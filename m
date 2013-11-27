Return-Path: <kmo@daterainc.com>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
	[209.85.160.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4CA5710593BC
	for <drbd-dev@lists.linbit.com>; Wed, 27 Nov 2013 01:50:50 +0100 (CET)
Received: by mail-pb0-f43.google.com with SMTP id rq2so9223603pbb.30
	for <drbd-dev@lists.linbit.com>; Tue, 26 Nov 2013 16:50:49 -0800 (PST)
From: Kent Overstreet <kmo@daterainc.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hch@infradead.org
Date: Tue, 26 Nov 2013 16:45:07 -0800
Message-Id: <1385513128-5035-4-git-send-email-kmo@daterainc.com>
In-Reply-To: <1385513128-5035-1-git-send-email-kmo@daterainc.com>
References: <20131127004422.GB21305@kmo>
	<1385513128-5035-1-git-send-email-kmo@daterainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Dave Kleikamp <shaggy@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>,
	Jan Beulich <jbeulich@suse.com>, "Ed L. Cashin" <ecashin@coraid.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Selvan Mani <smani@micron.com>, Namjae Jeon <namjae.jeon@samsung.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Chris Mason <chris.mason@fusionio.com>, dm-devel@redhat.com,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, Sage Weil <sage@inktank.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Joe Perches <joe@perches.com>, Mike Snitzer <snitzer@redhat.com>,
	Len Brown <len.brown@intel.com>,
	Minchan Kim <minchan@kernel.org>, Jie Liu <jeff.liu@oracle.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Boaz Harrosh <bharrosh@panasas.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Prasad Joshi <prasadjoshi.linux@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Alex Elder <elder@inktank.com>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	Peng Tao <tao.peng@emc.com>, Nick Piggin <npiggin@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Pankaj Kumar <pankaj.km@samsung.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Joern Engel <joern@logfs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Steven Rostedt <rostedt@goodmis.org>, xfs@oss.sgi.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>,
	Kent Overstreet <kmo@daterainc.com>,
	Jerome Marchand <jmarchand@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Adamson <andros@netapp.com>,
	Sam Bradshaw <sbradshaw@micron.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>,
	ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>,
	Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	Asai Thambi S P <asamymuthupa@micron.com>, Ben Myers <bpm@sgi.com>,
	fanchaoting <fanchaoting@cn.fujitsu.com>,
	Benny Halevy <bhalevy@tonian.com>, Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Mark Fasheh <mfasheh@suse.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, Joel Becker <jlbec@evilplan.org>
Subject: [Drbd-dev] [PATCH 04/25] block: Abstract out bvec iterator
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Immutable biovecs are going to require an explicit iterator. To
implement immutable bvecs, a later patch is going to add a bi_bvec_done
member to this struct; for now, this patch effectively just renames
things.

Signed-off-by: Kent Overstreet <kmo@daterainc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Ed L. Cashin" <ecashin@coraid.com>
Cc: Nick Piggin <npiggin@kernel.dk>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Matthew Wilcox <willy@linux.intel.com>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org
Cc: Joshua Morris <josh.h.morris@us.ibm.com>
Cc: Philip Kelleher <pjk1939@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Neil Brown <neilb@suse.de>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: Boaz Harrosh <bharrosh@panasas.com>
Cc: Benny Halevy <bhalevy@tonian.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Chris Mason <chris.mason@fusionio.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Joern Engel <joern@logfs.org>
Cc: Prasad Joshi <prasadjoshi.linux@gmail.com>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>
Cc: Mark Fasheh <mfasheh@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Ben Myers <bpm@sgi.com>
Cc: xfs@oss.sgi.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Asai Thambi S P <asamymuthupa@micron.com>
Cc: Selvan Mani <smani@micron.com>
Cc: Sam Bradshaw <sbradshaw@micron.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Jerome Marchand <jmarchand@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Peng Tao <tao.peng@emc.com>
Cc: Andy Adamson <andros@netapp.com>
Cc: fanchaoting <fanchaoting@cn.fujitsu.com>
Cc: Jie Liu <jeff.liu@oracle.com>
Cc: Sunil Mushran <sunil.mushran@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Pankaj Kumar <pankaj.km@samsung.com>
Cc: Dan Magenheimer <dan.magenheimer@oracle.com>
Cc: Mel Gorman <mgorman@suse.de>6
---
 Documentation/block/biodoc.txt              |  7 +--
 arch/m68k/emu/nfblock.c                     |  2 +-
 arch/powerpc/sysdev/axonram.c               |  3 +-
 block/blk-core.c                            | 36 ++++++------
 block/blk-flush.c                           |  2 +-
 block/blk-lib.c                             | 12 ++--
 block/blk-map.c                             |  6 +-
 block/blk-merge.c                           |  4 +-
 block/blk-mq.c                              |  2 +-
 block/blk-throttle.c                        | 14 ++---
 block/elevator.c                            |  2 +-
 drivers/block/aoe/aoecmd.c                  |  6 +-
 drivers/block/brd.c                         |  4 +-
 drivers/block/drbd/drbd_actlog.c            |  2 +-
 drivers/block/drbd/drbd_bitmap.c            |  2 +-
 drivers/block/drbd/drbd_receiver.c          |  6 +-
 drivers/block/drbd/drbd_req.c               |  6 +-
 drivers/block/drbd/drbd_req.h               |  2 +-
 drivers/block/floppy.c                      |  4 +-
 drivers/block/loop.c                        |  4 +-
 drivers/block/mtip32xx/mtip32xx.c           |  7 ++-
 drivers/block/nvme-core.c                   | 25 ++++----
 drivers/block/pktcdvd.c                     | 54 +++++++++--------
 drivers/block/ps3disk.c                     |  2 +-
 drivers/block/ps3vram.c                     |  2 +-
 drivers/block/rbd.c                         | 21 +++----
 drivers/block/rsxx/dev.c                    |  6 +-
 drivers/block/rsxx/dma.c                    |  4 +-
 drivers/block/umem.c                        |  9 +--
 drivers/block/xen-blkback/blkback.c         |  2 +-
 drivers/block/xen-blkfront.c                |  2 +-
 drivers/md/bcache/btree.c                   |  4 +-
 drivers/md/bcache/debug.c                   |  2 +-
 drivers/md/bcache/io.c                      | 26 ++++-----
 drivers/md/bcache/journal.c                 | 12 ++--
 drivers/md/bcache/movinggc.c                |  4 +-
 drivers/md/bcache/request.c                 | 58 +++++++++---------
 drivers/md/bcache/super.c                   | 16 ++---
 drivers/md/bcache/util.c                    |  4 +-
 drivers/md/bcache/writeback.c               |  6 +-
 drivers/md/bcache/writeback.h               |  2 +-
 drivers/md/dm-bio-record.h                  | 12 ++--
 drivers/md/dm-bufio.c                       |  2 +-
 drivers/md/dm-cache-policy-mq.c             |  4 +-
 drivers/md/dm-cache-target.c                | 22 +++----
 drivers/md/dm-crypt.c                       | 19 +++---
 drivers/md/dm-delay.c                       |  7 ++-
 drivers/md/dm-flakey.c                      |  7 ++-
 drivers/md/dm-io.c                          |  6 +-
 drivers/md/dm-linear.c                      |  3 +-
 drivers/md/dm-raid1.c                       | 16 ++---
 drivers/md/dm-region-hash.c                 |  3 +-
 drivers/md/dm-snap.c                        | 18 +++---
 drivers/md/dm-stripe.c                      | 13 +++--
 drivers/md/dm-switch.c                      |  4 +-
 drivers/md/dm-thin.c                        | 22 +++----
 drivers/md/dm-verity.c                      |  8 +--
 drivers/md/dm.c                             | 25 ++++----
 drivers/md/faulty.c                         | 19 +++---
 drivers/md/linear.c                         | 12 ++--
 drivers/md/md.c                             | 10 ++--
 drivers/md/multipath.c                      | 13 +++--
 drivers/md/raid0.c                          | 16 ++---
 drivers/md/raid1.c                          | 75 ++++++++++++------------
 drivers/md/raid10.c                         | 91 ++++++++++++++++-------------
 drivers/md/raid5.c                          | 72 ++++++++++++-----------
 drivers/s390/block/dcssblk.c                |  5 +-
 drivers/s390/block/xpram.c                  |  9 +--
 drivers/scsi/osd/osd_initiator.c            |  2 +-
 drivers/staging/lustre/lustre/llite/lloop.c | 12 ++--
 drivers/staging/zram/zram_drv.c             | 14 +++--
 drivers/target/target_core_iblock.c         |  2 +-
 fs/bio-integrity.c                          |  8 +--
 fs/bio.c                                    | 56 +++++++++---------
 fs/btrfs/check-integrity.c                  |  8 +--
 fs/btrfs/compression.c                      | 17 +++---
 fs/btrfs/extent_io.c                        | 14 ++---
 fs/btrfs/file-item.c                        | 19 +++---
 fs/btrfs/inode.c                            | 22 +++----
 fs/btrfs/raid56.c                           | 22 +++----
 fs/btrfs/scrub.c                            | 12 ++--
 fs/btrfs/volumes.c                          | 12 ++--
 fs/buffer.c                                 | 12 ++--
 fs/direct-io.c                              |  4 +-
 fs/ext4/page-io.c                           |  4 +-
 fs/f2fs/data.c                              |  2 +-
 fs/f2fs/segment.c                           |  2 +-
 fs/gfs2/lops.c                              |  2 +-
 fs/gfs2/ops_fstype.c                        |  2 +-
 fs/hfsplus/wrapper.c                        |  2 +-
 fs/jfs/jfs_logmgr.c                         | 12 ++--
 fs/jfs/jfs_metapage.c                       |  9 +--
 fs/logfs/dev_bdev.c                         | 20 +++----
 fs/mpage.c                                  |  2 +-
 fs/nfs/blocklayout/blocklayout.c            |  9 +--
 fs/nilfs2/segbuf.c                          |  3 +-
 fs/ocfs2/cluster/heartbeat.c                |  2 +-
 fs/xfs/xfs_aops.c                           |  2 +-
 fs/xfs/xfs_buf.c                            |  4 +-
 include/linux/bio.h                         | 16 ++---
 include/linux/blk_types.h                   | 19 +++---
 include/trace/events/bcache.h               | 26 ++++-----
 include/trace/events/block.h                | 26 ++++-----
 include/trace/events/f2fs.h                 |  4 +-
 kernel/power/block_io.c                     |  2 +-
 kernel/trace/blktrace.c                     | 15 ++---
 mm/page_io.c                                | 10 ++--
 107 files changed, 700 insertions(+), 638 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index 8df5e8e..2101e71 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -447,14 +447,13 @@ struct bio_vec {
  * main unit of I/O for the block layer and lower layers (ie drivers)
  */
 struct bio {
-       sector_t            bi_sector;
        struct bio          *bi_next;    /* request queue link */
        struct block_device *bi_bdev;	/* target device */
        unsigned long       bi_flags;    /* status, command, etc */
        unsigned long       bi_rw;       /* low bits: r/w, high: priority */
 
        unsigned int	bi_vcnt;     /* how may bio_vec's */
-       unsigned int	bi_idx;		/* current index into bio_vec array */
+       struct bvec_iter	bi_iter;	/* current index into bio_vec array */
 
        unsigned int	bi_size;     /* total size in bytes */
        unsigned short 	bi_phys_segments; /* segments after physaddr coalesce*/
@@ -480,7 +479,7 @@ With this multipage bio design:
 - Code that traverses the req list can find all the segments of a bio
   by using rq_for_each_segment.  This handles the fact that a request
   has multiple bios, each of which can have multiple segments.
-- Drivers which can't process a large bio in one shot can use the bi_idx
+- Drivers which can't process a large bio in one shot can use the bi_iter
   field to keep track of the next bio_vec entry to process.
   (e.g a 1MB bio_vec needs to be handled in max 128kB chunks for IDE)
   [TBD: Should preferably also have a bi_voffset and bi_vlen to avoid modifying
@@ -589,7 +588,7 @@ driver should not modify these values. The block layer sets up the
 nr_sectors and current_nr_sectors fields (based on the corresponding
 hard_xxx values and the number of bytes transferred) and updates it on
 every transfer that invokes end_that_request_first. It does the same for the
-buffer, bio, bio->bi_idx fields too.
+buffer, bio, bio->bi_iter fields too.
 
 The buffer field is just a virtual address mapping of the current segment
 of the i/o buffer in cases where the buffer resides in low-memory. For high
diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 0721858..0a9d0b3 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -64,7 +64,7 @@ static void nfhd_make_request(struct request_queue *queue, struct bio *bio)
 	struct nfhd_device *dev = queue->queuedata;
 	struct bio_vec *bvec;
 	int i, dir, len, shift;
-	sector_t sec = bio->bi_sector;
+	sector_t sec = bio->bi_iter.bi_sector;
 
 	dir = bio_data_dir(bio);
 	shift = dev->bshift;
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 1c16141..f33bcba 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -113,7 +113,8 @@ axon_ram_make_request(struct request_queue *queue, struct bio *bio)
 	unsigned int transfered;
 	unsigned short idx;
 
-	phys_mem = bank->io_addr + (bio->bi_sector << AXON_RAM_SECTOR_SHIFT);
+	phys_mem = bank->io_addr + (bio->bi_iter.bi_sector <<
+				    AXON_RAM_SECTOR_SHIFT);
 	phys_end = bank->io_addr + bank->size;
 	transfered = 0;
 	bio_for_each_segment(vec, bio, idx) {
diff --git a/block/blk-core.c b/block/blk-core.c
index 8bdd012..5c2ab2c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -130,7 +130,7 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 	bio_advance(bio, nbytes);
 
 	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_size == 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
+	if (bio->bi_iter.bi_size == 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
 		bio_endio(bio, error);
 }
 
@@ -1326,7 +1326,7 @@ void blk_add_request_payload(struct request *rq, struct page *page,
 	bio->bi_io_vec->bv_offset = 0;
 	bio->bi_io_vec->bv_len = len;
 
-	bio->bi_size = len;
+	bio->bi_iter.bi_size = len;
 	bio->bi_vcnt = 1;
 	bio->bi_phys_segments = 1;
 
@@ -1351,7 +1351,7 @@ bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
-	req->__data_len += bio->bi_size;
+	req->__data_len += bio->bi_iter.bi_size;
 	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	blk_account_io_start(req, false);
@@ -1380,8 +1380,8 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 	 * not touch req->buffer either...
 	 */
 	req->buffer = bio_data(bio);
-	req->__sector = bio->bi_sector;
-	req->__data_len += bio->bi_size;
+	req->__sector = bio->bi_iter.bi_sector;
+	req->__data_len += bio->bi_iter.bi_size;
 	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	blk_account_io_start(req, false);
@@ -1459,7 +1459,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->errors = 0;
-	req->__sector = bio->bi_sector;
+	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
@@ -1583,12 +1583,12 @@ static inline void blk_partition_remap(struct bio *bio)
 	if (bio_sectors(bio) && bdev != bdev->bd_contains) {
 		struct hd_struct *p = bdev->bd_part;
 
-		bio->bi_sector += p->start_sect;
+		bio->bi_iter.bi_sector += p->start_sect;
 		bio->bi_bdev = bdev->bd_contains;
 
 		trace_block_bio_remap(bdev_get_queue(bio->bi_bdev), bio,
 				      bdev->bd_dev,
-				      bio->bi_sector - p->start_sect);
+				      bio->bi_iter.bi_sector - p->start_sect);
 	}
 }
 
@@ -1654,7 +1654,7 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 	/* Test device or partition size, when known. */
 	maxsector = i_size_read(bio->bi_bdev->bd_inode) >> 9;
 	if (maxsector) {
-		sector_t sector = bio->bi_sector;
+		sector_t sector = bio->bi_iter.bi_sector;
 
 		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
 			/*
@@ -1690,7 +1690,7 @@ generic_make_request_checks(struct bio *bio)
 		       "generic_make_request: Trying to access "
 			"nonexistent block-device %s (%Lu)\n",
 			bdevname(bio->bi_bdev, b),
-			(long long) bio->bi_sector);
+			(long long) bio->bi_iter.bi_sector);
 		goto end_io;
 	}
 
@@ -1704,9 +1704,9 @@ generic_make_request_checks(struct bio *bio)
 	}
 
 	part = bio->bi_bdev->bd_part;
-	if (should_fail_request(part, bio->bi_size) ||
+	if (should_fail_request(part, bio->bi_iter.bi_size) ||
 	    should_fail_request(&part_to_disk(part)->part0,
-				bio->bi_size))
+				bio->bi_iter.bi_size))
 		goto end_io;
 
 	/*
@@ -1865,7 +1865,7 @@ void submit_bio(int rw, struct bio *bio)
 		if (rw & WRITE) {
 			count_vm_events(PGPGOUT, count);
 		} else {
-			task_io_account_read(bio->bi_size);
+			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
 
@@ -1874,7 +1874,7 @@ void submit_bio(int rw, struct bio *bio)
 			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
 			current->comm, task_pid_nr(current),
 				(rw & WRITE) ? "WRITE" : "READ",
-				(unsigned long long)bio->bi_sector,
+				(unsigned long long)bio->bi_iter.bi_sector,
 				bdevname(bio->bi_bdev, b),
 				count);
 		}
@@ -2007,7 +2007,7 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 	for (bio = rq->bio; bio; bio = bio->bi_next) {
 		if ((bio->bi_rw & ff) != ff)
 			break;
-		bytes += bio->bi_size;
+		bytes += bio->bi_iter.bi_size;
 	}
 
 	/* this could lead to infinite loop */
@@ -2378,9 +2378,9 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 	total_bytes = 0;
 	while (req->bio) {
 		struct bio *bio = req->bio;
-		unsigned bio_bytes = min(bio->bi_size, nr_bytes);
+		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
-		if (bio_bytes == bio->bi_size)
+		if (bio_bytes == bio->bi_iter.bi_size)
 			req->bio = bio->bi_next;
 
 		req_bio_endio(req, bio, bio_bytes, error);
@@ -2728,7 +2728,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
 		rq->buffer = bio_data(bio);
 	}
-	rq->__data_len = bio->bi_size;
+	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 
 	if (bio->bi_bdev)
diff --git a/block/blk-flush.c b/block/blk-flush.c
index fb6f3c0..9288aaf 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -548,7 +548,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	 * copied from blk_rq_pos(rq).
 	 */
 	if (error_sector)
-		*error_sector = bio->bi_sector;
+		*error_sector = bio->bi_iter.bi_sector;
 
 	bio_put(bio);
 	return ret;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9b5b561..2da76c9 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -108,12 +108,12 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			req_sects = end_sect - sector;
 		}
 
-		bio->bi_sector = sector;
+		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;
 		bio->bi_bdev = bdev;
 		bio->bi_private = &bb;
 
-		bio->bi_size = req_sects << 9;
+		bio->bi_iter.bi_size = req_sects << 9;
 		nr_sects -= req_sects;
 		sector = end_sect;
 
@@ -174,7 +174,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			break;
 		}
 
-		bio->bi_sector = sector;
+		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;
 		bio->bi_bdev = bdev;
 		bio->bi_private = &bb;
@@ -184,11 +184,11 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
 
 		if (nr_sects > max_write_same_sectors) {
-			bio->bi_size = max_write_same_sectors << 9;
+			bio->bi_iter.bi_size = max_write_same_sectors << 9;
 			nr_sects -= max_write_same_sectors;
 			sector += max_write_same_sectors;
 		} else {
-			bio->bi_size = nr_sects << 9;
+			bio->bi_iter.bi_size = nr_sects << 9;
 			nr_sects = 0;
 		}
 
@@ -240,7 +240,7 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			break;
 		}
 
-		bio->bi_sector = sector;
+		bio->bi_iter.bi_sector = sector;
 		bio->bi_bdev   = bdev;
 		bio->bi_end_io = bio_batch_end_io;
 		bio->bi_private = &bb;
diff --git a/block/blk-map.c b/block/blk-map.c
index 623e1cd..ae4ae10 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -20,7 +20,7 @@ int blk_rq_append_bio(struct request_queue *q, struct request *rq,
 		rq->biotail->bi_next = bio;
 		rq->biotail = bio;
 
-		rq->__data_len += bio->bi_size;
+		rq->__data_len += bio->bi_iter.bi_size;
 	}
 	return 0;
 }
@@ -76,7 +76,7 @@ static int __blk_rq_map_user(struct request_queue *q, struct request *rq,
 
 	ret = blk_rq_append_bio(q, rq, bio);
 	if (!ret)
-		return bio->bi_size;
+		return bio->bi_iter.bi_size;
 
 	/* if it was boucned we must call the end io function */
 	bio_endio(bio, 0);
@@ -220,7 +220,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	if (bio->bi_size != len) {
+	if (bio->bi_iter.bi_size != len) {
 		/*
 		 * Grab an extra reference to this bio, as bio_unmap_user()
 		 * expects to be able to drop it twice as it happens on the
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1ffc589..03bc083 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -543,9 +543,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 int blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_sector)
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
-	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_sector)
+	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
 		return ELEVATOR_FRONT_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cdc629c..e4fbcc3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -301,7 +301,7 @@ void blk_mq_complete_request(struct request *rq, int error)
 		struct bio *next = bio->bi_next;
 
 		bio->bi_next = NULL;
-		bytes += bio->bi_size;
+		bytes += bio->bi_iter.bi_size;
 		blk_mq_bio_endio(rq, bio, error);
 		bio = next;
 	}
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0653404..20f8200 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -877,14 +877,14 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	do_div(tmp, HZ);
 	bytes_allowed = tmp;
 
-	if (tg->bytes_disp[rw] + bio->bi_size <= bytes_allowed) {
+	if (tg->bytes_disp[rw] + bio->bi_iter.bi_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
 		return 1;
 	}
 
 	/* Calc approx time to dispatch */
-	extra_bytes = tg->bytes_disp[rw] + bio->bi_size - bytes_allowed;
+	extra_bytes = tg->bytes_disp[rw] + bio->bi_iter.bi_size - bytes_allowed;
 	jiffy_wait = div64_u64(extra_bytes * HZ, tg->bps[rw]);
 
 	if (!jiffy_wait)
@@ -987,7 +987,7 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	bool rw = bio_data_dir(bio);
 
 	/* Charge the bio to the group */
-	tg->bytes_disp[rw] += bio->bi_size;
+	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
 
 	/*
@@ -1003,8 +1003,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	 */
 	if (!(bio->bi_rw & REQ_THROTTLED)) {
 		bio->bi_rw |= REQ_THROTTLED;
-		throtl_update_dispatch_stats(tg_to_blkg(tg), bio->bi_size,
-					     bio->bi_rw);
+		throtl_update_dispatch_stats(tg_to_blkg(tg),
+					     bio->bi_iter.bi_size, bio->bi_rw);
 	}
 }
 
@@ -1508,7 +1508,7 @@ bool blk_throtl_bio(struct request_queue *q, struct bio *bio)
 	if (tg) {
 		if (!tg->has_rules[rw]) {
 			throtl_update_dispatch_stats(tg_to_blkg(tg),
-						     bio->bi_size, bio->bi_rw);
+					bio->bi_iter.bi_size, bio->bi_rw);
 			goto out_unlock_rcu;
 		}
 	}
@@ -1564,7 +1564,7 @@ bool blk_throtl_bio(struct request_queue *q, struct bio *bio)
 	/* out-of-limit, queue to @tg */
 	throtl_log(sq, "[%c] bio. bdisp=%llu sz=%u bps=%llu iodisp=%u iops=%u queued=%d/%d",
 		   rw == READ ? 'R' : 'W',
-		   tg->bytes_disp[rw], bio->bi_size, tg->bps[rw],
+		   tg->bytes_disp[rw], bio->bi_iter.bi_size, tg->bps[rw],
 		   tg->io_disp[rw], tg->iops[rw],
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
diff --git a/block/elevator.c b/block/elevator.c
index b7ff286..42c45a7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -440,7 +440,7 @@ int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
 	/*
 	 * See if our hash lookup can find a potential backmerge.
 	 */
-	__rq = elv_rqhash_find(q, bio->bi_sector);
+	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		*req = __rq;
 		return ELEVATOR_BACK_MERGE;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d251543..877ba11 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -929,8 +929,8 @@ bufinit(struct buf *buf, struct request *rq, struct bio *bio)
 	memset(buf, 0, sizeof(*buf));
 	buf->rq = rq;
 	buf->bio = bio;
-	buf->resid = bio->bi_size;
-	buf->sector = bio->bi_sector;
+	buf->resid = bio->bi_iter.bi_size;
+	buf->sector = bio->bi_iter.bi_sector;
 	bio_pageinc(bio);
 	buf->bv = bio_iovec(bio);
 	buf->bv_resid = buf->bv->bv_len;
@@ -1152,7 +1152,7 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
 	do {
 		bio = rq->bio;
 		bok = !fastfail && test_bit(BIO_UPTODATE, &bio->bi_flags);
-	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_size));
+	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_iter.bi_size));
 
 	/* cf. http://lkml.org/lkml/2006/10/31/28 */
 	if (!fastfail)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index d91f1a5..66f5aaa 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -333,13 +333,13 @@ static void brd_make_request(struct request_queue *q, struct bio *bio)
 	int i;
 	int err = -EIO;
 
-	sector = bio->bi_sector;
+	sector = bio->bi_iter.bi_sector;
 	if (bio_end_sector(bio) > get_capacity(bdev->bd_disk))
 		goto out;
 
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
 		err = 0;
