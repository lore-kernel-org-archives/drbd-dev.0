Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (Ad5f1.a.pppool.de [213.6.213.241])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AD378142F9
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 18:09:30 +0200 (CEST)
Date: Tue, 21 Sep 2004 18:09:10 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <YscVefD2K3hzkd308QASFow=lge@web.de>
References: <20040921153713.3E1613BE6E@garcon.linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921153713.3E1613BE6E@garcon.linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1550 - trunk
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-21 17:37:13 +0200
\ svn@svn.drbd.org:
> Author: phil
> Date: 2004-09-21 17:37:10 +0200 (Tue, 21 Sep 2004)
> New Revision: 1550
> 
> Added:
>    trunk/ROADMAP
> Log:
> What we want to do...
> 
> 
> 
> Added: trunk/ROADMAP
> ===================================================================
> --- trunk/ROADMAP	2004-09-21 11:05:25 UTC (rev 1549)
> +++ trunk/ROADMAP	2004-09-21 15:37:10 UTC (rev 1550)
> @@ -0,0 +1,200 @@
> +DRBD 0.8 Roadmap
> +----------------
> +
> +1 Drop support for linux-2.4.x. 

done :)

> +  Do all size calculations on the base of sectors (512 Byte) as it 
> +  is common in Linux-2.6.x.
> +  (Currently they are done on a 1k base, for 2.4.x compatibility)

to be done

> +
> +2 Drop the Drbd_Parameter_Packet.
> +  Replace the Drbd_Parameter_Packet by a more general and 
> +  extensible mechanism.

yep.

> +
> +3 Authenticate the peer upon connect by using a shared secret. 
> +  Config file syntax:  net { auth-secret "secret-word" }
> +  Using a challenge-response authentication within the new
> +  handshake. 

yep.

> +
> +4 Changes of state and cstate synchronized by mutex and only done by
> +  the worker thread.

yep.

> +
> +5 Two new config options, to allow more fine grained definition of
> +  DRDBs behaviour after a split-brain situation:
> +
> +  after-sb-2pri = 
> +   disconnect     No automatic resynchronisation gets performed. One
> +                  node should drop its net-conf (preferable the
> +                  node that would become sync-target)
> +                  DEFAULT.
> +   asf-older      Auto sync from is the oder primary (curr.behaviour i.t.s.)
> +   asf-younger    Auto sync from is the younger primary
> +   asf-furthest   Auto sync from is the node that did more modifications
> +   asf-NODENAME   Auto sync from is the named node 

please name it more agressive. how about:
 discard-older-transactions
 discard-younger-transactions
 discard-less-modified
 discard-changes-on-NODENAME

> +  
> +  pri-sees-sec-with-higher-gc =
> +   disconnect     (current behaviour)
> +   asf-primary    Auto sync from is the current primary

again: discard-...

> +   panic          The current primary panics. The node with the
> +                  higher gc should take over.

we should replace all panic calls with something else,
because the panic is not guaranteed to work anyways, and
it is very rude to other resources, too.

maybe rather replace it with some exeption handling scheme which would
block all further access to the device first, then call some user space
helper to do problem solving (and that script then can decide to do
something like halt -nf, shutdown now+60seconds bla ...

> +  Notes:
> +  1) The disconnect actions cause the sync-target or the secondary
> +     (better both) node to go into StandAlone state.
> +  2) If two nodes in primary state try to connect one (better both)
> +     of them goes into StandAlone state (=curr. behaviour)
> +  3) As soon as the decision is takes the sync-target adopts the
> +     GC of the sync source. 
> +     [ The whole algorithm would also work if both would reset their 
> +       GCs to <0,0,0...> after the decision, but since we also
> +       use the GC to tag the bitmap it is better the current way ]

needs more thought...

