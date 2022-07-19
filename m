Return-Path: <veggiemike@sourceruckus.org>
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
	[209.85.210.182])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8AA89420668
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2022 16:32:02 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id w185so13724580pfb.4
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2022 07:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220718203421.963-1-veggiemike@sourceruckus.org>
	<acd5b1c9-d770-8db9-45a0-c78051cc3f59@linbit.com>
In-Reply-To: <acd5b1c9-d770-8db9-45a0-c78051cc3f59@linbit.com>
From: Michael Labriola <veggiemike@sourceruckus.org>
Date: Tue, 19 Jul 2022 10:31:50 -0400
Message-ID: <CAA1fRFh1NbuJ-TYKXF3GX6XdDXbEQWmWZzx2-Q6eM9M_NfLKZQ@mail.gmail.com>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] compat: actually, bio_alloc now has 4 params
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jul 19, 2022 at 7:31 AM Christoph B=C3=B6hmwalder
<christoph.boehmwalder@linbit.com> wrote:
>
> Am 18.07.22 um 22:34 schrieb Michael D Labriola:
> > The original compat check for this got a bit wrapped around the axle.
> > Both bio_alloc() and bio_alloc_bioset() grew 2 more arguments.  All
> > the comments and filenames from b6d4d588597 say "bio_alloc has 5
> > params", but it was actually bio_alloc_bioset() that now has 5 params.
> > And the test takes the 5 params now required for bio_alloc_bioset()
> > and passed them into bio_alloc()... which causes the correct code for
> > 5.17 kernels to get patched back out erroneously.
> >
> > Signed-off-by: Michael D Labriola <veggiemike@sourceruckus.org>
> > ---
> >  ...no_has_5_params.cocci =3D> bio_alloc__no_has_4_params.cocci} | 0
> >  drbd/drbd-kernel-compat/gen_patch_names.c                     | 2 +-
> >  .../{bio_alloc_has_5_params.c =3D> bio_alloc_has_4_params.c}    | 4 ++=
--
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >  rename drbd/drbd-kernel-compat/cocci/{bio_alloc__no_has_5_params.cocci=
 =3D> bio_alloc__no_has_4_params.cocci} (100%)
> >  rename drbd/drbd-kernel-compat/tests/{bio_alloc_has_5_params.c =3D> bi=
o_alloc_has_4_params.c} (80%)
> >
> > diff --git a/drbd/drbd-kernel-compat/cocci/bio_alloc__no_has_5_params.c=
occi b/drbd/drbd-kernel-compat/cocci/bio_alloc__no_has_4_params.cocci
> > similarity index 100%
> > rename from drbd/drbd-kernel-compat/cocci/bio_alloc__no_has_5_params.co=
cci
> > rename to drbd/drbd-kernel-compat/cocci/bio_alloc__no_has_4_params.cocc=
i
> > diff --git a/drbd/drbd-kernel-compat/gen_patch_names.c b/drbd/drbd-kern=
el-compat/gen_patch_names.c
> > index e98c3d44..1074bb12 100644
> > --- a/drbd/drbd-kernel-compat/gen_patch_names.c
> > +++ b/drbd/drbd-kernel-compat/gen_patch_names.c
> > @@ -102,7 +102,7 @@ int main(int argc, char **argv)
> >  #endif
> >
> >       patch(1, "bio_alloc", true, false,
> > -           COMPAT_BIO_ALLOC_HAS_5_PARAMS, "has_5_params");
> > +           COMPAT_BIO_ALLOC_HAS_4_PARAMS, "has_4_params");
> >
> >  #if !defined(COMPAT_HAVE_BIO_SET_DEV)
> >       patch(1, "bio_set_dev", true, false,
> > diff --git a/drbd/drbd-kernel-compat/tests/bio_alloc_has_5_params.c b/d=
rbd/drbd-kernel-compat/tests/bio_alloc_has_4_params.c
> > similarity index 80%
> > rename from drbd/drbd-kernel-compat/tests/bio_alloc_has_5_params.c
> > rename to drbd/drbd-kernel-compat/tests/bio_alloc_has_4_params.c
> > index 1c28f049..6000e101 100644
> > --- a/drbd/drbd-kernel-compat/tests/bio_alloc_has_5_params.c
> > +++ b/drbd/drbd-kernel-compat/tests/bio_alloc_has_4_params.c
> > @@ -6,7 +6,7 @@
> >  #include <linux/bio.h>
> >
> >  struct bio *foo(struct block_device *bdev, unsigned short nr_vecs,
> > -             unsigned int opf, gfp_t gfp_mask, struct bio_set *bs)
> > +             unsigned int opf, gfp_t gfp_mask)
> >  {
> > -     return bio_alloc(bdev, nr_vecs, opf, gfp_mask, bs);
> > +     return bio_alloc(bdev, nr_vecs, opf, gfp_mask);
> >  }
>
> D'oh, seems like I indeed mixed those up.
> Good catch, thanks!
>
> Applied as https://github.com/LINBIT/drbd/commit/e47c64a35faeb9b080772b06=
8a5630976cb0754d
>
> I'm glad to have someone in the community to double-check my stuff :)

No problem.  Took longer to remember how to get git send-email to work
than it did to fix it.  ;-)

--
Michael D Labriola
401-316-9844 (cell)

>
> --
> Christoph B=C3=B6hmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA =E2=80=94  Disaster Recovery =E2=80=94 Software defined Storage
