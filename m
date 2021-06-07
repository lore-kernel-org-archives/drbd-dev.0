Return-Path: <dan.j.williams@intel.com>
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
	[209.85.216.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4D2F6420210
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jun 2021 06:43:15 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
	m13-20020a17090b068db02901656cc93a75so11109224pjz.3
	for <drbd-dev@lists.linbit.com>; Sun, 06 Jun 2021 21:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de>
	<20210521055116.1053587-18-hch@lst.de>
In-Reply-To: <20210521055116.1053587-18-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 6 Jun 2021 21:43:03 -0700
Message-ID: <CAPcyv4gFEbZH4sXbkvQ32Xv1HiZ6JPL04efGpAWCqaJP_X9jaA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, nvdimm@lists.linux.dev,
	Ulf Hansson <ulf.hansson@linaro.org>, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	linux-bcache@vger.kernel.org, Joshua Morris <josh.h.morris@us.ibm.com>,
	drbd-dev@lists.linbit.com, linux-s390 <linux-s390@vger.kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matias Bjorling <mb@lightnvm.io>, Nitin Gupta <ngupta@vflare.org>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-xtensa@linux-xtensa.org,
	Alex Dubov <oakad@yahoo.com>, Heiko Carstens <hca@linux.ibm.com>,
	Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	linux-raid <linux-raid@vger.kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-mmc@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Drbd-dev] [PATCH 17/26] nvdimm-pmem: convert to
	blk_alloc_disk/blk_cleanup_disk
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

[ add Sachin who reported this commit in -next ]

On Thu, May 20, 2021 at 10:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Convert the nvdimm-pmem driver to use the blk_alloc_disk and
> blk_cleanup_disk helpers to simplify gendisk and request_queue
> allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 968b8483c763..9fcd05084564 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,7 +338,7 @@ static void pmem_pagemap_cleanup(struct dev_pagemap *pgmap)
>         struct request_queue *q =
>                 container_of(pgmap->ref, struct request_queue, q_usage_counter);
>
> -       blk_cleanup_queue(q);
> +       blk_cleanup_disk(queue_to_disk(q));

This is broken. This comes after del_gendisk() which means the queue
device is no longer associated with its disk parent. Perhaps @pmem
could be stashed in pgmap->owner and then this can use pmem->disk? Not
see any other readily available ways to get back to the disk from here
after del_gendisk().
