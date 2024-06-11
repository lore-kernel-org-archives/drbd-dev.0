Return-Path: <dlemoal@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BE354205A9
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 09:25:26 +0200 (CEST)
Message-ID: <92df5033-5df7-4b2a-98ad-a27f8443ee6a@kernel.org>
Date: Tue, 11 Jun 2024 16:25:18 +0900
MIME-Version: 1.0
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
	sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
	<20240611051929.513387-3-hch@lst.de>
	<40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
	<20240611055239.GA3141@lst.de> <20240611055405.GA3256@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240611055405.GA3256@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	linux-bcache@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org, Roger Pau Monn?? <roger.pau@citrix.com>
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

On 6/11/24 2:54 PM, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 07:52:39AM +0200, Christoph Hellwig wrote:
>>> Maybe we should clear the other zone related limits here ? If the drive is
>>> reformatted/converted from SMR to CMR (FORMAT WITH PRESET), the other zone
>>> limits may be set already, no ?
>>
>> blk_validate_zoned_limits already takes care of that.
> 
> Sorry, brainfart.  The integrity code does that, but not the zoned
> code.  I suspect the core code might be a better place for it,
> though.

Yes. Just replied to your previous email before seeing this one.
I think that:

static int blk_validate_zoned_limits(struct queue_limits *lim)
{
        if (!lim->zoned) {
                if (WARN_ON_ONCE(lim->max_open_zones) ||
                    WARN_ON_ONCE(lim->max_active_zones) ||
                    WARN_ON_ONCE(lim->zone_write_granularity) ||
                    WARN_ON_ONCE(lim->max_zone_append_sectors))
                        return -EINVAL;
                return 0;
        }
	...

could be changed into:

static int blk_validate_zoned_limits(struct queue_limits *lim)
{
	if (!lim->zoned) {
                lim->max_open_zones = 0;
		lim->max_active_zones = 0;
		lim->zone_write_granularity = 0;
		lim->max_zone_append_sectors = 0
		return 0;
	}

But then we would not see "bad" drivers. Could have a small

blk_clear_zoned_limits(struct queue_limits *lim)

helper too.

-- 
Damien Le Moal
Western Digital Research

