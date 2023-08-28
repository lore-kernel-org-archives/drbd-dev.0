Return-Path: <BATV+b83d16e5cd0c301f07e4+7309+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6AFD64201C8
	for <drbd-dev@lists.linbit.com>; Mon, 28 Aug 2023 16:27:46 +0200 (CEST)
Date: Mon, 28 Aug 2023 07:27:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <ZOyu2FX7Fmzj6JJz@infradead.org>
References: <20230810171429.31759-1-jack@suse.cz>
	<20230825015843.GB95084@ZenIV>
	<20230825134756.o3wpq6bogndukn53@quack3>
	<20230826022852.GO3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826022852.GO3390869@ZenIV>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-nvme@lists.infradead.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Jack Wang <jinpu.wang@ionos.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	xen-devel@lists.xenproject.org, Gao Xiang <xiang@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, Chao Yu <chao@kernel.org>,
	Joern Engel <joern@lazybastard.org>,
	reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>,
	linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH v2 0/29] block: Make blkdev_get_by_*() return
	handle
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

On Sat, Aug 26, 2023 at 03:28:52AM +0100, Al Viro wrote:
> I mean, look at claim_swapfile() for example:
>                 p->bdev = blkdev_get_by_dev(inode->i_rdev,
>                                    FMODE_READ | FMODE_WRITE | FMODE_EXCL, p);
>                 if (IS_ERR(p->bdev)) {
>                         error = PTR_ERR(p->bdev);
>                         p->bdev = NULL;
>                         return error;
>                 }
>                 p->old_block_size = block_size(p->bdev);
>                 error = set_blocksize(p->bdev, PAGE_SIZE);
>                 if (error < 0)
>                         return error;
> we already have the file opened, and we keep it opened all the way until
> the swapoff(2); here we have noticed that it's a block device and we
> 	* open the fucker again (by device number), this time claiming
> it with our swap_info_struct as holder, to be closed at swapoff(2) time
> (just before we close the file)

Note that some drivers look at FMODE_EXCL/BLK_OPEN_EXCL in ->open.
These are probably bogus and maybe we want to kill them, but that will
need an audit first.

> BTW, what happens if two threads call ioctl(fd, BLKBSZSET, &n)
> for the same descriptor that happens to have been opened O_EXCL?
> Without O_EXCL they would've been unable to claim the sucker at the same
> time - the holder we are using is the address of a function argument,
> i.e. something that points to kernel stack of the caller.  Those would
> conflict and we either get set_blocksize() calls fully serialized, or
> one of the callers would eat -EBUSY.  Not so in "opened with O_EXCL"
> case - they can very well overlap and IIRC set_blocksize() does *not*
> expect that kind of crap...  It's all under CAP_SYS_ADMIN, so it's not
> as if it was a meaningful security hole anyway, but it does look fishy.

The user get to keep the pieces..  BLKBSZSET is kinda bogus anyway
as the soft blocksize only matters for buffer_head-like I/O, and
there only for file systems.  Not idea why anyone would set it manually.
