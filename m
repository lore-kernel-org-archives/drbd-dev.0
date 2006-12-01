Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 92C672D9E1E5
	for <drbd-dev@lists.linbit.com>; Fri,  1 Dec 2006 10:43:34 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across reboot.
Date: Fri, 1 Dec 2006 10:43:36 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C84F@EXNA.corp.stratus.com>
	<20061130195953.GC7746@soda.linbit>
In-Reply-To: <20061130195953.GC7746@soda.linbit>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Il/bFJbvcgkG/su"
Message-Id: <200612011043.36208.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_Il/bFJbvcgkG/su
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[...]

Lars, that's right, this is the reason for the race condition. 
I think this patch fixes this. With this patch it should no longer
be possible to get both nodes into the WFBitMaps state.

It is in SVN with revision 2607.

Ernest, could you repeat your tests with this revision? Thanks!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_Il/bFJbvcgkG/su
Content-Type: text/x-diff; charset="iso-8859-1";
	name="both_in_WFBitMaps_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="both_in_WFBitMaps_fix.diff"

Index: drbd_receiver.c
===================================================================
--- drbd_receiver.c	(revision 2603)
+++ drbd_receiver.c	(working copy)
@@ -1668,7 +1668,7 @@
 	peer = mdev->p_uuid[Bitmap] & 1;
 
 	ch_peer = mdev->p_uuid[UUID_SIZE];
-	ch_self = drbd_bm_total_weight(mdev);
+	ch_self = mdev->comm_bm_set;
 
 	switch ( mdev->net_conf->after_sb_0p ) {
 	case Consensus:
Index: drbd_main.c
===================================================================
--- drbd_main.c	(revision 2603)
+++ drbd_main.c	(working copy)
@@ -1288,7 +1288,8 @@
 			: 0;
 	}
 
-	p.uuid[UUID_SIZE] = cpu_to_be64(drbd_bm_total_weight(mdev));
+	mdev->comm_bm_set = drbd_bm_total_weight(mdev);
+	p.uuid[UUID_SIZE] = cpu_to_be64(mdev->comm_bm_set);
 	uuid_flags |= mdev->net_conf->want_lose ? 1 : 0;
 	uuid_flags |= test_bit(CRASHED_PRIMARY, &mdev->flags) ? 2 : 0;
 	p.uuid[UUID_FLAGS] = cpu_to_be64(uuid_flags);
Index: drbd_int.h
===================================================================
--- drbd_int.h	(revision 2603)
+++ drbd_int.h	(working copy)
@@ -853,6 +853,7 @@
 	unsigned int peer_seq;
 	spinlock_t peer_seq_lock;
 	int minor;
+	unsigned long comm_bm_set; // communicated number of set bits.
 };
 
 static inline drbd_dev *minor_to_mdev(int minor)

--Boundary-00=_Il/bFJbvcgkG/su--
