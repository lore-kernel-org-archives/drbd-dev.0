Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 54D271055707
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4FC81449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HVQDSWABL7By for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 33BBF44A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T4IswBVgKtYb for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:45 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E8492449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:44 +0200 (CEST)
Resent-Message-ID: <20150507093544.GZ18767@soda.linbit>
MIME-Version: 1.0
In-Reply-To: <20150506072637.GB23083@lst.de>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-8-git-send-email-mlin@kernel.org>
	<20150429080919.342fddfd@notabene.brown>
	<5547241B.1040903@kernel.org> <20150506072637.GB23083@lst.de>
Date: Wed, 6 May 2015 10:05:09 -0700
Message-ID: <CAF1ivSaSAqfG3-U37T5U3a7_L4q-PD7Mw980K51CqzrtXx8CGA@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Alex Elder <elder@kernel.org>, Sage Weil <sage@inktank.com>,
	Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>, ceph-devel@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	Alasdair Kergon <agk@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lin <mlin@kernel.org>, drbd-user@lists.linbit.com,
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

On Wed, May 6, 2015 at 12:26 AM, Christoph Hellwig <hch@lst.de> wrote:
>> -static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
>> +static int __chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
>
> Call it raid5_read_one_chunk or something similar descriptive?
>
>>  {
>>       struct r5conf *conf = mddev->private;
>>       int dd_idx;
>> @@ -4718,7 +4718,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
>>       sector_t end_sector;
>>
>>       if (!in_chunk_boundary(mddev, raid_bio)) {
>> -             pr_debug("chunk_aligned_read : non aligned\n");
>> +             pr_debug("__chunk_aligned_read : non aligned\n");
>
> Switch to __func__?
>
>> +static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
>> +{
>> +     struct bio *split;
>> +
>> +     do {
>> +             sector_t sector = raid_bio->bi_iter.bi_sector;
>> +             unsigned chunk_sects = mddev->chunk_sectors;
>> +
>> +             unsigned sectors = chunk_sects -
>> +                     (likely(is_power_of_2(chunk_sects))
>> +                      ? (sector & (chunk_sects-1))
>> +                      : sector_div(sector, chunk_sects));
>
> This would be a lot more readable with a good old if.
>
>>       if (rw == READ && mddev->degraded == 0 &&
>>            mddev->reshape_position == MaxSector &&
>> -          chunk_aligned_read(mddev,bi))
>> +          (!(bi = chunk_aligned_read(mddev, bi))))
>>               return;
>
>         if (rw == READ && mddev->degraded == 0 &&
>             mddev->reshape_position == MaxSector) {
>                 bi = chunk_aligned_read(mddev, bi);
>                 if (!bi)
>                         return;
>         }

Will update all. Thanks.
