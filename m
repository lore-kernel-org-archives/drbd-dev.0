Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-064-125.arcor-ip.net
	[145.254.64.125])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id EE09314311
	for <drbd-dev@lists.linbit.com>; Fri,  8 Oct 2004 15:54:53 +0200 (CEST)
Date: Fri, 8 Oct 2004 15:51:56 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <dDaDQgQP8BPHVcecFLAhen0=lge@web.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<200410041617.21258.philipp.reisner@linbit.com>
	<2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
	<200410081432.09710.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410081432.09710.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-08 14:32:09 +0200
\ Philipp Reisner:
> Hi Friends,
> 
> In reallity it is much more complex than we thought in the first
> place.
> 
> I think that the solution with the "coordinator node" and the write
> now packet would be simpler, but it's drawback is the additional
> write now packet means that we have more packets on the wirte....
> 
> ... But please read it first!

now, I did not, yet...

but, 

network packets we have in the active/non-active case:

	data -> 
	     <- ack (recv (B) or write (C))
	
packets we have in the active/active case,
lets do this strictly for protocol C first:

  write on non-coordinator:
	data -> 
	     <- write now               [ when? is this already a write ack? ]
	ack  ->             (write ack)
             <- ack         (write ack) [ when? is this neccessary? ]

  write on coordinator:
	     <- data
	ack  ->

packets we have in the active/active case, arbitration mode:

	data ->
		[ cancel it, or write it.
		  if canceled, send "cancel ack",
		  if written, send write ack ]
	     <- ack


do we agree so far?
or is anything else neccessary?
an additional ack in the other direction, maybe?


I think I like the "locking extents" best.
this assumes that a typical usage pattern would have distinct active
sets on both nodes. then, most of the time writes go through normally as
if this was active, and the other node non-active.
sometimes, i.e. whenever I modify the activity-log, I need to communiacte:
	want-extent -> 
			[**]
		    <- there you go

and this expected to be as infrequent as actlog updates now.
but [**] can be expensive, if both nodes try to write to the same
"lock region", and we have a lock-extent ping-pong, because it would
basically mean 
	if I don't use it, tell peer "you have it",
	if I did use it, but its no longer in active use now, ex it from
		my activity log and tell peer "you have it"
	if it is still in use, mark it to be send to the peer,
		which implies to not accept new requests,
		and as soon as the local usage count drops to zero,
		it is send to the peer.
now, if the alternating write blocks to the same lock-region, thats bad.
expectation is they don't, because upper layers have the same
problem, and therefore will optimize to not do so.


but, yes, I will have a look at the arbitration logic, too.

	lge
