Return-Path: <cassel@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 57F9C4200BE
	for <drbd-dev@lists.linbit.com>;
	Mon, 24 Jun 2024 15:52:30 +0200 (CEST)
Date: Mon, 24 Jun 2024 15:45:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [axboe-block:for-next] [block] bd4a633b6f: fsmark.files_per_sec
	-64.5% regression
Message-ID: <Znl4lXRmK2ukDB7r@ryzen.lan>
References: <202406241546.6bbd44a7-oliver.sang@intel.com>
	<20240624083537.GA19941@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624083537.GA19941@lst.de>
Cc: nvdimm@lists.linux.dev, feng.tang@intel.com, linux-nvme@lists.infradead.org,
	fengwei.yin@intel.com, linux-mtd@lists.infradead.org,
	linux-bcache@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, lkp@intel.com,
	linux-scsi@vger.kernel.org, ying.huang@intel.com,
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

On Mon, Jun 24, 2024 at 10:35:37AM +0200, Christoph Hellwig wrote:
> This is odd to say at least.  Any chance you can check the value
> of /sys/block/$DEVICE/queue/rotational for the relevant device before
> and after this commit?  And is this an ATA or NVMe SSD?
> 

Seems to be ATA SSD:
https://download.01.org/0day-ci/archive/20240624/202406241546.6bbd44a7-oliver.sang@intel.com/job.yaml

ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part1"

Most likely btrfs does something different depending on the nonrot flag
being set or not. (And like you are suggesting, most likely the value of
the nonrot flag is somehow different after commit bd4a633b6f)


Kind regards,
Niklas
