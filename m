Return-Path: <Eduard.Guzovsky@stratus.com>
Received: from mailhub4.stratus.com (mailhub4.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 76229105ABD9
	for <drbd-dev@lists.linbit.com>; Thu, 29 Apr 2010 22:01:00 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Apr 2010 16:00:50 -0400
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com>
From: "Guzovsky, Eduard" <Eduard.Guzovsky@stratus.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] DRBD small synchronous writes performance improvements
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi guys,

We analyzed DRBD performance of small synchronous write operations on
systems with RAID controllers.  This i/o pattern happens frequently in
data base transaction processing workloads. Large RAID caches ensure
that disk i/o overhead is small - about 100us per 32KB block - and
network overhead turns into a dominant factor.  In addition to network
stack processing time, network overhead has two large components

1. "Wire time" - the actual time it takes to transmit data. On 1Gig
network it takes about 270us to transmit 32KB block, on 10Gig - about
27us.

2. "NIC latency" - the time it takes NIC to start transmitting a packet
on the sending node plus the time on the receiving node between the
packet reception by the NIC and delivering the packet to the driver. NIC
latency is chip specific and depends on "packet/interrupt coalescing"
setting configurable via "ethtool -C ". The default setting results in
about a 100us to 125us "short packet round trip" latency.  We reduced it
to about 50us by effectively disabling packet coalescing.  Have you or
your customers experimented with this? We are obviously concerned with
adverse side effects of disabling packet coalescing on whole system
performance during high network loads.

We found in our testing that certain DRBD changes - see the patch bellow
- improve performance of small synchronous writes.  For the reference,
the testing was done in Xen environment on Dell T610 system with Xeon
E5520 2.27 GHz CPU, and Dell PERC 6/I RAID controller.  DRBD code was
running in the 2 way SMP Dom0.
The patch is made against DRBD version 8.2.7, but it is equally relevant
to 8.3.7 as corresponding parts of the code did not change
significantly. This patch is a "rough draft request for comment". It
contains several changes.

1. TCP_QUICKACK option is set incorrectly. The goal was force TCP to
send and ACK as a  "one time" event.  Instead the code permanently sets
connection in the QUICKACK mode.

2. Socket sndbufsize/rcvbufsize setting is done incorrectly. The code
sets socket buffer sizes _after_ connection is established.  In order
for these settings to take effect they should be set _before_ connection
is established.  We made a quick and dirty change that makes identical
setting for both meta and data connections.  It would require a bigger
change to have separate settings because in the current code it is not
known in advance which socket will be used for which connection.

3. We noticed that on the primary node it takes about 20us to schedule
DRBD worker thread that packages and sends write request to the
secondary node. We think it would be better to send request to the
secondary ASAP and only then continue with primary node processing. So I
added "schedule()"  hack to drbd_make_request_common() and raised the
priority of the worker thread. That reduced worker thread scheduling
delay to about 7us. I am not 100% if this hack is safe - would be very
interested in your opinion on it.

4. We disabled TCP_CORK through drbdsetup utility and modified the code
to do implicit corking using MSG_MORE flag. TCP code tries to postpone
sending partial message until the whole message is assembled. So we try
to send drbd request header first to let the secondary node start
preparations to receive the data part while the primary node is still
transmitting the data. May be this behavior  should be a configurable
variant of tcp corking, because it might not be advantageous for every
NIC/link speed configuration.

We were also considering implementation of "zero copy" receive that
should improve performance for 10Gig links - that is not part of the
patch. The basic idea is to intercept incoming data before they get
queued to the socket in the same way NFS and i-scsi  code do it through
tcp_read_sock() api. Then drbd could convert sk_buff chain to bio, if
alignment is right, and avoid expensive data copy. Do you plan to add
something like this into you future DRBD release so we do not have to do
it ourselves? ;-)

We would appreciate your comments on the patch.

Thanks,

-Ed

-----------------------------


diff -aur src.orig/drbd/drbd_int.h src/drbd/drbd_int.h
--- src.orig/drbd/drbd_int.h	2010-04-01 15:47:54.000000000 -0400
+++ src/drbd/drbd_int.h	2010-04-26 18:09:14.000000000 -0400
@@ -1124,7 +1124,7 @@
 extern int drbd_send_ack_ex(struct drbd_conf *mdev, enum
Drbd_Packet_Cmd cmd,
 			    sector_t sector, int blksize, u64 block_id);
 extern int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
