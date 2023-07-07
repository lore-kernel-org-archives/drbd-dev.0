Return-Path: <jack@suse.cz>
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A65C4203A5
	for <drbd-dev@lists.linbit.com>; Fri,  7 Jul 2023 14:24:35 +0200 (CEST)
Date: Fri, 7 Jul 2023 14:24:34 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20230707122434.s46ytxpne42hecni@quack3>
References: <20230629165206.383-1-jack@suse.cz>
	<20230704122224.16257-1-jack@suse.cz>
	<ZKbgAG5OoHVyUKOG@infradead.org>
	<20230706161433.lj4apushiwguzvdd@quack3>
	<ZKf26fYMDHnTCb29@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKf26fYMDHnTCb29@infradead.org>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-nvme@lists.infradead.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Jack Wang <jinpu.wang@ionos.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	xen-devel@lists.xenproject.org, Gao Xiang <xiang@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, Chao Yu <chao@kernel.org>,
	Joern Engel <joern@lazybastard.org>,
	reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
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
Subject: Re: [Drbd-dev] [PATCH 01/32] block: Provide blkdev_get_handle_*
	functions
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

On Fri 07-07-23 04:28:41, Christoph Hellwig wrote:
> On Thu, Jul 06, 2023 at 06:14:33PM +0200, Jan Kara wrote:
> > > struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
> > > 		void *holder, const struct blk_holder_ops *hops);
> > > void bdev_release(struct bdev_handle *handle);
> > 
> > I'd maybe use bdev_close() instead of bdev_release() but otherwise I like
> > the new naming.
> 
> We're using release everywhese else, but if Jens is fine with that I
> can live with close.

Dunno, to me words pair like open-close, get-put, acquire-release.
Furthermore e.g. ->release() (and thus blkdev_release()) is called only
when the last file reference is dropped, not when each reference is
dropped, so that's why bdev_release() seems a bit confusing to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
