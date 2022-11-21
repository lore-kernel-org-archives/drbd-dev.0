Return-Path: <bcodding@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8188F420964
	for <drbd-dev@lists.linbit.com>; Mon, 21 Nov 2022 14:42:10 +0100 (CET)
From: Benjamin Coddington <bcodding@redhat.com>
To: netdev@vger.kernel.org
Date: Mon, 21 Nov 2022 08:35:18 -0500
Message-Id: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
In-Reply-To: <cover.1669036433.git.bcodding@redhat.com>
References: <cover.1669036433.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Latchesar Ionkov <lucho@ionkov.net>, samba-technical@lists.samba.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	linux-nvme@lists.infradead.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, linux-nfs@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>, linux-afs@lists.infradead.org,
	cluster-devel@redhat.com, Christine Caulfield <ccaulfie@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Anna Schumaker <anna@kernel.org>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-block@vger.kernel.org, David Teigland <teigland@redhat.com>,
	Joel Becker <jlbec@evilplan.org>, v9fs-developer@lists.sourceforge.net,
	Keith Busch <kbusch@kernel.org>, ceph-devel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
	open-iscsi@googlegroups.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Chuck Lever <chuck.lever@oracle.com>, Lee Duncan <lduncan@suse.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Subject: [Drbd-dev] [PATCH v1 2/3] Treewide: Stop corrupting socket's
	task_frag
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

Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
GFP_NOIO flag on sk_allocation which the networking system uses to decide
when it is safe to use current->task_frag.  The results of this are
unexpected corruption in task_frag when SUNRPC is involved in memory
reclaim.

The corruption can be seen in crashes, but the root cause is often
difficult to ascertain as a crashing machine's stack trace will have no
evidence of being near NFS or SUNRPC code.  I believe this problem to
be much more pervasive than reports to the community may indicate.

Fix this by having kernel users of sockets that may corrupt task_frag due
to reclaim set sk_use_task_frag = false.  Preemptively correcting this
situation for users that still set sk_allocation allows them to convert to
memalloc_nofs_save/restore without the same unexpected corruptions that are
sure to follow, unlikely to show up in testing, and difficult to bisect.

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Josef Bacik <josef@toxicpanda.com>
CC: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>
CC: Lee Duncan <lduncan@suse.com>
CC: Chris Leech <cleech@redhat.com>
CC: Mike Christie <michael.christie@oracle.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Valentina Manea <valentina.manea.m@gmail.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: David Howells <dhowells@redhat.com>
CC: Marc Dionne <marc.dionne@auristor.com>
CC: Steve French <sfrench@samba.org>
CC: Christine Caulfield <ccaulfie@redhat.com>
CC: David Teigland <teigland@redhat.com>
CC: Mark Fasheh <mark@fasheh.com>
CC: Joel Becker <jlbec@evilplan.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Eric Van Hensbergen <ericvh@gmail.com>
CC: Latchesar Ionkov <lucho@ionkov.net>
CC: Dominique Martinet <asmadeus@codewreck.org>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Ilya Dryomov <idryomov@gmail.com>
CC: Xiubo Li <xiubli@redhat.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: drbd-dev@lists.linbit.com
CC: linux-block@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: nbd@other.debian.org
CC: linux-nvme@lists.infradead.org
CC: open-iscsi@googlegroups.com
CC: linux-scsi@vger.kernel.org
CC: linux-usb@vger.kernel.org
CC: linux-afs@lists.infradead.org
CC: linux-cifs@vger.kernel.org
CC: samba-technical@lists.samba.org
CC: cluster-devel@redhat.com
CC: ocfs2-devel@oss.oracle.com
CC: v9fs-developer@lists.sourceforge.net
CC: netdev@vger.kernel.org
CC: ceph-devel@vger.kernel.org
CC: linux-nfs@vger.kernel.org

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 +++
 drivers/block/nbd.c                | 1 +
 drivers/nvme/host/tcp.c            | 1 +
 drivers/scsi/iscsi_tcp.c           | 1 +
 drivers/usb/usbip/usbip_common.c   | 1 +
 fs/afs/rxrpc.c                     | 1 +
 fs/cifs/connect.c                  | 1 +
 fs/dlm/lowcomms.c                  | 2 ++
 fs/ocfs2/cluster/tcp.c             | 1 +
 net/9p/trans_fd.c                  | 1 +
 net/ceph/messenger.c               | 1 +
 net/sunrpc/xprtsock.c              | 3 +++
 12 files changed, 17 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index af4c7d65490b..09ad8d82c200 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1030,6 +1030,9 @@ static int conn_connect(struct drbd_connection *connection)
 	sock.socket->sk->sk_allocation = GFP_NOIO;
 	msock.socket->sk->sk_allocation = GFP_NOIO;
 
