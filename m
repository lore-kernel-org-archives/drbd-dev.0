Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 97D2F1056463
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8893B40C6AD
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Gg6HHA7nqJ0h for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6ADF240C6B0
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w4QBqzT9GtsG for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4148D40C6AD
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 15:57:37 +0200 (CEST)
Date: Thu, 21 Apr 2016 15:57:36 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160421135736.GW3078@soda.linbit>
References: <CAF6H8oFWgKL3W5eeBeisDhk9Ldjm5YKUpKR0jUL-xtOmVbmS4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAF6H8oFWgKL3W5eeBeisDhk9Ldjm5YKUpKR0jUL-xtOmVbmS4Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [CASE-29] After re-connect,
 WFBitMapS-WFBitMapT status has sustained continuously and copy
 command hangs
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

On Thu, Apr 21, 2016 at 10:48:11PM +0900, Jaeheon Kim wrote:
> Hi,
>=20
> We wrote some temporary solution to avoid file copy hang problem.
> We inserted wake_up function for sender_work queue after  _req_mod(req,
> QUEUE_FOR_SEND_OOS, peer_device).
> Please check following code in drbd_process_write_request function.

Please try to send unified diffs.
maybe git diff, even.

>=20
> drbd_process_write_request ()
> {
>=20
>   ........
>=20
>=20
> } else if (drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size=
))
>=20
> #ifdef _WIN32_V9 // Windows DRBD
> {
>     _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device);
>     if(peer_device->repl_state[NOW] =3D=3D L_WF_BITMAP_S)
>     {
>         wake_up(&peer_device->connection->sender_work.q_wait);
>     }
> }
> #else
>     _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device); // Linux Org
> #endif
>=20
> }
>=20
> What do you think about this idea?

You are correct,
if all established replication links are "ahead",
and not a single link actually gets the data,
we may miss the wake up of the sender.

better fix is probably
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 3159de8..ae4bbd6 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -1666,8 +1666,7 @@ static void drbd_send_and_submit(struct drbd_device=
 *device, struct drbd_request
 		}
 		if (!drbd_process_write_request(req))
 			no_remote =3D true;
-		else
-			wake_all_senders(resource);
+		wake_all_senders(resource);
 	} else {
 		if (peer_device) {
 			_req_mod(req, TO_BE_SENT, peer_device);

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
