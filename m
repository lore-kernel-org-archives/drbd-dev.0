Return-Path: <lars@linbit.com>
Resent-Message-ID: <20070504161427.GA367@nudl>
Date: Fri, 4 May 2007 18:00:24 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Panic in _drbd_send_page() again.
Message-ID: <20070504160024.GA31637@nudl>
References: <342BAC0A5467384983B586A6B0B376710563693E@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B376710563693E@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 04, 2007 at 10:37:32AM -0400, Graham, Simon wrote:
> > 
> > all pieces of information we have about this seem to indicate that the
> > xen block device code builds up its own bios, tries to be smart
> > there...
> > 
> > and possibly outsmarts itself.
> > 
> 
> It's of course possible and we're looking at it but it's actually a
> pretty standard piece of code that builds the bio and I don't see any
> trickiness in it.
> 
> I also have a theory on the cause of this -- it's another tiny timing
> window I think similar to ones we fixed earlier where the ack for a
> packet would be received whilst we were still processing inside
> drbd_send_zc_bio -- here's my hypothesis:
> 
> 1. We're in drbd_send_zc_bio, we've sent the last segment but have not
> yet looped back to
>    the top of the loop to __bio_for_each_segment.
> 2. Ack arrives for last segment - clears RQ_NET_PENDING
> 3. Local IO completes, clears RQ_LOCAL_PENDING and calls req_may_be_done
> ==> completes bio
>    because both RQ_NET_PENDING and RQ_LOCAL_PENDING are clear.
> 
> NOW we come back to the thread running drbd_send_zc_bio and the bio has
> been freed... KABLOOIE!
> 
> I realize this is a very small window but, as the saying goes, where
> there's a window there's a bug...

hm. this does make sense, actually :)

> Seems to me that req_may_be_done should not complete the master bio
> unless RQ_NET_SENT is set... maybe the completed_ok: case in req_mod
> should test this similar to what is done in recv_acked_by_peer:...
> although it seems to me that this test should actually be buried in
> req_may_be_done since if this flag is not set, the request is not done!


so what you suggest is:

Index: drbd_req.c
===================================================================
--- drbd_req.c	(revision 2864)
+++ drbd_req.c	(working copy)
@@ -255,6 +255,16 @@
 	print_rq_state(req, "_req_may_be_done");
 	MUST_HOLD(&mdev->req_lock)
 
+	/* we must not complete the master bio, while it is
+	 *	still being processed by _drbd_send_zc_bio (drbd_send_dblock)
+	 *	not yet acknowledged by the peer
+	 *	not yet completed by the local io subsystem
+	 * these flags may get cleared in any order by
+	 *	the worker,
+	 *	the receiver,
+	 *	the bio_endio completion callbacks.
+	 */
+	if (s & RQ_NET_QUEUED) return;
 	if (s & RQ_NET_PENDING) return;
 	if (s & RQ_LOCAL_PENDING) return;
 

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :

