Return-Path: <Simon.Graham@stratus.com>
Received: from mailhub4.stratus.com (mailhub4.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5A2FF1072EB9
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jan 2010 16:03:21 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 7 Jan 2010 10:02:43 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C93915A6@EXHQ.corp.stratus.com>
In-Reply-To: 20100106113556.GZ23877@barkeeper1-xen.linbit
References: <BC2F8964429F14468EA0E6D6CF00E8C969FBEF@EXHQ.corp.stratus.com>
	20100106113556.GZ23877@barkeeper1-xen.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] syncsource -> sync completed ack lost
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> bounces@lists.linbit.com] On Behalf Of Lars Ellenberg
> > This is on drbd 8.2.7. The sync target was recently outdarted and
> > resynced
>=20
> please go to 8.3 branch.
> 8.2 is obsolete.
>=20
> if you can reproduce with 8.3,
> we will certainly look into this.
>

Whilst I understand your desire to move on and only support 8.3, you
must understand that products using DRBD internally cannot move
instantly to a new release - not only do we have to integrate and
thoroughly test the new release before shipping it to customers, we also
have an installed base that we need to support and fix bugs for.

Obviously it's our problem to do this but some help locating the issues
would be appreciated.

> but I think we fix a few things that would match your symptoms in 8.3.

If you could give some hints as to what was fixed that would be helpful.

BTW: it's not even very easy to move to 8.3 internally to see if the
problem has been fixed for a couple of reasons:

1. Changes in the build in 8.3 have made it hard to build from git - I
don't know all the
   details but there are issues with the autoconf stuff when building
from git that cause
   the RPM build to fail.

2. These problems are very hard to reproduce - we need to work hard to
debug from available
   data when they occur because we don't have the luxury of reproducing
easily.

Simon
