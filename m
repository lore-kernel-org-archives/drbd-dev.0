Return-Path: <lmb@suse.de>
Date: Thu, 26 Aug 2004 10:27:50 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Summary (3rd try)
Message-ID: <20040826082750.GA3125@marowsky-bree.de>
References: <200408251713.45325.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408251713.45325.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-08-25T17:13:45,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> Hi,
> 
> I tried to incooperate the comments of LMB and LGE. Please review:
> 
> after-pri-pri-now-sec-sec = 

I wish I had a better name here ;-)

>  disconnect     No automatic resynchronisation gets performed. One
>                 node should drop its net-conf (preferable the
>                 node that would become sync-target)
>                 DEFAULT.

Hmmm. Should they drop the netconf, or should instead the first node to
be elected primary become the SyncSource implicitly?

>  ass-older      Auto sync source is the oder primary (curr.behaviour i.t.s.)
>  ass-younger    Auto sync source is the younger primary

I'm a bit concerned about the older vs younger distinction. "before" and
"after" may be slightly better at conveying what you mean.

>  ass-furthest   Auto sync source is the node that did more modifications
>  ass-NODENAME   Auto sync source is the named node 

> pri-sees-sec-with-higher-gc =
>  disconnect	(current behaviour)
>  ass-primary	Auto sync source is the current primary
>  panic		The current primary panics. The node with the
> 		higher gc should take over.

Seems ok.

> Notes:
> 1) The disconnect actions cause the sync-target or the secondary
>    node to go into StandAllone state.
> 2) If two nodes in primary state try to connect one of them goes
>    into StandAllone state (=curr. behaviour)

This is not quite symmetric, which means special cases ;-) Shouldn't
they either refuse to connect, or both drop to StandAlone?

> 3) As soon as the decission is takes the sync-target addopts the
>    GC of the sync source. 
>    [ The whole algorith would also work if both would reset their 
>      GCs to <0,0,0...> after the decission, but since we also
>      use the GC to tag the bitmap it is better the current way ]

Ok.

> Is this better than try2 ?
> Should we improve the naming ? "ass" might not be the best choice.

auto-sync-from-

> Do you think that the naming is constent ?
> Is it still ambiguous ?

I hope it's not, but the other Lars is better at spotting
inconsistencies than I am ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

