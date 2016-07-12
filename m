Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 049731028A59
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BA3E842096E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id at388MaBWWbC for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9C6E342096F
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id boimd-TwkEan for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7316642096E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 14:08:42 +0200 (CEST)
Date: Tue, 12 Jul 2016 14:08:42 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160712120842.GB29779@soda.linbit>
References: <CALLFrTQGkpOfP+41paPU2wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTQGkpOfP+41paPU2wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Failed to sync initially at different volume's size
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

On Tue, Jul 12, 2016 at 06:12:32PM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> Hello.
>=20
> After 4fe4c96 commit
> <http://git.drbd.org/drbd-9.0.git/commit/4fe4c962f41307c2db2846f18f5137=
082f339cd9>
> in
> DRBD9,
> If both volume's size is different, It is not going on progress sync
> initially, at  WFBitmapS/WFBitmapT

Hmpf. "Don't do that, then" ;-)

> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting -> Co=
nnected ) peer( Unknown -> Secondary )
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 450560
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 430080=
 u_size: 0 d_size: 430080 max_size: 430080
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 0 my_=
usize: 0
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx=
: 0 bm-uuid: 0x0 flags: 0x0 max_size: 430080 (DUnknown)
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling drbd_d=
etermine_dev_size()
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx=
: 0 bm-uuid: 0x0 flags: 0x0 max_size: 430080 (DUnknown)

Do it knows the max size,
but ignores it, ...

> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: drbd_sync_hand=
shake:
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self 000000000=
0000004:0000000000000000:0000000000000000:0000000000000000 bits:56320 fla=
gs:0
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer 000000000=
0000004:0000000000000000:0000000000000000:0000000000000000 bits:53760 fla=
gs:24
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=
=3D0 by rule 10
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: No resync, but 56320 b=
its in bitmap!
> Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown=
 -> Inconsistent ) repl( Off -> Established )

... because it double checks on repl_state, which is still L_OFF :-(

This should make it work:

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index c71607e..176f8bc 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -1534,7 +1534,11 @@ static bool get_max_agreeable_size(struct drbd_dev=
ice *device, uint64_t *max) __
 					peer_device->max_size,
 					drbd_disk_str(pdsk));
=20
-			if (peer_device->repl_state[NOW] >=3D L_ESTABLISHED) {
+			/* Note: in receive_sizes during connection handshake,
+			 * repl_state may still be L_OFF;
+			 * double check on cstate ... */
+			if (peer_device->repl_state[NOW] >=3D L_ESTABLISHED ||
+			    peer_device->connection->cstate[NOW] >=3D C_CONNECTED) {
 				/* If we still can see it, consider its last
 				 * known size, even if it may have meanwhile
 				 * detached from its disk.



--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT
