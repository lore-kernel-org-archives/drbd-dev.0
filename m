Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6294C142F9
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 16:16:46 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 21 Sep 2004 16:16:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409211616.59305.philipp.reisner@linbit.com>
Subject: [Drbd-dev] GFS support in DRBD-0.8
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Lars,

I have thought about it and wrote this item for the roadmpa.txt
document :

--snip--
8 Support shared disk semantics  ( for GFS, OCFS etc... )

    All the thoughts in this area, imply that the cluster deals
    with split brain situations as discussed in item 6.

  In order to offer a shared disk mode for GFS, we introduce a 
  new state "shared" (in addition to primary and secondary).

  In a cluster of two nodes in shared state we determine a 
  coordinator node (e.g. by selecting the node with the 
  numeric higher IP address)

 read after write dependencies

  The shared state is available to clusters using protocol C
  and B. It is not usable with protocol A.

  To support the shared state with protocol B, upon a read
  request the node has to check if a new version of the block
  is in the progress of getting written. (== search for it on
  active_ee and done_ee, must make sure that it is on active_ee
  before the RecvAck is sent. [is already the case.] )
  
 global write order

  As far as I understand the toppic up to now we have two options
  to establish a global write order. 

  Proposed Solution 1, using the order of a coordinator node:

  Writes from the coordinator node are carried out, as they are
  carried out on the primary node in conventional DRBD. ( Write 
  to disk and send to peer simultaniously. )

  Writes from the other node are sent to the coordinator first, 
  then the coordinator inserts a small "write now" packet into
  its stram of write packets.
  The node commits the write to its local IO subsystem as soon 
  as it gets the "write-now" packet from the coordinator.

  Note: With protocol C it does not matter which node is the
        coordinator from the performance viewpoint.

  Proposed Solution 2, use ALs as distributed locks:

  Only one node might mark an extent as active at a time. New
  packets are introduced to request the locking of an extent.
--snap--

PS: I think that we do not need to use the AL extents as
    distributed locks.

PS2: Comments about the wording ("coordinator") are also welcome.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
