Return-Path: <philipp.reisner@linbit.com>
Received: from [10.9.9.50] (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5883D151AB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2005 11:38:27 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch] avoid long long division in _hash_fn
Date: Tue, 22 Feb 2005 11:38:36 +0100
References: <20050221171110.GN7016@marowsky-bree.de>
In-Reply-To: <20050221171110.GN7016@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200502221138.36850.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 21. Februar 2005 18:11 schrieb Lars Marowsky-Bree:
> sector_t might be 64 bit, but long long divisions aren't supported in
> kernel space in i386. This patch adds a straightforward cast to avoid an
> unresolved symbol for __umoddi3.
>
> Index: drbd/drbd_main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drbd/drbd_main.c    (revision 1763)
> +++ drbd/drbd_main.c    (working copy)
> @@ -164,7 +164,7 @@
>
>  STATIC unsigned int tl_hash_fn(drbd_dev *mdev, sector_t sector)
>  {
> -       return (sector>>HT_SHIFT) % mdev->tl_hash_s;
> +       return (unsigned int)(sector>>HT_SHIFT) % mdev->tl_hash_s;
>  }
>
>
> @@ -367,7 +367,7 @@
>
>  STATIC unsigned int ee_hash_fn(drbd_dev *mdev, sector_t sector)
>  {
> -       return (sector>>HT_SHIFT) % mdev->ee_hash_s;
> +       return (unsigned int)(sector>>HT_SHIFT) % mdev->ee_hash_s;
>  }
>
>  STATIC int overlaps(sector_t s1, int l1, sector_t s2, int l2)
>
>
> Sincerely,
>     Lars Marowsky-Br=E9e <lmb@suse.de>

Both patches found their way into SVN...

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
