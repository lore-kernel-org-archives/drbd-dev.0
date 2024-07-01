Return-Path: <oliver.sang@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D76C420657
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2024 10:22:42 +0200 (CEST)
Date: Mon, 1 Jul 2024 16:22:19 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [axboe-block:for-next] [block]  1122c0c1cc:  aim7.jobs-per-min
	22.6% improvement
Message-ID: <ZoJnO09LBj6kApY7@xsang-OptiPlex-9020>
References: <202406250948.e0044f1d-oliver.sang@intel.com>
	<ZnqGf49cvy6W-xWf@infradead.org>
	<Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
	<ZnuNhkH26nZi8fz6@infradead.org>
	<ZnzP+nUrk8+9bANK@xsang-OptiPlex-9020>
	<ZnzwbYSaIlT0SIEy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnzwbYSaIlT0SIEy@infradead.org>
MIME-Version: 1.0
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	feng.tang@intel.com, linux-nvme@lists.infradead.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	lkp@intel.com, linux-scsi@vger.kernel.org, ying.huang@intel.com,
	xen-devel@lists.xenproject.org, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	nbd@other.debian.org, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	fengwei.yin@intel.com, oliver.sang@intel.com,
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

hi, Christoph Hellwig,

On Wed, Jun 26, 2024 at 09:54:05PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 27, 2024 at 10:35:38AM +0800, Oliver Sang wrote:
> > 
> > I failed to apply patch in your previous reply to 1122c0c1cc or current tip
> > of axboe-block/for-next:
> > c1440ed442a58 (axboe-block/for-next) Merge branch 'for-6.11/block' into for-next
> 
> That already includes it.

for the patch in your previous reply [1]
the bot applied it automatically as:
* 5c683739f6c2f patch in [1]
* 0fc4bfab2cd45 (tag: next-20240625) Add linux-next specific files for 20240625

for patch set [2], the bot applied it as:
* 6490f979767736 block: move dma_pad_mask into queue_limits
* 278817f42e219b block: remove the fallback case in queue_dma_alignment
* 81afb19d619a04 block: remove disk_update_readahead
* 037d85402b8b83 block: conding style fixup for blk_queue_max_guaranteed_bio
* 4fe67425ae31a8 block: convert features and flags to __bitwise types
* e3c2d2ad4136f2 block: rename BLK_FLAG_MISALIGNED
* 33ead159243d1c block: correctly report cache type
* 6725109120e0ba md: set md-specific flags for all queue limits
*   e6d130064a02f5 Merge branch 'for-6.11/block' into for-next


but both build failed with the error:
  - "ERROR: modpost: \"md_init_stacking_limits\" [drivers/md/raid456.ko] undefined!"
  - "ERROR: modpost: \"md_init_stacking_limits\" [drivers/md/raid1.ko] undefined!"
  - "ERROR: modpost: \"md_init_stacking_limits\" [drivers/md/raid0.ko] undefined!"
  - "ERROR: modpost: \"md_init_stacking_limits\" [drivers/md/raid10.ko] undefined!"


since you mentioned the axboe-block/for-next branch has already includes the
patch-set, I got a snapshot of the branch as below several days ago:

*   bc512ae8cb934 (axboe-block/for-next) Merge branch 'for-6.11/block' into for-next   <-----------
|\
| * 18048c1af7836 (axboe-block/for-6.11/block) loop: Fix a race between loop detach and loop open
| * 63db4a1f795a1 block: Delete blk_queue_flag_test_and_set()
* | e21d05740862c Merge branch 'for-6.11/block' into for-next
|\|
| * e269537e491da block: clean up the check in blkdev_iomap_begin()
* | 9c6e1f8702d51 Merge branch 'for-6.11/block' into for-next
|\|
| * 69b6517687a4b block: use the right type for stub rq_integrity_vec()
* | c1440ed442a58 Merge branch 'for-6.11/block' into for-next
|\|
| * e94b45d08b5d1 block: move dma_pad_mask into queue_limits          <----------------
| * abfc9d810926d block: remove the fallback case in queue_dma_alignment
| * 73781b3b81e76 block: remove disk_update_readahead
| * 3302f6f090522 block: conding style fixup for blk_queue_max_guaranteed_bio
| * fcf865e357f80 block: convert features and flags to __bitwise types
| * ec9b1cf0b0ebf block: rename BLK_FEAT_MISALIGNED
| * 78887d004fb2b block: correctly report cache type
| * 573d5abf3df00 md: set md-specific flags for all queue limits       <----------------
* | 72e9cd924fccc Merge branch 'for-6.11/block' into for-next
|\|
| * cf546dd289e0f block: change rq_integrity_vec to respect the iterator  <-------------

from below, it seems the patchset doesn't introduce any performance improvement
but a regression now. is this expected?

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
  gcc-13/performance/4BRD_12G/xfs/x86_64-rhel-8.3/300/RAID0/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/sync_disk_rw/aim7

cf546dd289e0f6d2 573d5abf3df00c879fbd25774e4 e94b45d08b5d1c230c0f59c3eed bc512ae8cb934ac31470bc825fa
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     21493           -19.6%      17278           -19.2%      17371           -19.7%      17264        aim7.jobs-per-min



[1] https://lore.kernel.org/all/ZnqGf49cvy6W-xWf@infradead.org/
[2] https://lore.kernel.org/all/20240625145955.115252-2-hch@lst.de/

> 
> > 
> > but it's ok to apply upon next:
> > * 0fc4bfab2cd45 (tag: next-20240625) Add linux-next specific files for 20240625
> > 
> > I've already started the test based on this applyment.
> > is the expectation that patch should not introduce performance change comparing
> > to 0fc4bfab2cd45?
> > 
> > or if this applyment is not ok, please just give me guidance. Thanks!
> 
> The expectation is that the latest block branch (and thus linux-next)
> doesn't see this performance change.
> 
