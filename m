Return-Path: <Lars.Ellenberg@linbit.com>
Date: Sat, 25 Sep 2004 01:04:57 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Message-ID: <qEu8Pd/NWgF9/2NlEKWF2r4=lge@web.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<20040924211133.GC3927@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924211133.GC3927@marowsky-bree.de>
Cc: 
Subject: [Drbd-dev] Re: [Linux-ha-dev] [RFC] (CRM and) DRBD (0.8) states and
	transistions, recovery strategies
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-24 23:11:33 +0200
\ Lars Marowsky-Bree:
> On 2004-09-24T16:29:25,
>    Lars Ellenberg <Lars.Ellenberg@linbit.com> said:
> 
> > some of this applies to replicated resources in general,
> > so Andrew may have some ideas to generalize it...
> 
> I think the modelling we have so far (with the recent addendum) captures
> this quite nicely for the time being. But of course, it'll help us to
> verify this.
> 
> >     Some of the attributes depend on others, and the information about the
> >     node status could be easily encoded in one single letter.
> > 
> >     But since HA is all about redundancy, we will encode the node status
> >     redundantly in *four* letters, to make it more obvious to human readers.
> > 
> >      _        down,
> >      S        up, standby (non-active, but ready to become active)
> >      s        up, not-active, but target of sync
> >      i        up, not-active, unconnected, inconsistent
> >      o        up, not-active, unconnected, outdated
> >      d        up, not-active, diskless
> >      A        up, active
> >      a        up, active, but target of sync
> >      b        up, blocking, because unconnected active and inconsistent
> >                             (no valid data available)
> >      B        up, blocking, because unconnected active and diskless
> >                             (no valid data available)
> >      D        up, active, but diskless (implies connection to good data)
> >       M       meta-data storage available
> >       _       meta-data storage unavailable
> >        *      backing storage available
> >        o      backing storage consistent but outdated
> >               (refuses to become active)
> >        i      backing storage inconsistent (unfinished sync)
> >        _      diskless 
> >         :     unconnected, stand alone
> >         ?     unconnected, looking for peer
> >         -     connected
> >         >     connected, sync source
> >         <     connected, sync target
> 
> I'd structure this somewhat differently into the node states (Up, Down),
> our assumption about the other node (up, down, fenced), Backing Store
> states (available, outdated, inconsistent, unavailable), the connection
> (up or down) and the relationship between the GCs (higher, lower,
> equal).
> 
> (Whether we are syncing and in what direction seems to be a function of
> that, same whether or not we are blocking or not.)
> 
> It's essentially the same as your list, but it seems to be more
> accessible to me. But, it's late ;-)

well, it is really the same, I guess.

but I'll try to write pseudo code for the state tupels that should make
it clear, and post that here, before I go implement it.

> >   Classify
> >     These states can be classified as sane "[OK]", degraded "[deg]", not
> >     operational "{bad}", and fatal "[BAD]".
> 
> Makes sense, mostly, but...
> 
> >     A "[deg]" state is still operational. This means that applications can
> >     run and client requests are satisfied. But they are only one failure
> >     appart from being rendered non-operational, so you still should *run*
> >     and fix it...
> > 
> >     If it is not fatal, but only "{bad}", it *can* be "self healing", i.e.
> >     some of the "{bad}" states may find a transition to a operational state,
> >     though most likely only to some "{deg}" one. For example if the network
> >     comes back, or the cluster manager promotes a currently non-active node
> >     to be active.
> 
> A bad state seems 'degenerate' to me. Are those two really distinct?
> Self-healing would be an on-going sync or something like it.

well, the difference is "degenerate" is bad,
but I still have access to good data (which I mean by operational)!

> >     225 states: [OK]: AM*---*MS SM*---*MS
> 
> I see know why you backed away from my proposal of the state machine for
> the testing back then and instead suggested the CTH ;-)

at that point of time we did not know yet about "outdated",
and it was "only" 171 states iirc ...

> >     We ignore certain node state transitions which are refused by drbd.
> >     Allowed node state transition "inputs" or "reactions" are
> > 
> >     *   up or down the node
> > 
> >     *   add/remove the disk (by administrative request or in response to io
> >         error)
> > 
> >         if it was the last accessible good data, should this result in
> >         suicide, or block all further io, or just fail all further io?
> > 
> >         if this lost the meta-data storage at the same time (meta-data
> >         internal), do we handle this differently?
> > 
> >     *   fail meta-data storage
> > 
> >         should result in suicide.
> 
> In fact, even for meta-data loss, we can switch to detached mode and
> increase some version counters on the other side, and still do a smooth
> transition. We can't any longer touch the local disk, which is bad, but
> we also can't make it worse.
> 
> This will work as long as we don't explicitly have to _set_ a
> dirty/outdated bit, but if we explicitly clear it instead when we
> smoothly shutdown.
> 
> I don't see any difference here between meta-data and backing store
> loss, actually, that complicates things unnecessarily.

well, DRBD needs to make a difference, because they meta-data storage
and data storage may be physically different devices, and therefore can
fail independently. (ok, single blocks can fail on the same physical
storage independently, too, but this is an other thing)

but yes, meta-data loss is not per definition catastrophic...

	lge
