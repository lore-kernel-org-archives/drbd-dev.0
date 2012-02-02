Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 070C41056C5C
	for <drbd-dev@lists.linbit.com>; Thu,  2 Feb 2012 16:30:51 +0100 (CET)
Date: Thu, 2 Feb 2012 16:30:51 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20120202153051.GJ31519@barkeeper1-xen.linbit>
References: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
	<CAPkhwwRUvGsmQCAO+UJJL2CXG-Xa=DemzV2q1_4Ztkn5ZwHKEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPkhwwRUvGsmQCAO+UJJL2CXG-Xa=DemzV2q1_4Ztkn5ZwHKEg@mail.gmail.com>
Subject: Re: [Drbd-dev] Why does resync-cache uses LRU, rather than a queue,
 as its mechanism.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Feb 02, 2012 at 11:12:36PM +0800, carlos_wang wrote:
> 2012/1/29 carlos_wang <1988wzc@gmail.com>
> 
> > Hi all:
> >         I got a problem in understanding why resync-cache uses LRU as its
> > mechanism. I think that a queue is enough to realize the LRU functions. Why
> > does it use LRU anyway?
> >
> >         Thanks in advance.
> >
> >         Carlos.
> >
> Blocks may be "resynced" by new application writes as well.
> 
> Thanks, but according to the code,

I wrote it. Usually I know what it does.
Sometimes I even remember why it does things the way it does ;-)
Though I'm not saying that was the only way to do things.
MD raid solves its own very similar problem differently.

> Once application writes on a DRBD
> device, act_log will cache the active sector in al_extent, writes the last
> extent in lru list on the disk, And never known by resync extent, of course
> in right connection. How blocks know "resynced" by new application
> writes? When drbd begin resyncing, the sector will start from the first
> sector to last sector, so I think it's no need to use LRU as its resync
> mechanism.

Even *during* resync, there are application writes.

Besides, just curious here, why do you even care?

What are you trying to do, prove, disprove, improve?
What is you interest in DRBD in particular?
Anything we can help you with?

Cheers,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
