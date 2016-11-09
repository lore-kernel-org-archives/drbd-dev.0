Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 418E91056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 16:32:10 +0100 (CET)
Date: Wed, 9 Nov 2016 16:32:09 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20161109153209.GK1382@soda.linbit>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
	<497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
	<20161108165204.GC2834@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20161108165204.GC2834@kernel.dk>
Content-Transfer-Encoding: quoted-printable
Cc: wolfgang.glas@iteg.at, Richard Weinberger <richard@nod.at>,
	christoph.lechleitner@iteg.at, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, philipp.reisner@linbit.com,
	viro@zeniv.linux.org.uk, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
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

On Tue, Nov 08, 2016 at 09:52:04AM -0700, Jens Axboe wrote:
> > > This should go into 4.9,
> > > and into all stable branches since and including v4.0,
> > > which is the first to contain the exposing change.
> > >=20
> > > It is correct for all stable branches older than that as well
> > > (which contain the DRBD driver; which is 2.6.33 and up).
> > >=20
> > > It requires a small "conflict" resolution for v4.4 and earlier, wit=
h v4.5
> > > we dropped the comment block immediately preceding the kernel_sendm=
sg().
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Cc: viro@zeniv.linux.org.uk
> > > Cc: christoph.lechleitner@iteg.at
> > > Cc: wolfgang.glas@iteg.at
> > > Reported-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> > > Tested-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> >=20
> > Changing my patch is perfectly fine, but please clearly state it.
> > I.e. by adding something like that before your S-o-b.
> > [Lars: Massaged patch to match my personal taste...]
>=20

> Lars, are you sending a new one? If you do, add the stable tag as well.

So my "change" against his original patch was
- rv =3D kernel_sendmsg(sock, &msg, &iov, 1, size - sent);
+ rv =3D kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);
to make it "more obviously correct" from looking just at the one line
without even having to read the context.  And a more verbose commit messa=
ge.

If that requires yet additional noise, sure, so be it :)

Should I sent two patches, one that applies to 4.5 and later,
and one that applies to 2.6.33 ... 4.4, or are you or stable
willing to resolve the trivial "missing comment block" conflict yourself?

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
