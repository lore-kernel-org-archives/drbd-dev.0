Return-Path: <lmb@suse.de>
Date: Thu, 9 Sep 2004 12:05:52 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] roadmap draft
Message-ID: <20040909100552.GQ20844@marowsky-bree.de>
References: <200409071549.16078.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409071549.16078.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T15:49:15,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> DRBD 0.8 Roadmap
> ----------------
> 
> 1 Drop support for linux-2.4.x. 
>   Do all size calculations on the base of sectors (512 Byte) as it 
>   is common in Linux-2.6.x.
>   (Currently they are done on a 1k base, for 2.4.x compatibility)

For all I care, 2.4 can die die die any second... ;-)

> 4 Two new config options, to allow more fine grained definition of
>   DRDBs behaviour after a split-brain situation:
> 
>   after-sb-2pri = 
>    disconnect     No automatic resynchronisation gets performed. One
>                   node should drop its net-conf (preferable the
>                   node that would become sync-target)
>                   DEFAULT.
>    asf-older      Auto sync from is the oder primary (curr.behaviour i.t.s.)
>    asf-younger    Auto sync from is the younger primary
>    asf-furthest   Auto sync from is the node that did more modifications
>    asf-NODENAME   Auto sync from is the named node 

With the 'preferrably the node which would become sync-target'
constraint, you would need to allow to specify one of the other methods
too (how else would you determine which node would become sync-target?).

>   pri-sees-sec-with-higher-gc =
>    disconnect     (current behaviour)
>    asf-primary    Auto sync from is the current primary
>    panic          The current primary panics. The node with the
>                   higher gc should take over.
>   
>   
>   Notes:
>   1) The disconnect actions cause the sync-target or the secondary
>      node to go into StandAlone state.

>   2) If two nodes in primary state try to connect one of them goes
>      into StandAlone state (=curr. behaviour)

1+2 - I'd rather prefer a symmetric scenario where both nodes go to
StandAlone.

>   3) As soon as the decision is takes the sync-target adopts the
>      GC of the sync source. 
>      [ The whole algorithm would also work if both would reset their 
>        GCs to <0,0,0...> after the decision, but since we also
>        use the GC to tag the bitmap it is better the current way ]
> 
> 5 It is possible that a secondary node crashes a primary by 
>   returning invalid block_ids in ACK packets. [This might be 
>   either caused by faulty hardware, or by a hostile modification
>   of DRBD on the secondary node]
> 
>   Proposed solution:

I'd just keep a map of outstanding ACKs and compare any ACK received
against that list. Wouldn't that solve this?

> 6 Support IO fencing; introduce the "Dead" peer state (o_state)

Dead peer state + Outdated flag seems good, but regarding the 'fence', I
defer this to the other thread ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

