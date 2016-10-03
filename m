Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3D0131056332
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 11:52:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1B9EA4630C6
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 11:52:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id goVgpQp8Hm0t for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 11:52:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EC8D3463102
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 11:52:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QXjdYmS8SPXS for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 11:52:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id C274F4630C6
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 11:52:21 +0200 (CEST)
Date: Mon, 3 Oct 2016 11:52:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20161003095221.GG3302@soda.linbit>
References: <20160927104156.GD3302@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 29, 2016 at 03:34:10PM -0700, Eric Wheeler wrote:
> On Tue, 27 Sep 2016, Lars Ellenberg wrote:
> > On Mon, Sep 26, 2016 at 12:34:18PM -0700, Eric Wheeler wrote:
> > > On Mon, 26 Sep 2016, Lars Ellenberg wrote:
> > > > On Sun, Sep 25, 2016 at 04:47:49PM -0700, Eric Wheeler wrote:
> > > > > Hello all,
> > > > >=20
> > > > > Would someone kindly point me at documentation or help me summa=
rize the=20
> > > > > kernel thread and workqueues used by each DRBD resource?
> > > > >=20
> > > > > These are the ones I've found, please correct or add to my anno=
tations as=20
> > > > > necessary to get a better understanding of the internal data fl=
ow:
> > > > >=20
> > > > > drbd_submit (workqueue, device->submit.wq):
> > > > >   The workqueue that handles new read/write requests from the b=
lock layer,=20
> > > > >   updates the AL as necessary, sends IO to the peer (or remote-=
reads if=20
> > > > >   diskless).  Does this thread write blocklayer-submitted IO to=
 the=20
> > > > >   backing device, too, or just metadata writes?
> > > > >=20
> > > > >=20
> > > > > drbd_receiver (thread, connection->receiver):
> > > > >   The connection handling thread.  Does this thread do anything=
 besides=20
> > > > >   make sure the connection is up and handle cleanup on disconne=
ct?
> > > > >  =20
> > > > >   It looks like drbd_submit_peer_request is called several time=
s from=20
> > > > >   drbd_receiver.c, but is any disk IO performed by this thread?
> > > > >=20
> > > > >=20
> > > > > drbd_worker (thread, connection->worker):
> > > > >   The thread that does drbd work which is not directly related =
to IO=20
> > > > >   passed in by the block layer; action based on the work bits f=
rom=20
> > > > >   device->flags such as:
> > > > > 	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_dest=
roy, do_start_resync=20
> > > > >   Do metadata updates happen through this thread via=20
> > > > >   do_md_sync/update_on_disk_bitmap, or are they passed off to a=
nother=20
> > > > >   thread for writes?  Is any blocklayer-submitted IO submitted =
by this=20
> > > > >   thread?
> > > > >=20
> > > > >=20
> > > > > drbd_ack_receiver (thread, connection->ack_receiver):
> > > > >   Thread that receives all ACK types from the peer node. =20
> > > > >   Does this thread perform any disk IO?  What kind?
> > > > >=20
> > > > >=20
> > > > > drbd_ack_sender (workqueue, connection->ack_sender):
> > > > >   Thread that sends ACKs to the peer node.
> > > > >   Does this thread perform any disk IO?  What kind?
> > > >=20
> > > >=20
> > > > May I ask what you are doing?
> > > > It may help if I'm aware of your goals.
> > >=20
> > > Definitely!  There are several goals:=20
> > >=20
> > >   1. I would like to configure IO priority for metadata separately =
from=20
> > >      actual queued IO from the block layer (via ionice). If the IO =
is=20
> > >      separated nicely per pid, then I can ionice.  Prioritizing the=
 md IO=20
> > >      above request IO should increase fairness between DRBD volumes=
. =20
> > >      Secondarily, I'm working on cache hinting for bcache based on =
the=20
> > >      bio's ioprio and I would like to hint that any metadata IO to =
be=20
> > >      cached.
> > >=20
> > >   2. I would like to set the latency-sensitive pids as round-robin =
RT=20
> > >      through `chrt -r` so they be first off the running queue.  For=
=20
> > >      example, I would think ACKs should be sent/received/serviced a=
s fast=20
> > >      as possible to prevent the send/receive buffer from filling up=
 on a=20
