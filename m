Return-Path: <jack@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70CBA420171
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jul 2023 18:12:26 +0200 (CEST)
Date: Wed, 5 Jul 2023 18:12:25 +0200
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <bvanassche@acm.org>
Message-ID: <20230705161225.cwig5a3mo6oz7lew@quack3>
References: <20230629165206.383-1-jack@suse.cz>
	<20230704122224.16257-1-jack@suse.cz>
	<bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
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

On Tue 04-07-23 07:06:26, Bart Van Assche wrote:
> On 7/4/23 05:21, Jan Kara wrote:
> > +struct bdev_handle {
> > +	struct block_device *bdev;
> > +	void *holder;
> > +};
> 
> Please explain in the patch description why a holder pointer is introduced
> in struct bdev_handle and how it relates to the bd_holder pointer in struct
> block_device. Is one of the purposes of this patch series perhaps to add
> support for multiple holders per block device?

No. The reason for adding holder to struct bdev_handle is that it is an
argument blkdev_put() needs. Currently, every user of blkdev_put() has to
remember what it has passed as 'holder' to blkdev_get_by_*() call and pass
that to blkdev_put(). With struct bdev_handle this will happen
automatically. This is already explained in the changelog of this patch:

"Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put()..."

If it was only about holder, the intrusive patches would not be warranted
but as the description also says:

"This will eventually allow us to pass one more argument to blkdev_put()
without too much hassle."

Because we will additionaly need to propagate the 'mode' argument used at
open to blkdev_put().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
