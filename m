Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 02A671432C
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2005 09:56:14 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch] __bio_clone() behaviour
Date: Thu, 27 Jan 2005 09:56:16 +0100
References: <20050126164612.GH5511@marowsky-bree.de>
In-Reply-To: <20050126164612.GH5511@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501270956.16709.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 26. Januar 2005 17:46 schrieb Lars Marowsky-Bree:
> With the __bio_clone() bugfix by Jens Axboe (in the recent 2.6.10-ac
> kernels or SLES9 SP1) which causes __bio_clone() to copy the bi_io_vec,
> it would always try to copy the _maximum_ size, as defined by
> bio_src->bi_max_vecs:
>
> inline void __bio_clone(struct bio *bio, struct bio *bio_src)
> {
>         request_queue_t *q =3D bdev_get_queue(bio_src->bi_bdev);
>         memcpy(bio->bi_io_vec, bio_src->bi_io_vec, bio_src->bi_max_vecs *
> sizeof(struct bio_vec)); ...
>
> drbd however only has space for a single iovec (because it's all
> statically allocated right now), and so the memcpy would silently
> overwrite memory.
>
> The attached patch 'fixes' this up.
>
> Note that it is a bit ugly but safe, as drbd already asserts that
> bi_vcnt =3D=3D 1 anyway.
>
> FWIW, drbd seems to be the only user of __bio_clone() I could find,
> there's no in-tree users, everything goes through bio_clone() otherwise,
> which would have dynamically allocated the properly sized structures.
>

This really gives me the feeling that I should not have done the=20
0.7.9 release. --- The only one to blame is myself, who thought it=20
would be a nice idea to have the same release as SUSE.
Bullshit -> The next release will only happen when I am convinced
that the new release is necessary, and that it will not be a=20
disaster.


BTW, regarind this patch: We now modify someone else's BIO.=20
     Is this a good idea ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
