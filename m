Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 16B552CE82C8
	for <drbd-dev@lists.linbit.com>; Wed, 16 Aug 2006 10:44:23 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
Date: Wed, 16 Aug 2006 10:44:31 +0200
References: <342BAC0A5467384983B586A6B0B37671036252EC@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671036252EC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vrt4EfQsBv+tPRo"
Message-Id: <200608161044.31669.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_vrt4EfQsBv+tPRo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 15. August 2006 21:46 schrieb Graham, Simon:
> Have now traced the network and I am very confused -- I'm still
> convinced that the problem is that we are still in drbd_send_zc_bio when
> the Ack for the write is received BUT the data is correctly and
> completely sent on the wire to the peer who turns around and sends a
> WriteAck to it.
>
> I suppose it's theoretically possible that sending the final portion of
> the data from drbd_send_zc_bio might end up being pended; maybe the pipe
> is full when we go to send it which causes the worker thread to get
> suspended. That being the case, it's possible that this thread doesn't
> get rescheduled until waaaaay later - specifically, AFTER the Ack has
> been received and the bio completed and freed -- now we return to the
> worker thread and attempt to continue to loop through the (now free) bio
> with __bio_for_each_segment -- does this seem feasible?
>
> Assuming for the minute that this IS the cause, what would a suitable
> solution be? We really need to delay processing the Ack until the
> send-dblock/send-block has finished -- i.e. we should wait until the
> RQ_DRBD_ON_WIRE flag is set in the request -- is there something
> suitable we could issue a wait_event_interruptible() on in
> got_BlockAck() to wait for this?
>

Simon,=20

I think a suitable solution would be to complete the request after
1) it was written locally.
2) the ack was received.
3) and we finished sending it [new]

I attached the patch. I guess you will rerun your tests with this
patch. [ it is completely untested ]

I take from Lars' mail yesterday that he could not reproduce this
problem here on our main test cluster here, so it is up to you
to verify it.

=2Dphilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_vrt4EfQsBv+tPRo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="for_simon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="for_simon.diff"

Index: drbd_worker.c
===================================================================
--- drbd_worker.c	(revision 2373)
+++ drbd_worker.c	(working copy)
@@ -564,12 +564,10 @@
 
 	ok = drbd_send_dblock(mdev,req);
 	if (ok) {
-		spin_lock_irq(&mdev->req_lock);
-		req->rq_status |= RQ_DRBD_ON_WIRE;
-		spin_unlock_irq(&mdev->req_lock);
-
 		inc_ap_pending(mdev);
 
+		drbd_end_req(req,RQ_DRBD_ON_WIRE,1,drbd_req_get_sector(req));
+
 		if(mdev->net_conf->wire_protocol == DRBD_PROT_A) {
 			dec_ap_pending(mdev);
 			drbd_end_req(req, RQ_DRBD_SENT, 1, 
Index: drbd_int.h
===================================================================
--- drbd_int.h	(revision 2373)
+++ drbd_int.h	(working copy)
@@ -233,9 +233,9 @@
 #define RQ_DRBD_NOTHING	  0x0001
 #define RQ_DRBD_SENT      0x0010   // We got an ack
 #define RQ_DRBD_LOCAL     0x0020   // We wrote it to the local disk
-#define RQ_DRBD_DONE      0x0030   // We are done ;)
 #define RQ_DRBD_IN_TL     0x0040   // Set when it is in the TL
 #define RQ_DRBD_ON_WIRE   0x0080   // Set as soon as it is on the socket...
+#define RQ_DRBD_DONE      ( RQ_DRBD_SENT + RQ_DRBD_LOCAL + RQ_DRBD_ON_WIRE )
 
 /* drbd_meta-data.c (still in drbd_main.c) */
 #define DRBD_MD_MAGIC (DRBD_MAGIC+4) // 4th incarnation of the disk layout.

--Boundary-00=_vrt4EfQsBv+tPRo--
