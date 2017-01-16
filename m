Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 05EE2105645E
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B2C1548760A
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id GldjLGqgrp8a for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9248248760B
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KRz5JL5efFKY for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5A63548760A
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jan 2017 11:35:03 +0100 (CET)
Date: Mon, 16 Jan 2017 11:35:02 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170116103502.GF9172@soda.linbit>
References: <1484288158-25952-1-git-send-email-nwang@suse.com>
	<20170113110345.GA9172@soda.linbit>
	<F749D893-B652-4BA8-AA15-AD88344EE2F9@acsalaska.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F749D893-B652-4BA8-AA15-AD88344EE2F9@acsalaska.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Fix the default node id
 initialization when upgrade v8 to v9
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

On Fri, Jan 13, 2017 at 10:01:50AM -0900, David M. Syzdek wrote:
>=20
>=20
> > On Jan 13, 2017, at 2:03 AM, Lars Ellenberg <lars.ellenberg@linbit.co=
m> wrote:
> >=20
> > On Fri, Jan 13, 2017 at 02:15:58PM +0800, Nick Wang wrote:
> >> Node id will be initialized as "0" in md_convert_08_to_09() when upg=
rading to drbd9=20
> >> (still using two nodes without changing configuration like expliciti=
ng set the node id).=20
> >=20
> > With DRBD 9, you *have* to set the node id in the configuration.
> > If there is a way around that, we need to fix it.
>=20
> If by configuration, you are referring the .res resource file, then
> this may be the intention, however this is not currently the case.  I
> am able to initialize a new resource on two peers using the following
> config without using the =E2=80=99node-id=E2=80=99 directives:

Yes, I forgot, if we find a two-node-only 8 compat config,
we sort the IP addresses (or something),
and use that to implicitly assign node-id.

works for most "simple" setups,
may break for more interesting ones
(IPs look different depending on node)

> > Also, IMO, in virtually all 8 -> 9 upgrade scenarios, you are better =
off
> > creating new DRBD 9 meta data instead of trying to "convert=E2=80=9D.
>=20
> Is there a technical reason

There are two basic scenarios, "rolling" upgrade,
and "stop, replace, and restart the world".=20

"stop the world" obviously means downtime.
But for the "rolling" upgrade,
you need more steps and at least a switchover,
which typically also implies a downtime.

My preferred upgrade procedure would be "replace the world"
 * make sure all data is "stable" and in sync
 * stop all services (yes, that means a short down time)
 * upgrade modules
 * recreate meta data, and prepare to skip the initial sync,
   because we know everything is in sync (see first step)
   potentially allocating more bitmap slots in preparation for N > 2.
 * bring it all online.

If that is not acceptable, or you think the rolling upgrade incurs less
service interruption, you go with the "upgrade meta data in place"
procedure, and hope we got that right :-)

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT
