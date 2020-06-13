Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E4324203FF
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:55 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id t18so12293880wru.6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:55 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	b19sm20966523wmj.0.2020.06.13.02.56.54
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:54 -0700 (PDT)
Resent-Message-ID: <20200613095652.GP4222@soda.linbit>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 083664203C1
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 20:35:12 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4CCE9206A5
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 18:29:31 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 188so341087lfa.10
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 11:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de>
	<20200508161517.252308-13-hch@lst.de>
In-Reply-To: <20200508161517.252308-13-hch@lst.de>
From: Song Liu <song@kernel.org>
Message-ID: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
	linux-raid <linux-raid@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>, linux-m68k@lists.linux-m68k.org,
	Philip Kelleher <pjk1939@linux.ibm.com>,
	linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 12/15] md: stop using ->queuedata
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
Date: Sat, 13 Jun 2020 10:02:45 -0000

On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the cleanup. IIUC, you want this go through md tree?

Otherwise,

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 271e8a5873549..c079ecf77c564 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -466,7 +466,7 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
>  {
>         const int rw = bio_data_dir(bio);
>         const int sgrp = op_stat_group(bio_op(bio));
> -       struct mddev *mddev = q->queuedata;
> +       struct mddev *mddev = bio->bi_disk->private_data;
>         unsigned int sectors;
>
>         if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
> @@ -5626,7 +5626,6 @@ static int md_alloc(dev_t dev, char *name)
>         mddev->queue = blk_alloc_queue(md_make_request, NUMA_NO_NODE);
>         if (!mddev->queue)
>                 goto abort;
> -       mddev->queue->queuedata = mddev;
>
>         blk_set_stacking_limits(&mddev->queue->limits);
>
> --
> 2.26.2
>
