Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0A575105645E
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2016 12:41:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CA30B427AD0
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2016 12:41:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PDcB4DrJ_a_4 for <drbd-dev@lists.linbit.com>;
	Tue, 27 Sep 2016 12:41:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A5632427AD3
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2016 12:41:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gJ0Nz8l9AW00 for <drbd-dev@lists.linbit.com>;
	Tue, 27 Sep 2016 12:41:57 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E34CE427AD0
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2016 12:41:56 +0200 (CEST)
Date: Tue, 27 Sep 2016 12:41:56 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160927104156.GD3302@soda.linbit>
References: <alpine.LRH.2.11.1609251548430.29933@mail.ewheeler.net>
	<20160926115838.GA3302@soda.linbit>
	<alpine.LRH.2.11.1609261154460.29933@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1609261154460.29933@mail.ewheeler.net>
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

On Mon, Sep 26, 2016 at 12:34:18PM -0700, Eric Wheeler wrote:
> On Mon, 26 Sep 2016, Lars Ellenberg wrote:
> > On Sun, Sep 25, 2016 at 04:47:49PM -0700, Eric Wheeler wrote:
> > > Hello all,
> > >=20
> > > Would someone kindly point me at documentation or help me summarize=
 the=20
> > > kernel thread and workqueues used by each DRBD resource?
> > >=20
> > > These are the ones I've found, please correct or add to my annotati=
ons as=20
> > > necessary to get a better understanding of the internal data flow:
> > >=20
> > > drbd_submit (workqueue, device->submit.wq):
> > >   The workqueue that handles new read/write requests from the block=
 layer,=20
> > >   updates the AL as necessary, sends IO to the peer (or remote-read=
s if=20
> > >   diskless).  Does this thread write blocklayer-submitted IO to the=
=20
> > >   backing device, too, or just metadata writes?
> > >=20
> > >=20
> > > drbd_receiver (thread, connection->receiver):
> > >   The connection handling thread.  Does this thread do anything bes=
ides=20
> > >   make sure the connection is up and handle cleanup on disconnect?
> > >  =20
> > >   It looks like drbd_submit_peer_request is called several times fr=
om=20
> > >   drbd_receiver.c, but is any disk IO performed by this thread?
> > >=20
> > >=20
> > > drbd_worker (thread, connection->worker):
> > >   The thread that does drbd work which is not directly related to I=
O=20
> > >   passed in by the block layer; action based on the work bits from=20
> > >   device->flags such as:
> > > 	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_destroy,=
 do_start_resync=20
> > >   Do metadata updates happen through this thread via=20
> > >   do_md_sync/update_on_disk_bitmap, or are they passed off to anoth=
er=20
> > >   thread for writes?  Is any blocklayer-submitted IO submitted by t=
his=20
> > >   thread?
> > >=20
> > >=20
> > > drbd_ack_receiver (thread, connection->ack_receiver):
> > >   Thread that receives all ACK types from the peer node. =20
> > >   Does this thread perform any disk IO?  What kind?
> > >=20
> > >=20
> > > drbd_ack_sender (workqueue, connection->ack_sender):
> > >   Thread that sends ACKs to the peer node.
> > >   Does this thread perform any disk IO?  What kind?
> >=20
> >=20
> > May I ask what you are doing?
> > It may help if I'm aware of your goals.
>=20
> Definitely!  There are several goals:=20
>=20
>   1. I would like to configure IO priority for metadata separately from=
=20
>      actual queued IO from the block layer (via ionice). If the IO is=20
>      separated nicely per pid, then I can ionice.  Prioritizing the md =
IO=20
>      above request IO should increase fairness between DRBD volumes. =20
>      Secondarily, I'm working on cache hinting for bcache based on the=20
>      bio's ioprio and I would like to hint that any metadata IO to be=20
>      cached.
>=20
>   2. I would like to set the latency-sensitive pids as round-robin RT=20
>      through `chrt -r` so they be first off the running queue.  For=20
>      example, I would think ACKs should be sent/received/serviced as fa=
st=20
>      as possible to prevent the send/receive buffer from filling up on =
a=20
>      busy system without increasing the buffer size and adding buffer=20
>      latency.  This is probably most useful for proto C, least for A.
>=20
>      If the request path is separated from the IO path into two process=
es,=20
>      then increasing the new request handling thread priority could red=
uce=20
>      latency on compute-heavy systems when the run queue is congested.=20
>      Thus, the submitting process can send its (async?) request and get=
=20
>      back to computing with minimal delay for making the actual request=
. =20
>      IO may then complete at its leisure.
>=20
>   3. For multi-socket installations, sometimes the network card is tied=
 to=20
