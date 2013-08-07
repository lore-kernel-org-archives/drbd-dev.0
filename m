Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B45491058E23
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id A697C1B4386
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:48 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNgNbnOjuzdZ for <drbd-dev@lists.linbit.com>;
	Fri,  9 Aug 2013 09:43:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id E9DD41B4383
	for <drbd-dev@lists.linbit.com>; Fri,  9 Aug 2013 09:43:47 +0200 (CEST)
Resent-Message-ID: <20130809074347.GL10571@soda.linbit>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
	[209.85.160.46]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A061D1058DFD
	for <drbd-dev@lists.linbit.com>; Wed,  7 Aug 2013 23:55:06 +0200 (CEST)
Received: by mail-pb0-f46.google.com with SMTP id rq2so2401944pbb.19
	for <drbd-dev@lists.linbit.com>; Wed, 07 Aug 2013 14:55:04 -0700 (PDT)
From: Kent Overstreet <kmo@daterainc.com>
To: axboe@kernel.dk
Date: Wed,  7 Aug 2013 14:54:13 -0700
Message-Id: <1375912471-5106-5-git-send-email-kmo@daterainc.com>
In-Reply-To: <1375912471-5106-1-git-send-email-kmo@daterainc.com>
References: <1375912471-5106-1-git-send-email-kmo@daterainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Nitin Gupta <ngupta@vflare.org>,
	Len Brown <len.brown@intel.com>, Sage Weil <sage@inktank.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Joern Engel <joern@logfs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Kent Overstreet <kmo@daterainc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Yehuda Sadeh <yehuda@inktank.com>, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Guo Chao <yan@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
	"Ed L. Cashin" <ecashin@coraid.com>,
	Pankaj Kumar <pankaj.km@samsung.com>, dm-devel@redhat.com,
	KONISHI Ryusuke <konishi.ryusuke@lab.ntt.co.jp>,
	Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Jie Liu <jeff.liu@oracle.com>, Mark Fasheh <mfasheh@suse.com>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Asai Thambi S P <asamymuthupa@micron.com>,
	Prasad Joshi <prasadjoshi.linux@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>,
	Ben Myers <bpm@sgi.com>, Jerome Marchand <jmarchand@redhat.com>,
	Selvan Mani <smani@micron.com>, Theodore Ts'o <tytso@mit.edu>,
	Minchan Kim <minchan@kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Chris Mason <chris.mason@fusionio.com>,
	fanchaoting <fanchaoting@cn.fujitsu.com>, Jan Beulich <jbeulich@suse.com>,
	Jaegeuk Kim <jaegeuk.kim@samsung.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Nick Piggin <npiggin@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>, xfs@oss.sgi.com,
	Andy Adamson <andros@netapp.com>, ceph-devel@vger.kernel.org,
	Alex Elder <elder@inktank.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sam Bradshaw <sbradshaw@micron.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-fsdevel@vger.kernel.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, neilb@suse.de,
	Peng Tao <tao.peng@emc.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Jiang Liu <jiang.liu@huawei.com>, Benny Halevy <bhalevy@tonian.com>,
	Ingo Molnar <mingo@redhat.com>, Boaz Harrosh <bharrosh@panasas.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-raid@vger.kernel.org,
	Steven Whitehouse <swhiteho@redhat.com>, Joel Becker <jlbec@evilplan.org>
Subject: [Drbd-dev] [PATCH 04/22] block: Abstract out bvec iterator
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
Cc: Mel Gorman <mgorman@suse.de>
---
 Documentation/block/biodoc.txt      |  7 ++-
 arch/m68k/emu/nfblock.c             |  2 +-
 arch/powerpc/sysdev/axonram.c       |  3 +-
 block/blk-core.c                    | 36 +++++++--------
 block/blk-flush.c                   |  2 +-
 block/blk-lib.c                     | 12 ++---
 block/blk-map.c                     |  6 +--
 block/blk-merge.c                   |  4 +-
 block/blk-throttle.c                | 14 +++---
 block/elevator.c                    |  2 +-
 drivers/block/aoe/aoecmd.c          |  6 +--
 drivers/block/brd.c                 |  4 +-
 drivers/block/drbd/drbd_actlog.c    |  2 +-
 drivers/block/drbd/drbd_bitmap.c    |  2 +-
 drivers/block/drbd/drbd_receiver.c  |  6 +--
 drivers/block/drbd/drbd_req.c       |  6 +--
 drivers/block/drbd/drbd_req.h       |  2 +-
 drivers/block/floppy.c              |  4 +-
 drivers/block/loop.c                |  4 +-
 drivers/block/mtip32xx/mtip32xx.c   |  7 +--
 drivers/block/nvme-core.c           | 25 +++++-----
 drivers/block/pktcdvd.c             | 51 +++++++++++----------
 drivers/block/ps3disk.c             |  2 +-
 drivers/block/rbd.c                 | 21 +++++----
 drivers/block/rsxx/dev.c            |  6 +--
 drivers/block/rsxx/dma.c            |  4 +-
 drivers/block/umem.c                |  9 ++--
 drivers/block/virtio_blk.c          |  4 +-
 drivers/block/xen-blkback/blkback.c |  2 +-
 drivers/block/xen-blkfront.c        |  2 +-
 drivers/md/bcache/alloc.c           |  4 +-
 drivers/md/bcache/btree.c           | 17 +++----
 drivers/md/bcache/debug.c           |  2 +-
 drivers/md/bcache/io.c              | 26 +++++------
 drivers/md/bcache/journal.c         | 12 ++---
 drivers/md/bcache/movinggc.c        |  4 +-
 drivers/md/bcache/request.c         | 50 ++++++++++----------
 drivers/md/bcache/super.c           | 16 +++----
 drivers/md/bcache/util.c            |  4 +-
 drivers/md/bcache/writeback.c       |  6 +--
 drivers/md/bcache/writeback.h       |  2 +-
 drivers/md/dm-bio-record.h          | 12 ++---
 drivers/md/dm-bufio.c               |  2 +-
 drivers/md/dm-cache-policy-mq.c     |  4 +-
 drivers/md/dm-cache-target.c        | 16 ++++---
 drivers/md/dm-crypt.c               | 20 ++++----
 drivers/md/dm-delay.c               |  7 +--
 drivers/md/dm-flakey.c              |  7 +--
 drivers/md/dm-io.c                  |  7 +--
 drivers/md/dm-linear.c              |  3 +-
 drivers/md/dm-raid1.c               | 16 +++----
 drivers/md/dm-region-hash.c         |  3 +-
 drivers/md/dm-snap.c                | 13 +++---
 drivers/md/dm-stripe.c              | 13 ++++--
 drivers/md/dm-switch.c              |  4 +-
 drivers/md/dm-thin.c                | 23 ++++++----
 drivers/md/dm-verity.c              |  9 ++--
 drivers/md/dm.c                     | 21 +++++----
 drivers/md/faulty.c                 | 19 +++++---
 drivers/md/linear.c                 | 12 ++---
 drivers/md/md.c                     | 10 ++--
 drivers/md/multipath.c              | 13 +++---
 drivers/md/raid0.c                  | 16 ++++---
 drivers/md/raid1.c                  | 63 +++++++++++++------------
 drivers/md/raid10.c                 | 91 ++++++++++++++++++++-----------------
 drivers/md/raid5.c                  | 72 +++++++++++++++--------------
 drivers/s390/block/dcssblk.c        |  5 +-
 drivers/s390/block/xpram.c          |  9 ++--
 drivers/scsi/osd/osd_initiator.c    |  2 +-
 drivers/staging/zram/zram_drv.c     | 14 +++---
 drivers/target/target_core_iblock.c |  2 +-
 fs/bio-integrity.c                  |  8 ++--
 fs/bio.c                            | 56 ++++++++++++-----------
 fs/btrfs/check-integrity.c          | 10 ++--
 fs/btrfs/compression.c              | 17 +++----
 fs/btrfs/extent_io.c                | 16 +++----
 fs/btrfs/file-item.c                | 15 +++---
 fs/btrfs/inode.c                    | 19 ++++----
 fs/btrfs/raid56.c                   | 22 ++++-----
 fs/btrfs/scrub.c                    | 12 ++---
 fs/btrfs/volumes.c                  | 12 ++---
 fs/buffer.c                         | 12 ++---
 fs/direct-io.c                      |  4 +-
 fs/ext4/page-io.c                   |  4 +-
 fs/f2fs/data.c                      |  2 +-
 fs/f2fs/segment.c                   |  3 +-
 fs/gfs2/lops.c                      |  2 +-
 fs/gfs2/ops_fstype.c                |  2 +-
 fs/hfsplus/wrapper.c                |  2 +-
 fs/jfs/jfs_logmgr.c                 | 12 ++---
 fs/jfs/jfs_metapage.c               |  9 ++--
 fs/logfs/dev_bdev.c                 | 20 ++++----
 fs/mpage.c                          |  2 +-
 fs/nfs/blocklayout/blocklayout.c    |  9 ++--
 fs/nilfs2/segbuf.c                  |  3 +-
 fs/ocfs2/cluster/heartbeat.c        |  2 +-
 fs/xfs/xfs_aops.c                   |  2 +-
 fs/xfs/xfs_buf.c                    |  4 +-
 include/linux/bio.h                 | 16 +++----
 include/linux/blk_types.h           | 19 +++++---
 include/trace/events/bcache.h       | 26 +++++------
 include/trace/events/block.h        | 26 +++++------
 include/trace/events/f2fs.h         |  4 +-
 kernel/power/block_io.c             |  2 +-
 kernel/trace/blktrace.c             | 15 +++---
 mm/page_io.c                        | 10 ++--
 106 files changed, 689 insertions(+), 618 deletions(-)

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
index e301133..9070d6c 100644
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
index 93a18d1..0ec13409 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -166,7 +166,7 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 	bio_advance(bio, nbytes);
 
 	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_size == 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
+	if (bio->bi_iter.bi_size == 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
 		bio_endio(bio, error);
 }
 
@@ -1333,7 +1333,7 @@ void blk_add_request_payload(struct request *rq, struct page *page,
 	bio->bi_io_vec->bv_offset = 0;
 	bio->bi_io_vec->bv_len = len;
 
-	bio->bi_size = len;
+	bio->bi_iter.bi_size = len;
 	bio->bi_vcnt = 1;
 	bio->bi_phys_segments = 1;
 
@@ -1358,7 +1358,7 @@ static bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
-	req->__data_len += bio->bi_size;
+	req->__data_len += bio->bi_iter.bi_size;
 	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	drive_stat_acct(req, 0);
@@ -1387,8 +1387,8 @@ static bool bio_attempt_front_merge(struct request_queue *q,
 	 * not touch req->buffer either...
 	 */
 	req->buffer = bio_data(bio);
-	req->__sector = bio->bi_sector;
-	req->__data_len += bio->bi_size;
+	req->__sector = bio->bi_iter.bi_sector;
+	req->__data_len += bio->bi_iter.bi_size;
 	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	drive_stat_acct(req, 0);
@@ -1457,7 +1457,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
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
@@ -2335,9 +2335,9 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 	total_bytes = 0;
 	while (req->bio) {
 		struct bio *bio = req->bio;
-		unsigned bio_bytes = min(bio->bi_size, nr_bytes);
+		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
-		if (bio_bytes == bio->bi_size)
+		if (bio_bytes == bio->bi_iter.bi_size)
 			req->bio = bio->bi_next;
 
 		req_bio_endio(req, bio, bio_bytes, error);
@@ -2686,7 +2686,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
 		rq->buffer = bio_data(bio);
 	}
-	rq->__data_len = bio->bi_size;
+	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 
 	if (bio->bi_bdev)
diff --git a/block/blk-flush.c b/block/blk-flush.c
index cc2b827..3248998 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -444,7 +444,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	 * copied from blk_rq_pos(rq).
 	 */
 	if (error_sector)
-		*error_sector = bio->bi_sector;
+		*error_sector = bio->bi_iter.bi_sector;
 
 	if (!bio_flagged(bio, BIO_UPTODATE))
 		ret = -EIO;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index d6f50d5..3250620 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -110,12 +110,12 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
 
@@ -176,7 +176,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			break;
 		}
 
-		bio->bi_sector = sector;
+		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;
 		bio->bi_bdev = bdev;
 		bio->bi_private = &bb;
@@ -186,11 +186,11 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
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
 
@@ -242,7 +242,7 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
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
index 5f24482..7750b25 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -532,9 +532,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
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
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 08a32df..1b1bea0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -867,14 +867,14 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
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
@@ -977,7 +977,7 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	bool rw = bio_data_dir(bio);
 
 	/* Charge the bio to the group */
-	tg->bytes_disp[rw] += bio->bi_size;
+	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
 
 	/*
@@ -993,8 +993,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	 */
 	if (!(bio->bi_rw & REQ_THROTTLED)) {
 		bio->bi_rw |= REQ_THROTTLED;
-		throtl_update_dispatch_stats(tg_to_blkg(tg), bio->bi_size,
-					     bio->bi_rw);
+		throtl_update_dispatch_stats(tg_to_blkg(tg),
+					     bio->bi_iter.bi_size, bio->bi_rw);
 	}
 }
 
