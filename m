Return-Path: <philipp.reisner@linbit.com>
Received: from [10.9.9.50] (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F2F2142F9
	for <drbd-dev@lists.linbit.com>; Tue,  1 Feb 2005 18:34:55 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1743 - in branches/drbd-0.7: . drbd
Date: Tue, 1 Feb 2005 18:36:43 +0100
References: <20050131111921.EE6F83BE6D@garcon.linbit.com>
	<20050201164820.GL7628@marowsky-bree.de>
In-Reply-To: <20050201164820.GL7628@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200502011836.43449.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 1. Februar 2005 17:48 schrieb Lars Marowsky-Bree:
> On 2005-01-31T12:19:21, svn@svn.drbd.org wrote:
> > Modified:
> >    branches/drbd-0.7/ChangeLog
> >    branches/drbd-0.7/drbd.spec.in
> >    branches/drbd-0.7/drbd/drbd_actlog.c
> >    branches/drbd-0.7/drbd/drbd_compat_wrappers.h
> > Log:
> > No longer leak of BIOs.
>
> Good goal, but ...
>
> > Modified: branches/drbd-0.7/drbd/drbd_actlog.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- branches/drbd-0.7/drbd/drbd_actlog.c 2005-01-31 09:20:39 UTC (rev
> > 1742) +++ branches/drbd-0.7/drbd/drbd_actlog.c 2005-01-31 11:19:19 UTC
> > (rev 1743) @@ -68,8 +68,6 @@
> >   struct completion event;
> >   int ok;
> >
> > - bio_get(bio);
> > -
> >   bio->bi_bdev =3D mdev->md_bdev;
> >   bio->bi_sector =3D sector;
> >   bio_add_page(bio, page, size, 0);
>
> I think this is a bug. If you look at the comments in
> linux/include/linux/bio.h, you'll find that this is just how the bio is
> supposed to be used:
>
> /*
>  * get a reference to a bio, so it won't disappear. the intended use is
>  * something like:
>  *
>  * bio_get(bio);
>  * submit_bio(rw, bio);
>  * if (bio->bi_flags ...)
>  *      do_something
>  * bio_put(bio);
>  *
>  * without the bio_get(), it could potentially complete I/O before
> submit_bio * returns. and then bio would be freed memory when if
> (bio->bi_flags ...) * runs
>  */
> #define bio_get(bio)    atomic_inc(&(bio)->bi_cnt)
>
> The fix I did was not the right way (removing the bio embedding was much
> better), but it also wasn't completely wrong.
>

I did not look at the comments, I read the code. And what I read there was:
a BIO has after bio_init() a refcount (bi_cnt) of 1. It is freed when the=20
refcount drops to zero.=20

bio_alloc();
do something with it
bio_put();

is right.

What you did is:

bio_alloc();
bio_get();   // increase to 2
bio_put();   // decreat to 1

and let it live forever...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