>      a separate socket than the HBA.  I would like to set affinity per=20
>      drbd pid (in the same resource) such that network IO lives on the=20
>      network socket and block IO lives on the HBA socket---at least to =
the=20
>      extent possible as threads function currently.
>=20
>   4. If possible, I would like to reduce priority for resync and verify=
=20
>      reads (and maybe resync writes if it doesn't congest the normal=20
>      request write path).  This might require a configurable ioprio opt=
ion=20
>      to make drbd tag bio's with the configured ioprio before=20
>      drbd_generic_make_request---but it would be neat if this is possib=
le=20
>      by changing the ioprio of the associated drbd resource pid. =20
>      (Looking at the code though, I think the receiver/worker threads=20
>      handle verifies I can't selectively choose the ioprio simply by=20
>      flagging ioprio of the pid.)
>=20
>   5. General documentation.  It might help a developer in the future to=
=20
>      have a reference for the threads' purposes and general data flow=20
>      between the threads.


Thanks.


Block IO reaches drbd in drbd_make_request(), __drbd_make_request(),
then proceeds to drbd_request_prepare(), and (if possible[*]) is
submitted directly, still within the same context,
via drbd_send_and_submit().

This is the "normal" path: local IO submission happens within the
context of the original submitter.

[*] in case we need an activity log transaction first,
to save latency, and be able to accumulate several incoming write
requests (increase potential IO-depth), we queue incoming IO to the
"drbd_submit" work queue, which does "do_submit()" whenever woken up.
This way we can keep the submit latency small, even if the requests
may stay queued for some time because they wait for concurrent resync,
or meta data transactions.

Things that end up on the "drbd_submit" work queue are WRITE requests
that need to wait for an activity log update first.
These activity log transactions (drbd meta data IO to the bitmap area
and the activity log area) are then submitted from this work queue,=20
then the corresponding queued IO is further processed like before,
by drbd_send_and_submit().

At this point, DRBD does ignore "io contexts".
We don't set our own context for meta data IO,
and we don't try to keep track of original context
for these writes that are submitted from the work queue context.


drbd_send_and_submit() also queues IO (typically: writes;
remote reads, if we have "read balancing" enabled,
or no good local) for the sender thread.

The sender thread with DRBD 8.4 is still the "worker" thread,
drbdd(), which is also involved in DRBD internal state transition
handling (persisting role changes, data generation UUID tags and stuff),
so it occasionally has to do synchronous updates to our "superblock",
but most of the time it just sends data as fast as it can to the peer,
via our "bulk data" connection.

That data is received by the receiver thread on the peer,
which re-assembles the requests into bios, and currently
is also directly submitting these bios.

At some point we may decouple receiving/reassembling of bios
and submitssion of said bios.

The io-completion of the submitted-by-receiver-thread-on-peer
bios queues these as "ready-to-be-acked" on some list, where the
a(ck)sender thread picks them up and sends those acks via our "control"
or "meta" socket back to the primary peer, where they are received
and processed by the ack receiver thread.

Both ack sender and ack receiver set themselves as SCHED_RR.


In addition to that we have the resync.  Depending on configuration,
resync related bios will be submitted by the worker (maybe, on verify
and on checksum-based resync) and receiver threads (always).


Then we have a "retry" context, where IO requests may be pushed back to,
if we want to mask IO errors from upper layers.
It acts as the context from where we re-enter __drbd_make_request().

All real DRBD kernel threads do cpu pinning, by default they just pick
"some" core, as in $minor modulo NR_CPUS or something.
Can be configured by "cpu-mask" in drbd.conf.


I think that is about it.
What do I need to clarify?


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
