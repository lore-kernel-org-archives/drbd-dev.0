Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BC4614301
	for <drbd-dev@lists.linbit.com>; Mon,  4 Oct 2004 15:25:40 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Mon, 4 Oct 2004 15:26:15 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004130158.GP1542@marowsky-bree.de>
In-Reply-To: <20041004130158.GP1542@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410041526.15189.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 04 October 2004 15:01, Lars Marowsky-Bree wrote:
> On 2004-10-04T14:56:21, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> > This is intended as food for thought on how we should design our
> > support for shared disk file systems.
>
> I'm still not sure what kind of special support you need. The only
> guarantee you need to provide is that after a barrier all reads on all
> nodes return the same data for those blocks affected by the flush.
>
> The shared disk file system itself will take care of issueing
> appropriate barrier and flushing the OS caches.
>
> Am I missing something? ;-)
>

If everything works (esp. the locking of the shared disk fs) no.

But just consider that the locking of the shared disk FS on 
top of us is broken, and that it issues a write request to
the same block number on both nodes.

Then each node would write its copy first and the peers
version of the data at second to that block number.

=> We would have different data in this block on our
   two copies. - And we would event know about it!

What would have happened on a real shared disk?
The real shared disk would have ordered in some order,
ond one of the writes would overwrite the other version.
(This is the basic design idea of proposed solution 1)

(For proposed solution2 the lock "granulaty" of the 
 shared disk FS is interesting...)


--snip from ROADMAP file--
 global write order

  As far as I understand the topic up to now we have two options
  to establish a global write order. 

  Proposed Solution 1, using the order of a coordinator node:

  Writes from the coordinator node are carried out, as they are
  carried out on the primary node in conventional DRBD. ( Write 
  to disk and send to peer simultaneously. )

  Writes from the other node are sent to the coordinator first, 
  then the coordinator inserts a small "write now" packet into
  its stream of write packets.
  The node commits the write to its local IO subsystem as soon 
  as it gets the "write-now" packet from the coordinator.

  Note: With protocol C it does not matter which node is the
        coordinator from the performance viewpoint.

  Proposed Solution 2, use a dedicated LRU to implement locking:

  Each extent in the locking LRU can have on of these states:
    requested
    locked-by-peer
    locked-by-me
    locked-by-me-and-requested-by-peer

  We allow application writes only to extents which are in
  locked-by-me* state. 

  New Packets:
    LockExtent
    LockExtentAck

  Configuration directives: dl-extents , dl-extent-size

  TODO: Need to verify with GFS that this makes sense.



-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
