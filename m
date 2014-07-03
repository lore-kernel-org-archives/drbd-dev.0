Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 54C36101AC71
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4B0ED38C7C2
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:33:29 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qglRQcr4TdIW for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2CD89390705
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:33:29 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J1JiVbNn76on for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:33:29 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D407938C7C2
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:33:28 +0200 (CEST)
Date: Thu, 3 Jul 2014 15:33:28 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140703133328.GH11700@soda.linbit>
References: <201407021549.52105.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <201407021549.52105.mmazur@kernel.pl>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] ocf resource invoking non-existent 'syncer' command
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

On Wed, Jul 02, 2014 at 03:49:51PM +0200, Mariusz Mazur wrote:
> drbdadm's 'syncer' command was removed in 8.4. Yet=20
> thecreate_device_udev_settle() function in scripts/drbd.ocf still (as o=
f=20
> current git master branch) invokes it as have all the 8.4.x releases.
>=20
> (I'm surprised nobody encountered this before, 8.4.0 is three years old=
.)

That's because it is *intentional*
(backwards compatibility).

If you look there, that's in an elif branch.

Cheers,
	Lars

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
