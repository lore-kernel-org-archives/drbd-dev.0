Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D66EA1056498
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C1EBB463ED6
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lGgLDa-q10OJ for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 90289463EEF
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cbd_18J_K23Y for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6C16B463ED6
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 13:58:38 +0200 (CEST)
Date: Mon, 26 Sep 2016 13:58:38 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160926115838.GA3302@soda.linbit>
References: <alpine.LRH.2.11.1609251548430.29933@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1609251548430.29933@mail.ewheeler.net>
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

On Sun, Sep 25, 2016 at 04:47:49PM -0700, Eric Wheeler wrote:
> Hello all,
>=20
> Would someone kindly point me at documentation or help me summarize the=
=20
> kernel thread and workqueues used by each DRBD resource?
>=20
> These are the ones I've found, please correct or add to my annotations =
as=20
> necessary to get a better understanding of the internal data flow:
>=20
> drbd_submit (workqueue, device->submit.wq):
>   The workqueue that handles new read/write requests from the block lay=
er,=20
>   updates the AL as necessary, sends IO to the peer (or remote-reads if=
=20
>   diskless).  Does this thread write blocklayer-submitted IO to the=20
>   backing device, too, or just metadata writes?
>=20
>=20
> drbd_receiver (thread, connection->receiver):
>   The connection handling thread.  Does this thread do anything besides=
=20
>   make sure the connection is up and handle cleanup on disconnect?
>  =20
>   It looks like drbd_submit_peer_request is called several times from=20
>   drbd_receiver.c, but is any disk IO performed by this thread?
>=20
>=20
> drbd_worker (thread, connection->worker):
>   The thread that does drbd work which is not directly related to IO=20
>   passed in by the block layer; action based on the work bits from=20
>   device->flags such as:
> 	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_destroy, do_=
start_resync=20
>   Do metadata updates happen through this thread via=20
>   do_md_sync/update_on_disk_bitmap, or are they passed off to another=20
>   thread for writes?  Is any blocklayer-submitted IO submitted by this=20
>   thread?
>=20
>=20
> drbd_ack_receiver (thread, connection->ack_receiver):
>   Thread that receives all ACK types from the peer node. =20
>   Does this thread perform any disk IO?  What kind?
>=20
>=20
> drbd_ack_sender (workqueue, connection->ack_sender):
>   Thread that sends ACKs to the peer node.
>   Does this thread perform any disk IO?  What kind?


May I ask what you are doing?
It may help if I'm aware of your goals.


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
