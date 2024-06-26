Return-Path: <oliver.sang@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3A3164200BE
	for <drbd-dev@lists.linbit.com>; Wed, 26 Jun 2024 08:18:55 +0200 (CEST)
Date: Wed, 26 Jun 2024 14:11:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [axboe-block:for-next] [block] bd4a633b6f: fsmark.files_per_sec
	-64.5% regression
Message-ID: <Znuw/4zMD4w5Oq2a@xsang-OptiPlex-9020>
References: <202406241546.6bbd44a7-oliver.sang@intel.com>
	<20240624083537.GA19941@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624083537.GA19941@lst.de>
MIME-Version: 1.0
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
	oliver.sang@intel.com, oe-lkp@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
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

hi, Christoph Hellwig,

On Mon, Jun 24, 2024 at 10:35:37AM +0200, Christoph Hellwig wrote:
> This is odd to say at least.  Any chance you can check the value
> of /sys/block/$DEVICE/queue/rotational for the relevant device before
> and after this commit?  And is this an ATA or NVMe SSD?
> 

yeah, as Niklas mentioned, it's an ATA SSD.

I checked the /sys/block/$DEVICE/queue/rotational before and after this commit,
both show '0'. not sure if this is expected.

anyway, I noticed you send a patch [1]

so I applied this patch upon bd4a633b6f, and found the performance restored.

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-13/performance/1SSD/9B/nfsv4/btrfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit:
  1122c0c1cc ("block: move cache control settings out of queue->flags")
  bd4a633b6f ("block: move the nonrot flag to queue_limits")
  e9a0f6a398 = bd4a633b6f + patch [1]

1122c0c1cc71f740 bd4a633b6f7c3c6b6ebc1a07317 e9a0f6a398f162d115d208ad95b
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4177 ±  2%     -64.7%       1475            -1.1%       4130        fsmark.files_per_sec


[1] https://lore.kernel.org/all/20240624173835.76753-1-hch@lst.de/
