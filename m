Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 884DB1056423
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7813E3EA225
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EAl5hRiSUn8f for <drbd-dev@lists.linbit.com>;
	Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5CC7C3EA2BA
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aGZ3nXWX0Ovn for <drbd-dev@lists.linbit.com>;
	Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 18C343EA225
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2016 14:37:32 +0100 (CET)
Date: Wed, 9 Mar 2016 14:37:30 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160309133730.GV17669@soda.linbit>
References: <CAF6H8oH2bWZBWQYL3ei9MuS4sXCVML5r3j_yfDutU7jo129DmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAF6H8oH2bWZBWQYL3ei9MuS4sXCVML5r3j_yfDutU7jo129DmQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [CASE-28] Pause-SyncS color?
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

On Wed, Mar 02, 2016 at 06:30:17PM +0900, Jaeheon Kim wrote:
> Hi,
>=20
> It's trivial.
>=20
> On CLI, Pause-SyncT is red color but Pause-SyncS is none.
> We think L_PAUSED_SYNC_S is  COLOR_BAD, maybe.
> Please check drbd-utils/user/v9/drbdsetup_colors.c

If I'm the source of a resync,
then my data is apparently good enough
to be a source of resync.
That's not bad, is it?

besides, who cares.
colorization was only a nice prove-of-concept, actually.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
