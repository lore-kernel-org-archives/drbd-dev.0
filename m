Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 374A61028A59
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 13:35:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 22FCA3F4426
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 13:35:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FR8-wGEMDWew for <drbd-dev@lists.linbit.com>;
	Wed, 10 Jun 2015 13:35:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 045603F4425
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 13:35:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m4vVferGn-fO for <drbd-dev@lists.linbit.com>;
	Wed, 10 Jun 2015 13:35:15 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 454153F4424
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 13:35:15 +0200 (CEST)
Date: Wed, 10 Jun 2015 13:35:15 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150610113515.GC22714@soda.linbit>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 00/10] Zero out devices instead of initial
	full sync
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

On Wed, Jun 10, 2015 at 03:48:19PM +0800, Nick Wang wrote:
> Full sync for drbd initial usually take a long time, especically
> when network become the bottleneck the syncing. Simply skip the
> full sync with "--clear-bitmap" may not the perfect solution
> for all the cases. So this patches can be used to zero out=20
> devices locally instead of a full sync,two make consistent block=20
> device. This approach can be useful when lack of network bandwidth=20
> to sync.
>=20
> The patches add one new option "--zap-devices" to "new-current-uuid"=20
> to zero out devices. Besides the change of drbd, also need to modify=20
> drbd-utils for the flag.
>=20
> All patches are compiled/tested against SLES12.

Completely unnecessary.
Zero out the devices in userspace, then set up DRBD,
and skip the initial sync.

--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
