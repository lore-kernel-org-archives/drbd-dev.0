Return-Path: <lars@linbit.com>
Date: Sat, 5 May 2007 02:14:16 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Panic in _drbd_send_page() again.
Message-ID: <20070505001416.GA11793@nudl>
References: <342BAC0A5467384983B586A6B0B376710563693E@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B37671056369DA@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671056369DA@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 04, 2007 at 03:02:45PM -0400, Graham, Simon wrote:
> > so what you suggest is:
> > 
> > Index: drbd_req.c
> > ===================================================================
> > --- drbd_req.c	(revision 2864)
> > +++ drbd_req.c	(working copy)
> > @@ -255,6 +255,16 @@
> >  	print_rq_state(req, "_req_may_be_done");
> >  	MUST_HOLD(&mdev->req_lock)
> > 
> > +	/* we must not complete the master bio, while it is
> > +	 *	still being processed by _drbd_send_zc_bio
> > (drbd_send_dblock)
> > +	 *	not yet acknowledged by the peer
> > +	 *	not yet completed by the local io subsystem
> > +	 * these flags may get cleared in any order by
> > +	 *	the worker,
> > +	 *	the receiver,
> > +	 *	the bio_endio completion callbacks.
> > +	 */
> > +	if (s & RQ_NET_QUEUED) return;
> >  	if (s & RQ_NET_PENDING) return;
> >  	if (s & RQ_LOCAL_PENDING) return;
> > 
> 
> I think this is correct -- in fact, I _think_ you could probably do away
> with the RQ_NET_SENT flag (since this is, I think, the same as
> !RQ_NET_QUEUED) which would be good (always good to remove extra
> flags!).
> 
> In addition, there is code in req_mod right now that checks RQ_NET_SENT
> before calling req_may_be_done -- this is no lomger needed since
> req_may_be_done does the check. I've attached a completely untested
> proposed patch that does this in addition to the change above... let me
> know what you think...

For protocol C [and thats all that really matters, I know ;)]
this would be correct. I think.
But then, for protocol C only, we could get rid of a lot more there.

One might think the NET_SENT was always only a redundant flag,
and just the negation of the NET_QUEUED. but it is not.

I needed it to distinguish a local only request from one that was sent
over the network, but is not yet done, even though all other
NET_somthing flags might be clear for some reason.

there must be no time window where I cannot tell
whether a request had a network part or not,
from looking at the state flags.

At least for protocol A and B this would open up an other window,
where (state & NET_MASK) == 0 [*], even though it is still on the lists,
and the corresponding barrier ack is still pending.

[*] e.g. when receiving a neg_acked before handed_over_to_network.
    maybe that is even the only corner case, given that otherwise
    either NET_OK or NET_DONE should be set...

there is obviously redundant information in there,
using five bits for way below 32 states...
we can probably reorganize these flags, and their lifetime.
say, introduce a "RQ_NET_PART" and "RQ_LOCAL_PART".

but I don't think we can get rid of RQ_NET_SENT _that_ easy.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