-		discard_from_brd(brd, sector, bio->bi_size);
+		discard_from_brd(brd, sector, bio->bi_iter.bi_size);
 		goto out;
 	}
 
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 28c73ca..a9b13f2 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -159,7 +159,7 @@ static int _drbd_md_sync_page_io(struct drbd_conf *mdev,
 
 	bio = bio_alloc_drbd(GFP_NOIO);
 	bio->bi_bdev = bdev->md_bdev;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	err = -EIO;
 	if (bio_add_page(bio, page, size, 0) != size)
 		goto out;
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index b12c11e..597f111 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1028,7 +1028,7 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx, int page_nr, int rw) __must
 	} else
 		page = b->bm_pages[page_nr];
 	bio->bi_bdev = mdev->ldev->md_bdev;
-	bio->bi_sector = on_disk_sector;
+	bio->bi_iter.bi_sector = on_disk_sector;
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
 	bio_add_page(bio, page, len, 0);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6fa6673..5326c22 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1333,7 +1333,7 @@ next_bio:
 		goto fail;
 	}
 	/* > peer_req->i.sector, unless this is the first bio */
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = mdev->ldev->backing_bdev;
 	bio->bi_rw = rw;
 	bio->bi_private = peer_req;
@@ -1353,7 +1353,7 @@ next_bio:
 				dev_err(DEV,
 					"bio_add_page failed for len=%u, "
 					"bi_vcnt=0 (bi_sector=%llu)\n",
-					len, (unsigned long long)bio->bi_sector);
+					len, (uint64_t)bio->bi_iter.bi_sector);
 				err = -ENOSPC;
 				goto fail;
 			}
@@ -1615,7 +1615,7 @@ static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
 	mdev->recv_cnt += data_size>>9;
 
 	bio = req->master_bio;
