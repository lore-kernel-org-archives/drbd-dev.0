Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7775E142F8
	for <drbd-dev@lists.linbit.com>; Wed,  8 Sep 2004 14:06:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Any updates on drbd-0.7.x on Linux-2.4.x ??
Date: Wed, 8 Sep 2004 14:06:07 +0200
References: <200409081155.48942.philipp.reisner@linbit.com>
	<200409081321.55125.philipp.reisner@linbit.com>
	<20040908114209.GB10017@nudl>
In-Reply-To: <20040908114209.GB10017@nudl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vWvPBNd98xMED9Z"
Message-Id: <200409081406.07659.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_vWvPBNd98xMED9Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wednesday 08 September 2004 13:42, Lars Ellenberg wrote:
> On Wed, Sep 08, 2004 at 01:21:55PM +0200, Philipp Reisner wrote:
> > On Wednesday 08 September 2004 12:58, Lars Ellenberg wrote:
> > > On Wed, Sep 08, 2004 at 11:55:48AM +0200, Philipp Reisner wrote:
> > > > Otherwhise I will make the 0.7.4 release
> > > > (and reenable the use of sendpage() generally)
>
>   BTW: please only enable it again after you at least did some
>        successfull full test runs on bloody&mary,
>        in particular T-007.sh
>

I will do...

> > What do you think will be on the 0.7.5 release ?
>
> currently pending: some modified ioctls for better heartbeat integration
> its a minor code change, but it will break API again.

I do not know what it is, but: yes, why not. ( on the other hand,  
see my perceptions about the progress with 0.8 )

> and we should do global cleanup over {user,drbd}/*.[ch] ...
>

Why should me do more with the code than necessary now. I do 
not like the idea to do any cleanup now. 

> so ok, lets do a test run on blodymary,
> release 0.7.4, go sailing, give me some five days of hacking, and
> release 0.7.5 then.

> if that is ok, then I'd say we fork the 0.7 branch, and continue with
> 0.8 cleanup and features in the trunk.
>

Right, I think we should create the 0.7 branch rather soon, and 
trunk becomes 0.8. I want to postpone any cleanup [ read: any not
really necessary changes! ] to the new branch.

Regarding the timeline:

Read what we have on the roadmap for 0.8 by now. There are no
really big things by now. I believe the we will be able to do
the 0.8 release aber 6 weeks after we started the branch already!

-> Lets do the really demanding changes in 0.9

-> Lets do all those little improvements in 0.8 (see roadmap.txt)

-> Do not press anything into 0.7, it should become stable like the
   ice of the antarctica.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_vWvPBNd98xMED9Z
Content-Type: text/plain;
  charset="iso-8859-1";
  name="roadmap.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roadmap.txt"

DRBD 0.8 Roadmap
----------------

1 Drop support for linux-2.4.x. 
  Do all size calculations on the base of sectors (512 Byte) as it 
  is common in Linux-2.6.x.
  (Currently they are done on a 1k base, for 2.4.x compatibility)

2 Drop the Drbd_Parameter_Packet.
  Replace the Drbd_Parameter_Packet by a more general and 
  extensible mechanism.

3 Changes of state and cstate synchronized by mutex and only done by
  the worker thread.

4 Two new config options, to allow more fine grained definition of
  DRDBs behaviour after a split-brain situation:

  after-sb-2pri = 
   disconnect     No automatic resynchronisation gets performed. One
                  node should drop its net-conf (preferable the
                  node that would become sync-target)
                  DEFAULT.
   asf-older      Auto sync from is the oder primary (curr.behaviour i.t.s.)
   asf-younger    Auto sync from is the younger primary
   asf-furthest   Auto sync from is the node that did more modifications
   asf-NODENAME   Auto sync from is the named node 
  
  
  pri-sees-sec-with-higher-gc =
   disconnect     (current behaviour)
   asf-primary    Auto sync from is the current primary
   panic          The current primary panics. The node with the
                  higher gc should take over.
  
  
  Notes:
  1) The disconnect actions cause the sync-target or the secondary
     node to go into StandAlone state.
  2) If two nodes in primary state try to connect one of them goes
     into StandAlone state (=curr. behaviour)
  3) As soon as the decision is takes the sync-target adopts the
     GC of the sync source. 
     [ The whole algorithm would also work if both would reset their 
       GCs to <0,0,0...> after the decision, but since we also
       use the GC to tag the bitmap it is better the current way ]

5 It is possible that a secondary node crashes a primary by 
  returning invalid block_ids in ACK packets. [This might be 
  either caused by faulty hardware, or by a hostile modification
  of DRBD on the secondary node]

  Proposed solution:
  
  Extend the block_id field. (currently 64 bit) by at least
  32 bits (64?) . (=block_id_chk field). The primary node 
  stores an encrypted (random key, changes every 15 minutes...) 
  checksum (=signature) in the second field. 

  The secondary node can not fake (either intentionally or 
  unintentionally) these signature. 

  The primary node will only dereference the block_id pointers
  if the signature is right.

6 Support IO fencing; introduce the "Dead" peer state (o_state)

  New commands:
    drbdadm peer-dead r0
    drbdadm [ considered-dead | die | fence | outdate ] r0 
      ( What do you like best ? Suggestions ? )

  remove option value: on-disconnect=freeze_io

  introduce: 
    peer-state-unknown=freeze_io
    peer-state-unknown=continue_io

  New meta-data flag: "Outdated"

  Let us assume that we have two boxes (N1 and N2) and that these
  two boxes are connected by two networks (net and cnet [ clinets'-net ]).

  Net is used by DRBD, while heartbeat uses both, net and cnet

  I know that you are talking about fencing by STONITH, but DRBD is
  not limited to that. Here comes my understanding of how fencing
  (other than STONITH) should work with DRBD-0.8 :

   N1  net   N2
   P/S ---  S/P     everything up and running.
   P/? - -  S/?     network breaks ; N1 freezes IO
   P/? - -  S/?     N1 fences N2:
                    In the STONITH case: turn off N2.
                    In the "smart" case: 
                    N1 asks N2 to fence itself from the storage via cnet.
                    HB calls "drbdadm fence r0" on N2.
                    N2 replies to N1 that fencing is done via cnet.
                    N1 calls "drbdadm peer-dead r0".
   P/D - -  S/?     N1 thaws IO

  N2 got the the "Outdated" flag set in its meta-data, by the "fence" 
  command. I am not sure if it should be called "fence", other ideas:
  "considered-dead","die","fence","outdate". What do you think ?

7 New command drbdmeta

  We move the read_gc.pl/write_gc.pl to the user directory. 
  Make them to one C program: drbdmeta
   -> in the future the module never creates the meta data
      block. One can use drbdmeta to create, read and 
      modify the drbdmeta block. drbdmeta refuses to write
      to it as long as the module is loaded (configured).

  drbdsetup gets the ability to read the gc values while DRBD
  is set up via an ioctl() call. -- drbdmeta refuses to run
  if DRBD is configured. 

  drbdadm is the nice frontend. It alsways uses the right 
  backend (drbdmeta or drbdsetup)...

  drbdadm md-set-gc 1:2:3:4:5:6 r0
  drbdadm md-get-gc r0
  drbdadm md-get/set-{la-size|consistent|etc...} resources....
  drbdadm md-create r0

plus-banches:
----------------------

* Implement the checksum based resync. 

* 3 node support. Do and test a 3 node setup (2nd DRBD stacked over
  a DRBD pair). Enhance the user level tools to support the 3 node
  setup.

--Boundary-00=_vWvPBNd98xMED9Z--
