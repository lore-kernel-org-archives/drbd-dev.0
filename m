Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id DD7ED142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 15:49:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 7 Sep 2004 15:49:15 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cxbPB2XblGp/gN1"
Message-Id: <200409071549.16078.philipp.reisner@linbit.com>
Subject: [Drbd-dev] roadmap draft
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_cxbPB2XblGp/gN1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

...
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_cxbPB2XblGp/gN1
Content-Type: text/plain;
  charset="us-ascii";
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

--Boundary-00=_cxbPB2XblGp/gN1--
