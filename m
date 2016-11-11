Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7321D1056471
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2016 10:48:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3984F2AD767
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2016 10:48:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 80KjEs-z766L for <drbd-dev@lists.linbit.com>;
	Mon, 14 Nov 2016 10:48:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 183EB48617D
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2016 10:48:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yhxGLoiF2rfk for <drbd-dev@lists.linbit.com>;
	Mon, 14 Nov 2016 10:48:39 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E67F42AD767
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2016 10:48:38 +0100 (CET)
Resent-Message-ID: <20161114094838.GV1382@soda.linbit>
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de
	[141.84.225.229])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C1181056469
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2016 18:53:32 +0100 (CET)
From: Wolfgang Walter <linux@stwm.de>
To: drbd-dev@lists.linbit.com
Date: Fri, 11 Nov 2016 18:45:18 +0100
Message-ID: <6098334.rfGYZxPirJ@stwm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] DRBD: ASSERT in drbd_actlog.c:259
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

Hello,

when I execute

mkfs.ext4 -J device=3DUUID=3D625d871f-c278-4acb-916d-774dc78dbd8a -v -b=
 4096 -E stride=3D$((512/4)),stripe_width=3D$((512/4*3)),lazy_itable_in=
it=3D0 -O inline_data,mmp -L dyn -m .01 /dev/test/big

the command hangs and the kernel (4.4.30) complains:

block drbd1: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259
block drbd2: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259
block drbd1: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259
block drbd3: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259
block drbd2: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259
block drbd3: ASSERT( (unsigned)(last - first) <=3D 1 ) in drivers/block=
/drbd/drbd_actlog.c:259

This does _not_ happen if I use

mkfs.ext4 -J device=3DUUID=3D625d871f-c278-4acb-916d-774dc78dbd8a -v -b=
 4096 -E stride=3D$((512/4)),stripe_width=3D$((512/4*3)),lazy_itable_in=
it=3D0, nodiscard -O inline_data,mmp -L dyn -m .01 /dev/export/dyn

drbd1, drbd2 and drbd3 are three volumes of one resource. These three d=
rbd devices are physical volumes of a volume group test with an LV big.=
 test/big uses drbd1 ... drbd3 as backing devices (striped; stripesize =
ist 512k.


Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
