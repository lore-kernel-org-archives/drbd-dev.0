Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 817892D9DDDE
	for <drbd-dev@lists.linbit.com>; Fri, 12 Jan 2007 00:18:43 +0100 (CET)
Date: Fri, 12 Jan 2007 00:18:44 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: BUG when disk write errors occur during
	heavyI/O
Message-ID: <20070111231844.GB4245@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767104614900@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767104614900@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-01-11 15:39:10 -0500
\ Graham, Simon:
> > 
> > Simon, this is an excellent description of what is going on. I also
> > have gone
> > through it as well, and think that moving dec_local() is the correct
> > solution.
> > 
> > Just have just committed it
> > http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001421.html
> > 
> 
> Phil,
> 
> It turns out that this fix, whilst necessary I think, is not sufficient
> -- specifically, it does not cover the case where the local request
> fails and then later on the network request is ACK'd...
> 
> . When the local request fails, we run through
> req_mod(write_completed_with_error) and at the end
>   do the dec_local().
> . If some other thread was attempting to set the local disk Diskless, it
> will now see local_cnt==0
>   and run, releasing the act_log and resync caches.
> . Now the network request is acked and we run
> req_mod(write_acked_by_peer) -- now that both local and
>   remote are done, req_may_be_done does it's thing and ends up calling
> drbd_al_complete_io which crashes
>   because act_log is now NULL.
> 
> Now - one fix would be to check for act_log being NULL in
> drbd_al_complete_io. However, I wonder if it might be more correct to
> delay doing the dec_local() until we are definitely done with the
> request?
> 
> This would mean moving it out of req_mod() completely and instead doing
> it in req_may_be_done() when the request actually is complete on both
> sides... (and if RQ_LOCAL_COMPLETED flag is set I think)

so what you are saying is:
inc_local is done when the request is submitted.
dec_local should be done only when the request is in fact "done".
like below.

| Index: drbd_req.c
| ===================================================================
| --- drbd_req.c	(revision 2685)
| +++ drbd_req.c	(working copy)
| @@ -281,6 +281,7 @@
|  		} else {
|  			drbd_req_free(req);
|  		}
| +		dec_local(mdev);
|  	}
|  	/* else: network part and not DONE yet. that is
|  	 * protocol A or B, barrier ack still pending... */
| @@ -442,7 +443,6 @@
|  		req->rq_state &= ~RQ_LOCAL_PENDING;
|  
|  		_req_may_be_done(req,error);
| -		dec_local(mdev);
|  		break;
|  
|  	case write_completed_with_error:
| @@ -457,7 +457,6 @@
|  		 * FIXME see comment below in read_completed_with_error */
|  		__drbd_chk_io_error(mdev,FALSE);
|  		_req_may_be_done(req,error);
| -		dec_local(mdev);
|  		break;
|  
|  	case read_completed_with_error:
| @@ -469,7 +468,6 @@
|  
|  		bio_put(req->private_bio);
|  		req->private_bio = NULL;
| -		dec_local(mdev);
|  		if (bio_rw(req->master_bio) == READA) {
|  			/* it is legal to fail READA */
|  			_req_may_be_done(req,error);

hm. but that would make the "local" reference count be a network
reference count, too, it may even keep the reference for a long time
if you configure it to freeze io on connection loss...

not good.

so maybe we rather want to brace drbd_al_complete_io
with inc_local dec_local ?

currently we only call it in three places,
early bail out on conflicting writes in drbd_make_request
[which holds local ref], drbd_endio_write_sec when the
EE_CALL_AL_COMPLETE_IO flag is set [also holds a local ref]
and this code in question.

so how about this (sorry for the long lines):

Index: drbd_req.c
===================================================================
--- drbd_req.c	(revision 2685)
+++ drbd_req.c	(working copy)
@@ -257,7 +257,13 @@
 			 * we would forget to resync the corresponding extent.
 			 */
 			if (s & RQ_LOCAL_MASK) {
-				drbd_al_complete_io(mdev, req->sector);
+				if (inc_local_if_state(mdev,Failed)) {
+					drbd_al_complete_io(mdev, req->sector);
+					dec_local(mdev);
+				} else {
+					WARN("Should have called drbd_al_complete_io(, %llu), "
+					     "but my Disk seems to have faile :(\n", req->sector);
+				}
 			}
 		}
 

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
