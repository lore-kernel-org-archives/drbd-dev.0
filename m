Return-Path: <Simon.Graham@stratus.com>
Received: from mailhub4.stratus.com (mailhub4.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 441C81432B97
	for <drbd-dev@lists.linbit.com>; Tue,  3 Nov 2009 13:40:50 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 3 Nov 2009 07:40:44 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9390DAC@EXHQ.corp.stratus.com>
In-Reply-To: 20091103111355.GA12242@barkeeper1-xen.linbit
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com><BC2F8964429F14468EA0E6D6CF00E8C9390DA7@EXHQ.corp.strat
	us.com> 20091103111355.GA12242@barkeeper1-xen.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>=20
> No.
> The correct fix for your problem probably is not only this,
> but some addition to the "exposed data uuid" stuff as well.
>=20
> Because it is Primary, there may be cached pages,
> file system and applications usually have a rough idea
> what data they expect to live where.
>=20
> What this is supposed to do is avoid a timewarp into stale data,
> if you lose network first, hum along for hours,
> and then lose the disk as well.
>=20
> Or vice versa.
>=20
> You are then only allowed to attach or connect to the
> data you had last access to, not to the other set,
> as the other set would mean a time warp into stale data.
>=20

Good point -- if you lose the network first then I agree. However, if
you lose the primary side disk first then I don't think you can hit this
'time warp'.

My first thought when looking at this was to NOT attempt to update the
current UUID on the Primary if it is diskless when you lose the
connection - however, this doesn't work in the specific case that caused
us to see this problem -- in that case, we had a DRBD device sitting on
a physical disk which had actually gone bad; however, we didn't see this
until we tried to write the meta-data with the updated UUID when we lost
the network connection...

Maybe we just need to back out the UUID update if you cant flush it to
disk...

Simon
