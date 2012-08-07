Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A009E1055F5C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 99B1C1B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:24 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAkxVkVD6BS9 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:24 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 79D961B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:24 +0200 (CEST)
Resent-Message-ID: <20120810203324.GS31190@soda.linbit>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 28C92100542F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 05:23:29 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so1900996wib.15
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2012 20:23:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343160689-12378-13-git-send-email-koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-13-git-send-email-koverstreet@google.com>
Date: Mon, 6 Aug 2012 20:17:58 -0700
Message-ID: <CAFR8ued4XmZUAL9RVnmdSspRom14u6rCZmhohJGChPqwfPOdfQ@mail.gmail.com>
From: Muthu Kumar <muthu.lkml@gmail.com>
To: Kent Overstreet <koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 12/12] block: Only clone bio vecs that are
	in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

On Tue, Jul 24, 2012 at 1:11 PM, Kent Overstreet <koverstreet@google.com> wrote:
> bcache creates large bios internally, and then splits them according to
> the device requirements before it sends them down. If a lower level
> device tries to clone the bio, and the original bio had more than
> BIO_MAX_PAGES, the clone will fail unecessarily.
>
> We can fix this by only cloning the bio vecs that are actually in use.
>
> Signed-off-by: Kent Overstreet <koverstreet@google.com>

<snip>

>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3f3c26e..193fb19 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1057,11 +1057,10 @@ static struct bio *clone_bio(struct bio *bio, sector_t sector,
>  {
>         struct bio *clone;
>
> -       clone = bio_alloc_bioset(GFP_NOIO, bio->bi_max_vecs, bs);
> +       clone = bio_alloc_bioset(GFP_NOIO, bv_count, bs);

Number of io_vecs allocated in clone is different. Please see my comment below.

>         __bio_clone(clone, bio);
>         clone->bi_sector = sector;
> -       clone->bi_idx = idx;
> -       clone->bi_vcnt = idx + bv_count;
> +       clone->bi_vcnt = bv_count;
>         clone->bi_size = to_bytes(len);
>         clone->bi_flags &= ~(1 << BIO_SEG_VALID);
>
> diff --git a/fs/bio.c b/fs/bio.c
> index 7a0801d..ec6a357 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -451,8 +451,9 @@ EXPORT_SYMBOL(bio_phys_segments);
>   */
>  void __bio_clone(struct bio *bio, struct bio *bio_src)
>  {
> -       memcpy(bio->bi_io_vec, bio_src->bi_io_vec,
> -               bio_src->bi_max_vecs * sizeof(struct bio_vec));
> +       memcpy(bio->bi_io_vec,
> +              bio_iovec(bio_src),
> +              bio_segments(bio_src) * sizeof(struct bio_vec));
>


You are changing the meaning of __bio_clone() here. In old code, the
number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
bi_iovec[0] and also restricting the number of allocated io_vecs of
the clone. It may be useful for cases were we would like a identical
copy of the original bio (may not be in current code base, but this
implementation is definitely not what one would expect from the name
"clone").

May be, call this new implementation some thing else (and use it for bcache)?

Regards,
Muthu



>         /*
>          * most users will be overriding ->bi_bdev with a new target,
> @@ -461,10 +462,10 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
>         bio->bi_sector = bio_src->bi_sector;
>         bio->bi_bdev = bio_src->bi_bdev;
>         bio->bi_flags |= 1 << BIO_CLONED;
> +       bio->bi_flags &= ~(1 << BIO_SEG_VALID);
>         bio->bi_rw = bio_src->bi_rw;
> -       bio->bi_vcnt = bio_src->bi_vcnt;
> +       bio->bi_vcnt = bio_segments(bio_src);
>         bio->bi_size = bio_src->bi_size;
> -       bio->bi_idx = bio_src->bi_idx;
>  }
>  EXPORT_SYMBOL(__bio_clone);
>
> @@ -479,7 +480,7 @@ EXPORT_SYMBOL(__bio_clone);
>  struct bio *bio_clone_bioset(struct bio *bio, gfp_t gfp_mask,
>                              struct bio_set *bs)
>  {
> -       struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, bs);
> +       struct bio *b = bio_alloc_bioset(gfp_mask, bio_segments(bio), bs);
>
>         if (!b)
>                 return NULL;
> @@ -509,7 +510,7 @@ EXPORT_SYMBOL(bio_clone);
>
>  struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
>  {
> -       struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);
> +       struct bio *b = bio_kmalloc(gfp_mask, bio_segments(bio));
>
>         if (!b)
>                 return NULL;
> --
> 1.7.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
