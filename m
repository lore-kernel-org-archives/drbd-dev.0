Return-Path: <lmb@suse.de>
Date: Fri, 24 Sep 2004 23:11:33 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Message-ID: <20040924211133.GC3927@marowsky-bree.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
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

On 2004-09-24T16:29:25,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

> some of this applies to replicated resources in general,
> so Andrew may have some ideas to generalize it...

I think the modelling we have so far (with the recent addendum) captures
this quite nicely for the time being. But of course, it'll help us to
verify this.

>     Some of the attributes depend on others, and the information about the
>     node status could be easily encoded in one single letter.
> 
>     But since HA is all about redundancy, we will encode the node status
>     redundantly in *four* letters, to make it more obvious to human readers.
> 
>      _        down,
>      S        up, standby (non-active, but ready to become active)
>      s        up, not-active, but target of sync
>      i        up, not-active, unconnected, inconsistent
>      o        up, not-active, unconnected, outdated
>      d        up, not-active, diskless
>      A        up, active
>      a        up, active, but target of sync
>      b        up, blocking, because unconnected active and inconsistent
>                             (no valid data available)
>      B        up, blocking, because unconnected active and diskless
>                             (no valid data available)
>      D        up, active, but diskless (implies connection to good data)
>       M       meta-data storage available
>       _       meta-data storage unavailable
>        *      backing storage available
>        o      backing storage consistent but outdated
>               (refuses to become active)
>        i      backing storage inconsistent (unfinished sync)
>        _      diskless 
>         :     unconnected, stand alone
>         ?     unconnected, looking for peer
>         -     connected
>         >     connected, sync source
>         <     connected, sync target

I'd structure this somewhat differently into the node states (Up, Down),
our assumption about the other node (up, down, fenced), Backing Store
states (available, outdated, inconsistent, unavailable), the connection
(up or down) and the relationship between the GCs (higher, lower,
equal).

(Whether we are syncing and in what direction seems to be a function of
that, same whether or not we are blocking or not.)

It's essentially the same as your list, but it seems to be more
accessible to me. But, it's late ;-)

>     Because non-active unconnected diskless node can as well be down, to
>     simplify, we *could* introduce this equivalence, which reduces some
>     cluster states: dM_[:?] => __:

Seems sane.

>     We *could* merge both unconnected states into one for the purpose of
>     describing and testing it. This needs some thought. It would reduce the
>     number of possible node states by 5 resp. 6, and the resulting cluster
>     states by a considerable factor. (..)[:?] => $1:

Are they really, though? Doesn't it affect the GC if I tell it to go
standalone as opposed to leaving it looking for it's peer?

>   Classify
>     These states can be classified as sane "[OK]", degraded "[deg]", not
>     operational "{bad}", and fatal "[BAD]".

Makes sense, mostly, but...

>     A "[deg]" state is still operational. This means that applications can
>     run and client requests are satisfied. But they are only one failure
>     appart from being rendered non-operational, so you still should *run*
>     and fix it...
> 
>     If it is not fatal, but only "{bad}", it *can* be "self healing", i.e.
>     some of the "{bad}" states may find a transition to a operational state,
>     though most likely only to some "{deg}" one. For example if the network
>     comes back, or the cluster manager promotes a currently non-active node
>     to be active.

A bad state seems 'degenerate' to me. Are those two really distinct?
Self-healing would be an on-going sync or something like it.

>     The outcome is
> 
>     225 states: [OK]: AM*---*MS SM*---*MS

I see know why you backed away from my proposal of the state machine for
the testing back then and instead suggested the CTH ;-)

>   Possible Transitions
>     Now, by comparing each with every state, and finding all pairs which
>     differ in exactly one "attribute", we have all possible state
>     transitions.

These seem sane and complete.

Just some comments:

>     We ignore certain node state transitions which are refused by drbd.
>     Allowed node state transition "inputs" or "reactions" are
> 
>     *   up or down the node
> 
>     *   add/remove the disk (by administrative request or in response to io
>         error)
> 
>         if it was the last accessible good data, should this result in
>         suicide, or block all further io, or just fail all further io?
> 
>         if this lost the meta-data storage at the same time (meta-data
>         internal), do we handle this differently?
> 
>     *   fail meta-data storage
> 
>         should result in suicide.

In fact, even for meta-data loss, we can switch to detached mode and
increase some version counters on the other side, and still do a smooth
transition. We can't any longer touch the local disk, which is bad, but
we also can't make it worse.

This will work as long as we don't explicitly have to _set_ a
dirty/outdated bit, but if we explicitly clear it instead when we
smoothly shutdown.

I don't see any difference here between meta-data and backing store
loss, actually, that complicates things unnecessarily.

>     *   establish or lose the connection; quit/start retrying to establish a
>         connection.
> 
>     *   promote to active / demote to non-active
> 
>         To promote an unconnected inconsistent non-active node you need
>         brute force. Similar if it thinks it is outdated.
> 
>         Promoting an unconnected diskless node is not possible. But those
>         should have been mapped to a "down" node, anyways.
> 
>     *   start/finish synchronization
> 
>         One must not request a running and up-to-date active node to become
>         target of synchronization.
> 
>     *   block/unblock all io requests
> 
>         This is in response to drbdadm suspend/resume, or a result of an
>         "execption handler".
> 
>     *   commit suicide
> 
>         This is our last resort emergency handler. It should not be
>         implemented as "panic", though currently it is.
> 


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