> > >      busy system without increasing the buffer size and adding buff=
er=20
> > >      latency.  This is probably most useful for proto C, least for =
A.
> > >=20
> > >      If the request path is separated from the IO path into two pro=
cesses,=20
> > >      then increasing the new request handling thread priority could=
 reduce=20
> > >      latency on compute-heavy systems when the run queue is congest=
ed.=20
> > >      Thus, the submitting process can send its (async?) request and=
 get=20
> > >      back to computing with minimal delay for making the actual req=
uest. =20
> > >      IO may then complete at its leisure.
> > >=20
> > >   3. For multi-socket installations, sometimes the network card is =
tied to=20
> > >      a separate socket than the HBA.  I would like to set affinity =
per=20
> > >      drbd pid (in the same resource) such that network IO lives on =
the=20
> > >      network socket and block IO lives on the HBA socket---at least=
 to the=20
> > >      extent possible as threads function currently.
> > >=20
> > >   4. If possible, I would like to reduce priority for resync and ve=
rify=20
> > >      reads (and maybe resync writes if it doesn't congest the norma=
l=20
> > >      request write path).  This might require a configurable ioprio=
 option=20
> > >      to make drbd tag bio's with the configured ioprio before=20
> > >      drbd_generic_make_request---but it would be neat if this is po=
ssible=20
> > >      by changing the ioprio of the associated drbd resource pid. =20
> > >      (Looking at the code though, I think the receiver/worker threa=
ds=20
> > >      handle verifies I can't selectively choose the ioprio simply b=
y=20
> > >      flagging ioprio of the pid.)
> > >=20
> > >   5. General documentation.  It might help a developer in the futur=
e to=20
> > >      have a reference for the threads' purposes and general data fl=
ow=20
> > >      between the threads.
> >=20
> >=20
> > Thanks.
> >=20
> >=20
> > Block IO reaches drbd in drbd_make_request(), __drbd_make_request(),
> > then proceeds to drbd_request_prepare(), and (if possible[*]) is
> > submitted directly, still within the same context,
> > via drbd_send_and_submit().
> >=20
> > This is the "normal" path: local IO submission happens within the
> > context of the original submitter.
>=20
> Interesting, that makes sense. So if I wish to affect the IO priority=20
> (ionice) of the bio, then I need to modify the calling process since=20
> updating the DRBD pids will have no direct effect on "normal" traffic?

ionice'ing the original process will have the desired effect "most of
the time" for "not too large" and "not too fast moving" working sets,
and usually for READs.

> > [*] in case we need an activity log transaction first,
> > to save latency, and be able to accumulate several incoming write
> > requests (increase potential IO-depth), we queue incoming IO to the
> > "drbd_submit" work queue, which does "do_submit()" whenever woken up.
> > This way we can keep the submit latency small, even if the requests
> > may stay queued for some time because they wait for concurrent resync=
,
> > or meta data transactions.
> >=20
> > Things that end up on the "drbd_submit" work queue are WRITE requests
> > that need to wait for an activity log update first.
> > These activity log transactions (drbd meta data IO to the bitmap area
> > and the activity log area) are then submitted from this work queue,=20
> > then the corresponding queued IO is further processed like before,
> > by drbd_send_and_submit().
>=20
> So if I were to ionice the worker thread, then it will affect writes=20
> blocked by AL updates in addition to the queued write?

Worker thread ionice would not have any effect.  And the "drbd submit"
work queue is a work queue, and does only have "rescuer thread", but
usually the execution context would be the system work queue threads.

Not what you want.

If you think you need it, you'd have to come up with some mechanics of
"passing the original io-context along with the struct drbd_request",
then associate with that context regardless of submission context.

Is that really worth the effort in your scenario?

> Are all queued writes that require an AL update REQ_SYNC, or REQ_FLUSH?=
=20

