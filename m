Return-Path: <BATV+04e4e05a438ac94c6a9b+6987+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C6A8420319
	for <drbd-dev@lists.linbit.com>; Mon, 10 Oct 2022 10:50:25 +0200 (CEST)
Date: Mon, 10 Oct 2022 00:59:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Message-ID: <Y0PQxdzmMzAAW0KF@infradead.org>
References: <20221005050027.39591-1-kch@nvidia.com>
	<20221005050027.39591-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005050027.39591-2-kch@nvidia.com>
Cc: vincent.fu@samsung.com, vigneshr@ti.com, philipp.reisner@linbit.com,
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
	jinpu.wang@ionos.com, tim@cyberelk.net,
	drbd-dev@lists.linbit.com, bvanassche@acm.org, richard@nod.at,
	damien.lemoal@opensource.wdc.com, shinichiro.kawasaki@wdc.com,
	ogeert@linux-m68k.org, josef@toxicpanda.com, efremov@linux.com,
	nbd@other.debian.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, hare@suse.de,
	ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, mcgrof@kernel.org,
	haris.iqbal@ionos.com, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 01/18] block: add and use init disk helper
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

On Tue, Oct 04, 2022 at 10:00:10PM -0700, Chaitanya Kulkarni wrote:
> +void init_disk(struct gendisk *disk, int major, int first_minor,
> +		int minors, sector_t sectors, void *private_data,
> +		const struct block_device_operations *fops)
> +{
> +	disk->major = major;
> +	disk->first_minor = first_minor;
> +	disk->minors = minors;
> +	set_capacity(disk, sectors);
> +	disk->private_data = private_data;
> +	disk->fops = fops;

I don't like this at all.  For one major/first_minor/minors are
optional and discouraged for new drivers.  Setting the capacity is
a different thing and is done by helpers also used for revalidation
in many drivers.

It might make sense to pass the fops (and maybe private_data) to
blk_mq_alloc_disk / blk_alloc_disk, but even then I'm not quite
sure it is worth the churn.
