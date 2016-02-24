Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C86D9104B1A2
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BBBAA3E7FD7
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X1QPgeTnHHCR for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9C23F3E83BC
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uheXdkMu3N_g for <drbd-dev@lists.linbit.com>;
	Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7207A3E7FD7
	for <drbd-dev@lists.linbit.com>; Wed, 24 Feb 2016 15:17:39 +0100 (CET)
Date: Wed, 24 Feb 2016 15:17:39 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160224141738.GI17669@soda.linbit>
References: <CAF6H8oFkGOr-=Uej1fR5JZxh47UPNzF-Dc2Va4p6ZpUcmwip6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6H8oFkGOr-=Uej1fR5JZxh47UPNzF-Dc2Va4p6ZpUcmwip6A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [CASE-24] Does replication have to wait until the
 end of handler service?
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

On Wed, Feb 24, 2016 at 04:04:11PM +0900, =EA=B9=80=EC=9E=AC=ED=97=8C wro=
te:
> Hi,
>=20
> Conf:
>  - A(Async) or C(sync) replication mode
>  - setup before-resync-source( this handler sleeps just 1 minute)
>=20
> Test:
>  - 1) Big file copy
>  - 2) During copy,disconnect and connect
>  - 3) before-resync-source handler called
>  - 4) At this point copy operation is pending until handler finished.
>=20
> Is it normal operation?

The before-resync handlers can return an exit code !=3D 0 (and !=3D 3,
for hysterical reasons), and will cause the connection to be dropped
(and nothing to be resynced or changed).

So yes, the resync has to wait for that exit code.

What would you want to do from there?

Also, if you think that is useful,
you can do the equivalent of "nohup some-long-running-script & exit 0"...
But I fail to see the usecase.


--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.
