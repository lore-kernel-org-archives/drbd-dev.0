Return-Path: <BATV+a231b325d53909937e6f+6122+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D9A6442038C
	for <drbd-dev@lists.linbit.com>; Thu, 28 May 2020 07:39:12 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 28 May 2020 07:12:36 +0200
Message-Id: <20200528051236.620353-29-hch@lst.de>
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
	Ying Xue <ying.xue@windriver.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 28/28] tipc: call tsk_set_importance from
	tipc_topsrv_create_listener
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

Avoid using kernel_setsockopt for the TIPC_IMPORTANCE option when we can
just use the internal helper.  The only change needed is to pass a struct
sock instead of tipc_sock, which is private to socket.c

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/tipc/socket.c | 18 +++++++++---------
 net/tipc/socket.h |  2 ++
 net/tipc/topsrv.c |  6 +++---
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d6b67d07d22ec..3734cdbedc9cc 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -196,17 +196,17 @@ static int tsk_importance(struct tipc_sock *tsk)
 	return msg_importance(&tsk->phdr);
 }
 
-static int tsk_set_importance(struct tipc_sock *tsk, int imp)
+static struct tipc_sock *tipc_sk(const struct sock *sk)
 {
-	if (imp > TIPC_CRITICAL_IMPORTANCE)
-		return -EINVAL;
-	msg_set_importance(&tsk->phdr, (u32)imp);
-	return 0;
+	return container_of(sk, struct tipc_sock, sk);
 }
 
-static struct tipc_sock *tipc_sk(const struct sock *sk)
+int tsk_set_importance(struct sock *sk, int imp)
 {
-	return container_of(sk, struct tipc_sock, sk);
+	if (imp > TIPC_CRITICAL_IMPORTANCE)
+		return -EINVAL;
+	msg_set_importance(&tipc_sk(sk)->phdr, (u32)imp);
+	return 0;
 }
 
 static bool tsk_conn_cong(struct tipc_sock *tsk)
@@ -2721,7 +2721,7 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock, int flags,
 	/* Connect new socket to it's peer */
 	tipc_sk_finish_conn(new_tsock, msg_origport(msg), msg_orignode(msg));
 
-	tsk_set_importance(new_tsock, msg_importance(msg));
+	tsk_set_importance(new_sk, msg_importance(msg));
 	if (msg_named(msg)) {
 		new_tsock->conn_type = msg_nametype(msg);
 		new_tsock->conn_instance = msg_nameinst(msg);
@@ -3139,7 +3139,7 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
 
 	switch (opt) {
 	case TIPC_IMPORTANCE:
-		res = tsk_set_importance(tsk, value);
+		res = tsk_set_importance(sk, value);
 		break;
 	case TIPC_SRC_DROPPABLE:
 		if (sock->type != SOCK_STREAM)
diff --git a/net/tipc/socket.h b/net/tipc/socket.h
index 235b9679acee4..b11575afc66fe 100644
--- a/net/tipc/socket.h
+++ b/net/tipc/socket.h
@@ -75,4 +75,6 @@ u32 tipc_sock_get_portid(struct sock *sk);
 bool tipc_sk_overlimit1(struct sock *sk, struct sk_buff *skb);
 bool tipc_sk_overlimit2(struct sock *sk, struct sk_buff *skb);
 
+int tsk_set_importance(struct sock *sk, int imp);
+
 #endif
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 446af7bbd13e6..1489cfb941d8e 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -497,7 +497,6 @@ static void tipc_topsrv_listener_data_ready(struct sock *sk)
 
 static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 {
-	int imp = TIPC_CRITICAL_IMPORTANCE;
 	struct socket *lsock = NULL;
 	struct sockaddr_tipc saddr;
 	struct sock *sk;
@@ -514,8 +513,9 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	sk->sk_user_data = srv;
 	write_unlock_bh(&sk->sk_callback_lock);
 
-	rc = kernel_setsockopt(lsock, SOL_TIPC, TIPC_IMPORTANCE,
-			       (char *)&imp, sizeof(imp));
+	lock_sock(sk);
+	rc = tsk_set_importance(sk, TIPC_CRITICAL_IMPORTANCE);
+	release_sock(sk);
 	if (rc < 0)
 		goto err;
 
-- 
2.26.2

