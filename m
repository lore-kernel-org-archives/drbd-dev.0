Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 547CD1056469
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jul 2016 18:27:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4ABDA429C32
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jul 2016 18:27:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id u2hkonuwkWoB for <drbd-dev@lists.linbit.com>;
	Mon, 11 Jul 2016 18:27:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0DC4C429C37
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jul 2016 18:27:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i3kOTUGDlZZs for <drbd-dev@lists.linbit.com>;
	Mon, 11 Jul 2016 18:27:34 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DB4DD429C32
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jul 2016 18:27:34 +0200 (CEST)
Date: Mon, 11 Jul 2016 18:27:34 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160711162734.GC13335@soda.linbit>
References: <B7D370631C221640AE09F705C57A14F37329FAF0@W2K050.campus.gsi.de>
	<B7D370631C221640AE09F705C57A14F3732A0E50@W2K050.campus.gsi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <B7D370631C221640AE09F705C57A14F3732A0E50@W2K050.campus.gsi.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] drbd.ocf: drbdsetup v9 has no sh-status
 command
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

On Fri, Jul 08, 2016 at 11:26:52AM +0000, Miedzik, Piotr Bogdan wrote:
> I've found mistake in drbd.ocf in line 1045 anyway.
> Kernel module version should be checked in opposite order.

That's not the only thing missing wrt drbd 9 and pacemaker integration.

I have some unfinished work around, which eventually will find its way
into the repositories and packages "soon".

But for now, it's unfinished :-|

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
