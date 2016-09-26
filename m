Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D495D1056468
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 21:34:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id 540D0A0C52
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 12:34:19 -0700 (PDT)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z3gc2sKLvQhs for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 12:34:18 -0700 (PDT)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 628E0A0C51
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 12:34:18 -0700 (PDT)
Date: Mon, 26 Sep 2016 12:34:18 -0700 (PDT)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
In-Reply-To: <20160926115838.GA3302@soda.linbit>
Message-ID: <alpine.LRH.2.11.1609261154460.29933@mail.ewheeler.net>
References: <alpine.LRH.2.11.1609251548430.29933@mail.ewheeler.net>
	<20160926115838.GA3302@soda.linbit>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1641074820-236621891-1474918315=:29933"
Subject: Re: [Drbd-dev] drbd threads and workqueues: For what is each
 responsible?
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1641074820-236621891-1474918315=:29933
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 26 Sep 2016, Lars Ellenberg wrote:
> On Sun, Sep 25, 2016 at 04:47:49PM -0700, Eric Wheeler wrote:
> > Hello all,
> > 
> > Would someone kindly point me at documentation or help me summarize the 
> > kernel thread and workqueues used by each DRBD resource?
> > 
> > These are the ones I've found, please correct or add to my annotations as 
> > necessary to get a better understanding of the internal data flow:
> > 
> > drbd_submit (workqueue, device->submit.wq):
> >   The workqueue that handles new read/write requests from the block layer, 
> >   updates the AL as necessary, sends IO to the peer (or remote-reads if 
> >   diskless).  Does this thread write blocklayer-submitted IO to the 
> >   backing device, too, or just metadata writes?
> > 
> > 
> > drbd_receiver (thread, connection->receiver):
> >   The connection handling thread.  Does this thread do anything besides 
> >   make sure the connection is up and handle cleanup on disconnect?
> >   
> >   It looks like drbd_submit_peer_request is called several times from 
> >   drbd_receiver.c, but is any disk IO performed by this thread?
> > 
> > 
> > drbd_worker (thread, connection->worker):
> >   The thread that does drbd work which is not directly related to IO 
> >   passed in by the block layer; action based on the work bits from 
> >   device->flags such as:
> > 	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_destroy, do_start_resync 
> >   Do metadata updates happen through this thread via 
> >   do_md_sync/update_on_disk_bitmap, or are they passed off to another 
> >   thread for writes?  Is any blocklayer-submitted IO submitted by this 
> >   thread?
> > 
> > 
> > drbd_ack_receiver (thread, connection->ack_receiver):
> >   Thread that receives all ACK types from the peer node.  
> >   Does this thread perform any disk IO?  What kind?
> > 
> > 
> > drbd_ack_sender (workqueue, connection->ack_sender):
> >   Thread that sends ACKs to the peer node.
> >   Does this thread perform any disk IO?  What kind?
> 
> 
> May I ask what you are doing?
> It may help if I'm aware of your goals.

Definitely!  There are several goals: 

  1. I would like to configure IO priority for metadata separately from 
     actual queued IO from the block layer (via ionice). If the IO is 
     separated nicely per pid, then I can ionice.  Prioritizing the md IO 
     above request IO should increase fairness between DRBD volumes.  
     Secondarily, I'm working on cache hinting for bcache based on the 
     bio's ioprio and I would like to hint that any metadata IO to be 
     cached.

  2. I would like to set the latency-sensitive pids as round-robin RT 
     through `chrt -r` so they be first off the running queue.  For 
     example, I would think ACKs should be sent/received/serviced as fast 
     as possible to prevent the send/receive buffer from filling up on a 
     busy system without increasing the buffer size and adding buffer 
     latency.  This is probably most useful for proto C, least for A.

     If the request path is separated from the IO path into two processes, 
     then increasing the new request handling thread priority could reduce 
     latency on compute-heavy systems when the run queue is congested. 
     Thus, the submitting process can send its (async?) request and get 
     back to computing with minimal delay for making the actual request.  
     IO may then complete at its leisure.

  3. For multi-socket installations, sometimes the network card is tied to 
     a separate socket than the HBA.  I would like to set affinity per 
     drbd pid (in the same resource) such that network IO lives on the 
     network socket and block IO lives on the HBA socket---at least to the 
     extent possible as threads function currently.

  4. If possible, I would like to reduce priority for resync and verify 
     reads (and maybe resync writes if it doesn't congest the normal 
     request write path).  This might require a configurable ioprio option 
     to make drbd tag bio's with the configured ioprio before 
     drbd_generic_make_request---but it would be neat if this is possible 
     by changing the ioprio of the associated drbd resource pid.  
     (Looking at the code though, I think the receiver/worker threads 
     handle verifies I can't selectively choose the ioprio simply by 
     flagging ioprio of the pid.)

  5. General documentation.  It might help a developer in the future to 
     have a reference for the threads' purposes and general data flow 
     between the threads.


--
Eric Wheeler



> 
> 
> -- 
> : Lars Ellenberg
> : LINBIT | Keeping the Digital World Running
> : DRBD -- Heartbeat -- Corosync -- Pacemaker
> : R&D, Integration, Ops, Consulting, Support
> 
> DRBD® and LINBIT® are registered trademarks of LINBIT
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 
--1641074820-236621891-1474918315=:29933--
