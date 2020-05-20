Return-Path: <BATV+9495f3cb3d3d1d0fc876+6114+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A74144203E3
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2020 21:55:56 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Wed, 20 May 2020 21:54:38 +0200
Message-Id: <20200520195509.2215098-3-hch@lst.de>
In-Reply-To: <20200520195509.2215098-1-hch@lst.de>
References: <20200520195509.2215098-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, ocfs2-devel@oss.oracle.com
Subject: [Drbd-dev] [PATCH 02/33] net: remove kernel_getsockopt
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

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/net.h |  2 --
 net/socket.c        | 34 ----------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 6451425e828f5..74ef5d7315f70 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -303,8 +303,6 @@ int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags);
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
-int kernel_getsockopt(struct socket *sock, int level, int optname, char *optval,
-		      int *optlen);
 int kernel_setsockopt(struct socket *sock, int level, int optname, char *optval,
 		      unsigned int optlen);
 int kernel_sendpage(struct socket *sock, struct page *page, int offset,
diff --git a/net/socket.c b/net/socket.c
index 80422fc3c836e..81a98b6cbd087 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3624,40 +3624,6 @@ int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
 }
 EXPORT_SYMBOL(kernel_getpeername);
 
-/**
- *	kernel_getsockopt - get a socket option (kernel space)
- *	@sock: socket
- *	@level: API level (SOL_SOCKET, ...)
- *	@optname: option tag
- *	@optval: option value
- *	@optlen: option length
- *
- *	Assigns the option length to @optlen.
- *	Returns 0 or an error.
- */
-
-int kernel_getsockopt(struct socket *sock, int level, int optname,
-			char *optval, int *optlen)
-{
-	mm_segment_t oldfs = get_fs();
-	char __user *uoptval;
-	int __user *uoptlen;
-	int err;
-
-	uoptval = (char __user __force *) optval;
-	uoptlen = (int __user __force *) optlen;
-
-	set_fs(KERNEL_DS);
-	if (level == SOL_SOCKET)
-		err = sock_getsockopt(sock, level, optname, uoptval, uoptlen);
-	else
-		err = sock->ops->getsockopt(sock, level, optname, uoptval,
-					    uoptlen);
-	set_fs(oldfs);
-	return err;
-}
-EXPORT_SYMBOL(kernel_getsockopt);
-
 /**
  *	kernel_setsockopt - set a socket option (kernel space)
  *	@sock: socket
-- 
2.26.2

