Return-Path: <konishi.ryusuke@gmail.com>
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
	[209.85.167.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2ECC6420FC9
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 19:28:28 +0200 (CEST)
Received: by mail-lf1-f47.google.com with SMTP id z12so5275138lfu.10
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 10:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-24-hch@lst.de>
In-Reply-To: <20220406060516.409838-24-hch@lst.de>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 7 Apr 2022 02:28:15 +0900
Message-ID: <CAKFNMokGOma3pvHdEsnsjuKgW+jpYX9zx8fWwJWyeKuCpKz-YQ@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
	device-mapper development <dm-devel@redhat.com>,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	linux-nilfs <linux-nilfs@vger.kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	linux-um@lists.infradead.org, nbd@other.debian.org,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 23/27] block: add a bdev_max_discard_sectors
	helper
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

On Wed, Apr 6, 2022 at 11:05 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to query the number of sectors support per each discard bio
> based on the block device and use this helper to stop various places from
> poking into the request_queue to see if discard is supported and if so how
> much.  This mirrors what is done e.g. for write zeroes as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
...
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 16e775bcf4a7c..7d510e4231713 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -829,9 +829,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
>  }
>
>  /*
> - * Check if the underlying struct block_device request_queue supports
> - * the QUEUE_FLAG_DISCARD bit for UNMAP/WRITE_SAME in SCSI + TRIM
> - * in ATA and we need to set TPE=1

> + * Check if the underlying struct block_device request_queue supports disard.
>   */

Here was a typo:

 s/disard/discard/

On Thu, Apr 7, 2022 at 12:19 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> If I'm misreading things, could you please document that
> bdev_max_discard_sectors() != 0 implies that discard is supported?

I got the same impression.   Checking the discard support with
bdev_max_discard_sectors() != 0 seems a bit unclear than before.

Thanks,
Ryusuke Konishi
