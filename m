Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2070F4200BE
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 17:20:31 +0200 (CEST)
Date: Mon, 24 Jun 2024 17:20:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Subject: Re: [axboe-block:for-next] [block]  bd4a633b6f:
	fsmark.files_per_sec -64.5% regression
Message-ID: <20240624152028.GA11961@lst.de>
References: <202406241546.6bbd44a7-oliver.sang@intel.com>
	<20240624083537.GA19941@lst.de> <Znl4lXRmK2ukDB7r@ryzen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znl4lXRmK2ukDB7r@ryzen.lan>
Cc: nvdimm@lists.linux.dev, feng.tang@intel.com, linux-nvme@lists.infradead.org,
	fengwei.yin@intel.com, linux-mtd@lists.infradead.org,
	linux-bcache@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	lkp@intel.com, linux-scsi@vger.kernel.org, ying.huang@intel.com,
	xen-devel@lists.xenproject.org, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	nbd@other.debian.org, linux-raid@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>, ceph-devel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
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

On Mon, Jun 24, 2024 at 03:45:57PM +0200, Niklas Cassel wrote:
> Seems to be ATA SSD:
> https://download.01.org/0day-ci/archive/20240624/202406241546.6bbd44a7-oliver.sang@intel.com/job.yaml
> 
> ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part1"
> 
> Most likely btrfs does something different depending on the nonrot flag
> being set or not. (And like you are suggesting, most likely the value of
> the nonrot flag is somehow different after commit bd4a633b6f)

Yes, btrfs does.  That's why I'm curious about the before and after,
as I can't see any way how they would be set differently.  Right now
I can only claim with vitual AHCI devices, which claim to be rotational,
though.

