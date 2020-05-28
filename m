Return-Path: <BATV+a231b325d53909937e6f+6122+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 717674203B3
	for <drbd-dev@lists.linbit.com>; Thu, 28 May 2020 07:39:13 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 28 May 2020 07:12:32 +0200
Message-Id: <20200528051236.620353-25-hch@lst.de>
In-Reply-To: <20200528051236.620353-1-hch@lst.de>
References: <20200528051236.620353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	cluster-devel@redhat.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Jon Maloy <jmaloy@redhat.com>,
	linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 24/28] ipv6: add ip6_sock_set_recverr
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

Add a helper to directly set the IPV6_RECVERR sockopt from kernel space
without going through a fake uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/net/ipv6.h       |  7 +++++++
 net/rxrpc/local_object.c | 10 ++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 9b91188c9a74c..49c4abf991489 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1188,4 +1188,11 @@ static inline int ip6_sock_set_v6only(struct sock *sk)
 	return 0;
 }
 
+static inline void ip6_sock_set_recverr(struct sock *sk)
+{
+	lock_sock(sk);
+	inet6_sk(sk)->recverr = true;
+	release_sock(sk);
+}
+
 #endif /* _NET_IPV6_H */
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 6f4e6b4817cf2..c8b2097f499c0 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -107,7 +107,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct rxrpc_net *rxnet,
 static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 {
 	struct sock *usk;
-	int ret, opt;
+	int ret;
 
 	_enter("%p{%d,%d}",
 	       local, local->srx.transport_type, local->srx.transport.family);
@@ -157,13 +157,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	switch (local->srx.transport.family) {
 	case AF_INET6:
 		/* we want to receive ICMPv6 errors */
-		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_RECVERR,
-					(char *) &opt, sizeof(opt));
-		if (ret < 0) {
-			_debug("setsockopt failed");
-			goto error;
-		}
+		ip6_sock_set_recverr(local->socket->sk);
 
 		/* Fall through and set IPv4 options too otherwise we don't get
 		 * errors from IPv4 packets sent through the IPv6 socket.
-- 
2.26.2

