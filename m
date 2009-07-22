Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 16BCF101286B
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jul 2009 12:26:43 +0200 (CEST)
Resent-Message-ID: <20090722102642.GB8035@barkeeper1-xen.linbit>
Resent-Message-ID: <20090722101901.GA8035@barkeeper1-xen.linbit>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B2F2E1012A9E
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jul 2009 07:08:21 +0200 (CEST)
Date: Wed, 22 Jul 2009 14:59:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-Id: <20090722145917.055eddc1.sfr@canb.auug.org.au>
In-Reply-To: <20090721185156.GA10126@johann>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
	<20090720224940.36da1ef8.akpm@linux-foundation.org>
	<20090721185156.GA10126@johann>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__22_Jul_2009_14_59_17_+1000_s8u5PqXttceDOxyO"
Cc: Christoph Hellwig <hch@infradead.org>, Kyle Moffett <kyle@moffetthome.net>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@gmail.com>, Dave,
	linux-next@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
	Jens Axboe <jens.axboe@oracle.com>, Jones <davej@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/16] drbd: a block device for HA clusters
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Wed__22_Jul_2009_14_59_17_+1000_s8u5PqXttceDOxyO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On Tue, 21 Jul 2009 20:51:56 +0200 Lars Ellenberg <lars.ellenberg@linbit.co=
m> wrote:
>
> Stephen: expect an explicit linux-next merge request
> within the next few days.

OK, just to be clear your tree should be based on Linus' tree (or some
other *stable*, non rebasing, tree - *not* linux-next).

[I guess your tree will fulfill all the following]

What I tell everyone: all patches/commits in the tree/series must
have been:

	posted to a relevant mailing list
	reviewed
	unit tested
	destined for the next merge window (or the current release)

*before* they are included.  The linux-next tree is for integration
testing and to lower the impact of conflicts between subsystems in the
next merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Jul_2009_14_59_17_+1000_s8u5PqXttceDOxyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpmnKUACgkQjjKRsyhoI8ylEACdFd8fg00tm2I4X7PRZHncR502
c28AnRmbPP+Gx4guSTzafXJiwhLnoNSf
=W/NG
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Jul_2009_14_59_17_+1000_s8u5PqXttceDOxyO--
