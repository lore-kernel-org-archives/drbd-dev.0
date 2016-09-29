Return-Path: <lists@ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 508D9105646E
	for <drbd-dev@lists.linbit.com>; Fri, 30 Sep 2016 20:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id CB5F7A0C50
	for <drbd-dev@lists.linbit.com>; Fri, 30 Sep 2016 10:58:11 -0700 (PDT)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BSj4sgXNX2RY for <drbd-dev@lists.linbit.com>;
	Fri, 30 Sep 2016 10:58:11 -0700 (PDT)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 0AE4DA0C2C
	for <drbd-dev@lists.linbit.com>; Fri, 30 Sep 2016 10:58:11 -0700 (PDT)
In-Reply-To: <20160927104156.GD3302@soda.linbit>
Date: Thu, 29 Sep 2016 15:34:10 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
ReSent-Message-ID: <alpine.LRH.2.11.1609301057550.31574@mail.ewheeler.net>
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
Message-ID: <20160929223410.oJpTDReKSWWyWOt2WMucYFDfWoi9cScrZ4feYCH9BF8@z>

On Tue, 27 Sep 2016, Lars Ellenberg wrote:
> On Mon, Sep 26, 2016 at 12:34:18PM -0700, Eric Wheeler wrote:
> > On Mon, 26 Sep 2016, Lars Ellenberg wrote:
> > > On Sun, Sep 25, 2016 at 04:47:49PM -0700, Eric Wheeler wrote:
> > > > Hello all,
> > > > 
> > > > Would someone kindly point me at documentation or help me summarize the 
> > > > kernel thread and workqueues used by each DRBD resource?
> > > > 
> > > > These are the ones I've found, please correct or add to my annotations as 
> > > > necessary to get a better understanding of the internal data flow:
> > > > 
> > > > drbd_submit (workqueue, device->submit.wq):
> > > >   The workqueue that handles new read/write requests from the block layer, 
> > > >   updates the AL as necessary, sends IO to the peer (or remote-reads if 
> > > >   diskless).  Does this thread write blocklayer-submitted IO to the 
> > > >   backing device, too, or just metadata writes?
> > > > 
> > > > 
> > > > drbd_receiver (thread, connection->receiver):
> > > >   The connection handling thread.  Does this thread do anything besides 
> > > >   make sure the connection is up and handle cleanup on disconnect?
> > > >   
> > > >   It looks like drbd_submit_peer_request is called several times from 
> > > >   drbd_receiver.c, but is any disk IO performed by this thread?
> > > > 
> > > > 
> > > > drbd_worker (thread, connection->worker):
> > > >   The thread that does drbd work which is not directly related to IO 
> > > >   passed in by the block layer; action based on the work bits from 
> > > >   device->flags such as:
> > > > 	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_destroy, do_start_resync 
> > > >   Do metadata updates happen through this thread via 
> > > >   do_md_sync/update_on_disk_bitmap, or are they passed off to another 
> > > >   thread for writes?  Is any blocklayer-submitted IO submitted by this 
> > > >   thread?
> > > > 
> > > > 
> > > > drbd_ack_receiver (thread, connection->ack_receiver):
> > > >   Thread that receives all ACK types from the peer node.  
> > > >   Does this thread perform any disk IO?  What kind?
> > > > 
> > > > 
> > > > drbd_ack_sender (workqueue, connection->ack_sender):
> > > >   Thread that sends ACKs to the peer node.
> > > >   Does this thread perform any disk IO?  What kind?
> > > 
> > > 
> > > May I ask what you are doing?
> > > It may help if I'm aware of your goals.
> > 
> > Definitely!  There are several goals: 
> > 
> >   1. I would like to configure IO priority for metadata separately from 
> >      actual queued IO from the block layer (via ionice). If the IO is 
> >      separated nicely per pid, then I can ionice.  Prioritizing the md IO 
> >      above request IO should increase fairness between DRBD volumes.  
> >      Secondarily, I'm working on cache hinting for bcache based on the 
> >      bio's ioprio and I would like to hint that any metadata IO to be 
> >      cached.
> > 
> >   2. I would like to set the latency-sensitive pids as round-robin RT 
> >      through `chrt -r` so they be first off the running queue.  For 
> >      example, I would think ACKs should be sent/received/serviced as fast 
> >      as possible to prevent the send/receive buffer from filling up on a 
> >      busy system without increasing the buffer size and adding buffer 
> >      latency.  This is probably most useful for proto C, least for A.
> > 
> >      If the request path is separated from the IO path into two processes, 
> >      then increasing the new request handling thread priority could reduce 
> >      latency on compute-heavy systems when the run queue is congested. 
> >      Thus, the submitting process can send its (async?) request and get 
> >      back to computing with minimal delay for making the actual request.  
> >      IO may then complete at its leisure.
> > 
> >   3. For multi-socket installations, sometimes the network card is tied to 
> >      a separate socket than the HBA.  I would like to set affinity per 
> >      drbd pid (in the same resource) such that network IO lives on the 
> >      network socket and block IO lives on the HBA socket---at least to the 
> >      extent possible as threads function currently.
> > 
> >   4. If possible, I would like to reduce priority for resync and verify 
> >      reads (and maybe resync writes if it doesn't congest the normal 
> >      request write path).  This might require a configurable ioprio option 
> >      to make drbd tag bio's with the configured ioprio before 
> >      drbd_generic_make_request---but it would be neat if this is possible 
> >      by changing the ioprio of the associated drbd resource pid.  
> >      (Looking at the code though, I think the receiver/worker threads 
> >      handle verifies I can't selectively choose the ioprio simply by 
> >      flagging ioprio of the pid.)
> > 
> >   5. General documentation.  It might help a developer in the future to 
> >      have a reference for the threads' purposes and general data flow 
> >      between the threads.
> 
> 
> Thanks.
> 
> 
> Block IO reaches drbd in drbd_make_request(), __drbd_make_request(),
> then proceeds to drbd_request_prepare(), and (if possible[*]) is
> submitted directly, still within the same context,
> via drbd_send_and_submit().
> 
> This is the "normal" path: local IO submission happens within the
> context of the original submitter.

