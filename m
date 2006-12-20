Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2006 12:46:18 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C897@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 - trunk/drbd -
	The fix forthe "both nodes in WFBitMaps" issue, Ernest
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Phil,
I am still seeing this issue that I reported a while back and for which
you submitted a fix (see original message below).  But essentially after
the drbd heartbeat link is disconnected and Split brain occurred, both
nodes thinks they should be the sync source.  They send their peers(each
other) to the following states:
peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk(
DUnknown -> UpToDate ) At the same time..
This state persists across a reboot and the drbd_receiver thread loops
on both nodes with:

[root@morticia ~]# tail -f /var/log/messages
Dec 19 14:12:00 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965943
Dec 19 14:12:06 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965942
Dec 19 14:12:12 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965941
Dec 19 14:12:18 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965940



-----Original Message-----
From: drbd-cvs-bounces@linbit.com [mailto:drbd-cvs-bounces@linbit.com]
On Behalf Of drbd-cvs@linbit.com
Sent: Friday, December 01, 2006 4:42 AM
To: drbd-cvs@linbit.com
Subject: [DRBD-cvs] svn commit by phil - r2607 - trunk/drbd - The fix
forthe "both nodes in WFBitMaps" issue, Ernest

Author: phil
Date: 2006-12-01 10:41:58 +0100 (Fri, 01 Dec 2006)
New Revision: 2607

Modified:
   trunk/drbd/drbd_int.h
   trunk/drbd/drbd_main.c
   trunk/drbd/drbd_receiver.c
Log:
The fix for the "both nodes in WFBitMaps" issue, Ernest reported.



Modified: trunk/drbd/drbd_int.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- trunk/drbd/drbd_int.h	2006-11-30 15:00:22 UTC (rev 2606)
+++ trunk/drbd/drbd_int.h	2006-12-01 09:41:58 UTC (rev 2607)
@@ -853,6 +853,7 @@
 	unsigned int peer_seq;
 	spinlock_t peer_seq_lock;
 	int minor;
+	unsigned long comm_bm_set; // communicated number of set bits.
 };
=20
 static inline drbd_dev *minor_to_mdev(int minor)

Modified: trunk/drbd/drbd_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- trunk/drbd/drbd_main.c	2006-11-30 15:00:22 UTC (rev 2606)
+++ trunk/drbd/drbd_main.c	2006-12-01 09:41:58 UTC (rev 2607)
@@ -1288,7 +1288,8 @@
 			: 0;
 	}
=20
-	p.uuid[UUID_SIZE] =3D cpu_to_be64(drbd_bm_total_weight(mdev));
+	mdev->comm_bm_set =3D drbd_bm_total_weight(mdev);
+	p.uuid[UUID_SIZE] =3D cpu_to_be64(mdev->comm_bm_set);
 	uuid_flags |=3D mdev->net_conf->want_lose ? 1 : 0;
 	uuid_flags |=3D test_bit(CRASHED_PRIMARY, &mdev->flags) ? 2 : 0;
 	p.uuid[UUID_FLAGS] =3D cpu_to_be64(uuid_flags);

Modified: trunk/drbd/drbd_receiver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- trunk/drbd/drbd_receiver.c	2006-11-30 15:00:22 UTC (rev 2606)
+++ trunk/drbd/drbd_receiver.c	2006-12-01 09:41:58 UTC (rev 2607)
@@ -1668,7 +1668,7 @@
 	peer =3D mdev->p_uuid[Bitmap] & 1;
=20
 	ch_peer =3D mdev->p_uuid[UUID_SIZE];
-	ch_self =3D drbd_bm_total_weight(mdev);
+	ch_self =3D mdev->comm_bm_set;
=20
 	switch ( mdev->net_conf->after_sb_0p ) {
 	case Consensus:

_______________________________________________
drbd-cvs mailing list
drbd-cvs@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-cvs