-	D_ASSERT(sector == bio->bi_sector);
+	D_ASSERT(sector == bio->bi_iter.bi_sector);
 
 	bio_for_each_segment(bvec, bio, i) {
 		void *mapped = kmap(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index fec7bef..104a040 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -77,8 +77,8 @@ static struct drbd_request *drbd_req_new(struct drbd_conf *mdev,
 	req->epoch       = 0;
 
 	drbd_clear_interval(&req->i);
-	req->i.sector     = bio_src->bi_sector;
-	req->i.size      = bio_src->bi_size;
+	req->i.sector     = bio_src->bi_iter.bi_sector;
+	req->i.size      = bio_src->bi_iter.bi_size;
 	req->i.local = true;
 	req->i.waiting = false;
 
@@ -1280,7 +1280,7 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
 	/*
 	 * what we "blindly" assume:
 	 */
-	D_ASSERT(IS_ALIGNED(bio->bi_size, 512));
+	D_ASSERT(IS_ALIGNED(bio->bi_iter.bi_size, 512));
 
 	inc_ap_bio(mdev);
 	__drbd_make_request(mdev, bio, start_time);
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 978cb1a..28e15d9 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -269,7 +269,7 @@ static inline void drbd_req_make_private_bio(struct drbd_request *req, struct bi
 
 /* Short lived temporary struct on the stack.
  * We could squirrel the error to be returned into
- * bio->bi_size, or similar. But that would be too ugly. */
+ * bio->bi_iter.bi_size, or similar. But that would be too ugly. */
 struct bio_and_error {
 	struct bio *bio;
 	int error;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 000abe2..6a86fe7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3775,9 +3775,9 @@ static int __floppy_read_block_0(struct block_device *bdev)
 	bio_vec.bv_len = size;
 	bio_vec.bv_offset = 0;
 	bio.bi_vcnt = 1;
-	bio.bi_size = size;
+	bio.bi_iter.bi_size = size;
 	bio.bi_bdev = bdev;
-	bio.bi_sector = 0;
+	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags = (1 << BIO_QUIET);
 	init_completion(&complete);
 	bio.bi_private = &complete;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c8dac73..f5e3998 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -415,7 +415,7 @@ static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 	loff_t pos;
 	int ret;
 
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	pos = ((loff_t) bio->bi_iter.bi_sector << 9) + lo->lo_offset;
 
 	if (bio_rw(bio) == WRITE) {
 		struct file *file = lo->lo_backing_file;
@@ -444,7 +444,7 @@ static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 				goto out;
 			}
 			ret = file->f_op->fallocate(file, mode, pos,
-						    bio->bi_size);
+						    bio->bi_iter.bi_size);
 			if (unlikely(ret && ret != -EINVAL &&
 				     ret != -EOPNOTSUPP))
 				ret = -EIO;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 050c712..69e9eb5 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3993,7 +3993,7 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 	}
 
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
-		bio_endio(bio, mtip_send_trim(dd, bio->bi_sector,
+		bio_endio(bio, mtip_send_trim(dd, bio->bi_iter.bi_sector,
 						bio_sectors(bio)));
 		return;
 	}
@@ -4006,7 +4006,8 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 
 	if (bio_data_dir(bio) == WRITE && bio_sectors(bio) <= 64 &&
 							dd->unal_qdepth) {
-		if (bio->bi_sector % 8 != 0) /* Unaligned on 4k boundaries */
+		if (bio->bi_iter.bi_sector % 8 != 0)
+			/* Unaligned on 4k boundaries */
 			unaligned = 1;
 		else if (bio_sectors(bio) % 8 != 0) /* Aligned but not 4k/8k */
 			unaligned = 1;
@@ -4035,7 +4036,7 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 
 		/* Issue the read/write. */
 		mtip_hw_submit_io(dd,
-				bio->bi_sector,
+				bio->bi_iter.bi_sector,
 				bio_sectors(bio),
 				nents,
 				tag,
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 26d03fa..53d2173 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -468,7 +468,7 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 {
 	struct nvme_bio_pair *bp;
 
-	BUG_ON(len > bio->bi_size);
+	BUG_ON(len > bio->bi_iter.bi_size);
 	BUG_ON(idx > bio->bi_vcnt);
 
 	bp = kmalloc(sizeof(*bp), GFP_ATOMIC);
@@ -479,11 +479,11 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 	bp->b1 = *bio;
 	bp->b2 = *bio;
 
-	bp->b1.bi_size = len;
-	bp->b2.bi_size -= len;
+	bp->b1.bi_iter.bi_size = len;
+	bp->b2.bi_iter.bi_size -= len;
 	bp->b1.bi_vcnt = idx;
-	bp->b2.bi_idx = idx;
-	bp->b2.bi_sector += len >> 9;
+	bp->b2.bi_iter.bi_idx = idx;
+	bp->b2.bi_iter.bi_sector += len >> 9;
 
 	if (offset) {
 		bp->bv1 = kmalloc(bio->bi_max_vecs * sizeof(struct bio_vec),
@@ -552,11 +552,12 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 {
 	struct bio_vec *bvec, *bvprv = NULL;
 	struct scatterlist *sg = NULL;
-	int i, length = 0, nsegs = 0, split_len = bio->bi_size;
+	int i, length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
 
 	if (nvmeq->dev->stripe_size)
 		split_len = nvmeq->dev->stripe_size -
-			((bio->bi_sector << 9) & (nvmeq->dev->stripe_size - 1));
+			((bio->bi_iter.bi_sector << 9) &
+			 (nvmeq->dev->stripe_size - 1));
 
 	sg_init_table(iod->sg, psegs);
 	bio_for_each_segment(bvec, bio, i) {
@@ -584,7 +585,7 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
 		return -ENOMEM;
 
-	BUG_ON(length != bio->bi_size);
+	BUG_ON(length != bio->bi_iter.bi_size);
 	return length;
 }
 
@@ -608,8 +609,8 @@ static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	iod->npages = 0;
 
 	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(bio->bi_size >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	range->nlb = cpu_to_le32(bio->bi_iter.bi_size >> ns->lba_shift);
+	range->slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
@@ -674,7 +675,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	}
 
 	result = -ENOMEM;
-	iod = nvme_alloc_iod(psegs, bio->bi_size, GFP_ATOMIC);
+	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
 	if (!iod)
 		goto nomem;
 	iod->private = bio;
@@ -723,7 +724,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
 	length = nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, length,
 								GFP_ATOMIC);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
 	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ff8668c..ce986ba 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -651,7 +651,7 @@ static struct pkt_rb_node *pkt_rbtree_find(struct pktcdvd_device *pd, sector_t s
 
 	for (;;) {
 		tmp = rb_entry(n, struct pkt_rb_node, rb_node);
-		if (s <= tmp->bio->bi_sector)
+		if (s <= tmp->bio->bi_iter.bi_sector)
 			next = n->rb_left;
 		else
 			next = n->rb_right;
@@ -660,12 +660,12 @@ static struct pkt_rb_node *pkt_rbtree_find(struct pktcdvd_device *pd, sector_t s
 		n = next;
 	}
 
-	if (s > tmp->bio->bi_sector) {
+	if (s > tmp->bio->bi_iter.bi_sector) {
 		tmp = pkt_rbtree_next(tmp);
 		if (!tmp)
 			return NULL;
 	}
-	BUG_ON(s > tmp->bio->bi_sector);
+	BUG_ON(s > tmp->bio->bi_iter.bi_sector);
 	return tmp;
 }
 
@@ -676,13 +676,13 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
 {
 	struct rb_node **p = &pd->bio_queue.rb_node;
 	struct rb_node *parent = NULL;
-	sector_t s = node->bio->bi_sector;
+	sector_t s = node->bio->bi_iter.bi_sector;
 	struct pkt_rb_node *tmp;
 
 	while (*p) {
 		parent = *p;
 		tmp = rb_entry(parent, struct pkt_rb_node, rb_node);
-		if (s < tmp->bio->bi_sector)
+		if (s < tmp->bio->bi_iter.bi_sector)
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -857,7 +857,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 			spin_lock(&pd->iosched.lock);
 			bio = bio_list_peek(&pd->iosched.write_queue);
 			spin_unlock(&pd->iosched.lock);
-			if (bio && (bio->bi_sector == pd->iosched.last_write))
+			if (bio && (bio->bi_iter.bi_sector ==
+				    pd->iosched.last_write))
 				need_write_seek = 0;
 			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
@@ -888,7 +889,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 			continue;
 
 		if (bio_data_dir(bio) == READ)
-			pd->iosched.successive_reads += bio->bi_size >> 10;
+			pd->iosched.successive_reads +=
+				bio->bi_iter.bi_size >> 10;
 		else {
 			pd->iosched.successive_reads = 0;
 			pd->iosched.last_write = bio_end_sector(bio);
@@ -978,7 +980,7 @@ static void pkt_end_io_read(struct bio *bio, int err)
 
 	pkt_dbg(2, pd, "bio=%p sec0=%llx sec=%llx err=%d\n",
 		bio, (unsigned long long)pkt->sector,
-		(unsigned long long)bio->bi_sector, err);
+		(unsigned long long)bio->bi_iter.bi_sector, err);
 
 	if (err)
 		atomic_inc(&pkt->io_errors);
@@ -1026,8 +1028,9 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	memset(written, 0, sizeof(written));
 	spin_lock(&pkt->lock);
 	bio_list_for_each(bio, &pkt->orig_bios) {
-		int first_frame = (bio->bi_sector - pkt->sector) / (CD_FRAMESIZE >> 9);
-		int num_frames = bio->bi_size / CD_FRAMESIZE;
+		int first_frame = (bio->bi_iter.bi_sector - pkt->sector) /
+			(CD_FRAMESIZE >> 9);
+		int num_frames = bio->bi_iter.bi_size / CD_FRAMESIZE;
 		pd->stats.secs_w += num_frames * (CD_FRAMESIZE >> 9);
 		BUG_ON(first_frame < 0);
 		BUG_ON(first_frame + num_frames > pkt->frames);
@@ -1053,7 +1056,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 		bio = pkt->r_bios[f];
 		bio_reset(bio);
-		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_bdev = pd->bdev;
 		bio->bi_end_io = pkt_end_io_read;
 		bio->bi_private = pkt;
@@ -1150,8 +1153,8 @@ static int pkt_start_recovery(struct packet_data *pkt)
 	bio_reset(pkt->bio);
 	pkt->bio->bi_bdev = pd->bdev;
 	pkt->bio->bi_rw = REQ_WRITE;
-	pkt->bio->bi_sector = new_sector;
-	pkt->bio->bi_size = pkt->frames * CD_FRAMESIZE;
+	pkt->bio->bi_iter.bi_sector = new_sector;
+	pkt->bio->bi_iter.bi_size = pkt->frames * CD_FRAMESIZE;
 	pkt->bio->bi_vcnt = pkt->frames;
 
 	pkt->bio->bi_end_io = pkt_end_io_packet_write;
@@ -1213,7 +1216,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	node = first_node;
 	while (node) {
 		bio = node->bio;
-		zone = get_zone(bio->bi_sector, pd);
+		zone = get_zone(bio->bi_iter.bi_sector, pd);
 		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
 			if (p->sector == zone) {
 				bio = NULL;
@@ -1252,14 +1255,14 @@ try_next_bio:
 	pkt_dbg(2, pd, "looking for zone %llx\n", (unsigned long long)zone);
 	while ((node = pkt_rbtree_find(pd, zone)) != NULL) {
 		bio = node->bio;
-		pkt_dbg(2, pd, "found zone=%llx\n",
-			(unsigned long long)get_zone(bio->bi_sector, pd));
-		if (get_zone(bio->bi_sector, pd) != zone)
+		pkt_dbg(2, pd, "found zone=%llx\n", (unsigned long long)
+			get_zone(bio->bi_iter.bi_sector, pd));
+		if (get_zone(bio->bi_iter.bi_sector, pd) != zone)
 			break;
 		pkt_rbtree_erase(pd, node);
 		spin_lock(&pkt->lock);
 		bio_list_add(&pkt->orig_bios, bio);
-		pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+		pkt->write_size += bio->bi_iter.bi_size / CD_FRAMESIZE;
 		spin_unlock(&pkt->lock);
 	}
 	/* check write congestion marks, and if bio_queue_size is
@@ -1293,7 +1296,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	struct bio_vec *bvec = pkt->w_bio->bi_io_vec;
 
 	bio_reset(pkt->w_bio);
-	pkt->w_bio->bi_sector = pkt->sector;
+	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
 	pkt->w_bio->bi_bdev = pd->bdev;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
 	pkt->w_bio->bi_private = pkt;
@@ -2370,20 +2373,20 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
 		pkt_notice(pd, "WRITE for ro device (%llu)\n",
-			   (unsigned long long)bio->bi_sector);
+			   (unsigned long long)bio->bi_iter.bi_sector);
 		goto end_io;
 	}
 
-	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
+	if (!bio->bi_iter.bi_size || (bio->bi_iter.bi_size % CD_FRAMESIZE)) {
 		pkt_err(pd, "wrong bio size\n");
 		goto end_io;
 	}
 
 	blk_queue_bounce(q, &bio);
 
-	zone = get_zone(bio->bi_sector, pd);
+	zone = get_zone(bio->bi_iter.bi_sector, pd);
 	pkt_dbg(2, pd, "start = %6llx stop = %6llx\n",
-		(unsigned long long)bio->bi_sector,
+		(unsigned long long)bio->bi_iter.bi_sector,
 		(unsigned long long)bio_end_sector(bio));
 
 	/* Check if we have to split the bio */
@@ -2395,7 +2398,7 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 		last_zone = get_zone(bio_end_sector(bio) - 1, pd);
 		if (last_zone != zone) {
 			BUG_ON(last_zone != zone + pd->settings.size);
-			first_sectors = last_zone - bio->bi_sector;
+			first_sectors = last_zone - bio->bi_iter.bi_sector;
 			bp = bio_split(bio, first_sectors);
 			BUG_ON(!bp);
 			pkt_make_request(q, &bp->bio1);
@@ -2417,7 +2420,8 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 			if ((pkt->state == PACKET_WAITING_STATE) ||
 			    (pkt->state == PACKET_READ_WAIT_STATE)) {
 				bio_list_add(&pkt->orig_bios, bio);
-				pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+				pkt->write_size +=
+					bio->bi_iter.bi_size / CD_FRAMESIZE;
 				if ((pkt->write_size >= pkt->frames) &&
 				    (pkt->state == PACKET_WAITING_STATE)) {
 					atomic_inc(&pkt->run_sm);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index d754a88..464be78 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -104,7 +104,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: bio %u: %u segs %u sectors from %lu\n",
 			__func__, __LINE__, i, bio_segments(iter.bio),
-			bio_sectors(iter.bio), iter.bio->bi_sector);
+			bio_sectors(iter.bio), iter.bio->bi_iter.bi_sector);
 
 		size = bvec->bv_len;
 		buf = bvec_kmap_irq(bvec, &flags);
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 06a2e53..320bbfc 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -553,7 +553,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int write = bio_data_dir(bio) == WRITE;
 	const char *op = write ? "write" : "read";
-	loff_t offset = bio->bi_sector << 9;
+	loff_t offset = bio->bi_iter.bi_sector << 9;
 	int error = 0;
 	struct bio_vec *bvec;
 	unsigned int i;
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cb1db29..a8f4fe2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1183,14 +1183,14 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 
 	/* Handle the easy case for the caller */
 
-	if (!offset && len == bio_src->bi_size)
+	if (!offset && len == bio_src->bi_iter.bi_size)
 		return bio_clone(bio_src, gfpmask);
 
 	if (WARN_ON_ONCE(!len))
 		return NULL;
-	if (WARN_ON_ONCE(len > bio_src->bi_size))
+	if (WARN_ON_ONCE(len > bio_src->bi_iter.bi_size))
 		return NULL;
-	if (WARN_ON_ONCE(offset > bio_src->bi_size - len))
+	if (WARN_ON_ONCE(offset > bio_src->bi_iter.bi_size - len))
 		return NULL;
 
 	/* Find first affected segment... */
@@ -1220,7 +1220,8 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 		return NULL;	/* ENOMEM */
 
 	bio->bi_bdev = bio_src->bi_bdev;
-	bio->bi_sector = bio_src->bi_sector + (offset >> SECTOR_SHIFT);
+	bio->bi_iter.bi_sector = bio_src->bi_iter.bi_sector +
+		(offset >> SECTOR_SHIFT);
 	bio->bi_rw = bio_src->bi_rw;
 	bio->bi_flags |= 1 << BIO_CLONED;
 
@@ -1239,8 +1240,7 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 	}
 
 	bio->bi_vcnt = vcnt;
-	bio->bi_size = len;
-	bio->bi_idx = 0;
+	bio->bi_iter.bi_size = len;
 
 	return bio;
 }
@@ -1271,7 +1271,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 
 	/* Build up a chain of clone bios up to the limit */
 
-	if (!bi || off >= bi->bi_size || !len)
+	if (!bi || off >= bi->bi_iter.bi_size || !len)
 		return NULL;		/* Nothing to clone */
 
 	end = &chain;
@@ -1283,7 +1283,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 			rbd_warn(NULL, "bio_chain exhausted with %u left", len);
 			goto out_err;	/* EINVAL; ran out of bio's */
 		}
-		bi_size = min_t(unsigned int, bi->bi_size - off, len);
+		bi_size = min_t(unsigned int, bi->bi_iter.bi_size - off, len);
 		bio = bio_clone_range(bi, off, bi_size, gfpmask);
 		if (!bio)
 			goto out_err;	/* ENOMEM */
@@ -1292,7 +1292,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 		end = &bio->bi_next;
 
 		off += bi_size;
-		if (off == bi->bi_size) {
+		if (off == bi->bi_iter.bi_size) {
 			bi = bi->bi_next;
 			off = 0;
 		}
@@ -2186,7 +2186,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 	if (type == OBJ_REQUEST_BIO) {
 		bio_list = data_desc;
-		rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
+		rbd_assert(img_offset ==
+			   bio_list->bi_iter.bi_sector << SECTOR_SHIFT);
 	} else {
 		rbd_assert(type == OBJ_REQUEST_PAGES);
 		pages = data_desc;
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 2284f5d..2839d37 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -174,7 +174,7 @@ static void rsxx_make_request(struct request_queue *q, struct bio *bio)
 	if (!card)
 		goto req_err;
 
-	if (bio->bi_sector + (bio->bi_size >> 9) > get_capacity(card->gendisk))
+	if (bio_end_sector(bio) > get_capacity(card->gendisk))
 		goto req_err;
 
 	if (unlikely(card->halt)) {
@@ -187,7 +187,7 @@ static void rsxx_make_request(struct request_queue *q, struct bio *bio)
 		goto req_err;
 	}
 
-	if (bio->bi_size == 0) {
+	if (bio->bi_iter.bi_size == 0) {
 		dev_err(CARD_TO_DEV(card), "size zero BIO!\n");
 		goto req_err;
 	}
@@ -208,7 +208,7 @@ static void rsxx_make_request(struct request_queue *q, struct bio *bio)
 
 	dev_dbg(CARD_TO_DEV(card), "BIO[%c]: meta: %p addr8: x%llx size: %d\n",
 		 bio_data_dir(bio) ? 'W' : 'R', bio_meta,
-		 (u64)bio->bi_sector << 9, bio->bi_size);
+		 (u64)bio->bi_iter.bi_sector << 9, bio->bi_iter.bi_size);
 
 	st = rsxx_dma_queue_bio(card, bio, &bio_meta->pending_dmas,
 				    bio_dma_done_cb, bio_meta);
diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index fc88ba3..3716633 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -696,7 +696,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 	int st;
 	int i;
 
-	addr8 = bio->bi_sector << 9; /* sectors are 512 bytes */
+	addr8 = bio->bi_iter.bi_sector << 9; /* sectors are 512 bytes */
 	atomic_set(n_dmas, 0);
 
 	for (i = 0; i < card->n_targets; i++) {
@@ -705,7 +705,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 	}
 
 	if (bio->bi_rw & REQ_DISCARD) {
-		bv_len = bio->bi_size;
+		bv_len = bio->bi_iter.bi_size;
 
 		while (bv_len > 0) {
 			tgt   = rsxx_get_dma_tgt(card, addr8);
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index ad70868..dab4f1a 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -352,8 +352,8 @@ static int add_bio(struct cardinfo *card)
 	bio = card->currentbio;
 	if (!bio && card->bio) {
 		card->currentbio = card->bio;
-		card->current_idx = card->bio->bi_idx;
-		card->current_sector = card->bio->bi_sector;
+		card->current_idx = card->bio->bi_iter.bi_idx;
+		card->current_sector = card->bio->bi_iter.bi_sector;
 		card->bio = card->bio->bi_next;
 		if (card->bio == NULL)
 			card->biotail = &card->bio;
@@ -451,7 +451,7 @@ static void process_page(unsigned long data)
 		if (page->idx >= bio->bi_vcnt) {
 			page->bio = bio->bi_next;
 			if (page->bio)
-				page->idx = page->bio->bi_idx;
+				page->idx = page->bio->bi_iter.bi_idx;
 		}
 
 		pci_unmap_page(card->dev, desc->data_dma_handle,
@@ -532,7 +532,8 @@ static void mm_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct cardinfo *card = q->queuedata;
 	pr_debug("mm_make_request %llu %u\n",
-		 (unsigned long long)bio->bi_sector, bio->bi_size);
+		 (unsigned long long)bio->bi_iter.bi_sector,
+		 bio->bi_iter.bi_size);
 
 	spin_lock_irq(&card->lock);
 	*card->biotail = bio;
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6620b73..4b97b86 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1257,7 +1257,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 			bio->bi_bdev    = preq.bdev;
 			bio->bi_private = pending_req;
 			bio->bi_end_io  = end_block_io_op;
-			bio->bi_sector  = preq.sector_number;
+			bio->bi_iter.bi_sector  = preq.sector_number;
 		}
 
 		preq.sector_number += seg[i].nsec;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 432db1b..80e8630 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1547,7 +1547,7 @@ static int blkif_recover(struct blkfront_info *info)
 			for (i = 0; i < pending; i++) {
 				offset = (i * segs * PAGE_SIZE) >> 9;
 				size = min((unsigned int)(segs * PAGE_SIZE) >> 9,
-					   (unsigned int)(bio->bi_size >> 9) - offset);
+					   (unsigned int)bio_sectors(bio) - offset);
 				cloned_bio = bio_clone(bio, GFP_NOIO);
 				BUG_ON(cloned_bio == NULL);
 				bio_trim(cloned_bio, offset, size);
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 5e2765a..038a6d2 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -299,7 +299,7 @@ void bch_btree_node_read(struct btree *b)
 
 	bio = bch_bbio_alloc(b->c);
 	bio->bi_rw	= REQ_META|READ_SYNC;
-	bio->bi_size	= KEY_SIZE(&b->key) << 9;
+	bio->bi_iter.bi_size = KEY_SIZE(&b->key) << 9;
 	bio->bi_end_io	= btree_node_read_endio;
 	bio->bi_private	= &cl;
 
@@ -395,7 +395,7 @@ static void do_btree_node_write(struct btree *b)
 	b->bio->bi_end_io	= btree_node_write_endio;
 	b->bio->bi_private	= cl;
 	b->bio->bi_rw		= REQ_META|WRITE_SYNC|REQ_FUA;
-	b->bio->bi_size		= set_blocks(i, b->c) * block_bytes(b->c);
+	b->bio->bi_iter.bi_size	= set_blocks(i, b->c) * block_bytes(b->c);
 	bch_bio_map(b->bio, i);
 
 	/*
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 264fcfb..92b3fd4 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -195,7 +195,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 				 dc->disk.c,
 				 "verify failed at dev %s sector %llu",
 				 bdevname(dc->bdev, name),
-				 (uint64_t) bio->bi_sector);
+				 (uint64_t) bio->bi_iter.bi_sector);
 
 		kunmap_atomic(p1);
 	}
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index 9056632..cc4ba2d 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -21,18 +21,18 @@ static void bch_bi_idx_hack_endio(struct bio *bio, int error)
 
 static void bch_generic_make_request_hack(struct bio *bio)
 {
-	if (bio->bi_idx) {
+	if (bio->bi_iter.bi_idx) {
 		struct bio *clone = bio_alloc(GFP_NOIO, bio_segments(bio));
 
 		memcpy(clone->bi_io_vec,
 		       bio_iovec(bio),
 		       bio_segments(bio) * sizeof(struct bio_vec));
 
-		clone->bi_sector	= bio->bi_sector;
+		clone->bi_iter.bi_sector = bio->bi_iter.bi_sector;
 		clone->bi_bdev		= bio->bi_bdev;
 		clone->bi_rw		= bio->bi_rw;
 		clone->bi_vcnt		= bio_segments(bio);
-		clone->bi_size		= bio->bi_size;
+		clone->bi_iter.bi_size	= bio->bi_iter.bi_size;
 
 		clone->bi_private	= bio;
 		clone->bi_end_io	= bch_bi_idx_hack_endio;
@@ -72,7 +72,7 @@ static void bch_generic_make_request_hack(struct bio *bio)
 struct bio *bch_bio_split(struct bio *bio, int sectors,
 			  gfp_t gfp, struct bio_set *bs)
 {
-	unsigned idx = bio->bi_idx, vcnt = 0, nbytes = sectors << 9;
+	unsigned idx = bio->bi_iter.bi_idx, vcnt = 0, nbytes = sectors << 9;
 	struct bio_vec *bv;
 	struct bio *ret = NULL;
 
@@ -90,7 +90,7 @@ struct bio *bch_bio_split(struct bio *bio, int sectors,
 	}
 
 	bio_for_each_segment(bv, bio, idx) {
-		vcnt = idx - bio->bi_idx;
+		vcnt = idx - bio->bi_iter.bi_idx;
 
 		if (!nbytes) {
 			ret = bio_alloc_bioset(gfp, vcnt, bs);
@@ -119,15 +119,15 @@ struct bio *bch_bio_split(struct bio *bio, int sectors,
 	}
 out:
 	ret->bi_bdev	= bio->bi_bdev;
-	ret->bi_sector	= bio->bi_sector;
-	ret->bi_size	= sectors << 9;
+	ret->bi_iter.bi_sector	= bio->bi_iter.bi_sector;
+	ret->bi_iter.bi_size	= sectors << 9;
 	ret->bi_rw	= bio->bi_rw;
 	ret->bi_vcnt	= vcnt;
 	ret->bi_max_vecs = vcnt;
 
-	bio->bi_sector	+= sectors;
-	bio->bi_size	-= sectors << 9;
-	bio->bi_idx	 = idx;
+	bio->bi_iter.bi_sector	+= sectors;
+	bio->bi_iter.bi_size	-= sectors << 9;
+	bio->bi_iter.bi_idx	 = idx;
 
 	if (bio_integrity(bio)) {
 		if (bio_integrity_clone(ret, bio, gfp)) {
@@ -162,7 +162,7 @@ static unsigned bch_bio_max_sectors(struct bio *bio)
 		bio_for_each_segment(bv, bio, i) {
 			struct bvec_merge_data bvm = {
 				.bi_bdev	= bio->bi_bdev,
-				.bi_sector	= bio->bi_sector,
+				.bi_sector	= bio->bi_iter.bi_sector,
 				.bi_size	= ret << 9,
 				.bi_rw		= bio->bi_rw,
 			};
@@ -272,8 +272,8 @@ void __bch_submit_bbio(struct bio *bio, struct cache_set *c)
 {
 	struct bbio *b = container_of(bio, struct bbio, bio);
 
-	bio->bi_sector	= PTR_OFFSET(&b->key, 0);
-	bio->bi_bdev	= PTR_CACHE(c, &b->key, 0)->bdev;
+	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
+	bio->bi_bdev		= PTR_CACHE(c, &b->key, 0)->bdev;
 
 	b->submit_time_us = local_clock_us();
 	closure_bio_submit(bio, bio->bi_private, PTR_CACHE(c, &b->key, 0));
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index ecdaa67..7eafdf0 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -51,10 +51,10 @@ reread:		left = ca->sb.bucket_size - offset;
 		len = min_t(unsigned, left, PAGE_SECTORS * 8);
 
 		bio_reset(bio);
-		bio->bi_sector	= bucket + offset;
+		bio->bi_iter.bi_sector	= bucket + offset;
 		bio->bi_bdev	= ca->bdev;
 		bio->bi_rw	= READ;
-		bio->bi_size	= len << 9;
+		bio->bi_iter.bi_size	= len << 9;
 
 		bio->bi_end_io	= journal_read_endio;
 		bio->bi_private = &cl;
@@ -437,13 +437,13 @@ static void do_journal_discard(struct cache *ca)
 		atomic_set(&ja->discard_in_flight, DISCARD_IN_FLIGHT);
 
 		bio_init(bio);
-		bio->bi_sector		= bucket_to_sector(ca->set,
+		bio->bi_iter.bi_sector	= bucket_to_sector(ca->set,
 						ca->sb.d[ja->discard_idx]);
 		bio->bi_bdev		= ca->bdev;
 		bio->bi_rw		= REQ_WRITE|REQ_DISCARD;
 		bio->bi_max_vecs	= 1;
 		bio->bi_io_vec		= bio->bi_inline_vecs;
-		bio->bi_size		= bucket_bytes(ca);
+		bio->bi_iter.bi_size	= bucket_bytes(ca);
 		bio->bi_end_io		= journal_discard_endio;
 
 		closure_get(&ca->set->cl);
@@ -608,10 +608,10 @@ static void journal_write_unlocked(struct closure *cl)
 		atomic_long_add(sectors, &ca->meta_sectors_written);
 
 		bio_reset(bio);
-		bio->bi_sector	= PTR_OFFSET(k, i);
+		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
 		bio->bi_bdev	= ca->bdev;
 		bio->bi_rw	= REQ_WRITE|REQ_SYNC|REQ_META|REQ_FLUSH|REQ_FUA;
-		bio->bi_size	= sectors << 9;
+		bio->bi_iter.bi_size = sectors << 9;
 
 		bio->bi_end_io	= journal_write_endio;
 		bio->bi_private = w;
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 7c1275e..581f95d 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -82,7 +82,7 @@ static void moving_init(struct moving_io *io)
 	bio_get(bio);
 	bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 
-	bio->bi_size		= KEY_SIZE(&io->w->key) << 9;
+	bio->bi_iter.bi_size	= KEY_SIZE(&io->w->key) << 9;
 	bio->bi_max_vecs	= DIV_ROUND_UP(KEY_SIZE(&io->w->key),
 					       PAGE_SECTORS);
 	bio->bi_private		= &io->cl;
@@ -98,7 +98,7 @@ static void write_moving(struct closure *cl)
 	if (!op->error) {
 		moving_init(io);
 
-		io->bio.bio.bi_sector = KEY_START(&io->w->key);
+		io->bio.bio.bi_iter.bi_sector = KEY_START(&io->w->key);
 		op->write_prio		= 1;
 		op->bio			= &io->bio.bio;
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 78bab41..47a9bbc 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -261,7 +261,7 @@ static void bch_data_invalidate(struct closure *cl)
 	struct bio *bio = op->bio;
 
 	pr_debug("invalidating %i sectors from %llu",
-		 bio_sectors(bio), (uint64_t) bio->bi_sector);
+		 bio_sectors(bio), (uint64_t) bio->bi_iter.bi_sector);
 
 	while (bio_sectors(bio)) {
 		unsigned sectors = min(bio_sectors(bio),
@@ -270,11 +270,11 @@ static void bch_data_invalidate(struct closure *cl)
 		if (bch_keylist_realloc(&op->insert_keys, 0, op->c))
 			goto out;
 
-		bio->bi_sector	+= sectors;
-		bio->bi_size	-= sectors << 9;
+		bio->bi_iter.bi_sector	+= sectors;
+		bio->bi_iter.bi_size	-= sectors << 9;
 
 		bch_keylist_add(&op->insert_keys,
-				&KEY(op->inode, bio->bi_sector, sectors));
+				&KEY(op->inode, bio->bi_iter.bi_sector, sectors));
 	}
 
 	op->insert_data_done = true;
@@ -364,7 +364,7 @@ static void bch_data_insert_start(struct closure *cl)
 		k = op->insert_keys.top;
 		bkey_init(k);
 		SET_KEY_INODE(k, op->inode);
-		SET_KEY_OFFSET(k, bio->bi_sector);
+		SET_KEY_OFFSET(k, bio->bi_iter.bi_sector);
 
 		if (!bch_alloc_sectors(op->c, k, bio_sectors(bio),
 				       op->write_point, op->write_prio,
@@ -522,7 +522,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	     (bio->bi_rw & REQ_WRITE)))
 		goto skip;
 
-	if (bio->bi_sector & (c->sb.block_size - 1) ||
+	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
 	    bio_sectors(bio) & (c->sb.block_size - 1)) {
 		pr_debug("skipping unaligned io");
 		goto skip;
@@ -546,8 +546,8 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 
 	spin_lock(&dc->io_lock);
 
-	hlist_for_each_entry(i, iohash(dc, bio->bi_sector), hash)
-		if (i->last == bio->bi_sector &&
+	hlist_for_each_entry(i, iohash(dc, bio->bi_iter.bi_sector), hash)
+		if (i->last == bio->bi_iter.bi_sector &&
 		    time_before(jiffies, i->jiffies))
 			goto found;
 
@@ -556,8 +556,8 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	add_sequential(task);
 	i->sequential = 0;
 found:
-	if (i->sequential + bio->bi_size > i->sequential)
-		i->sequential	+= bio->bi_size;
+	if (i->sequential + bio->bi_iter.bi_size > i->sequential)
+		i->sequential	+= bio->bi_iter.bi_size;
 
 	i->last			 = bio_end_sector(bio);
 	i->jiffies		 = jiffies + msecs_to_jiffies(5000);
@@ -650,15 +650,15 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 	struct bkey *bio_key;
 	unsigned ptr;
 
-	if (bkey_cmp(k, &KEY(s->iop.inode, bio->bi_sector, 0)) <= 0)
+	if (bkey_cmp(k, &KEY(s->iop.inode, bio->bi_iter.bi_sector, 0)) <= 0)
 		return MAP_CONTINUE;
 
 	if (KEY_INODE(k) != s->iop.inode ||
-	    KEY_START(k) > bio->bi_sector) {
+	    KEY_START(k) > bio->bi_iter.bi_sector) {
 		unsigned bio_sectors = bio_sectors(bio);
 		unsigned sectors = KEY_INODE(k) == s->iop.inode
 			? min_t(uint64_t, INT_MAX,
-				KEY_START(k) - bio->bi_sector)
+				KEY_START(k) - bio->bi_iter.bi_sector)
 			: INT_MAX;
 
 		int ret = s->d->cache_miss(b, s, bio, sectors);
@@ -681,13 +681,13 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 		s->read_dirty_data = true;
 
 	n = bch_bio_split(bio, min_t(uint64_t, INT_MAX,
-				     KEY_OFFSET(k) - bio->bi_sector),
+				     KEY_OFFSET(k) - bio->bi_iter.bi_sector),
 			  GFP_NOIO, s->d->bio_split);
 
 	bio_key = &container_of(n, struct bbio, bio)->key;
 	bch_bkey_copy_single_ptr(bio_key, k, ptr);
 
-	bch_cut_front(&KEY(s->iop.inode, n->bi_sector, 0), bio_key);
+	bch_cut_front(&KEY(s->iop.inode, n->bi_iter.bi_sector, 0), bio_key);
 	bch_cut_back(&KEY(s->iop.inode, bio_end_sector(n), 0), bio_key);
 
 	n->bi_end_io	= bch_cache_read_endio;
@@ -714,7 +714,7 @@ static void cache_lookup(struct closure *cl)
 	struct bio *bio = &s->bio.bio;
 
 	int ret = bch_btree_map_keys(&s->op, s->iop.c,
-				     &KEY(s->iop.inode, bio->bi_sector, 0),
+				     &KEY(s->iop.inode, bio->bi_iter.bi_sector, 0),
 				     cache_lookup_fn, MAP_END_KEY);
 	if (ret == -EAGAIN)
 		continue_at(cl, cache_lookup, bcache_wq);
@@ -872,9 +872,9 @@ static void cached_dev_read_done(struct closure *cl)
 
 	if (s->iop.bio) {
 		bio_reset(s->iop.bio);
-		s->iop.bio->bi_sector = s->cache_miss->bi_sector;
+		s->iop.bio->bi_iter.bi_sector = s->cache_miss->bi_iter.bi_sector;
 		s->iop.bio->bi_bdev = s->cache_miss->bi_bdev;
-		s->iop.bio->bi_size = s->insert_bio_sectors << 9;
+		s->iop.bio->bi_iter.bi_size = s->insert_bio_sectors << 9;
 		bch_bio_map(s->iop.bio, NULL);
 
 		bio_copy_data(s->cache_miss, s->iop.bio);
@@ -937,7 +937,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	s->insert_bio_sectors = min(sectors, bio_sectors(bio) + reada);
 
 	s->iop.replace_key = KEY(s->iop.inode,
-				 bio->bi_sector + s->insert_bio_sectors,
+				 bio->bi_iter.bi_sector + s->insert_bio_sectors,
 				 s->insert_bio_sectors);
 
 	ret = bch_btree_insert_check_key(b, &s->op, &s->iop.replace_key);
@@ -957,9 +957,9 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	if (!cache_bio)
 		goto out_submit;
 
-	cache_bio->bi_sector	= miss->bi_sector;
-	cache_bio->bi_bdev	= miss->bi_bdev;
-	cache_bio->bi_size	= s->insert_bio_sectors << 9;
+	cache_bio->bi_iter.bi_sector	= miss->bi_iter.bi_sector;
+	cache_bio->bi_bdev		= miss->bi_bdev;
+	cache_bio->bi_iter.bi_size	= s->insert_bio_sectors << 9;
 
 	cache_bio->bi_end_io	= request_endio;
 	cache_bio->bi_private	= &s->cl;
@@ -1009,7 +1009,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
 {
 	struct closure *cl = &s->cl;
 	struct bio *bio = &s->bio.bio;
-	struct bkey start = KEY(dc->disk.id, bio->bi_sector, 0);
+	struct bkey start = KEY(dc->disk.id, bio->bi_iter.bi_sector, 0);
 	struct bkey end = KEY(dc->disk.id, bio_end_sector(bio), 0);
 
 	bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys, &start, &end);
@@ -1104,13 +1104,13 @@ static void cached_dev_make_request(struct request_queue *q, struct bio *bio)
 	part_stat_unlock();
 
 	bio->bi_bdev = dc->bdev;
-	bio->bi_sector += dc->sb.data_offset;
+	bio->bi_iter.bi_sector += dc->sb.data_offset;
 
 	if (cached_dev_get(dc)) {
 		s = search_alloc(bio, d);
 		trace_bcache_request_start(s->d, bio);
 
-		if (!bio->bi_size) {
+		if (!bio->bi_iter.bi_size) {
 			/*
 			 * can't call bch_journal_meta from under
 			 * generic_make_request
@@ -1197,9 +1197,9 @@ static int flash_dev_cache_miss(struct btree *b, struct search *s,
 		sectors	-= j;
 	}
 
-	bio_advance(bio, min(sectors << 9, bio->bi_size));
+	bio_advance(bio, min(sectors << 9, bio->bi_iter.bi_size));
 
-	if (!bio->bi_size)
+	if (!bio->bi_iter.bi_size)
 		return MAP_DONE;
 
 	return MAP_CONTINUE;
@@ -1233,7 +1233,7 @@ static void flash_dev_make_request(struct request_queue *q, struct bio *bio)
 
 	trace_bcache_request_start(s->d, bio);
 
-	if (!bio->bi_size) {
+	if (!bio->bi_iter.bi_size) {
 		/*
 		 * can't call bch_journal_meta from under
 		 * generic_make_request
@@ -1243,7 +1243,7 @@ static void flash_dev_make_request(struct request_queue *q, struct bio *bio)
 				      bcache_wq);
 	} else if (rw) {
 		bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys,
-					&KEY(d->id, bio->bi_sector, 0),
+					&KEY(d->id, bio->bi_iter.bi_sector, 0),
 					&KEY(d->id, bio_end_sector(bio), 0));
 
 		s->iop.bypass		= (bio->bi_rw & REQ_DISCARD) != 0;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1d9ee67..60fb604 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -233,9 +233,9 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
 	struct cache_sb *out = page_address(bio->bi_io_vec[0].bv_page);
 	unsigned i;
 
-	bio->bi_sector	= SB_SECTOR;
-	bio->bi_rw	= REQ_SYNC|REQ_META;
-	bio->bi_size	= SB_SIZE;
+	bio->bi_iter.bi_sector	= SB_SECTOR;
+	bio->bi_rw		= REQ_SYNC|REQ_META;
+	bio->bi_iter.bi_size	= SB_SIZE;
 	bch_bio_map(bio, NULL);
 
 	out->offset		= cpu_to_le64(sb->offset);
@@ -347,7 +347,7 @@ static void uuid_io(struct cache_set *c, unsigned long rw,
 		struct bio *bio = bch_bbio_alloc(c);
 
 		bio->bi_rw	= REQ_SYNC|REQ_META|rw;
-		bio->bi_size	= KEY_SIZE(k) << 9;
+		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
 
 		bio->bi_end_io	= uuid_endio;
 		bio->bi_private = cl;
@@ -503,10 +503,10 @@ static void prio_io(struct cache *ca, uint64_t bucket, unsigned long rw)
 
 	closure_init_stack(cl);
 
-	bio->bi_sector	= bucket * ca->sb.bucket_size;
-	bio->bi_bdev	= ca->bdev;
-	bio->bi_rw	= REQ_SYNC|REQ_META|rw;
-	bio->bi_size	= bucket_bytes(ca);
+	bio->bi_iter.bi_sector	= bucket * ca->sb.bucket_size;
+	bio->bi_bdev		= ca->bdev;
+	bio->bi_rw		= REQ_SYNC|REQ_META|rw;
+	bio->bi_iter.bi_size	= bucket_bytes(ca);
 
 	bio->bi_end_io	= prio_endio;
 	bio->bi_private = ca;
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 462214e..c57621e 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -218,10 +218,10 @@ uint64_t bch_next_delay(struct bch_ratelimit *d, uint64_t done)
 
 void bch_bio_map(struct bio *bio, void *base)
 {
-	size_t size = bio->bi_size;
+	size_t size = bio->bi_iter.bi_size;
 	struct bio_vec *bv = bio->bi_io_vec;
 
-	BUG_ON(!bio->bi_size);
+	BUG_ON(!bio->bi_iter.bi_size);
 	BUG_ON(bio->bi_vcnt);
 
 	bv->bv_offset = base ? ((unsigned long) base) % PAGE_SIZE : 0;
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 99053b1..04657e9 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -113,7 +113,7 @@ static void dirty_init(struct keybuf_key *w)
 	if (!io->dc->writeback_percent)
 		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 
-	bio->bi_size		= KEY_SIZE(&w->key) << 9;
+	bio->bi_iter.bi_size	= KEY_SIZE(&w->key) << 9;
 	bio->bi_max_vecs	= DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS);
 	bio->bi_private		= w;
 	bio->bi_io_vec		= bio->bi_inline_vecs;
@@ -186,7 +186,7 @@ static void write_dirty(struct closure *cl)
 
 	dirty_init(w);
 	io->bio.bi_rw		= WRITE;
-	io->bio.bi_sector	= KEY_START(&w->key);
+	io->bio.bi_iter.bi_sector = KEY_START(&w->key);
 	io->bio.bi_bdev		= io->dc->bdev;
 	io->bio.bi_end_io	= dirty_endio;
 
@@ -255,7 +255,7 @@ static void read_dirty(struct cached_dev *dc)
 		io->dc		= dc;
 
 		dirty_init(w);
-		io->bio.bi_sector	= PTR_OFFSET(&w->key, 0);
+		io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
 		io->bio.bi_bdev		= PTR_CACHE(dc->disk.c,
 						    &w->key, 0)->bdev;
 		io->bio.bi_rw		= READ;
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index c9ddcf4..e2f8598 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -50,7 +50,7 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 		return false;
 
 	if (dc->partial_stripes_expensive &&
-	    bcache_dev_stripe_dirty(dc, bio->bi_sector,
+	    bcache_dev_stripe_dirty(dc, bio->bi_iter.bi_sector,
 				    bio_sectors(bio)))
 		return true;
 
diff --git a/drivers/md/dm-bio-record.h b/drivers/md/dm-bio-record.h
index 3a8cfa2..5ace48e 100644
--- a/drivers/md/dm-bio-record.h
+++ b/drivers/md/dm-bio-record.h
@@ -40,10 +40,10 @@ static inline void dm_bio_record(struct dm_bio_details *bd, struct bio *bio)
 {
 	unsigned i;
 
-	bd->bi_sector = bio->bi_sector;
+	bd->bi_sector = bio->bi_iter.bi_sector;
 	bd->bi_bdev = bio->bi_bdev;
-	bd->bi_size = bio->bi_size;
-	bd->bi_idx = bio->bi_idx;
+	bd->bi_size = bio->bi_iter.bi_size;
+	bd->bi_idx = bio->bi_iter.bi_idx;
 	bd->bi_flags = bio->bi_flags;
 
 	for (i = 0; i < bio->bi_vcnt; i++) {
@@ -56,10 +56,10 @@ static inline void dm_bio_restore(struct dm_bio_details *bd, struct bio *bio)
 {
 	unsigned i;
 
-	bio->bi_sector = bd->bi_sector;
+	bio->bi_iter.bi_sector = bd->bi_sector;
 	bio->bi_bdev = bd->bi_bdev;
-	bio->bi_size = bd->bi_size;
-	bio->bi_idx = bd->bi_idx;
+	bio->bi_iter.bi_size = bd->bi_size;
+	bio->bi_iter.bi_idx = bd->bi_idx;
 	bio->bi_flags = bd->bi_flags;
 
 	for (i = 0; i < bio->bi_vcnt; i++) {
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 173cbb2..4113b60 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -538,7 +538,7 @@ static void use_inline_bio(struct dm_buffer *b, int rw, sector_t block,
 	bio_init(&b->bio);
 	b->bio.bi_io_vec = b->bio_vec;
 	b->bio.bi_max_vecs = DM_BUFIO_INLINE_VECS;
-	b->bio.bi_sector = block << b->c->sectors_per_block_bits;
+	b->bio.bi_iter.bi_sector = block << b->c->sectors_per_block_bits;
 	b->bio.bi_bdev = b->c->bdev;
 	b->bio.bi_end_io = end_io;
 
diff --git a/drivers/md/dm-cache-policy-mq.c b/drivers/md/dm-cache-policy-mq.c
index 416b7b7..bfba97d 100644
--- a/drivers/md/dm-cache-policy-mq.c
+++ b/drivers/md/dm-cache-policy-mq.c
@@ -72,7 +72,7 @@ static enum io_pattern iot_pattern(struct io_tracker *t)
 
 static void iot_update_stats(struct io_tracker *t, struct bio *bio)
 {
-	if (bio->bi_sector == from_oblock(t->last_end_oblock) + 1)
+	if (bio->bi_iter.bi_sector == from_oblock(t->last_end_oblock) + 1)
 		t->nr_seq_samples++;
 	else {
 		/*
@@ -87,7 +87,7 @@ static void iot_update_stats(struct io_tracker *t, struct bio *bio)
 		t->nr_rand_samples++;
 	}
 
-	t->last_end_oblock = to_oblock(bio->bi_sector + bio_sectors(bio) - 1);
+	t->last_end_oblock = to_oblock(bio_end_sector(bio) - 1);
 }
 
 static void iot_check_for_pattern_switch(struct io_tracker *t)
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 9efcf10..86f9c83 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -664,15 +664,17 @@ static void remap_to_origin(struct cache *cache, struct bio *bio)
 static void remap_to_cache(struct cache *cache, struct bio *bio,
 			   dm_cblock_t cblock)
 {
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	bio->bi_bdev = cache->cache_dev->bdev;
 	if (!block_size_is_power_of_two(cache))
-		bio->bi_sector = (from_cblock(cblock) * cache->sectors_per_block) +
-				sector_div(bi_sector, cache->sectors_per_block);
+		bio->bi_iter.bi_sector =
+			(from_cblock(cblock) * cache->sectors_per_block) +
+			sector_div(bi_sector, cache->sectors_per_block);
 	else
-		bio->bi_sector = (from_cblock(cblock) << cache->sectors_per_block_shift) |
-				(bi_sector & (cache->sectors_per_block - 1));
+		bio->bi_iter.bi_sector =
+			(from_cblock(cblock) << cache->sectors_per_block_shift) |
+			(bi_sector & (cache->sectors_per_block - 1));
 }
 
 static void check_if_tick_bio_needed(struct cache *cache, struct bio *bio)
@@ -712,7 +714,7 @@ static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
 
 static dm_oblock_t get_bio_block(struct cache *cache, struct bio *bio)
 {
-	sector_t block_nr = bio->bi_sector;
+	sector_t block_nr = bio->bi_iter.bi_sector;
 
 	if (!block_size_is_power_of_two(cache))
 		(void) sector_div(block_nr, cache->sectors_per_block);
@@ -1027,7 +1029,7 @@ static void issue_overwrite(struct dm_cache_migration *mg, struct bio *bio)
 static bool bio_writes_complete_block(struct cache *cache, struct bio *bio)
 {
 	return (bio_data_dir(bio) == WRITE) &&
-		(bio->bi_size == (cache->sectors_per_block << SECTOR_SHIFT));
+		(bio->bi_iter.bi_size == (cache->sectors_per_block << SECTOR_SHIFT));
 }
 
 static void avoid_copy(struct dm_cache_migration *mg)
@@ -1252,7 +1254,7 @@ static void process_flush_bio(struct cache *cache, struct bio *bio)
 	size_t pb_data_size = get_per_bio_data_size(cache);
 	struct per_bio_data *pb = get_per_bio_data(bio, pb_data_size);
 
-	BUG_ON(bio->bi_size);
+	BUG_ON(bio->bi_iter.bi_size);
 	if (!pb->req_nr)
 		remap_to_origin(cache, bio);
 	else
@@ -1275,9 +1277,9 @@ static void process_flush_bio(struct cache *cache, struct bio *bio)
  */
 static void process_discard_bio(struct cache *cache, struct bio *bio)
 {
-	dm_block_t start_block = dm_sector_div_up(bio->bi_sector,
+	dm_block_t start_block = dm_sector_div_up(bio->bi_iter.bi_sector,
 						  cache->discard_block_size);
-	dm_block_t end_block = bio->bi_sector + bio_sectors(bio);
+	dm_block_t end_block = bio_end_sector(bio);
 	dm_block_t b;
 
 	end_block = block_div(end_block, cache->discard_block_size);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 81b0fa6..1e2e546 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -828,8 +828,8 @@ static void crypt_convert_init(struct crypt_config *cc,
 	ctx->bio_out = bio_out;
 	ctx->offset_in = 0;
 	ctx->offset_out = 0;
-	ctx->idx_in = bio_in ? bio_in->bi_idx : 0;
-	ctx->idx_out = bio_out ? bio_out->bi_idx : 0;
+	ctx->idx_in = bio_in ? bio_in->bi_iter.bi_idx : 0;
+	ctx->idx_out = bio_out ? bio_out->bi_iter.bi_idx : 0;
 	ctx->cc_sector = sector + cc->iv_offset;
 	init_completion(&ctx->restart);
 }
@@ -1021,7 +1021,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size,
 		size -= len;
 	}
 
-	if (!clone->bi_size) {
+	if (!clone->bi_iter.bi_size) {
 		bio_put(clone);
 		return NULL;
 	}
@@ -1161,7 +1161,7 @@ static int kcryptd_io_read(struct dm_crypt_io *io, gfp_t gfp)
 	crypt_inc_pending(io);
 
 	clone_init(io, clone);
-	clone->bi_sector = cc->start + io->sector;
+	clone->bi_iter.bi_sector = cc->start + io->sector;
 
 	generic_make_request(clone);
 	return 0;
@@ -1209,7 +1209,7 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 	/* crypt_convert should have filled the clone bio */
 	BUG_ON(io->ctx.idx_out < clone->bi_vcnt);
 
-	clone->bi_sector = cc->start + io->sector;
+	clone->bi_iter.bi_sector = cc->start + io->sector;
 
 	if (async)
 		kcryptd_queue_io(io);
@@ -1224,7 +1224,7 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	struct dm_crypt_io *new_io;
 	int crypt_finished;
 	unsigned out_of_pages = 0;
-	unsigned remaining = io->base_bio->bi_size;
+	unsigned remaining = io->base_bio->bi_iter.bi_size;
 	sector_t sector = io->sector;
 	int r;
 
@@ -1248,7 +1248,7 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 		io->ctx.bio_out = clone;
 		io->ctx.idx_out = 0;
 
-		remaining -= clone->bi_size;
+		remaining -= clone->bi_iter.bi_size;
 		sector += bio_sectors(clone);
 
 		crypt_inc_pending(io);
@@ -1869,11 +1869,12 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	if (unlikely(bio->bi_rw & (REQ_FLUSH | REQ_DISCARD))) {
 		bio->bi_bdev = cc->dev->bdev;
 		if (bio_sectors(bio))
-			bio->bi_sector = cc->start + dm_target_offset(ti, bio->bi_sector);
+			bio->bi_iter.bi_sector = cc->start +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
 		return DM_MAPIO_REMAPPED;
 	}
 
-	io = crypt_io_alloc(cc, bio, dm_target_offset(ti, bio->bi_sector));
+	io = crypt_io_alloc(cc, bio, dm_target_offset(ti, bio->bi_iter.bi_sector));
 
 	if (bio_data_dir(io->base_bio) == READ) {
 		if (kcryptd_io_read(io, GFP_NOWAIT))
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 496d5f3..84c8601 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -281,14 +281,15 @@ static int delay_map(struct dm_target *ti, struct bio *bio)
 	if ((bio_data_dir(bio) == WRITE) && (dc->dev_write)) {
 		bio->bi_bdev = dc->dev_write->bdev;
 		if (bio_sectors(bio))
-			bio->bi_sector = dc->start_write +
-					 dm_target_offset(ti, bio->bi_sector);
+			bio->bi_iter.bi_sector = dc->start_write +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
 
 		return delay_bio(dc, dc->write_delay, bio);
 	}
 
 	bio->bi_bdev = dc->dev_read->bdev;
-	bio->bi_sector = dc->start_read + dm_target_offset(ti, bio->bi_sector);
+	bio->bi_iter.bi_sector = dc->start_read +
+		dm_target_offset(ti, bio->bi_iter.bi_sector);
 
 	return delay_bio(dc, dc->read_delay, bio);
 }
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index c80a0ec..b257e46 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -248,7 +248,8 @@ static void flakey_map_bio(struct dm_target *ti, struct bio *bio)
 
 	bio->bi_bdev = fc->dev->bdev;
 	if (bio_sectors(bio))
-		bio->bi_sector = flakey_map_sector(ti, bio->bi_sector);
+		bio->bi_iter.bi_sector =
+			flakey_map_sector(ti, bio->bi_iter.bi_sector);
 }
 
 static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc)
@@ -265,8 +266,8 @@ static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc)
 		DMDEBUG("Corrupting data bio=%p by writing %u to byte %u "
 			"(rw=%c bi_rw=%lu bi_sector=%llu cur_bytes=%u)\n",
 			bio, fc->corrupt_bio_value, fc->corrupt_bio_byte,
-			(bio_data_dir(bio) == WRITE) ? 'w' : 'r',
-			bio->bi_rw, (unsigned long long)bio->bi_sector, bio_bytes);
+			(bio_data_dir(bio) == WRITE) ? 'w' : 'r', bio->bi_rw,
+			(unsigned long long)bio->bi_iter.bi_sector, bio_bytes);
 	}
 }
 
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2a20986..01558b0 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -304,14 +304,14 @@ static void do_region(int rw, unsigned region, struct dm_io_region *where,
 					  dm_sector_div_up(remaining, (PAGE_SIZE >> SECTOR_SHIFT)));
 
 		bio = bio_alloc_bioset(GFP_NOIO, num_bvecs, io->client->bios);
-		bio->bi_sector = where->sector + (where->count - remaining);
+		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
 		bio->bi_bdev = where->bdev;
 		bio->bi_end_io = endio;
 		store_io_and_region_in_bio(bio, io, region);
 
 		if (rw & REQ_DISCARD) {
 			num_sectors = min_t(sector_t, q->limits.max_discard_sectors, remaining);
-			bio->bi_size = num_sectors << SECTOR_SHIFT;
+			bio->bi_iter.bi_size = num_sectors << SECTOR_SHIFT;
 			remaining -= num_sectors;
 		} else if (rw & REQ_WRITE_SAME) {
 			/*
@@ -320,7 +320,7 @@ static void do_region(int rw, unsigned region, struct dm_io_region *where,
 			dp->get_page(dp, &page, &len, &offset);
 			bio_add_page(bio, page, logical_block_size, offset);
 			num_sectors = min_t(sector_t, q->limits.max_write_same_sectors, remaining);
-			bio->bi_size = num_sectors << SECTOR_SHIFT;
+			bio->bi_iter.bi_size = num_sectors << SECTOR_SHIFT;
 
 			offset = 0;
 			remaining -= num_sectors;
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 4f99d26..53e848c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -85,7 +85,8 @@ static void linear_map_bio(struct dm_target *ti, struct bio *bio)
 
 	bio->bi_bdev = lc->dev->bdev;
 	if (bio_sectors(bio))
-		bio->bi_sector = linear_map_sector(ti, bio->bi_sector);
+		bio->bi_iter.bi_sector =
+			linear_map_sector(ti, bio->bi_iter.bi_sector);
 }
 
 static int linear_map(struct dm_target *ti, struct bio *bio)
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 9584443..9f6d8e6 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -432,7 +432,7 @@ static int mirror_available(struct mirror_set *ms, struct bio *bio)
 	region_t region = dm_rh_bio_to_region(ms->rh, bio);
 
 	if (log->type->in_sync(log, region, 0))
-		return choose_mirror(ms,  bio->bi_sector) ? 1 : 0;
+		return choose_mirror(ms,  bio->bi_iter.bi_sector) ? 1 : 0;
 
 	return 0;
 }
@@ -442,15 +442,15 @@ static int mirror_available(struct mirror_set *ms, struct bio *bio)
  */
 static sector_t map_sector(struct mirror *m, struct bio *bio)
 {
-	if (unlikely(!bio->bi_size))
+	if (unlikely(!bio->bi_iter.bi_size))
 		return 0;
-	return m->offset + dm_target_offset(m->ms->ti, bio->bi_sector);
+	return m->offset + dm_target_offset(m->ms->ti, bio->bi_iter.bi_sector);
 }
 
 static void map_bio(struct mirror *m, struct bio *bio)
 {
 	bio->bi_bdev = m->dev->bdev;
-	bio->bi_sector = map_sector(m, bio);
+	bio->bi_iter.bi_sector = map_sector(m, bio);
 }
 
 static void map_region(struct dm_io_region *io, struct mirror *m,
@@ -527,7 +527,7 @@ static void read_async_bio(struct mirror *m, struct bio *bio)
 	struct dm_io_request io_req = {
 		.bi_rw = READ,
 		.mem.type = DM_IO_BVEC,
-		.mem.ptr.bvec = bio->bi_io_vec + bio->bi_idx,
+		.mem.ptr.bvec = bio->bi_io_vec + bio->bi_iter.bi_idx,
 		.notify.fn = read_callback,
 		.notify.context = bio,
 		.client = m->ms->io_client,
@@ -559,7 +559,7 @@ static void do_reads(struct mirror_set *ms, struct bio_list *reads)
 		 * We can only read balance if the region is in sync.
 		 */
 		if (likely(region_in_sync(ms, region, 1)))
-			m = choose_mirror(ms, bio->bi_sector);
+			m = choose_mirror(ms, bio->bi_iter.bi_sector);
 		else if (m && atomic_read(&m->error_count))
 			m = NULL;
 
@@ -630,7 +630,7 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	struct dm_io_request io_req = {
 		.bi_rw = WRITE | (bio->bi_rw & WRITE_FLUSH_FUA),
 		.mem.type = DM_IO_BVEC,
-		.mem.ptr.bvec = bio->bi_io_vec + bio->bi_idx,
+		.mem.ptr.bvec = bio->bi_io_vec + bio->bi_iter.bi_idx,
 		.notify.fn = write_callback,
 		.notify.context = bio,
 		.client = ms->io_client,
@@ -1181,7 +1181,7 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 	 * The region is in-sync and we can perform reads directly.
 	 * Store enough information so we can retry if it fails.
 	 */
-	m = choose_mirror(ms, bio->bi_sector);
+	m = choose_mirror(ms, bio->bi_iter.bi_sector);
 	if (unlikely(!m))
 		return -EIO;
 
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 69732e0..b929fd5 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -126,7 +126,8 @@ EXPORT_SYMBOL_GPL(dm_rh_region_to_sector);
 
 region_t dm_rh_bio_to_region(struct dm_region_hash *rh, struct bio *bio)
 {
-	return dm_rh_sector_to_region(rh, bio->bi_sector - rh->target_begin);
+	return dm_rh_sector_to_region(rh, bio->bi_iter.bi_sector -
+				      rh->target_begin);
 }
 EXPORT_SYMBOL_GPL(dm_rh_bio_to_region);
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index aec57d7..3ded8c7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1562,11 +1562,10 @@ static void remap_exception(struct dm_snapshot *s, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
 	bio->bi_bdev = s->cow->bdev;
-	bio->bi_sector = chunk_to_sector(s->store,
-					 dm_chunk_number(e->new_chunk) +
-					 (chunk - e->old_chunk)) +
-					 (bio->bi_sector &
-					  s->store->chunk_mask);
+	bio->bi_iter.bi_sector =
+		chunk_to_sector(s->store, dm_chunk_number(e->new_chunk) +
+				(chunk - e->old_chunk)) +
+		(bio->bi_iter.bi_sector & s->store->chunk_mask);
 }
 
 static int snapshot_map(struct dm_target *ti, struct bio *bio)
@@ -1584,7 +1583,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
 
-	chunk = sector_to_chunk(s->store, bio->bi_sector);
+	chunk = sector_to_chunk(s->store, bio->bi_iter.bi_sector);
 
 	/* Full snapshots are not usable */
 	/* To get here the table must be live so s->active is always set. */
@@ -1645,7 +1644,8 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 		r = DM_MAPIO_SUBMITTED;
 
 		if (!pe->started &&
-		    bio->bi_size == (s->store->chunk_size << SECTOR_SHIFT)) {
+		    bio->bi_iter.bi_size ==
+		    (s->store->chunk_size << SECTOR_SHIFT)) {
 			pe->started = 1;
 			up_write(&s->lock);
 			start_full_bio(pe, bio);
@@ -1701,7 +1701,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
 
-	chunk = sector_to_chunk(s->store, bio->bi_sector);
+	chunk = sector_to_chunk(s->store, bio->bi_iter.bi_sector);
 
 	down_write(&s->lock);
 
@@ -2038,7 +2038,7 @@ static int do_origin(struct dm_dev *origin, struct bio *bio)
 	down_read(&_origins_lock);
 	o = __lookup_origin(origin->bdev);
 	if (o)
-		r = __origin_write(&o->snapshots, bio->bi_sector, bio);
+		r = __origin_write(&o->snapshots, bio->bi_iter.bi_sector, bio);
 	up_read(&_origins_lock);
 
 	return r;
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 73c1712..d1600d2 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -259,13 +259,15 @@ static int stripe_map_range(struct stripe_c *sc, struct bio *bio,
 {
 	sector_t begin, end;
 
-	stripe_map_range_sector(sc, bio->bi_sector, target_stripe, &begin);
+	stripe_map_range_sector(sc, bio->bi_iter.bi_sector,
+				target_stripe, &begin);
 	stripe_map_range_sector(sc, bio_end_sector(bio),
 				target_stripe, &end);
 	if (begin < end) {
 		bio->bi_bdev = sc->stripe[target_stripe].dev->bdev;
-		bio->bi_sector = begin + sc->stripe[target_stripe].physical_start;
-		bio->bi_size = to_bytes(end - begin);
+		bio->bi_iter.bi_sector = begin +
+			sc->stripe[target_stripe].physical_start;
+		bio->bi_iter.bi_size = to_bytes(end - begin);
 		return DM_MAPIO_REMAPPED;
 	} else {
 		/* The range doesn't map to the target stripe */
@@ -293,9 +295,10 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 		return stripe_map_range(sc, bio, target_bio_nr);
 	}
 
-	stripe_map_sector(sc, bio->bi_sector, &stripe, &bio->bi_sector);
+	stripe_map_sector(sc, bio->bi_iter.bi_sector,
+			  &stripe, &bio->bi_iter.bi_sector);
 
-	bio->bi_sector += sc->stripe[stripe].physical_start;
+	bio->bi_iter.bi_sector += sc->stripe[stripe].physical_start;
 	bio->bi_bdev = sc->stripe[stripe].dev->bdev;
 
 	return DM_MAPIO_REMAPPED;
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index ff9ac4b..09a688b 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -311,11 +311,11 @@ error:
 static int switch_map(struct dm_target *ti, struct bio *bio)
 {
 	struct switch_ctx *sctx = ti->private;
-	sector_t offset = dm_target_offset(ti, bio->bi_sector);
+	sector_t offset = dm_target_offset(ti, bio->bi_iter.bi_sector);
 	unsigned path_nr = switch_get_path_nr(sctx, offset);
 
 	bio->bi_bdev = sctx->path_list[path_nr].dmdev->bdev;
-	bio->bi_sector = sctx->path_list[path_nr].start + offset;
+	bio->bi_iter.bi_sector = sctx->path_list[path_nr].start + offset;
 
 	return DM_MAPIO_REMAPPED;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 2c0cf51..a654024 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -413,7 +413,7 @@ static bool block_size_is_power_of_two(struct pool *pool)
 static dm_block_t get_bio_block(struct thin_c *tc, struct bio *bio)
 {
 	struct pool *pool = tc->pool;
-	sector_t block_nr = bio->bi_sector;
+	sector_t block_nr = bio->bi_iter.bi_sector;
 
 	if (block_size_is_power_of_two(pool))
 		block_nr >>= pool->sectors_per_block_shift;
@@ -426,14 +426,15 @@ static dm_block_t get_bio_block(struct thin_c *tc, struct bio *bio)
 static void remap(struct thin_c *tc, struct bio *bio, dm_block_t block)
 {
 	struct pool *pool = tc->pool;
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	bio->bi_bdev = tc->pool_dev->bdev;
 	if (block_size_is_power_of_two(pool))
-		bio->bi_sector = (block << pool->sectors_per_block_shift) |
-				(bi_sector & (pool->sectors_per_block - 1));
+		bio->bi_iter.bi_sector =
+			(block << pool->sectors_per_block_shift) |
+			(bi_sector & (pool->sectors_per_block - 1));
 	else
-		bio->bi_sector = (block * pool->sectors_per_block) +
+		bio->bi_iter.bi_sector = (block * pool->sectors_per_block) +
 				 sector_div(bi_sector, pool->sectors_per_block);
 }
 
@@ -721,7 +722,8 @@ static void process_prepared(struct pool *pool, struct list_head *head,
  */
 static int io_overlaps_block(struct pool *pool, struct bio *bio)
 {
-	return bio->bi_size == (pool->sectors_per_block << SECTOR_SHIFT);
+	return bio->bi_iter.bi_size ==
+		(pool->sectors_per_block << SECTOR_SHIFT);
 }
 
 static int io_overwrites_block(struct pool *pool, struct bio *bio)
@@ -1130,7 +1132,7 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
 	if (bio_detain(pool, &key, bio, &cell))
 		return;
 
-	if (bio_data_dir(bio) == WRITE && bio->bi_size)
+	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size)
 		break_sharing(tc, bio, block, &key, lookup_result, cell);
 	else {
 		struct dm_thin_endio_hook *h = dm_per_bio_data(bio, sizeof(struct dm_thin_endio_hook));
@@ -1153,7 +1155,7 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
 	/*
 	 * Remap empty bios (flushes) immediately, without provisioning.
 	 */
-	if (!bio->bi_size) {
+	if (!bio->bi_iter.bi_size) {
 		inc_all_io_entry(pool, bio);
 		cell_defer_no_holder(tc, cell);
 
@@ -1253,7 +1255,7 @@ static void process_bio_read_only(struct thin_c *tc, struct bio *bio)
 	r = dm_thin_find_block(tc->td, block, 1, &lookup_result);
 	switch (r) {
 	case 0:
-		if (lookup_result.shared && (rw == WRITE) && bio->bi_size)
+		if (lookup_result.shared && (rw == WRITE) && bio->bi_iter.bi_size)
 			bio_io_error(bio);
 		else {
 			inc_all_io_entry(tc->pool, bio);
@@ -2867,7 +2869,7 @@ out_unlock:
 
 static int thin_map(struct dm_target *ti, struct bio *bio)
 {
-	bio->bi_sector = dm_target_offset(ti, bio->bi_sector);
+	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
 
 	return thin_bio_map(ti, bio);
 }
diff --git a/drivers/md/dm-verity.c b/drivers/md/dm-verity.c
index 4b7941d..132b315 100644
--- a/drivers/md/dm-verity.c
+++ b/drivers/md/dm-verity.c
@@ -493,9 +493,9 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	struct dm_verity_io *io;
 
 	bio->bi_bdev = v->data_dev->bdev;
-	bio->bi_sector = verity_map_sector(v, bio->bi_sector);
+	bio->bi_iter.bi_sector = verity_map_sector(v, bio->bi_iter.bi_sector);
 
-	if (((unsigned)bio->bi_sector | bio_sectors(bio)) &
+	if (((unsigned)bio->bi_iter.bi_sector | bio_sectors(bio)) &
 	    ((1 << (v->data_dev_block_bits - SECTOR_SHIFT)) - 1)) {
 		DMERR_LIMIT("unaligned io");
 		return -EIO;
@@ -514,8 +514,8 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	io->v = v;
 	io->orig_bi_end_io = bio->bi_end_io;
 	io->orig_bi_private = bio->bi_private;
-	io->block = bio->bi_sector >> (v->data_dev_block_bits - SECTOR_SHIFT);
-	io->n_blocks = bio->bi_size >> v->data_dev_block_bits;
+	io->block = bio->bi_iter.bi_sector >> (v->data_dev_block_bits - SECTOR_SHIFT);
+	io->n_blocks = bio->bi_iter.bi_size >> v->data_dev_block_bits;
 
 	bio->bi_end_io = verity_end_io;
 	bio->bi_private = io;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0704c52..ccd064e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -575,7 +575,7 @@ static void start_io_acct(struct dm_io *io)
 		atomic_inc_return(&md->pending[rw]));
 
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_sector,
+		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
 				    bio_sectors(bio), false, 0, &io->stats_aux);
 }
 
@@ -593,7 +593,7 @@ static void end_io_acct(struct dm_io *io)
 	part_stat_unlock();
 
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_sector,
+		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
 				    bio_sectors(bio), true, duration, &io->stats_aux);
 
 	/*
@@ -742,7 +742,7 @@ static void dec_pending(struct dm_io *io, int error)
 		if (io_error == DM_ENDIO_REQUEUE)
 			return;
 
-		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_size) {
+		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_iter.bi_size) {
 			/*
 			 * Preflush done for flush with data, reissue
 			 * without REQ_FLUSH.
@@ -797,7 +797,7 @@ static void end_clone_bio(struct bio *clone, int error)
 	struct dm_rq_clone_bio_info *info = clone->bi_private;
 	struct dm_rq_target_io *tio = info->tio;
 	struct bio *bio = info->orig;
-	unsigned int nr_bytes = info->orig->bi_size;
+	unsigned int nr_bytes = info->orig->bi_iter.bi_size;
 
 	bio_put(clone);
 
@@ -1128,7 +1128,7 @@ static void __map_bio(struct dm_target_io *tio)
 	 * this io.
 	 */
 	atomic_inc(&tio->io->io_count);
-	sector = clone->bi_sector;
+	sector = clone->bi_iter.bi_sector;
 	r = ti->type->map(ti, clone);
 	if (r == DM_MAPIO_REMAPPED) {
 		/* the bio has been remapped so dispatch it */
@@ -1160,13 +1160,13 @@ struct clone_info {
 
 static void bio_setup_sector(struct bio *bio, sector_t sector, sector_t len)
 {
-	bio->bi_sector = sector;
-	bio->bi_size = to_bytes(len);
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_iter.bi_size = to_bytes(len);
 }
 
 static void bio_setup_bv(struct bio *bio, unsigned short idx, unsigned short bv_count)
 {
-	bio->bi_idx = idx;
+	bio->bi_iter.bi_idx = idx;
 	bio->bi_vcnt = idx + bv_count;
 	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 }
@@ -1202,7 +1202,7 @@ static void clone_split_bio(struct dm_target_io *tio, struct bio *bio,
 	clone->bi_rw = bio->bi_rw;
 	clone->bi_vcnt = 1;
 	clone->bi_io_vec->bv_offset = offset;
-	clone->bi_io_vec->bv_len = clone->bi_size;
+	clone->bi_io_vec->bv_len = clone->bi_iter.bi_size;
 	clone->bi_flags |= 1 << BIO_CLONED;
 
 	clone_bio_integrity(bio, clone, idx, len, offset, 1);
@@ -1222,7 +1222,8 @@ static void clone_bio(struct dm_target_io *tio, struct bio *bio,
 	bio_setup_sector(clone, sector, len);
 	bio_setup_bv(clone, idx, bv_count);
 
-	if (idx != bio->bi_idx || clone->bi_size < bio->bi_size)
+	if (idx != bio->bi_iter.bi_idx ||
+	    clone->bi_iter.bi_size < bio->bi_iter.bi_size)
 		trim = 1;
 	clone_bio_integrity(bio, clone, idx, len, 0, trim);
 }
@@ -1510,8 +1511,8 @@ static void __split_and_process_bio(struct mapped_device *md,
 	ci.io->bio = bio;
 	ci.io->md = md;
 	spin_lock_init(&ci.io->endio_lock);
-	ci.sector = bio->bi_sector;
-	ci.idx = bio->bi_idx;
+	ci.sector = bio->bi_iter.bi_sector;
+	ci.idx = bio->bi_iter.bi_idx;
 
 	start_io_acct(ci.io);
 
diff --git a/drivers/md/faulty.c b/drivers/md/faulty.c
index 3193aef..e8b4574 100644
--- a/drivers/md/faulty.c
+++ b/drivers/md/faulty.c
@@ -74,8 +74,8 @@ static void faulty_fail(struct bio *bio, int error)
 {
 	struct bio *b = bio->bi_private;
 
-	b->bi_size = bio->bi_size;
-	b->bi_sector = bio->bi_sector;
+	b->bi_iter.bi_size = bio->bi_iter.bi_size;
+	b->bi_iter.bi_sector = bio->bi_iter.bi_sector;
 
 	bio_put(bio);
 
@@ -185,26 +185,31 @@ static void make_request(struct mddev *mddev, struct bio *bio)
 			return;
 		}
 
-		if (check_sector(conf, bio->bi_sector, bio_end_sector(bio), WRITE))
+		if (check_sector(conf, bio->bi_iter.bi_sector,
+				 bio_end_sector(bio), WRITE))
 			failit = 1;
 		if (check_mode(conf, WritePersistent)) {
-			add_sector(conf, bio->bi_sector, WritePersistent);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   WritePersistent);
 			failit = 1;
 		}
 		if (check_mode(conf, WriteTransient))
 			failit = 1;
 	} else {
 		/* read request */
-		if (check_sector(conf, bio->bi_sector, bio_end_sector(bio), READ))
+		if (check_sector(conf, bio->bi_iter.bi_sector,
+				 bio_end_sector(bio), READ))
 			failit = 1;
 		if (check_mode(conf, ReadTransient))
 			failit = 1;
 		if (check_mode(conf, ReadPersistent)) {
-			add_sector(conf, bio->bi_sector, ReadPersistent);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   ReadPersistent);
 			failit = 1;
 		}
 		if (check_mode(conf, ReadFixable)) {
-			add_sector(conf, bio->bi_sector, ReadFixable);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   ReadFixable);
 			failit = 1;
 		}
 	}
diff --git a/drivers/md/linear.c b/drivers/md/linear.c
index f03fabd..fb3b0d0 100644
--- a/drivers/md/linear.c
+++ b/drivers/md/linear.c
@@ -297,19 +297,19 @@ static void linear_make_request(struct mddev *mddev, struct bio *bio)
 	}
 
 	rcu_read_lock();
-	tmp_dev = which_dev(mddev, bio->bi_sector);
+	tmp_dev = which_dev(mddev, bio->bi_iter.bi_sector);
 	start_sector = tmp_dev->end_sector - tmp_dev->rdev->sectors;
 
 
-	if (unlikely(bio->bi_sector >= (tmp_dev->end_sector)
-		     || (bio->bi_sector < start_sector))) {
+	if (unlikely(bio->bi_iter.bi_sector >= (tmp_dev->end_sector)
+		     || (bio->bi_iter.bi_sector < start_sector))) {
 		char b[BDEVNAME_SIZE];
 
 		printk(KERN_ERR
 		       "md/linear:%s: make_request: Sector %llu out of bounds on "
 		       "dev %s: %llu sectors, offset %llu\n",
 		       mdname(mddev),
-		       (unsigned long long)bio->bi_sector,
+		       (unsigned long long)bio->bi_iter.bi_sector,
 		       bdevname(tmp_dev->rdev->bdev, b),
 		       (unsigned long long)tmp_dev->rdev->sectors,
 		       (unsigned long long)start_sector);
@@ -326,7 +326,7 @@ static void linear_make_request(struct mddev *mddev, struct bio *bio)
 
 		rcu_read_unlock();
 
-		bp = bio_split(bio, end_sector - bio->bi_sector);
+		bp = bio_split(bio, end_sector - bio->bi_iter.bi_sector);
 
 		linear_make_request(mddev, &bp->bio1);
 		linear_make_request(mddev, &bp->bio2);
@@ -335,7 +335,7 @@ static void linear_make_request(struct mddev *mddev, struct bio *bio)
 	}
 		    
 	bio->bi_bdev = tmp_dev->rdev->bdev;
-	bio->bi_sector = bio->bi_sector - start_sector
+	bio->bi_iter.bi_sector = bio->bi_iter.bi_sector - start_sector
 		+ tmp_dev->rdev->data_offset;
 	rcu_read_unlock();
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 739b1ec..b07fed3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -393,7 +393,7 @@ static void md_submit_flush_data(struct work_struct *ws)
 	struct mddev *mddev = container_of(ws, struct mddev, flush_work);
 	struct bio *bio = mddev->flush_bio;
 
-	if (bio->bi_size == 0)
+	if (bio->bi_iter.bi_size == 0)
 		/* an empty barrier - all done */
 		bio_endio(bio, 0);
 	else {
@@ -754,7 +754,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	struct bio *bio = bio_alloc_mddev(GFP_NOIO, 1, mddev);
 
 	bio->bi_bdev = rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
@@ -785,13 +785,13 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 	bio->bi_bdev = (metadata_op && rdev->meta_bdev) ?
 		rdev->meta_bdev : rdev->bdev;
 	if (metadata_op)
-		bio->bi_sector = sector + rdev->sb_start;
+		bio->bi_iter.bi_sector = sector + rdev->sb_start;
 	else if (rdev->mddev->reshape_position != MaxSector &&
 		 (rdev->mddev->reshape_backwards ==
 		  (sector >= rdev->mddev->reshape_position)))
-		bio->bi_sector = sector + rdev->new_data_offset;
+		bio->bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
-		bio->bi_sector = sector + rdev->data_offset;
+		bio->bi_iter.bi_sector = sector + rdev->data_offset;
 	bio_add_page(bio, page, size, 0);
 	submit_bio_wait(rw, bio);
 
diff --git a/drivers/md/multipath.c b/drivers/md/multipath.c
index 1642eae..849ad39 100644
--- a/drivers/md/multipath.c
+++ b/drivers/md/multipath.c
@@ -100,7 +100,7 @@ static void multipath_end_request(struct bio *bio, int error)
 		md_error (mp_bh->mddev, rdev);
 		printk(KERN_ERR "multipath: %s: rescheduling sector %llu\n", 
 		       bdevname(rdev->bdev,b), 
-		       (unsigned long long)bio->bi_sector);
+		       (unsigned long long)bio->bi_iter.bi_sector);
 		multipath_reschedule_retry(mp_bh);
 	} else
 		multipath_end_bh_io(mp_bh, error);
@@ -132,7 +132,7 @@ static void multipath_make_request(struct mddev *mddev, struct bio * bio)
 	multipath = conf->multipaths + mp_bh->path;
 
 	mp_bh->bio = *bio;
-	mp_bh->bio.bi_sector += multipath->rdev->data_offset;
+	mp_bh->bio.bi_iter.bi_sector += multipath->rdev->data_offset;
 	mp_bh->bio.bi_bdev = multipath->rdev->bdev;
 	mp_bh->bio.bi_rw |= REQ_FAILFAST_TRANSPORT;
 	mp_bh->bio.bi_end_io = multipath_end_request;
@@ -355,21 +355,22 @@ static void multipathd(struct md_thread *thread)
 		spin_unlock_irqrestore(&conf->device_lock, flags);
 
 		bio = &mp_bh->bio;
-		bio->bi_sector = mp_bh->master_bio->bi_sector;
+		bio->bi_iter.bi_sector = mp_bh->master_bio->bi_iter.bi_sector;
 		
 		if ((mp_bh->path = multipath_map (conf))<0) {
 			printk(KERN_ALERT "multipath: %s: unrecoverable IO read"
 				" error for block %llu\n",
 				bdevname(bio->bi_bdev,b),
-				(unsigned long long)bio->bi_sector);
+				(unsigned long long)bio->bi_iter.bi_sector);
 			multipath_end_bh_io(mp_bh, -EIO);
 		} else {
 			printk(KERN_ERR "multipath: %s: redirecting sector %llu"
 				" to another IO path\n",
 				bdevname(bio->bi_bdev,b),
-				(unsigned long long)bio->bi_sector);
+				(unsigned long long)bio->bi_iter.bi_sector);
 			*bio = *(mp_bh->master_bio);
-			bio->bi_sector += conf->multipaths[mp_bh->path].rdev->data_offset;
+			bio->bi_iter.bi_sector +=
+				conf->multipaths[mp_bh->path].rdev->data_offset;
 			bio->bi_bdev = conf->multipaths[mp_bh->path].rdev->bdev;
 			bio->bi_rw |= REQ_FAILFAST_TRANSPORT;
 			bio->bi_end_io = multipath_end_request;
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c4d420b..e38d1d3 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -501,10 +501,11 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
 			unsigned int chunk_sects, struct bio *bio)
 {
 	if (likely(is_power_of_2(chunk_sects))) {
-		return chunk_sects >= ((bio->bi_sector & (chunk_sects-1))
+		return chunk_sects >=
+			((bio->bi_iter.bi_sector & (chunk_sects-1))
 					+ bio_sectors(bio));
 	} else{
-		sector_t sector = bio->bi_sector;
+		sector_t sector = bio->bi_iter.bi_sector;
 		return chunk_sects >= (sector_div(sector, chunk_sects)
 						+ bio_sectors(bio));
 	}
@@ -524,7 +525,7 @@ static void raid0_make_request(struct mddev *mddev, struct bio *bio)
 
 	chunk_sects = mddev->chunk_sectors;
 	if (unlikely(!is_io_in_chunk_boundary(mddev, chunk_sects, bio))) {
-		sector_t sector = bio->bi_sector;
+		sector_t sector = bio->bi_iter.bi_sector;
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
 		if (bio_segments(bio) > 1)
@@ -544,12 +545,12 @@ static void raid0_make_request(struct mddev *mddev, struct bio *bio)
 		return;
 	}
 
-	sector_offset = bio->bi_sector;
+	sector_offset = bio->bi_iter.bi_sector;
 	zone = find_zone(mddev->private, &sector_offset);
-	tmp_dev = map_sector(mddev, zone, bio->bi_sector,
+	tmp_dev = map_sector(mddev, zone, bio->bi_iter.bi_sector,
 			     &sector_offset);
 	bio->bi_bdev = tmp_dev->bdev;
-	bio->bi_sector = sector_offset + zone->dev_start +
+	bio->bi_iter.bi_sector = sector_offset + zone->dev_start +
 		tmp_dev->data_offset;
 
 	if (unlikely((bio->bi_rw & REQ_DISCARD) &&
@@ -566,7 +567,8 @@ bad_map:
 	printk("md/raid0:%s: make_request bug: can't convert block across chunks"
 	       " or bigger than %dk %llu %d\n",
 	       mdname(mddev), chunk_sects / 2,
-	       (unsigned long long)bio->bi_sector, bio_sectors(bio) / 2);
+	       (unsigned long long)bio->bi_iter.bi_sector,
+	       bio_sectors(bio) / 2);
 
 	bio_io_error(bio);
 	return;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1e5a540..db3b9d7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -229,7 +229,7 @@ static void call_bio_endio(struct r1bio *r1_bio)
 	int done;
 	struct r1conf *conf = r1_bio->mddev->private;
 	sector_t start_next_window = r1_bio->start_next_window;
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	if (bio->bi_phys_segments) {
 		unsigned long flags;
@@ -265,9 +265,8 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
 	if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
 		pr_debug("raid1: sync end %s on sectors %llu-%llu\n",
 			 (bio_data_dir(bio) == WRITE) ? "write" : "read",
-			 (unsigned long long) bio->bi_sector,
-			 (unsigned long long) bio->bi_sector +
-			 bio_sectors(bio) - 1);
+			 (unsigned long long) bio->bi_iter.bi_sector,
+			 (unsigned long long) bio_end_sector(bio) - 1);
 
 		call_bio_endio(r1_bio);
 	}
@@ -466,9 +465,8 @@ static void raid1_end_write_request(struct bio *bio, int error)
 				struct bio *mbio = r1_bio->master_bio;
 				pr_debug("raid1: behind end write sectors"
 					 " %llu-%llu\n",
-					 (unsigned long long) mbio->bi_sector,
-					 (unsigned long long) mbio->bi_sector +
-					 bio_sectors(mbio) - 1);
+					 (unsigned long long) mbio->bi_iter.bi_sector,
+					 (unsigned long long) bio_end_sector(mbio) - 1);
 				call_bio_endio(r1_bio);
 			}
 		}
@@ -875,7 +873,7 @@ static bool need_to_wait_for_sync(struct r1conf *conf, struct bio *bio)
 		else if ((conf->next_resync - RESYNC_WINDOW_SECTORS
 				>= bio_end_sector(bio)) ||
 			 (conf->next_resync + NEXT_NORMALIO_DISTANCE
-				<= bio->bi_sector))
+				<= bio->bi_iter.bi_sector))
 			wait = false;
 		else
 			wait = true;
@@ -913,19 +911,19 @@ static sector_t wait_barrier(struct r1conf *conf, struct bio *bio)
 
 	if (bio && bio_data_dir(bio) == WRITE) {
 		if (conf->next_resync + NEXT_NORMALIO_DISTANCE
-		    <= bio->bi_sector) {
+		    <= bio->bi_iter.bi_sector) {
 			if (conf->start_next_window == MaxSector)
 				conf->start_next_window =
 					conf->next_resync +
 					NEXT_NORMALIO_DISTANCE;
 
 			if ((conf->start_next_window + NEXT_NORMALIO_DISTANCE)
-			    <= bio->bi_sector)
+			    <= bio->bi_iter.bi_sector)
 				conf->next_window_requests++;
 			else
 				conf->current_window_requests++;
 		}
-		if (bio->bi_sector >= conf->start_next_window)
+		if (bio->bi_iter.bi_sector >= conf->start_next_window)
 			sector = conf->start_next_window;
 	}
 
@@ -1028,7 +1026,8 @@ do_sync_io:
 		if (bvecs[i].bv_page)
 			put_page(bvecs[i].bv_page);
 	kfree(bvecs);
-	pr_debug("%dB behind alloc failed, doing sync I/O\n", bio->bi_size);
+	pr_debug("%dB behind alloc failed, doing sync I/O\n",
+		 bio->bi_iter.bi_size);
 }
 
 struct raid1_plug_cb {
@@ -1108,7 +1107,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 
 	if (bio_data_dir(bio) == WRITE &&
 	    bio_end_sector(bio) > mddev->suspend_lo &&
-	    bio->bi_sector < mddev->suspend_hi) {
+	    bio->bi_iter.bi_sector < mddev->suspend_hi) {
 		/* As the suspend_* range is controlled by
 		 * userspace, we want an interruptible
 		 * wait.
@@ -1119,7 +1118,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_INTERRUPTIBLE);
 			if (bio_end_sector(bio) <= mddev->suspend_lo ||
-			    bio->bi_sector >= mddev->suspend_hi)
+			    bio->bi_iter.bi_sector >= mddev->suspend_hi)
 				break;
 			schedule();
 		}
@@ -1141,7 +1140,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 	r1_bio->sectors = bio_sectors(bio);
 	r1_bio->state = 0;
 	r1_bio->mddev = mddev;
-	r1_bio->sector = bio->bi_sector;
+	r1_bio->sector = bio->bi_iter.bi_sector;
 
 	/* We might need to issue multiple reads to different
 	 * devices if there are bad blocks around, so we keep
@@ -1181,12 +1180,13 @@ read_again:
 		r1_bio->read_disk = rdisk;
 
 		read_bio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(read_bio, r1_bio->sector - bio->bi_sector,
+		bio_trim(read_bio, r1_bio->sector - bio->bi_iter.bi_sector,
 			 max_sectors);
 
 		r1_bio->bios[rdisk] = read_bio;
 
-		read_bio->bi_sector = r1_bio->sector + mirror->rdev->data_offset;
+		read_bio->bi_iter.bi_sector = r1_bio->sector +
+			mirror->rdev->data_offset;
 		read_bio->bi_bdev = mirror->rdev->bdev;
 		read_bio->bi_end_io = raid1_end_read_request;
 		read_bio->bi_rw = READ | do_sync;
@@ -1198,7 +1198,7 @@ read_again:
 			 */
 
 			sectors_handled = (r1_bio->sector + max_sectors
-					   - bio->bi_sector);
+					   - bio->bi_iter.bi_sector);
 			r1_bio->sectors = max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (bio->bi_phys_segments == 0)
@@ -1219,7 +1219,8 @@ read_again:
 			r1_bio->sectors = bio_sectors(bio) - sectors_handled;
 			r1_bio->state = 0;
 			r1_bio->mddev = mddev;
-			r1_bio->sector = bio->bi_sector + sectors_handled;
+			r1_bio->sector = bio->bi_iter.bi_sector +
+				sectors_handled;
 			goto read_again;
 		} else
 			generic_make_request(read_bio);
@@ -1322,7 +1323,7 @@ read_again:
 			if (r1_bio->bios[j])
 				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
 		r1_bio->state = 0;
-		allow_barrier(conf, start_next_window, bio->bi_sector);
+		allow_barrier(conf, start_next_window, bio->bi_iter.bi_sector);
 		md_wait_for_blocked_rdev(blocked_rdev, mddev);
 		start_next_window = wait_barrier(conf, bio);
 		/*
@@ -1349,7 +1350,7 @@ read_again:
 			bio->bi_phys_segments++;
 		spin_unlock_irq(&conf->device_lock);
 	}
-	sectors_handled = r1_bio->sector + max_sectors - bio->bi_sector;
+	sectors_handled = r1_bio->sector + max_sectors - bio->bi_iter.bi_sector;
 
 	atomic_set(&r1_bio->remaining, 1);
 	atomic_set(&r1_bio->behind_remaining, 0);
@@ -1361,7 +1362,7 @@ read_again:
 			continue;
 
 		mbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(mbio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(mbio, r1_bio->sector - bio->bi_iter.bi_sector, max_sectors);
 
 		if (first_clone) {
 			/* do behind I/O ?
@@ -1395,7 +1396,7 @@ read_again:
 
 		r1_bio->bios[i] = mbio;
 
-		mbio->bi_sector	= (r1_bio->sector +
+		mbio->bi_iter.bi_sector	= (r1_bio->sector +
 				   conf->mirrors[i].rdev->data_offset);
 		mbio->bi_bdev = conf->mirrors[i].rdev->bdev;
 		mbio->bi_end_io	= raid1_end_write_request;
@@ -1435,7 +1436,7 @@ read_again:
 		r1_bio->sectors = bio_sectors(bio) - sectors_handled;
 		r1_bio->state = 0;
 		r1_bio->mddev = mddev;
-		r1_bio->sector = bio->bi_sector + sectors_handled;
+		r1_bio->sector = bio->bi_iter.bi_sector + sectors_handled;
 		goto retry_write;
 	}
 
@@ -1959,14 +1960,14 @@ static int process_checks(struct r1bio *r1_bio)
 		/* fixup the bio for reuse */
 		bio_reset(b);
 		b->bi_vcnt = vcnt;
-		b->bi_size = r1_bio->sectors << 9;
-		b->bi_sector = r1_bio->sector +
+		b->bi_iter.bi_size = r1_bio->sectors << 9;
+		b->bi_iter.bi_sector = r1_bio->sector +
 			conf->mirrors[i].rdev->data_offset;
 		b->bi_bdev = conf->mirrors[i].rdev->bdev;
 		b->bi_end_io = end_sync_read;
 		b->bi_private = r1_bio;
 
-		size = b->bi_size;
+		size = b->bi_iter.bi_size;
 		for (j = 0; j < vcnt ; j++) {
 			struct bio_vec *bi;
 			bi = &b->bi_io_vec[j];
@@ -2221,11 +2222,11 @@ static int narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_rw = WRITE;
-		wbio->bi_sector = r1_bio->sector;
-		wbio->bi_size = r1_bio->sectors << 9;
+		wbio->bi_iter.bi_sector = r1_bio->sector;
+		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
 		bio_trim(wbio, sector - r1_bio->sector, sectors);
-		wbio->bi_sector += rdev->data_offset;
+		wbio->bi_iter.bi_sector += rdev->data_offset;
 		wbio->bi_bdev = rdev->bdev;
 		if (submit_bio_wait(WRITE, wbio) == 0)
 			/* failure! */
@@ -2339,7 +2340,8 @@ read_more:
 		}
 		r1_bio->read_disk = disk;
 		bio = bio_clone_mddev(r1_bio->master_bio, GFP_NOIO, mddev);
-		bio_trim(bio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(bio, r1_bio->sector - bio->bi_iter.bi_sector,
+			 max_sectors);
 		r1_bio->bios[r1_bio->read_disk] = bio;
 		rdev = conf->mirrors[disk].rdev;
 		printk_ratelimited(KERN_ERR
@@ -2348,7 +2350,7 @@ read_more:
 				   mdname(mddev),
 				   (unsigned long long)r1_bio->sector,
 				   bdevname(rdev->bdev, b));
-		bio->bi_sector = r1_bio->sector + rdev->data_offset;
+		bio->bi_iter.bi_sector = r1_bio->sector + rdev->data_offset;
 		bio->bi_bdev = rdev->bdev;
 		bio->bi_end_io = raid1_end_read_request;
 		bio->bi_rw = READ | do_sync;
@@ -2357,7 +2359,7 @@ read_more:
 			/* Drat - have to split this up more */
 			struct bio *mbio = r1_bio->master_bio;
 			int sectors_handled = (r1_bio->sector + max_sectors
-					       - mbio->bi_sector);
+					       - mbio->bi_iter.bi_sector);
 			r1_bio->sectors = max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (mbio->bi_phys_segments == 0)
@@ -2375,7 +2377,8 @@ read_more:
 			r1_bio->state = 0;
 			set_bit(R1BIO_ReadError, &r1_bio->state);
 			r1_bio->mddev = mddev;
-			r1_bio->sector = mbio->bi_sector + sectors_handled;
+			r1_bio->sector = mbio->bi_iter.bi_sector +
+				sectors_handled;
 
 			goto read_more;
 		} else
@@ -2599,7 +2602,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr, int *skipp
 		}
 		if (bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
-			bio->bi_sector = sector_nr + rdev->data_offset;
+			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
 			bio->bi_bdev = rdev->bdev;
 			bio->bi_private = r1_bio;
 		}
@@ -2699,7 +2702,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr, int *skipp
 							continue;
 						/* remove last page from this bio */
 						bio->bi_vcnt--;
-						bio->bi_size -= len;
+						bio->bi_iter.bi_size -= len;
 						bio->bi_flags &= ~(1<< BIO_SEG_VALID);
 					}
 					goto bio_full;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c504e83..dbf3b63 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1182,7 +1182,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 	/* If this request crosses a chunk boundary, we need to
 	 * split it.  This will only happen for 1 PAGE (or less) requests.
 	 */
-	if (unlikely((bio->bi_sector & chunk_mask) + bio_sectors(bio)
+	if (unlikely((bio->bi_iter.bi_sector & chunk_mask) + bio_sectors(bio)
 		     > chunk_sects
 		     && (conf->geo.near_copies < conf->geo.raid_disks
 			 || conf->prev.near_copies < conf->prev.raid_disks))) {
@@ -1193,8 +1193,8 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
 		 */
-		bp = bio_split(bio,
-			       chunk_sects - (bio->bi_sector & (chunk_sects - 1)) );
+		bp = bio_split(bio, chunk_sects -
+			       (bio->bi_iter.bi_sector & (chunk_sects - 1)));
 
 		/* Each of these 'make_request' calls will call 'wait_barrier'.
 		 * If the first succeeds but the second blocks due to the resync
@@ -1221,7 +1221,8 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 	bad_map:
 		printk("md/raid10:%s: make_request bug: can't convert block across chunks"
 		       " or bigger than %dk %llu %d\n", mdname(mddev), chunk_sects/2,
-		       (unsigned long long)bio->bi_sector, bio_sectors(bio) / 2);
+		       (unsigned long long)bio->bi_iter.bi_sector,
+		       bio_sectors(bio) / 2);
 
 		bio_io_error(bio);
 		return;
@@ -1238,24 +1239,25 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 
 	sectors = bio_sectors(bio);
 	while (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
-	    bio->bi_sector < conf->reshape_progress &&
-	    bio->bi_sector + sectors > conf->reshape_progress) {
+	    bio->bi_iter.bi_sector < conf->reshape_progress &&
+	    bio->bi_iter.bi_sector + sectors > conf->reshape_progress) {
 		/* IO spans the reshape position.  Need to wait for
 		 * reshape to pass
 		 */
 		allow_barrier(conf);
 		wait_event(conf->wait_barrier,
-			   conf->reshape_progress <= bio->bi_sector ||
-			   conf->reshape_progress >= bio->bi_sector + sectors);
+			   conf->reshape_progress <= bio->bi_iter.bi_sector ||
+			   conf->reshape_progress >= bio->bi_iter.bi_sector +
+			   sectors);
 		wait_barrier(conf);
 	}
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    bio_data_dir(bio) == WRITE &&
 	    (mddev->reshape_backwards
-	     ? (bio->bi_sector < conf->reshape_safe &&
-		bio->bi_sector + sectors > conf->reshape_progress)
-	     : (bio->bi_sector + sectors > conf->reshape_safe &&
-		bio->bi_sector < conf->reshape_progress))) {
+	     ? (bio->bi_iter.bi_sector < conf->reshape_safe &&
+		bio->bi_iter.bi_sector + sectors > conf->reshape_progress)
+	     : (bio->bi_iter.bi_sector + sectors > conf->reshape_safe &&
+		bio->bi_iter.bi_sector < conf->reshape_progress))) {
 		/* Need to update reshape_position in metadata */
 		mddev->reshape_position = conf->reshape_progress;
 		set_bit(MD_CHANGE_DEVS, &mddev->flags);
@@ -1273,7 +1275,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 	r10_bio->sectors = sectors;
 
 	r10_bio->mddev = mddev;
-	r10_bio->sector = bio->bi_sector;
+	r10_bio->sector = bio->bi_iter.bi_sector;
 	r10_bio->state = 0;
 
 	/* We might need to issue multiple reads to different
@@ -1302,13 +1304,13 @@ read_again:
 		slot = r10_bio->read_slot;
 
 		read_bio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(read_bio, r10_bio->sector - bio->bi_sector,
+		bio_trim(read_bio, r10_bio->sector - bio->bi_iter.bi_sector,
 			 max_sectors);
 
 		r10_bio->devs[slot].bio = read_bio;
 		r10_bio->devs[slot].rdev = rdev;
 
-		read_bio->bi_sector = r10_bio->devs[slot].addr +
+		read_bio->bi_iter.bi_sector = r10_bio->devs[slot].addr +
 			choose_data_offset(r10_bio, rdev);
 		read_bio->bi_bdev = rdev->bdev;
 		read_bio->bi_end_io = raid10_end_read_request;
@@ -1320,7 +1322,7 @@ read_again:
 			 * need another r10_bio.
 			 */
 			sectors_handled = (r10_bio->sectors + max_sectors
-					   - bio->bi_sector);
+					   - bio->bi_iter.bi_sector);
 			r10_bio->sectors = max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (bio->bi_phys_segments == 0)
@@ -1341,7 +1343,8 @@ read_again:
 			r10_bio->sectors = bio_sectors(bio) - sectors_handled;
 			r10_bio->state = 0;
 			r10_bio->mddev = mddev;
-			r10_bio->sector = bio->bi_sector + sectors_handled;
+			r10_bio->sector = bio->bi_iter.bi_sector +
+				sectors_handled;
 			goto read_again;
 		} else
 			generic_make_request(read_bio);
@@ -1499,7 +1502,8 @@ retry_write:
 			bio->bi_phys_segments++;
 		spin_unlock_irq(&conf->device_lock);
 	}
-	sectors_handled = r10_bio->sector + max_sectors - bio->bi_sector;
+	sectors_handled = r10_bio->sector + max_sectors -
+		bio->bi_iter.bi_sector;
 
 	atomic_set(&r10_bio->remaining, 1);
 	bitmap_startwrite(mddev->bitmap, r10_bio->sector, r10_bio->sectors, 0);
@@ -1510,11 +1514,11 @@ retry_write:
 		if (r10_bio->devs[i].bio) {
 			struct md_rdev *rdev = conf->mirrors[d].rdev;
 			mbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-			bio_trim(mbio, r10_bio->sector - bio->bi_sector,
+			bio_trim(mbio, r10_bio->sector - bio->bi_iter.bi_sector,
 				 max_sectors);
 			r10_bio->devs[i].bio = mbio;
 
-			mbio->bi_sector	= (r10_bio->devs[i].addr+
+			mbio->bi_iter.bi_sector	= (r10_bio->devs[i].addr+
 					   choose_data_offset(r10_bio,
 							      rdev));
 			mbio->bi_bdev = rdev->bdev;
@@ -1553,11 +1557,11 @@ retry_write:
 				rdev = conf->mirrors[d].rdev;
 			}
 			mbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-			bio_trim(mbio, r10_bio->sector - bio->bi_sector,
+			bio_trim(mbio, r10_bio->sector - bio->bi_iter.bi_sector,
 				 max_sectors);
 			r10_bio->devs[i].repl_bio = mbio;
 
-			mbio->bi_sector	= (r10_bio->devs[i].addr +
+			mbio->bi_iter.bi_sector	= (r10_bio->devs[i].addr +
 					   choose_data_offset(
 						   r10_bio, rdev));
 			mbio->bi_bdev = rdev->bdev;
@@ -1591,7 +1595,7 @@ retry_write:
 		r10_bio->sectors = bio_sectors(bio) - sectors_handled;
 
 		r10_bio->mddev = mddev;
-		r10_bio->sector = bio->bi_sector + sectors_handled;
+		r10_bio->sector = bio->bi_iter.bi_sector + sectors_handled;
 		r10_bio->state = 0;
 		goto retry_write;
 	}
@@ -2124,10 +2128,10 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		bio_reset(tbio);
 
 		tbio->bi_vcnt = vcnt;
-		tbio->bi_size = r10_bio->sectors << 9;
+		tbio->bi_iter.bi_size = r10_bio->sectors << 9;
 		tbio->bi_rw = WRITE;
 		tbio->bi_private = r10_bio;
-		tbio->bi_sector = r10_bio->devs[i].addr;
+		tbio->bi_iter.bi_sector = r10_bio->devs[i].addr;
 
 		for (j=0; j < vcnt ; j++) {
 			tbio->bi_io_vec[j].bv_offset = 0;
@@ -2144,7 +2148,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		atomic_inc(&r10_bio->remaining);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
 
-		tbio->bi_sector += conf->mirrors[d].rdev->data_offset;
+		tbio->bi_iter.bi_sector += conf->mirrors[d].rdev->data_offset;
 		tbio->bi_bdev = conf->mirrors[d].rdev->bdev;
 		generic_make_request(tbio);
 	}
@@ -2614,8 +2618,8 @@ static int narrow_write_error(struct r10bio *r10_bio, int i)
 			sectors = sect_to_write;
 		/* Write at 'sector' for 'sectors' */
 		wbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(wbio, sector - bio->bi_sector, sectors);
-		wbio->bi_sector = (r10_bio->devs[i].addr+
+		bio_trim(wbio, sector - bio->bi_iter.bi_sector, sectors);
+		wbio->bi_iter.bi_sector = (r10_bio->devs[i].addr+
 				   choose_data_offset(r10_bio, rdev) +
 				   (sector - r10_bio->sector));
 		wbio->bi_bdev = rdev->bdev;
@@ -2687,10 +2691,10 @@ read_more:
 		(unsigned long long)r10_bio->sector);
 	bio = bio_clone_mddev(r10_bio->master_bio,
 			      GFP_NOIO, mddev);
-	bio_trim(bio, r10_bio->sector - bio->bi_sector, max_sectors);
+	bio_trim(bio, r10_bio->sector - bio->bi_iter.bi_sector, max_sectors);
 	r10_bio->devs[slot].bio = bio;
 	r10_bio->devs[slot].rdev = rdev;
-	bio->bi_sector = r10_bio->devs[slot].addr
+	bio->bi_iter.bi_sector = r10_bio->devs[slot].addr
 		+ choose_data_offset(r10_bio, rdev);
 	bio->bi_bdev = rdev->bdev;
 	bio->bi_rw = READ | do_sync;
@@ -2701,7 +2705,7 @@ read_more:
 		struct bio *mbio = r10_bio->master_bio;
 		int sectors_handled =
 			r10_bio->sector + max_sectors
-			- mbio->bi_sector;
+			- mbio->bi_iter.bi_sector;
 		r10_bio->sectors = max_sectors;
 		spin_lock_irq(&conf->device_lock);
 		if (mbio->bi_phys_segments == 0)
@@ -2719,7 +2723,7 @@ read_more:
 		set_bit(R10BIO_ReadError,
 			&r10_bio->state);
 		r10_bio->mddev = mddev;
-		r10_bio->sector = mbio->bi_sector
+		r10_bio->sector = mbio->bi_iter.bi_sector
 			+ sectors_handled;
 
 		goto read_more;
@@ -3157,7 +3161,8 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_end_io = end_sync_read;
 				bio->bi_rw = READ;
 				from_addr = r10_bio->devs[j].addr;
-				bio->bi_sector = from_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector = from_addr +
+					rdev->data_offset;
 				bio->bi_bdev = rdev->bdev;
 				atomic_inc(&rdev->nr_pending);
 				/* and we write to 'i' (if not in_sync) */
@@ -3181,7 +3186,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 					bio->bi_private = r10_bio;
 					bio->bi_end_io = end_sync_write;
 					bio->bi_rw = WRITE;
-					bio->bi_sector = to_addr
+					bio->bi_iter.bi_sector = to_addr
 						+ rdev->data_offset;
 					bio->bi_bdev = rdev->bdev;
 					atomic_inc(&r10_bio->remaining);
@@ -3210,7 +3215,8 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_private = r10_bio;
 				bio->bi_end_io = end_sync_write;
 				bio->bi_rw = WRITE;
-				bio->bi_sector = to_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector = to_addr +
+					rdev->data_offset;
 				bio->bi_bdev = rdev->bdev;
 				atomic_inc(&r10_bio->remaining);
 				break;
@@ -3328,7 +3334,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio->bi_private = r10_bio;
 			bio->bi_end_io = end_sync_read;
 			bio->bi_rw = READ;
-			bio->bi_sector = sector +
+			bio->bi_iter.bi_sector = sector +
 				conf->mirrors[d].rdev->data_offset;
 			bio->bi_bdev = conf->mirrors[d].rdev->bdev;
 			count++;
@@ -3350,7 +3356,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio->bi_private = r10_bio;
 			bio->bi_end_io = end_sync_write;
 			bio->bi_rw = WRITE;
-			bio->bi_sector = sector +
+			bio->bi_iter.bi_sector = sector +
 				conf->mirrors[d].replacement->data_offset;
 			bio->bi_bdev = conf->mirrors[d].replacement->bdev;
 			count++;
@@ -3397,7 +3403,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			     bio2 = bio2->bi_next) {
 				/* remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -= len;
+				bio2->bi_iter.bi_size -= len;
 				bio2->bi_flags &= ~(1<< BIO_SEG_VALID);
 			}
 			goto bio_full;
@@ -4417,7 +4423,7 @@ read_more:
 	read_bio = bio_alloc_mddev(GFP_KERNEL, RESYNC_PAGES, mddev);
 
 	read_bio->bi_bdev = rdev->bdev;
-	read_bio->bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
+	read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
 			       + rdev->data_offset);
 	read_bio->bi_private = r10_bio;
 	read_bio->bi_end_io = end_sync_read;
@@ -4425,7 +4431,7 @@ read_more:
 	read_bio->bi_flags &= ~(BIO_POOL_MASK - 1);
 	read_bio->bi_flags |= 1 << BIO_UPTODATE;
 	read_bio->bi_vcnt = 0;
-	read_bio->bi_size = 0;
+	read_bio->bi_iter.bi_size = 0;
 	r10_bio->master_bio = read_bio;
 	r10_bio->read_slot = r10_bio->devs[r10_bio->read_slot].devnum;
 
@@ -4451,7 +4457,8 @@ read_more:
 
 		bio_reset(b);
 		b->bi_bdev = rdev2->bdev;
-		b->bi_sector = r10_bio->devs[s/2].addr + rdev2->new_data_offset;
+		b->bi_iter.bi_sector = r10_bio->devs[s/2].addr +
+			rdev2->new_data_offset;
 		b->bi_private = r10_bio;
 		b->bi_end_io = end_reshape_write;
 		b->bi_rw = WRITE;
@@ -4478,7 +4485,7 @@ read_more:
 			     bio2 = bio2->bi_next) {
 				/* Remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -= len;
+				bio2->bi_iter.bi_size -= len;
 				bio2->bi_flags &= ~(1<<BIO_SEG_VALID);
 			}
 			goto bio_full;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 47da0af..a5d9c0e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -133,7 +133,7 @@ static inline void unlock_all_device_hash_locks_irq(struct r5conf *conf)
 static inline struct bio *r5_next_bio(struct bio *bio, sector_t sector)
 {
 	int sectors = bio_sectors(bio);
-	if (bio->bi_sector + sectors < sector + STRIPE_SECTORS)
+	if (bio->bi_iter.bi_sector + sectors < sector + STRIPE_SECTORS)
 		return bio->bi_next;
 	else
 		return NULL;
@@ -225,7 +225,7 @@ static void return_io(struct bio *return_bi)
 
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
-		bi->bi_size = 0;
+		bi->bi_iter.bi_size = 0;
 		trace_block_bio_complete(bdev_get_queue(bi->bi_bdev),
 					 bi, 0);
 		bio_endio(bi, 0);
@@ -854,10 +854,10 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				bi->bi_rw, i);
 			atomic_inc(&sh->count);
 			if (use_new_offset(conf, sh))
-				bi->bi_sector = (sh->sector
+				bi->bi_iter.bi_sector = (sh->sector
 						 + rdev->new_data_offset);
 			else
-				bi->bi_sector = (sh->sector
+				bi->bi_iter.bi_sector = (sh->sector
 						 + rdev->data_offset);
 			if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
 				bi->bi_rw |= REQ_NOMERGE;
@@ -865,7 +865,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			bi->bi_vcnt = 1;
 			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
 			bi->bi_io_vec[0].bv_offset = 0;
-			bi->bi_size = STRIPE_SIZE;
+			bi->bi_iter.bi_size = STRIPE_SIZE;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
@@ -901,15 +901,15 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				rbi->bi_rw, i);
 			atomic_inc(&sh->count);
 			if (use_new_offset(conf, sh))
-				rbi->bi_sector = (sh->sector
+				rbi->bi_iter.bi_sector = (sh->sector
 						  + rrdev->new_data_offset);
 			else
-				rbi->bi_sector = (sh->sector
+				rbi->bi_iter.bi_sector = (sh->sector
 						  + rrdev->data_offset);
 			rbi->bi_vcnt = 1;
 			rbi->bi_io_vec[0].bv_len = STRIPE_SIZE;
 			rbi->bi_io_vec[0].bv_offset = 0;
-			rbi->bi_size = STRIPE_SIZE;
+			rbi->bi_iter.bi_size = STRIPE_SIZE;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
@@ -944,10 +944,10 @@ async_copy_data(int frombio, struct bio *bio, struct page *page,
 	struct async_submit_ctl submit;
 	enum async_tx_flags flags = 0;
 
-	if (bio->bi_sector >= sector)
-		page_offset = (signed)(bio->bi_sector - sector) * 512;
+	if (bio->bi_iter.bi_sector >= sector)
+		page_offset = (signed)(bio->bi_iter.bi_sector - sector) * 512;
 	else
-		page_offset = (signed)(sector - bio->bi_sector) * -512;
+		page_offset = (signed)(sector - bio->bi_iter.bi_sector) * -512;
 
 	if (frombio)
 		flags |= ASYNC_TX_FENCE;
@@ -1014,7 +1014,7 @@ static void ops_complete_biofill(void *stripe_head_ref)
 			BUG_ON(!dev->read);
 			rbi = dev->read;
 			dev->read = NULL;
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				rbi2 = r5_next_bio(rbi, dev->sector);
 				if (!raid5_dec_bi_active_stripes(rbi)) {
@@ -1050,7 +1050,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 			dev->read = rbi = dev->toread;
 			dev->toread = NULL;
 			spin_unlock_irq(&sh->stripe_lock);
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				tx = async_copy_data(0, rbi, dev->page,
 					dev->sector, tx);
@@ -1392,7 +1392,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 			wbi = dev->written = chosen;
 			spin_unlock_irq(&sh->stripe_lock);
 
-			while (wbi && wbi->bi_sector <
+			while (wbi && wbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				if (wbi->bi_rw & REQ_FUA)
 					set_bit(R5_WantFUA, &dev->flags);
@@ -2616,7 +2616,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 	int firstwrite=0;
 
 	pr_debug("adding bi b#%llu to stripe s#%llu\n",
-		(unsigned long long)bi->bi_sector,
+		(unsigned long long)bi->bi_iter.bi_sector,
 		(unsigned long long)sh->sector);
 
 	/*
@@ -2634,12 +2634,12 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 			firstwrite = 1;
 	} else
 		bip = &sh->dev[dd_idx].toread;
-	while (*bip && (*bip)->bi_sector < bi->bi_sector) {
-		if (bio_end_sector(*bip) > bi->bi_sector)
+	while (*bip && (*bip)->bi_iter.bi_sector < bi->bi_iter.bi_sector) {
+		if (bio_end_sector(*bip) > bi->bi_iter.bi_sector)
 			goto overlap;
 		bip = & (*bip)->bi_next;
 	}
-	if (*bip && (*bip)->bi_sector < bio_end_sector(bi))
+	if (*bip && (*bip)->bi_iter.bi_sector < bio_end_sector(bi))
 		goto overlap;
 
 	BUG_ON(*bip && bi->bi_next && (*bip) != bi->bi_next);
@@ -2653,7 +2653,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 		sector_t sector = sh->dev[dd_idx].sector;
 		for (bi=sh->dev[dd_idx].towrite;
 		     sector < sh->dev[dd_idx].sector + STRIPE_SECTORS &&
-			     bi && bi->bi_sector <= sector;
+			     bi && bi->bi_iter.bi_sector <= sector;
 		     bi = r5_next_bio(bi, sh->dev[dd_idx].sector)) {
 			if (bio_end_sector(bi) >= sector)
 				sector = bio_end_sector(bi);
@@ -2663,7 +2663,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 	}
 
 	pr_debug("added bi b#%llu to stripe s#%llu, disk %d.\n",
-		(unsigned long long)(*bip)->bi_sector,
+		(unsigned long long)(*bip)->bi_iter.bi_sector,
 		(unsigned long long)sh->sector, dd_idx);
 	spin_unlock_irq(&sh->stripe_lock);
 
@@ -2738,7 +2738,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 			wake_up(&conf->wait_for_overlap);
 
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 			sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *nextbi = r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2757,7 +2757,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		bi = sh->dev[i].written;
 		sh->dev[i].written = NULL;
 		if (bi) bitmap_end = 1;
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 		       sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *bi2 = r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2781,7 +2781,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			spin_unlock_irq(&sh->stripe_lock);
 			if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 				wake_up(&conf->wait_for_overlap);
-			while (bi && bi->bi_sector <
+			while (bi && bi->bi_iter.bi_sector <
 			       sh->dev[i].sector + STRIPE_SECTORS) {
 				struct bio *nextbi =
 					r5_next_bio(bi, sh->dev[i].sector);
@@ -3005,7 +3005,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 					clear_bit(R5_UPTODATE, &dev->flags);
 				wbi = dev->written;
 				dev->written = NULL;
-				while (wbi && wbi->bi_sector <
+				while (wbi && wbi->bi_iter.bi_sector <
 					dev->sector + STRIPE_SECTORS) {
 					wbi2 = r5_next_bio(wbi, dev->sector);
 					if (!raid5_dec_bi_active_stripes(wbi)) {
@@ -4097,7 +4097,7 @@ static int raid5_mergeable_bvec(struct request_queue *q,
 
 static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
 {
-	sector_t sector = bio->bi_sector + get_start_sect(bio->bi_bdev);
+	sector_t sector = bio->bi_iter.bi_sector + get_start_sect(bio->bi_bdev);
 	unsigned int chunk_sectors = mddev->chunk_sectors;
 	unsigned int bio_sectors = bio_sectors(bio);
 
@@ -4234,9 +4234,9 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 	/*
 	 *	compute position
 	 */
-	align_bi->bi_sector =  raid5_compute_sector(conf, raid_bio->bi_sector,
-						    0,
-						    &dd_idx, NULL);
+	align_bi->bi_iter.bi_sector =
+		raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector,
+				     0, &dd_idx, NULL);
 
 	end_sector = bio_end_sector(align_bi);
 	rcu_read_lock();
@@ -4261,7 +4261,8 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		align_bi->bi_flags &= ~(1 << BIO_SEG_VALID);
 
 		if (!bio_fits_rdev(align_bi) ||
-		    is_badblock(rdev, align_bi->bi_sector, bio_sectors(align_bi),
+		    is_badblock(rdev, align_bi->bi_iter.bi_sector,
+				bio_sectors(align_bi),
 				&first_bad, &bad_sectors)) {
 			/* too big in some way, or has a known bad block */
 			bio_put(align_bi);
@@ -4270,7 +4271,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		}
 
 		/* No reshape active, so we can trust rdev->data_offset */
-		align_bi->bi_sector += rdev->data_offset;
+		align_bi->bi_iter.bi_sector += rdev->data_offset;
 
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,
@@ -4282,7 +4283,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(align_bi->bi_bdev),
 					      align_bi, disk_devt(mddev->gendisk),
-					      raid_bio->bi_sector);
+					      raid_bio->bi_iter.bi_sector);
 		generic_make_request(align_bi);
 		return 1;
 	} else {
@@ -4465,8 +4466,8 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		/* Skip discard while reshape is happening */
 		return;
 
-	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
-	last_sector = bi->bi_sector + (bi->bi_size>>9);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	last_sector = bi->bi_iter.bi_sector + (bi->bi_iter.bi_size>>9);
 
 	bi->bi_next = NULL;
 	bi->bi_phys_segments = 1; /* over-loaded to count active stripes */
@@ -4570,7 +4571,7 @@ static void make_request(struct mddev *mddev, struct bio * bi)
 		return;
 	}
 
-	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 	bi->bi_phys_segments = 1;	/* over-loaded to count active stripes */
@@ -5054,7 +5055,8 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio)
 	int remaining;
 	int handled = 0;
 
-	logical_sector = raid_bio->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector = raid_bio->bi_iter.bi_sector &
+		~((sector_t)STRIPE_SECTORS-1);
 	sector = raid5_compute_sector(conf, logical_sector,
 				      0, &dd_idx, NULL);
 	last_sector = bio_end_sector(raid_bio);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 6eca019..16814a8 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -819,7 +819,8 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 	dev_info = bio->bi_bdev->bd_disk->private_data;
 	if (dev_info == NULL)
 		goto fail;
-	if ((bio->bi_sector & 7) != 0 || (bio->bi_size & 4095) != 0)
+	if ((bio->bi_iter.bi_sector & 7) != 0 ||
+	    (bio->bi_iter.bi_size & 4095) != 0)
 		/* Request is not page-aligned. */
 		goto fail;
 	if (bio_end_sector(bio) > get_capacity(bio->bi_bdev->bd_disk)) {
@@ -842,7 +843,7 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 		}
 	}
 
-	index = (bio->bi_sector >> 3);
+	index = (bio->bi_iter.bi_sector >> 3);
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr = (unsigned long)
 			page_address(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 464dd29..dd4e73f 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -190,15 +190,16 @@ static void xpram_make_request(struct request_queue *q, struct bio *bio)
 	unsigned long bytes;
 	int i;
 
-	if ((bio->bi_sector & 7) != 0 || (bio->bi_size & 4095) != 0)
+	if ((bio->bi_iter.bi_sector & 7) != 0 ||
+	    (bio->bi_iter.bi_size & 4095) != 0)
 		/* Request is not page-aligned. */
 		goto fail;
-	if ((bio->bi_size >> 12) > xdev->size)
+	if ((bio->bi_iter.bi_size >> 12) > xdev->size)
 		/* Request size is no page-aligned. */
 		goto fail;
-	if ((bio->bi_sector >> 3) > 0xffffffffU - xdev->offset)
+	if ((bio->bi_iter.bi_sector >> 3) > 0xffffffffU - xdev->offset)
 		goto fail;
-	index = (bio->bi_sector >> 3) + xdev->offset;
+	index = (bio->bi_iter.bi_sector >> 3) + xdev->offset;
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr = (unsigned long)
 			kmap(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index aa66361..bac04c2 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -731,7 +731,7 @@ static int _osd_req_list_objects(struct osd_request *or,
 
 	bio->bi_rw &= ~REQ_WRITE;
 	or->in.bio = bio;
-	or->in.total_bytes = bio->bi_size;
+	or->in.total_bytes = bio->bi_iter.bi_size;
 	return 0;
 }
 
diff --git a/drivers/staging/lustre/lustre/llite/lloop.c b/drivers/staging/lustre/lustre/llite/lloop.c
index e2421ea..53741be 100644
--- a/drivers/staging/lustre/lustre/llite/lloop.c
+++ b/drivers/staging/lustre/lustre/llite/lloop.c
@@ -220,7 +220,7 @@ static int do_bio_lustrebacked(struct lloop_device *lo, struct bio *head)
 	for (bio = head; bio != NULL; bio = bio->bi_next) {
 		LASSERT(rw == bio->bi_rw);
 
-		offset = (pgoff_t)(bio->bi_sector << 9) + lo->lo_offset;
+		offset = (pgoff_t)(bio->bi_iter.bi_sector << 9) + lo->lo_offset;
 		bio_for_each_segment(bvec, bio, i) {
 			BUG_ON(bvec->bv_offset != 0);
 			BUG_ON(bvec->bv_len != PAGE_CACHE_SIZE);
@@ -313,7 +313,8 @@ static unsigned int loop_get_bio(struct lloop_device *lo, struct bio **req)
 	bio = &lo->lo_bio;
 	while (*bio && (*bio)->bi_rw == rw) {
 		CDEBUG(D_INFO, "bio sector %llu size %u count %u vcnt%u \n",
-		       (unsigned long long)(*bio)->bi_sector, (*bio)->bi_size,
+		       (unsigned long long)(*bio)->bi_iter.bi_sector,
+		       (*bio)->bi_iter.bi_size,
 		       page_count, (*bio)->bi_vcnt);
 		if (page_count + (*bio)->bi_vcnt > LLOOP_MAX_SEGMENTS)
 			break;
@@ -347,7 +348,8 @@ static void loop_make_request(struct request_queue *q, struct bio *old_bio)
 		goto err;
 
 	CDEBUG(D_INFO, "submit bio sector %llu size %u\n",
-	       (unsigned long long)old_bio->bi_sector, old_bio->bi_size);
+	       (unsigned long long)old_bio->bi_iter.bi_sector,
+	       old_bio->bi_iter.bi_size);
 
 	spin_lock_irq(&lo->lo_lock);
 	inactive = (lo->lo_state != LLOOP_BOUND);
@@ -367,7 +369,7 @@ static void loop_make_request(struct request_queue *q, struct bio *old_bio)
 	loop_add_bio(lo, old_bio);
 	return;
 err:
-	cfs_bio_io_error(old_bio, old_bio->bi_size);
+	cfs_bio_io_error(old_bio, old_bio->bi_iter.bi_size);
 }
 
 
@@ -378,7 +380,7 @@ static inline void loop_handle_bio(struct lloop_device *lo, struct bio *bio)
 	while (bio) {
 		struct bio *tmp = bio->bi_next;
 		bio->bi_next = NULL;
-		cfs_bio_endio(bio, bio->bi_size, ret);
+		cfs_bio_endio(bio, bio->bi_iter.bi_size, ret);
 		bio = tmp;
 	}
 }
diff --git a/drivers/staging/zram/zram_drv.c b/drivers/staging/zram/zram_drv.c
index 79ce363..e9e6f98 100644
--- a/drivers/staging/zram/zram_drv.c
+++ b/drivers/staging/zram/zram_drv.c
@@ -171,13 +171,14 @@ static inline int valid_io_request(struct zram *zram, struct bio *bio)
 	u64 start, end, bound;
 
 	/* unaligned request */
-	if (unlikely(bio->bi_sector & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
+	if (unlikely(bio->bi_iter.bi_sector &
+		     (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
 		return 0;
-	if (unlikely(bio->bi_size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
+	if (unlikely(bio->bi_iter.bi_size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
 		return 0;
 
-	start = bio->bi_sector;
-	end = start + (bio->bi_size >> SECTOR_SHIFT);
+	start = bio->bi_iter.bi_sector;
+	end = start + (bio->bi_iter.bi_size >> SECTOR_SHIFT);
 	bound = zram->disksize >> SECTOR_SHIFT;
 	/* out of range range */
 	if (unlikely(start >= bound || end > bound || start > end))
@@ -684,8 +685,9 @@ static void __zram_make_request(struct zram *zram, struct bio *bio, int rw)
 		break;
 	}
 
-	index = bio->bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	offset = (bio->bi_sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
+	index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+	offset = (bio->bi_iter.bi_sector &
+		  (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
 
 	bio_for_each_segment(bvec, bio, i) {
 		int max_transfer_size = PAGE_SIZE - offset;
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index c87959f..2d29356 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -319,7 +319,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num)
 	bio->bi_bdev = ib_dev->ibd_bd;
 	bio->bi_private = cmd;
 	bio->bi_end_io = &iblock_bio_done;
-	bio->bi_sector = lba;
+	bio->bi_iter.bi_sector = lba;
 
 	return bio;
 }
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index fc60b31..08e3d13 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -215,9 +215,9 @@ unsigned int bio_integrity_tag_size(struct bio *bio)
 {
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 
-	BUG_ON(bio->bi_size == 0);
+	BUG_ON(bio->bi_iter.bi_size == 0);
 
-	return bi->tag_size * (bio->bi_size / bi->sector_size);
+	return bi->tag_size * (bio->bi_iter.bi_size / bi->sector_size);
 }
 EXPORT_SYMBOL(bio_integrity_tag_size);
 
@@ -300,7 +300,7 @@ static void bio_integrity_generate(struct bio *bio)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector = bio->bi_sector;
+	sector_t sector = bio->bi_iter.bi_sector;
 	unsigned int i, sectors, total;
 	void *prot_buf = bio->bi_integrity->bip_buf;
 
@@ -387,7 +387,7 @@ int bio_integrity_prep(struct bio *bio)
 	bip->bip_owns_buf = 1;
 	bip->bip_buf = buf;
 	bip->bip_size = len;
-	bip->bip_sector = bio->bi_sector;
+	bip->bip_sector = bio->bi_iter.bi_sector;
 
 	/* Map it */
 	offset = offset_in_page(buf);
diff --git a/fs/bio.c b/fs/bio.c
index 33d79a4..a402ad6 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -532,13 +532,13 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
 	 * most users will be overriding ->bi_bdev with a new target,
 	 * so we don't set nor calculate new physical/hw segment counts here
 	 */
-	bio->bi_sector = bio_src->bi_sector;
+	bio->bi_iter.bi_sector = bio_src->bi_iter.bi_sector;
 	bio->bi_bdev = bio_src->bi_bdev;
 	bio->bi_flags |= 1 << BIO_CLONED;
 	bio->bi_rw = bio_src->bi_rw;
 	bio->bi_vcnt = bio_src->bi_vcnt;
-	bio->bi_size = bio_src->bi_size;
-	bio->bi_idx = bio_src->bi_idx;
+	bio->bi_iter.bi_size = bio_src->bi_iter.bi_size;
+	bio->bi_iter.bi_idx = bio_src->bi_iter.bi_idx;
 }
 EXPORT_SYMBOL(__bio_clone);
 
@@ -612,7 +612,7 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 	if (unlikely(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_size + len) >> 9) > max_sectors)
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
 
 	/*
@@ -635,8 +635,9 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 					   simulate merging updated prev_bvec
 					   as new bvec. */
 					.bi_bdev = bio->bi_bdev,
-					.bi_sector = bio->bi_sector,
-					.bi_size = bio->bi_size - prev_bv_len,
+					.bi_sector = bio->bi_iter.bi_sector,
+					.bi_size = bio->bi_iter.bi_size -
+						prev_bv_len,
 					.bi_rw = bio->bi_rw,
 				};
 
@@ -684,8 +685,8 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 	if (q->merge_bvec_fn) {
 		struct bvec_merge_data bvm = {
 			.bi_bdev = bio->bi_bdev,
-			.bi_sector = bio->bi_sector,
-			.bi_size = bio->bi_size,
+			.bi_sector = bio->bi_iter.bi_sector,
+			.bi_size = bio->bi_iter.bi_size,
 			.bi_rw = bio->bi_rw,
 		};
 
@@ -708,7 +709,7 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 	bio->bi_vcnt++;
 	bio->bi_phys_segments++;
  done:
-	bio->bi_size += len;
+	bio->bi_iter.bi_size += len;
 	return len;
 }
 
@@ -807,22 +808,22 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
 
-	bio->bi_sector += bytes >> 9;
-	bio->bi_size -= bytes;
+	bio->bi_iter.bi_sector += bytes >> 9;
+	bio->bi_iter.bi_size -= bytes;
 
 	if (bio->bi_rw & BIO_NO_ADVANCE_ITER_MASK)
 		return;
 
 	while (bytes) {
-		if (unlikely(bio->bi_idx >= bio->bi_vcnt)) {
+		if (unlikely(bio->bi_iter.bi_idx >= bio->bi_vcnt)) {
 			WARN_ONCE(1, "bio idx %d >= vcnt %d\n",
-				  bio->bi_idx, bio->bi_vcnt);
+				  bio->bi_iter.bi_idx, bio->bi_vcnt);
 			break;
 		}
 
 		if (bytes >= bio_iovec(bio)->bv_len) {
 			bytes -= bio_iovec(bio)->bv_len;
-			bio->bi_idx++;
+			bio->bi_iter.bi_idx++;
 		} else {
 			bio_iovec(bio)->bv_len -= bytes;
 			bio_iovec(bio)->bv_offset += bytes;
@@ -1485,7 +1486,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	if (IS_ERR(bio))
 		return bio;
 
-	if (bio->bi_size == len)
+	if (bio->bi_iter.bi_size == len)
 		return bio;
 
 	/*
@@ -1763,16 +1764,16 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 		return bp;
 
 	trace_block_split(bdev_get_queue(bi->bi_bdev), bi,
-				bi->bi_sector + first_sectors);
+				bi->bi_iter.bi_sector + first_sectors);
 
 	BUG_ON(bio_segments(bi) > 1);
 	atomic_set(&bp->cnt, 3);
 	bp->error = 0;
 	bp->bio1 = *bi;
 	bp->bio2 = *bi;
-	bp->bio2.bi_sector += first_sectors;
-	bp->bio2.bi_size -= first_sectors << 9;
-	bp->bio1.bi_size = first_sectors << 9;
+	bp->bio2.bi_iter.bi_sector += first_sectors;
+	bp->bio2.bi_iter.bi_size -= first_sectors << 9;
+	bp->bio1.bi_iter.bi_size = first_sectors << 9;
 
 	if (bi->bi_vcnt != 0) {
 		bp->bv1 = *bio_iovec(bi);
@@ -1821,21 +1822,22 @@ void bio_trim(struct bio *bio, int offset, int size)
 	int sofar = 0;
 
 	size <<= 9;
-	if (offset == 0 && size == bio->bi_size)
+	if (offset == 0 && size == bio->bi_iter.bi_size)
 		return;
 
 	clear_bit(BIO_SEG_VALID, &bio->bi_flags);
 
 	bio_advance(bio, offset << 9);
 
-	bio->bi_size = size;
+	bio->bi_iter.bi_size = size;
 
 	/* avoid any complications with bi_idx being non-zero*/
-	if (bio->bi_idx) {
-		memmove(bio->bi_io_vec, bio->bi_io_vec+bio->bi_idx,
-			(bio->bi_vcnt - bio->bi_idx) * sizeof(struct bio_vec));
-		bio->bi_vcnt -= bio->bi_idx;
-		bio->bi_idx = 0;
+	if (bio->bi_iter.bi_idx) {
+		memmove(bio->bi_io_vec, bio->bi_io_vec+bio->bi_iter.bi_idx,
+			(bio->bi_vcnt - bio->bi_iter.bi_idx) *
+			sizeof(struct bio_vec));
+		bio->bi_vcnt -= bio->bi_iter.bi_idx;
+		bio->bi_iter.bi_idx = 0;
 	}
 	/* Make sure vcnt and last bv are not too big */
 	bio_for_each_segment(bvec, bio, i) {
@@ -1871,7 +1873,7 @@ sector_t bio_sector_offset(struct bio *bio, unsigned short index,
 	sector_sz = queue_logical_block_size(bio->bi_bdev->bd_disk->queue);
 	sectors = 0;
 
-	if (index >= bio->bi_idx)
+	if (index >= bio->bi_iter.bi_idx)
 		index = bio->bi_vcnt - 1;
 
 	bio_for_each_segment_all(bv, bio, i) {
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 131d828..cb05e1c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1695,7 +1695,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 			return -1;
 		}
 		bio->bi_bdev = block_ctx->dev->bdev;
-		bio->bi_sector = dev_bytenr >> 9;
+		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 
 		for (j = i; j < num_pages; j++) {
 			ret = bio_add_page(bio, block_ctx->pagev[j],
@@ -3013,7 +3013,7 @@ static void __btrfsic_submit_bio(int rw, struct bio *bio)
 		int bio_is_patched;
 		char **mapped_datav;
 
-		dev_bytenr = 512 * bio->bi_sector;
+		dev_bytenr = 512 * bio->bi_iter.bi_sector;
 		bio_is_patched = 0;
 		if (dev_state->state->print_mask &
 		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
@@ -3021,8 +3021,8 @@ static void __btrfsic_submit_bio(int rw, struct bio *bio)
 			       "submit_bio(rw=0x%x, bi_vcnt=%u,"
 			       " bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
 			       rw, bio->bi_vcnt,
-			       (unsigned long long)bio->bi_sector, dev_bytenr,
-			       bio->bi_bdev);
+			       (unsigned long long)bio->bi_iter.bi_sector,
+			       dev_bytenr, bio->bi_bdev);
 
 		mapped_datav = kmalloc(sizeof(*mapped_datav) * bio->bi_vcnt,
 				       GFP_NOFS);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index eac6784..f5cdeb4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -172,7 +172,8 @@ static void end_compressed_bio_read(struct bio *bio, int err)
 		goto out;
 
 	inode = cb->inode;
-	ret = check_compressed_csum(inode, cb, (u64)bio->bi_sector << 9);
+	ret = check_compressed_csum(inode, cb,
+				    (u64)bio->bi_iter.bi_sector << 9);
 	if (ret)
 		goto csum_failed;
 
@@ -370,7 +371,7 @@ int btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
 		page = compressed_pages[pg_index];
 		page->mapping = inode->i_mapping;
-		if (bio->bi_size)
+		if (bio->bi_iter.bi_size)
 			ret = io_tree->ops->merge_bio_hook(WRITE, page, 0,
 							   PAGE_CACHE_SIZE,
 							   bio, 0);
@@ -504,7 +505,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 		if (!em || last_offset < em->start ||
 		    (last_offset + PAGE_CACHE_SIZE > extent_map_end(em)) ||
-		    (em->block_start >> 9) != cb->orig_bio->bi_sector) {
+		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, last_offset, end);
 			unlock_page(page);
@@ -550,7 +551,7 @@ next:
  * in it.  We don't actually do IO on those pages but allocate new ones
  * to hold the compressed pages on disk.
  *
- * bio->bi_sector points to the compressed extent on disk
+ * bio->bi_iter.bi_sector points to the compressed extent on disk
  * bio->bi_io_vec points to all of the inode pages
  * bio->bi_vcnt is a count of pages
  *
@@ -571,7 +572,7 @@ int btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct page *page;
 	struct block_device *bdev;
 	struct bio *comp_bio;
-	u64 cur_disk_byte = (u64)bio->bi_sector << 9;
+	u64 cur_disk_byte = (u64)bio->bi_iter.bi_sector << 9;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -657,7 +658,7 @@ int btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		page->mapping = inode->i_mapping;
 		page->index = em_start >> PAGE_CACHE_SHIFT;
 
-		if (comp_bio->bi_size)
+		if (comp_bio->bi_iter.bi_size)
 			ret = tree->ops->merge_bio_hook(READ, page, 0,
 							PAGE_CACHE_SIZE,
 							comp_bio, 0);
@@ -685,8 +686,8 @@ int btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 							comp_bio, sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
-			sums += (comp_bio->bi_size + root->sectorsize - 1) /
-				root->sectorsize;
+			sums += (comp_bio->bi_iter.bi_size +
+				 root->sectorsize - 1) / root->sectorsize;
 
 			ret = btrfs_map_bio(root, READ, comp_bio,
 					    mirror_num, 0);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8b5f9e1..bcb6f1b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1984,7 +1984,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 start,
 	bio = btrfs_io_bio_alloc(GFP_NOFS, 1);
 	if (!bio)
 		return -EIO;
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
 	ret = btrfs_map_block(fs_info, WRITE, logical,
@@ -1995,7 +1995,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 start,
 	}
 	BUG_ON(mirror_num != bbio->mirror_num);
 	sector = bbio->stripes[mirror_num-1].physical >> 9;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	dev = bbio->stripes[mirror_num-1].dev;
 	kfree(bbio);
 	if (!dev || !dev->bdev || !dev->writeable) {
@@ -2268,9 +2268,9 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 		return -EIO;
 	}
 	bio->bi_end_io = failed_bio->bi_end_io;
-	bio->bi_sector = failrec->logical >> 9;
+	bio->bi_iter.bi_sector = failrec->logical >> 9;
 	bio->bi_bdev = BTRFS_I(inode)->root->fs_info->fs_devices->latest_bdev;
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 
 	btrfs_failed_bio = btrfs_io_bio(failed_bio);
 	if (btrfs_failed_bio->csum) {
@@ -2412,7 +2412,7 @@ static void end_bio_extent_readpage(struct bio *bio, int err)
 		struct inode *inode = page->mapping->host;
 
 		pr_debug("end_bio_extent_readpage: bi_sector=%llu, err=%d, "
-			 "mirror=%lu\n", (u64)bio->bi_sector, err,
+			 "mirror=%lu\n", (u64)bio->bi_iter.bi_sector, err,
 			 io_bio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 
@@ -2543,7 +2543,7 @@ btrfs_bio_alloc(struct block_device *bdev, u64 first_sector, int nr_vecs,
 
 	if (bio) {
 		bio->bi_bdev = bdev;
-		bio->bi_sector = first_sector;
+		bio->bi_iter.bi_sector = first_sector;
 		btrfs_bio = btrfs_io_bio(bio);
 		btrfs_bio->csum = NULL;
 		btrfs_bio->csum_allocated = NULL;
@@ -2637,7 +2637,7 @@ static int submit_extent_page(int rw, struct extent_io_tree *tree,
 	if (bio_ret && *bio_ret) {
 		bio = *bio_ret;
 		if (old_compressed)
-			contig = bio->bi_sector == sector;
+			contig = bio->bi_iter.bi_sector == sector;
 		else
 			contig = bio_end_sector(bio) == sector;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6f38488..84a46a4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -182,7 +182,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root *root,
 	if (!path)
 		return -ENOMEM;
 
-	nblocks = bio->bi_size >> inode->i_sb->s_blocksize_bits;
+	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
 	if (!dst) {
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum_allocated = kmalloc(nblocks * csum_size,
@@ -201,7 +201,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root *root,
 		csum = (u8 *)dst;
 	}
 
-	if (bio->bi_size > PAGE_CACHE_SIZE * 8)
+	if (bio->bi_iter.bi_size > PAGE_CACHE_SIZE * 8)
 		path->reada = 2;
 
 	WARN_ON(bio->bi_vcnt <= 0);
@@ -217,7 +217,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root *root,
 		path->skip_locking = 1;
 	}
 
-	disk_bytenr = (u64)bio->bi_sector << 9;
+	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	if (dio)
 		offset = logical_offset;
 	while (bio_index < bio->bi_vcnt) {
@@ -302,7 +302,7 @@ int btrfs_lookup_bio_sums_dio(struct btrfs_root *root, struct inode *inode,
 			      struct btrfs_dio_private *dip, struct bio *bio,
 			      u64 offset)
 {
-	int len = (bio->bi_sector << 9) - dip->disk_bytenr;
+	int len = (bio->bi_iter.bi_sector << 9) - dip->disk_bytenr;
 	u16 csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
 	int ret;
 
@@ -447,11 +447,12 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 	u64 offset;
 
 	WARN_ON(bio->bi_vcnt <= 0);
-	sums = kzalloc(btrfs_ordered_sum_size(root, bio->bi_size), GFP_NOFS);
+	sums = kzalloc(btrfs_ordered_sum_size(root, bio->bi_iter.bi_size),
+		       GFP_NOFS);
 	if (!sums)
 		return -ENOMEM;
 
-	sums->len = bio->bi_size;
+	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
 	if (contig)
@@ -461,7 +462,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 
 	ordered = btrfs_lookup_ordered_extent(inode, offset);
 	BUG_ON(!ordered); /* Logic error */
-	sums->bytenr = (u64)bio->bi_sector << 9;
+	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	while (bio_index < bio->bi_vcnt) {
@@ -476,7 +477,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 			btrfs_add_ordered_sum(inode, ordered, sums);
 			btrfs_put_ordered_extent(ordered);
 
-			bytes_left = bio->bi_size - total_bytes;
+			bytes_left = bio->bi_iter.bi_size - total_bytes;
 
 			sums = kzalloc(btrfs_ordered_sum_size(root, bytes_left),
 				       GFP_NOFS);
@@ -484,7 +485,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 			sums->len = bytes_left;
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
 			BUG_ON(!ordered); /* Logic error */
-			sums->bytenr = ((u64)bio->bi_sector << 9) +
+			sums->bytenr = ((u64)bio->bi_iter.bi_sector << 9) +
 				       total_bytes;
 			index = 0;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6630dc..7ab0e94 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1577,7 +1577,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page, unsigned long offset,
 			 unsigned long bio_flags)
 {
 	struct btrfs_root *root = BTRFS_I(page->mapping->host)->root;
-	u64 logical = (u64)bio->bi_sector << 9;
+	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	int ret;
@@ -1585,7 +1585,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page, unsigned long offset,
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
 		return 0;
 
-	length = bio->bi_size;
+	length = bio->bi_iter.bi_size;
 	map_length = length;
 	ret = btrfs_map_block(root->fs_info, rw, logical,
 			      &map_length, NULL, 0);
@@ -6894,7 +6894,8 @@ static void btrfs_end_dio_bio(struct bio *bio, int err)
 		printk(KERN_ERR "btrfs direct IO failed ino %llu rw %lu "
 		      "sector %#Lx len %u err no %d\n",
 		      btrfs_ino(dip->inode), bio->bi_rw,
-		      (unsigned long long)bio->bi_sector, bio->bi_size, err);
+		      (unsigned long long)bio->bi_iter.bi_sector,
+		      bio->bi_iter.bi_size, err);
 		dip->errors = 1;
 
 		/*
@@ -6985,7 +6986,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 	struct bio *bio;
 	struct bio *orig_bio = dip->orig_bio;
 	struct bio_vec *bvec = orig_bio->bi_io_vec;
-	u64 start_sector = orig_bio->bi_sector;
+	u64 start_sector = orig_bio->bi_iter.bi_sector;
 	u64 file_offset = dip->logical_offset;
 	u64 submit_len = 0;
 	u64 map_length;
@@ -6993,7 +6994,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 	int ret = 0;
 	int async_submit = 0;
 
-	map_length = orig_bio->bi_size;
+	map_length = orig_bio->bi_iter.bi_size;
 	ret = btrfs_map_block(root->fs_info, rw, start_sector << 9,
 			      &map_length, NULL, 0);
 	if (ret) {
@@ -7001,7 +7002,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 		return -EIO;
 	}
 
-	if (map_length >= orig_bio->bi_size) {
+	if (map_length >= orig_bio->bi_iter.bi_size) {
 		bio = orig_bio;
 		goto submit;
 	}
@@ -7053,7 +7054,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 			bio->bi_private = dip;
 			bio->bi_end_io = btrfs_end_dio_bio;
 
-			map_length = orig_bio->bi_size;
+			map_length = orig_bio->bi_iter.bi_size;
 			ret = btrfs_map_block(root->fs_info, rw,
 					      start_sector << 9,
 					      &map_length, NULL, 0);
@@ -7111,7 +7112,8 @@ static void btrfs_submit_direct(int rw, struct bio *dio_bio,
 
 	if (!skip_sum && !write) {
 		csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
-		sum_len = dio_bio->bi_size >> inode->i_sb->s_blocksize_bits;
+		sum_len = dio_bio->bi_iter.bi_size >>
+			inode->i_sb->s_blocksize_bits;
 		sum_len *= csum_size;
 	} else {
 		sum_len = 0;
@@ -7126,8 +7128,8 @@ static void btrfs_submit_direct(int rw, struct bio *dio_bio,
 	dip->private = dio_bio->bi_private;
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
-	dip->bytes = dio_bio->bi_size;
-	dip->disk_bytenr = (u64)dio_bio->bi_sector << 9;
+	dip->bytes = dio_bio->bi_iter.bi_size;
+	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
 	io_bio->bi_private = dip;
 	dip->errors = 0;
 	dip->orig_bio = io_bio;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 24ac218..9af0b25 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1032,8 +1032,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		last_end = (u64)last->bi_sector << 9;
-		last_end += last->bi_size;
+		last_end = (u64)last->bi_iter.bi_sector << 9;
+		last_end += last->bi_iter.bi_size;
 
 		/*
 		 * we can't merge these if they are from different
@@ -1053,9 +1053,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	if (!bio)
 		return -ENOMEM;
 
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 	bio->bi_bdev = stripe->dev->bdev;
-	bio->bi_sector = disk_start >> 9;
+	bio->bi_iter.bi_sector = disk_start >> 9;
 	set_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
@@ -1111,7 +1111,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	spin_lock_irq(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list) {
-		start = (u64)bio->bi_sector << 9;
+		start = (u64)bio->bi_iter.bi_sector << 9;
 		stripe_offset = start - rbio->raid_map[0];
 		page_index = stripe_offset >> PAGE_CACHE_SHIFT;
 
@@ -1272,7 +1272,7 @@ cleanup:
 static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 			   struct bio *bio)
 {
-	u64 physical = bio->bi_sector;
+	u64 physical = bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
 	struct btrfs_bio_stripe *stripe;
@@ -1298,7 +1298,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 				   struct bio *bio)
 {
-	u64 logical = bio->bi_sector;
+	u64 logical = bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
 
@@ -1602,8 +1602,8 @@ static int plug_cmp(void *priv, struct list_head *a, struct list_head *b)
 						 plug_list);
 	struct btrfs_raid_bio *rb = container_of(b, struct btrfs_raid_bio,
 						 plug_list);
-	u64 a_sector = ra->bio_list.head->bi_sector;
-	u64 b_sector = rb->bio_list.head->bi_sector;
+	u64 a_sector = ra->bio_list.head->bi_iter.bi_sector;
+	u64 b_sector = rb->bio_list.head->bi_iter.bi_sector;
 
 	if (a_sector < b_sector)
 		return -1;
@@ -1691,7 +1691,7 @@ int raid56_parity_write(struct btrfs_root *root, struct bio *bio,
 	if (IS_ERR(rbio))
 		return PTR_ERR(rbio);
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes = bio->bi_size;
+	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	/*
 	 * don't plug on full rbios, just get them out the door
@@ -2044,7 +2044,7 @@ int raid56_parity_recover(struct btrfs_root *root, struct bio *bio,
 
 	rbio->read_rebuild = 1;
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes = bio->bi_size;
+	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1fd3f33..bb9a928 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1308,7 +1308,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 		bio->bi_bdev = page->dev->bdev;
-		bio->bi_sector = page->physical >> 9;
+		bio->bi_iter.bi_sector = page->physical >> 9;
 
 		bio_add_page(bio, page->page, PAGE_SIZE, 0);
 		if (btrfsic_submit_bio_wait(READ, bio))
@@ -1427,7 +1427,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 		if (!bio)
 			return -EIO;
 		bio->bi_bdev = page_bad->dev->bdev;
-		bio->bi_sector = page_bad->physical >> 9;
+		bio->bi_iter.bi_sector = page_bad->physical >> 9;
 
 		ret = bio_add_page(bio, page_good->page, PAGE_SIZE, 0);
 		if (PAGE_SIZE != ret) {
@@ -1520,7 +1520,7 @@ again:
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_wr_bio_end_io;
 		bio->bi_bdev = sbio->dev->bdev;
-		bio->bi_sector = sbio->physical >> 9;
+		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->err = 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
 		   spage->physical_for_dev_replace ||
@@ -1926,7 +1926,7 @@ again:
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_bio_end_io;
 		bio->bi_bdev = sbio->dev->bdev;
-		bio->bi_sector = sbio->physical >> 9;
+		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->err = 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
 		   spage->physical ||
@@ -3371,8 +3371,8 @@ static int write_page_nocow(struct scrub_ctx *sctx,
 		spin_unlock(&sctx->stat_lock);
 		return -ENOMEM;
 	}
-	bio->bi_size = 0;
-	bio->bi_sector = physical_for_dev_replace >> 9;
+	bio->bi_iter.bi_size = 0;
+	bio->bi_iter.bi_sector = physical_for_dev_replace >> 9;
 	bio->bi_bdev = dev->bdev;
 	ret = bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
 	if (ret != PAGE_CACHE_SIZE) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 92303f4..f2130de 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5411,7 +5411,7 @@ static int bio_size_ok(struct block_device *bdev, struct bio *bio,
 	if (!q->merge_bvec_fn)
 		return 1;
 
-	bvm.bi_size = bio->bi_size - prev->bv_len;
+	bvm.bi_size = bio->bi_iter.bi_size - prev->bv_len;
 	if (q->merge_bvec_fn(q, &bvm, prev) < prev->bv_len)
 		return 0;
 	return 1;
@@ -5426,7 +5426,7 @@ static void submit_stripe_bio(struct btrfs_root *root, struct btrfs_bio *bbio,
 	bio->bi_private = bbio;
 	btrfs_io_bio(bio)->stripe_index = dev_nr;
 	bio->bi_end_io = btrfs_end_bio;
-	bio->bi_sector = physical >> 9;
+	bio->bi_iter.bi_sector = physical >> 9;
 #ifdef DEBUG
 	{
 		struct rcu_string *name;
@@ -5464,7 +5464,7 @@ again:
 	while (bvec <= (first_bio->bi_io_vec + first_bio->bi_vcnt - 1)) {
 		if (bio_add_page(bio, bvec->bv_page, bvec->bv_len,
 				 bvec->bv_offset) < bvec->bv_len) {
-			u64 len = bio->bi_size;
+			u64 len = bio->bi_iter.bi_size;
 
 			atomic_inc(&bbio->stripes_pending);
 			submit_stripe_bio(root, bbio, bio, physical, dev_nr,
@@ -5486,7 +5486,7 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 		bio->bi_private = bbio->private;
 		bio->bi_end_io = bbio->end_io;
 		btrfs_io_bio(bio)->mirror_num = bbio->mirror_num;
-		bio->bi_sector = logical >> 9;
+		bio->bi_iter.bi_sector = logical >> 9;
 		kfree(bbio);
 		bio_endio(bio, -EIO);
 	}
@@ -5497,7 +5497,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, struct bio *bio,
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
-	u64 logical = (u64)bio->bi_sector << 9;
+	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	u64 *raid_map = NULL;
@@ -5506,7 +5506,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, struct bio *bio,
 	int total_devs = 1;
 	struct btrfs_bio *bbio = NULL;
 
-	length = bio->bi_size;
+	length = bio->bi_iter.bi_size;
 	map_length = length;
 
 	ret = __btrfs_map_block(root->fs_info, rw, logical, &map_length, &bbio,
diff --git a/fs/buffer.c b/fs/buffer.c
index 6024877..1c04ec6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2982,11 +2982,11 @@ static void guard_bh_eod(int rw, struct bio *bio, struct buffer_head *bh)
 	 * let it through, and the IO layer will turn it into
 	 * an EIO.
 	 */
-	if (unlikely(bio->bi_sector >= maxsector))
+	if (unlikely(bio->bi_iter.bi_sector >= maxsector))
 		return;
 
-	maxsector -= bio->bi_sector;
-	bytes = bio->bi_size;
+	maxsector -= bio->bi_iter.bi_sector;
+	bytes = bio->bi_iter.bi_size;
 	if (likely((bytes >> 9) <= maxsector))
 		return;
 
@@ -2994,7 +2994,7 @@ static void guard_bh_eod(int rw, struct bio *bio, struct buffer_head *bh)
 	bytes = maxsector << 9;
 
 	/* Truncate the bio.. */
-	bio->bi_size = bytes;
+	bio->bi_iter.bi_size = bytes;
 	bio->bi_io_vec[0].bv_len = bytes;
 
 	/* ..and clear the end of the buffer for reads */
@@ -3029,14 +3029,14 @@ int _submit_bh(int rw, struct buffer_head *bh, unsigned long bio_flags)
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
 	bio->bi_io_vec[0].bv_page = bh->b_page;
 	bio->bi_io_vec[0].bv_len = bh->b_size;
 	bio->bi_io_vec[0].bv_offset = bh_offset(bh);
 
 	bio->bi_vcnt = 1;
-	bio->bi_size = bh->b_size;
+	bio->bi_iter.bi_size = bh->b_size;
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0e04142..160a548 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -375,7 +375,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
 	bio->bi_bdev = bdev;
-	bio->bi_sector = first_sector;
+	bio->bi_iter.bi_sector = first_sector;
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
@@ -719,7 +719,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	if (sdio->bio) {
 		loff_t cur_offset = sdio->cur_page_fs_offset;
 		loff_t bio_next_offset = sdio->logical_offset_in_bio +
-			sdio->bio->bi_size;
+			sdio->bio->bi_iter.bi_size;
 
 		/*
 		 * See whether this new request is contiguous with the old.
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a31e4da..ab95508 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -298,7 +298,7 @@ ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
 static void ext4_end_bio(struct bio *bio, int error)
 {
 	ext4_io_end_t *io_end = bio->bi_private;
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	BUG_ON(!io_end);
 	bio->bi_end_io = NULL;
@@ -366,7 +366,7 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	bio = bio_alloc(GFP_NOIO, min(nvecs, BIO_MAX_PAGES));
 	if (!bio)
 		return -ENOMEM;
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a494909..a2c8de8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -386,7 +386,7 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 	bio = f2fs_bio_alloc(bdev, 1);
 
 	/* Initialize the bio */
-	bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 	bio->bi_end_io = read_end_io;
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a90c6bc..36e8afd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -682,7 +682,7 @@ retry:
 
 		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
 		sbi->bio[type] = f2fs_bio_alloc(bdev, bio_blocks);
-		sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+		sbi->bio[type]->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 		sbi->bio[type]->bi_private = priv;
 		/*
 		 * The end_io will be assigned at the sumbission phase.
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 010b9fb..985da94 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -272,7 +272,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno)
 		nrvecs = max(nrvecs/2, 1U);
 	}
 
-	bio->bi_sector = blkno * (sb->s_blocksize >> 9);
+	bio->bi_iter.bi_sector = blkno * (sb->s_blocksize >> 9);
 	bio->bi_bdev = sb->s_bdev;
 	bio->bi_end_io = gfs2_end_log_write;
 	bio->bi_private = sdp;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 82303b4..16194da 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -224,7 +224,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 	lock_page(page);
 
 	bio = bio_alloc(GFP_NOFS, 1);
-	bio->bi_sector = sector * (sb->s_blocksize >> 9);
+	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
 	bio->bi_bdev = sb->s_bdev;
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index e9a97a0..3f99964 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -63,7 +63,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
 
 	bio = bio_alloc(GFP_NOIO, 1);
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = sb->s_bdev;
 
 	if (!(rw & WRITE) && data)
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 360d27c..8d811e0 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1998,20 +1998,20 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio = bio_alloc(GFP_NOFS, 1);
 
-	bio->bi_sector = bp->l_blkno << (log->l2bsize - 9);
+	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio->bi_bdev = log->bdev;
 	bio->bi_io_vec[0].bv_page = bp->l_page;
 	bio->bi_io_vec[0].bv_len = LOGPSIZE;
 	bio->bi_io_vec[0].bv_offset = bp->l_offset;
 
 	bio->bi_vcnt = 1;
-	bio->bi_size = LOGPSIZE;
+	bio->bi_iter.bi_size = LOGPSIZE;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
-		bio->bi_size = 0;
+		bio->bi_iter.bi_size = 0;
 		lbmIODone(bio, 0);
 	} else {
 		submit_bio(READ_SYNC, bio);
@@ -2144,21 +2144,21 @@ static void lbmStartIO(struct lbuf * bp)
 	jfs_info("lbmStartIO\n");
 
 	bio = bio_alloc(GFP_NOFS, 1);
-	bio->bi_sector = bp->l_blkno << (log->l2bsize - 9);
+	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	bio->bi_bdev = log->bdev;
 	bio->bi_io_vec[0].bv_page = bp->l_page;
 	bio->bi_io_vec[0].bv_len = LOGPSIZE;
 	bio->bi_io_vec[0].bv_offset = bp->l_offset;
 
 	bio->bi_vcnt = 1;
-	bio->bi_size = LOGPSIZE;
+	bio->bi_iter.bi_size = LOGPSIZE;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
 
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
-		bio->bi_size = 0;
+		bio->bi_iter.bi_size = 0;
 		lbmIODone(bio, 0);
 	} else {
 		submit_bio(WRITE_SYNC, bio);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index d165cde..49ba7ff 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -416,7 +416,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 			 * count from hitting zero before we're through
 			 */
 			inc_io(page);
-			if (!bio->bi_size)
+			if (!bio->bi_iter.bi_size)
 				goto dump_bio;
 			submit_bio(WRITE, bio);
 			nr_underway++;
@@ -438,7 +438,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 
 		bio = bio_alloc(GFP_NOFS, 1);
 		bio->bi_bdev = inode->i_sb->s_bdev;
-		bio->bi_sector = pblock << (inode->i_blkbits - 9);
+		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
 
@@ -452,7 +452,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	if (bio) {
 		if (bio_add_page(bio, page, bio_bytes, bio_offset) < bio_bytes)
 				goto add_failed;
-		if (!bio->bi_size)
+		if (!bio->bi_iter.bi_size)
 			goto dump_bio;
 
 		submit_bio(WRITE, bio);
@@ -517,7 +517,8 @@ static int metapage_readpage(struct file *fp, struct page *page)
 
 			bio = bio_alloc(GFP_NOFS, 1);
 			bio->bi_bdev = inode->i_sb->s_bdev;
-			bio->bi_sector = pblock << (inode->i_blkbits - 9);
+			bio->bi_iter.bi_sector =
+				pblock << (inode->i_blkbits - 9);
 			bio->bi_end_io = metapage_read_end_io;
 			bio->bi_private = page;
 			len = xlen << inode->i_blkbits;
diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index e6df3be..76279e1 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -26,9 +26,9 @@ static int sync_request(struct page *page, struct block_device *bdev, int rw)
 	bio_vec.bv_len = PAGE_SIZE;
 	bio_vec.bv_offset = 0;
 	bio.bi_vcnt = 1;
-	bio.bi_size = PAGE_SIZE;
 	bio.bi_bdev = bdev;
-	bio.bi_sector = page->index * (PAGE_SIZE >> 9);
+	bio.bi_iter.bi_sector = page->index * (PAGE_SIZE >> 9);
+	bio.bi_iter.bi_size = PAGE_SIZE;
 
 	return submit_bio_wait(rw, &bio);
 }
@@ -92,9 +92,9 @@ static int __bdev_writeseg(struct super_block *sb, u64 ofs, pgoff_t index,
 		if (i >= max_pages) {
 			/* Block layer cannot split bios :( */
 			bio->bi_vcnt = i;
-			bio->bi_size = i * PAGE_SIZE;
+			bio->bi_iter.bi_size = i * PAGE_SIZE;
 			bio->bi_bdev = super->s_bdev;
-			bio->bi_sector = ofs >> 9;
+			bio->bi_iter.bi_sector = ofs >> 9;
 			bio->bi_private = sb;
 			bio->bi_end_io = writeseg_end_io;
 			atomic_inc(&super->s_pending_writes);
@@ -119,9 +119,9 @@ static int __bdev_writeseg(struct super_block *sb, u64 ofs, pgoff_t index,
 		unlock_page(page);
 	}
 	bio->bi_vcnt = nr_pages;
-	bio->bi_size = nr_pages * PAGE_SIZE;
+	bio->bi_iter.bi_size = nr_pages * PAGE_SIZE;
 	bio->bi_bdev = super->s_bdev;
-	bio->bi_sector = ofs >> 9;
+	bio->bi_iter.bi_sector = ofs >> 9;
 	bio->bi_private = sb;
 	bio->bi_end_io = writeseg_end_io;
 	atomic_inc(&super->s_pending_writes);
@@ -184,9 +184,9 @@ static int do_erase(struct super_block *sb, u64 ofs, pgoff_t index,
 		if (i >= max_pages) {
 			/* Block layer cannot split bios :( */
 			bio->bi_vcnt = i;
-			bio->bi_size = i * PAGE_SIZE;
+			bio->bi_iter.bi_size = i * PAGE_SIZE;
 			bio->bi_bdev = super->s_bdev;
-			bio->bi_sector = ofs >> 9;
+			bio->bi_iter.bi_sector = ofs >> 9;
 			bio->bi_private = sb;
 			bio->bi_end_io = erase_end_io;
 			atomic_inc(&super->s_pending_writes);
@@ -205,9 +205,9 @@ static int do_erase(struct super_block *sb, u64 ofs, pgoff_t index,
 		bio->bi_io_vec[i].bv_offset = 0;
 	}
 	bio->bi_vcnt = nr_pages;
-	bio->bi_size = nr_pages * PAGE_SIZE;
+	bio->bi_iter.bi_size = nr_pages * PAGE_SIZE;
 	bio->bi_bdev = super->s_bdev;
-	bio->bi_sector = ofs >> 9;
+	bio->bi_iter.bi_sector = ofs >> 9;
 	bio->bi_private = sb;
 	bio->bi_end_io = erase_end_io;
 	atomic_inc(&super->s_pending_writes);
diff --git a/fs/mpage.c b/fs/mpage.c
index dd6d587..4979ffa 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -93,7 +93,7 @@ mpage_alloc(struct block_device *bdev,
 
 	if (bio) {
 		bio->bi_bdev = bdev;
-		bio->bi_sector = first_sector;
+		bio->bi_iter.bi_sector = first_sector;
 	}
 	return bio;
 }
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index da76892..56ff823 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -134,8 +134,8 @@ bl_submit_bio(int rw, struct bio *bio)
 	if (bio) {
 		get_parallel(bio->bi_private);
 		dprintk("%s submitting %s bio %u@%llu\n", __func__,
-			rw == READ ? "read" : "write",
-			bio->bi_size, (unsigned long long)bio->bi_sector);
+			rw == READ ? "read" : "write", bio->bi_iter.bi_size,
+			(unsigned long long)bio->bi_iter.bi_sector);
 		submit_bio(rw, bio);
 	}
 	return NULL;
@@ -156,7 +156,8 @@ static struct bio *bl_alloc_init_bio(int npg, sector_t isect,
 	}
 
 	if (bio) {
-		bio->bi_sector = isect - be->be_f_offset + be->be_v_offset;
+		bio->bi_iter.bi_sector = isect - be->be_f_offset +
+			be->be_v_offset;
 		bio->bi_bdev = be->be_mdev;
 		bio->bi_end_io = end_io;
 		bio->bi_private = par;
@@ -511,7 +512,7 @@ bl_do_readpage_sync(struct page *page, struct pnfs_block_extent *be,
 	isect = (page->index << PAGE_CACHE_SECTOR_SHIFT) +
 		(offset / SECTOR_SIZE);
 
-	bio->bi_sector = isect - be->be_f_offset + be->be_v_offset;
+	bio->bi_iter.bi_sector = isect - be->be_f_offset + be->be_v_offset;
 	bio->bi_bdev = be->be_mdev;
 	bio->bi_end_io = bl_read_single_end_io;
 
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 2d8be51..dc3a9efd 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -416,7 +416,8 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
 	}
 	if (likely(bio)) {
 		bio->bi_bdev = nilfs->ns_bdev;
-		bio->bi_sector = start << (nilfs->ns_blocksize_bits - 9);
+		bio->bi_iter.bi_sector =
+			start << (nilfs->ns_blocksize_bits - 9);
 	}
 	return bio;
 }
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 73920ff..bf482df 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -413,7 +413,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_sector = (reg->hr_start_block + cs) << (bits - 9);
+	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
 	bio->bi_bdev = reg->hr_bdev;
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 71c8c9d..1b19b9c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -407,7 +407,7 @@ xfs_alloc_ioend_bio(
 	struct bio		*bio = bio_alloc(GFP_NOIO, nvecs);
 
 	ASSERT(bio->bi_private == NULL);
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
 	return bio;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c7f0b77..5f3ea44 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1255,7 +1255,7 @@ next_chunk:
 
 	bio = bio_alloc(GFP_NOIO, nr_pages);
 	bio->bi_bdev = bp->b_target->bt_bdev;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
 
@@ -1277,7 +1277,7 @@ next_chunk:
 		total_nr_pages--;
 	}
 
-	if (likely(bio->bi_size)) {
+	if (likely(bio->bi_iter.bi_size)) {
 		if (xfs_buf_is_vmapped(bp)) {
 			flush_kernel_vmap_range(bp->b_addr,
 						xfs_buf_vmap_len(bp));
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 060ff69..e2e0bc6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -62,19 +62,19 @@
  * on highmem page vectors
  */
 #define bio_iovec_idx(bio, idx)	(&((bio)->bi_io_vec[(idx)]))
-#define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
+#define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_iter.bi_idx)
 #define bio_page(bio)		bio_iovec((bio))->bv_page
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
-#define bio_segments(bio)	((bio)->bi_vcnt - (bio)->bi_idx)
-#define bio_sectors(bio)	((bio)->bi_size >> 9)
-#define bio_end_sector(bio)	((bio)->bi_sector + bio_sectors((bio)))
+#define bio_segments(bio)	((bio)->bi_vcnt - (bio)->bi_iter.bi_idx)
+#define bio_sectors(bio)	((bio)->bi_iter.bi_size >> 9)
+#define bio_end_sector(bio)	((bio)->bi_iter.bi_sector + bio_sectors((bio)))
 
 static inline unsigned int bio_cur_bytes(struct bio *bio)
 {
 	if (bio->bi_vcnt)
 		return bio_iovec(bio)->bv_len;
 	else /* dataless requests such as discard */
-		return bio->bi_size;
+		return bio->bi_iter.bi_size;
 }
 
 static inline void *bio_data(struct bio *bio)
@@ -108,7 +108,7 @@ static inline void *bio_data(struct bio *bio)
  */
 
 #define __BVEC_END(bio)		bio_iovec_idx((bio), (bio)->bi_vcnt - 1)
-#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_idx)
+#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_iter.bi_idx)
 
 /* Default implementation of BIOVEC_PHYS_MERGEABLE */
 #define __BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
@@ -150,7 +150,7 @@ static inline void *bio_data(struct bio *bio)
 	     i++)
 
 #define bio_for_each_segment(bvl, bio, i)				\
-	for (i = (bio)->bi_idx;						\
+	for (i = (bio)->bi_iter.bi_idx;					\
 	     bvl = bio_iovec_idx((bio), (i)), i < (bio)->bi_vcnt;	\
 	     i++)
 
@@ -365,7 +365,7 @@ static inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
 #define __bio_kunmap_irq(buf, flags)	bvec_kunmap_irq(buf, flags)
 
 #define bio_kmap_irq(bio, flags) \
-	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
+	__bio_kmap_irq((bio), (bio)->bi_iter.bi_idx, (flags))
 #define bio_kunmap_irq(buf,flags)	__bio_kunmap_irq(buf, flags)
 
 /*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 238ef0e..29b5b84 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -28,13 +28,19 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
+struct bvec_iter {
+	sector_t		bi_sector;	/* device address in 512 byte
+						   sectors */
+	unsigned int		bi_size;	/* residual I/O count */
+
+	unsigned int		bi_idx;		/* current index into bvl_vec */
+};
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
  */
 struct bio {
-	sector_t		bi_sector;	/* device address in 512 byte
-						   sectors */
 	struct bio		*bi_next;	/* request queue link */
 	struct block_device	*bi_bdev;
 	unsigned long		bi_flags;	/* status, command, etc */
@@ -42,16 +48,13 @@ struct bio {
 						 * top bits priority
 						 */
 
-	unsigned short		bi_vcnt;	/* how many bio_vec's */
-	unsigned short		bi_idx;		/* current index into bvl_vec */
+	struct bvec_iter	bi_iter;
 
 	/* Number of segments in this BIO after
 	 * physical address coalescing is performed.
 	 */
 	unsigned int		bi_phys_segments;
 
-	unsigned int		bi_size;	/* residual I/O count */
-
 	/*
 	 * To keep track of the max segment size, we account for the
 	 * sizes of the first and last mergeable segments in this bio.
@@ -74,11 +77,13 @@ struct bio {
 	struct bio_integrity_payload *bi_integrity;  /* data integrity */
 #endif
 
+	unsigned short		bi_vcnt;	/* how many bio_vec's */
+
 	/*
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
 	 */
 
-	unsigned int		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
 
 	atomic_t		bi_cnt;		/* pin count */
 
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index e2b9576..095c6e4 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -24,10 +24,10 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->orig_major	= d->disk->major;
 		__entry->orig_minor	= d->disk->first_minor;
-		__entry->sector		= bio->bi_sector;
-		__entry->orig_sector	= bio->bi_sector - 16;
-		__entry->nr_sector	= bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->orig_sector	= bio->bi_iter.bi_sector - 16;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
@@ -99,9 +99,9 @@ DECLARE_EVENT_CLASS(bcache_bio,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
-		__entry->nr_sector	= bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d  %s %llu + %u",
@@ -134,9 +134,9 @@ TRACE_EVENT(bcache_read,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
-		__entry->nr_sector	= bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		__entry->cache_hit = hit;
 		__entry->bypass = bypass;
 	),
@@ -162,9 +162,9 @@ TRACE_EVENT(bcache_write,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
-		__entry->nr_sector	= bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		__entry->writeback = writeback;
 		__entry->bypass = bypass;
 	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 4c2301d..e76ae19 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -243,9 +243,9 @@ TRACE_EVENT(block_bio_bounce,
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev ?
 					  bio->bi_bdev->bd_dev : 0;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -280,10 +280,10 @@ TRACE_EVENT(block_bio_complete,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->error		= error;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%d]",
@@ -308,9 +308,9 @@ DECLARE_EVENT_CLASS(block_bio_merge,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -375,9 +375,9 @@ TRACE_EVENT(block_bio_queue,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -403,7 +403,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
 
 	TP_fast_assign(
 		__entry->dev		= bio ? bio->bi_bdev->bd_dev : 0;
-		__entry->sector		= bio ? bio->bi_sector : 0;
+		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
 		blk_fill_rwbs(__entry->rwbs,
 			      bio ? bio->bi_rw : 0, __entry->nr_sector);
@@ -538,9 +538,9 @@ TRACE_EVENT(block_split,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -579,11 +579,11 @@ TRACE_EVENT(block_bio_remap,
 
 	TP_fast_assign(
 		__entry->dev		= bio->bi_bdev->bd_dev;
-		__entry->sector		= bio->bi_sector;
+		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e0dc355..bd3ee4f 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -616,8 +616,8 @@ TRACE_EVENT(f2fs_do_submit_bio,
 		__entry->dev		= sb->s_dev;
 		__entry->btype		= btype;
 		__entry->sync		= sync;
-		__entry->sector		= bio->bi_sector;
-		__entry->size		= bio->bi_size;
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->size		= bio->bi_iter.bi_size;
 	),
 
 	TP_printk("dev = (%d,%d), type = %s, io = %s, sector = %lld, size = %u",
diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index d09dd10..9a58bc2 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -32,7 +32,7 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
 	struct bio *bio;
 
 	bio = bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = bdev;
 	bio->bi_end_io = end_swap_bio_read;
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f785aef..b418cb0 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -781,8 +781,8 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 	if (!error && !bio_flagged(bio, BIO_UPTODATE))
 		error = EIO;
 
-	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw, what,
-			error, 0, NULL);
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio->bi_rw, what, error, 0, NULL);
 }
 
 static void blk_add_trace_bio_bounce(void *ignore,
@@ -885,8 +885,9 @@ static void blk_add_trace_split(void *ignore,
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(pdu);
 
-		__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw,
-				BLK_TA_SPLIT, !bio_flagged(bio, BIO_UPTODATE),
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio->bi_rw, BLK_TA_SPLIT,
+				!bio_flagged(bio, BIO_UPTODATE),
 				sizeof(rpdu), &rpdu);
 	}
 }
@@ -918,9 +919,9 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.device_to   = cpu_to_be32(bio->bi_bdev->bd_dev);
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw,
-			BLK_TA_REMAP, !bio_flagged(bio, BIO_UPTODATE),
-			sizeof(r), &r);
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio->bi_rw, BLK_TA_REMAP,
+			!bio_flagged(bio, BIO_UPTODATE), sizeof(r), &r);
 }
 
 /**
diff --git a/mm/page_io.c b/mm/page_io.c
index 8c79a47..f14eded 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -31,13 +31,13 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 	bio = bio_alloc(gfp_flags, 1);
 	if (bio) {
-		bio->bi_sector = map_swap_page(page, &bio->bi_bdev);
-		bio->bi_sector <<= PAGE_SHIFT - 9;
+		bio->bi_iter.bi_sector = map_swap_page(page, &bio->bi_bdev);
+		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_io_vec[0].bv_page = page;
 		bio->bi_io_vec[0].bv_len = PAGE_SIZE;
 		bio->bi_io_vec[0].bv_offset = 0;
 		bio->bi_vcnt = 1;
-		bio->bi_size = PAGE_SIZE;
+		bio->bi_iter.bi_size = PAGE_SIZE;
 		bio->bi_end_io = end_io;
 	}
 	return bio;
@@ -62,7 +62,7 @@ void end_swap_bio_write(struct bio *bio, int err)
 		printk(KERN_ALERT "Write-error on swap-device (%u:%u:%Lu)\n",
 				imajor(bio->bi_bdev->bd_inode),
 				iminor(bio->bi_bdev->bd_inode),
-				(unsigned long long)bio->bi_sector);
+				(unsigned long long)bio->bi_iter.bi_sector);
 		ClearPageReclaim(page);
 	}
 	end_page_writeback(page);
@@ -80,7 +80,7 @@ void end_swap_bio_read(struct bio *bio, int err)
 		printk(KERN_ALERT "Read-error on swap-device (%u:%u:%Lu)\n",
 				imajor(bio->bi_bdev->bd_inode),
 				iminor(bio->bi_bdev->bd_inode),
-				(unsigned long long)bio->bi_sector);
+				(unsigned long long)bio->bi_iter.bi_sector);
 		goto out;
 	}
 
-- 
1.8.4.4