Interesting, that makes sense. So if I wish to affect the IO priority 
(ionice) of the bio, then I need to modify the calling process since 
updating the DRBD pids will have no direct effect on "normal" traffic?
 
> [*] in case we need an activity log transaction first,
> to save latency, and be able to accumulate several incoming write
> requests (increase potential IO-depth), we queue incoming IO to the
> "drbd_submit" work queue, which does "do_submit()" whenever woken up.
> This way we can keep the submit latency small, even if the requests
> may stay queued for some time because they wait for concurrent resync,
> or meta data transactions.
> 
> Things that end up on the "drbd_submit" work queue are WRITE requests
> that need to wait for an activity log update first.
> These activity log transactions (drbd meta data IO to the bitmap area
> and the activity log area) are then submitted from this work queue, 
> then the corresponding queued IO is further processed like before,
> by drbd_send_and_submit().

So if I were to ionice the worker thread, then it will affect writes 
blocked by AL updates in addition to the queued write?

Are all queued writes that require an AL update REQ_SYNC, or REQ_FLUSH? 
More generally, what types of IOs are relegated to the worker and blocked 
by an AL update?

What do you think about the idea of adding REQ_META to AL writes?


> At this point, DRBD does ignore "io contexts".
> We don't set our own context for meta data IO,
> and we don't try to keep track of original context
> for these writes that are submitted from the work queue context.

Understood.


> drbd_send_and_submit() also queues IO (typically: writes;
> remote reads, if we have "read balancing" enabled,
> or no good local) for the sender thread.
> 
> The sender thread with DRBD 8.4 is still the "worker" thread,
> drbdd(), which is also involved in DRBD internal state transition
> handling (persisting role changes, data generation UUID tags and stuff),
> so it occasionally has to do synchronous updates to our "superblock",
> but most of the time it just sends data as fast as it can to the peer,
> via our "bulk data" connection.
> 
> That data is received by the receiver thread on the peer,
> which re-assembles the requests into bios, and currently
> is also directly submitting these bios.

So in the scenario where a secondary node is resyncing from its primary 
peer, the secondary node's receiver thread will issue the writes to its 
local disk?

Is it also the receiving thread on the primary node that issues the read 
requests for that resync process?

Does this scenario change in a checksum-based resync?


> At some point we may decouple receiving/reassembling of bios
> and submitssion of said bios.
> 
> The io-completion of the submitted-by-receiver-thread-on-peer
> bios queues these as "ready-to-be-acked" on some list, where the
> a(ck)sender thread picks them up and sends those acks via our "control"
> or "meta" socket back to the primary peer, where they are received
> and processed by the ack receiver thread.
> 
> Both ack sender and ack receiver set themselves as SCHED_RR.

So ack sender and ack receiver never perform disk IO?


> In addition to that we have the resync.  Depending on configuration,
> resync related bios will be submitted by the worker (maybe, on verify
> and on checksum-based resync) and receiver threads (always).

I think I understand, but please answer with my 3 questions in the 
scenario above for my understanding and expand on them if necessary.


> Then we have a "retry" context, where IO requests may be pushed back to,
> if we want to mask IO errors from upper layers.
> It acts as the context from where we re-enter __drbd_make_request().
> 
> All real DRBD kernel threads do cpu pinning, by default they just pick
> "some" core, as in $minor modulo NR_CPUS or something.
> Can be configured by "cpu-mask" in drbd.conf.

When defining a CPU mask, does it pin to any random CPU in that mask?

If I understand correctly, ack sender and ack receiver can be pinned to 
the network-cpu-socket-core since they perform no disk IO?

-Eric

