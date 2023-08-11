Return-Path: <jack@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DC234422110
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Date: Fri, 11 Aug 2023 13:04:31 +0200
Message-Id: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	linux-mm@kvack.org, Song Liu <song@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH v2 0/29] block: Make blkdev_get_by_*() return
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

Hello,

this is a v2 of the patch series which implements the idea of blkdev_get_by_*()
calls returning bdev_handle which is then passed to blkdev_put() [1]. This
makes the get and put calls for bdevs more obviously matching and allows us to
propagate context from get to put without having to modify all the users
(again!).  In particular I need to propagate used open flags to blkdev_put() to
be able count writeable opens and add support for blocking writes to mounted
block devices. I'll send that series separately.

The series is based on Christian's vfs tree as of yesterday as there is quite
some overlap. Patches have passed some reasonable testing - I've tested block
changes, md, dm, bcache, xfs, btrfs, ext4, swap. This obviously doesn't cover
everything so I'd like to ask respective maintainers to review / test their
changes. Thanks! I've pushed out the full branch to:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle

to ease review / testing.

Changes since v1:
* Rebased on top of current vfs tree
* Renamed final functions to bdev_open_by_*() and bdev_release()
* Fixed detection of exclusive open in blkdev_ioctl() and blkdev_fallocate()
* Fixed swap conversion to properly reinitialize swap_info->bdev_handle
* Fixed xfs conversion to not oops with rtdev without logdev
* Couple other minor fixups

								Honza

[1] https://lore.kernel.org/all/ZJGNsVDhZx0Xgs2H@infradead.org

CC: Alasdair Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Anna Schumaker <anna@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Coly Li <colyli@suse.de
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: Dave Kleikamp <shaggy@kernel.org>
CC: David Sterba <dsterba@suse.com>
CC: dm-devel@redhat.com
CC: drbd-dev@lists.linbit.com
CC: Gao Xiang <xiang@kernel.org>
CC: Jack Wang <jinpu.wang@ionos.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
CC: Joern Engel <joern@lazybastard.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: linux-erofs@lists.ozlabs.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: linux-mm@kvack.org
CC: linux-mtd@lists.infradead.org
CC: linux-nfs@vger.kernel.org
CC: linux-nilfs@vger.kernel.org
CC: linux-nvme@lists.infradead.org
CC: linux-pm@vger.kernel.org
CC: linux-raid@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-scsi@vger.kernel.org
CC: linux-xfs@vger.kernel.org
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: Minchan Kim <minchan@kernel.org>
CC: ocfs2-devel@oss.oracle.com
CC: reiserfs-devel@vger.kernel.org
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Song Liu <song@kernel.org>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: target-devel@vger.kernel.org
CC: Ted Tso <tytso@mit.edu>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: xen-devel@lists.xenproject.org

Previous versions:
Link: http://lore.kernel.org/r/20230629165206.383-1-jack@suse.cz # v1
