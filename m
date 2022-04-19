Return-Path: <dsterba@suse.cz>
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 302F34201B9
	for <drbd-dev@lists.linbit.com>; Tue, 19 Apr 2022 14:59:20 +0200 (CEST)
Date: Tue, 19 Apr 2022 14:55:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20220419125517.GB2348@twin.jikos.cz>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415045258.199825-28-hch@lst.de>
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
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
Subject: Re: [Drbd-dev] [PATCH 27/27] direct-io: remove random prefetches
Reply-To: dsterba@suse.cz
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

On Fri, Apr 15, 2022 at 06:52:58AM +0200, Christoph Hellwig wrote:
> Randomly poking into block device internals for manual prefetches isn't
> exactly a very maintainable thing to do.  And none of the performance
> criticil direct I/O implementations still use this library function
> anyway, so just drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That the direct io function needed a valid bdev just for the prefetch
but nothing else was one of the reasons we had to keep the latest_bdev
in btrfs, so good riddance.

You may want to add the reference to the patch that added the prefetch,
65dd2aa90aa1 ("dio: optimize cache misses in the submission path") and
also remove #include <linux/prefetch.h> as there are no more uses of
prefetch in the file.

With that

Reviewed-by: David Sterba <dsterba@suse.com>