> +6 It is possible that a secondary node crashes a primary by 
> +  returning invalid block_ids in ACK packets. [This might be 
> +  either caused by faulty hardware, or by a hostile modification
> +  of DRBD on the secondary node]
> +
> +  Proposed solution:
> +
> +  Have a hash table (hlist_head style), add the collision
> +  member (hlist_node) to drbd_request. 
> +
> +  Use the pointer to the drbd_request as key to the hash, each
> +  drbd_request is also put into this hash table. We still use the 
> +  pointer as block_id. 
> +
> +  When we get an ACK packet, we lookup the hash table with the
> +  block_id, and may find the drbd_request there. Otherwise it 
> +  was a forged ACK.

yep.

> +7 Handle split brain situations; Support IO fencing; 
> +  introduce the "Dead" peer state (o_state)
> +
> +  New commands:
> +    drbdadm peer-dead r0

     peer-is-dead r0
     peer-was-fenced r0

and, while we are at it,
   suspend
   resume

> +    drbdadm [ considered-dead | die | fence | outdate ] r0 
> +      ( What do you like best ? Suggestions ? )
> +
> +  remove option value: on-disconnect=freeze_io
> +
> +  introduce: 
> +    peer-state-unknown=freeze_io
> +    peer-state-unknown=continue_io
> +
> +  New meta-data flag: "Outdated"
> +
> +  Let us assume that we have two boxes (N1 and N2) and that these
> +  two boxes are connected by two networks (net and cnet [ clinets'-net ]).
> +
> +  Net is used by DRBD, while heartbeat uses both, net and cnet
> +
> +  I know that you are talking about fencing by STONITH, but DRBD is
> +  not limited to that. Here comes my understanding of how fencing
> +  (other than STONITH) should work with DRBD-0.8 :
> +
> +   N1  net   N2
> +   P/S ---  S/P     everything up and running.
> +   P/? - -  S/?     network breaks ; N1 freezes IO
> +   P/? - -  S/?     N1 fences N2:
> +                    In the STONITH case: turn off N2.
> +                    In the "smart" case: 
> +                    N1 asks N2 to fence itself from the storage via cnet.
> +                    HB calls "drbdadm fence r0" on N2.
> +                    N2 replies to N1 that fencing is done via cnet.
> +                    N1 calls "drbdadm peer-dead r0".
> +   P/D - -  S/?     N1 thaws IO
> +
> +  N2 got the the "Outdated" flag set in its meta-data, by the "fence" 
> +  command. I am not sure if it should be called "fence", other ideas:
> +  "considered-dead","die","fence","outdate". What do you think ?

yes.
this will be sorted out in detail once we get to
implementing it on the drbd and on the crm side...

> +
> +8 New command drbdmeta
> +
> +  We move the read_gc.pl/write_gc.pl to the user directory. 
> +  Make them to one C program: drbdmeta
> +   -> in the future the module never creates the meta data
> +      block. One can use drbdmeta to create, read and 
> +      modify the drbdmeta block. drbdmeta refuses to write
> +      to it as long as the module is loaded (configured).

I think the module still needs to generate the meta data.
only it no longer does so by itself, it needs to be asked explicitly.
helps to avoid funny races.

> +  drbdsetup gets the ability to read the gc values while DRBD
> +  is set up via an ioctl() call. -- drbdmeta refuses to run
> +  if DRBD is configured. 

hm. could, and maybe should, go through the module.
then it could manipulate GCs on a running drbd, too.
I can imagine situations where this would be convenient.

> +  drbdadm is the nice frontend. It alsways uses the right 
> +  backend (drbdmeta or drbdsetup)...
> +
> +  drbdadm md-set-gc 1:2:3:4:5:6 r0
> +  drbdadm md-get-gc r0
> +  drbdadm md-get/set-{la-size|consistent|etc...} resources....
> +  drbdadm md-create r0

md-create would ask nasty questions about whether you are really sure
and so on, and do some plausibility checks first...
md-set would be undocumented and for wizards only.

> +9 Support shared disk semantics  ( for GFS, OCFS etc... )
> +plus-banches:

I already commented on these two.


	lge