@@ -1499,7 +1499,7 @@ bool blk_throtl_bio(struct request_queue *q, struct bio *bio)
 	if (tg) {
 		if (!tg->has_rules[rw]) {
 			throtl_update_dispatch_stats(tg_to_blkg(tg),
-						     bio->bi_size, bio->bi_rw);
+					bio->bi_iter.bi_size, bio->bi_rw);
 			goto out_unlock_rcu;
 		}
 	}
@@ -1555,7 +1555,7 @@ bool blk_throtl_bio(struct request_queue *q, struct bio *bio)
 	/* out-of-limit, queue to @tg */
 	throtl_log(sq, "[%c] bio. bdisp=%llu sz=%u bps=%llu iodisp=%u iops=%u queued=%d/%d",
 		   rw == READ ? 'R' : 'W',
-		   tg->bytes_disp[rw], bio->bi_size, tg->bps[rw],
+		   tg->bytes_disp[rw], bio->bi_iter.bi_size, tg->bps[rw],
 		   tg->io_disp[rw], tg->iops[rw],
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
diff --git a/block/elevator.c b/block/elevator.c
index 668394d..803e855 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -434,7 +434,7 @@ int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
 	/*
 	 * See if our hash lookup can find a potential backmerge.
 	 */
-	__rq = elv_rqhash_find(q, bio->bi_sector);
+	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		*req = __rq;
 		return ELEVATOR_BACK_MERGE;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 99cb944..3f1a192 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -936,8 +936,8 @@ bufinit(struct buf *buf, struct request *rq, struct bio *bio)
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
@@ -1159,7 +1159,7 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
 	do {
 		bio = rq->bio;
 		bok = !fastfail && test_bit(BIO_UPTODATE, &bio->bi_flags);
-	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_size));
+	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_iter.bi_size));
 
 	/* cf. http://lkml.org/lkml/2006/10/31/28 */
 	if (!fastfail)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 9bf4371..e269532 100644
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
index 64fbb83..d0d847a 100644
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
index cc29cd3..cf6d072 100644
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
index c24379f..a6bedaa 100644
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
index 04ceb7e..bf7b8b2 100644
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
index 40e7155..2440b50 100644
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
index 952dbfe..a49bdaf 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3890,7 +3890,7 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 	}
 
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
-		bio_endio(bio, mtip_send_trim(dd, bio->bi_sector,
+		bio_endio(bio, mtip_send_trim(dd, bio->bi_iter.bi_sector,
 						bio_sectors(bio)));
 		return;
 	}
@@ -3903,7 +3903,8 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 
 	if (bio_data_dir(bio) == WRITE && bio_sectors(bio) <= 64 &&
 							dd->unal_qdepth) {
-		if (bio->bi_sector % 8 != 0) /* Unaligned on 4k boundaries */
+		if (bio->bi_iter.bi_sector % 8 != 0)
+			/* Unaligned on 4k boundaries */
 			unaligned = 1;
 		else if (bio_sectors(bio) % 8 != 0) /* Aligned but not 4k/8k */
 			unaligned = 1;
@@ -3932,7 +3933,7 @@ static void mtip_make_request(struct request_queue *queue, struct bio *bio)
 
 		/* Issue the read/write. */
 		mtip_hw_submit_io(dd,
-				bio->bi_sector,
+				bio->bi_iter.bi_sector,
 				bio_sectors(bio),
 				nents,
 				tag,
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..685cfb1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -435,7 +435,7 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 {
 	struct nvme_bio_pair *bp;
 
-	BUG_ON(len > bio->bi_size);
+	BUG_ON(len > bio->bi_iter.bi_size);
 	BUG_ON(idx > bio->bi_vcnt);
 
 	bp = kmalloc(sizeof(*bp), GFP_ATOMIC);
@@ -446,11 +446,11 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
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
@@ -519,11 +519,12 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
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
@@ -551,7 +552,7 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
 		return -ENOMEM;
 
-	BUG_ON(length != bio->bi_size);
+	BUG_ON(length != bio->bi_iter.bi_size);
 	return length;
 }
 
@@ -575,8 +576,8 @@ static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	iod->npages = 0;
 
 	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(bio->bi_size >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	range->nlb = cpu_to_le32(bio->bi_iter.bi_size >> ns->lba_shift);
+	range->slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
@@ -641,7 +642,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	}
 
 	result = -ENOMEM;
-	iod = nvme_alloc_iod(psegs, bio->bi_size, GFP_ATOMIC);
+	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
 	if (!iod)
 		goto nomem;
 	iod->private = bio;
@@ -690,7 +691,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
 	length = nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, length,
 								GFP_ATOMIC);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
 	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f5d0ea1..f16dfca 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -659,7 +659,7 @@ static struct pkt_rb_node *pkt_rbtree_find(struct pktcdvd_device *pd, sector_t s
 
 	for (;;) {
 		tmp = rb_entry(n, struct pkt_rb_node, rb_node);
-		if (s <= tmp->bio->bi_sector)
+		if (s <= tmp->bio->bi_iter.bi_sector)
 			next = n->rb_left;
 		else
 			next = n->rb_right;
@@ -668,12 +668,12 @@ static struct pkt_rb_node *pkt_rbtree_find(struct pktcdvd_device *pd, sector_t s
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
 
@@ -684,13 +684,13 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
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
@@ -868,7 +868,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 			spin_lock(&pd->iosched.lock);
 			bio = bio_list_peek(&pd->iosched.write_queue);
 			spin_unlock(&pd->iosched.lock);
-			if (bio && (bio->bi_sector == pd->iosched.last_write))
+			if (bio && (bio->bi_iter.bi_sector ==
+				    pd->iosched.last_write))
 				need_write_seek = 0;
 			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
@@ -899,7 +900,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 			continue;
 
 		if (bio_data_dir(bio) == READ)
-			pd->iosched.successive_reads += bio->bi_size >> 10;
+			pd->iosched.successive_reads +=
+				bio->bi_iter.bi_size >> 10;
 		else {
 			pd->iosched.successive_reads = 0;
 			pd->iosched.last_write = bio_end_sector(bio);
@@ -988,7 +990,8 @@ static void pkt_end_io_read(struct bio *bio, int err)
 	BUG_ON(!pd);
 
 	VPRINTK("pkt_end_io_read: bio=%p sec0=%llx sec=%llx err=%d\n", bio,
-		(unsigned long long)pkt->sector, (unsigned long long)bio->bi_sector, err);
+		(unsigned long long)pkt->sector,
+		(unsigned long long)bio->bi_iter.bi_sector, err);
 
 	if (err)
 		atomic_inc(&pkt->io_errors);
@@ -1036,8 +1039,9 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
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
@@ -1063,7 +1067,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 		bio = pkt->r_bios[f];
 		bio_reset(bio);
-		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_bdev = pd->bdev;
 		bio->bi_end_io = pkt_end_io_read;
 		bio->bi_private = pkt;
@@ -1160,8 +1164,8 @@ static int pkt_start_recovery(struct packet_data *pkt)
 	bio_reset(pkt->bio);
 	pkt->bio->bi_bdev = pd->bdev;
 	pkt->bio->bi_rw = REQ_WRITE;
-	pkt->bio->bi_sector = new_sector;
-	pkt->bio->bi_size = pkt->frames * CD_FRAMESIZE;
+	pkt->bio->bi_iter.bi_sector = new_sector;
+	pkt->bio->bi_iter.bi_size = pkt->frames * CD_FRAMESIZE;
 	pkt->bio->bi_vcnt = pkt->frames;
 
 	pkt->bio->bi_end_io = pkt_end_io_packet_write;
@@ -1224,7 +1228,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	node = first_node;
 	while (node) {
 		bio = node->bio;
-		zone = ZONE(bio->bi_sector, pd);
+		zone = ZONE(bio->bi_iter.bi_sector, pd);
 		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
 			if (p->sector == zone) {
 				bio = NULL;
@@ -1264,13 +1268,13 @@ try_next_bio:
 	while ((node = pkt_rbtree_find(pd, zone)) != NULL) {
 		bio = node->bio;
 		VPRINTK("pkt_handle_queue: found zone=%llx\n",
-			(unsigned long long)ZONE(bio->bi_sector, pd));
-		if (ZONE(bio->bi_sector, pd) != zone)
+			(unsigned long long)ZONE(bio->bi_iter.bi_sector, pd));
+		if (ZONE(bio->bi_iter.bi_sector, pd) != zone)
 			break;
 		pkt_rbtree_erase(pd, node);
 		spin_lock(&pkt->lock);
 		bio_list_add(&pkt->orig_bios, bio);
-		pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+		pkt->write_size += bio->bi_iter.bi_size / CD_FRAMESIZE;
 		spin_unlock(&pkt->lock);
 	}
 	/* check write congestion marks, and if bio_queue_size is
@@ -1304,7 +1308,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	struct bio_vec *bvec = pkt->w_bio->bi_io_vec;
 
 	bio_reset(pkt->w_bio);
-	pkt->w_bio->bi_sector = pkt->sector;
+	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
 	pkt->w_bio->bi_bdev = pd->bdev;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
 	pkt->w_bio->bi_private = pkt;
@@ -2383,18 +2387,18 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
 		printk(DRIVER_NAME": WRITE for ro device %s (%llu)\n",
-			pd->name, (unsigned long long)bio->bi_sector);
+			pd->name, (unsigned long long)bio->bi_iter.bi_sector);
 		goto end_io;
 	}
 
-	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
+	if (!bio->bi_iter.bi_size || (bio->bi_iter.bi_size % CD_FRAMESIZE)) {
 		printk(DRIVER_NAME": wrong bio size\n");
 		goto end_io;
 	}
 
 	blk_queue_bounce(q, &bio);
 
-	zone = ZONE(bio->bi_sector, pd);
+	zone = ZONE(bio->bi_iter.bi_sector, pd);
 	VPRINTK("pkt_make_request: start = %6llx stop = %6llx\n",
 		(unsigned long long)bio->bi_sector,
 		(unsigned long long)bio_end_sector(bio));
@@ -2408,7 +2412,7 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 		last_zone = ZONE(bio_end_sector(bio) - 1, pd);
 		if (last_zone != zone) {
 			BUG_ON(last_zone != zone + pd->settings.size);
-			first_sectors = last_zone - bio->bi_sector;
+			first_sectors = last_zone - bio->bi_iter.bi_sector;
 			bp = bio_split(bio, first_sectors);
 			BUG_ON(!bp);
 			pkt_make_request(q, &bp->bio1);
@@ -2430,7 +2434,8 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
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
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ad2ad9..99334ac 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1177,14 +1177,14 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 
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
@@ -1214,7 +1214,8 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 		return NULL;	/* ENOMEM */
 
 	bio->bi_bdev = bio_src->bi_bdev;
-	bio->bi_sector = bio_src->bi_sector + (offset >> SECTOR_SHIFT);
+	bio->bi_iter.bi_sector = bio_src->bi_iter.bi_sector +
+		(offset >> SECTOR_SHIFT);
 	bio->bi_rw = bio_src->bi_rw;
 	bio->bi_flags |= 1 << BIO_CLONED;
 
@@ -1233,8 +1234,7 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 	}
 
 	bio->bi_vcnt = vcnt;
-	bio->bi_size = len;
-	bio->bi_idx = 0;
+	bio->bi_iter.bi_size = len;
 
 	return bio;
 }
@@ -1265,7 +1265,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 
 	/* Build up a chain of clone bios up to the limit */
 
-	if (!bi || off >= bi->bi_size || !len)
+	if (!bi || off >= bi->bi_iter.bi_size || !len)
 		return NULL;		/* Nothing to clone */
 
 	end = &chain;
@@ -1277,7 +1277,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 			rbd_warn(NULL, "bio_chain exhausted with %u left", len);
 			goto out_err;	/* EINVAL; ran out of bio's */
 		}
-		bi_size = min_t(unsigned int, bi->bi_size - off, len);
+		bi_size = min_t(unsigned int, bi->bi_iter.bi_size - off, len);
 		bio = bio_clone_range(bi, off, bi_size, gfpmask);
 		if (!bio)
 			goto out_err;	/* ENOMEM */
@@ -1286,7 +1286,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 		end = &bio->bi_next;
 
 		off += bi_size;
-		if (off == bi->bi_size) {
+		if (off == bi->bi_iter.bi_size) {
 			bi = bi->bi_next;
 			off = 0;
 		}
@@ -2180,7 +2180,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 	if (type == OBJ_REQUEST_BIO) {
 		bio_list = data_desc;
-		rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
+		rbd_assert(img_offset ==
+			   bio_list->bi_iter.bi_sector << SECTOR_SHIFT);
 	} else {
 		rbd_assert(type == OBJ_REQUEST_PAGES);
 		pages = data_desc;
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index d7af441..9b17fa0 100644
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
index bed32f1..9e6318a 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -667,7 +667,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 	int st;
 	int i;
 
-	addr8 = bio->bi_sector << 9; /* sectors are 512 bytes */
+	addr8 = bio->bi_iter.bi_sector << 9; /* sectors are 512 bytes */
 	atomic_set(n_dmas, 0);
 
 	for (i = 0; i < card->n_targets; i++) {
@@ -676,7 +676,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
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
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5cdf88b..93fde08 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -184,7 +184,7 @@ static void virtblk_bio_send_data(struct virtblk_req *vbr)
 
 	vbr->flags &= ~VBLK_IS_FLUSH;
 	vbr->out_hdr.type = 0;
-	vbr->out_hdr.sector = bio->bi_sector;
+	vbr->out_hdr.sector = bio->bi_iter.bi_sector;
 	vbr->out_hdr.ioprio = bio_prio(bio);
 
 	if (blk_bio_map_sg(vblk->disk->queue, bio, vbr->sg)) {
@@ -400,7 +400,7 @@ static void virtblk_make_request(struct request_queue *q, struct bio *bio)
 		vbr->flags |= VBLK_REQ_FLUSH;
 	if (bio->bi_rw & REQ_FUA)
 		vbr->flags |= VBLK_REQ_FUA;
-	if (bio->bi_size)
+	if (bio->bi_iter.bi_size)
 		vbr->flags |= VBLK_REQ_DATA;
 
 	if (unlikely(vbr->flags & VBLK_REQ_FLUSH))
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index bf4b9d2..ce0674f 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1256,7 +1256,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 			bio->bi_bdev    = preq.bdev;
 			bio->bi_private = pending_req;
 			bio->bi_end_io  = end_block_io_op;
-			bio->bi_sector  = preq.sector_number;
+			bio->bi_iter.bi_sector  = preq.sector_number;
 		}
 
 		preq.sector_number += seg[i].nsec;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8d53ed2..a2ade73 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1468,7 +1468,7 @@ static int blkif_recover(struct blkfront_info *info)
 			for (i = 0; i < pending; i++) {
 				offset = (i * segs * PAGE_SIZE) >> 9;
 				size = min((unsigned int)(segs * PAGE_SIZE) >> 9,
-					   (unsigned int)(bio->bi_size >> 9) - offset);
+					   (unsigned int)bio_sectors(bio) - offset);
 				cloned_bio = bio_clone(bio, GFP_NOIO);
 				BUG_ON(cloned_bio == NULL);
 				bio_trim(cloned_bio, offset, size);
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index e45f557..9afe32f 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -178,12 +178,12 @@ static void do_discard(struct cache *ca, long bucket)
 
 	bio_init(&d->bio);
 
-	d->bio.bi_sector	= bucket_to_sector(ca->set, d->bucket);
+	d->bio.bi_iter.bi_sector = bucket_to_sector(ca->set, d->bucket);
 	d->bio.bi_bdev		= ca->bdev;
 	d->bio.bi_rw		= REQ_WRITE|REQ_DISCARD;
 	d->bio.bi_max_vecs	= 1;
 	d->bio.bi_io_vec	= d->bio.bi_inline_vecs;
-	d->bio.bi_size		= bucket_bytes(ca);
+	d->bio.bi_iter.bi_size	= bucket_bytes(ca);
 	d->bio.bi_end_io	= discard_endio;
 	bio_set_prio(&d->bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ee37288..933ed8d 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -230,7 +230,7 @@ void bch_btree_node_read(struct btree *b)
 
 	bio = bch_bbio_alloc(b->c);
 	bio->bi_rw	= REQ_META|READ_SYNC;
-	bio->bi_size	= KEY_SIZE(&b->key) << 9;
+	bio->bi_iter.bi_size = KEY_SIZE(&b->key) << 9;
 	bio->bi_end_io	= btree_node_read_endio;
 	bio->bi_private	= &cl;
 
@@ -329,7 +329,7 @@ static void do_btree_node_write(struct btree *b)
 	b->bio->bi_end_io	= btree_node_write_endio;
 	b->bio->bi_private	= &b->io.cl;
 	b->bio->bi_rw		= REQ_META|WRITE_SYNC|REQ_FUA;
-	b->bio->bi_size		= set_blocks(i, b->c) * block_bytes(b->c);
+	b->bio->bi_iter.bi_size	= set_blocks(i, b->c) * block_bytes(b->c);
 	bch_bio_map(b->bio, i);
 
 	/*
@@ -2152,11 +2152,11 @@ static int submit_partial_cache_miss(struct btree *b, struct btree_op *op,
 		unsigned sectors = INT_MAX;
 
 		if (KEY_INODE(k) == op->inode) {
-			if (KEY_START(k) <= bio->bi_sector)
+			if (KEY_START(k) <= bio->bi_iter.bi_sector)
 				break;
 
 			sectors = min_t(uint64_t, sectors,
-					KEY_START(k) - bio->bi_sector);
+					KEY_START(k) - bio->bi_iter.bi_sector);
 		}
 
 		ret = s->d->cache_miss(b, s, bio, sectors);
@@ -2188,12 +2188,12 @@ static int submit_partial_cache_hit(struct btree *b, struct btree_op *op,
 
 	while (!op->lookup_done &&
 	       KEY_INODE(k) == op->inode &&
-	       bio->bi_sector < KEY_OFFSET(k)) {
+	       bio->bi_iter.bi_sector < KEY_OFFSET(k)) {
 		struct bkey *bio_key;
 		sector_t sector = PTR_OFFSET(k, ptr) +
-			(bio->bi_sector - KEY_START(k));
+			(bio->bi_iter.bi_sector - KEY_START(k));
 		unsigned sectors = min_t(uint64_t, INT_MAX,
-					 KEY_OFFSET(k) - bio->bi_sector);
+				KEY_OFFSET(k) - bio->bi_iter.bi_sector);
 
 		n = bch_bio_split(bio, sectors, GFP_NOIO, s->d->bio_split);
 		if (n == bio)
@@ -2232,7 +2232,8 @@ int bch_btree_search_recurse(struct btree *b, struct btree_op *op)
 	int ret = 0;
 	struct bkey *k;
 	struct btree_iter iter;
-	bch_btree_iter_init(b, &iter, &KEY(op->inode, bio->bi_sector, 0));
+	bch_btree_iter_init(b, &iter, &KEY(op->inode,
+					   bio->bi_iter.bi_sector, 0));
 
 	do {
 		k = bch_btree_iter_next_filter(&iter, b, bch_ptr_bad);
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 545680b..84c93a1 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -215,7 +215,7 @@ void bch_data_verify(struct search *s)
 			printk(KERN_ERR
 			       "bcache (%s): verify failed at sector %llu\n",
 			       bdevname(dc->bdev, name),
-			       (uint64_t) s->orig_bio->bi_sector);
+			       (uint64_t) s->orig_bio->bi_iter.bi_sector);
 
 		kunmap(bv->bv_page);
 		kunmap(check->bi_io_vec[i].bv_page);
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
index ba95ab8..2169ad8 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -49,10 +49,10 @@ reread:		left = ca->sb.bucket_size - offset;
 		len = min_t(unsigned, left, PAGE_SECTORS * 8);
 
 		bio_reset(bio);
-		bio->bi_sector	= bucket + offset;
+		bio->bi_iter.bi_sector	= bucket + offset;
 		bio->bi_bdev	= ca->bdev;
 		bio->bi_rw	= READ;
-		bio->bi_size	= len << 9;
+		bio->bi_iter.bi_size	= len << 9;
 
 		bio->bi_end_io	= journal_read_endio;
 		bio->bi_private = &op->cl;
@@ -446,13 +446,13 @@ static void do_journal_discard(struct cache *ca)
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
@@ -623,10 +623,10 @@ static void journal_write_unlocked(struct closure *cl)
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
index 1a3b4f4..ef630f4 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -82,7 +82,7 @@ static void moving_init(struct moving_io *io)
 	bio_get(bio);
 	bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 
-	bio->bi_size		= KEY_SIZE(&io->w->key) << 9;
+	bio->bi_iter.bi_size	= KEY_SIZE(&io->w->key) << 9;
 	bio->bi_max_vecs	= DIV_ROUND_UP(KEY_SIZE(&io->w->key),
 					       PAGE_SECTORS);
 	bio->bi_private		= &io->s.cl;
@@ -98,7 +98,7 @@ static void write_moving(struct closure *cl)
 	if (!s->error) {
 		moving_init(io);
 
-		io->bio.bio.bi_sector	= KEY_START(&io->w->key);
+		io->bio.bio.bi_iter.bi_sector = KEY_START(&io->w->key);
 		s->op.lock		= -1;
 		s->op.write_prio	= 1;
 		s->op.cache_bio		= &io->bio.bio;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 2c2e1c1..d94c08f 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -219,7 +219,7 @@ static void bio_invalidate(struct closure *cl)
 	struct bio *bio = op->cache_bio;
 
 	pr_debug("invalidating %i sectors from %llu",
-		 bio_sectors(bio), (uint64_t) bio->bi_sector);
+		 bio_sectors(bio), (uint64_t) bio->bi_iter.bi_sector);
 
 	while (bio_sectors(bio)) {
 		unsigned len = min(bio_sectors(bio), 1U << 14);
@@ -227,11 +227,11 @@ static void bio_invalidate(struct closure *cl)
 		if (bch_keylist_realloc(&op->keys, 0, op->c))
 			goto out;
 
-		bio->bi_sector	+= len;
-		bio->bi_size	-= len << 9;
+		bio->bi_iter.bi_sector	+= len;
+		bio->bi_iter.bi_size	-= len << 9;
 
 		bch_keylist_add(&op->keys,
-				&KEY(op->inode, bio->bi_sector, len));
+				&KEY(op->inode, bio->bi_iter.bi_sector, len));
 	}
 
 	op->insert_data_done = true;
@@ -509,7 +509,7 @@ static void bch_insert_data_loop(struct closure *cl)
 		k = op->keys.top;
 		bkey_init(k);
 		SET_KEY_INODE(k, op->inode);
-		SET_KEY_OFFSET(k, bio->bi_sector);
+		SET_KEY_OFFSET(k, bio->bi_iter.bi_sector);
 
 		if (!bch_alloc_sectors(k, bio_sectors(bio), s))
 			goto err;
@@ -802,9 +802,12 @@ static void request_read_done(struct closure *cl)
 
 	if (s->op.cache_bio) {
 		bio_reset(s->op.cache_bio);
-		s->op.cache_bio->bi_sector	= s->cache_miss->bi_sector;
-		s->op.cache_bio->bi_bdev	= s->cache_miss->bi_bdev;
-		s->op.cache_bio->bi_size	= s->cache_bio_sectors << 9;
+		s->op.cache_bio->bi_iter.bi_sector =
+			s->cache_miss->bi_iter.bi_sector;
+		s->op.cache_bio->bi_bdev =
+			s->cache_miss->bi_bdev;
+		s->op.cache_bio->bi_iter.bi_size =
+			s->cache_bio_sectors << 9;
 		bch_bio_map(s->op.cache_bio, NULL);
 
 		bio_copy_data(s->cache_miss, s->op.cache_bio);
@@ -883,9 +886,9 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	if (!s->op.cache_bio)
 		goto out_submit;
 
-	s->op.cache_bio->bi_sector	= miss->bi_sector;
+	s->op.cache_bio->bi_iter.bi_sector = miss->bi_iter.bi_sector;
 	s->op.cache_bio->bi_bdev	= miss->bi_bdev;
-	s->op.cache_bio->bi_size	= s->cache_bio_sectors << 9;
+	s->op.cache_bio->bi_iter.bi_size = s->cache_bio_sectors << 9;
 
 	s->op.cache_bio->bi_end_io	= request_endio;
 	s->op.cache_bio->bi_private	= &s->cl;
@@ -939,7 +942,7 @@ static void request_write(struct cached_dev *dc, struct search *s)
 	struct closure *cl = &s->cl;
 	struct bio *bio = &s->bio.bio;
 	struct bkey start, end;
-	start = KEY(dc->disk.id, bio->bi_sector, 0);
+	start = KEY(dc->disk.id, bio->bi_iter.bi_sector, 0);
 	end = KEY(dc->disk.id, bio_end_sector(bio), 0);
 
 	bch_keybuf_check_overlapping(&s->op.c->moving_gc_keys, &start, &end);
@@ -980,7 +983,7 @@ static void request_write(struct cached_dev *dc, struct search *s)
 			s->op.cache_bio = bio_clone_bioset(bio, GFP_NOIO,
 							   dc->disk.bio_split);
 
-			bio->bi_size = 0;
+			bio->bi_iter.bi_size = 0;
 			bio->bi_vcnt = 0;
 			closure_bio_submit(bio, cl, s->d);
 		} else {
@@ -1081,8 +1084,8 @@ static void check_should_skip(struct cached_dev *dc, struct search *s)
 	     (bio->bi_rw & REQ_WRITE)))
 		goto skip;
 
-	if (bio->bi_sector   & (c->sb.block_size - 1) ||
-	    bio_sectors(bio) & (c->sb.block_size - 1)) {
+	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
+	    bio_sectors(bio)       & (c->sb.block_size - 1)) {
 		pr_debug("skipping unaligned io");
 		goto skip;
 	}
@@ -1101,8 +1104,9 @@ static void check_should_skip(struct cached_dev *dc, struct search *s)
 
 		spin_lock(&dc->io_lock);
 
-		hlist_for_each_entry(i, iohash(dc, bio->bi_sector), hash)
-			if (i->last == bio->bi_sector &&
+		hlist_for_each_entry(i, iohash(dc, bio->bi_iter.bi_sector),
+				     hash)
+			if (i->last == bio->bi_iter.bi_sector &&
 			    time_before(jiffies, i->jiffies))
 				goto found;
 
@@ -1111,8 +1115,8 @@ static void check_should_skip(struct cached_dev *dc, struct search *s)
 		add_sequential(s->task);
 		i->sequential = 0;
 found:
-		if (i->sequential + bio->bi_size > i->sequential)
-			i->sequential	+= bio->bi_size;
+		if (i->sequential + bio->bi_iter.bi_size > i->sequential)
+			i->sequential	+= bio->bi_iter.bi_size;
 
 		i->last			 = bio_end_sector(bio);
 		i->jiffies		 = jiffies + msecs_to_jiffies(5000);
@@ -1124,7 +1128,7 @@ found:
 
 		spin_unlock(&dc->io_lock);
 	} else {
-		s->task->sequential_io = bio->bi_size;
+		s->task->sequential_io = bio->bi_iter.bi_size;
 
 		add_sequential(s->task);
 	}
@@ -1164,7 +1168,7 @@ static void cached_dev_make_request(struct request_queue *q, struct bio *bio)
 	part_stat_unlock();
 
 	bio->bi_bdev = dc->bdev;
-	bio->bi_sector += dc->sb.data_offset;
+	bio->bi_iter.bi_sector += dc->sb.data_offset;
 
 	if (cached_dev_get(dc)) {
 		s = search_alloc(bio, d);
@@ -1247,9 +1251,9 @@ static int flash_dev_cache_miss(struct btree *b, struct search *s,
 		sectors	-= j;
 	}
 
-	bio_advance(bio, min(sectors << 9, bio->bi_size));
+	bio_advance(bio, min(sectors << 9, bio->bi_iter.bi_size));
 
-	if (!bio->bi_size)
+	if (!bio->bi_iter.bi_size)
 		s->op.lookup_done = true;
 
 	return 0;
@@ -1277,7 +1281,7 @@ static void flash_dev_make_request(struct request_queue *q, struct bio *bio)
 		closure_call(&s->op.cl, btree_read_async, NULL, cl);
 	} else if (bio_has_data(bio) || s->op.skip) {
 		bch_keybuf_check_overlapping(&s->op.c->moving_gc_keys,
-					&KEY(d->id, bio->bi_sector, 0),
+					&KEY(d->id, bio->bi_iter.bi_sector, 0),
 					&KEY(d->id, bio_end_sector(bio), 0));
 
 		s->writeback	= true;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index dc073eb..fff4894 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -240,9 +240,9 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
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
@@ -354,7 +354,7 @@ static void uuid_io(struct cache_set *c, unsigned long rw,
 		struct bio *bio = bch_bbio_alloc(c);
 
 		bio->bi_rw	= REQ_SYNC|REQ_META|rw;
-		bio->bi_size	= KEY_SIZE(k) << 9;
+		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
 
 		bio->bi_end_io	= uuid_endio;
 		bio->bi_private = cl;
@@ -510,10 +510,10 @@ static void prio_io(struct cache *ca, uint64_t bucket, unsigned long rw)
 
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
index 98eb811..b995d5a 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -203,10 +203,10 @@ unsigned bch_next_delay(struct ratelimit *d, uint64_t done)
 
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
index 22cbff5..029ac2f 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -142,7 +142,7 @@ static void dirty_init(struct keybuf_key *w)
 	if (!io->dc->writeback_percent)
 		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 
-	bio->bi_size		= KEY_SIZE(&w->key) << 9;
+	bio->bi_iter.bi_size	= KEY_SIZE(&w->key) << 9;
 	bio->bi_max_vecs	= DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS);
 	bio->bi_private		= w;
 	bio->bi_io_vec		= bio->bi_inline_vecs;
@@ -343,7 +343,7 @@ static void write_dirty(struct closure *cl)
 
 	dirty_init(w);
 	io->bio.bi_rw		= WRITE;
-	io->bio.bi_sector	= KEY_START(&w->key);
+	io->bio.bi_iter.bi_sector = KEY_START(&w->key);
 	io->bio.bi_bdev		= io->dc->bdev;
 	io->bio.bi_end_io	= dirty_endio;
 
@@ -413,7 +413,7 @@ static void read_dirty(struct closure *cl)
 		io->dc		= dc;
 
 		dirty_init(w);
-		io->bio.bi_sector	= PTR_OFFSET(&w->key, 0);
+		io->bio.bi_iter.bi_sector = PTR_OFFSET(&w->key, 0);
 		io->bio.bi_bdev		= PTR_CACHE(dc->disk.c,
 						    &w->key, 0)->bdev;
 		io->bio.bi_rw		= READ;
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index c91f61b..681efd3 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -43,7 +43,7 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 		return false;
 
 	if (dc->partial_stripes_expensive &&
-	    bcache_dev_stripe_dirty(&dc->disk, bio->bi_sector,
+	    bcache_dev_stripe_dirty(&dc->disk, bio->bi_iter.bi_sector,
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
index 5227e07..41eed4c 100644
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
index dc112a7..6e8aedb 100644
--- a/drivers/md/dm-cache-policy-mq.c
+++ b/drivers/md/dm-cache-policy-mq.c
@@ -85,7 +85,7 @@ static enum io_pattern iot_pattern(struct io_tracker *t)
 
 static void iot_update_stats(struct io_tracker *t, struct bio *bio)
 {
-	if (bio->bi_sector == from_oblock(t->last_end_oblock) + 1)
+	if (bio->bi_iter.bi_sector == from_oblock(t->last_end_oblock) + 1)
 		t->nr_seq_samples++;
 	else {
 		/*
@@ -100,7 +100,7 @@ static void iot_update_stats(struct io_tracker *t, struct bio *bio)
 		t->nr_rand_samples++;
 	}
 
-	t->last_end_oblock = to_oblock(bio->bi_sector + bio_sectors(bio) - 1);
+	t->last_end_oblock = to_oblock(bio_end_sector(bio) - 1);
 }
 
 static void iot_check_for_pattern_switch(struct io_tracker *t)
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 0df3ec0..c9f0f82 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -565,14 +565,16 @@ static void remap_to_origin(struct cache *cache, struct bio *bio)
 static void remap_to_cache(struct cache *cache, struct bio *bio,
 			   dm_cblock_t cblock)
 {
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	bio->bi_bdev = cache->cache_dev->bdev;
 	if (!block_size_is_power_of_two(cache))
-		bio->bi_sector = (from_cblock(cblock) * cache->sectors_per_block) +
+		bio->bi_iter.bi_sector = (from_cblock(cblock) *
+					  cache->sectors_per_block) +
 				sector_div(bi_sector, cache->sectors_per_block);
 	else
-		bio->bi_sector = (from_cblock(cblock) << cache->sectors_per_block_shift) |
+		bio->bi_iter.bi_sector = (from_cblock(cblock) <<
+					  cache->sectors_per_block_shift) |
 				(bi_sector & (cache->sectors_per_block - 1));
 }
 
@@ -612,7 +614,7 @@ static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
 
 static dm_oblock_t get_bio_block(struct cache *cache, struct bio *bio)
 {
-	sector_t block_nr = bio->bi_sector;
+	sector_t block_nr = bio->bi_iter.bi_sector;
 
 	if (!block_size_is_power_of_two(cache))
 		(void) sector_div(block_nr, cache->sectors_per_block);
@@ -1064,7 +1066,7 @@ static void process_flush_bio(struct cache *cache, struct bio *bio)
 	size_t pb_data_size = get_per_bio_data_size(cache);
 	struct per_bio_data *pb = get_per_bio_data(bio, pb_data_size);
 
-	BUG_ON(bio->bi_size);
+	BUG_ON(bio->bi_iter.bi_size);
 	if (!pb->req_nr)
 		remap_to_origin(cache, bio);
 	else
@@ -1087,9 +1089,9 @@ static void process_flush_bio(struct cache *cache, struct bio *bio)
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
index 6d2d41a..fca3bba 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -652,8 +652,8 @@ static void crypt_convert_init(struct crypt_config *cc,
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
@@ -845,7 +845,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size,
 		size -= len;
 	}
 
-	if (!clone->bi_size) {
+	if (!clone->bi_iter.bi_size) {
 		bio_put(clone);
 		return NULL;
 	}
@@ -985,7 +985,7 @@ static int kcryptd_io_read(struct dm_crypt_io *io, gfp_t gfp)
 	crypt_inc_pending(io);
 
 	clone_init(io, clone);
-	clone->bi_sector = cc->start + io->sector;
+	clone->bi_iter.bi_sector = cc->start + io->sector;
 
 	generic_make_request(clone);
 	return 0;
@@ -1033,7 +1033,7 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 	/* crypt_convert should have filled the clone bio */
 	BUG_ON(io->ctx.idx_out < clone->bi_vcnt);
 
-	clone->bi_sector = cc->start + io->sector;
+	clone->bi_iter.bi_sector = cc->start + io->sector;
 
 	if (async)
 		kcryptd_queue_io(io);
@@ -1048,7 +1048,7 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	struct dm_crypt_io *new_io;
 	int crypt_finished;
 	unsigned out_of_pages = 0;
-	unsigned remaining = io->base_bio->bi_size;
+	unsigned remaining = io->base_bio->bi_iter.bi_size;
 	sector_t sector = io->sector;
 	int r;
 
@@ -1072,7 +1072,7 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 		io->ctx.bio_out = clone;
 		io->ctx.idx_out = 0;
 
-		remaining -= clone->bi_size;
+		remaining -= clone->bi_iter.bi_size;
 		sector += bio_sectors(clone);
 
 		crypt_inc_pending(io);
@@ -1687,11 +1687,13 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	if (unlikely(bio->bi_rw & (REQ_FLUSH | REQ_DISCARD))) {
 		bio->bi_bdev = cc->dev->bdev;
 		if (bio_sectors(bio))
-			bio->bi_sector = cc->start + dm_target_offset(ti, bio->bi_sector);
+			bio->bi_iter.bi_sector = cc->start +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
 		return DM_MAPIO_REMAPPED;
 	}
 
-	io = crypt_io_alloc(cc, bio, dm_target_offset(ti, bio->bi_sector));
+	io = crypt_io_alloc(cc, bio,
+			    dm_target_offset(ti, bio->bi_iter.bi_sector));
 
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
index ea49834..a6de5c9 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -305,14 +305,15 @@ static void do_region(int rw, unsigned region, struct dm_io_region *where,
 					  dm_sector_div_up(remaining, (PAGE_SIZE >> SECTOR_SHIFT)));
 
 		bio = bio_alloc_bioset(GFP_NOIO, num_bvecs, io->client->bios);
-		bio->bi_sector = where->sector + (where->count - remaining);
+		bio->bi_iter.bi_sector = where->sector +
+			(where->count - remaining);
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
@@ -321,7 +322,7 @@ static void do_region(int rw, unsigned region, struct dm_io_region *where,
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
index 699b5be..e3efb91 100644
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
@@ -1182,7 +1182,7 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
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
index c434e5a..a1df777 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1563,10 +1563,10 @@ static void remap_exception(struct dm_snapshot *s, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
 	bio->bi_bdev = s->cow->bdev;
-	bio->bi_sector = chunk_to_sector(s->store,
+	bio->bi_iter.bi_sector = chunk_to_sector(s->store,
 					 dm_chunk_number(e->new_chunk) +
 					 (chunk - e->old_chunk)) +
-					 (bio->bi_sector &
+					 (bio->bi_iter.bi_sector &
 					  s->store->chunk_mask);
 }
 
@@ -1585,7 +1585,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
 
-	chunk = sector_to_chunk(s->store, bio->bi_sector);
+	chunk = sector_to_chunk(s->store, bio->bi_iter.bi_sector);
 
 	/* Full snapshots are not usable */
 	/* To get here the table must be live so s->active is always set. */
@@ -1646,7 +1646,8 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 		r = DM_MAPIO_SUBMITTED;
 
 		if (!pe->started &&
-		    bio->bi_size == (s->store->chunk_size << SECTOR_SHIFT)) {
+		    bio->bi_iter.bi_size ==
+		    (s->store->chunk_size << SECTOR_SHIFT)) {
 			pe->started = 1;
 			up_write(&s->lock);
 			start_full_bio(pe, bio);
@@ -1702,7 +1703,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
 
-	chunk = sector_to_chunk(s->store, bio->bi_sector);
+	chunk = sector_to_chunk(s->store, bio->bi_iter.bi_sector);
 
 	down_write(&s->lock);
 
@@ -2039,7 +2040,7 @@ static int do_origin(struct dm_dev *origin, struct bio *bio)
 	down_read(&_origins_lock);
 	o = __lookup_origin(origin->bdev);
 	if (o)
-		r = __origin_write(&o->snapshots, bio->bi_sector, bio);
+		r = __origin_write(&o->snapshots, bio->bi_iter.bi_sector, bio);
 	up_read(&_origins_lock);
 
 	return r;
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index d907ca6..8045b09 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -258,13 +258,15 @@ static int stripe_map_range(struct stripe_c *sc, struct bio *bio,
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
@@ -292,9 +294,10 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
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
index 88f2f80..2e2212c 100644
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
@@ -1121,7 +1123,7 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
 	if (bio_detain(pool, &key, bio, &cell))
 		return;
 
-	if (bio_data_dir(bio) == WRITE && bio->bi_size)
+	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size)
 		break_sharing(tc, bio, block, &key, lookup_result, cell);
 	else {
 		struct dm_thin_endio_hook *h = dm_per_bio_data(bio, sizeof(struct dm_thin_endio_hook));
@@ -1144,7 +1146,7 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
 	/*
 	 * Remap empty bios (flushes) immediately, without provisioning.
 	 */
-	if (!bio->bi_size) {
+	if (!bio->bi_iter.bi_size) {
 		inc_all_io_entry(pool, bio);
 		cell_defer_no_holder(tc, cell);
 
@@ -1244,7 +1246,8 @@ static void process_bio_read_only(struct thin_c *tc, struct bio *bio)
 	r = dm_thin_find_block(tc->td, block, 1, &lookup_result);
 	switch (r) {
 	case 0:
-		if (lookup_result.shared && (rw == WRITE) && bio->bi_size)
+		if (lookup_result.shared &&
+		    (rw == WRITE) && bio->bi_iter.bi_size)
 			bio_io_error(bio);
 		else {
 			inc_all_io_entry(tc->pool, bio);
@@ -2827,7 +2830,7 @@ out_unlock:
 
 static int thin_map(struct dm_target *ti, struct bio *bio)
 {
-	bio->bi_sector = dm_target_offset(ti, bio->bi_sector);
+	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
 
 	return thin_bio_map(ti, bio);
 }
diff --git a/drivers/md/dm-verity.c b/drivers/md/dm-verity.c
index 4b7941d..bf84bb3 100644
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
@@ -514,8 +514,9 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	io->v = v;
 	io->orig_bi_end_io = bio->bi_end_io;
 	io->orig_bi_private = bio->bi_private;
-	io->block = bio->bi_sector >> (v->data_dev_block_bits - SECTOR_SHIFT);
-	io->n_blocks = bio->bi_size >> v->data_dev_block_bits;
+	io->block = bio->bi_iter.bi_sector >>
+		(v->data_dev_block_bits - SECTOR_SHIFT);
+	io->n_blocks = bio->bi_iter.bi_size >> v->data_dev_block_bits;
 
 	bio->bi_end_io = verity_end_io;
 	bio->bi_private = io;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 9e39d2b..5544af7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -637,7 +637,7 @@ static void dec_pending(struct dm_io *io, int error)
 		if (io_error == DM_ENDIO_REQUEUE)
 			return;
 
-		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_size) {
+		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_iter.bi_size) {
 			/*
 			 * Preflush done for flush with data, reissue
 			 * without REQ_FLUSH.
@@ -692,7 +692,7 @@ static void end_clone_bio(struct bio *clone, int error)
 	struct dm_rq_clone_bio_info *info = clone->bi_private;
 	struct dm_rq_target_io *tio = info->tio;
 	struct bio *bio = info->orig;
-	unsigned int nr_bytes = info->orig->bi_size;
+	unsigned int nr_bytes = info->orig->bi_iter.bi_size;
 
 	bio_put(clone);
 
@@ -1023,7 +1023,7 @@ static void __map_bio(struct dm_target_io *tio)
 	 * this io.
 	 */
 	atomic_inc(&tio->io->io_count);
-	sector = clone->bi_sector;
+	sector = clone->bi_iter.bi_sector;
 	r = ti->type->map(ti, clone);
 	if (r == DM_MAPIO_REMAPPED) {
 		/* the bio has been remapped so dispatch it */
@@ -1055,13 +1055,13 @@ struct clone_info {
 
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
@@ -1097,7 +1097,7 @@ static void clone_split_bio(struct dm_target_io *tio, struct bio *bio,
 	clone->bi_rw = bio->bi_rw;
 	clone->bi_vcnt = 1;
 	clone->bi_io_vec->bv_offset = offset;
-	clone->bi_io_vec->bv_len = clone->bi_size;
+	clone->bi_io_vec->bv_len = clone->bi_iter.bi_size;
 	clone->bi_flags |= 1 << BIO_CLONED;
 
 	clone_bio_integrity(bio, clone, idx, len, offset, 1);
@@ -1117,7 +1117,8 @@ static void clone_bio(struct dm_target_io *tio, struct bio *bio,
 	bio_setup_sector(clone, sector, len);
 	bio_setup_bv(clone, idx, bv_count);
 
-	if (idx != bio->bi_idx || clone->bi_size < bio->bi_size)
+	if (idx != bio->bi_iter.bi_idx ||
+	    clone->bi_iter.bi_size < bio->bi_iter.bi_size)
 		trim = 1;
 	clone_bio_integrity(bio, clone, idx, len, 0, trim);
 }
@@ -1405,8 +1406,8 @@ static void __split_and_process_bio(struct mapped_device *md,
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
index 60e10f1..ecc7381 100644
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
@@ -746,7 +746,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
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
 	init_completion(&event);
 	bio->bi_private = &event;
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
index fc817ff..c40846e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -255,9 +255,8 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
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
@@ -456,9 +455,8 @@ static void raid1_end_write_request(struct bio *bio, int error)
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
@@ -945,7 +943,8 @@ do_sync_io:
 		if (bvecs[i].bv_page)
 			put_page(bvecs[i].bv_page);
 	kfree(bvecs);
-	pr_debug("%dB behind alloc failed, doing sync I/O\n", bio->bi_size);
+	pr_debug("%dB behind alloc failed, doing sync I/O\n",
+		 bio->bi_iter.bi_size);
 }
 
 struct raid1_plug_cb {
@@ -1024,7 +1023,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 
 	if (bio_data_dir(bio) == WRITE &&
 	    bio_end_sector(bio) > mddev->suspend_lo &&
-	    bio->bi_sector < mddev->suspend_hi) {
+	    bio->bi_iter.bi_sector < mddev->suspend_hi) {
 		/* As the suspend_* range is controlled by
 		 * userspace, we want an interruptible
 		 * wait.
@@ -1035,7 +1034,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_INTERRUPTIBLE);
 			if (bio_end_sector(bio) <= mddev->suspend_lo ||
-			    bio->bi_sector >= mddev->suspend_hi)
+			    bio->bi_iter.bi_sector >= mddev->suspend_hi)
 				break;
 			schedule();
 		}
@@ -1057,7 +1056,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 	r1_bio->sectors = bio_sectors(bio);
 	r1_bio->state = 0;
 	r1_bio->mddev = mddev;
-	r1_bio->sector = bio->bi_sector;
+	r1_bio->sector = bio->bi_iter.bi_sector;
 
 	/* We might need to issue multiple reads to different
 	 * devices if there are bad blocks around, so we keep
@@ -1097,12 +1096,13 @@ read_again:
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
@@ -1114,7 +1114,7 @@ read_again:
 			 */
 
 			sectors_handled = (r1_bio->sector + max_sectors
-					   - bio->bi_sector);
+					   - bio->bi_iter.bi_sector);
 			r1_bio->sectors = max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (bio->bi_phys_segments == 0)
@@ -1135,7 +1135,8 @@ read_again:
 			r1_bio->sectors = bio_sectors(bio) - sectors_handled;
 			r1_bio->state = 0;
 			r1_bio->mddev = mddev;
-			r1_bio->sector = bio->bi_sector + sectors_handled;
+			r1_bio->sector = bio->bi_iter.bi_sector +
+				sectors_handled;
 			goto read_again;
 		} else
 			generic_make_request(read_bio);
@@ -1254,7 +1255,7 @@ read_again:
 			bio->bi_phys_segments++;
 		spin_unlock_irq(&conf->device_lock);
 	}
-	sectors_handled = r1_bio->sector + max_sectors - bio->bi_sector;
+	sectors_handled = r1_bio->sector + max_sectors - bio->bi_iter.bi_sector;
 
 	atomic_set(&r1_bio->remaining, 1);
 	atomic_set(&r1_bio->behind_remaining, 0);
@@ -1266,7 +1267,7 @@ read_again:
 			continue;
 
 		mbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(mbio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(mbio, r1_bio->sector - bio->bi_iter.bi_sector, max_sectors);
 
 		if (first_clone) {
 			/* do behind I/O ?
@@ -1300,7 +1301,7 @@ read_again:
 
 		r1_bio->bios[i] = mbio;
 
-		mbio->bi_sector	= (r1_bio->sector +
+		mbio->bi_iter.bi_sector	= (r1_bio->sector +
 				   conf->mirrors[i].rdev->data_offset);
 		mbio->bi_bdev = conf->mirrors[i].rdev->bdev;
 		mbio->bi_end_io	= raid1_end_write_request;
@@ -1340,7 +1341,7 @@ read_again:
 		r1_bio->sectors = bio_sectors(bio) - sectors_handled;
 		r1_bio->state = 0;
 		r1_bio->mddev = mddev;
-		r1_bio->sector = bio->bi_sector + sectors_handled;
+		r1_bio->sector = bio->bi_iter.bi_sector + sectors_handled;
 		goto retry_write;
 	}
 
@@ -1860,14 +1861,14 @@ static int process_checks(struct r1bio *r1_bio)
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
@@ -2122,11 +2123,11 @@ static int narrow_write_error(struct r1bio *r1_bio, int i)
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
@@ -2240,7 +2241,8 @@ read_more:
 		}
 		r1_bio->read_disk = disk;
 		bio = bio_clone_mddev(r1_bio->master_bio, GFP_NOIO, mddev);
-		bio_trim(bio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(bio, r1_bio->sector - bio->bi_iter.bi_sector,
+			 max_sectors);
 		r1_bio->bios[r1_bio->read_disk] = bio;
 		rdev = conf->mirrors[disk].rdev;
 		printk_ratelimited(KERN_ERR
@@ -2249,7 +2251,7 @@ read_more:
 				   mdname(mddev),
 				   (unsigned long long)r1_bio->sector,
 				   bdevname(rdev->bdev, b));
-		bio->bi_sector = r1_bio->sector + rdev->data_offset;
+		bio->bi_iter.bi_sector = r1_bio->sector + rdev->data_offset;
 		bio->bi_bdev = rdev->bdev;
 		bio->bi_end_io = raid1_end_read_request;
 		bio->bi_rw = READ | do_sync;
@@ -2258,7 +2260,7 @@ read_more:
 			/* Drat - have to split this up more */
 			struct bio *mbio = r1_bio->master_bio;
 			int sectors_handled = (r1_bio->sector + max_sectors
-					       - mbio->bi_sector);
+					       - mbio->bi_iter.bi_sector);
 			r1_bio->sectors = max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (mbio->bi_phys_segments == 0)
@@ -2276,7 +2278,8 @@ read_more:
 			r1_bio->state = 0;
 			set_bit(R1BIO_ReadError, &r1_bio->state);
 			r1_bio->mddev = mddev;
-			r1_bio->sector = mbio->bi_sector + sectors_handled;
+			r1_bio->sector = mbio->bi_iter.bi_sector +
+				sectors_handled;
 
 			goto read_more;
 		} else
@@ -2500,7 +2503,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr, int *skipp
 		}
 		if (bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
-			bio->bi_sector = sector_nr + rdev->data_offset;
+			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
 			bio->bi_bdev = rdev->bdev;
 			bio->bi_private = r1_bio;
 		}
@@ -2600,7 +2603,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr, int *skipp
 							continue;
 						/* remove last page from this bio */
 						bio->bi_vcnt--;
-						bio->bi_size -= len;
+						bio->bi_iter.bi_size -= len;
 						bio->bi_flags &= ~(1<< BIO_SEG_VALID);
 					}
 					goto bio_full;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a582235..fca8887 100644
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
@@ -2123,10 +2127,10 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
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
@@ -2143,7 +2147,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		atomic_inc(&r10_bio->remaining);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
 
-		tbio->bi_sector += conf->mirrors[d].rdev->data_offset;
+		tbio->bi_iter.bi_sector += conf->mirrors[d].rdev->data_offset;
 		tbio->bi_bdev = conf->mirrors[d].rdev->bdev;
 		generic_make_request(tbio);
 	}
@@ -2613,8 +2617,8 @@ static int narrow_write_error(struct r10bio *r10_bio, int i)
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
@@ -2686,10 +2690,10 @@ read_more:
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
@@ -2700,7 +2704,7 @@ read_more:
 		struct bio *mbio = r10_bio->master_bio;
 		int sectors_handled =
 			r10_bio->sector + max_sectors
-			- mbio->bi_sector;
+			- mbio->bi_iter.bi_sector;
 		r10_bio->sectors = max_sectors;
 		spin_lock_irq(&conf->device_lock);
 		if (mbio->bi_phys_segments == 0)
@@ -2718,7 +2722,7 @@ read_more:
 		set_bit(R10BIO_ReadError,
 			&r10_bio->state);
 		r10_bio->mddev = mddev;
-		r10_bio->sector = mbio->bi_sector
+		r10_bio->sector = mbio->bi_iter.bi_sector
 			+ sectors_handled;
 
 		goto read_more;
@@ -3156,7 +3160,8 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_end_io = end_sync_read;
 				bio->bi_rw = READ;
 				from_addr = r10_bio->devs[j].addr;
-				bio->bi_sector = from_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector = from_addr +
+					rdev->data_offset;
 				bio->bi_bdev = rdev->bdev;
 				atomic_inc(&rdev->nr_pending);
 				/* and we write to 'i' (if not in_sync) */
@@ -3180,7 +3185,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 					bio->bi_private = r10_bio;
 					bio->bi_end_io = end_sync_write;
 					bio->bi_rw = WRITE;
-					bio->bi_sector = to_addr
+					bio->bi_iter.bi_sector = to_addr
 						+ rdev->data_offset;
 					bio->bi_bdev = rdev->bdev;
 					atomic_inc(&r10_bio->remaining);
@@ -3209,7 +3214,8 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_private = r10_bio;
 				bio->bi_end_io = end_sync_write;
 				bio->bi_rw = WRITE;
-				bio->bi_sector = to_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector = to_addr +
+					rdev->data_offset;
 				bio->bi_bdev = rdev->bdev;
 				atomic_inc(&r10_bio->remaining);
 				break;
@@ -3327,7 +3333,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio->bi_private = r10_bio;
 			bio->bi_end_io = end_sync_read;
 			bio->bi_rw = READ;
-			bio->bi_sector = sector +
+			bio->bi_iter.bi_sector = sector +
 				conf->mirrors[d].rdev->data_offset;
 			bio->bi_bdev = conf->mirrors[d].rdev->bdev;
 			count++;
@@ -3349,7 +3355,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio->bi_private = r10_bio;
 			bio->bi_end_io = end_sync_write;
 			bio->bi_rw = WRITE;
-			bio->bi_sector = sector +
+			bio->bi_iter.bi_sector = sector +
 				conf->mirrors[d].replacement->data_offset;
 			bio->bi_bdev = conf->mirrors[d].replacement->bdev;
 			count++;
@@ -3396,7 +3402,7 @@ static sector_t sync_request(struct mddev *mddev, sector_t sector_nr,
 			     bio2 = bio2->bi_next) {
 				/* remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -= len;
+				bio2->bi_iter.bi_size -= len;
 				bio2->bi_flags &= ~(1<< BIO_SEG_VALID);
 			}
 			goto bio_full;
@@ -4412,7 +4418,7 @@ read_more:
 	read_bio = bio_alloc_mddev(GFP_KERNEL, RESYNC_PAGES, mddev);
 
 	read_bio->bi_bdev = rdev->bdev;
-	read_bio->bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
+	read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
 			       + rdev->data_offset);
 	read_bio->bi_private = r10_bio;
 	read_bio->bi_end_io = end_sync_read;
@@ -4420,7 +4426,7 @@ read_more:
 	read_bio->bi_flags &= ~(BIO_POOL_MASK - 1);
 	read_bio->bi_flags |= 1 << BIO_UPTODATE;
 	read_bio->bi_vcnt = 0;
-	read_bio->bi_size = 0;
+	read_bio->bi_iter.bi_size = 0;
 	r10_bio->master_bio = read_bio;
 	r10_bio->read_slot = r10_bio->devs[r10_bio->read_slot].devnum;
 
@@ -4446,7 +4452,8 @@ read_more:
 
 		bio_reset(b);
 		b->bi_bdev = rdev2->bdev;
-		b->bi_sector = r10_bio->devs[s/2].addr + rdev2->new_data_offset;
+		b->bi_iter.bi_sector = r10_bio->devs[s/2].addr +
+			rdev2->new_data_offset;
 		b->bi_private = r10_bio;
 		b->bi_end_io = end_reshape_write;
 		b->bi_rw = WRITE;
@@ -4473,7 +4480,7 @@ read_more:
 			     bio2 = bio2->bi_next) {
 				/* Remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -= len;
+				bio2->bi_iter.bi_size -= len;
 				bio2->bi_flags &= ~(1<<BIO_SEG_VALID);
 			}
 			goto bio_full;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 78ea443..3b10a02 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -91,7 +91,7 @@ static inline struct hlist_head *stripe_hash(struct r5conf *conf, sector_t sect)
 static inline struct bio *r5_next_bio(struct bio *bio, sector_t sector)
 {
 	int sectors = bio_sectors(bio);
-	if (bio->bi_sector + sectors < sector + STRIPE_SECTORS)
+	if (bio->bi_iter.bi_sector + sectors < sector + STRIPE_SECTORS)
 		return bio->bi_next;
 	else
 		return NULL;
@@ -183,7 +183,7 @@ static void return_io(struct bio *return_bi)
 
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
-		bi->bi_size = 0;
+		bi->bi_iter.bi_size = 0;
 		trace_block_bio_complete(bdev_get_queue(bi->bi_bdev),
 					 bi, 0);
 		bio_endio(bi, 0);
@@ -656,10 +656,10 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
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
 				bi->bi_rw |= REQ_FLUSH;
@@ -667,7 +667,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			bi->bi_vcnt = 1;
 			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
 			bi->bi_io_vec[0].bv_offset = 0;
-			bi->bi_size = STRIPE_SIZE;
+			bi->bi_iter.bi_size = STRIPE_SIZE;
 			if (rrdev)
 				set_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags);
 
@@ -697,15 +697,15 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
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
 			if (conf->mddev->gendisk)
 				trace_block_bio_remap(bdev_get_queue(rbi->bi_bdev),
 						      rbi, disk_devt(conf->mddev->gendisk),
@@ -734,10 +734,10 @@ async_copy_data(int frombio, struct bio *bio, struct page *page,
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
@@ -804,7 +804,7 @@ static void ops_complete_biofill(void *stripe_head_ref)
 			BUG_ON(!dev->read);
 			rbi = dev->read;
 			dev->read = NULL;
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				rbi2 = r5_next_bio(rbi, dev->sector);
 				if (!raid5_dec_bi_active_stripes(rbi)) {
@@ -840,7 +840,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 			dev->read = rbi = dev->toread;
 			dev->toread = NULL;
 			spin_unlock_irq(&sh->stripe_lock);
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				tx = async_copy_data(0, rbi, dev->page,
 					dev->sector, tx);
@@ -1182,7 +1182,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 			wbi = dev->written = chosen;
 			spin_unlock_irq(&sh->stripe_lock);
 
-			while (wbi && wbi->bi_sector <
+			while (wbi && wbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				if (wbi->bi_rw & REQ_FUA)
 					set_bit(R5_WantFUA, &dev->flags);
@@ -2384,7 +2384,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 	int firstwrite=0;
 
 	pr_debug("adding bi b#%llu to stripe s#%llu\n",
-		(unsigned long long)bi->bi_sector,
+		(unsigned long long)bi->bi_iter.bi_sector,
 		(unsigned long long)sh->sector);
 
 	/*
@@ -2402,12 +2402,12 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
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
@@ -2421,7 +2421,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 		sector_t sector = sh->dev[dd_idx].sector;
 		for (bi=sh->dev[dd_idx].towrite;
 		     sector < sh->dev[dd_idx].sector + STRIPE_SECTORS &&
-			     bi && bi->bi_sector <= sector;
+			     bi && bi->bi_iter.bi_sector <= sector;
 		     bi = r5_next_bio(bi, sh->dev[dd_idx].sector)) {
 			if (bio_end_sector(bi) >= sector)
 				sector = bio_end_sector(bi);
@@ -2431,7 +2431,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx, in
 	}
 
 	pr_debug("added bi b#%llu to stripe s#%llu, disk %d.\n",
-		(unsigned long long)(*bip)->bi_sector,
+		(unsigned long long)(*bip)->bi_iter.bi_sector,
 		(unsigned long long)sh->sector, dd_idx);
 	spin_unlock_irq(&sh->stripe_lock);
 
@@ -2506,7 +2506,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 			wake_up(&conf->wait_for_overlap);
 
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 			sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *nextbi = r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2525,7 +2525,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		bi = sh->dev[i].written;
 		sh->dev[i].written = NULL;
 		if (bi) bitmap_end = 1;
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 		       sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *bi2 = r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2549,7 +2549,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			spin_unlock_irq(&sh->stripe_lock);
 			if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 				wake_up(&conf->wait_for_overlap);
-			while (bi && bi->bi_sector <
+			while (bi && bi->bi_iter.bi_sector <
 			       sh->dev[i].sector + STRIPE_SECTORS) {
 				struct bio *nextbi =
 					r5_next_bio(bi, sh->dev[i].sector);
@@ -2773,7 +2773,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 					clear_bit(R5_UPTODATE, &dev->flags);
 				wbi = dev->written;
 				dev->written = NULL;
-				while (wbi && wbi->bi_sector <
+				while (wbi && wbi->bi_iter.bi_sector <
 					dev->sector + STRIPE_SECTORS) {
 					wbi2 = r5_next_bio(wbi, dev->sector);
 					if (!raid5_dec_bi_active_stripes(wbi)) {
@@ -3853,7 +3853,7 @@ static int raid5_mergeable_bvec(struct request_queue *q,
 
 static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
 {
-	sector_t sector = bio->bi_sector + get_start_sect(bio->bi_bdev);
+	sector_t sector = bio->bi_iter.bi_sector + get_start_sect(bio->bi_bdev);
 	unsigned int chunk_sectors = mddev->chunk_sectors;
 	unsigned int bio_sectors = bio_sectors(bio);
 
@@ -3990,9 +3990,9 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
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
@@ -4017,7 +4017,8 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		align_bi->bi_flags &= ~(1 << BIO_SEG_VALID);
 
 		if (!bio_fits_rdev(align_bi) ||
-		    is_badblock(rdev, align_bi->bi_sector, bio_sectors(align_bi),
+		    is_badblock(rdev, align_bi->bi_iter.bi_sector,
+				bio_sectors(align_bi),
 				&first_bad, &bad_sectors)) {
 			/* too big in some way, or has a known bad block */
 			bio_put(align_bi);
@@ -4026,7 +4027,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		}
 
 		/* No reshape active, so we can trust rdev->data_offset */
-		align_bi->bi_sector += rdev->data_offset;
+		align_bi->bi_iter.bi_sector += rdev->data_offset;
 
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,
@@ -4038,7 +4039,7 @@ static int chunk_aligned_read(struct mddev *mddev, struct bio * raid_bio)
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(align_bi->bi_bdev),
 					      align_bi, disk_devt(mddev->gendisk),
-					      raid_bio->bi_sector);
+					      raid_bio->bi_iter.bi_sector);
 		generic_make_request(align_bi);
 		return 1;
 	} else {
@@ -4173,8 +4174,8 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		/* Skip discard while reshape is happening */
 		return;
 
-	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
-	last_sector = bi->bi_sector + (bi->bi_size>>9);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	last_sector = bi->bi_iter.bi_sector + (bi->bi_iter.bi_size>>9);
 
 	bi->bi_next = NULL;
 	bi->bi_phys_segments = 1; /* over-loaded to count active stripes */
@@ -4278,7 +4279,7 @@ static void make_request(struct mddev *mddev, struct bio * bi)
 		return;
 	}
 
-	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 	bi->bi_phys_segments = 1;	/* over-loaded to count active stripes */
@@ -4742,7 +4743,8 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio)
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
 
diff --git a/drivers/staging/zram/zram_drv.c b/drivers/staging/zram/zram_drv.c
index e77fb6e..34ee87d 100644
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
@@ -654,8 +655,9 @@ static void __zram_make_request(struct zram *zram, struct bio *bio, int rw)
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
index aa1620a..4032d6b 100644
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
index 8fb4291..f824c30 100644
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
index 2b6a816..0a86e2c 100644
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
@@ -1475,7 +1476,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	if (IS_ERR(bio))
 		return bio;
 
-	if (bio->bi_size == len)
+	if (bio->bi_iter.bi_size == len)
 		return bio;
 
 	/*
@@ -1753,16 +1754,16 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
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
@@ -1811,21 +1812,22 @@ void bio_trim(struct bio *bio, int offset, int size)
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
@@ -1861,7 +1863,7 @@ sector_t bio_sector_offset(struct bio *bio, unsigned short index,
 	sector_sz = queue_logical_block_size(bio->bi_bdev->bd_disk->queue);
 	sectors = 0;
 
-	if (index >= bio->bi_idx)
+	if (index >= bio->bi_iter.bi_idx)
 		index = bio->bi_vcnt - 1;
 
 	bio_for_each_segment_all(bv, bio, i) {
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 1431a69..2ae350c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1708,7 +1708,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 			return -1;
 		}
 		bio->bi_bdev = block_ctx->dev->bdev;
-		bio->bi_sector = dev_bytenr >> 9;
+		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 		bio->bi_end_io = btrfsic_complete_bio_end_io;
 		bio->bi_private = &complete;
 
@@ -3112,16 +3112,16 @@ void btrfsic_submit_bio(int rw, struct bio *bio)
 		int bio_is_patched;
 		char **mapped_datav;
 
-		dev_bytenr = 512 * bio->bi_sector;
+		dev_bytenr = 512 * bio->bi_iter.bi_sector;
 		bio_is_patched = 0;
 		if (dev_state->state->print_mask &
 		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
 			printk(KERN_INFO
 			       "submit_bio(rw=0x%x, bi_vcnt=%u,"
 			       " bi_sector=%lu (bytenr %llu), bi_bdev=%p)\n",
-			       rw, bio->bi_vcnt, (unsigned long)bio->bi_sector,
-			       (unsigned long long)dev_bytenr,
-			       bio->bi_bdev);
+			       rw, bio->bi_vcnt,
+			       (unsigned long)bio->bi_iter.bi_sector,
+			       (unsigned long long)dev_bytenr, bio->bi_bdev);
 
 		mapped_datav = kmalloc(sizeof(*mapped_datav) * bio->bi_vcnt,
 				       GFP_NOFS);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b189bd1..2d7515b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -174,7 +174,8 @@ static void end_compressed_bio_read(struct bio *bio, int err)
 		goto out;
 
 	inode = cb->inode;
-	ret = check_compressed_csum(inode, cb, (u64)bio->bi_sector << 9);
+	ret = check_compressed_csum(inode, cb,
+				    (u64)bio->bi_iter.bi_sector << 9);
 	if (ret)
 		goto csum_failed;
 
@@ -374,7 +375,7 @@ int btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
 		page = compressed_pages[pg_index];
 		page->mapping = inode->i_mapping;
-		if (bio->bi_size)
+		if (bio->bi_iter.bi_size)
 			ret = io_tree->ops->merge_bio_hook(WRITE, page, 0,
 							   PAGE_CACHE_SIZE,
 							   bio, 0);
@@ -508,7 +509,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 		if (!em || last_offset < em->start ||
 		    (last_offset + PAGE_CACHE_SIZE > extent_map_end(em)) ||
-		    (em->block_start >> 9) != cb->orig_bio->bi_sector) {
+		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, last_offset, end);
 			unlock_page(page);
@@ -554,7 +555,7 @@ next:
  * in it.  We don't actually do IO on those pages but allocate new ones
  * to hold the compressed pages on disk.
  *
- * bio->bi_sector points to the compressed extent on disk
+ * bio->bi_iter.bi_sector points to the compressed extent on disk
  * bio->bi_io_vec points to all of the inode pages
  * bio->bi_vcnt is a count of pages
  *
@@ -575,7 +576,7 @@ int btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
index 583d98b..27aed9d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2072,7 +2072,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 start,
 		return -EIO;
 	bio->bi_private = &compl;
 	bio->bi_end_io = repair_io_failure_callback;
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
 	ret = btrfs_map_block(fs_info, WRITE, logical,
@@ -2083,7 +2083,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 start,
 	}
 	BUG_ON(mirror_num != bbio->mirror_num);
 	sector = bbio->stripes[mirror_num-1].physical >> 9;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	dev = bbio->stripes[mirror_num-1].dev;
 	kfree(bbio);
 	if (!dev || !dev->bdev || !dev->writeable) {
@@ -2364,9 +2364,9 @@ static int bio_readpage_error(struct bio *failed_bio, struct page *page,
 	}
 	bio->bi_private = state;
 	bio->bi_end_io = failed_bio->bi_end_io;
-	bio->bi_sector = failrec->logical >> 9;
+	bio->bi_iter.bi_sector = failrec->logical >> 9;
 	bio->bi_bdev = BTRFS_I(inode)->root->fs_info->fs_devices->latest_bdev;
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 
 	bio_add_page(bio, page, failrec->len, start - page_offset(page));
 
@@ -2483,7 +2483,7 @@ static void end_bio_extent_readpage(struct bio *bio, int err)
 		struct inode *inode = page->mapping->host;
 
 		pr_debug("end_bio_extent_readpage: bi_sector=%llu, err=%d, "
-			 "mirror=%lu\n", (u64)bio->bi_sector, err,
+			 "mirror=%lu\n", (u64)bio->bi_iter.bi_sector, err,
 			 io_bio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
 
@@ -2598,9 +2598,9 @@ btrfs_bio_alloc(struct block_device *bdev, u64 first_sector, int nr_vecs,
 	}
 
 	if (bio) {
-		bio->bi_size = 0;
+		bio->bi_iter.bi_size = 0;
 		bio->bi_bdev = bdev;
-		bio->bi_sector = first_sector;
+		bio->bi_iter.bi_sector = first_sector;
 	}
 	return bio;
 }
@@ -2680,7 +2680,7 @@ static int submit_extent_page(int rw, struct extent_io_tree *tree,
 	if (bio_ret && *bio_ret) {
 		bio = *bio_ret;
 		if (old_compressed)
-			contig = bio->bi_sector == sector;
+			contig = bio->bi_iter.bi_sector == sector;
 		else
 			contig = bio_end_sector(bio) == sector;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a7bfc95..890f977 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -174,7 +174,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root *root,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	if (bio->bi_size > PAGE_CACHE_SIZE * 8)
+	if (bio->bi_iter.bi_size > PAGE_CACHE_SIZE * 8)
 		path->reada = 2;
 
 	WARN_ON(bio->bi_vcnt <= 0);
@@ -190,7 +190,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root *root,
 		path->skip_locking = 1;
 	}
 
-	disk_bytenr = (u64)bio->bi_sector << 9;
+	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	if (dio)
 		offset = logical_offset;
 	while (bio_index < bio->bi_vcnt) {
@@ -419,11 +419,12 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
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
@@ -433,7 +434,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 
 	ordered = btrfs_lookup_ordered_extent(inode, offset);
 	BUG_ON(!ordered); /* Logic error */
-	sums->bytenr = (u64)bio->bi_sector << 9;
+	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	while (bio_index < bio->bi_vcnt) {
@@ -448,7 +449,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 			btrfs_add_ordered_sum(inode, ordered, sums);
 			btrfs_put_ordered_extent(ordered);
 
-			bytes_left = bio->bi_size - total_bytes;
+			bytes_left = bio->bi_iter.bi_size - total_bytes;
 
 			sums = kzalloc(btrfs_ordered_sum_size(root, bytes_left),
 				       GFP_NOFS);
@@ -456,7 +457,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struct inode *inode,
 			sums->len = bytes_left;
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
 			BUG_ON(!ordered); /* Logic error */
-			sums->bytenr = ((u64)bio->bi_sector << 9) +
+			sums->bytenr = ((u64)bio->bi_iter.bi_sector << 9) +
 				       total_bytes;
 			index = 0;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d1b93c..df6eb55 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1666,7 +1666,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page, unsigned long offset,
 			 unsigned long bio_flags)
 {
 	struct btrfs_root *root = BTRFS_I(page->mapping->host)->root;
-	u64 logical = (u64)bio->bi_sector << 9;
+	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	int ret;
@@ -1674,7 +1674,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page, unsigned long offset,
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
 		return 0;
 
-	length = bio->bi_size;
+	length = bio->bi_iter.bi_size;
 	map_length = length;
 	ret = btrfs_map_block(root->fs_info, rw, logical,
 			      &map_length, NULL, 0);
@@ -6935,7 +6935,8 @@ static void btrfs_end_dio_bio(struct bio *bio, int err)
 		printk(KERN_ERR "btrfs direct IO failed ino %llu rw %lu "
 		      "sector %#Lx len %u err no %d\n",
 		      (unsigned long long)btrfs_ino(dip->inode), bio->bi_rw,
-		      (unsigned long long)bio->bi_sector, bio->bi_size, err);
+		      (unsigned long long)bio->bi_iter.bi_sector,
+		      bio->bi_iter.bi_size, err);
 		dip->errors = 1;
 
 		/*
@@ -7024,7 +7025,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 	struct bio *bio;
 	struct bio *orig_bio = dip->orig_bio;
 	struct bio_vec *bvec = orig_bio->bi_io_vec;
-	u64 start_sector = orig_bio->bi_sector;
+	u64 start_sector = orig_bio->bi_iter.bi_sector;
 	u64 file_offset = dip->logical_offset;
 	u64 submit_len = 0;
 	u64 map_length;
@@ -7032,14 +7033,14 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 	int ret = 0;
 	int async_submit = 0;
 
-	map_length = orig_bio->bi_size;
+	map_length = orig_bio->bi_iter.bi_size;
 	ret = btrfs_map_block(root->fs_info, rw, start_sector << 9,
 			      &map_length, NULL, 0);
 	if (ret) {
 		bio_put(orig_bio);
 		return -EIO;
 	}
-	if (map_length >= orig_bio->bi_size) {
+	if (map_length >= orig_bio->bi_iter.bi_size) {
 		bio = orig_bio;
 		goto submit;
 	}
@@ -7091,7 +7092,7 @@ static int btrfs_submit_direct_hook(int rw, struct btrfs_dio_private *dip,
 			bio->bi_private = dip;
 			bio->bi_end_io = btrfs_end_dio_bio;
 
-			map_length = orig_bio->bi_size;
+			map_length = orig_bio->bi_iter.bi_size;
 			ret = btrfs_map_block(root->fs_info, rw,
 					      start_sector << 9,
 					      &map_length, NULL, 0);
@@ -7155,8 +7156,8 @@ static void btrfs_submit_direct(int rw, struct bio *dio_bio,
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
index 0525e13..fc89bee 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1033,8 +1033,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		last_end = (u64)last->bi_sector << 9;
-		last_end += last->bi_size;
+		last_end = (u64)last->bi_iter.bi_sector << 9;
+		last_end += last->bi_iter.bi_size;
 
 		/*
 		 * we can't merge these if they are from different
@@ -1054,9 +1054,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	if (!bio)
 		return -ENOMEM;
 
-	bio->bi_size = 0;
+	bio->bi_iter.bi_size = 0;
 	bio->bi_bdev = stripe->dev->bdev;
-	bio->bi_sector = disk_start >> 9;
+	bio->bi_iter.bi_sector = disk_start >> 9;
 	set_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
@@ -1112,7 +1112,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	spin_lock_irq(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list) {
-		start = (u64)bio->bi_sector << 9;
+		start = (u64)bio->bi_iter.bi_sector << 9;
 		stripe_offset = start - rbio->raid_map[0];
 		page_index = stripe_offset >> PAGE_CACHE_SHIFT;
 
@@ -1273,7 +1273,7 @@ cleanup:
 static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 			   struct bio *bio)
 {
-	u64 physical = bio->bi_sector;
+	u64 physical = bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
 	struct btrfs_bio_stripe *stripe;
@@ -1299,7 +1299,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 				   struct bio *bio)
 {
-	u64 logical = bio->bi_sector;
+	u64 logical = bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
 
@@ -1601,8 +1601,8 @@ static int plug_cmp(void *priv, struct list_head *a, struct list_head *b)
 						 plug_list);
 	struct btrfs_raid_bio *rb = container_of(b, struct btrfs_raid_bio,
 						 plug_list);
-	u64 a_sector = ra->bio_list.head->bi_sector;
-	u64 b_sector = rb->bio_list.head->bi_sector;
+	u64 a_sector = ra->bio_list.head->bi_iter.bi_sector;
+	u64 b_sector = rb->bio_list.head->bi_iter.bi_sector;
 
 	if (a_sector < b_sector)
 		return -1;
@@ -1693,7 +1693,7 @@ int raid56_parity_write(struct btrfs_root *root, struct bio *bio,
 		return PTR_ERR(rbio);
 	}
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes = bio->bi_size;
+	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	/*
 	 * don't plug on full rbios, just get them out the door
@@ -2047,7 +2047,7 @@ int raid56_parity_recover(struct btrfs_root *root, struct bio *bio,
 
 	rbio->read_rebuild = 1;
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes = bio->bi_size;
+	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 64a157b..5be7c61 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1303,7 +1303,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 		bio->bi_bdev = page->dev->bdev;
-		bio->bi_sector = page->physical >> 9;
+		bio->bi_iter.bi_sector = page->physical >> 9;
 		bio->bi_end_io = scrub_complete_bio_end_io;
 		bio->bi_private = &complete;
 
@@ -1435,7 +1435,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 		if (!bio)
 			return -EIO;
 		bio->bi_bdev = page_bad->dev->bdev;
-		bio->bi_sector = page_bad->physical >> 9;
+		bio->bi_iter.bi_sector = page_bad->physical >> 9;
 		bio->bi_end_io = scrub_complete_bio_end_io;
 		bio->bi_private = &complete;
 
@@ -1533,7 +1533,7 @@ again:
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_wr_bio_end_io;
 		bio->bi_bdev = sbio->dev->bdev;
-		bio->bi_sector = sbio->physical >> 9;
+		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->err = 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
 		   spage->physical_for_dev_replace ||
@@ -1939,7 +1939,7 @@ again:
 		bio->bi_private = sbio;
 		bio->bi_end_io = scrub_bio_end_io;
 		bio->bi_bdev = sbio->dev->bdev;
-		bio->bi_sector = sbio->physical >> 9;
+		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->err = 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=
 		   spage->physical ||
@@ -3330,8 +3330,8 @@ static int write_page_nocow(struct scrub_ctx *sctx,
 	}
 	bio->bi_private = &compl;
 	bio->bi_end_io = scrub_complete_bio_end_io;
-	bio->bi_size = 0;
-	bio->bi_sector = physical_for_dev_replace >> 9;
+	bio->bi_iter.bi_size = 0;
+	bio->bi_iter.bi_sector = physical_for_dev_replace >> 9;
 	bio->bi_bdev = dev->bdev;
 	ret = bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
 	if (ret != PAGE_CACHE_SIZE) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 78b8717..99ca1b6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5122,7 +5122,7 @@ static int bio_size_ok(struct block_device *bdev, struct bio *bio,
 	if (!q->merge_bvec_fn)
 		return 1;
 
-	bvm.bi_size = bio->bi_size - prev->bv_len;
+	bvm.bi_size = bio->bi_iter.bi_size - prev->bv_len;
 	if (q->merge_bvec_fn(q, &bvm, prev) < prev->bv_len)
 		return 0;
 	return 1;
@@ -5137,7 +5137,7 @@ static void submit_stripe_bio(struct btrfs_root *root, struct btrfs_bio *bbio,
 	bio->bi_private = bbio;
 	btrfs_io_bio(bio)->stripe_index = dev_nr;
 	bio->bi_end_io = btrfs_end_bio;
-	bio->bi_sector = physical >> 9;
+	bio->bi_iter.bi_sector = physical >> 9;
 #ifdef DEBUG
 	{
 		struct rcu_string *name;
@@ -5175,7 +5175,7 @@ again:
 	while (bvec <= (first_bio->bi_io_vec + first_bio->bi_vcnt - 1)) {
 		if (bio_add_page(bio, bvec->bv_page, bvec->bv_len,
 				 bvec->bv_offset) < bvec->bv_len) {
-			u64 len = bio->bi_size;
+			u64 len = bio->bi_iter.bi_size;
 
 			atomic_inc(&bbio->stripes_pending);
 			submit_stripe_bio(root, bbio, bio, physical, dev_nr,
@@ -5197,7 +5197,7 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 		bio->bi_private = bbio->private;
 		bio->bi_end_io = bbio->end_io;
 		btrfs_io_bio(bio)->mirror_num = bbio->mirror_num;
-		bio->bi_sector = logical >> 9;
+		bio->bi_iter.bi_sector = logical >> 9;
 		kfree(bbio);
 		bio_endio(bio, -EIO);
 	}
@@ -5208,7 +5208,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, struct bio *bio,
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
-	u64 logical = (u64)bio->bi_sector << 9;
+	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	u64 *raid_map = NULL;
@@ -5217,7 +5217,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, struct bio *bio,
 	int total_devs = 1;
 	struct btrfs_bio *bbio = NULL;
 
-	length = bio->bi_size;
+	length = bio->bi_iter.bi_size;
 	map_length = length;
 
 	ret = __btrfs_map_block(root->fs_info, rw, logical, &map_length, &bbio,
diff --git a/fs/buffer.c b/fs/buffer.c
index 4d74335..8f35e75 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2972,11 +2972,11 @@ static void guard_bh_eod(int rw, struct bio *bio, struct buffer_head *bh)
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
 
@@ -2984,7 +2984,7 @@ static void guard_bh_eod(int rw, struct bio *bio, struct buffer_head *bh)
 	bytes = maxsector << 9;
 
 	/* Truncate the bio.. */
-	bio->bi_size = bytes;
+	bio->bi_iter.bi_size = bytes;
 	bio->bi_io_vec[0].bv_len = bytes;
 
 	/* ..and clear the end of the buffer for reads */
@@ -3019,14 +3019,14 @@ int _submit_bh(int rw, struct buffer_head *bh, unsigned long bio_flags)
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
index 7ab90f5..6a5de20 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -349,7 +349,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
 	bio->bi_bdev = bdev;
-	bio->bi_sector = first_sector;
+	bio->bi_iter.bi_sector = first_sector;
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
@@ -654,7 +654,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	if (sdio->bio) {
 		loff_t cur_offset = sdio->cur_page_fs_offset;
 		loff_t bio_next_offset = sdio->logical_offset_in_bio +
-			sdio->bio->bi_size;
+			sdio->bio->bi_iter.bi_size;
 
 		/*
 		 * See whether this new request is contiguous with the old.
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 6625d21..da4cbf0 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -313,7 +313,7 @@ ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
 static void ext4_end_bio(struct bio *bio, int error)
 {
 	ext4_io_end_t *io_end = bio->bi_private;
-	sector_t bi_sector = bio->bi_sector;
+	sector_t bi_sector = bio->bi_iter.bi_sector;
 
 	BUG_ON(!io_end);
 	bio->bi_end_io = NULL;
@@ -381,7 +381,7 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	bio = bio_alloc(GFP_NOIO, min(nvecs, BIO_MAX_PAGES));
 	if (!bio)
 		return -ENOMEM;
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 035f9a3..12a2ad5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,7 +387,7 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 	bio = f2fs_bio_alloc(bdev, 1);
 
 	/* Initialize the bio */
-	bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 	bio->bi_end_io = read_end_io;
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a86d125..ecfe65c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -682,7 +682,8 @@ static void submit_write_page(struct f2fs_sb_info *sbi, struct page *page,
 alloc_new:
 	if (sbi->bio[type] == NULL) {
 		sbi->bio[type] = f2fs_bio_alloc(bdev, max_hw_blocks(sbi));
-		sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+		sbi->bio[type]->bi_iter.bi_sector =
+			SECTOR_FROM_BLOCK(sbi, blk_addr);
 		/*
 		 * The end_io will be assigned at the sumbission phase.
 		 * Until then, let bio_add_page() merge consecutive IOs as much
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 17c5b5d..81ea4de 100644
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
index 0262c19..ea63e03 100644
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
index b51a607..5585a32 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -71,7 +71,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
 
 	bio = bio_alloc(GFP_NOIO, 1);
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = sb->s_bdev;
 	bio->bi_end_io = hfsplus_end_io_sync;
 	bio->bi_private = &wait;
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
index 550475c..a1b161f 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -32,9 +32,9 @@ static int sync_request(struct page *page, struct block_device *bdev, int rw)
 	bio_vec.bv_len = PAGE_SIZE;
 	bio_vec.bv_offset = 0;
 	bio.bi_vcnt = 1;
-	bio.bi_size = PAGE_SIZE;
+	bio.bi_iter.bi_size = PAGE_SIZE;
 	bio.bi_bdev = bdev;
-	bio.bi_sector = page->index * (PAGE_SIZE >> 9);
+	bio.bi_iter.bi_sector = page->index * (PAGE_SIZE >> 9);
 	init_completion(&complete);
 	bio.bi_private = &complete;
 	bio.bi_end_io = request_complete;
@@ -107,9 +107,9 @@ static int __bdev_writeseg(struct super_block *sb, u64 ofs, pgoff_t index,
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
@@ -134,9 +134,9 @@ static int __bdev_writeseg(struct super_block *sb, u64 ofs, pgoff_t index,
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
@@ -199,9 +199,9 @@ static int do_erase(struct super_block *sb, u64 ofs, pgoff_t index,
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
@@ -220,9 +220,9 @@ static int do_erase(struct super_block *sb, u64 ofs, pgoff_t index,
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
index 0face1c..92b125f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -94,7 +94,7 @@ mpage_alloc(struct block_device *bdev,
 
 	if (bio) {
 		bio->bi_bdev = bdev;
-		bio->bi_sector = first_sector;
+		bio->bi_iter.bi_sector = first_sector;
 	}
 	return bio;
 }
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index e242bbf..af73896 100644
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
@@ -519,7 +520,7 @@ bl_do_readpage_sync(struct page *page, struct pnfs_block_extent *be,
 	isect = (page->index << PAGE_CACHE_SECTOR_SHIFT) +
 		(offset / SECTOR_SIZE);
 
-	bio->bi_sector = isect - be->be_f_offset + be->be_v_offset;
+	bio->bi_iter.bi_sector = isect - be->be_f_offset + be->be_v_offset;
 	bio->bi_bdev = be->be_mdev;
 	bio->bi_end_io = bl_read_single_end_io;
 
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index dc9a913..85dabcd 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -417,7 +417,8 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
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
index 5c1c864..e1d1e82 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -421,7 +421,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_sector = (reg->hr_start_block + cs) << (bits - 9);
+	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
 	bio->bi_bdev = reg->hr_bdev;
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 596ec71..b4ad186 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -415,7 +415,7 @@ xfs_alloc_ioend_bio(
 	struct bio		*bio = bio_alloc(GFP_NOIO, nvecs);
 
 	ASSERT(bio->bi_private == NULL);
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
 	return bio;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1b2472a..0af7f93 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1285,7 +1285,7 @@ next_chunk:
 
 	bio = bio_alloc(GFP_NOIO, nr_pages);
 	bio->bi_bdev = bp->b_target->bt_bdev;
-	bio->bi_sector = sector;
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
 
@@ -1307,7 +1307,7 @@ next_chunk:
 		total_nr_pages--;
 	}
 
-	if (likely(bio->bi_size)) {
+	if (likely(bio->bi_iter.bi_size)) {
 		if (xfs_buf_is_vmapped(bp)) {
 			flush_kernel_vmap_range(bp->b_addr,
 						xfs_buf_vmap_len(bp));
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 162036a..5f440f0 100644
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
index fa1abeb..d46e8a6 100644
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
index 5ebda97..5b647cd 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -26,10 +26,10 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->orig_major	= s->d->disk->major;
 		__entry->orig_minor	= s->d->disk->first_minor;
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
@@ -101,9 +101,9 @@ DECLARE_EVENT_CLASS(bcache_bio,
 
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
@@ -136,9 +136,9 @@ TRACE_EVENT(bcache_read,
 
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
@@ -164,9 +164,9 @@ TRACE_EVENT(bcache_write,
 
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
index 60ae7c3..fbf9c5c 100644
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
index 52ae548..a9531ad 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -611,8 +611,8 @@ TRACE_EVENT(f2fs_do_submit_bio,
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
index b8b8560..2814a3e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -764,8 +764,8 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 	if (!error && !bio_flagged(bio, BIO_UPTODATE))
 		error = EIO;
 
-	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw, what,
-			error, 0, NULL);
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio->bi_rw, what, error, 0, NULL);
 }
 
 static void blk_add_trace_bio_bounce(void *ignore,
@@ -868,8 +868,9 @@ static void blk_add_trace_split(void *ignore,
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
@@ -901,9 +902,9 @@ static void blk_add_trace_bio_remap(void *ignore,
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
index ba05b64..8b14ef2 100644
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
1.8.4.rc1