No. They just happen to target a "cold" extent.
But the activity log transaction would have to reach stable storage
before the writes waiting for it may be submitted,
so that usually would involve FLUSH/FUA, unless disabled in the config.

> More generally, what types of IOs are relegated to the worker and block=
ed=20
> by an AL update?

writes.

> What do you think about the idea of adding REQ_META to AL writes?

I'd be surprised if it made any difference.

> > At this point, DRBD does ignore "io contexts".
> > We don't set our own context for meta data IO,
> > and we don't try to keep track of original context
> > for these writes that are submitted from the work queue context.
>=20
> Understood.
>=20
>=20
> > drbd_send_and_submit() also queues IO (typically: writes;
> > remote reads, if we have "read balancing" enabled,
> > or no good local) for the sender thread.
> >=20
> > The sender thread with DRBD 8.4 is still the "worker" thread,
> > drbdd(), which is also involved in DRBD internal state transition
> > handling (persisting role changes, data generation UUID tags and stuf=
f),
> > so it occasionally has to do synchronous updates to our "superblock",
> > but most of the time it just sends data as fast as it can to the peer=
,
> > via our "bulk data" connection.
> >=20
> > That data is received by the receiver thread on the peer,
> > which re-assembles the requests into bios, and currently
> > is also directly submitting these bios.
>=20
> So in the scenario where a secondary node is resyncing from its primary=
=20
> peer, the secondary node's receiver thread will issue the writes to its=
=20
> local disk?

You realize that we distinguish between replication (normal operation)
and resynchronization (after an outage).

> Is it also the receiving thread on the primary node that issues the rea=
d=20
> requests for that resync process?

The receiver thread will directly submit any IO request it receives from
the peer, regardless of "application" (submitted from upper layers on
the peer) or "resync" (internally generated by DRBD for resync or verify
purposes).

> Does this scenario change in a checksum-based resync?

In "normal" resync, sync target requests, sync source reads,
sync target writes.

In "checksum based" resync, sync target reads, then sends the checksums,
sync source reads, then sends back "check sum matches" or the actual data=
.

The first step is make_resync_request(), which means that the
read_for_csum() on sync target happens from the worker thread context.

> > At some point we may decouple receiving/reassembling of bios
> > and submitssion of said bios.
> >=20
> > The io-completion of the submitted-by-receiver-thread-on-peer
> > bios queues these as "ready-to-be-acked" on some list, where the
> > a(ck)sender thread picks them up and sends those acks via our "contro=
l"
> > or "meta" socket back to the primary peer, where they are received
> > and processed by the ack receiver thread.
> >=20
> > Both ack sender and ack receiver set themselves as SCHED_RR.
>=20
> So ack sender and ack receiver never perform disk IO?

Should not, no. I think they don't.  I won't bet on "never", though,
maybe they do, sometimes, implicitly, or in rare corner cases.

> > In addition to that we have the resync.  Depending on configuration,
> > resync related bios will be submitted by the worker (maybe, on verify
> > and on checksum-based resync) and receiver threads (always).
>=20
> I think I understand, but please answer with my 3 questions in the=20
> scenario above for my understanding and expand on them if necessary.
>=20
>=20
> > Then we have a "retry" context, where IO requests may be pushed back =
to,
> > if we want to mask IO errors from upper layers.
> > It acts as the context from where we re-enter __drbd_make_request().
> >=20
> > All real DRBD kernel threads do cpu pinning, by default they just pic=
k
> > "some" core, as in $minor modulo NR_CPUS or something.
> > Can be configured by "cpu-mask" in drbd.conf.
>=20
> When defining a CPU mask, does it pin to any random CPU in that mask?

cpu mask is passed to set_cpus_allowed_ptr().

> If I understand correctly, ack sender and ack receiver can be pinned to=
=20
> the network-cpu-socket-core since they perform no disk IO?

We currently have the one cpu mask for all threads.
But go ahead and pin (using taskset or cgroups or whatnot) how you see fi=
t,
and see if it makes a difference, we only apply the configured (or, if
not configured, calculated) cpu mask when you reconfigure it (resource op=
tions),
or during thread (re)start.


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