+	sock.socket->sk->sk_use_task_frag = false;
+	msock.socket->sk->sk_use_task_frag = false;
+
 	sock.socket->sk->sk_priority = TC_PRIO_INTERACTIVE_BULK;
 	msock.socket->sk->sk_priority = TC_PRIO_INTERACTIVE;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a709daefbc4..815ee631ed30 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -514,6 +514,7 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 	noreclaim_flag = memalloc_noreclaim_save();
 	do {
 		sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
+		sock->sk->sk_use_task_frag = false;
 		msg.msg_name = NULL;
 		msg.msg_namelen = 0;
 		msg.msg_control = NULL;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d5871fd6f769..e01d78858cb4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1531,6 +1531,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
+	queue->sock->sk->sk_use_task_frag = false;
 	nvme_tcp_set_queue_io_cpu(queue);
 	queue->request = NULL;
 	queue->data_remaining = 0;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 29b1bd755afe..733e540d0abf 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -733,6 +733,7 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 	sk->sk_reuse = SK_CAN_REUSE;
 	sk->sk_sndtimeo = 15 * HZ; /* FIXME: make it configurable */
 	sk->sk_allocation = GFP_ATOMIC;
+	sk->sk_use_task_frag = false;
 	sk_set_memalloc(sk);
 	sock_no_linger(sk);
 
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 2ab99244bc31..76bfc6e43881 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -315,6 +315,7 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
+		sock->sk->sk_use_task_frag = false;
 
 		result = sock_recvmsg(sock, &msg, MSG_WAITALL);
 		if (result <= 0)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index eccc3cd0cb70..ac75ad18db83 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -46,6 +46,7 @@ int afs_open_socket(struct afs_net *net)
 		goto error_1;
 
 	socket->sk->sk_allocation = GFP_NOFS;
+	socket->sk->sk_use_task_frag = false;
 
 	/* bind the callback manager's address to make this a server socket */
 	memset(&srx, 0, sizeof(srx));
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 7ae6f2c08153..c2b0d6f59f79 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2935,6 +2935,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		cifs_dbg(FYI, "Socket created\n");
 		server->ssocket = socket;
 		socket->sk->sk_allocation = GFP_NOFS;
+		socket->sk->sk_use_task_frag = false;
 		if (sfamily == AF_INET6)
 			cifs_reclassify_socket6(socket);
 		else
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index a4e84e8d94c8..4cf29ac3c428 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -699,6 +699,7 @@ static void add_listen_sock(struct socket *sock, struct listen_connection *con)
 
 	sk->sk_user_data = con;
 	sk->sk_allocation = GFP_NOFS;
+	sk->sk_use_task_frag = false;
 	/* Install a data_ready callback */
 	sk->sk_data_ready = lowcomms_listen_data_ready;
 	release_sock(sk);
@@ -718,6 +719,7 @@ static void add_sock(struct socket *sock, struct connection *con)
 	sk->sk_write_space = lowcomms_write_space;
 	sk->sk_state_change = lowcomms_state_change;
 	sk->sk_allocation = GFP_NOFS;
+	sk->sk_use_task_frag = false;
 	sk->sk_error_report = lowcomms_error_report;
 	release_sock(sk);
 }
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63..3eaafa5e5ec4 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1604,6 +1604,7 @@ static void o2net_start_connect(struct work_struct *work)
 	sc->sc_sock = sock; /* freed by sc_kref_release */
 
 	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_use_task_frag = false;
 
 	myaddr.sin_family = AF_INET;
 	myaddr.sin_addr.s_addr = mynode->nd_ipv4_address;
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e758978b44be..96f803499323 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -851,6 +851,7 @@ static int p9_socket_open(struct p9_client *client, struct socket *csocket)
 		return -ENOMEM;
 
 	csocket->sk->sk_allocation = GFP_NOIO;
+	csocket->sk->sk_use_task_frag = false;
 	file = sock_alloc_file(csocket, 0, NULL);
 	if (IS_ERR(file)) {
 		pr_err("%s (%d): failed to map fd\n",
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d3bb656308b4..cad8e0ca8432 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -446,6 +446,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	if (ret)
 		return ret;
 	sock->sk->sk_allocation = GFP_NOFS;
+	sock->sk->sk_use_task_frag = false;
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_set_class(&sock->sk->sk_lock, &socket_class);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e976007f4fd0..d3170b753dfc 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1882,6 +1882,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		sk->sk_write_space = xs_udp_write_space;
 		sk->sk_state_change = xs_local_state_change;
 		sk->sk_error_report = xs_error_report;
+		sk->sk_use_task_frag = false;
 
 		xprt_clear_connected(xprt);
 
@@ -2083,6 +2084,7 @@ static void xs_udp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
+		sk->sk_use_task_frag = false;
 
 		xprt_set_connected(xprt);
 
@@ -2250,6 +2252,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_state_change = xs_tcp_state_change;
 		sk->sk_write_space = xs_tcp_write_space;
 		sk->sk_error_report = xs_error_report;
+		sk->sk_use_task_frag = false;
 
 		/* socket options */
 		sock_reset_flag(sk, SOCK_LINGER);
-- 
2.31.1