-			int offset, size_t size);
+			int offset, size_t size, int flags);
 extern int drbd_send_block(struct drbd_conf *mdev, enum Drbd_Packet_Cmd
cmd,
 			   struct Tl_epoch_entry *e);
 extern int drbd_send_dblock(struct drbd_conf *mdev, struct drbd_request
*req);
@@ -1596,7 +1596,7 @@
=20
 static inline void drbd_tcp_quickack(struct socket *sock)
 {
-	int __user val =3D 1;
+	int __user val =3D 2;
 	(void) drbd_setsockopt(sock, SOL_TCP, TCP_QUICKACK,
 			(char __user *)&val, sizeof(val));
 }
diff -aur src.orig/drbd/drbd_main.c src/drbd/drbd_main.c
--- src.orig/drbd/drbd_main.c	2010-04-01 15:47:54.000000000 -0400
+++ src/drbd/drbd_main.c	2010-04-28 15:25:48.000000000 -0400
@@ -2084,7 +2084,7 @@
 }
=20
 int _drbd_send_page(struct drbd_conf *mdev, struct page *page,
-		    int offset, size_t size)
+		    int offset, size_t size, int flags)
 {
 	mm_segment_t oldfs =3D get_fs();
 	int sent, ok;
@@ -2130,7 +2130,7 @@
 	do {
 		sent =3D
mdev->data.socket->ops->sendpage(mdev->data.socket, page,
 							offset, len,
-							MSG_NOSIGNAL);
+							flags |
MSG_NOSIGNAL);
 		if (sent =3D=3D -EAGAIN) {
 			if (we_should_drop_the_connection(mdev,
=20
mdev->data.socket))
@@ -2168,13 +2168,20 @@
 	return 1;
 }
=20
-static inline int _drbd_send_zc_bio(struct drbd_conf *mdev, struct bio
*bio)
+static inline int _drbd_send_zc_bio(struct drbd_conf *mdev, struct bio
*bio,
+                                    int flags)
 {
 	struct bio_vec *bvec;
 	int i;
+        unsigned int len =3D 0;
+
 	__bio_for_each_segment(bvec, bio, i, 0) {
+
+                if ((len +=3D bvec->bv_len) =3D=3D bio->bi_size)
+                        flags =3D 0;
+
 		if (!_drbd_send_page(mdev, bvec->bv_page,
-				     bvec->bv_offset, bvec->bv_len))
+				     bvec->bv_offset, bvec->bv_len,
flags))
 			return 0;
 	}
=20
@@ -2224,7 +2231,7 @@
 	dump_packet(mdev, mdev->data.socket, 0, (void *)&p, __FILE__,
__LINE__);
 	blk_add_trace_bio(mdev->rq_queue, req->master_bio,
BLK_TA_GETRQ);
 	ok =3D (sizeof(p) =3D=3D
-		drbd_send(mdev, mdev->data.socket, &p, sizeof(p),
MSG_MORE));
+                drbd_send(mdev, mdev->data.socket, &p, sizeof(p), 0));
 	if (ok && dgs) {
 		dgb =3D mdev->int_dig_out;
 		drbd_csum(mdev, mdev->integrity_w_tfm, req->master_bio,
dgb);
@@ -2234,7 +2241,7 @@
 		if (mdev->net_conf->wire_protocol =3D=3D DRBD_PROT_A)
 			ok =3D _drbd_send_bio(mdev, req->master_bio);
 		else
-			ok =3D _drbd_send_zc_bio(mdev, req->master_bio);
+			ok =3D _drbd_send_zc_bio(mdev, req->master_bio,
MSG_MORE);
 	}
=20
 	drbd_put_data_sock(mdev);
@@ -2281,7 +2288,7 @@
 		ok =3D drbd_send(mdev, mdev->data.socket, dgb, dgs,
MSG_MORE);
 	}
 	if (ok)
-		ok =3D _drbd_send_zc_bio(mdev, e->private_bio);
+		ok =3D _drbd_send_zc_bio(mdev, e->private_bio, 0);
=20
 	drbd_put_data_sock(mdev);
 	return ok;
