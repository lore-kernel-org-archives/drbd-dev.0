Return-Path: <Lars.Ellenberg@linbit.com>
Date: Fri, 24 Sep 2004 16:29:25 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Message-ID: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: 
Subject: [Drbd-dev] [RFC] (CRM and) DRBD (0.8) states and transistions,
	recovery strategies
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

some of this applies to replicated resources in general,
so Andrew may have some ideas to generalize it...

source of it is a pod'ed perl script that I try to tweak into
calculating all the possible transitions for me (and then filter out the
relevant ones ...)

=======

DRBD cluster states and state transitions
    We want to consolidate all DRBD state changes and "recovery strategies"
    into one prominent and obvious place, something like a state machine.
    This is neccessary to serialize state changes properly, and to make
    error recovery maintainable.

    Given this background, this script generates a set of cluster states
    (and transitions later) of two DRBD peers from the point of view of an
    all knowing higher level intelligence (cluster manager/operator).

    We (as DRBD) should actually only be concerned about the single node
    state transitions, but the CRM (wink to Andrew) may want to twist its
    brain with the two node states to think about what can happen with
    replicated resources...

    This overview can and should be improved, so we provably cover all
    corner cases and the recovery strategies are as best as can be.

    Currently this covers only the states, and outlines the transitions. It
    should help to define the actions to be taken on every possible "input"
    to the DRBD internal "state machine".

    Please think about it and give us feedback. Especially about whether the
    the set of states is complete. We do not want to miss one single corner
    case.

    Thank you very much.

    Lars Ellenberg

  Node states
    Each node has several attributes, which may change more or less
    independently. A node can be

    *   up or down

    *   with backing storage or diskless

        We need to distinguish between data storage and meta-data storage.
        If we don't have meta-data storage, this may as well be down (and in
        the event of losing the md storage, it should take appropriate
        emergency actions to commit suicide).

        Obviously a diskless node cannot take part in synchronization.

    *   Active or Standby

        Promoting an unconnected diskless non-active node is not possible.

        Promoting a connected diskless non-active node should not be
        possible.

    *   target or source of synchronization, consistent, or inconsistent.

        Even though consistent, we might know or assume that we are
        outdated.

    *   connected or unconnected.

        Obviously an unconnected node cannot take part in synchronization.

    Some of the attributes depend on others, and the information about the
    node status could be easily encoded in one single letter.

    But since HA is all about redundancy, we will encode the node status
    redundantly in *four* letters, to make it more obvious to human readers.

     _        down,
     S        up, standby (non-active, but ready to become active)
     s        up, not-active, but target of sync
     i        up, not-active, unconnected, inconsistent
     o        up, not-active, unconnected, outdated
     d        up, not-active, diskless
     A        up, active
     a        up, active, but target of sync
     b        up, blocking, because unconnected active and inconsistent
                            (no valid data available)
     B        up, blocking, because unconnected active and diskless
                            (no valid data available)
     D        up, active, but diskless (implies connection to good data)
      M       meta-data storage available
      _       meta-data storage unavailable
       *      backing storage available
       o      backing storage consistent but outdated
              (refuses to become active)
       i      backing storage inconsistent (unfinished sync)
       _      diskless 
        :     unconnected, stand alone
        ?     unconnected, looking for peer
        -     connected
        >     connected, sync source
        <     connected, sync target

    Note however that "S" does NOT necessarily mean it has uptodate data,
    only that it thinks its data is consistent, it was not explicitly told
    that it is outdated, and it had no reason to assume so! E.g. directly
    after boot, if it was not yet connected, the data may well be
    consistent, but outdated. But since this is information not directly
    available to the node, let alone DRBD, this is difficult to map in here.

    Since if the node is down, everything else is irrelevant, and since
    synchronisation implies backing storage, without meta-data storage we
    refuse to do anything, and some of the states will resolve immediately,
    (e.g. outaded => sync target upon connect), we do now have 24
    distinguishable host states.

     ___:
     AM*- DM_- AM*> aM*< AM*?  AM*: bM*?  bM*: BM_?  BM_:
     SM*- dM_- SM*> sM*< SM*?  SM*: iM*?  iM*: dM_?  dM_:
          oM*-                      oM*?  oM*:

    This is our starting point, so please double check. Did I miss
    something?

    Because non-active unconnected diskless node can as well be down, to
    simplify, we *could* introduce this equivalence, which reduces some
    cluster states: dM_[:?] => __:

    We *could* merge both unconnected states into one for the purpose of
    describing and testing it. This needs some thought. It would reduce the
    number of possible node states by 5 resp. 6, and the resulting cluster
    states by a considerable factor. (..)[:?] => $1:

  Cluster States
    For the cluster:

     left-node -- network -- right-node

    the list of all possible pairwise combinations of these states needs to
    be filtered: combining a connected left state with an unconnected right
    state does not give a valid cluster state.

    Since connected states with more than one active node currently are
    still invalid, too, and will be immediately disconnected, we don't
    mention these, either. See also the note about the "split brain" cluster
    states below.

    States where both nodes are looking for the peer (should) resolve
    automatically into some connected mode "imediately" (unless the network
    is broken).

    Since we assume an "all knowing" CM, the state of the network link is
    therefore explicitly stated as - ok % broken

    For the purpose of describing and testing it we may chose to merge :%:
    and :-: into :_:, because if neither node tries to connect, the link
    status is irrelevant.

    We leave off states where the reverse symmetrically states are already
    listed.

  Classify
    These states can be classified as sane "[OK]", degraded "[deg]", not
    operational "{bad}", and fatal "[BAD]".

    A "[deg]" state is still operational. This means that applications can
    run and client requests are satisfied. But they are only one failure
    appart from being rendered non-operational, so you still should *run*
    and fix it...

    If it is not fatal, but only "{bad}", it *can* be "self healing", i.e.
    some of the "{bad}" states may find a transition to a operational state,
    though most likely only to some "{deg}" one. For example if the network
    comes back, or the cluster manager promotes a currently non-active node
    to be active.

    In case "[BAD]" modes do ever occure, intervention of a higher level
    intelligence (cluster manager/operator) is necessary to restore an
    operational state.

    There is one additional class: the "BRAIN" class, which typically can
    only occur in and after split brain situations, and can never occur with
    an "all knowing" cluster manager, so these are special cases here.

    Note that some of these (the "double A" states) may eventually become
    legal, when we start to support [Open]GFS or other shared access modes,
    others will then just be "{BAD}" or even only "{bad}".

    The outcome is

    225 states: [OK]: AM*---*MS SM*---*MS

     {deg}: AM*---_Md   DM_---*MS   AM*>->*Ms   aM*<-<*MS   AM*?-:*Mo
            AM*?%:*Mo   AM*?%?*Mo   AM*?%?*MS   AM*?-:*MS   AM*?%:*MS
            AM*?%?*Mi   AM*?-:*Mi   AM*?%:*Mi   AM*?%?_Md   AM*?-:_Md
            AM*?%:_Md   AM*?-:___   AM*?%:___   AM*:-:*Mo   AM*:%:*Mo
            AM*:-?*Mo   AM*:%?*Mo   AM*:-?*MS   AM*:%?*MS   AM*:-:*MS
            AM*:%:*MS   AM*:-?*Mi   AM*:%?*Mi   AM*:-:*Mi   AM*:%:*Mi
            AM*:-?_Md   AM*:%?_Md   AM*:-:_Md   AM*:%:_Md   AM*:-:___
            AM*:%:___   SM*>->*Ms

     {bad}: bM*?%?*MS   bM*?-:*MS   bM*?%:*MS   bM*:-?*MS   bM*:%?*MS
            bM*:-:*MS   bM*:%:*MS   BM_?%?*MS   BM_?-:*MS   BM_?%:*MS
            BM_:-?*MS   BM_:%?*MS   BM_:-:*MS   BM_:%:*MS   SM*---_Md
            oM*:-?*MS   oM*:%?*MS   oM*:-:*MS   oM*:%:*MS   oM*?%?*MS
            oM*?-:*MS   oM*?%:*MS   SM*?%?*MS   SM*?-:*MS   SM*?%:*MS
            SM*?%?*Mi   SM*?-:*Mi   SM*?%:*Mi   SM*?%?_Md   SM*?-:_Md
            SM*?%:_Md   SM*?-:___   SM*?%:___   SM*:-:*MS   SM*:%:*MS
            SM*:-?*Mi   SM*:%?*Mi   SM*:-:*Mi   SM*:%:*Mi   SM*:-?_Md
            SM*:%?_Md   SM*:-:_Md   SM*:%:_Md   SM*:-:___   SM*:%:___

     [BAD]: DM_---*Mo   DM_---_Md   bM*?-:*Mo   bM*?%:*Mo   bM*?%?*Mo
            bM*?%?*Mi   bM*?-:*Mi   bM*?%:*Mi   bM*?%?_Md   bM*?-:_Md
            bM*?%:_Md   bM*?-:___   bM*?%:___   bM*:-:*Mo   bM*:%:*Mo
            bM*:-?*Mo   bM*:%?*Mo   bM*:-?*Mi   bM*:%?*Mi   bM*:-:*Mi
            bM*:%:*Mi   bM*:-?_Md   bM*:%?_Md   bM*:-:_Md   bM*:%:_Md
            bM*:-:___   bM*:%:___   BM_?-:*Mo   BM_?%:*Mo   BM_?%?*Mo
            BM_?%?*Mi   BM_?-:*Mi   BM_?%:*Mi   BM_?%?_Md   BM_?-:_Md
            BM_?%:_Md   BM_?-:___   BM_?%:___   BM_:-:*Mo   BM_:%:*Mo
            BM_:-?*Mo   BM_:%?*Mo   BM_:-?*Mi   BM_:%?*Mi   BM_:-:*Mi
            BM_:%:*Mi   BM_:-?_Md   BM_:%?_Md   BM_:-:_Md   BM_:%:_Md
            BM_:-:___   BM_:%:___   oM*---*Mo   oM*---_Md   oM*:-:*Mo
            oM*:%:*Mo   oM*:-?*Mo   oM*:%?*Mo   oM*:-?*Mi   oM*:%?*Mi
            oM*:-:*Mi   oM*:%:*Mi   oM*:-?_Md   oM*:%?_Md   oM*:-:_Md
            oM*:%:_Md   oM*:-:___   oM*:%:___   oM*?%?*Mo   oM*?%?*Mi
            oM*?-:*Mi   oM*?%:*Mi   oM*?%?_Md   oM*?-:_Md   oM*?%:_Md
            oM*?-:___   oM*?%:___   dM_---_Md   iM*?%?*Mi   iM*?-:*Mi
            iM*?%:*Mi   iM*?%?_Md   iM*?-:_Md   iM*?%:_Md   iM*?-:___
            iM*?%:___   iM*:-:*Mi   iM*:%:*Mi   iM*:-?_Md   iM*:%?_Md
            iM*:-:_Md   iM*:%:_Md   iM*:-:___   iM*:%:___   dM_?%?_Md
            dM_?-:_Md   dM_?%:_Md   dM_?-:___   dM_?%:___   dM_:-:_Md
            dM_:%:_Md   dM_:-:___   dM_:%:___   ___:-:___   ___:%:___

     BRAIN: AM*?%?*MA   AM*?-:*MA   AM*?%:*MA   AM*?%?*Mb   AM*?-:*Mb
            AM*?%:*Mb   AM*?%?_MB   AM*?-:_MB   AM*?%:_MB   AM*:-:*MA
            AM*:%:*MA   AM*:-?*Mb   AM*:%?*Mb   AM*:-:*Mb   AM*:%:*Mb
            AM*:-?_MB   AM*:%?_MB   AM*:-:_MB   AM*:%:_MB   bM*?%?*Mb
            bM*?-:*Mb   bM*?%:*Mb   bM*?%?_MB   bM*?-:_MB   bM*?%:_MB
            bM*:-:*Mb   bM*:%:*Mb   bM*:-?_MB   bM*:%?_MB   bM*:-:_MB
            bM*:%:_MB   BM_?%?_MB   BM_?-:_MB   BM_?%:_MB   BM_:-:_MB
            BM_:%:_MB

  Possible Transitions
    Now, by comparing each with every state, and finding all pairs which
    differ in exactly one "attribute", we have all possible state
    transitions.

    We ignore certain node state transitions which are refused by drbd.
    Allowed node state transition "inputs" or "reactions" are

    *   up or down the node

    *   add/remove the disk (by administrative request or in response to io
        error)

        if it was the last accessible good data, should this result in
        suicide, or block all further io, or just fail all further io?

        if this lost the meta-data storage at the same time (meta-data
        internal), do we handle this differently?

    *   fail meta-data storage

        should result in suicide.

    *   establish or lose the connection; quit/start retrying to establish a
        connection.

    *   promote to active / demote to non-active

        To promote an unconnected inconsistent non-active node you need
        brute force. Similar if it thinks it is outdated.

        Promoting an unconnected diskless node is not possible. But those
        should have been mapped to a "down" node, anyways.

    *   start/finish synchronization

        One must not request a running and up-to-date active node to become
        target of synchronization.

    *   block/unblock all io requests

        This is in response to drbdadm suspend/resume, or a result of an
        "execption handler".

    *   commit suicide

        This is our last resort emergency handler. It should not be
        implemented as "panic", though currently it is.

    Again, this is important, please double check: Did I miss something?

    Because the fatal "[BAD]" and "BRAIN" states can only be resolved by the
    operator, for these we consider only transitions to a non-fatal state.
    Connected fatal states will immediately be disconnected.

    Transitions are consequences of certain events. An event can be an
    operator/cluster manager Request, a Failure, or a self-healing (of the
    network link, for example).

    While simulating the events, we will at any time modify exactly one node
    attribute of one node, or the status of the network link.

    The "establish connection" event is special in that we cannot simulate
    it: this is a DRBD-internel event. And from only looking at the cluster
    state before this event, we cannot directly know what cluster state will
    result, unless we want to add the "up-to-date-ness" of the data as
    additional node attribute...

    So as soon as the connection between DRBD-peers is established, they
    will auto-resolve to some other state.

======

what should follow are the relevant state transitions...
I am still not satisfied with the output of my script, though.
