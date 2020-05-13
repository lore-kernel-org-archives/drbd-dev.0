Return-Path: <BATV+0881196e8d815fc0828c+6107+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 36725420407
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 08:30:05 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Wed, 13 May 2020 08:26:21 +0200
Message-Id: <20200513062649.2100053-7-hch@lst.de>
In-Reply-To: <20200513062649.2100053-1-hch@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, ocfs2-devel@oss.oracle.com
Subject: [Drbd-dev] [PATCH 06/33] net: add sock_set_timestamps
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Add a helper to directly set the SO_TIMESTAMP* sockopts from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sock.h       |  1 +
 net/core/sock.c          | 47 +++++++++++++++++++++++++---------------
 net/rxrpc/local_object.c |  8 +------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b63ea15362065..cf8a30e0168de 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2692,5 +2692,6 @@ void sock_set_linger(struct sock *sk, bool onoff, unsigned int linger);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_sndtimeo(struct sock *sk, unsigned int secs);
 int sock_bindtoindex(struct sock *sk, int ifindex);
+void sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns);
 
 #endif	/* _SOCK_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 4b7439308caec..1589f242ecc7e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -772,6 +772,28 @@ void sock_set_sndtimeo(struct sock *sk, unsigned int secs)
 }
 EXPORT_SYMBOL(sock_set_sndtimeo);
 
+static void __sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns)
+{
+	if (val)  {
+		sock_valbool_flag(sk, SOCK_TSTAMP_NEW, new);
+		sock_valbool_flag(sk, SOCK_RCVTSTAMPNS, ns);
+		sock_set_flag(sk, SOCK_RCVTSTAMP);
+		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	} else {
+		sock_reset_flag(sk, SOCK_RCVTSTAMP);
+		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+		sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+	}
+}
+
+void sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns)
+{
+	lock_sock(sk);
+	__sock_set_timestamps(sk, val, new, ns);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_set_timestamps);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -953,28 +975,17 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
+		__sock_set_timestamps(sk, valbool, false, false);
+		break;
 	case SO_TIMESTAMP_NEW:
+		__sock_set_timestamps(sk, valbool, true, false);
+		break;
 	case SO_TIMESTAMPNS_OLD:
+		__sock_set_timestamps(sk, valbool, false, true);
+		break;
 	case SO_TIMESTAMPNS_NEW:
-		if (valbool)  {
-			if (optname == SO_TIMESTAMP_NEW || optname == SO_TIMESTAMPNS_NEW)
-				sock_set_flag(sk, SOCK_TSTAMP_NEW);
-			else
-				sock_reset_flag(sk, SOCK_TSTAMP_NEW);
-
-			if (optname == SO_TIMESTAMP_OLD || optname == SO_TIMESTAMP_NEW)
-				sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-			else
-				sock_set_flag(sk, SOCK_RCVTSTAMPNS);
-			sock_set_flag(sk, SOCK_RCVTSTAMP);
-			sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-		} else {
-			sock_reset_flag(sk, SOCK_RCVTSTAMP);
-			sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-			sock_reset_flag(sk, SOCK_TSTAMP_NEW);
-		}
+		__sock_set_timestamps(sk, valbool, true, true);
 		break;
-
 	case SO_TIMESTAMPING_NEW:
 		sock_set_flag(sk, SOCK_TSTAMP_NEW);
 		/* fall through */
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 01135e54d95d2..562ea36c96b0f 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -189,13 +189,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		}
 
 		/* We want receive timestamps. */
-		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-					(char *)&opt, sizeof(opt));
-		if (ret < 0) {
-			_debug("setsockopt failed");
-			goto error;
-		}
+		sock_set_timestamps(local->socket->sk, true, false, true);
 		break;
 
 	default:
-- 
2.26.2

