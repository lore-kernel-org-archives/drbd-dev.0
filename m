Return-Path: <BATV+9495f3cb3d3d1d0fc876+6114+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F07D4203E8
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2020 21:55:57 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Wed, 20 May 2020 21:54:37 +0200
Message-Id: <20200520195509.2215098-2-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 01/33] dlm: use the tcp version of
	accept_from_sock for sctp as well
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

The only difference between a few missing fixes applied to the SCTP
one is that TCP uses ->getpeername to get the remote address, while
SCTP uses kernel_getsockopt(.. SCTP_PRIMARY_ADDR).  But given that
getpeername is defined to return the primary address for sctp, there
doesn't seem to be any reason for the different way of quering the
peername, or all the code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dlm/lowcomms.c | 123 ++--------------------------------------------
 1 file changed, 3 insertions(+), 120 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cdfaf4f0e11a0..f13dad0fd9ef3 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -724,7 +724,7 @@ static int receive_from_sock(struct connection *con)
 }
 
 /* Listening socket is busy, accept a connection */
-static int tcp_accept_from_sock(struct connection *con)
+static int accept_from_sock(struct connection *con)
 {
 	int result;
 	struct sockaddr_storage peeraddr;
@@ -852,123 +852,6 @@ static int tcp_accept_from_sock(struct connection *con)
 	return result;
 }
 
-static int sctp_accept_from_sock(struct connection *con)
-{
-	/* Check that the new node is in the lockspace */
-	struct sctp_prim prim;
-	int nodeid;
-	int prim_len, ret;
-	int addr_len;
-	struct connection *newcon;
-	struct connection *addcon;
-	struct socket *newsock;
-
-	mutex_lock(&connections_lock);
-	if (!dlm_allow_conn) {
-		mutex_unlock(&connections_lock);
-		return -1;
-	}
-	mutex_unlock(&connections_lock);
-
-	mutex_lock_nested(&con->sock_mutex, 0);
-
-	ret = kernel_accept(con->sock, &newsock, O_NONBLOCK);
-	if (ret < 0)
-		goto accept_err;
-
-	memset(&prim, 0, sizeof(struct sctp_prim));
-	prim_len = sizeof(struct sctp_prim);
-
-	ret = kernel_getsockopt(newsock, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
-				(char *)&prim, &prim_len);
-	if (ret < 0) {
-		log_print("getsockopt/sctp_primary_addr failed: %d", ret);
-		goto accept_err;
-	}
-
-	make_sockaddr(&prim.ssp_addr, 0, &addr_len);
-	ret = addr_to_nodeid(&prim.ssp_addr, &nodeid);
-	if (ret) {
-		unsigned char *b = (unsigned char *)&prim.ssp_addr;
-
-		log_print("reject connect from unknown addr");
-		print_hex_dump_bytes("ss: ", DUMP_PREFIX_NONE,
-				     b, sizeof(struct sockaddr_storage));
-		goto accept_err;
-	}
-
-	newcon = nodeid2con(nodeid, GFP_NOFS);
-	if (!newcon) {
-		ret = -ENOMEM;
-		goto accept_err;
-	}
-
-	mutex_lock_nested(&newcon->sock_mutex, 1);
-
-	if (newcon->sock) {
-		struct connection *othercon = newcon->othercon;
-
-		if (!othercon) {
-			othercon = kmem_cache_zalloc(con_cache, GFP_NOFS);
-			if (!othercon) {
-				log_print("failed to allocate incoming socket");
-				mutex_unlock(&newcon->sock_mutex);
-				ret = -ENOMEM;
-				goto accept_err;
-			}
-			othercon->nodeid = nodeid;
-			othercon->rx_action = receive_from_sock;
-			mutex_init(&othercon->sock_mutex);
-			INIT_LIST_HEAD(&othercon->writequeue);
-			spin_lock_init(&othercon->writequeue_lock);
-			INIT_WORK(&othercon->swork, process_send_sockets);
-			INIT_WORK(&othercon->rwork, process_recv_sockets);
-			set_bit(CF_IS_OTHERCON, &othercon->flags);
-		}
-		mutex_lock_nested(&othercon->sock_mutex, 2);
-		if (!othercon->sock) {
-			newcon->othercon = othercon;
-			add_sock(newsock, othercon);
-			addcon = othercon;
-			mutex_unlock(&othercon->sock_mutex);
-		} else {
-			printk("Extra connection from node %d attempted\n", nodeid);
-			ret = -EAGAIN;
-			mutex_unlock(&othercon->sock_mutex);
-			mutex_unlock(&newcon->sock_mutex);
-			goto accept_err;
-		}
-	} else {
-		newcon->rx_action = receive_from_sock;
-		add_sock(newsock, newcon);
-		addcon = newcon;
-	}
-
-	log_print("connected to %d", nodeid);
-
-	mutex_unlock(&newcon->sock_mutex);
-
-	/*
-	 * Add it to the active queue in case we got data
-	 * between processing the accept adding the socket
-	 * to the read_sockets list
-	 */
-	if (!test_and_set_bit(CF_READ_PENDING, &addcon->flags))
-		queue_work(recv_workqueue, &addcon->rwork);
-	mutex_unlock(&con->sock_mutex);
-
-	return 0;
-
-accept_err:
-	mutex_unlock(&con->sock_mutex);
-	if (newsock)
-		sock_release(newsock);
-	if (ret != -EAGAIN)
-		log_print("error accepting connection from node: %d", ret);
-
-	return ret;
-}
-
 static void free_entry(struct writequeue_entry *e)
 {
 	__free_page(e->page);
@@ -1253,7 +1136,7 @@ static struct socket *tcp_create_listen_sock(struct connection *con,
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_user_data = con;
 	save_listen_callbacks(sock);
-	con->rx_action = tcp_accept_from_sock;
+	con->rx_action = accept_from_sock;
 	con->connect_action = tcp_connect_to_sock;
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
@@ -1340,7 +1223,7 @@ static int sctp_listen_for_all(void)
 	save_listen_callbacks(sock);
 	con->sock = sock;
 	con->sock->sk->sk_data_ready = lowcomms_data_ready;
-	con->rx_action = sctp_accept_from_sock;
+	con->rx_action = accept_from_sock;
 	con->connect_action = sctp_connect_to_sock;
 
 	write_unlock_bh(&sock->sk->sk_callback_lock);
-- 
2.26.2

