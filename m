Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7D63B2DBC9DF
	for <drbd-dev@lists.linbit.com>; Thu, 11 Jan 2007 11:01:24 +0100 (CET)
Date: Thu, 11 Jan 2007 11:01:25 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - handling data write errors
Message-ID: <20070111100125.GE7910@soda.linbit>
References: <342BAC0A5467384983B586A6B0B376710461476B@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B376710461476B@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-01-10 23:00:53 -0500
\ Graham, Simon:
> > I'm not really sure how to fix this at the moment, but I'm considering
> > the following:
> > 
> > 1. The side that gets the error marks the block as out of sync AND
> > marks the local disk as inconsistent.
> > 2. Receipt of a NegAck causes the block to be marked as out of sync
> > AND the peer disk is made inconsistent (not sure if I need this step
> > since step 1 should cause this fact to be broadcast but it seems
> > safer).
> > 
> 
> So - I've found there is some existing code in place already - for
> example, set_out_of_sync is done in req_may_be_done if either local or
> remote fails, however, this is not sufficient for a couple of reasons:
> 
> 1. Need to get the failing disk set Inconsistent so that following reads
> do not attempt to use the local block.
> 
> 2. It seems to me that the current code doesn't really handle
> set_out_of_sync being set whilst resync is in progress (i.e. if a
> write error occurs on an application write during resync).
> 
> I've also coded something that sends the Inconsistent state to the other
> side, which will trigger resync immediately - perhaps I shouldn't do
> this??? Not really going to be able to fix this problem (although it
> might be worth trying if the error was transient)...
> 
> I wonder if we shouldn't instead simply always detach on error (i.e.
> stop using PassOn at all) to get the best behavior... this would
> certainly make things simpler (and we could remove the forcible detach
> on meta-data error that I added earlier -- if you want to be able to
> handle errors then never use PassOn!

this is not a short-term project, but
how about this:
 introduce an additional "badblocks" bitmap -- actually, I think probably
 a "range-list" type of storage would be appropriate here.

 local read error:
    mark dirty, read full blocks remotely (which may be more than the
    application requested), write -- written ok: mark clean again.
 local write error:
    mark block (range) as bad,
    mark system "degraded"
 both blocks bad, or remote not reachable:
    pass to upper layers.

I still need to think about the various meta-data io-error possibilities.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
