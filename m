Return-Path: <firi@galatai.de>
Received: from www2.brainhall.org (www2.brainhall.org [193.34.68.92])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A6A610476FB
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2009 17:02:03 +0200 (CEST)
Received: from Asterix (HSI-KBW-078-043-034-193.hsi4.kabel-badenwuerttemberg.de
	[78.43.34.193])
	by www2.brainhall.org (Postfix) with ESMTP id 9C15F17C012
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2009 16:33:57 +0200 (CEST)
Date: Wed, 6 May 2009 16:33:55 +0200
From: Firi <firi@galatai.de>
Message-ID: <902001984.20090506163355@galatai.de>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] DRDB abd Xen
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi at All,

i installed a xen cluster as the following how to explain:

http://asplund.nu/xencluster/xen-cluster-howto.html

That works realy realy realy fine.

Now, in updated the from 3.2 to 3.3 and now he isnt able to
unterstand the disk port at the vps config.
The Error is: Block device must have pyh file or tap.....

What i mean is that part:

    disk =3D [
    'drbd:test-swap,xvda1,w',
    'drbd:test-disk,xvda2,w',
    ]

Is there any needed patch or something like this?
The xen version is installed from a Ubuntu Backport reposity.

Maybe anyone here is able to tell me more about that.


--=20
Mit freundlichen Gr=FC=DFen
Firi
mailto:firi@galatai.de


