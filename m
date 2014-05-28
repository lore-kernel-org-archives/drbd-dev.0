Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 39710101AC76
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 13:56:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2FF7C3C8D71
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 13:56:55 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id K66OYETu_ywu for <drbd-dev@lists.linbit.com>;
	Wed, 28 May 2014 13:56:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 153503C8D6A
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 13:56:55 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qrDCjcyZWVwB for <drbd-dev@lists.linbit.com>;
	Wed, 28 May 2014 13:56:55 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D415B3C8D67
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 13:56:54 +0200 (CEST)
Date: Wed, 28 May 2014 13:56:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140528115654.GH17111@soda.linbit>
References: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
	<20140527224053.GD17111@soda.linbit>
	<85bebd869def7c9ebf198ee72baef5ba@ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <85bebd869def7c9ebf198ee72baef5ba@ugr.es>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Protocol C
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

On Wed, May 28, 2014 at 12:14:30PM +0200, raulhp wrote:
> Hi Lars,
>=20
> I=B4m trying to understand how ACK=B4s works en Protocol C to try to us=
e
> it in Reliable Multicast in each receiver, I=B4m using a Reliable
> Multicast with NACK (Negative-ACKnowledgment) only in each loss
> packet.

Ok.

The entry point for requests from "upper layers" is
drbd_make_request
  __drbd_make_request
    drbd_request_prepare()
    drbd_send_and_submit(),
    which is in drbd_req.c

Everything "interesting" that happens to such a struct drbd_request
object is handled with req_mod(req, event, peer_device)
(or _req_mod ...) which are both a wrapper around
__req_mod(),
which calls into mod_rq_state();

"events" are drbd_req_events,
drbd requests state flags are from drbd_req_state_bits (__RQ_*)
(or the corresponding RQ_* defines).

grep for req_mod should be useful.

If you consider only the replication link(s),
the interesting functions are likely
drbd_sender.c,
  drbd_sender()
    wait_for_sender_todo()
    process_sender_todo()
      process_one_request()  =20

drbd_receiver.c
  drbd_asender()
     ... lots of other stuff ...
     cmd =3D &asender_tbl[pi.cmd];
     ...
     cmd->fn(connection, &pi);
with fn (see asender_tbl) being
  got_BlockAck()
  got_NegAck()

Where you would probabaly need a "got_mcast_neg_ack()",
which could maybe better be re-labeled as "got_mcast_retransmit_request()=
".

You would need to find the "relevant" requests on the
  resource->transfer_log(), and queue them for resend.
(Or abstract out your own primitives from the existing stuff,
 and implement both the existing TCP links and the new mcast
 with some additional auxiliary functions as needed).

Does that help?

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
