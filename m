Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E4CA410556BC
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DF60344A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T0rEeNmUpVWf for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BFB65449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cB3DRjGQy_fh for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 95C63444287
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Resent-Message-ID: <20150507093542.GW18767@soda.linbit>
MIME-Version: 1.0
In-Reply-To: <5547241B.1040903@kernel.org>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-8-git-send-email-mlin@kernel.org>
	<20150429080919.342fddfd@notabene.brown>
	<5547241B.1040903@kernel.org>
Date: Wed, 6 May 2015 00:10:24 -0700
Message-ID: <CAF1ivSZ0fA9RPQ6VrQSUveQjYjM1UXt_28Vod9RiH16jqnBn6A@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Ming Lin <mlin@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Alex Elder <elder@kernel.org>, Sage Weil <sage@inktank.com>,
	Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
	Yehuda Sadeh <yehuda@inktank.com>, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@gmail.com>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 07/10] block: kill merge_bvec_fn() completely
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

On Mon, May 4, 2015 at 12:47 AM, Ming Lin <mlin@kernel.org> wrote:
> On 04/28/2015 03:09 PM, NeilBrown wrote:
>> On Mon, 27 Apr 2015 23:48:34 -0700 Ming Lin <mlin@kernel.org> wrote:
>>
>>> From: Kent Overstreet <kent.overstreet@gmail.com>
>>>
>>> As generic_make_request() is now able to handle arbitrarily sized bios,
>>> it's no longer necessary for each individual block driver to define its
>>> own ->merge_bvec_fn() callback. Remove every invocation completely.
>>
>> This patch it just a little premature I think.
>>
>> md/raid5 still assumes read requests will mostly fit within a single chunk
>> (which merge_bvec_fn encourages) so they can be serviced without using the
>> stripe-cache.
>> You've just broken that assumption.
>>
>> I think 'chunk_aligned_read' needs to get a loop using bio_split, a bit like
>> raid0, first.
>
> How about below?

Hi NeilBrown,

Are you OK with below fix?
Then I'll include it in the next version.

Thanks.

>
>  drivers/md/raid5.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index e42b624..2ddfa1e 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -4709,7 +4709,7 @@ static void raid5_align_endio(struct bio *bi, int error)
>         add_bio_to_retry(raid_bi, conf);
>  }
>
> -static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
> +static int __chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
>  {
>         struct r5conf *conf = mddev->private;
>         int dd_idx;
> @@ -4718,7 +4718,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
>         sector_t end_sector;
>
>         if (!in_chunk_boundary(mddev, raid_bio)) {
> -               pr_debug("chunk_aligned_read : non aligned\n");
> +               pr_debug("__chunk_aligned_read : non aligned\n");
>                 return 0;
>         }
>         /*
> @@ -4793,6 +4793,35 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
>         }
>  }
>
> +static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
> +{
> +       struct bio *split;
> +
> +       do {
> +               sector_t sector = raid_bio->bi_iter.bi_sector;
> +               unsigned chunk_sects = mddev->chunk_sectors;
> +
> +               unsigned sectors = chunk_sects -
> +                       (likely(is_power_of_2(chunk_sects))
> +                        ? (sector & (chunk_sects-1))
> +                        : sector_div(sector, chunk_sects));
> +
> +               if (sectors < bio_sectors(raid_bio)) {
> +                       split = bio_split(raid_bio, sectors, GFP_NOIO, fs_bio_set);
> +                       bio_chain(split, raid_bio);
> +               } else
> +                       split = raid_bio;
> +
> +               if (!__chunk_aligned_read(mddev, split)) {
> +                       if (split != raid_bio)
> +                               generic_make_request(raid_bio);
> +                       return split;
> +               }
> +       } while (split != raid_bio);
> +
> +       return NULL;
> +}
> +
>  /* __get_priority_stripe - get the next stripe to process
>   *
>   * Full stripe writes are allowed to pass preread active stripes up until
> @@ -5071,7 +5100,7 @@ static void make_request(struct mddev *mddev, struct bio * bi)
>          */
>         if (rw == READ && mddev->degraded == 0 &&
>              mddev->reshape_position == MaxSector &&
> -            chunk_aligned_read(mddev,bi))
> +            (!(bi = chunk_aligned_read(mddev, bi))))
>                 return;
>
>         if (unlikely(bi->bi_rw & REQ_DISCARD)) {