Only in src/drbd: drbd_main.c~
diff -aur src.orig/drbd/drbd_receiver.c src/drbd/drbd_receiver.c
--- src.orig/drbd/drbd_receiver.c	2010-04-01 15:47:54.000000000
-0400
+++ src/drbd/drbd_receiver.c	2010-04-28 15:27:17.000000000 -0400
@@ -620,6 +620,15 @@
 	sock->sk->sk_rcvtimeo =3D
 	sock->sk->sk_sndtimeo =3D  mdev->net_conf->try_connect_int*HZ;
=20
+	if (mdev->net_conf->sndbuf_size) {
+		/* FIXME fold to limits. should be done during
configuration */
+		/* this is setsockopt SO_SNDBUFFORCE and SO_RCVBUFFORCE,
+		 * done directly. */
+		sock->sk->sk_sndbuf =3D mdev->net_conf->sndbuf_size;
+		sock->sk->sk_rcvbuf =3D mdev->net_conf->sndbuf_size;
+		sock->sk->sk_userlocks |=3D SOCK_SNDBUF_LOCK |
SOCK_RCVBUF_LOCK;
+	}
+
        /* explicitly bind to the configured IP as source IP
 	*  for the outgoing connections.
 	*  This is needed for multihomed hosts and to be
@@ -699,6 +708,16 @@
 	s_listen->sk->sk_rcvtimeo =3D
 	s_listen->sk->sk_sndtimeo =3D  mdev->net_conf->try_connect_int*HZ;
=20
+	if (mdev->net_conf->sndbuf_size) {
+		/* FIXME fold to limits. should be done during
configuration */
+		/* this is setsockopt SO_SNDBUFFORCE and SO_RCVBUFFORCE,
+		 * done directly. */
+		s_listen->sk->sk_sndbuf =3D mdev->net_conf->sndbuf_size;
+		s_listen->sk->sk_rcvbuf =3D mdev->net_conf->sndbuf_size;
+		s_listen->sk->sk_userlocks |=3D=20
+                    SOCK_SNDBUF_LOCK | SOCK_RCVBUF_LOCK;
+	}
+
 	what =3D "bind before listen";
 	err =3D s_listen->ops->bind(s_listen,
 			      (struct sockaddr *)
mdev->net_conf->my_addr,
@@ -885,6 +904,7 @@
 	sock->sk->sk_priority =3D TC_PRIO_INTERACTIVE_BULK;
 	msock->sk->sk_priority =3D TC_PRIO_INTERACTIVE;
=20
+#if 0=20
 	if (mdev->net_conf->sndbuf_size) {
 		/* FIXME fold to limits. should be done during
configuration */
 		/* this is setsockopt SO_SNDBUFFORCE and SO_RCVBUFFORCE,
@@ -893,6 +913,7 @@
 		sock->sk->sk_rcvbuf =3D mdev->net_conf->sndbuf_size;
 		sock->sk->sk_userlocks |=3D SOCK_SNDBUF_LOCK |
SOCK_RCVBUF_LOCK;
 	}
+#endif=20
=20
 #if 0 /* don't pin the msock bufsize, autotuning should work better */
 	msock->sk->sk_sndbuf =3D 2*32767;
diff -aur src.orig/drbd/drbd_req.c src/drbd/drbd_req.c
--- src.orig/drbd/drbd_req.c	2010-04-01 15:47:54.000000000 -0400
+++ src/drbd/drbd_req.c	2010-04-28 15:28:27.000000000 -0400
@@ -1110,6 +1110,13 @@
 			_req_mod(req, queue_for_net_read, 0);
 	}
 	spin_unlock_irq(&mdev->req_lock);
+
+     /* give a worker thread a chance to pick up the request */
+	if (remote) {
+            if (!in_atomic())
+                    schedule();
+     }
+
 	kfree(b); /* if someone else has beaten us to it... */
=20
 	if (local) {
diff -aur src.orig/drbd/drbd_worker.c src/drbd/drbd_worker.c
--- src.orig/drbd/drbd_worker.c	2010-04-01 15:47:54.000000000 -0400
+++ src/drbd/drbd_worker.c	2010-04-26 18:25:17.000000000 -0400
@@ -1237,6 +1237,9 @@
=20
 	sprintf(current->comm, "drbd%d_worker", mdev_to_minor(mdev));
=20
+	current->policy =3D SCHED_RR;  /* Make this a realtime task! */
+	current->rt_priority =3D 2;    /* more important than all other
tasks */
+
 	while (get_t_state(thi) =3D=3D Running) {
 		drbd_thread_current_set_cpu(mdev);
