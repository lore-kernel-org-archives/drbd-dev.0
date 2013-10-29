Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 943E410583DE
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8D81C44A2C3
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:30 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cmXHHYjwk2nl for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:59:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 606DF45C73F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:30 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BnQqQKveq4v3 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Nov 2013 15:59:30 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTP id E190144A2C3
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2013 15:59:29 +0100 (CET)
Resent-Message-ID: <20131108145929.GJ4144@soda.linbit>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
	[209.85.160.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 15C121057678
	for <drbd-dev@lists.linbit.com>; Tue, 29 Oct 2013 21:49:44 +0100 (CET)
Received: by mail-pb0-f41.google.com with SMTP id um1so392337pbc.28
	for <drbd-dev@lists.linbit.com>; Tue, 29 Oct 2013 13:49:42 -0700 (PDT)
From: Kent Overstreet <kmo@daterainc.com>
To: axboe@kernel.dk
Date: Tue, 29 Oct 2013 13:17:57 -0700
Message-Id: <1383077896-4132-5-git-send-email-kmo@daterainc.com>
In-Reply-To: <1383077896-4132-1-git-send-email-kmo@daterainc.com>
References: <1383077896-4132-1-git-send-email-kmo@daterainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
	Pankaj Kumar <pankaj.km@samsung.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Nick Piggin <npiggin@kernel.dk>, Joe Perches <joe@perches.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Minchan Kim <minchan@kernel.org>, Ben Myers <bpm@sgi.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Steven Whitehouse <swhiteho@redhat.com>, hch@infradead.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Mel Gorman <mgorman@suse.de>, Boaz Harrosh <bharrosh@panasas.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Prasad Joshi <prasadjoshi.linux@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Len Brown <len.brown@intel.com>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Ian Campbell <Ian.Campbell@citrix.com>,
	Peng Tao <tao.peng@emc.com>, Sage Weil <sage@inktank.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jie Liu <jeff.liu@oracle.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Joern Engel <joern@logfs.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Steven Rostedt <rostedt@goodmis.org>, xfs@oss.sgi.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Kent Overstreet <kmo@daterainc.com>,
	Jerome Marchand <jmarchand@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Adamson <andros@netapp.com>,
	Sam Bradshaw <sbradshaw@micron.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>,
	ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>,
	Alex Elder <elder@inktank.com>, Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sunil Mushran <sunil.mushran@gmail.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	Asai Thambi S P <asamymuthupa@micron.com>, linux-kernel@vger.kernel.org,
	fanchaoting <fanchaoting@cn.fujitsu.com>,
	Benny Halevy <bhalevy@tonian.com>, Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tj@kernel.org,
	linux390@de.ibm.com, Mark Fasheh <mfasheh@suse.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, Joel Becker <jlbec@evilplan.org>
Subject: [Drbd-dev] [PATCH 04/23] block: Abstract out bvec iterator
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
Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
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
 drivers/block/rbd.c                         | 21 +++----
 drivers/block/rsxx/dev.c                    |  6 +-
 drivers/block/rsxx/dma.c                    |  4 +-
 drivers/block/umem.c                        |  9 +--
 drivers/block/virtio_blk.c                  |  4 +-
 drivers/block/xen-blkback/blkback.c         |  2 +-
 drivers/block/xen-blkfront.c                |  2 +-
 drivers/md/bcache/alloc.c                   |  4 +-
 drivers/md/bcache/btree.c                   | 17 +++---
 drivers/md/bcache/debug.c                   |  2 +-
 drivers/md/bcache/io.c                      | 26 ++++-----
 drivers/md/bcache/journal.c                 | 12 ++--
 drivers/md/bcache/movinggc.c                |  4 +-
 drivers/md/bcache/request.c                 | 48 ++++++++-------
 drivers/md/bcache/super.c                   | 16 ++---
 drivers/md/bcache/util.c                    |  4 +-
 drivers/md/bcache/writeback.c               |  6 +-
 drivers/md/bcache/writeback.h               |  2 +-
 drivers/md/dm-bio-record.h                  | 12 ++--
 drivers/md/dm-bufio.c                       |  2 +-
 drivers/md/dm-cache-policy-mq.c             |  4 +-
 drivers/md/dm-cache-target.c                | 20 ++++---
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
 drivers/md/raid1.c                          | 63 ++++++++++----------
 drivers/md/raid10.c                         | 91 ++++++++++++++++-------=
------
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
 fs/btrfs/extent_io.c                        | 16 ++---
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
 107 files changed, 700 insertions(+), 633 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.=
txt
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
        unsigned long       bi_rw;       /* low bits: r/w, high: priority=
 */
=20
        unsigned int	bi_vcnt;     /* how may bio_vec's */
-       unsigned int	bi_idx;		/* current index into bio_vec array */
+       struct bvec_iter	bi_iter;	/* current index into bio_vec array */
=20
        unsigned int	bi_size;     /* total size in bytes */
        unsigned short 	bi_phys_segments; /* segments after physaddr coal=
esce*/
@@ -480,7 +479,7 @@ With this multipage bio design:
 - Code that traverses the req list can find all the segments of a bio
   by using rq_for_each_segment.  This handles the fact that a request
   has multiple bios, each of which can have multiple segments.
-- Drivers which can't process a large bio in one shot can use the bi_idx
+- Drivers which can't process a large bio in one shot can use the bi_ite=
r
   field to keep track of the next bio_vec entry to process.
   (e.g a 1MB bio_vec needs to be handled in max 128kB chunks for IDE)
   [TBD: Should preferably also have a bi_voffset and bi_vlen to avoid mo=
difying
@@ -589,7 +588,7 @@ driver should not modify these values. The block laye=
r sets up the
 nr_sectors and current_nr_sectors fields (based on the corresponding
 hard_xxx values and the number of bytes transferred) and updates it on
 every transfer that invokes end_that_request_first. It does the same for=
 the
-buffer, bio, bio->bi_idx fields too.
+buffer, bio, bio->bi_iter fields too.
=20
 The buffer field is just a virtual address mapping of the current segmen=
t
 of the i/o buffer in cases where the buffer resides in low-memory. For h=
igh
diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 0721858..0a9d0b3 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -64,7 +64,7 @@ static void nfhd_make_request(struct request_queue *que=
ue, struct bio *bio)
 	struct nfhd_device *dev =3D queue->queuedata;
 	struct bio_vec *bvec;
 	int i, dir, len, shift;
-	sector_t sec =3D bio->bi_sector;
+	sector_t sec =3D bio->bi_iter.bi_sector;
=20
 	dir =3D bio_data_dir(bio);
 	shift =3D dev->bshift;
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.=
c
index 1c16141..f33bcba 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -113,7 +113,8 @@ axon_ram_make_request(struct request_queue *queue, st=
ruct bio *bio)
 	unsigned int transfered;
 	unsigned short idx;
=20
-	phys_mem =3D bank->io_addr + (bio->bi_sector << AXON_RAM_SECTOR_SHIFT);
+	phys_mem =3D bank->io_addr + (bio->bi_iter.bi_sector <<
+				    AXON_RAM_SECTOR_SHIFT);
 	phys_end =3D bank->io_addr + bank->size;
 	transfered =3D 0;
 	bio_for_each_segment(vec, bio, idx) {
diff --git a/block/blk-core.c b/block/blk-core.c
index 0a00e4e..bf6cca1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -166,7 +166,7 @@ static void req_bio_endio(struct request *rq, struct =
bio *bio,
 	bio_advance(bio, nbytes);
=20
 	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_size =3D=3D 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
+	if (bio->bi_iter.bi_size =3D=3D 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
 		bio_endio(bio, error);
 }
=20
@@ -1333,7 +1333,7 @@ void blk_add_request_payload(struct request *rq, st=
ruct page *page,
 	bio->bi_io_vec->bv_offset =3D 0;
 	bio->bi_io_vec->bv_len =3D len;
=20
-	bio->bi_size =3D len;
+	bio->bi_iter.bi_size =3D len;
 	bio->bi_vcnt =3D 1;
 	bio->bi_phys_segments =3D 1;
=20
@@ -1358,7 +1358,7 @@ static bool bio_attempt_back_merge(struct request_q=
ueue *q, struct request *req,
=20
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
-	req->__data_len +=3D bio->bi_size;
+	req->__data_len +=3D bio->bi_iter.bi_size;
 	req->ioprio =3D ioprio_best(req->ioprio, bio_prio(bio));
=20
 	drive_stat_acct(req, 0);
@@ -1387,8 +1387,8 @@ static bool bio_attempt_front_merge(struct request_=
queue *q,
 	 * not touch req->buffer either...
 	 */
 	req->buffer =3D bio_data(bio);
-	req->__sector =3D bio->bi_sector;
-	req->__data_len +=3D bio->bi_size;
+	req->__sector =3D bio->bi_iter.bi_sector;
+	req->__data_len +=3D bio->bi_iter.bi_size;
 	req->ioprio =3D ioprio_best(req->ioprio, bio_prio(bio));
=20
 	drive_stat_acct(req, 0);
@@ -1457,7 +1457,7 @@ void init_request_from_bio(struct request *req, str=
uct bio *bio)
 		req->cmd_flags |=3D REQ_FAILFAST_MASK;
=20
 	req->errors =3D 0;
-	req->__sector =3D bio->bi_sector;
+	req->__sector =3D bio->bi_iter.bi_sector;
 	req->ioprio =3D bio_prio(bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
@@ -1581,12 +1581,12 @@ static inline void blk_partition_remap(struct bio=
 *bio)
 	if (bio_sectors(bio) && bdev !=3D bdev->bd_contains) {
 		struct hd_struct *p =3D bdev->bd_part;
=20
-		bio->bi_sector +=3D p->start_sect;
+		bio->bi_iter.bi_sector +=3D p->start_sect;
 		bio->bi_bdev =3D bdev->bd_contains;
=20
 		trace_block_bio_remap(bdev_get_queue(bio->bi_bdev), bio,
 				      bdev->bd_dev,
-				      bio->bi_sector - p->start_sect);
+				      bio->bi_iter.bi_sector - p->start_sect);
 	}
 }
=20
@@ -1652,7 +1652,7 @@ static inline int bio_check_eod(struct bio *bio, un=
signed int nr_sectors)
 	/* Test device or partition size, when known. */
 	maxsector =3D i_size_read(bio->bi_bdev->bd_inode) >> 9;
 	if (maxsector) {
-		sector_t sector =3D bio->bi_sector;
+		sector_t sector =3D bio->bi_iter.bi_sector;
=20
 		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
 			/*
@@ -1688,7 +1688,7 @@ generic_make_request_checks(struct bio *bio)
 		       "generic_make_request: Trying to access "
 			"nonexistent block-device %s (%Lu)\n",
 			bdevname(bio->bi_bdev, b),
-			(long long) bio->bi_sector);
+			(long long) bio->bi_iter.bi_sector);
 		goto end_io;
 	}
=20
@@ -1702,9 +1702,9 @@ generic_make_request_checks(struct bio *bio)
 	}
=20
 	part =3D bio->bi_bdev->bd_part;
-	if (should_fail_request(part, bio->bi_size) ||
+	if (should_fail_request(part, bio->bi_iter.bi_size) ||
 	    should_fail_request(&part_to_disk(part)->part0,
-				bio->bi_size))
+				bio->bi_iter.bi_size))
 		goto end_io;
=20
 	/*
@@ -1863,7 +1863,7 @@ void submit_bio(int rw, struct bio *bio)
 		if (rw & WRITE) {
 			count_vm_events(PGPGOUT, count);
 		} else {
-			task_io_account_read(bio->bi_size);
+			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
=20
@@ -1872,7 +1872,7 @@ void submit_bio(int rw, struct bio *bio)
 			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
 			current->comm, task_pid_nr(current),
 				(rw & WRITE) ? "WRITE" : "READ",
-				(unsigned long long)bio->bi_sector,
+				(unsigned long long)bio->bi_iter.bi_sector,
 				bdevname(bio->bi_bdev, b),
 				count);
 		}
@@ -2005,7 +2005,7 @@ unsigned int blk_rq_err_bytes(const struct request =
*rq)
 	for (bio =3D rq->bio; bio; bio =3D bio->bi_next) {
 		if ((bio->bi_rw & ff) !=3D ff)
 			break;
-		bytes +=3D bio->bi_size;
+		bytes +=3D bio->bi_iter.bi_size;
 	}
=20
 	/* this could lead to infinite loop */
@@ -2339,9 +2339,9 @@ bool blk_update_request(struct request *req, int er=
ror, unsigned int nr_bytes)
 	total_bytes =3D 0;
 	while (req->bio) {
 		struct bio *bio =3D req->bio;
-		unsigned bio_bytes =3D min(bio->bi_size, nr_bytes);
+		unsigned bio_bytes =3D min(bio->bi_iter.bi_size, nr_bytes);
=20
-		if (bio_bytes =3D=3D bio->bi_size)
+		if (bio_bytes =3D=3D bio->bi_iter.bi_size)
 			req->bio =3D bio->bi_next;
=20
 		req_bio_endio(req, bio, bio_bytes, error);
@@ -2690,7 +2690,7 @@ void blk_rq_bio_prep(struct request_queue *q, struc=
t request *rq,
 		rq->nr_phys_segments =3D bio_phys_segments(q, bio);
 		rq->buffer =3D bio_data(bio);
 	}
-	rq->__data_len =3D bio->bi_size;
+	rq->__data_len =3D bio->bi_iter.bi_size;
 	rq->bio =3D rq->biotail =3D bio;
=20
 	if (bio->bi_bdev)
diff --git a/block/blk-flush.c b/block/blk-flush.c
index cc2b827..3248998 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -444,7 +444,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp=
_t gfp_mask,
 	 * copied from blk_rq_pos(rq).
 	 */
 	if (error_sector)
-		*error_sector =3D bio->bi_sector;
+		*error_sector =3D bio->bi_iter.bi_sector;
=20
 	if (!bio_flagged(bio, BIO_UPTODATE))
 		ret =3D -EIO;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index d6f50d5..3250620 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -110,12 +110,12 @@ int blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,
 			req_sects =3D end_sect - sector;
 		}
=20
-		bio->bi_sector =3D sector;
+		bio->bi_iter.bi_sector =3D sector;
 		bio->bi_end_io =3D bio_batch_end_io;
 		bio->bi_bdev =3D bdev;
 		bio->bi_private =3D &bb;
=20
-		bio->bi_size =3D req_sects << 9;
+		bio->bi_iter.bi_size =3D req_sects << 9;
 		nr_sects -=3D req_sects;
 		sector =3D end_sect;
=20
@@ -176,7 +176,7 @@ int blkdev_issue_write_same(struct block_device *bdev=
, sector_t sector,
 			break;
 		}
=20
-		bio->bi_sector =3D sector;
+		bio->bi_iter.bi_sector =3D sector;
 		bio->bi_end_io =3D bio_batch_end_io;
 		bio->bi_bdev =3D bdev;
 		bio->bi_private =3D &bb;
@@ -186,11 +186,11 @@ int blkdev_issue_write_same(struct block_device *bd=
ev, sector_t sector,
 		bio->bi_io_vec->bv_len =3D bdev_logical_block_size(bdev);
=20
 		if (nr_sects > max_write_same_sectors) {
-			bio->bi_size =3D max_write_same_sectors << 9;
+			bio->bi_iter.bi_size =3D max_write_same_sectors << 9;
 			nr_sects -=3D max_write_same_sectors;
 			sector +=3D max_write_same_sectors;
 		} else {
-			bio->bi_size =3D nr_sects << 9;
+			bio->bi_iter.bi_size =3D nr_sects << 9;
 			nr_sects =3D 0;
 		}
=20
@@ -242,7 +242,7 @@ int __blkdev_issue_zeroout(struct block_device *bdev,=
 sector_t sector,
 			break;
 		}
=20
-		bio->bi_sector =3D sector;
+		bio->bi_iter.bi_sector =3D sector;
 		bio->bi_bdev   =3D bdev;
 		bio->bi_end_io =3D bio_batch_end_io;
 		bio->bi_private =3D &bb;
diff --git a/block/blk-map.c b/block/blk-map.c
index 623e1cd..ae4ae10 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -20,7 +20,7 @@ int blk_rq_append_bio(struct request_queue *q, struct r=
equest *rq,
 		rq->biotail->bi_next =3D bio;
 		rq->biotail =3D bio;
=20
-		rq->__data_len +=3D bio->bi_size;
+		rq->__data_len +=3D bio->bi_iter.bi_size;
 	}
 	return 0;
 }
@@ -76,7 +76,7 @@ static int __blk_rq_map_user(struct request_queue *q, s=
truct request *rq,
=20
 	ret =3D blk_rq_append_bio(q, rq, bio);
 	if (!ret)
-		return bio->bi_size;
+		return bio->bi_iter.bi_size;
=20
 	/* if it was boucned we must call the end io function */
 	bio_endio(bio, 0);
@@ -220,7 +220,7 @@ int blk_rq_map_user_iov(struct request_queue *q, stru=
ct request *rq,
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
=20
-	if (bio->bi_size !=3D len) {
+	if (bio->bi_iter.bi_size !=3D len) {
 		/*
 		 * Grab an extra reference to this bio, as bio_unmap_user()
 		 * expects to be able to drop it twice as it happens on the
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5f24482..7750b25 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -532,9 +532,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *=
bio)
=20
 int blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_sector)
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
-	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_sector)
+	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_secto=
r)
 		return ELEVATOR_FRONT_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8331aba..91573ef 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -867,14 +867,14 @@ static bool tg_with_in_bps_limit(struct throtl_grp =
*tg, struct bio *bio,
 	do_div(tmp, HZ);
 	bytes_allowed =3D tmp;
=20
-	if (tg->bytes_disp[rw] + bio->bi_size <=3D bytes_allowed) {
+	if (tg->bytes_disp[rw] + bio->bi_iter.bi_size <=3D bytes_allowed) {
 		if (wait)
 			*wait =3D 0;
 		return 1;
 	}
=20
 	/* Calc approx time to dispatch */
-	extra_bytes =3D tg->bytes_disp[rw] + bio->bi_size - bytes_allowed;
+	extra_bytes =3D tg->bytes_disp[rw] + bio->bi_iter.bi_size - bytes_allow=
ed;
 	jiffy_wait =3D div64_u64(extra_bytes * HZ, tg->bps[rw]);
=20
 	if (!jiffy_wait)
@@ -977,7 +977,7 @@ static void throtl_charge_bio(struct throtl_grp *tg, =
struct bio *bio)
 	bool rw =3D bio_data_dir(bio);
=20
 	/* Charge the bio to the group */
-	tg->bytes_disp[rw] +=3D bio->bi_size;
+	tg->bytes_disp[rw] +=3D bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
=20
 	/*
@@ -993,8 +993,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, =
struct bio *bio)
 	 */
 	if (!(bio->bi_rw & REQ_THROTTLED)) {
 		bio->bi_rw |=3D REQ_THROTTLED;
-		throtl_update_dispatch_stats(tg_to_blkg(tg), bio->bi_size,
-					     bio->bi_rw);
+		throtl_update_dispatch_stats(tg_to_blkg(tg),
+					     bio->bi_iter.bi_size, bio->bi_rw);
 	}
 }
=20
@@ -1498,7 +1498,7 @@ bool blk_throtl_bio(struct request_queue *q, struct=
 bio *bio)
 	if (tg) {
 		if (!tg->has_rules[rw]) {
 			throtl_update_dispatch_stats(tg_to_blkg(tg),
-						     bio->bi_size, bio->bi_rw);
+					bio->bi_iter.bi_size, bio->bi_rw);
 			goto out_unlock_rcu;
 		}
 	}
@@ -1554,7 +1554,7 @@ bool blk_throtl_bio(struct request_queue *q, struct=
 bio *bio)
 	/* out-of-limit, queue to @tg */
 	throtl_log(sq, "[%c] bio. bdisp=3D%llu sz=3D%u bps=3D%llu iodisp=3D%u i=
ops=3D%u queued=3D%d/%d",
 		   rw =3D=3D READ ? 'R' : 'W',
-		   tg->bytes_disp[rw], bio->bi_size, tg->bps[rw],
+		   tg->bytes_disp[rw], bio->bi_iter.bi_size, tg->bps[rw],
 		   tg->io_disp[rw], tg->iops[rw],
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
=20
diff --git a/block/elevator.c b/block/elevator.c
index 2bcbd8c..b54923c0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -434,7 +434,7 @@ int elv_merge(struct request_queue *q, struct request=
 **req, struct bio *bio)
 	/*
 	 * See if our hash lookup can find a potential backmerge.
 	 */
-	__rq =3D elv_rqhash_find(q, bio->bi_sector);
+	__rq =3D elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		*req =3D __rq;
 		return ELEVATOR_BACK_MERGE;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d251543..877ba11 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -929,8 +929,8 @@ bufinit(struct buf *buf, struct request *rq, struct b=
io *bio)
 	memset(buf, 0, sizeof(*buf));
 	buf->rq =3D rq;
 	buf->bio =3D bio;
-	buf->resid =3D bio->bi_size;
-	buf->sector =3D bio->bi_sector;
+	buf->resid =3D bio->bi_iter.bi_size;
+	buf->sector =3D bio->bi_iter.bi_sector;
 	bio_pageinc(bio);
 	buf->bv =3D bio_iovec(bio);
 	buf->bv_resid =3D buf->bv->bv_len;
@@ -1152,7 +1152,7 @@ aoe_end_request(struct aoedev *d, struct request *r=
q, int fastfail)
 	do {
 		bio =3D rq->bio;
 		bok =3D !fastfail && test_bit(BIO_UPTODATE, &bio->bi_flags);
-	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_size));
+	} while (__blk_end_request(rq, bok ? 0 : -EIO, bio->bi_iter.bi_size));
=20
 	/* cf. http://lkml.org/lkml/2006/10/31/28 */
 	if (!fastfail)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 9bf4371..e269532 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -333,13 +333,13 @@ static void brd_make_request(struct request_queue *=
q, struct bio *bio)
 	int i;
 	int err =3D -EIO;
=20
-	sector =3D bio->bi_sector;
+	sector =3D bio->bi_iter.bi_sector;
 	if (bio_end_sector(bio) > get_capacity(bdev->bd_disk))
 		goto out;
=20
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
 		err =3D 0;
-		discard_from_brd(brd, sector, bio->bi_size);
+		discard_from_brd(brd, sector, bio->bi_iter.bi_size);
 		goto out;
 	}
=20
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_a=
ctlog.c
index 28c73ca..a9b13f2 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -159,7 +159,7 @@ static int _drbd_md_sync_page_io(struct drbd_conf *md=
ev,
=20
 	bio =3D bio_alloc_drbd(GFP_NOIO);
 	bio->bi_bdev =3D bdev->md_bdev;
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	err =3D -EIO;
 	if (bio_add_page(bio, page, size, 0) !=3D size)
 		goto out;
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index b12c11e..597f111 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1028,7 +1028,7 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx=
, int page_nr, int rw) __must
 	} else
 		page =3D b->bm_pages[page_nr];
 	bio->bi_bdev =3D mdev->ldev->md_bdev;
-	bio->bi_sector =3D on_disk_sector;
+	bio->bi_iter.bi_sector =3D on_disk_sector;
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
 	bio_add_page(bio, page, len, 0);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index cc29cd3..cf6d072 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1333,7 +1333,7 @@ next_bio:
 		goto fail;
 	}
 	/* > peer_req->i.sector, unless this is the first bio */
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	bio->bi_bdev =3D mdev->ldev->backing_bdev;
 	bio->bi_rw =3D rw;
 	bio->bi_private =3D peer_req;
@@ -1353,7 +1353,7 @@ next_bio:
 				dev_err(DEV,
 					"bio_add_page failed for len=3D%u, "
 					"bi_vcnt=3D0 (bi_sector=3D%llu)\n",
-					len, (unsigned long long)bio->bi_sector);
+					len, (uint64_t)bio->bi_iter.bi_sector);
 				err =3D -ENOSPC;
 				goto fail;
 			}
@@ -1615,7 +1615,7 @@ static int recv_dless_read(struct drbd_conf *mdev, =
struct drbd_request *req,
 	mdev->recv_cnt +=3D data_size>>9;
=20
 	bio =3D req->master_bio;
-	D_ASSERT(sector =3D=3D bio->bi_sector);
+	D_ASSERT(sector =3D=3D bio->bi_iter.bi_sector);
=20
 	bio_for_each_segment(bvec, bio, i) {
 		void *mapped =3D kmap(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index c24379f..a6bedaa 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -77,8 +77,8 @@ static struct drbd_request *drbd_req_new(struct drbd_co=
nf *mdev,
 	req->epoch       =3D 0;
=20
 	drbd_clear_interval(&req->i);
-	req->i.sector     =3D bio_src->bi_sector;
-	req->i.size      =3D bio_src->bi_size;
+	req->i.sector     =3D bio_src->bi_iter.bi_sector;
+	req->i.size      =3D bio_src->bi_iter.bi_size;
 	req->i.local =3D true;
 	req->i.waiting =3D false;
=20
@@ -1280,7 +1280,7 @@ void drbd_make_request(struct request_queue *q, str=
uct bio *bio)
 	/*
 	 * what we "blindly" assume:
 	 */
-	D_ASSERT(IS_ALIGNED(bio->bi_size, 512));
+	D_ASSERT(IS_ALIGNED(bio->bi_iter.bi_size, 512));
=20
 	inc_ap_bio(mdev);
 	__drbd_make_request(mdev, bio, start_time);
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.=
h
index 978cb1a..28e15d9 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -269,7 +269,7 @@ static inline void drbd_req_make_private_bio(struct d=
rbd_request *req, struct bi
=20
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
@@ -3775,9 +3775,9 @@ static int __floppy_read_block_0(struct block_devic=
e *bdev)
 	bio_vec.bv_len =3D size;
 	bio_vec.bv_offset =3D 0;
 	bio.bi_vcnt =3D 1;
-	bio.bi_size =3D size;
+	bio.bi_iter.bi_size =3D size;
 	bio.bi_bdev =3D bdev;
-	bio.bi_sector =3D 0;
+	bio.bi_iter.bi_sector =3D 0;
 	bio.bi_flags =3D (1 << BIO_QUIET);
 	init_completion(&complete);
 	bio.bi_private =3D &complete;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 40e7155..2440b50 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -415,7 +415,7 @@ static int do_bio_filebacked(struct loop_device *lo, =
struct bio *bio)
 	loff_t pos;
 	int ret;
=20
-	pos =3D ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	pos =3D ((loff_t) bio->bi_iter.bi_sector << 9) + lo->lo_offset;
=20
 	if (bio_rw(bio) =3D=3D WRITE) {
 		struct file *file =3D lo->lo_backing_file;
@@ -444,7 +444,7 @@ static int do_bio_filebacked(struct loop_device *lo, =
struct bio *bio)
 				goto out;
 			}
 			ret =3D file->f_op->fallocate(file, mode, pos,
-						    bio->bi_size);
+						    bio->bi_iter.bi_size);
 			if (unlikely(ret && ret !=3D -EINVAL &&
 				     ret !=3D -EOPNOTSUPP))
 				ret =3D -EIO;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 952dbfe..a49bdaf 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3890,7 +3890,7 @@ static void mtip_make_request(struct request_queue =
*queue, struct bio *bio)
 	}
=20
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
-		bio_endio(bio, mtip_send_trim(dd, bio->bi_sector,
+		bio_endio(bio, mtip_send_trim(dd, bio->bi_iter.bi_sector,
 						bio_sectors(bio)));
 		return;
 	}
@@ -3903,7 +3903,8 @@ static void mtip_make_request(struct request_queue =
*queue, struct bio *bio)
=20
 	if (bio_data_dir(bio) =3D=3D WRITE && bio_sectors(bio) <=3D 64 &&
 							dd->unal_qdepth) {
-		if (bio->bi_sector % 8 !=3D 0) /* Unaligned on 4k boundaries */
+		if (bio->bi_iter.bi_sector % 8 !=3D 0)
+			/* Unaligned on 4k boundaries */
 			unaligned =3D 1;
 		else if (bio_sectors(bio) % 8 !=3D 0) /* Aligned but not 4k/8k */
 			unaligned =3D 1;
@@ -3932,7 +3933,7 @@ static void mtip_make_request(struct request_queue =
*queue, struct bio *bio)
=20
 		/* Issue the read/write. */
 		mtip_hw_submit_io(dd,
-				bio->bi_sector,
+				bio->bi_iter.bi_sector,
 				bio_sectors(bio),
 				nents,
 				tag,
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..ab4d0b6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -468,7 +468,7 @@ static struct nvme_bio_pair *nvme_bio_split(struct bi=
o *bio, int idx,
 {
 	struct nvme_bio_pair *bp;
=20
-	BUG_ON(len > bio->bi_size);
+	BUG_ON(len > bio->bi_iter.bi_size);
 	BUG_ON(idx > bio->bi_vcnt);
=20
 	bp =3D kmalloc(sizeof(*bp), GFP_ATOMIC);
@@ -479,11 +479,11 @@ static struct nvme_bio_pair *nvme_bio_split(struct =
bio *bio, int idx,
 	bp->b1 =3D *bio;
 	bp->b2 =3D *bio;
=20
-	bp->b1.bi_size =3D len;
-	bp->b2.bi_size -=3D len;
+	bp->b1.bi_iter.bi_size =3D len;
+	bp->b2.bi_iter.bi_size -=3D len;
 	bp->b1.bi_vcnt =3D idx;
-	bp->b2.bi_idx =3D idx;
-	bp->b2.bi_sector +=3D len >> 9;
+	bp->b2.bi_iter.bi_idx =3D idx;
+	bp->b2.bi_iter.bi_sector +=3D len >> 9;
=20
 	if (offset) {
 		bp->bv1 =3D kmalloc(bio->bi_max_vecs * sizeof(struct bio_vec),
@@ -552,11 +552,12 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, s=
truct nvme_iod *iod,
 {
 	struct bio_vec *bvec, *bvprv =3D NULL;
 	struct scatterlist *sg =3D NULL;
-	int i, length =3D 0, nsegs =3D 0, split_len =3D bio->bi_size;
+	int i, length =3D 0, nsegs =3D 0, split_len =3D bio->bi_iter.bi_size;
=20
 	if (nvmeq->dev->stripe_size)
 		split_len =3D nvmeq->dev->stripe_size -
-			((bio->bi_sector << 9) & (nvmeq->dev->stripe_size - 1));
+			((bio->bi_iter.bi_sector << 9) &
+			 (nvmeq->dev->stripe_size - 1));
=20
 	sg_init_table(iod->sg, psegs);
 	bio_for_each_segment(bvec, bio, i) {
@@ -584,7 +585,7 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, str=
uct nvme_iod *iod,
 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) =3D=3D 0)
 		return -ENOMEM;
=20
-	BUG_ON(length !=3D bio->bi_size);
+	BUG_ON(length !=3D bio->bi_iter.bi_size);
 	return length;
 }
=20
@@ -608,8 +609,8 @@ static int nvme_submit_discard(struct nvme_queue *nvm=
eq, struct nvme_ns *ns,
 	iod->npages =3D 0;
=20
 	range->cattr =3D cpu_to_le32(0);
-	range->nlb =3D cpu_to_le32(bio->bi_size >> ns->lba_shift);
-	range->slba =3D cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	range->nlb =3D cpu_to_le32(bio->bi_iter.bi_size >> ns->lba_shift);
+	range->slba =3D cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
=20
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode =3D nvme_cmd_dsm;
@@ -674,7 +675,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *n=
vmeq, struct nvme_ns *ns,
 	}
=20
 	result =3D -ENOMEM;
-	iod =3D nvme_alloc_iod(psegs, bio->bi_size, GFP_ATOMIC);
+	iod =3D nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
 	if (!iod)
 		goto nomem;
 	iod->private =3D bio;
@@ -723,7 +724,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *n=
vmeq, struct nvme_ns *ns,
 	cmnd->rw.nsid =3D cpu_to_le32(ns->ns_id);
 	length =3D nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, length,
 								GFP_ATOMIC);
-	cmnd->rw.slba =3D cpu_to_le64(nvme_block_nr(ns, bio->bi_sector));
+	cmnd->rw.slba =3D cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector)=
);
 	cmnd->rw.length =3D cpu_to_le16((length >> ns->lba_shift) - 1);
 	cmnd->rw.control =3D cpu_to_le16(control);
 	cmnd->rw.dsmgmt =3D cpu_to_le32(dsmgmt);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 5618847..147f05e 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -665,7 +665,7 @@ static struct pkt_rb_node *pkt_rbtree_find(struct pkt=
cdvd_device *pd, sector_t s
=20
 	for (;;) {
 		tmp =3D rb_entry(n, struct pkt_rb_node, rb_node);
-		if (s <=3D tmp->bio->bi_sector)
+		if (s <=3D tmp->bio->bi_iter.bi_sector)
 			next =3D n->rb_left;
 		else
 			next =3D n->rb_right;
@@ -674,12 +674,12 @@ static struct pkt_rb_node *pkt_rbtree_find(struct p=
ktcdvd_device *pd, sector_t s
 		n =3D next;
 	}
=20
-	if (s > tmp->bio->bi_sector) {
+	if (s > tmp->bio->bi_iter.bi_sector) {
 		tmp =3D pkt_rbtree_next(tmp);
 		if (!tmp)
 			return NULL;
 	}
-	BUG_ON(s > tmp->bio->bi_sector);
+	BUG_ON(s > tmp->bio->bi_iter.bi_sector);
 	return tmp;
 }
=20
@@ -690,13 +690,13 @@ static void pkt_rbtree_insert(struct pktcdvd_device=
 *pd, struct pkt_rb_node *nod
 {
 	struct rb_node **p =3D &pd->bio_queue.rb_node;
 	struct rb_node *parent =3D NULL;
-	sector_t s =3D node->bio->bi_sector;
+	sector_t s =3D node->bio->bi_iter.bi_sector;
 	struct pkt_rb_node *tmp;
=20
 	while (*p) {
 		parent =3D *p;
 		tmp =3D rb_entry(parent, struct pkt_rb_node, rb_node);
-		if (s < tmp->bio->bi_sector)
+		if (s < tmp->bio->bi_iter.bi_sector)
 			p =3D &(*p)->rb_left;
 		else
 			p =3D &(*p)->rb_right;
@@ -871,7 +871,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_=
device *pd)
 			spin_lock(&pd->iosched.lock);
 			bio =3D bio_list_peek(&pd->iosched.write_queue);
 			spin_unlock(&pd->iosched.lock);
-			if (bio && (bio->bi_sector =3D=3D pd->iosched.last_write))
+			if (bio && (bio->bi_iter.bi_sector =3D=3D
+				    pd->iosched.last_write))
 				need_write_seek =3D 0;
 			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
@@ -902,7 +903,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_=
device *pd)
 			continue;
=20
 		if (bio_data_dir(bio) =3D=3D READ)
-			pd->iosched.successive_reads +=3D bio->bi_size >> 10;
+			pd->iosched.successive_reads +=3D
+				bio->bi_iter.bi_size >> 10;
 		else {
 			pd->iosched.successive_reads =3D 0;
 			pd->iosched.last_write =3D bio_end_sector(bio);
@@ -992,7 +994,7 @@ static void pkt_end_io_read(struct bio *bio, int err)
=20
 	pkt_dbg(2, pd, "bio=3D%p sec0=3D%llx sec=3D%llx err=3D%d\n",
 		bio, (unsigned long long)pkt->sector,
-		(unsigned long long)bio->bi_sector, err);
+		(unsigned long long)bio->bi_iter.bi_sector, err);
=20
 	if (err)
 		atomic_inc(&pkt->io_errors);
@@ -1040,8 +1042,9 @@ static void pkt_gather_data(struct pktcdvd_device *=
pd, struct packet_data *pkt)
 	memset(written, 0, sizeof(written));
 	spin_lock(&pkt->lock);
 	bio_list_for_each(bio, &pkt->orig_bios) {
-		int first_frame =3D (bio->bi_sector - pkt->sector) / (CD_FRAMESIZE >> =
9);
-		int num_frames =3D bio->bi_size / CD_FRAMESIZE;
+		int first_frame =3D (bio->bi_iter.bi_sector - pkt->sector) /
+			(CD_FRAMESIZE >> 9);
+		int num_frames =3D bio->bi_iter.bi_size / CD_FRAMESIZE;
 		pd->stats.secs_w +=3D num_frames * (CD_FRAMESIZE >> 9);
 		BUG_ON(first_frame < 0);
 		BUG_ON(first_frame + num_frames > pkt->frames);
@@ -1067,7 +1070,7 @@ static void pkt_gather_data(struct pktcdvd_device *=
pd, struct packet_data *pkt)
=20
 		bio =3D pkt->r_bios[f];
 		bio_reset(bio);
-		bio->bi_sector =3D pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_iter.bi_sector =3D pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_bdev =3D pd->bdev;
 		bio->bi_end_io =3D pkt_end_io_read;
 		bio->bi_private =3D pkt;
@@ -1164,8 +1167,8 @@ static int pkt_start_recovery(struct packet_data *p=
kt)
 	bio_reset(pkt->bio);
 	pkt->bio->bi_bdev =3D pd->bdev;
 	pkt->bio->bi_rw =3D REQ_WRITE;
-	pkt->bio->bi_sector =3D new_sector;
-	pkt->bio->bi_size =3D pkt->frames * CD_FRAMESIZE;
+	pkt->bio->bi_iter.bi_sector =3D new_sector;
+	pkt->bio->bi_iter.bi_size =3D pkt->frames * CD_FRAMESIZE;
 	pkt->bio->bi_vcnt =3D pkt->frames;
=20
 	pkt->bio->bi_end_io =3D pkt_end_io_packet_write;
@@ -1227,7 +1230,7 @@ static int pkt_handle_queue(struct pktcdvd_device *=
pd)
 	node =3D first_node;
 	while (node) {
 		bio =3D node->bio;
-		zone =3D get_zone(bio->bi_sector, pd);
+		zone =3D get_zone(bio->bi_iter.bi_sector, pd);
 		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
 			if (p->sector =3D=3D zone) {
 				bio =3D NULL;
@@ -1266,14 +1269,14 @@ try_next_bio:
 	pkt_dbg(2, pd, "looking for zone %llx\n", (unsigned long long)zone);
 	while ((node =3D pkt_rbtree_find(pd, zone)) !=3D NULL) {
 		bio =3D node->bio;
-		pkt_dbg(2, pd, "found zone=3D%llx\n",
-			(unsigned long long)get_zone(bio->bi_sector, pd));
-		if (get_zone(bio->bi_sector, pd) !=3D zone)
+		pkt_dbg(2, pd, "found zone=3D%llx\n", (unsigned long long)
+			get_zone(bio->bi_iter.bi_sector, pd));
+		if (get_zone(bio->bi_iter.bi_sector, pd) !=3D zone)
 			break;
 		pkt_rbtree_erase(pd, node);
 		spin_lock(&pkt->lock);
 		bio_list_add(&pkt->orig_bios, bio);
-		pkt->write_size +=3D bio->bi_size / CD_FRAMESIZE;
+		pkt->write_size +=3D bio->bi_iter.bi_size / CD_FRAMESIZE;
 		spin_unlock(&pkt->lock);
 	}
 	/* check write congestion marks, and if bio_queue_size is
@@ -1307,7 +1310,7 @@ static void pkt_start_write(struct pktcdvd_device *=
pd, struct packet_data *pkt)
 	struct bio_vec *bvec =3D pkt->w_bio->bi_io_vec;
=20
 	bio_reset(pkt->w_bio);
-	pkt->w_bio->bi_sector =3D pkt->sector;
+	pkt->w_bio->bi_iter.bi_sector =3D pkt->sector;
 	pkt->w_bio->bi_bdev =3D pd->bdev;
 	pkt->w_bio->bi_end_io =3D pkt_end_io_packet_write;
 	pkt->w_bio->bi_private =3D pkt;
@@ -2384,20 +2387,20 @@ static void pkt_make_request(struct request_queue=
 *q, struct bio *bio)
=20
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
 		pkt_notice(pd, "WRITE for ro device (%llu)\n",
-			   (unsigned long long)bio->bi_sector);
+			   (unsigned long long)bio->bi_iter.bi_sector);
 		goto end_io;
 	}
=20
-	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
+	if (!bio->bi_iter.bi_size || (bio->bi_iter.bi_size % CD_FRAMESIZE)) {
 		pkt_err(pd, "wrong bio size\n");
 		goto end_io;
 	}
=20
 	blk_queue_bounce(q, &bio);
=20
-	zone =3D get_zone(bio->bi_sector, pd);
+	zone =3D get_zone(bio->bi_iter.bi_sector, pd);
 	pkt_dbg(2, pd, "start =3D %6llx stop =3D %6llx\n",
-		(unsigned long long)bio->bi_sector,
+		(unsigned long long)bio->bi_iter.bi_sector,
 		(unsigned long long)bio_end_sector(bio));
=20
 	/* Check if we have to split the bio */
@@ -2409,7 +2412,7 @@ static void pkt_make_request(struct request_queue *=
q, struct bio *bio)
 		last_zone =3D get_zone(bio_end_sector(bio) - 1, pd);
 		if (last_zone !=3D zone) {
 			BUG_ON(last_zone !=3D zone + pd->settings.size);
-			first_sectors =3D last_zone - bio->bi_sector;
+			first_sectors =3D last_zone - bio->bi_iter.bi_sector;
 			bp =3D bio_split(bio, first_sectors);
 			BUG_ON(!bp);
 			pkt_make_request(q, &bp->bio1);
@@ -2431,7 +2434,8 @@ static void pkt_make_request(struct request_queue *=
q, struct bio *bio)
 			if ((pkt->state =3D=3D PACKET_WAITING_STATE) ||
 			    (pkt->state =3D=3D PACKET_READ_WAIT_STATE)) {
 				bio_list_add(&pkt->orig_bios, bio);
-				pkt->write_size +=3D bio->bi_size / CD_FRAMESIZE;
+				pkt->write_size +=3D
+					bio->bi_iter.bi_size / CD_FRAMESIZE;
 				if ((pkt->write_size >=3D pkt->frames) &&
 				    (pkt->state =3D=3D PACKET_WAITING_STATE)) {
 					atomic_inc(&pkt->run_sm);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index d754a88..464be78 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -104,7 +104,7 @@ static void ps3disk_scatter_gather(struct ps3_storage=
_device *dev,
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: bio %u: %u segs %u sectors from %lu\n",
 			__func__, __LINE__, i, bio_segments(iter.bio),
-			bio_sectors(iter.bio), iter.bio->bi_sector);
+			bio_sectors(iter.bio), iter.bio->bi_iter.bi_sector);
=20
 		size =3D bvec->bv_len;
 		buf =3D bvec_kmap_irq(bvec, &flags);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cb1db29..a8f4fe2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1183,14 +1183,14 @@ static struct bio *bio_clone_range(struct bio *bi=
o_src,
=20
 	/* Handle the easy case for the caller */
=20
-	if (!offset && len =3D=3D bio_src->bi_size)
+	if (!offset && len =3D=3D bio_src->bi_iter.bi_size)
 		return bio_clone(bio_src, gfpmask);
=20
 	if (WARN_ON_ONCE(!len))
 		return NULL;
-	if (WARN_ON_ONCE(len > bio_src->bi_size))
+	if (WARN_ON_ONCE(len > bio_src->bi_iter.bi_size))
 		return NULL;
-	if (WARN_ON_ONCE(offset > bio_src->bi_size - len))
+	if (WARN_ON_ONCE(offset > bio_src->bi_iter.bi_size - len))
 		return NULL;
=20
 	/* Find first affected segment... */
@@ -1220,7 +1220,8 @@ static struct bio *bio_clone_range(struct bio *bio_=
src,
 		return NULL;	/* ENOMEM */
=20
 	bio->bi_bdev =3D bio_src->bi_bdev;
-	bio->bi_sector =3D bio_src->bi_sector + (offset >> SECTOR_SHIFT);
+	bio->bi_iter.bi_sector =3D bio_src->bi_iter.bi_sector +
+		(offset >> SECTOR_SHIFT);
 	bio->bi_rw =3D bio_src->bi_rw;
 	bio->bi_flags |=3D 1 << BIO_CLONED;
=20
@@ -1239,8 +1240,7 @@ static struct bio *bio_clone_range(struct bio *bio_=
src,
 	}
=20
 	bio->bi_vcnt =3D vcnt;
-	bio->bi_size =3D len;
-	bio->bi_idx =3D 0;
+	bio->bi_iter.bi_size =3D len;
=20
 	return bio;
 }
@@ -1271,7 +1271,7 @@ static struct bio *bio_chain_clone_range(struct bio=
 **bio_src,
=20
 	/* Build up a chain of clone bios up to the limit */
=20
-	if (!bi || off >=3D bi->bi_size || !len)
+	if (!bi || off >=3D bi->bi_iter.bi_size || !len)
 		return NULL;		/* Nothing to clone */
=20
 	end =3D &chain;
@@ -1283,7 +1283,7 @@ static struct bio *bio_chain_clone_range(struct bio=
 **bio_src,
 			rbd_warn(NULL, "bio_chain exhausted with %u left", len);
 			goto out_err;	/* EINVAL; ran out of bio's */
 		}
-		bi_size =3D min_t(unsigned int, bi->bi_size - off, len);
+		bi_size =3D min_t(unsigned int, bi->bi_iter.bi_size - off, len);
 		bio =3D bio_clone_range(bi, off, bi_size, gfpmask);
 		if (!bio)
 			goto out_err;	/* ENOMEM */
@@ -1292,7 +1292,7 @@ static struct bio *bio_chain_clone_range(struct bio=
 **bio_src,
 		end =3D &bio->bi_next;
=20
 		off +=3D bi_size;
-		if (off =3D=3D bi->bi_size) {
+		if (off =3D=3D bi->bi_iter.bi_size) {
 			bi =3D bi->bi_next;
 			off =3D 0;
 		}
@@ -2186,7 +2186,8 @@ static int rbd_img_request_fill(struct rbd_img_requ=
est *img_request,
=20
 	if (type =3D=3D OBJ_REQUEST_BIO) {
 		bio_list =3D data_desc;
-		rbd_assert(img_offset =3D=3D bio_list->bi_sector << SECTOR_SHIFT);
+		rbd_assert(img_offset =3D=3D
+			   bio_list->bi_iter.bi_sector << SECTOR_SHIFT);
 	} else {
 		rbd_assert(type =3D=3D OBJ_REQUEST_PAGES);
 		pages =3D data_desc;
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index d7af441..9b17fa0 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -174,7 +174,7 @@ static void rsxx_make_request(struct request_queue *q=
, struct bio *bio)
 	if (!card)
 		goto req_err;
=20
-	if (bio->bi_sector + (bio->bi_size >> 9) > get_capacity(card->gendisk))
+	if (bio_end_sector(bio) > get_capacity(card->gendisk))
 		goto req_err;
=20
 	if (unlikely(card->halt)) {
@@ -187,7 +187,7 @@ static void rsxx_make_request(struct request_queue *q=
, struct bio *bio)
 		goto req_err;
 	}
=20
-	if (bio->bi_size =3D=3D 0) {
+	if (bio->bi_iter.bi_size =3D=3D 0) {
 		dev_err(CARD_TO_DEV(card), "size zero BIO!\n");
 		goto req_err;
 	}
@@ -208,7 +208,7 @@ static void rsxx_make_request(struct request_queue *q=
, struct bio *bio)
=20
 	dev_dbg(CARD_TO_DEV(card), "BIO[%c]: meta: %p addr8: x%llx size: %d\n",
 		 bio_data_dir(bio) ? 'W' : 'R', bio_meta,
-		 (u64)bio->bi_sector << 9, bio->bi_size);
+		 (u64)bio->bi_iter.bi_sector << 9, bio->bi_iter.bi_size);
=20
 	st =3D rsxx_dma_queue_bio(card, bio, &bio_meta->pending_dmas,
 				    bio_dma_done_cb, bio_meta);
diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index bed32f1..9e6318a 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -667,7 +667,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 	int st;
 	int i;
=20
-	addr8 =3D bio->bi_sector << 9; /* sectors are 512 bytes */
+	addr8 =3D bio->bi_iter.bi_sector << 9; /* sectors are 512 bytes */
 	atomic_set(n_dmas, 0);
=20
 	for (i =3D 0; i < card->n_targets; i++) {
@@ -676,7 +676,7 @@ int rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 	}
=20
 	if (bio->bi_rw & REQ_DISCARD) {
-		bv_len =3D bio->bi_size;
+		bv_len =3D bio->bi_iter.bi_size;
=20
 		while (bv_len > 0) {
 			tgt   =3D rsxx_get_dma_tgt(card, addr8);
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index ad70868..dab4f1a 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -352,8 +352,8 @@ static int add_bio(struct cardinfo *card)
 	bio =3D card->currentbio;
 	if (!bio && card->bio) {
 		card->currentbio =3D card->bio;
-		card->current_idx =3D card->bio->bi_idx;
-		card->current_sector =3D card->bio->bi_sector;
+		card->current_idx =3D card->bio->bi_iter.bi_idx;
+		card->current_sector =3D card->bio->bi_iter.bi_sector;
 		card->bio =3D card->bio->bi_next;
 		if (card->bio =3D=3D NULL)
 			card->biotail =3D &card->bio;
@@ -451,7 +451,7 @@ static void process_page(unsigned long data)
 		if (page->idx >=3D bio->bi_vcnt) {
 			page->bio =3D bio->bi_next;
 			if (page->bio)
-				page->idx =3D page->bio->bi_idx;
+				page->idx =3D page->bio->bi_iter.bi_idx;
 		}
=20
 		pci_unmap_page(card->dev, desc->data_dma_handle,
@@ -532,7 +532,8 @@ static void mm_make_request(struct request_queue *q, =
struct bio *bio)
 {
 	struct cardinfo *card =3D q->queuedata;
 	pr_debug("mm_make_request %llu %u\n",
-		 (unsigned long long)bio->bi_sector, bio->bi_size);
+		 (unsigned long long)bio->bi_iter.bi_sector,
+		 bio->bi_iter.bi_size);
=20
 	spin_lock_irq(&card->lock);
 	*card->biotail =3D bio;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5cdf88b..93fde08 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -184,7 +184,7 @@ static void virtblk_bio_send_data(struct virtblk_req =
*vbr)
=20
 	vbr->flags &=3D ~VBLK_IS_FLUSH;
 	vbr->out_hdr.type =3D 0;
-	vbr->out_hdr.sector =3D bio->bi_sector;
+	vbr->out_hdr.sector =3D bio->bi_iter.bi_sector;
 	vbr->out_hdr.ioprio =3D bio_prio(bio);
=20
 	if (blk_bio_map_sg(vblk->disk->queue, bio, vbr->sg)) {
@@ -400,7 +400,7 @@ static void virtblk_make_request(struct request_queue=
 *q, struct bio *bio)
 		vbr->flags |=3D VBLK_REQ_FLUSH;
 	if (bio->bi_rw & REQ_FUA)
 		vbr->flags |=3D VBLK_REQ_FUA;
-	if (bio->bi_size)
+	if (bio->bi_iter.bi_size)
 		vbr->flags |=3D VBLK_REQ_DATA;
=20
 	if (unlikely(vbr->flags & VBLK_REQ_FLUSH))
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkb=
ack/blkback.c
index bf4b9d2..ce0674f 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1256,7 +1256,7 @@ static int dispatch_rw_block_io(struct xen_blkif *b=
lkif,
 			bio->bi_bdev    =3D preq.bdev;
 			bio->bi_private =3D pending_req;
 			bio->bi_end_io  =3D end_block_io_op;
-			bio->bi_sector  =3D preq.sector_number;
+			bio->bi_iter.bi_sector  =3D preq.sector_number;
 		}
=20
 		preq.sector_number +=3D seg[i].nsec;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8d53ed2..a2ade73 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1468,7 +1468,7 @@ static int blkif_recover(struct blkfront_info *info=
)
 			for (i =3D 0; i < pending; i++) {
 				offset =3D (i * segs * PAGE_SIZE) >> 9;
 				size =3D min((unsigned int)(segs * PAGE_SIZE) >> 9,
-					   (unsigned int)(bio->bi_size >> 9) - offset);
+					   (unsigned int)bio_sectors(bio) - offset);
 				cloned_bio =3D bio_clone(bio, GFP_NOIO);
 				BUG_ON(cloned_bio =3D=3D NULL);
 				bio_trim(cloned_bio, offset, size);
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index e45f557..9afe32f 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -178,12 +178,12 @@ static void do_discard(struct cache *ca, long bucke=
t)
=20
 	bio_init(&d->bio);
=20
-	d->bio.bi_sector	=3D bucket_to_sector(ca->set, d->bucket);
+	d->bio.bi_iter.bi_sector =3D bucket_to_sector(ca->set, d->bucket);
 	d->bio.bi_bdev		=3D ca->bdev;
 	d->bio.bi_rw		=3D REQ_WRITE|REQ_DISCARD;
 	d->bio.bi_max_vecs	=3D 1;
 	d->bio.bi_io_vec	=3D d->bio.bi_inline_vecs;
-	d->bio.bi_size		=3D bucket_bytes(ca);
+	d->bio.bi_iter.bi_size	=3D bucket_bytes(ca);
 	d->bio.bi_end_io	=3D discard_endio;
 	bio_set_prio(&d->bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
=20
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index f42fc7e..19cd76f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -230,7 +230,7 @@ void bch_btree_node_read(struct btree *b)
=20
 	bio =3D bch_bbio_alloc(b->c);
 	bio->bi_rw	=3D REQ_META|READ_SYNC;
-	bio->bi_size	=3D KEY_SIZE(&b->key) << 9;
+	bio->bi_iter.bi_size =3D KEY_SIZE(&b->key) << 9;
 	bio->bi_end_io	=3D btree_node_read_endio;
 	bio->bi_private	=3D &cl;
=20
@@ -329,7 +329,7 @@ static void do_btree_node_write(struct btree *b)
 	b->bio->bi_end_io	=3D btree_node_write_endio;
 	b->bio->bi_private	=3D &b->io.cl;
 	b->bio->bi_rw		=3D REQ_META|WRITE_SYNC|REQ_FUA;
-	b->bio->bi_size		=3D set_blocks(i, b->c) * block_bytes(b->c);
+	b->bio->bi_iter.bi_size	=3D set_blocks(i, b->c) * block_bytes(b->c);
 	bch_bio_map(b->bio, i);
=20
 	/*
@@ -2161,11 +2161,11 @@ static int submit_partial_cache_miss(struct btree=
 *b, struct btree_op *op,
 		unsigned sectors =3D INT_MAX;
=20
 		if (KEY_INODE(k) =3D=3D op->inode) {
-			if (KEY_START(k) <=3D bio->bi_sector)
+			if (KEY_START(k) <=3D bio->bi_iter.bi_sector)
 				break;
=20
 			sectors =3D min_t(uint64_t, sectors,
-					KEY_START(k) - bio->bi_sector);
+					KEY_START(k) - bio->bi_iter.bi_sector);
 		}
=20
 		ret =3D s->d->cache_miss(b, s, bio, sectors);
@@ -2197,12 +2197,12 @@ static int submit_partial_cache_hit(struct btree =
*b, struct btree_op *op,
=20
 	while (!op->lookup_done &&
 	       KEY_INODE(k) =3D=3D op->inode &&
-	       bio->bi_sector < KEY_OFFSET(k)) {
+	       bio->bi_iter.bi_sector < KEY_OFFSET(k)) {
 		struct bkey *bio_key;
 		sector_t sector =3D PTR_OFFSET(k, ptr) +
-			(bio->bi_sector - KEY_START(k));
+			(bio->bi_iter.bi_sector - KEY_START(k));
 		unsigned sectors =3D min_t(uint64_t, INT_MAX,
-					 KEY_OFFSET(k) - bio->bi_sector);
+				KEY_OFFSET(k) - bio->bi_iter.bi_sector);
=20
 		n =3D bch_bio_split(bio, sectors, GFP_NOIO, s->d->bio_split);
 		if (n =3D=3D bio)
@@ -2241,7 +2241,8 @@ int bch_btree_search_recurse(struct btree *b, struc=
t btree_op *op)
 	int ret =3D 0;
 	struct bkey *k;
 	struct btree_iter iter;
-	bch_btree_iter_init(b, &iter, &KEY(op->inode, bio->bi_sector, 0));
+	bch_btree_iter_init(b, &iter, &KEY(op->inode,
+					   bio->bi_iter.bi_sector, 0));
=20
 	do {
 		k =3D bch_btree_iter_next_filter(&iter, b, bch_ptr_bad);
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
=20
 		kunmap(bv->bv_page);
 		kunmap(check->bi_io_vec[i].bv_page);
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index 9056632..cc4ba2d 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -21,18 +21,18 @@ static void bch_bi_idx_hack_endio(struct bio *bio, in=
t error)
=20
 static void bch_generic_make_request_hack(struct bio *bio)
 {
-	if (bio->bi_idx) {
+	if (bio->bi_iter.bi_idx) {
 		struct bio *clone =3D bio_alloc(GFP_NOIO, bio_segments(bio));
=20
 		memcpy(clone->bi_io_vec,
 		       bio_iovec(bio),
 		       bio_segments(bio) * sizeof(struct bio_vec));
=20
-		clone->bi_sector	=3D bio->bi_sector;
+		clone->bi_iter.bi_sector =3D bio->bi_iter.bi_sector;
 		clone->bi_bdev		=3D bio->bi_bdev;
 		clone->bi_rw		=3D bio->bi_rw;
 		clone->bi_vcnt		=3D bio_segments(bio);
-		clone->bi_size		=3D bio->bi_size;
+		clone->bi_iter.bi_size	=3D bio->bi_iter.bi_size;
=20
 		clone->bi_private	=3D bio;
 		clone->bi_end_io	=3D bch_bi_idx_hack_endio;
@@ -72,7 +72,7 @@ static void bch_generic_make_request_hack(struct bio *b=
io)
 struct bio *bch_bio_split(struct bio *bio, int sectors,
 			  gfp_t gfp, struct bio_set *bs)
 {
-	unsigned idx =3D bio->bi_idx, vcnt =3D 0, nbytes =3D sectors << 9;
+	unsigned idx =3D bio->bi_iter.bi_idx, vcnt =3D 0, nbytes =3D sectors <<=
 9;
 	struct bio_vec *bv;
 	struct bio *ret =3D NULL;
=20
@@ -90,7 +90,7 @@ struct bio *bch_bio_split(struct bio *bio, int sectors,
 	}
=20
 	bio_for_each_segment(bv, bio, idx) {
-		vcnt =3D idx - bio->bi_idx;
+		vcnt =3D idx - bio->bi_iter.bi_idx;
=20
 		if (!nbytes) {
 			ret =3D bio_alloc_bioset(gfp, vcnt, bs);
@@ -119,15 +119,15 @@ struct bio *bch_bio_split(struct bio *bio, int sect=
ors,
 	}
 out:
 	ret->bi_bdev	=3D bio->bi_bdev;
-	ret->bi_sector	=3D bio->bi_sector;
-	ret->bi_size	=3D sectors << 9;
+	ret->bi_iter.bi_sector	=3D bio->bi_iter.bi_sector;
+	ret->bi_iter.bi_size	=3D sectors << 9;
 	ret->bi_rw	=3D bio->bi_rw;
 	ret->bi_vcnt	=3D vcnt;
 	ret->bi_max_vecs =3D vcnt;
=20
-	bio->bi_sector	+=3D sectors;
-	bio->bi_size	-=3D sectors << 9;
-	bio->bi_idx	 =3D idx;
+	bio->bi_iter.bi_sector	+=3D sectors;
+	bio->bi_iter.bi_size	-=3D sectors << 9;
+	bio->bi_iter.bi_idx	 =3D idx;
=20
 	if (bio_integrity(bio)) {
 		if (bio_integrity_clone(ret, bio, gfp)) {
@@ -162,7 +162,7 @@ static unsigned bch_bio_max_sectors(struct bio *bio)
 		bio_for_each_segment(bv, bio, i) {
 			struct bvec_merge_data bvm =3D {
 				.bi_bdev	=3D bio->bi_bdev,
-				.bi_sector	=3D bio->bi_sector,
+				.bi_sector	=3D bio->bi_iter.bi_sector,
 				.bi_size	=3D ret << 9,
 				.bi_rw		=3D bio->bi_rw,
 			};
@@ -272,8 +272,8 @@ void __bch_submit_bbio(struct bio *bio, struct cache_=
set *c)
 {
 	struct bbio *b =3D container_of(bio, struct bbio, bio);
=20
-	bio->bi_sector	=3D PTR_OFFSET(&b->key, 0);
-	bio->bi_bdev	=3D PTR_CACHE(c, &b->key, 0)->bdev;
+	bio->bi_iter.bi_sector	=3D PTR_OFFSET(&b->key, 0);
+	bio->bi_bdev		=3D PTR_CACHE(c, &b->key, 0)->bdev;
=20
 	b->submit_time_us =3D local_clock_us();
 	closure_bio_submit(bio, bio->bi_private, PTR_CACHE(c, &b->key, 0));
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 8435f81..f7e5eeb 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -49,10 +49,10 @@ reread:		left =3D ca->sb.bucket_size - offset;
 		len =3D min_t(unsigned, left, PAGE_SECTORS * 8);
=20
 		bio_reset(bio);
-		bio->bi_sector	=3D bucket + offset;
+		bio->bi_iter.bi_sector	=3D bucket + offset;
 		bio->bi_bdev	=3D ca->bdev;
 		bio->bi_rw	=3D READ;
-		bio->bi_size	=3D len << 9;
+		bio->bi_iter.bi_size	=3D len << 9;
=20
 		bio->bi_end_io	=3D journal_read_endio;
 		bio->bi_private =3D &op->cl;
@@ -452,13 +452,13 @@ static void do_journal_discard(struct cache *ca)
 		atomic_set(&ja->discard_in_flight, DISCARD_IN_FLIGHT);
=20
 		bio_init(bio);
-		bio->bi_sector		=3D bucket_to_sector(ca->set,
+		bio->bi_iter.bi_sector	=3D bucket_to_sector(ca->set,
 						ca->sb.d[ja->discard_idx]);
 		bio->bi_bdev		=3D ca->bdev;
 		bio->bi_rw		=3D REQ_WRITE|REQ_DISCARD;
 		bio->bi_max_vecs	=3D 1;
 		bio->bi_io_vec		=3D bio->bi_inline_vecs;
-		bio->bi_size		=3D bucket_bytes(ca);
+		bio->bi_iter.bi_size	=3D bucket_bytes(ca);
 		bio->bi_end_io		=3D journal_discard_endio;
=20
 		closure_get(&ca->set->cl);
@@ -629,10 +629,10 @@ static void journal_write_unlocked(struct closure *=
cl)
 		atomic_long_add(sectors, &ca->meta_sectors_written);
=20
 		bio_reset(bio);
-		bio->bi_sector	=3D PTR_OFFSET(k, i);
+		bio->bi_iter.bi_sector	=3D PTR_OFFSET(k, i);
 		bio->bi_bdev	=3D ca->bdev;
 		bio->bi_rw	=3D REQ_WRITE|REQ_SYNC|REQ_META|REQ_FLUSH|REQ_FUA;
-		bio->bi_size	=3D sectors << 9;
+		bio->bi_iter.bi_size =3D sectors << 9;
=20
 		bio->bi_end_io	=3D journal_write_endio;
 		bio->bi_private =3D w;
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 1a3b4f4..ef630f4 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -82,7 +82,7 @@ static void moving_init(struct moving_io *io)
 	bio_get(bio);
 	bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
=20
-	bio->bi_size		=3D KEY_SIZE(&io->w->key) << 9;
+	bio->bi_iter.bi_size	=3D KEY_SIZE(&io->w->key) << 9;
 	bio->bi_max_vecs	=3D DIV_ROUND_UP(KEY_SIZE(&io->w->key),
 					       PAGE_SECTORS);
 	bio->bi_private		=3D &io->s.cl;
@@ -98,7 +98,7 @@ static void write_moving(struct closure *cl)
 	if (!s->error) {
 		moving_init(io);
=20
-		io->bio.bio.bi_sector	=3D KEY_START(&io->w->key);
+		io->bio.bio.bi_iter.bi_sector =3D KEY_START(&io->w->key);
 		s->op.lock		=3D -1;
 		s->op.write_prio	=3D 1;
 		s->op.cache_bio		=3D &io->bio.bio;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 00cc9be..6d2211a 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -219,7 +219,7 @@ static void bio_invalidate(struct closure *cl)
 	struct bio *bio =3D op->cache_bio;
=20
 	pr_debug("invalidating %i sectors from %llu",
-		 bio_sectors(bio), (uint64_t) bio->bi_sector);
+		 bio_sectors(bio), (uint64_t) bio->bi_iter.bi_sector);
=20
 	while (bio_sectors(bio)) {
 		unsigned len =3D min(bio_sectors(bio), 1U << 14);
@@ -227,11 +227,11 @@ static void bio_invalidate(struct closure *cl)
 		if (bch_keylist_realloc(&op->keys, 0, op->c))
 			goto out;
=20
-		bio->bi_sector	+=3D len;
-		bio->bi_size	-=3D len << 9;
+		bio->bi_iter.bi_sector	+=3D len;
+		bio->bi_iter.bi_size	-=3D len << 9;
=20
 		bch_keylist_add(&op->keys,
-				&KEY(op->inode, bio->bi_sector, len));
+				&KEY(op->inode, bio->bi_iter.bi_sector, len));
 	}
=20
 	op->insert_data_done =3D true;
@@ -509,7 +509,7 @@ static void bch_insert_data_loop(struct closure *cl)
 		k =3D op->keys.top;
 		bkey_init(k);
 		SET_KEY_INODE(k, op->inode);
-		SET_KEY_OFFSET(k, bio->bi_sector);
+		SET_KEY_OFFSET(k, bio->bi_iter.bi_sector);
=20
 		if (!bch_alloc_sectors(k, bio_sectors(bio), s))
 			goto err;
@@ -802,9 +802,12 @@ static void request_read_done(struct closure *cl)
=20
 	if (s->op.cache_bio) {
 		bio_reset(s->op.cache_bio);
-		s->op.cache_bio->bi_sector	=3D s->cache_miss->bi_sector;
-		s->op.cache_bio->bi_bdev	=3D s->cache_miss->bi_bdev;
-		s->op.cache_bio->bi_size	=3D s->cache_bio_sectors << 9;
+		s->op.cache_bio->bi_iter.bi_sector =3D
+			s->cache_miss->bi_iter.bi_sector;
+		s->op.cache_bio->bi_bdev =3D
+			s->cache_miss->bi_bdev;
+		s->op.cache_bio->bi_iter.bi_size =3D
+			s->cache_bio_sectors << 9;
 		bch_bio_map(s->op.cache_bio, NULL);
=20
 		bio_copy_data(s->cache_miss, s->op.cache_bio);
@@ -883,9 +886,9 @@ static int cached_dev_cache_miss(struct btree *b, str=
uct search *s,
 	if (!s->op.cache_bio)
 		goto out_submit;
=20
-	s->op.cache_bio->bi_sector	=3D miss->bi_sector;
+	s->op.cache_bio->bi_iter.bi_sector =3D miss->bi_iter.bi_sector;
 	s->op.cache_bio->bi_bdev	=3D miss->bi_bdev;
-	s->op.cache_bio->bi_size	=3D s->cache_bio_sectors << 9;
+	s->op.cache_bio->bi_iter.bi_size =3D s->cache_bio_sectors << 9;
=20
 	s->op.cache_bio->bi_end_io	=3D request_endio;
 	s->op.cache_bio->bi_private	=3D &s->cl;
@@ -939,7 +942,7 @@ static void request_write(struct cached_dev *dc, stru=
ct search *s)
 	struct closure *cl =3D &s->cl;
 	struct bio *bio =3D &s->bio.bio;
 	struct bkey start, end;
-	start =3D KEY(dc->disk.id, bio->bi_sector, 0);
+	start =3D KEY(dc->disk.id, bio->bi_iter.bi_sector, 0);
 	end =3D KEY(dc->disk.id, bio_end_sector(bio), 0);
=20
 	bch_keybuf_check_overlapping(&s->op.c->moving_gc_keys, &start, &end);
@@ -1083,8 +1086,8 @@ static void check_should_skip(struct cached_dev *dc=
, struct search *s)
 	     (bio->bi_rw & REQ_WRITE)))
 		goto skip;
=20
-	if (bio->bi_sector   & (c->sb.block_size - 1) ||
-	    bio_sectors(bio) & (c->sb.block_size - 1)) {
+	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
+	    bio_sectors(bio)       & (c->sb.block_size - 1)) {
 		pr_debug("skipping unaligned io");
 		goto skip;
 	}
@@ -1103,8 +1106,9 @@ static void check_should_skip(struct cached_dev *dc=
, struct search *s)
=20
 		spin_lock(&dc->io_lock);
=20
-		hlist_for_each_entry(i, iohash(dc, bio->bi_sector), hash)
-			if (i->last =3D=3D bio->bi_sector &&
+		hlist_for_each_entry(i, iohash(dc, bio->bi_iter.bi_sector),
+				     hash)
+			if (i->last =3D=3D bio->bi_iter.bi_sector &&
 			    time_before(jiffies, i->jiffies))
 				goto found;
=20
@@ -1113,8 +1117,8 @@ static void check_should_skip(struct cached_dev *dc=
, struct search *s)
 		add_sequential(s->task);
 		i->sequential =3D 0;
 found:
-		if (i->sequential + bio->bi_size > i->sequential)
-			i->sequential	+=3D bio->bi_size;
+		if (i->sequential + bio->bi_iter.bi_size > i->sequential)
+			i->sequential	+=3D bio->bi_iter.bi_size;
=20
 		i->last			 =3D bio_end_sector(bio);
 		i->jiffies		 =3D jiffies + msecs_to_jiffies(5000);
@@ -1126,7 +1130,7 @@ found:
=20
 		spin_unlock(&dc->io_lock);
 	} else {
-		s->task->sequential_io =3D bio->bi_size;
+		s->task->sequential_io =3D bio->bi_iter.bi_size;
=20
 		add_sequential(s->task);
 	}
@@ -1166,7 +1170,7 @@ static void cached_dev_make_request(struct request_=
queue *q, struct bio *bio)
 	part_stat_unlock();
=20
 	bio->bi_bdev =3D dc->bdev;
-	bio->bi_sector +=3D dc->sb.data_offset;
+	bio->bi_iter.bi_sector +=3D dc->sb.data_offset;
=20
 	if (cached_dev_get(dc)) {
 		s =3D search_alloc(bio, d);
@@ -1249,9 +1253,9 @@ static int flash_dev_cache_miss(struct btree *b, st=
ruct search *s,
 		sectors	-=3D j;
 	}
=20
-	bio_advance(bio, min(sectors << 9, bio->bi_size));
+	bio_advance(bio, min(sectors << 9, bio->bi_iter.bi_size));
=20
-	if (!bio->bi_size)
+	if (!bio->bi_iter.bi_size)
 		s->op.lookup_done =3D true;
=20
 	return 0;
@@ -1279,7 +1283,7 @@ static void flash_dev_make_request(struct request_q=
ueue *q, struct bio *bio)
 		closure_call(&s->op.cl, btree_read_async, NULL, cl);
 	} else if (bio_has_data(bio) || s->op.skip) {
 		bch_keybuf_check_overlapping(&s->op.c->moving_gc_keys,
-					&KEY(d->id, bio->bi_sector, 0),
+					&KEY(d->id, bio->bi_iter.bi_sector, 0),
 					&KEY(d->id, bio_end_sector(bio), 0));
=20
 		s->writeback	=3D true;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index dc073eb..fff4894 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -240,9 +240,9 @@ static void __write_super(struct cache_sb *sb, struct=
 bio *bio)
 	struct cache_sb *out =3D page_address(bio->bi_io_vec[0].bv_page);
 	unsigned i;
=20
-	bio->bi_sector	=3D SB_SECTOR;
-	bio->bi_rw	=3D REQ_SYNC|REQ_META;
-	bio->bi_size	=3D SB_SIZE;
+	bio->bi_iter.bi_sector	=3D SB_SECTOR;
+	bio->bi_rw		=3D REQ_SYNC|REQ_META;
+	bio->bi_iter.bi_size	=3D SB_SIZE;
 	bch_bio_map(bio, NULL);
=20
 	out->offset		=3D cpu_to_le64(sb->offset);
@@ -354,7 +354,7 @@ static void uuid_io(struct cache_set *c, unsigned lon=
g rw,
 		struct bio *bio =3D bch_bbio_alloc(c);
=20
 		bio->bi_rw	=3D REQ_SYNC|REQ_META|rw;
-		bio->bi_size	=3D KEY_SIZE(k) << 9;
+		bio->bi_iter.bi_size =3D KEY_SIZE(k) << 9;
=20
 		bio->bi_end_io	=3D uuid_endio;
 		bio->bi_private =3D cl;
@@ -510,10 +510,10 @@ static void prio_io(struct cache *ca, uint64_t buck=
et, unsigned long rw)
=20
 	closure_init_stack(cl);
=20
-	bio->bi_sector	=3D bucket * ca->sb.bucket_size;
-	bio->bi_bdev	=3D ca->bdev;
-	bio->bi_rw	=3D REQ_SYNC|REQ_META|rw;
-	bio->bi_size	=3D bucket_bytes(ca);
+	bio->bi_iter.bi_sector	=3D bucket * ca->sb.bucket_size;
+	bio->bi_bdev		=3D ca->bdev;
+	bio->bi_rw		=3D REQ_SYNC|REQ_META|rw;
+	bio->bi_iter.bi_size	=3D bucket_bytes(ca);
=20
 	bio->bi_end_io	=3D prio_endio;
 	bio->bi_private =3D ca;
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 420dad5..158827e6 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -212,10 +212,10 @@ uint64_t bch_next_delay(struct bch_ratelimit *d, ui=
nt64_t done)
=20
 void bch_bio_map(struct bio *bio, void *base)
 {
-	size_t size =3D bio->bi_size;
+	size_t size =3D bio->bi_iter.bi_size;
 	struct bio_vec *bv =3D bio->bi_io_vec;
=20
-	BUG_ON(!bio->bi_size);
+	BUG_ON(!bio->bi_iter.bi_size);
 	BUG_ON(bio->bi_vcnt);
=20
 	bv->bv_offset =3D base ? ((unsigned long) base) % PAGE_SIZE : 0;
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.=
c
index ba3ee48..6929ec3 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -146,7 +146,7 @@ static void dirty_init(struct keybuf_key *w)
 	if (!io->dc->writeback_percent)
 		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
=20
-	bio->bi_size		=3D KEY_SIZE(&w->key) << 9;
+	bio->bi_iter.bi_size	=3D KEY_SIZE(&w->key) << 9;
 	bio->bi_max_vecs	=3D DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS);
 	bio->bi_private		=3D w;
 	bio->bi_io_vec		=3D bio->bi_inline_vecs;
@@ -345,7 +345,7 @@ static void write_dirty(struct closure *cl)
=20
 	dirty_init(w);
 	io->bio.bi_rw		=3D WRITE;
-	io->bio.bi_sector	=3D KEY_START(&w->key);
+	io->bio.bi_iter.bi_sector =3D KEY_START(&w->key);
 	io->bio.bi_bdev		=3D io->dc->bdev;
 	io->bio.bi_end_io	=3D dirty_endio;
=20
@@ -411,7 +411,7 @@ static void read_dirty(struct closure *cl)
 		io->dc		=3D dc;
=20
 		dirty_init(w);
-		io->bio.bi_sector	=3D PTR_OFFSET(&w->key, 0);
+		io->bio.bi_iter.bi_sector =3D PTR_OFFSET(&w->key, 0);
 		io->bio.bi_bdev		=3D PTR_CACHE(dc->disk.c,
 						    &w->key, 0)->bdev;
 		io->bio.bi_rw		=3D READ;
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.=
h
index c91f61b..681efd3 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -43,7 +43,7 @@ static inline bool should_writeback(struct cached_dev *=
dc, struct bio *bio,
 		return false;
=20
 	if (dc->partial_stripes_expensive &&
-	    bcache_dev_stripe_dirty(&dc->disk, bio->bi_sector,
+	    bcache_dev_stripe_dirty(&dc->disk, bio->bi_iter.bi_sector,
 				    bio_sectors(bio)))
 		return true;
=20
diff --git a/drivers/md/dm-bio-record.h b/drivers/md/dm-bio-record.h
index 3a8cfa2..5ace48e 100644
--- a/drivers/md/dm-bio-record.h
+++ b/drivers/md/dm-bio-record.h
@@ -40,10 +40,10 @@ static inline void dm_bio_record(struct dm_bio_detail=
s *bd, struct bio *bio)
 {
 	unsigned i;
=20
-	bd->bi_sector =3D bio->bi_sector;
+	bd->bi_sector =3D bio->bi_iter.bi_sector;
 	bd->bi_bdev =3D bio->bi_bdev;
-	bd->bi_size =3D bio->bi_size;
-	bd->bi_idx =3D bio->bi_idx;
+	bd->bi_size =3D bio->bi_iter.bi_size;
+	bd->bi_idx =3D bio->bi_iter.bi_idx;
 	bd->bi_flags =3D bio->bi_flags;
=20
 	for (i =3D 0; i < bio->bi_vcnt; i++) {
@@ -56,10 +56,10 @@ static inline void dm_bio_restore(struct dm_bio_detai=
ls *bd, struct bio *bio)
 {
 	unsigned i;
=20
-	bio->bi_sector =3D bd->bi_sector;
+	bio->bi_iter.bi_sector =3D bd->bi_sector;
 	bio->bi_bdev =3D bd->bi_bdev;
-	bio->bi_size =3D bd->bi_size;
-	bio->bi_idx =3D bd->bi_idx;
+	bio->bi_iter.bi_size =3D bd->bi_size;
+	bio->bi_iter.bi_idx =3D bd->bi_idx;
 	bio->bi_flags =3D bd->bi_flags;
=20
 	for (i =3D 0; i < bio->bi_vcnt; i++) {
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 173cbb2..4113b60 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -538,7 +538,7 @@ static void use_inline_bio(struct dm_buffer *b, int r=
w, sector_t block,
 	bio_init(&b->bio);
 	b->bio.bi_io_vec =3D b->bio_vec;
 	b->bio.bi_max_vecs =3D DM_BUFIO_INLINE_VECS;
-	b->bio.bi_sector =3D block << b->c->sectors_per_block_bits;
+	b->bio.bi_iter.bi_sector =3D block << b->c->sectors_per_block_bits;
 	b->bio.bi_bdev =3D b->c->bdev;
 	b->bio.bi_end_io =3D end_io;
=20
diff --git a/drivers/md/dm-cache-policy-mq.c b/drivers/md/dm-cache-policy=
-mq.c
index 4296155..6714a30 100644
--- a/drivers/md/dm-cache-policy-mq.c
+++ b/drivers/md/dm-cache-policy-mq.c
@@ -85,7 +85,7 @@ static enum io_pattern iot_pattern(struct io_tracker *t=
)
=20
 static void iot_update_stats(struct io_tracker *t, struct bio *bio)
 {
-	if (bio->bi_sector =3D=3D from_oblock(t->last_end_oblock) + 1)
+	if (bio->bi_iter.bi_sector =3D=3D from_oblock(t->last_end_oblock) + 1)
 		t->nr_seq_samples++;
 	else {
 		/*
@@ -100,7 +100,7 @@ static void iot_update_stats(struct io_tracker *t, st=
ruct bio *bio)
 		t->nr_rand_samples++;
 	}
=20
-	t->last_end_oblock =3D to_oblock(bio->bi_sector + bio_sectors(bio) - 1)=
;
+	t->last_end_oblock =3D to_oblock(bio_end_sector(bio) - 1);
 }
=20
 static void iot_check_for_pattern_switch(struct io_tracker *t)
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 2956976..b71195f 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -567,15 +567,17 @@ static void remap_to_origin(struct cache *cache, st=
ruct bio *bio)
 static void remap_to_cache(struct cache *cache, struct bio *bio,
 			   dm_cblock_t cblock)
 {
-	sector_t bi_sector =3D bio->bi_sector;
+	sector_t bi_sector =3D bio->bi_iter.bi_sector;
=20
 	bio->bi_bdev =3D cache->cache_dev->bdev;
 	if (!block_size_is_power_of_two(cache))
-		bio->bi_sector =3D (from_cblock(cblock) * cache->sectors_per_block) +
-				sector_div(bi_sector, cache->sectors_per_block);
+		bio->bi_iter.bi_sector =3D
+			(from_cblock(cblock) * cache->sectors_per_block) +
+			sector_div(bi_sector, cache->sectors_per_block);
 	else
-		bio->bi_sector =3D (from_cblock(cblock) << cache->sectors_per_block_sh=
ift) |
-				(bi_sector & (cache->sectors_per_block - 1));
+		bio->bi_iter.bi_sector =3D
+			(from_cblock(cblock) << cache->sectors_per_block_shift) |
+			(bi_sector & (cache->sectors_per_block - 1));
 }
=20
 static void check_if_tick_bio_needed(struct cache *cache, struct bio *bi=
o)
@@ -614,7 +616,7 @@ static void remap_to_cache_dirty(struct cache *cache,=
 struct bio *bio,
=20
 static dm_oblock_t get_bio_block(struct cache *cache, struct bio *bio)
 {
-	sector_t block_nr =3D bio->bi_sector;
+	sector_t block_nr =3D bio->bi_iter.bi_sector;
=20
 	if (!block_size_is_power_of_two(cache))
 		(void) sector_div(block_nr, cache->sectors_per_block);
@@ -1066,7 +1068,7 @@ static void process_flush_bio(struct cache *cache, =
struct bio *bio)
 	size_t pb_data_size =3D get_per_bio_data_size(cache);
 	struct per_bio_data *pb =3D get_per_bio_data(bio, pb_data_size);
=20
-	BUG_ON(bio->bi_size);
+	BUG_ON(bio->bi_iter.bi_size);
 	if (!pb->req_nr)
 		remap_to_origin(cache, bio);
 	else
@@ -1089,9 +1091,9 @@ static void process_flush_bio(struct cache *cache, =
struct bio *bio)
  */
 static void process_discard_bio(struct cache *cache, struct bio *bio)
 {
-	dm_block_t start_block =3D dm_sector_div_up(bio->bi_sector,
+	dm_block_t start_block =3D dm_sector_div_up(bio->bi_iter.bi_sector,
 						  cache->discard_block_size);
-	dm_block_t end_block =3D bio->bi_sector + bio_sectors(bio);
+	dm_block_t end_block =3D bio_end_sector(bio);
 	dm_block_t b;
=20
 	end_block =3D block_div(end_block, cache->discard_block_size);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 0fce0bc..3e8dd65 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -652,8 +652,8 @@ static void crypt_convert_init(struct crypt_config *c=
c,
 	ctx->bio_out =3D bio_out;
 	ctx->offset_in =3D 0;
 	ctx->offset_out =3D 0;
-	ctx->idx_in =3D bio_in ? bio_in->bi_idx : 0;
-	ctx->idx_out =3D bio_out ? bio_out->bi_idx : 0;
+	ctx->idx_in =3D bio_in ? bio_in->bi_iter.bi_idx : 0;
+	ctx->idx_out =3D bio_out ? bio_out->bi_iter.bi_idx : 0;
 	ctx->cc_sector =3D sector + cc->iv_offset;
 	init_completion(&ctx->restart);
 }
@@ -845,7 +845,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt=
_io *io, unsigned size,
 		size -=3D len;
 	}
=20
-	if (!clone->bi_size) {
+	if (!clone->bi_iter.bi_size) {
 		bio_put(clone);
 		return NULL;
 	}
@@ -985,7 +985,7 @@ static int kcryptd_io_read(struct dm_crypt_io *io, gf=
p_t gfp)
 	crypt_inc_pending(io);
=20
 	clone_init(io, clone);
-	clone->bi_sector =3D cc->start + io->sector;
+	clone->bi_iter.bi_sector =3D cc->start + io->sector;
=20
 	generic_make_request(clone);
 	return 0;
@@ -1033,7 +1033,7 @@ static void kcryptd_crypt_write_io_submit(struct dm=
_crypt_io *io, int async)
 	/* crypt_convert should have filled the clone bio */
 	BUG_ON(io->ctx.idx_out < clone->bi_vcnt);
=20
-	clone->bi_sector =3D cc->start + io->sector;
+	clone->bi_iter.bi_sector =3D cc->start + io->sector;
=20
 	if (async)
 		kcryptd_queue_io(io);
@@ -1048,7 +1048,7 @@ static void kcryptd_crypt_write_convert(struct dm_c=
rypt_io *io)
 	struct dm_crypt_io *new_io;
 	int crypt_finished;
 	unsigned out_of_pages =3D 0;
-	unsigned remaining =3D io->base_bio->bi_size;
+	unsigned remaining =3D io->base_bio->bi_iter.bi_size;
 	sector_t sector =3D io->sector;
 	int r;
=20
@@ -1072,7 +1072,7 @@ static void kcryptd_crypt_write_convert(struct dm_c=
rypt_io *io)
 		io->ctx.bio_out =3D clone;
 		io->ctx.idx_out =3D 0;
=20
-		remaining -=3D clone->bi_size;
+		remaining -=3D clone->bi_iter.bi_size;
 		sector +=3D bio_sectors(clone);
=20
 		crypt_inc_pending(io);
@@ -1681,11 +1681,12 @@ static int crypt_map(struct dm_target *ti, struct=
 bio *bio)
 	if (unlikely(bio->bi_rw & (REQ_FLUSH | REQ_DISCARD))) {
 		bio->bi_bdev =3D cc->dev->bdev;
 		if (bio_sectors(bio))
-			bio->bi_sector =3D cc->start + dm_target_offset(ti, bio->bi_sector);
+			bio->bi_iter.bi_sector =3D cc->start +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
 		return DM_MAPIO_REMAPPED;
 	}
=20
-	io =3D crypt_io_alloc(cc, bio, dm_target_offset(ti, bio->bi_sector));
+	io =3D crypt_io_alloc(cc, bio, dm_target_offset(ti, bio->bi_iter.bi_sec=
tor));
=20
 	if (bio_data_dir(io->base_bio) =3D=3D READ) {
 		if (kcryptd_io_read(io, GFP_NOWAIT))
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 496d5f3..84c8601 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -281,14 +281,15 @@ static int delay_map(struct dm_target *ti, struct b=
io *bio)
 	if ((bio_data_dir(bio) =3D=3D WRITE) && (dc->dev_write)) {
 		bio->bi_bdev =3D dc->dev_write->bdev;
 		if (bio_sectors(bio))
-			bio->bi_sector =3D dc->start_write +
-					 dm_target_offset(ti, bio->bi_sector);
+			bio->bi_iter.bi_sector =3D dc->start_write +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
=20
 		return delay_bio(dc, dc->write_delay, bio);
 	}
=20
 	bio->bi_bdev =3D dc->dev_read->bdev;
-	bio->bi_sector =3D dc->start_read + dm_target_offset(ti, bio->bi_sector=
);
+	bio->bi_iter.bi_sector =3D dc->start_read +
+		dm_target_offset(ti, bio->bi_iter.bi_sector);
=20
 	return delay_bio(dc, dc->read_delay, bio);
 }
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index c80a0ec..b257e46 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -248,7 +248,8 @@ static void flakey_map_bio(struct dm_target *ti, stru=
ct bio *bio)
=20
 	bio->bi_bdev =3D fc->dev->bdev;
 	if (bio_sectors(bio))
-		bio->bi_sector =3D flakey_map_sector(ti, bio->bi_sector);
+		bio->bi_iter.bi_sector =3D
+			flakey_map_sector(ti, bio->bi_iter.bi_sector);
 }
=20
 static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc)
@@ -265,8 +266,8 @@ static void corrupt_bio_data(struct bio *bio, struct =
flakey_c *fc)
 		DMDEBUG("Corrupting data bio=3D%p by writing %u to byte %u "
 			"(rw=3D%c bi_rw=3D%lu bi_sector=3D%llu cur_bytes=3D%u)\n",
 			bio, fc->corrupt_bio_value, fc->corrupt_bio_byte,
-			(bio_data_dir(bio) =3D=3D WRITE) ? 'w' : 'r',
-			bio->bi_rw, (unsigned long long)bio->bi_sector, bio_bytes);
+			(bio_data_dir(bio) =3D=3D WRITE) ? 'w' : 'r', bio->bi_rw,
+			(unsigned long long)bio->bi_iter.bi_sector, bio_bytes);
 	}
 }
=20
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2a20986..01558b0 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -304,14 +304,14 @@ static void do_region(int rw, unsigned region, stru=
ct dm_io_region *where,
 					  dm_sector_div_up(remaining, (PAGE_SIZE >> SECTOR_SHIFT)));
=20
 		bio =3D bio_alloc_bioset(GFP_NOIO, num_bvecs, io->client->bios);
-		bio->bi_sector =3D where->sector + (where->count - remaining);
+		bio->bi_iter.bi_sector =3D where->sector + (where->count - remaining);
 		bio->bi_bdev =3D where->bdev;
 		bio->bi_end_io =3D endio;
 		store_io_and_region_in_bio(bio, io, region);
=20
 		if (rw & REQ_DISCARD) {
 			num_sectors =3D min_t(sector_t, q->limits.max_discard_sectors, remain=
ing);
-			bio->bi_size =3D num_sectors << SECTOR_SHIFT;
+			bio->bi_iter.bi_size =3D num_sectors << SECTOR_SHIFT;
 			remaining -=3D num_sectors;
 		} else if (rw & REQ_WRITE_SAME) {
 			/*
@@ -320,7 +320,7 @@ static void do_region(int rw, unsigned region, struct=
 dm_io_region *where,
 			dp->get_page(dp, &page, &len, &offset);
 			bio_add_page(bio, page, logical_block_size, offset);
 			num_sectors =3D min_t(sector_t, q->limits.max_write_same_sectors, rem=
aining);
-			bio->bi_size =3D num_sectors << SECTOR_SHIFT;
+			bio->bi_iter.bi_size =3D num_sectors << SECTOR_SHIFT;
=20
 			offset =3D 0;
 			remaining -=3D num_sectors;
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 4f99d26..53e848c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -85,7 +85,8 @@ static void linear_map_bio(struct dm_target *ti, struct=
 bio *bio)
=20
 	bio->bi_bdev =3D lc->dev->bdev;
 	if (bio_sectors(bio))
-		bio->bi_sector =3D linear_map_sector(ti, bio->bi_sector);
+		bio->bi_iter.bi_sector =3D
+			linear_map_sector(ti, bio->bi_iter.bi_sector);
 }
=20
 static int linear_map(struct dm_target *ti, struct bio *bio)
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 9584443..9f6d8e6 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -432,7 +432,7 @@ static int mirror_available(struct mirror_set *ms, st=
ruct bio *bio)
 	region_t region =3D dm_rh_bio_to_region(ms->rh, bio);
=20
 	if (log->type->in_sync(log, region, 0))
-		return choose_mirror(ms,  bio->bi_sector) ? 1 : 0;
+		return choose_mirror(ms,  bio->bi_iter.bi_sector) ? 1 : 0;
=20
 	return 0;
 }
@@ -442,15 +442,15 @@ static int mirror_available(struct mirror_set *ms, =
struct bio *bio)
  */
 static sector_t map_sector(struct mirror *m, struct bio *bio)
 {
-	if (unlikely(!bio->bi_size))
+	if (unlikely(!bio->bi_iter.bi_size))
 		return 0;
-	return m->offset + dm_target_offset(m->ms->ti, bio->bi_sector);
+	return m->offset + dm_target_offset(m->ms->ti, bio->bi_iter.bi_sector);
 }
=20
 static void map_bio(struct mirror *m, struct bio *bio)
 {
 	bio->bi_bdev =3D m->dev->bdev;
-	bio->bi_sector =3D map_sector(m, bio);
+	bio->bi_iter.bi_sector =3D map_sector(m, bio);
 }
=20
 static void map_region(struct dm_io_region *io, struct mirror *m,
@@ -527,7 +527,7 @@ static void read_async_bio(struct mirror *m, struct b=
io *bio)
 	struct dm_io_request io_req =3D {
 		.bi_rw =3D READ,
 		.mem.type =3D DM_IO_BVEC,
-		.mem.ptr.bvec =3D bio->bi_io_vec + bio->bi_idx,
+		.mem.ptr.bvec =3D bio->bi_io_vec + bio->bi_iter.bi_idx,
 		.notify.fn =3D read_callback,
 		.notify.context =3D bio,
 		.client =3D m->ms->io_client,
@@ -559,7 +559,7 @@ static void do_reads(struct mirror_set *ms, struct bi=
o_list *reads)
 		 * We can only read balance if the region is in sync.
 		 */
 		if (likely(region_in_sync(ms, region, 1)))
-			m =3D choose_mirror(ms, bio->bi_sector);
+			m =3D choose_mirror(ms, bio->bi_iter.bi_sector);
 		else if (m && atomic_read(&m->error_count))
 			m =3D NULL;
=20
@@ -630,7 +630,7 @@ static void do_write(struct mirror_set *ms, struct bi=
o *bio)
 	struct dm_io_request io_req =3D {
 		.bi_rw =3D WRITE | (bio->bi_rw & WRITE_FLUSH_FUA),
 		.mem.type =3D DM_IO_BVEC,
-		.mem.ptr.bvec =3D bio->bi_io_vec + bio->bi_idx,
+		.mem.ptr.bvec =3D bio->bi_io_vec + bio->bi_iter.bi_idx,
 		.notify.fn =3D write_callback,
 		.notify.context =3D bio,
 		.client =3D ms->io_client,
@@ -1181,7 +1181,7 @@ static int mirror_map(struct dm_target *ti, struct =
bio *bio)
 	 * The region is in-sync and we can perform reads directly.
 	 * Store enough information so we can retry if it fails.
 	 */
-	m =3D choose_mirror(ms, bio->bi_sector);
+	m =3D choose_mirror(ms, bio->bi_iter.bi_sector);
 	if (unlikely(!m))
 		return -EIO;
=20
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 69732e0..b929fd5 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -126,7 +126,8 @@ EXPORT_SYMBOL_GPL(dm_rh_region_to_sector);
=20
 region_t dm_rh_bio_to_region(struct dm_region_hash *rh, struct bio *bio)
 {
-	return dm_rh_sector_to_region(rh, bio->bi_sector - rh->target_begin);
+	return dm_rh_sector_to_region(rh, bio->bi_iter.bi_sector -
+				      rh->target_begin);
 }
 EXPORT_SYMBOL_GPL(dm_rh_bio_to_region);
=20
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index aec57d7..3ded8c7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1562,11 +1562,10 @@ static void remap_exception(struct dm_snapshot *s=
, struct dm_exception *e,
 			    struct bio *bio, chunk_t chunk)
 {
 	bio->bi_bdev =3D s->cow->bdev;
-	bio->bi_sector =3D chunk_to_sector(s->store,
-					 dm_chunk_number(e->new_chunk) +
-					 (chunk - e->old_chunk)) +
-					 (bio->bi_sector &
-					  s->store->chunk_mask);
+	bio->bi_iter.bi_sector =3D
+		chunk_to_sector(s->store, dm_chunk_number(e->new_chunk) +
+				(chunk - e->old_chunk)) +
+		(bio->bi_iter.bi_sector & s->store->chunk_mask);
 }
=20
 static int snapshot_map(struct dm_target *ti, struct bio *bio)
@@ -1584,7 +1583,7 @@ static int snapshot_map(struct dm_target *ti, struc=
t bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
=20
-	chunk =3D sector_to_chunk(s->store, bio->bi_sector);
+	chunk =3D sector_to_chunk(s->store, bio->bi_iter.bi_sector);
=20
 	/* Full snapshots are not usable */
 	/* To get here the table must be live so s->active is always set. */
@@ -1645,7 +1644,8 @@ static int snapshot_map(struct dm_target *ti, struc=
t bio *bio)
 		r =3D DM_MAPIO_SUBMITTED;
=20
 		if (!pe->started &&
-		    bio->bi_size =3D=3D (s->store->chunk_size << SECTOR_SHIFT)) {
+		    bio->bi_iter.bi_size =3D=3D
+		    (s->store->chunk_size << SECTOR_SHIFT)) {
 			pe->started =3D 1;
 			up_write(&s->lock);
 			start_full_bio(pe, bio);
@@ -1701,7 +1701,7 @@ static int snapshot_merge_map(struct dm_target *ti,=
 struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
=20
-	chunk =3D sector_to_chunk(s->store, bio->bi_sector);
+	chunk =3D sector_to_chunk(s->store, bio->bi_iter.bi_sector);
=20
 	down_write(&s->lock);
=20
@@ -2038,7 +2038,7 @@ static int do_origin(struct dm_dev *origin, struct =
bio *bio)
 	down_read(&_origins_lock);
 	o =3D __lookup_origin(origin->bdev);
 	if (o)
-		r =3D __origin_write(&o->snapshots, bio->bi_sector, bio);
+		r =3D __origin_write(&o->snapshots, bio->bi_iter.bi_sector, bio);
 	up_read(&_origins_lock);
=20
 	return r;
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 73c1712..d1600d2 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -259,13 +259,15 @@ static int stripe_map_range(struct stripe_c *sc, st=
ruct bio *bio,
 {
 	sector_t begin, end;
=20
-	stripe_map_range_sector(sc, bio->bi_sector, target_stripe, &begin);
+	stripe_map_range_sector(sc, bio->bi_iter.bi_sector,
+				target_stripe, &begin);
 	stripe_map_range_sector(sc, bio_end_sector(bio),
 				target_stripe, &end);
 	if (begin < end) {
 		bio->bi_bdev =3D sc->stripe[target_stripe].dev->bdev;
-		bio->bi_sector =3D begin + sc->stripe[target_stripe].physical_start;
-		bio->bi_size =3D to_bytes(end - begin);
+		bio->bi_iter.bi_sector =3D begin +
+			sc->stripe[target_stripe].physical_start;
+		bio->bi_iter.bi_size =3D to_bytes(end - begin);
 		return DM_MAPIO_REMAPPED;
 	} else {
 		/* The range doesn't map to the target stripe */
@@ -293,9 +295,10 @@ static int stripe_map(struct dm_target *ti, struct b=
io *bio)
 		return stripe_map_range(sc, bio, target_bio_nr);
 	}
=20
-	stripe_map_sector(sc, bio->bi_sector, &stripe, &bio->bi_sector);
+	stripe_map_sector(sc, bio->bi_iter.bi_sector,
+			  &stripe, &bio->bi_iter.bi_sector);
=20
-	bio->bi_sector +=3D sc->stripe[stripe].physical_start;
+	bio->bi_iter.bi_sector +=3D sc->stripe[stripe].physical_start;
 	bio->bi_bdev =3D sc->stripe[stripe].dev->bdev;
=20
 	return DM_MAPIO_REMAPPED;
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index ff9ac4b..09a688b 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -311,11 +311,11 @@ error:
 static int switch_map(struct dm_target *ti, struct bio *bio)
 {
 	struct switch_ctx *sctx =3D ti->private;
-	sector_t offset =3D dm_target_offset(ti, bio->bi_sector);
+	sector_t offset =3D dm_target_offset(ti, bio->bi_iter.bi_sector);
 	unsigned path_nr =3D switch_get_path_nr(sctx, offset);
=20
 	bio->bi_bdev =3D sctx->path_list[path_nr].dmdev->bdev;
-	bio->bi_sector =3D sctx->path_list[path_nr].start + offset;
+	bio->bi_iter.bi_sector =3D sctx->path_list[path_nr].start + offset;
=20
 	return DM_MAPIO_REMAPPED;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 2c0cf51..a654024 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -413,7 +413,7 @@ static bool block_size_is_power_of_two(struct pool *p=
ool)
 static dm_block_t get_bio_block(struct thin_c *tc, struct bio *bio)
 {
 	struct pool *pool =3D tc->pool;
-	sector_t block_nr =3D bio->bi_sector;
+	sector_t block_nr =3D bio->bi_iter.bi_sector;
=20
 	if (block_size_is_power_of_two(pool))
 		block_nr >>=3D pool->sectors_per_block_shift;
@@ -426,14 +426,15 @@ static dm_block_t get_bio_block(struct thin_c *tc, =
struct bio *bio)
 static void remap(struct thin_c *tc, struct bio *bio, dm_block_t block)
 {
 	struct pool *pool =3D tc->pool;
-	sector_t bi_sector =3D bio->bi_sector;
+	sector_t bi_sector =3D bio->bi_iter.bi_sector;
=20
 	bio->bi_bdev =3D tc->pool_dev->bdev;
 	if (block_size_is_power_of_two(pool))
-		bio->bi_sector =3D (block << pool->sectors_per_block_shift) |
-				(bi_sector & (pool->sectors_per_block - 1));
+		bio->bi_iter.bi_sector =3D
+			(block << pool->sectors_per_block_shift) |
+			(bi_sector & (pool->sectors_per_block - 1));
 	else
-		bio->bi_sector =3D (block * pool->sectors_per_block) +
+		bio->bi_iter.bi_sector =3D (block * pool->sectors_per_block) +
 				 sector_div(bi_sector, pool->sectors_per_block);
 }
=20
@@ -721,7 +722,8 @@ static void process_prepared(struct pool *pool, struc=
t list_head *head,
  */
 static int io_overlaps_block(struct pool *pool, struct bio *bio)
 {
-	return bio->bi_size =3D=3D (pool->sectors_per_block << SECTOR_SHIFT);
+	return bio->bi_iter.bi_size =3D=3D
+		(pool->sectors_per_block << SECTOR_SHIFT);
 }
=20
 static int io_overwrites_block(struct pool *pool, struct bio *bio)
@@ -1130,7 +1132,7 @@ static void process_shared_bio(struct thin_c *tc, s=
truct bio *bio,
 	if (bio_detain(pool, &key, bio, &cell))
 		return;
=20
-	if (bio_data_dir(bio) =3D=3D WRITE && bio->bi_size)
+	if (bio_data_dir(bio) =3D=3D WRITE && bio->bi_iter.bi_size)
 		break_sharing(tc, bio, block, &key, lookup_result, cell);
 	else {
 		struct dm_thin_endio_hook *h =3D dm_per_bio_data(bio, sizeof(struct dm=
_thin_endio_hook));
@@ -1153,7 +1155,7 @@ static void provision_block(struct thin_c *tc, stru=
ct bio *bio, dm_block_t block
 	/*
 	 * Remap empty bios (flushes) immediately, without provisioning.
 	 */
-	if (!bio->bi_size) {
+	if (!bio->bi_iter.bi_size) {
 		inc_all_io_entry(pool, bio);
 		cell_defer_no_holder(tc, cell);
=20
@@ -1253,7 +1255,7 @@ static void process_bio_read_only(struct thin_c *tc=
, struct bio *bio)
 	r =3D dm_thin_find_block(tc->td, block, 1, &lookup_result);
 	switch (r) {
 	case 0:
-		if (lookup_result.shared && (rw =3D=3D WRITE) && bio->bi_size)
+		if (lookup_result.shared && (rw =3D=3D WRITE) && bio->bi_iter.bi_size)
 			bio_io_error(bio);
 		else {
 			inc_all_io_entry(tc->pool, bio);
@@ -2867,7 +2869,7 @@ out_unlock:
=20
 static int thin_map(struct dm_target *ti, struct bio *bio)
 {
-	bio->bi_sector =3D dm_target_offset(ti, bio->bi_sector);
+	bio->bi_iter.bi_sector =3D dm_target_offset(ti, bio->bi_iter.bi_sector)=
;
=20
 	return thin_bio_map(ti, bio);
 }
diff --git a/drivers/md/dm-verity.c b/drivers/md/dm-verity.c
index 4b7941d..132b315 100644
--- a/drivers/md/dm-verity.c
+++ b/drivers/md/dm-verity.c
@@ -493,9 +493,9 @@ static int verity_map(struct dm_target *ti, struct bi=
o *bio)
 	struct dm_verity_io *io;
=20
 	bio->bi_bdev =3D v->data_dev->bdev;
-	bio->bi_sector =3D verity_map_sector(v, bio->bi_sector);
+	bio->bi_iter.bi_sector =3D verity_map_sector(v, bio->bi_iter.bi_sector)=
;
=20
-	if (((unsigned)bio->bi_sector | bio_sectors(bio)) &
+	if (((unsigned)bio->bi_iter.bi_sector | bio_sectors(bio)) &
 	    ((1 << (v->data_dev_block_bits - SECTOR_SHIFT)) - 1)) {
 		DMERR_LIMIT("unaligned io");
 		return -EIO;
@@ -514,8 +514,8 @@ static int verity_map(struct dm_target *ti, struct bi=
o *bio)
 	io->v =3D v;
 	io->orig_bi_end_io =3D bio->bi_end_io;
 	io->orig_bi_private =3D bio->bi_private;
-	io->block =3D bio->bi_sector >> (v->data_dev_block_bits - SECTOR_SHIFT)=
;
-	io->n_blocks =3D bio->bi_size >> v->data_dev_block_bits;
+	io->block =3D bio->bi_iter.bi_sector >> (v->data_dev_block_bits - SECTO=
R_SHIFT);
+	io->n_blocks =3D bio->bi_iter.bi_size >> v->data_dev_block_bits;
=20
 	bio->bi_end_io =3D verity_end_io;
 	bio->bi_private =3D io;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b3e26c7..e749bc4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -539,7 +539,7 @@ static void start_io_acct(struct dm_io *io)
 		atomic_inc_return(&md->pending[rw]));
=20
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_sector,
+		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
 				    bio_sectors(bio), false, 0, &io->stats_aux);
 }
=20
@@ -557,7 +557,7 @@ static void end_io_acct(struct dm_io *io)
 	part_stat_unlock();
=20
 	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_sector,
+		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
 				    bio_sectors(bio), true, duration, &io->stats_aux);
=20
 	/*
@@ -706,7 +706,7 @@ static void dec_pending(struct dm_io *io, int error)
 		if (io_error =3D=3D DM_ENDIO_REQUEUE)
 			return;
=20
-		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_size) {
+		if ((bio->bi_rw & REQ_FLUSH) && bio->bi_iter.bi_size) {
 			/*
 			 * Preflush done for flush with data, reissue
 			 * without REQ_FLUSH.
@@ -761,7 +761,7 @@ static void end_clone_bio(struct bio *clone, int erro=
r)
 	struct dm_rq_clone_bio_info *info =3D clone->bi_private;
 	struct dm_rq_target_io *tio =3D info->tio;
 	struct bio *bio =3D info->orig;
-	unsigned int nr_bytes =3D info->orig->bi_size;
+	unsigned int nr_bytes =3D info->orig->bi_iter.bi_size;
=20
 	bio_put(clone);
=20
@@ -1092,7 +1092,7 @@ static void __map_bio(struct dm_target_io *tio)
 	 * this io.
 	 */
 	atomic_inc(&tio->io->io_count);
-	sector =3D clone->bi_sector;
+	sector =3D clone->bi_iter.bi_sector;
 	r =3D ti->type->map(ti, clone);
 	if (r =3D=3D DM_MAPIO_REMAPPED) {
 		/* the bio has been remapped so dispatch it */
@@ -1124,13 +1124,13 @@ struct clone_info {
=20
 static void bio_setup_sector(struct bio *bio, sector_t sector, sector_t =
len)
 {
-	bio->bi_sector =3D sector;
-	bio->bi_size =3D to_bytes(len);
+	bio->bi_iter.bi_sector =3D sector;
+	bio->bi_iter.bi_size =3D to_bytes(len);
 }
=20
 static void bio_setup_bv(struct bio *bio, unsigned short idx, unsigned s=
hort bv_count)
 {
-	bio->bi_idx =3D idx;
+	bio->bi_iter.bi_idx =3D idx;
 	bio->bi_vcnt =3D idx + bv_count;
 	bio->bi_flags &=3D ~(1 << BIO_SEG_VALID);
 }
@@ -1166,7 +1166,7 @@ static void clone_split_bio(struct dm_target_io *ti=
o, struct bio *bio,
 	clone->bi_rw =3D bio->bi_rw;
 	clone->bi_vcnt =3D 1;
 	clone->bi_io_vec->bv_offset =3D offset;
-	clone->bi_io_vec->bv_len =3D clone->bi_size;
+	clone->bi_io_vec->bv_len =3D clone->bi_iter.bi_size;
 	clone->bi_flags |=3D 1 << BIO_CLONED;
=20
 	clone_bio_integrity(bio, clone, idx, len, offset, 1);
@@ -1186,7 +1186,8 @@ static void clone_bio(struct dm_target_io *tio, str=
uct bio *bio,
 	bio_setup_sector(clone, sector, len);
 	bio_setup_bv(clone, idx, bv_count);
=20
-	if (idx !=3D bio->bi_idx || clone->bi_size < bio->bi_size)
+	if (idx !=3D bio->bi_iter.bi_idx ||
+	    clone->bi_iter.bi_size < bio->bi_iter.bi_size)
 		trim =3D 1;
 	clone_bio_integrity(bio, clone, idx, len, 0, trim);
 }
@@ -1474,8 +1475,8 @@ static void __split_and_process_bio(struct mapped_d=
evice *md,
 	ci.io->bio =3D bio;
 	ci.io->md =3D md;
 	spin_lock_init(&ci.io->endio_lock);
-	ci.sector =3D bio->bi_sector;
-	ci.idx =3D bio->bi_idx;
+	ci.sector =3D bio->bi_iter.bi_sector;
+	ci.idx =3D bio->bi_iter.bi_idx;
=20
 	start_io_acct(ci.io);
=20
diff --git a/drivers/md/faulty.c b/drivers/md/faulty.c
index 3193aef..e8b4574 100644
--- a/drivers/md/faulty.c
+++ b/drivers/md/faulty.c
@@ -74,8 +74,8 @@ static void faulty_fail(struct bio *bio, int error)
 {
 	struct bio *b =3D bio->bi_private;
=20
-	b->bi_size =3D bio->bi_size;
-	b->bi_sector =3D bio->bi_sector;
+	b->bi_iter.bi_size =3D bio->bi_iter.bi_size;
+	b->bi_iter.bi_sector =3D bio->bi_iter.bi_sector;
=20
 	bio_put(bio);
=20
@@ -185,26 +185,31 @@ static void make_request(struct mddev *mddev, struc=
t bio *bio)
 			return;
 		}
=20
-		if (check_sector(conf, bio->bi_sector, bio_end_sector(bio), WRITE))
+		if (check_sector(conf, bio->bi_iter.bi_sector,
+				 bio_end_sector(bio), WRITE))
 			failit =3D 1;
 		if (check_mode(conf, WritePersistent)) {
-			add_sector(conf, bio->bi_sector, WritePersistent);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   WritePersistent);
 			failit =3D 1;
 		}
 		if (check_mode(conf, WriteTransient))
 			failit =3D 1;
 	} else {
 		/* read request */
-		if (check_sector(conf, bio->bi_sector, bio_end_sector(bio), READ))
+		if (check_sector(conf, bio->bi_iter.bi_sector,
+				 bio_end_sector(bio), READ))
 			failit =3D 1;
 		if (check_mode(conf, ReadTransient))
 			failit =3D 1;
 		if (check_mode(conf, ReadPersistent)) {
-			add_sector(conf, bio->bi_sector, ReadPersistent);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   ReadPersistent);
 			failit =3D 1;
 		}
 		if (check_mode(conf, ReadFixable)) {
-			add_sector(conf, bio->bi_sector, ReadFixable);
+			add_sector(conf, bio->bi_iter.bi_sector,
+				   ReadFixable);
 			failit =3D 1;
 		}
 	}
diff --git a/drivers/md/linear.c b/drivers/md/linear.c
index f03fabd..fb3b0d0 100644
--- a/drivers/md/linear.c
+++ b/drivers/md/linear.c
@@ -297,19 +297,19 @@ static void linear_make_request(struct mddev *mddev=
, struct bio *bio)
 	}
=20
 	rcu_read_lock();
-	tmp_dev =3D which_dev(mddev, bio->bi_sector);
+	tmp_dev =3D which_dev(mddev, bio->bi_iter.bi_sector);
 	start_sector =3D tmp_dev->end_sector - tmp_dev->rdev->sectors;
=20
=20
-	if (unlikely(bio->bi_sector >=3D (tmp_dev->end_sector)
-		     || (bio->bi_sector < start_sector))) {
+	if (unlikely(bio->bi_iter.bi_sector >=3D (tmp_dev->end_sector)
+		     || (bio->bi_iter.bi_sector < start_sector))) {
 		char b[BDEVNAME_SIZE];
=20
 		printk(KERN_ERR
 		       "md/linear:%s: make_request: Sector %llu out of bounds on "
 		       "dev %s: %llu sectors, offset %llu\n",
 		       mdname(mddev),
-		       (unsigned long long)bio->bi_sector,
+		       (unsigned long long)bio->bi_iter.bi_sector,
 		       bdevname(tmp_dev->rdev->bdev, b),
 		       (unsigned long long)tmp_dev->rdev->sectors,
 		       (unsigned long long)start_sector);
@@ -326,7 +326,7 @@ static void linear_make_request(struct mddev *mddev, =
struct bio *bio)
=20
 		rcu_read_unlock();
=20
-		bp =3D bio_split(bio, end_sector - bio->bi_sector);
+		bp =3D bio_split(bio, end_sector - bio->bi_iter.bi_sector);
=20
 		linear_make_request(mddev, &bp->bio1);
 		linear_make_request(mddev, &bp->bio2);
@@ -335,7 +335,7 @@ static void linear_make_request(struct mddev *mddev, =
struct bio *bio)
 	}
 		   =20
 	bio->bi_bdev =3D tmp_dev->rdev->bdev;
-	bio->bi_sector =3D bio->bi_sector - start_sector
+	bio->bi_iter.bi_sector =3D bio->bi_iter.bi_sector - start_sector
 		+ tmp_dev->rdev->data_offset;
 	rcu_read_unlock();
=20
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 251dca6..b9b372b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -393,7 +393,7 @@ static void md_submit_flush_data(struct work_struct *=
ws)
 	struct mddev *mddev =3D container_of(ws, struct mddev, flush_work);
 	struct bio *bio =3D mddev->flush_bio;
=20
-	if (bio->bi_size =3D=3D 0)
+	if (bio->bi_iter.bi_size =3D=3D 0)
 		/* an empty barrier - all done */
 		bio_endio(bio, 0);
 	else {
@@ -746,7 +746,7 @@ void md_super_write(struct mddev *mddev, struct md_rd=
ev *rdev,
 	struct bio *bio =3D bio_alloc_mddev(GFP_NOIO, 1, mddev);
=20
 	bio->bi_bdev =3D rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev;
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	bio_add_page(bio, page, size, 0);
 	bio->bi_private =3D rdev;
 	bio->bi_end_io =3D super_written;
@@ -785,13 +785,13 @@ int sync_page_io(struct md_rdev *rdev, sector_t sec=
tor, int size,
 	bio->bi_bdev =3D (metadata_op && rdev->meta_bdev) ?
 		rdev->meta_bdev : rdev->bdev;
 	if (metadata_op)
-		bio->bi_sector =3D sector + rdev->sb_start;
+		bio->bi_iter.bi_sector =3D sector + rdev->sb_start;
 	else if (rdev->mddev->reshape_position !=3D MaxSector &&
 		 (rdev->mddev->reshape_backwards =3D=3D
 		  (sector >=3D rdev->mddev->reshape_position)))
-		bio->bi_sector =3D sector + rdev->new_data_offset;
+		bio->bi_iter.bi_sector =3D sector + rdev->new_data_offset;
 	else
-		bio->bi_sector =3D sector + rdev->data_offset;
+		bio->bi_iter.bi_sector =3D sector + rdev->data_offset;
 	bio_add_page(bio, page, size, 0);
 	init_completion(&event);
 	bio->bi_private =3D &event;
diff --git a/drivers/md/multipath.c b/drivers/md/multipath.c
index 1642eae..849ad39 100644
--- a/drivers/md/multipath.c
+++ b/drivers/md/multipath.c
@@ -100,7 +100,7 @@ static void multipath_end_request(struct bio *bio, in=
t error)
 		md_error (mp_bh->mddev, rdev);
 		printk(KERN_ERR "multipath: %s: rescheduling sector %llu\n",=20
 		       bdevname(rdev->bdev,b),=20
-		       (unsigned long long)bio->bi_sector);
+		       (unsigned long long)bio->bi_iter.bi_sector);
 		multipath_reschedule_retry(mp_bh);
 	} else
 		multipath_end_bh_io(mp_bh, error);
@@ -132,7 +132,7 @@ static void multipath_make_request(struct mddev *mdde=
v, struct bio * bio)
 	multipath =3D conf->multipaths + mp_bh->path;
=20
 	mp_bh->bio =3D *bio;
-	mp_bh->bio.bi_sector +=3D multipath->rdev->data_offset;
+	mp_bh->bio.bi_iter.bi_sector +=3D multipath->rdev->data_offset;
 	mp_bh->bio.bi_bdev =3D multipath->rdev->bdev;
 	mp_bh->bio.bi_rw |=3D REQ_FAILFAST_TRANSPORT;
 	mp_bh->bio.bi_end_io =3D multipath_end_request;
@@ -355,21 +355,22 @@ static void multipathd(struct md_thread *thread)
 		spin_unlock_irqrestore(&conf->device_lock, flags);
=20
 		bio =3D &mp_bh->bio;
-		bio->bi_sector =3D mp_bh->master_bio->bi_sector;
+		bio->bi_iter.bi_sector =3D mp_bh->master_bio->bi_iter.bi_sector;
 	=09
 		if ((mp_bh->path =3D multipath_map (conf))<0) {
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
 			*bio =3D *(mp_bh->master_bio);
-			bio->bi_sector +=3D conf->multipaths[mp_bh->path].rdev->data_offset;
+			bio->bi_iter.bi_sector +=3D
+				conf->multipaths[mp_bh->path].rdev->data_offset;
 			bio->bi_bdev =3D conf->multipaths[mp_bh->path].rdev->bdev;
 			bio->bi_rw |=3D REQ_FAILFAST_TRANSPORT;
 			bio->bi_end_io =3D multipath_end_request;
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c4d420b..e38d1d3 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -501,10 +501,11 @@ static inline int is_io_in_chunk_boundary(struct md=
dev *mddev,
 			unsigned int chunk_sects, struct bio *bio)
 {
 	if (likely(is_power_of_2(chunk_sects))) {
-		return chunk_sects >=3D ((bio->bi_sector & (chunk_sects-1))
+		return chunk_sects >=3D
+			((bio->bi_iter.bi_sector & (chunk_sects-1))
 					+ bio_sectors(bio));
 	} else{
-		sector_t sector =3D bio->bi_sector;
+		sector_t sector =3D bio->bi_iter.bi_sector;
 		return chunk_sects >=3D (sector_div(sector, chunk_sects)
 						+ bio_sectors(bio));
 	}
@@ -524,7 +525,7 @@ static void raid0_make_request(struct mddev *mddev, s=
truct bio *bio)
=20
 	chunk_sects =3D mddev->chunk_sectors;
 	if (unlikely(!is_io_in_chunk_boundary(mddev, chunk_sects, bio))) {
-		sector_t sector =3D bio->bi_sector;
+		sector_t sector =3D bio->bi_iter.bi_sector;
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
 		if (bio_segments(bio) > 1)
@@ -544,12 +545,12 @@ static void raid0_make_request(struct mddev *mddev,=
 struct bio *bio)
 		return;
 	}
=20
-	sector_offset =3D bio->bi_sector;
+	sector_offset =3D bio->bi_iter.bi_sector;
 	zone =3D find_zone(mddev->private, &sector_offset);
-	tmp_dev =3D map_sector(mddev, zone, bio->bi_sector,
+	tmp_dev =3D map_sector(mddev, zone, bio->bi_iter.bi_sector,
 			     &sector_offset);
 	bio->bi_bdev =3D tmp_dev->bdev;
-	bio->bi_sector =3D sector_offset + zone->dev_start +
+	bio->bi_iter.bi_sector =3D sector_offset + zone->dev_start +
 		tmp_dev->data_offset;
=20
 	if (unlikely((bio->bi_rw & REQ_DISCARD) &&
@@ -566,7 +567,8 @@ bad_map:
 	printk("md/raid0:%s: make_request bug: can't convert block across chunk=
s"
 	       " or bigger than %dk %llu %d\n",
 	       mdname(mddev), chunk_sects / 2,
-	       (unsigned long long)bio->bi_sector, bio_sectors(bio) / 2);
+	       (unsigned long long)bio->bi_iter.bi_sector,
+	       bio_sectors(bio) / 2);
=20
 	bio_io_error(bio);
 	return;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index fc817ff..c40846e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -255,9 +255,8 @@ static void raid_end_bio_io(struct r1bio *r1_bio)
 	if (!test_and_set_bit(R1BIO_Returned, &r1_bio->state)) {
 		pr_debug("raid1: sync end %s on sectors %llu-%llu\n",
 			 (bio_data_dir(bio) =3D=3D WRITE) ? "write" : "read",
-			 (unsigned long long) bio->bi_sector,
-			 (unsigned long long) bio->bi_sector +
-			 bio_sectors(bio) - 1);
+			 (unsigned long long) bio->bi_iter.bi_sector,
+			 (unsigned long long) bio_end_sector(bio) - 1);
=20
 		call_bio_endio(r1_bio);
 	}
@@ -456,9 +455,8 @@ static void raid1_end_write_request(struct bio *bio, =
int error)
 				struct bio *mbio =3D r1_bio->master_bio;
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
=20
 struct raid1_plug_cb {
@@ -1024,7 +1023,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
=20
 	if (bio_data_dir(bio) =3D=3D WRITE &&
 	    bio_end_sector(bio) > mddev->suspend_lo &&
-	    bio->bi_sector < mddev->suspend_hi) {
+	    bio->bi_iter.bi_sector < mddev->suspend_hi) {
 		/* As the suspend_* range is controlled by
 		 * userspace, we want an interruptible
 		 * wait.
@@ -1035,7 +1034,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_INTERRUPTIBLE);
 			if (bio_end_sector(bio) <=3D mddev->suspend_lo ||
-			    bio->bi_sector >=3D mddev->suspend_hi)
+			    bio->bi_iter.bi_sector >=3D mddev->suspend_hi)
 				break;
 			schedule();
 		}
@@ -1057,7 +1056,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 	r1_bio->sectors =3D bio_sectors(bio);
 	r1_bio->state =3D 0;
 	r1_bio->mddev =3D mddev;
-	r1_bio->sector =3D bio->bi_sector;
+	r1_bio->sector =3D bio->bi_iter.bi_sector;
=20
 	/* We might need to issue multiple reads to different
 	 * devices if there are bad blocks around, so we keep
@@ -1097,12 +1096,13 @@ read_again:
 		r1_bio->read_disk =3D rdisk;
=20
 		read_bio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(read_bio, r1_bio->sector - bio->bi_sector,
+		bio_trim(read_bio, r1_bio->sector - bio->bi_iter.bi_sector,
 			 max_sectors);
=20
 		r1_bio->bios[rdisk] =3D read_bio;
=20
-		read_bio->bi_sector =3D r1_bio->sector + mirror->rdev->data_offset;
+		read_bio->bi_iter.bi_sector =3D r1_bio->sector +
+			mirror->rdev->data_offset;
 		read_bio->bi_bdev =3D mirror->rdev->bdev;
 		read_bio->bi_end_io =3D raid1_end_read_request;
 		read_bio->bi_rw =3D READ | do_sync;
@@ -1114,7 +1114,7 @@ read_again:
 			 */
=20
 			sectors_handled =3D (r1_bio->sector + max_sectors
-					   - bio->bi_sector);
+					   - bio->bi_iter.bi_sector);
 			r1_bio->sectors =3D max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (bio->bi_phys_segments =3D=3D 0)
@@ -1135,7 +1135,8 @@ read_again:
 			r1_bio->sectors =3D bio_sectors(bio) - sectors_handled;
 			r1_bio->state =3D 0;
 			r1_bio->mddev =3D mddev;
-			r1_bio->sector =3D bio->bi_sector + sectors_handled;
+			r1_bio->sector =3D bio->bi_iter.bi_sector +
+				sectors_handled;
 			goto read_again;
 		} else
 			generic_make_request(read_bio);
@@ -1254,7 +1255,7 @@ read_again:
 			bio->bi_phys_segments++;
 		spin_unlock_irq(&conf->device_lock);
 	}
-	sectors_handled =3D r1_bio->sector + max_sectors - bio->bi_sector;
+	sectors_handled =3D r1_bio->sector + max_sectors - bio->bi_iter.bi_sect=
or;
=20
 	atomic_set(&r1_bio->remaining, 1);
 	atomic_set(&r1_bio->behind_remaining, 0);
@@ -1266,7 +1267,7 @@ read_again:
 			continue;
=20
 		mbio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(mbio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(mbio, r1_bio->sector - bio->bi_iter.bi_sector, max_sectors);
=20
 		if (first_clone) {
 			/* do behind I/O ?
@@ -1300,7 +1301,7 @@ read_again:
=20
 		r1_bio->bios[i] =3D mbio;
=20
-		mbio->bi_sector	=3D (r1_bio->sector +
+		mbio->bi_iter.bi_sector	=3D (r1_bio->sector +
 				   conf->mirrors[i].rdev->data_offset);
 		mbio->bi_bdev =3D conf->mirrors[i].rdev->bdev;
 		mbio->bi_end_io	=3D raid1_end_write_request;
@@ -1340,7 +1341,7 @@ read_again:
 		r1_bio->sectors =3D bio_sectors(bio) - sectors_handled;
 		r1_bio->state =3D 0;
 		r1_bio->mddev =3D mddev;
-		r1_bio->sector =3D bio->bi_sector + sectors_handled;
+		r1_bio->sector =3D bio->bi_iter.bi_sector + sectors_handled;
 		goto retry_write;
 	}
=20
@@ -1860,14 +1861,14 @@ static int process_checks(struct r1bio *r1_bio)
 		/* fixup the bio for reuse */
 		bio_reset(b);
 		b->bi_vcnt =3D vcnt;
-		b->bi_size =3D r1_bio->sectors << 9;
-		b->bi_sector =3D r1_bio->sector +
+		b->bi_iter.bi_size =3D r1_bio->sectors << 9;
+		b->bi_iter.bi_sector =3D r1_bio->sector +
 			conf->mirrors[i].rdev->data_offset;
 		b->bi_bdev =3D conf->mirrors[i].rdev->bdev;
 		b->bi_end_io =3D end_sync_read;
 		b->bi_private =3D r1_bio;
=20
-		size =3D b->bi_size;
+		size =3D b->bi_iter.bi_size;
 		for (j =3D 0; j < vcnt ; j++) {
 			struct bio_vec *bi;
 			bi =3D &b->bi_io_vec[j];
@@ -2122,11 +2123,11 @@ static int narrow_write_error(struct r1bio *r1_bi=
o, int i)
 		}
=20
 		wbio->bi_rw =3D WRITE;
-		wbio->bi_sector =3D r1_bio->sector;
-		wbio->bi_size =3D r1_bio->sectors << 9;
+		wbio->bi_iter.bi_sector =3D r1_bio->sector;
+		wbio->bi_iter.bi_size =3D r1_bio->sectors << 9;
=20
 		bio_trim(wbio, sector - r1_bio->sector, sectors);
-		wbio->bi_sector +=3D rdev->data_offset;
+		wbio->bi_iter.bi_sector +=3D rdev->data_offset;
 		wbio->bi_bdev =3D rdev->bdev;
 		if (submit_bio_wait(WRITE, wbio) =3D=3D 0)
 			/* failure! */
@@ -2240,7 +2241,8 @@ read_more:
 		}
 		r1_bio->read_disk =3D disk;
 		bio =3D bio_clone_mddev(r1_bio->master_bio, GFP_NOIO, mddev);
-		bio_trim(bio, r1_bio->sector - bio->bi_sector, max_sectors);
+		bio_trim(bio, r1_bio->sector - bio->bi_iter.bi_sector,
+			 max_sectors);
 		r1_bio->bios[r1_bio->read_disk] =3D bio;
 		rdev =3D conf->mirrors[disk].rdev;
 		printk_ratelimited(KERN_ERR
@@ -2249,7 +2251,7 @@ read_more:
 				   mdname(mddev),
 				   (unsigned long long)r1_bio->sector,
 				   bdevname(rdev->bdev, b));
-		bio->bi_sector =3D r1_bio->sector + rdev->data_offset;
+		bio->bi_iter.bi_sector =3D r1_bio->sector + rdev->data_offset;
 		bio->bi_bdev =3D rdev->bdev;
 		bio->bi_end_io =3D raid1_end_read_request;
 		bio->bi_rw =3D READ | do_sync;
@@ -2258,7 +2260,7 @@ read_more:
 			/* Drat - have to split this up more */
 			struct bio *mbio =3D r1_bio->master_bio;
 			int sectors_handled =3D (r1_bio->sector + max_sectors
-					       - mbio->bi_sector);
+					       - mbio->bi_iter.bi_sector);
 			r1_bio->sectors =3D max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (mbio->bi_phys_segments =3D=3D 0)
@@ -2276,7 +2278,8 @@ read_more:
 			r1_bio->state =3D 0;
 			set_bit(R1BIO_ReadError, &r1_bio->state);
 			r1_bio->mddev =3D mddev;
-			r1_bio->sector =3D mbio->bi_sector + sectors_handled;
+			r1_bio->sector =3D mbio->bi_iter.bi_sector +
+				sectors_handled;
=20
 			goto read_more;
 		} else
@@ -2500,7 +2503,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr, int *skipp
 		}
 		if (bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
-			bio->bi_sector =3D sector_nr + rdev->data_offset;
+			bio->bi_iter.bi_sector =3D sector_nr + rdev->data_offset;
 			bio->bi_bdev =3D rdev->bdev;
 			bio->bi_private =3D r1_bio;
 		}
@@ -2600,7 +2603,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr, int *skipp
 							continue;
 						/* remove last page from this bio */
 						bio->bi_vcnt--;
-						bio->bi_size -=3D len;
+						bio->bi_iter.bi_size -=3D len;
 						bio->bi_flags &=3D ~(1<< BIO_SEG_VALID);
 					}
 					goto bio_full;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a582235..fca8887 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1182,7 +1182,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 	/* If this request crosses a chunk boundary, we need to
 	 * split it.  This will only happen for 1 PAGE (or less) requests.
 	 */
-	if (unlikely((bio->bi_sector & chunk_mask) + bio_sectors(bio)
+	if (unlikely((bio->bi_iter.bi_sector & chunk_mask) + bio_sectors(bio)
 		     > chunk_sects
 		     && (conf->geo.near_copies < conf->geo.raid_disks
 			 || conf->prev.near_copies < conf->prev.raid_disks))) {
@@ -1193,8 +1193,8 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
 		 */
-		bp =3D bio_split(bio,
-			       chunk_sects - (bio->bi_sector & (chunk_sects - 1)) );
+		bp =3D bio_split(bio, chunk_sects -
+			       (bio->bi_iter.bi_sector & (chunk_sects - 1)));
=20
 		/* Each of these 'make_request' calls will call 'wait_barrier'.
 		 * If the first succeeds but the second blocks due to the resync
@@ -1221,7 +1221,8 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 	bad_map:
 		printk("md/raid10:%s: make_request bug: can't convert block across chu=
nks"
 		       " or bigger than %dk %llu %d\n", mdname(mddev), chunk_sects/2,
-		       (unsigned long long)bio->bi_sector, bio_sectors(bio) / 2);
+		       (unsigned long long)bio->bi_iter.bi_sector,
+		       bio_sectors(bio) / 2);
=20
 		bio_io_error(bio);
 		return;
@@ -1238,24 +1239,25 @@ static void make_request(struct mddev *mddev, str=
uct bio * bio)
=20
 	sectors =3D bio_sectors(bio);
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
-			   conf->reshape_progress <=3D bio->bi_sector ||
-			   conf->reshape_progress >=3D bio->bi_sector + sectors);
+			   conf->reshape_progress <=3D bio->bi_iter.bi_sector ||
+			   conf->reshape_progress >=3D bio->bi_iter.bi_sector +
+			   sectors);
 		wait_barrier(conf);
 	}
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    bio_data_dir(bio) =3D=3D WRITE &&
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
 		mddev->reshape_position =3D conf->reshape_progress;
 		set_bit(MD_CHANGE_DEVS, &mddev->flags);
@@ -1273,7 +1275,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bio)
 	r10_bio->sectors =3D sectors;
=20
 	r10_bio->mddev =3D mddev;
-	r10_bio->sector =3D bio->bi_sector;
+	r10_bio->sector =3D bio->bi_iter.bi_sector;
 	r10_bio->state =3D 0;
=20
 	/* We might need to issue multiple reads to different
@@ -1302,13 +1304,13 @@ read_again:
 		slot =3D r10_bio->read_slot;
=20
 		read_bio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(read_bio, r10_bio->sector - bio->bi_sector,
+		bio_trim(read_bio, r10_bio->sector - bio->bi_iter.bi_sector,
 			 max_sectors);
=20
 		r10_bio->devs[slot].bio =3D read_bio;
 		r10_bio->devs[slot].rdev =3D rdev;
=20
-		read_bio->bi_sector =3D r10_bio->devs[slot].addr +
+		read_bio->bi_iter.bi_sector =3D r10_bio->devs[slot].addr +
 			choose_data_offset(r10_bio, rdev);
 		read_bio->bi_bdev =3D rdev->bdev;
 		read_bio->bi_end_io =3D raid10_end_read_request;
@@ -1320,7 +1322,7 @@ read_again:
 			 * need another r10_bio.
 			 */
 			sectors_handled =3D (r10_bio->sectors + max_sectors
-					   - bio->bi_sector);
+					   - bio->bi_iter.bi_sector);
 			r10_bio->sectors =3D max_sectors;
 			spin_lock_irq(&conf->device_lock);
 			if (bio->bi_phys_segments =3D=3D 0)
@@ -1341,7 +1343,8 @@ read_again:
 			r10_bio->sectors =3D bio_sectors(bio) - sectors_handled;
 			r10_bio->state =3D 0;
 			r10_bio->mddev =3D mddev;
-			r10_bio->sector =3D bio->bi_sector + sectors_handled;
+			r10_bio->sector =3D bio->bi_iter.bi_sector +
+				sectors_handled;
 			goto read_again;
 		} else
 			generic_make_request(read_bio);
@@ -1499,7 +1502,8 @@ retry_write:
 			bio->bi_phys_segments++;
 		spin_unlock_irq(&conf->device_lock);
 	}
-	sectors_handled =3D r10_bio->sector + max_sectors - bio->bi_sector;
+	sectors_handled =3D r10_bio->sector + max_sectors -
+		bio->bi_iter.bi_sector;
=20
 	atomic_set(&r10_bio->remaining, 1);
 	bitmap_startwrite(mddev->bitmap, r10_bio->sector, r10_bio->sectors, 0);
@@ -1510,11 +1514,11 @@ retry_write:
 		if (r10_bio->devs[i].bio) {
 			struct md_rdev *rdev =3D conf->mirrors[d].rdev;
 			mbio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-			bio_trim(mbio, r10_bio->sector - bio->bi_sector,
+			bio_trim(mbio, r10_bio->sector - bio->bi_iter.bi_sector,
 				 max_sectors);
 			r10_bio->devs[i].bio =3D mbio;
=20
-			mbio->bi_sector	=3D (r10_bio->devs[i].addr+
+			mbio->bi_iter.bi_sector	=3D (r10_bio->devs[i].addr+
 					   choose_data_offset(r10_bio,
 							      rdev));
 			mbio->bi_bdev =3D rdev->bdev;
@@ -1553,11 +1557,11 @@ retry_write:
 				rdev =3D conf->mirrors[d].rdev;
 			}
 			mbio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-			bio_trim(mbio, r10_bio->sector - bio->bi_sector,
+			bio_trim(mbio, r10_bio->sector - bio->bi_iter.bi_sector,
 				 max_sectors);
 			r10_bio->devs[i].repl_bio =3D mbio;
=20
-			mbio->bi_sector	=3D (r10_bio->devs[i].addr +
+			mbio->bi_iter.bi_sector	=3D (r10_bio->devs[i].addr +
 					   choose_data_offset(
 						   r10_bio, rdev));
 			mbio->bi_bdev =3D rdev->bdev;
@@ -1591,7 +1595,7 @@ retry_write:
 		r10_bio->sectors =3D bio_sectors(bio) - sectors_handled;
=20
 		r10_bio->mddev =3D mddev;
-		r10_bio->sector =3D bio->bi_sector + sectors_handled;
+		r10_bio->sector =3D bio->bi_iter.bi_sector + sectors_handled;
 		r10_bio->state =3D 0;
 		goto retry_write;
 	}
@@ -2123,10 +2127,10 @@ static void sync_request_write(struct mddev *mdde=
v, struct r10bio *r10_bio)
 		bio_reset(tbio);
=20
 		tbio->bi_vcnt =3D vcnt;
-		tbio->bi_size =3D r10_bio->sectors << 9;
+		tbio->bi_iter.bi_size =3D r10_bio->sectors << 9;
 		tbio->bi_rw =3D WRITE;
 		tbio->bi_private =3D r10_bio;
-		tbio->bi_sector =3D r10_bio->devs[i].addr;
+		tbio->bi_iter.bi_sector =3D r10_bio->devs[i].addr;
=20
 		for (j=3D0; j < vcnt ; j++) {
 			tbio->bi_io_vec[j].bv_offset =3D 0;
@@ -2143,7 +2147,7 @@ static void sync_request_write(struct mddev *mddev,=
 struct r10bio *r10_bio)
 		atomic_inc(&r10_bio->remaining);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
=20
-		tbio->bi_sector +=3D conf->mirrors[d].rdev->data_offset;
+		tbio->bi_iter.bi_sector +=3D conf->mirrors[d].rdev->data_offset;
 		tbio->bi_bdev =3D conf->mirrors[d].rdev->bdev;
 		generic_make_request(tbio);
 	}
@@ -2613,8 +2617,8 @@ static int narrow_write_error(struct r10bio *r10_bi=
o, int i)
 			sectors =3D sect_to_write;
 		/* Write at 'sector' for 'sectors' */
 		wbio =3D bio_clone_mddev(bio, GFP_NOIO, mddev);
-		bio_trim(wbio, sector - bio->bi_sector, sectors);
-		wbio->bi_sector =3D (r10_bio->devs[i].addr+
+		bio_trim(wbio, sector - bio->bi_iter.bi_sector, sectors);
+		wbio->bi_iter.bi_sector =3D (r10_bio->devs[i].addr+
 				   choose_data_offset(r10_bio, rdev) +
 				   (sector - r10_bio->sector));
 		wbio->bi_bdev =3D rdev->bdev;
@@ -2686,10 +2690,10 @@ read_more:
 		(unsigned long long)r10_bio->sector);
 	bio =3D bio_clone_mddev(r10_bio->master_bio,
 			      GFP_NOIO, mddev);
-	bio_trim(bio, r10_bio->sector - bio->bi_sector, max_sectors);
+	bio_trim(bio, r10_bio->sector - bio->bi_iter.bi_sector, max_sectors);
 	r10_bio->devs[slot].bio =3D bio;
 	r10_bio->devs[slot].rdev =3D rdev;
-	bio->bi_sector =3D r10_bio->devs[slot].addr
+	bio->bi_iter.bi_sector =3D r10_bio->devs[slot].addr
 		+ choose_data_offset(r10_bio, rdev);
 	bio->bi_bdev =3D rdev->bdev;
 	bio->bi_rw =3D READ | do_sync;
@@ -2700,7 +2704,7 @@ read_more:
 		struct bio *mbio =3D r10_bio->master_bio;
 		int sectors_handled =3D
 			r10_bio->sector + max_sectors
-			- mbio->bi_sector;
+			- mbio->bi_iter.bi_sector;
 		r10_bio->sectors =3D max_sectors;
 		spin_lock_irq(&conf->device_lock);
 		if (mbio->bi_phys_segments =3D=3D 0)
@@ -2718,7 +2722,7 @@ read_more:
 		set_bit(R10BIO_ReadError,
 			&r10_bio->state);
 		r10_bio->mddev =3D mddev;
-		r10_bio->sector =3D mbio->bi_sector
+		r10_bio->sector =3D mbio->bi_iter.bi_sector
 			+ sectors_handled;
=20
 		goto read_more;
@@ -3156,7 +3160,8 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 				bio->bi_end_io =3D end_sync_read;
 				bio->bi_rw =3D READ;
 				from_addr =3D r10_bio->devs[j].addr;
-				bio->bi_sector =3D from_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector =3D from_addr +
+					rdev->data_offset;
 				bio->bi_bdev =3D rdev->bdev;
 				atomic_inc(&rdev->nr_pending);
 				/* and we write to 'i' (if not in_sync) */
@@ -3180,7 +3185,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 					bio->bi_private =3D r10_bio;
 					bio->bi_end_io =3D end_sync_write;
 					bio->bi_rw =3D WRITE;
-					bio->bi_sector =3D to_addr
+					bio->bi_iter.bi_sector =3D to_addr
 						+ rdev->data_offset;
 					bio->bi_bdev =3D rdev->bdev;
 					atomic_inc(&r10_bio->remaining);
@@ -3209,7 +3214,8 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 				bio->bi_private =3D r10_bio;
 				bio->bi_end_io =3D end_sync_write;
 				bio->bi_rw =3D WRITE;
-				bio->bi_sector =3D to_addr + rdev->data_offset;
+				bio->bi_iter.bi_sector =3D to_addr +
+					rdev->data_offset;
 				bio->bi_bdev =3D rdev->bdev;
 				atomic_inc(&r10_bio->remaining);
 				break;
@@ -3327,7 +3333,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 			bio->bi_private =3D r10_bio;
 			bio->bi_end_io =3D end_sync_read;
 			bio->bi_rw =3D READ;
-			bio->bi_sector =3D sector +
+			bio->bi_iter.bi_sector =3D sector +
 				conf->mirrors[d].rdev->data_offset;
 			bio->bi_bdev =3D conf->mirrors[d].rdev->bdev;
 			count++;
@@ -3349,7 +3355,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 			bio->bi_private =3D r10_bio;
 			bio->bi_end_io =3D end_sync_write;
 			bio->bi_rw =3D WRITE;
-			bio->bi_sector =3D sector +
+			bio->bi_iter.bi_sector =3D sector +
 				conf->mirrors[d].replacement->data_offset;
 			bio->bi_bdev =3D conf->mirrors[d].replacement->bdev;
 			count++;
@@ -3396,7 +3402,7 @@ static sector_t sync_request(struct mddev *mddev, s=
ector_t sector_nr,
 			     bio2 =3D bio2->bi_next) {
 				/* remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -=3D len;
+				bio2->bi_iter.bi_size -=3D len;
 				bio2->bi_flags &=3D ~(1<< BIO_SEG_VALID);
 			}
 			goto bio_full;
@@ -4412,7 +4418,7 @@ read_more:
 	read_bio =3D bio_alloc_mddev(GFP_KERNEL, RESYNC_PAGES, mddev);
=20
 	read_bio->bi_bdev =3D rdev->bdev;
-	read_bio->bi_sector =3D (r10_bio->devs[r10_bio->read_slot].addr
+	read_bio->bi_iter.bi_sector =3D (r10_bio->devs[r10_bio->read_slot].addr
 			       + rdev->data_offset);
 	read_bio->bi_private =3D r10_bio;
 	read_bio->bi_end_io =3D end_sync_read;
@@ -4420,7 +4426,7 @@ read_more:
 	read_bio->bi_flags &=3D ~(BIO_POOL_MASK - 1);
 	read_bio->bi_flags |=3D 1 << BIO_UPTODATE;
 	read_bio->bi_vcnt =3D 0;
-	read_bio->bi_size =3D 0;
+	read_bio->bi_iter.bi_size =3D 0;
 	r10_bio->master_bio =3D read_bio;
 	r10_bio->read_slot =3D r10_bio->devs[r10_bio->read_slot].devnum;
=20
@@ -4446,7 +4452,8 @@ read_more:
=20
 		bio_reset(b);
 		b->bi_bdev =3D rdev2->bdev;
-		b->bi_sector =3D r10_bio->devs[s/2].addr + rdev2->new_data_offset;
+		b->bi_iter.bi_sector =3D r10_bio->devs[s/2].addr +
+			rdev2->new_data_offset;
 		b->bi_private =3D r10_bio;
 		b->bi_end_io =3D end_reshape_write;
 		b->bi_rw =3D WRITE;
@@ -4473,7 +4480,7 @@ read_more:
 			     bio2 =3D bio2->bi_next) {
 				/* Remove last page from this bio */
 				bio2->bi_vcnt--;
-				bio2->bi_size -=3D len;
+				bio2->bi_iter.bi_size -=3D len;
 				bio2->bi_flags &=3D ~(1<<BIO_SEG_VALID);
 			}
 			goto bio_full;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7ff4f25..6e0e4ea 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -97,7 +97,7 @@ static inline struct hlist_head *stripe_hash(struct r5c=
onf *conf, sector_t sect)
 static inline struct bio *r5_next_bio(struct bio *bio, sector_t sector)
 {
 	int sectors =3D bio_sectors(bio);
-	if (bio->bi_sector + sectors < sector + STRIPE_SECTORS)
+	if (bio->bi_iter.bi_sector + sectors < sector + STRIPE_SECTORS)
 		return bio->bi_next;
 	else
 		return NULL;
@@ -189,7 +189,7 @@ static void return_io(struct bio *return_bi)
=20
 		return_bi =3D bi->bi_next;
 		bi->bi_next =3D NULL;
-		bi->bi_size =3D 0;
+		bi->bi_iter.bi_size =3D 0;
 		trace_block_bio_complete(bdev_get_queue(bi->bi_bdev),
 					 bi, 0);
 		bio_endio(bi, 0);
@@ -766,10 +766,10 @@ static void ops_run_io(struct stripe_head *sh, stru=
ct stripe_head_state *s)
 				bi->bi_rw, i);
 			atomic_inc(&sh->count);
 			if (use_new_offset(conf, sh))
-				bi->bi_sector =3D (sh->sector
+				bi->bi_iter.bi_sector =3D (sh->sector
 						 + rdev->new_data_offset);
 			else
-				bi->bi_sector =3D (sh->sector
+				bi->bi_iter.bi_sector =3D (sh->sector
 						 + rdev->data_offset);
 			if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
 				bi->bi_rw |=3D REQ_FLUSH;
@@ -777,7 +777,7 @@ static void ops_run_io(struct stripe_head *sh, struct=
 stripe_head_state *s)
 			bi->bi_vcnt =3D 1;
 			bi->bi_io_vec[0].bv_len =3D STRIPE_SIZE;
 			bi->bi_io_vec[0].bv_offset =3D 0;
-			bi->bi_size =3D STRIPE_SIZE;
+			bi->bi_iter.bi_size =3D STRIPE_SIZE;
 			if (rrdev)
 				set_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags);
=20
@@ -807,15 +807,15 @@ static void ops_run_io(struct stripe_head *sh, stru=
ct stripe_head_state *s)
 				rbi->bi_rw, i);
 			atomic_inc(&sh->count);
 			if (use_new_offset(conf, sh))
-				rbi->bi_sector =3D (sh->sector
+				rbi->bi_iter.bi_sector =3D (sh->sector
 						  + rrdev->new_data_offset);
 			else
-				rbi->bi_sector =3D (sh->sector
+				rbi->bi_iter.bi_sector =3D (sh->sector
 						  + rrdev->data_offset);
 			rbi->bi_vcnt =3D 1;
 			rbi->bi_io_vec[0].bv_len =3D STRIPE_SIZE;
 			rbi->bi_io_vec[0].bv_offset =3D 0;
-			rbi->bi_size =3D STRIPE_SIZE;
+			rbi->bi_iter.bi_size =3D STRIPE_SIZE;
 			if (conf->mddev->gendisk)
 				trace_block_bio_remap(bdev_get_queue(rbi->bi_bdev),
 						      rbi, disk_devt(conf->mddev->gendisk),
@@ -844,10 +844,10 @@ async_copy_data(int frombio, struct bio *bio, struc=
t page *page,
 	struct async_submit_ctl submit;
 	enum async_tx_flags flags =3D 0;
=20
-	if (bio->bi_sector >=3D sector)
-		page_offset =3D (signed)(bio->bi_sector - sector) * 512;
+	if (bio->bi_iter.bi_sector >=3D sector)
+		page_offset =3D (signed)(bio->bi_iter.bi_sector - sector) * 512;
 	else
-		page_offset =3D (signed)(sector - bio->bi_sector) * -512;
+		page_offset =3D (signed)(sector - bio->bi_iter.bi_sector) * -512;
=20
 	if (frombio)
 		flags |=3D ASYNC_TX_FENCE;
@@ -914,7 +914,7 @@ static void ops_complete_biofill(void *stripe_head_re=
f)
 			BUG_ON(!dev->read);
 			rbi =3D dev->read;
 			dev->read =3D NULL;
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				rbi2 =3D r5_next_bio(rbi, dev->sector);
 				if (!raid5_dec_bi_active_stripes(rbi)) {
@@ -950,7 +950,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 			dev->read =3D rbi =3D dev->toread;
 			dev->toread =3D NULL;
 			spin_unlock_irq(&sh->stripe_lock);
-			while (rbi && rbi->bi_sector <
+			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				tx =3D async_copy_data(0, rbi, dev->page,
 					dev->sector, tx);
@@ -1292,7 +1292,7 @@ ops_run_biodrain(struct stripe_head *sh, struct dma=
_async_tx_descriptor *tx)
 			wbi =3D dev->written =3D chosen;
 			spin_unlock_irq(&sh->stripe_lock);
=20
-			while (wbi && wbi->bi_sector <
+			while (wbi && wbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				if (wbi->bi_rw & REQ_FUA)
 					set_bit(R5_WantFUA, &dev->flags);
@@ -2494,7 +2494,7 @@ static int add_stripe_bio(struct stripe_head *sh, s=
truct bio *bi, int dd_idx, in
 	int firstwrite=3D0;
=20
 	pr_debug("adding bi b#%llu to stripe s#%llu\n",
-		(unsigned long long)bi->bi_sector,
+		(unsigned long long)bi->bi_iter.bi_sector,
 		(unsigned long long)sh->sector);
=20
 	/*
@@ -2512,12 +2512,12 @@ static int add_stripe_bio(struct stripe_head *sh,=
 struct bio *bi, int dd_idx, in
 			firstwrite =3D 1;
 	} else
 		bip =3D &sh->dev[dd_idx].toread;
-	while (*bip && (*bip)->bi_sector < bi->bi_sector) {
-		if (bio_end_sector(*bip) > bi->bi_sector)
+	while (*bip && (*bip)->bi_iter.bi_sector < bi->bi_iter.bi_sector) {
+		if (bio_end_sector(*bip) > bi->bi_iter.bi_sector)
 			goto overlap;
 		bip =3D & (*bip)->bi_next;
 	}
-	if (*bip && (*bip)->bi_sector < bio_end_sector(bi))
+	if (*bip && (*bip)->bi_iter.bi_sector < bio_end_sector(bi))
 		goto overlap;
=20
 	BUG_ON(*bip && bi->bi_next && (*bip) !=3D bi->bi_next);
@@ -2531,7 +2531,7 @@ static int add_stripe_bio(struct stripe_head *sh, s=
truct bio *bi, int dd_idx, in
 		sector_t sector =3D sh->dev[dd_idx].sector;
 		for (bi=3Dsh->dev[dd_idx].towrite;
 		     sector < sh->dev[dd_idx].sector + STRIPE_SECTORS &&
-			     bi && bi->bi_sector <=3D sector;
+			     bi && bi->bi_iter.bi_sector <=3D sector;
 		     bi =3D r5_next_bio(bi, sh->dev[dd_idx].sector)) {
 			if (bio_end_sector(bi) >=3D sector)
 				sector =3D bio_end_sector(bi);
@@ -2541,7 +2541,7 @@ static int add_stripe_bio(struct stripe_head *sh, s=
truct bio *bi, int dd_idx, in
 	}
=20
 	pr_debug("added bi b#%llu to stripe s#%llu, disk %d.\n",
-		(unsigned long long)(*bip)->bi_sector,
+		(unsigned long long)(*bip)->bi_iter.bi_sector,
 		(unsigned long long)sh->sector, dd_idx);
 	spin_unlock_irq(&sh->stripe_lock);
=20
@@ -2616,7 +2616,7 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
 		if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 			wake_up(&conf->wait_for_overlap);
=20
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 			sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *nextbi =3D r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2635,7 +2635,7 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
 		bi =3D sh->dev[i].written;
 		sh->dev[i].written =3D NULL;
 		if (bi) bitmap_end =3D 1;
-		while (bi && bi->bi_sector <
+		while (bi && bi->bi_iter.bi_sector <
 		       sh->dev[i].sector + STRIPE_SECTORS) {
 			struct bio *bi2 =3D r5_next_bio(bi, sh->dev[i].sector);
 			clear_bit(BIO_UPTODATE, &bi->bi_flags);
@@ -2659,7 +2659,7 @@ handle_failed_stripe(struct r5conf *conf, struct st=
ripe_head *sh,
 			spin_unlock_irq(&sh->stripe_lock);
 			if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 				wake_up(&conf->wait_for_overlap);
-			while (bi && bi->bi_sector <
+			while (bi && bi->bi_iter.bi_sector <
 			       sh->dev[i].sector + STRIPE_SECTORS) {
 				struct bio *nextbi =3D
 					r5_next_bio(bi, sh->dev[i].sector);
@@ -2883,7 +2883,7 @@ static void handle_stripe_clean_event(struct r5conf=
 *conf,
 					clear_bit(R5_UPTODATE, &dev->flags);
 				wbi =3D dev->written;
 				dev->written =3D NULL;
-				while (wbi && wbi->bi_sector <
+				while (wbi && wbi->bi_iter.bi_sector <
 					dev->sector + STRIPE_SECTORS) {
 					wbi2 =3D r5_next_bio(wbi, dev->sector);
 					if (!raid5_dec_bi_active_stripes(wbi)) {
@@ -3964,7 +3964,7 @@ static int raid5_mergeable_bvec(struct request_queu=
e *q,
=20
 static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
 {
-	sector_t sector =3D bio->bi_sector + get_start_sect(bio->bi_bdev);
+	sector_t sector =3D bio->bi_iter.bi_sector + get_start_sect(bio->bi_bde=
v);
 	unsigned int chunk_sectors =3D mddev->chunk_sectors;
 	unsigned int bio_sectors =3D bio_sectors(bio);
=20
@@ -4101,9 +4101,9 @@ static int chunk_aligned_read(struct mddev *mddev, =
struct bio * raid_bio)
 	/*
 	 *	compute position
 	 */
-	align_bi->bi_sector =3D  raid5_compute_sector(conf, raid_bio->bi_sector=
,
-						    0,
-						    &dd_idx, NULL);
+	align_bi->bi_iter.bi_sector =3D
+		raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector,
+				     0, &dd_idx, NULL);
=20
 	end_sector =3D bio_end_sector(align_bi);
 	rcu_read_lock();
@@ -4128,7 +4128,8 @@ static int chunk_aligned_read(struct mddev *mddev, =
struct bio * raid_bio)
 		align_bi->bi_flags &=3D ~(1 << BIO_SEG_VALID);
=20
 		if (!bio_fits_rdev(align_bi) ||
-		    is_badblock(rdev, align_bi->bi_sector, bio_sectors(align_bi),
+		    is_badblock(rdev, align_bi->bi_iter.bi_sector,
+				bio_sectors(align_bi),
 				&first_bad, &bad_sectors)) {
 			/* too big in some way, or has a known bad block */
 			bio_put(align_bi);
@@ -4137,7 +4138,7 @@ static int chunk_aligned_read(struct mddev *mddev, =
struct bio * raid_bio)
 		}
=20
 		/* No reshape active, so we can trust rdev->data_offset */
-		align_bi->bi_sector +=3D rdev->data_offset;
+		align_bi->bi_iter.bi_sector +=3D rdev->data_offset;
=20
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,
@@ -4149,7 +4150,7 @@ static int chunk_aligned_read(struct mddev *mddev, =
struct bio * raid_bio)
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(align_bi->bi_bdev),
 					      align_bi, disk_devt(mddev->gendisk),
-					      raid_bio->bi_sector);
+					      raid_bio->bi_iter.bi_sector);
 		generic_make_request(align_bi);
 		return 1;
 	} else {
@@ -4323,8 +4324,8 @@ static void make_discard_request(struct mddev *mdde=
v, struct bio *bi)
 		/* Skip discard while reshape is happening */
 		return;
=20
-	logical_sector =3D bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
-	last_sector =3D bi->bi_sector + (bi->bi_size>>9);
+	logical_sector =3D bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1=
);
+	last_sector =3D bi->bi_iter.bi_sector + (bi->bi_iter.bi_size>>9);
=20
 	bi->bi_next =3D NULL;
 	bi->bi_phys_segments =3D 1; /* over-loaded to count active stripes */
@@ -4428,7 +4429,7 @@ static void make_request(struct mddev *mddev, struc=
t bio * bi)
 		return;
 	}
=20
-	logical_sector =3D bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector =3D bi->bi_iter.bi_sector & ~((sector_t)STRIPE_SECTORS-1=
);
 	last_sector =3D bio_end_sector(bi);
 	bi->bi_next =3D NULL;
 	bi->bi_phys_segments =3D 1;	/* over-loaded to count active stripes */
@@ -4901,7 +4902,8 @@ static int  retry_aligned_read(struct r5conf *conf,=
 struct bio *raid_bio)
 	int remaining;
 	int handled =3D 0;
=20
-	logical_sector =3D raid_bio->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	logical_sector =3D raid_bio->bi_iter.bi_sector &
+		~((sector_t)STRIPE_SECTORS-1);
 	sector =3D raid5_compute_sector(conf, logical_sector,
 				      0, &dd_idx, NULL);
 	last_sector =3D bio_end_sector(raid_bio);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 6eca019..16814a8 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -819,7 +819,8 @@ dcssblk_make_request(struct request_queue *q, struct =
bio *bio)
 	dev_info =3D bio->bi_bdev->bd_disk->private_data;
 	if (dev_info =3D=3D NULL)
 		goto fail;
-	if ((bio->bi_sector & 7) !=3D 0 || (bio->bi_size & 4095) !=3D 0)
+	if ((bio->bi_iter.bi_sector & 7) !=3D 0 ||
+	    (bio->bi_iter.bi_size & 4095) !=3D 0)
 		/* Request is not page-aligned. */
 		goto fail;
 	if (bio_end_sector(bio) > get_capacity(bio->bi_bdev->bd_disk)) {
@@ -842,7 +843,7 @@ dcssblk_make_request(struct request_queue *q, struct =
bio *bio)
 		}
 	}
=20
-	index =3D (bio->bi_sector >> 3);
+	index =3D (bio->bi_iter.bi_sector >> 3);
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr =3D (unsigned long)
 			page_address(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 464dd29..dd4e73f 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -190,15 +190,16 @@ static void xpram_make_request(struct request_queue=
 *q, struct bio *bio)
 	unsigned long bytes;
 	int i;
=20
-	if ((bio->bi_sector & 7) !=3D 0 || (bio->bi_size & 4095) !=3D 0)
+	if ((bio->bi_iter.bi_sector & 7) !=3D 0 ||
+	    (bio->bi_iter.bi_size & 4095) !=3D 0)
 		/* Request is not page-aligned. */
 		goto fail;
-	if ((bio->bi_size >> 12) > xdev->size)
+	if ((bio->bi_iter.bi_size >> 12) > xdev->size)
 		/* Request size is no page-aligned. */
 		goto fail;
-	if ((bio->bi_sector >> 3) > 0xffffffffU - xdev->offset)
+	if ((bio->bi_iter.bi_sector >> 3) > 0xffffffffU - xdev->offset)
 		goto fail;
-	index =3D (bio->bi_sector >> 3) + xdev->offset;
+	index =3D (bio->bi_iter.bi_sector >> 3) + xdev->offset;
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr =3D (unsigned long)
 			kmap(bvec->bv_page) + bvec->bv_offset;
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_init=
iator.c
index aa66361..bac04c2 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -731,7 +731,7 @@ static int _osd_req_list_objects(struct osd_request *=
or,
=20
 	bio->bi_rw &=3D ~REQ_WRITE;
 	or->in.bio =3D bio;
-	or->in.total_bytes =3D bio->bi_size;
+	or->in.total_bytes =3D bio->bi_iter.bi_size;
 	return 0;
 }
=20
diff --git a/drivers/staging/lustre/lustre/llite/lloop.c b/drivers/stagin=
g/lustre/lustre/llite/lloop.c
index 2340458..5b8c8c2 100644
--- a/drivers/staging/lustre/lustre/llite/lloop.c
+++ b/drivers/staging/lustre/lustre/llite/lloop.c
@@ -220,7 +220,7 @@ static int do_bio_lustrebacked(struct lloop_device *l=
o, struct bio *head)
 	for (bio =3D head; bio !=3D NULL; bio =3D bio->bi_next) {
 		LASSERT(rw =3D=3D bio->bi_rw);
=20
-		offset =3D (pgoff_t)(bio->bi_sector << 9) + lo->lo_offset;
+		offset =3D (pgoff_t)(bio->bi_iter.bi_sector << 9) + lo->lo_offset;
 		bio_for_each_segment(bvec, bio, i) {
 			BUG_ON(bvec->bv_offset !=3D 0);
 			BUG_ON(bvec->bv_len !=3D PAGE_CACHE_SIZE);
@@ -313,7 +313,8 @@ static unsigned int loop_get_bio(struct lloop_device =
*lo, struct bio **req)
 	bio =3D &lo->lo_bio;
 	while (*bio && (*bio)->bi_rw =3D=3D rw) {
 		CDEBUG(D_INFO, "bio sector %llu size %u count %u vcnt%u \n",
-		       (unsigned long long)(*bio)->bi_sector, (*bio)->bi_size,
+		       (unsigned long long)(*bio)->bi_iter.bi_sector,
+		       (*bio)->bi_iter.bi_size,
 		       page_count, (*bio)->bi_vcnt);
 		if (page_count + (*bio)->bi_vcnt > LLOOP_MAX_SEGMENTS)
 			break;
@@ -348,7 +349,8 @@ loop_make_request(struct request_queue *q, struct bio=
 *old_bio)
 		goto err;
=20
 	CDEBUG(D_INFO, "submit bio sector %llu size %u\n",
-	       (unsigned long long)old_bio->bi_sector, old_bio->bi_size);
+	       (unsigned long long)old_bio->bi_iter.bi_sector,
+	       old_bio->bi_iter.bi_size);
=20
 	spin_lock_irq(&lo->lo_lock);
 	inactive =3D (lo->lo_state !=3D LLOOP_BOUND);
@@ -368,7 +370,7 @@ loop_make_request(struct request_queue *q, struct bio=
 *old_bio)
 	loop_add_bio(lo, old_bio);
 	LL_MRF_RETURN(0);
 err:
-	cfs_bio_io_error(old_bio, old_bio->bi_size);
+	cfs_bio_io_error(old_bio, old_bio->bi_iter.bi_size);
 	LL_MRF_RETURN(0);
 }
=20
@@ -380,7 +382,7 @@ static inline void loop_handle_bio(struct lloop_devic=
e *lo, struct bio *bio)
 	while (bio) {
 		struct bio *tmp =3D bio->bi_next;
 		bio->bi_next =3D NULL;
-		cfs_bio_endio(bio, bio->bi_size, ret);
+		cfs_bio_endio(bio, bio->bi_iter.bi_size, ret);
 		bio =3D tmp;
 	}
 }
diff --git a/drivers/staging/zram/zram_drv.c b/drivers/staging/zram/zram_=
drv.c
index 2c4ed52..7b4255b 100644
--- a/drivers/staging/zram/zram_drv.c
+++ b/drivers/staging/zram/zram_drv.c
@@ -171,13 +171,14 @@ static inline int valid_io_request(struct zram *zra=
m, struct bio *bio)
 	u64 start, end, bound;
=20
 	/* unaligned request */
-	if (unlikely(bio->bi_sector & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
+	if (unlikely(bio->bi_iter.bi_sector &
+		     (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
 		return 0;
-	if (unlikely(bio->bi_size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
+	if (unlikely(bio->bi_iter.bi_size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
 		return 0;
=20
-	start =3D bio->bi_sector;
-	end =3D start + (bio->bi_size >> SECTOR_SHIFT);
+	start =3D bio->bi_iter.bi_sector;
+	end =3D start + (bio->bi_iter.bi_size >> SECTOR_SHIFT);
 	bound =3D zram->disksize >> SECTOR_SHIFT;
 	/* out of range range */
 	if (unlikely(start >=3D bound || end > bound || start > end))
@@ -682,8 +683,9 @@ static void __zram_make_request(struct zram *zram, st=
ruct bio *bio, int rw)
 		break;
 	}
=20
-	index =3D bio->bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	offset =3D (bio->bi_sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
+	index =3D bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+	offset =3D (bio->bi_iter.bi_sector &
+		  (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
=20
 	bio_for_each_segment(bvec, bio, i) {
 		int max_transfer_size =3D PAGE_SIZE - offset;
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_=
core_iblock.c
index b9a3394..4e89aa0 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -319,7 +319,7 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 =
sg_num)
 	bio->bi_bdev =3D ib_dev->ibd_bd;
 	bio->bi_private =3D cmd;
 	bio->bi_end_io =3D &iblock_bio_done;
-	bio->bi_sector =3D lba;
+	bio->bi_iter.bi_sector =3D lba;
=20
 	return bio;
 }
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index fc60b31..08e3d13 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -215,9 +215,9 @@ unsigned int bio_integrity_tag_size(struct bio *bio)
 {
 	struct blk_integrity *bi =3D bdev_get_integrity(bio->bi_bdev);
=20
-	BUG_ON(bio->bi_size =3D=3D 0);
+	BUG_ON(bio->bi_iter.bi_size =3D=3D 0);
=20
-	return bi->tag_size * (bio->bi_size / bi->sector_size);
+	return bi->tag_size * (bio->bi_iter.bi_size / bi->sector_size);
 }
 EXPORT_SYMBOL(bio_integrity_tag_size);
=20
@@ -300,7 +300,7 @@ static void bio_integrity_generate(struct bio *bio)
 	struct blk_integrity *bi =3D bdev_get_integrity(bio->bi_bdev);
 	struct blk_integrity_exchg bix;
 	struct bio_vec *bv;
-	sector_t sector =3D bio->bi_sector;
+	sector_t sector =3D bio->bi_iter.bi_sector;
 	unsigned int i, sectors, total;
 	void *prot_buf =3D bio->bi_integrity->bip_buf;
=20
@@ -387,7 +387,7 @@ int bio_integrity_prep(struct bio *bio)
 	bip->bip_owns_buf =3D 1;
 	bip->bip_buf =3D buf;
 	bip->bip_size =3D len;
-	bip->bip_sector =3D bio->bi_sector;
+	bip->bip_sector =3D bio->bi_iter.bi_sector;
=20
 	/* Map it */
 	offset =3D offset_in_page(buf);
diff --git a/fs/bio.c b/fs/bio.c
index 2bdb4e2..77ab430 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -532,13 +532,13 @@ void __bio_clone(struct bio *bio, struct bio *bio_s=
rc)
 	 * most users will be overriding ->bi_bdev with a new target,
 	 * so we don't set nor calculate new physical/hw segment counts here
 	 */
-	bio->bi_sector =3D bio_src->bi_sector;
+	bio->bi_iter.bi_sector =3D bio_src->bi_iter.bi_sector;
 	bio->bi_bdev =3D bio_src->bi_bdev;
 	bio->bi_flags |=3D 1 << BIO_CLONED;
 	bio->bi_rw =3D bio_src->bi_rw;
 	bio->bi_vcnt =3D bio_src->bi_vcnt;
-	bio->bi_size =3D bio_src->bi_size;
-	bio->bi_idx =3D bio_src->bi_idx;
+	bio->bi_iter.bi_size =3D bio_src->bi_iter.bi_size;
+	bio->bi_iter.bi_idx =3D bio_src->bi_iter.bi_idx;
 }
 EXPORT_SYMBOL(__bio_clone);
=20
@@ -612,7 +612,7 @@ static int __bio_add_page(struct request_queue *q, st=
ruct bio *bio, struct page
 	if (unlikely(bio_flagged(bio, BIO_CLONED)))
 		return 0;
=20
-	if (((bio->bi_size + len) >> 9) > max_sectors)
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
=20
 	/*
@@ -635,8 +635,9 @@ static int __bio_add_page(struct request_queue *q, st=
ruct bio *bio, struct page
 					   simulate merging updated prev_bvec
 					   as new bvec. */
 					.bi_bdev =3D bio->bi_bdev,
-					.bi_sector =3D bio->bi_sector,
-					.bi_size =3D bio->bi_size - prev_bv_len,
+					.bi_sector =3D bio->bi_iter.bi_sector,
+					.bi_size =3D bio->bi_iter.bi_size -
+						prev_bv_len,
 					.bi_rw =3D bio->bi_rw,
 				};
=20
@@ -684,8 +685,8 @@ static int __bio_add_page(struct request_queue *q, st=
ruct bio *bio, struct page
 	if (q->merge_bvec_fn) {
 		struct bvec_merge_data bvm =3D {
 			.bi_bdev =3D bio->bi_bdev,
-			.bi_sector =3D bio->bi_sector,
-			.bi_size =3D bio->bi_size,
+			.bi_sector =3D bio->bi_iter.bi_sector,
+			.bi_size =3D bio->bi_iter.bi_size,
 			.bi_rw =3D bio->bi_rw,
 		};
=20
@@ -708,7 +709,7 @@ static int __bio_add_page(struct request_queue *q, st=
ruct bio *bio, struct page
 	bio->bi_vcnt++;
 	bio->bi_phys_segments++;
  done:
-	bio->bi_size +=3D len;
+	bio->bi_iter.bi_size +=3D len;
 	return len;
 }
=20
@@ -807,22 +808,22 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
=20
-	bio->bi_sector +=3D bytes >> 9;
-	bio->bi_size -=3D bytes;
+	bio->bi_iter.bi_sector +=3D bytes >> 9;
+	bio->bi_iter.bi_size -=3D bytes;
=20
 	if (bio->bi_rw & BIO_NO_ADVANCE_ITER_MASK)
 		return;
=20
 	while (bytes) {
-		if (unlikely(bio->bi_idx >=3D bio->bi_vcnt)) {
+		if (unlikely(bio->bi_iter.bi_idx >=3D bio->bi_vcnt)) {
 			WARN_ONCE(1, "bio idx %d >=3D vcnt %d\n",
-				  bio->bi_idx, bio->bi_vcnt);
+				  bio->bi_iter.bi_idx, bio->bi_vcnt);
 			break;
 		}
=20
 		if (bytes >=3D bio_iovec(bio)->bv_len) {
 			bytes -=3D bio_iovec(bio)->bv_len;
-			bio->bi_idx++;
+			bio->bi_iter.bi_idx++;
 		} else {
 			bio_iovec(bio)->bv_len -=3D bytes;
 			bio_iovec(bio)->bv_offset +=3D bytes;
@@ -1485,7 +1486,7 @@ struct bio *bio_map_kern(struct request_queue *q, v=
oid *data, unsigned int len,
 	if (IS_ERR(bio))
 		return bio;
=20
-	if (bio->bi_size =3D=3D len)
+	if (bio->bi_iter.bi_size =3D=3D len)
 		return bio;
=20
 	/*
@@ -1763,16 +1764,16 @@ struct bio_pair *bio_split(struct bio *bi, int fi=
rst_sectors)
 		return bp;
=20
 	trace_block_split(bdev_get_queue(bi->bi_bdev), bi,
-				bi->bi_sector + first_sectors);
+				bi->bi_iter.bi_sector + first_sectors);
=20
 	BUG_ON(bio_segments(bi) > 1);
 	atomic_set(&bp->cnt, 3);
 	bp->error =3D 0;
 	bp->bio1 =3D *bi;
 	bp->bio2 =3D *bi;
-	bp->bio2.bi_sector +=3D first_sectors;
-	bp->bio2.bi_size -=3D first_sectors << 9;
-	bp->bio1.bi_size =3D first_sectors << 9;
+	bp->bio2.bi_iter.bi_sector +=3D first_sectors;
+	bp->bio2.bi_iter.bi_size -=3D first_sectors << 9;
+	bp->bio1.bi_iter.bi_size =3D first_sectors << 9;
=20
 	if (bi->bi_vcnt !=3D 0) {
 		bp->bv1 =3D *bio_iovec(bi);
@@ -1821,21 +1822,22 @@ void bio_trim(struct bio *bio, int offset, int si=
ze)
 	int sofar =3D 0;
=20
 	size <<=3D 9;
-	if (offset =3D=3D 0 && size =3D=3D bio->bi_size)
+	if (offset =3D=3D 0 && size =3D=3D bio->bi_iter.bi_size)
 		return;
=20
 	clear_bit(BIO_SEG_VALID, &bio->bi_flags);
=20
 	bio_advance(bio, offset << 9);
=20
-	bio->bi_size =3D size;
+	bio->bi_iter.bi_size =3D size;
=20
 	/* avoid any complications with bi_idx being non-zero*/
-	if (bio->bi_idx) {
-		memmove(bio->bi_io_vec, bio->bi_io_vec+bio->bi_idx,
-			(bio->bi_vcnt - bio->bi_idx) * sizeof(struct bio_vec));
-		bio->bi_vcnt -=3D bio->bi_idx;
-		bio->bi_idx =3D 0;
+	if (bio->bi_iter.bi_idx) {
+		memmove(bio->bi_io_vec, bio->bi_io_vec+bio->bi_iter.bi_idx,
+			(bio->bi_vcnt - bio->bi_iter.bi_idx) *
+			sizeof(struct bio_vec));
+		bio->bi_vcnt -=3D bio->bi_iter.bi_idx;
+		bio->bi_iter.bi_idx =3D 0;
 	}
 	/* Make sure vcnt and last bv are not too big */
 	bio_for_each_segment(bvec, bio, i) {
@@ -1871,7 +1873,7 @@ sector_t bio_sector_offset(struct bio *bio, unsigne=
d short index,
 	sector_sz =3D queue_logical_block_size(bio->bi_bdev->bd_disk->queue);
 	sectors =3D 0;
=20
-	if (index >=3D bio->bi_idx)
+	if (index >=3D bio->bi_iter.bi_idx)
 		index =3D bio->bi_vcnt - 1;
=20
 	bio_for_each_segment_all(bv, bio, i) {
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 1c47be1..7fcac70 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1687,7 +1687,7 @@ static int btrfsic_read_block(struct btrfsic_state =
*state,
 			return -1;
 		}
 		bio->bi_bdev =3D block_ctx->dev->bdev;
-		bio->bi_sector =3D dev_bytenr >> 9;
+		bio->bi_iter.bi_sector =3D dev_bytenr >> 9;
 		bio->bi_end_io =3D btrfsic_complete_bio_end_io;
 		bio->bi_private =3D &complete;
=20
@@ -3020,7 +3020,7 @@ void btrfsic_submit_bio(int rw, struct bio *bio)
 		int bio_is_patched;
 		char **mapped_datav;
=20
-		dev_bytenr =3D 512 * bio->bi_sector;
+		dev_bytenr =3D 512 * bio->bi_iter.bi_sector;
 		bio_is_patched =3D 0;
 		if (dev_state->state->print_mask &
 		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
@@ -3028,8 +3028,8 @@ void btrfsic_submit_bio(int rw, struct bio *bio)
 			       "submit_bio(rw=3D0x%x, bi_vcnt=3D%u,"
 			       " bi_sector=3D%llu (bytenr %llu), bi_bdev=3D%p)\n",
 			       rw, bio->bi_vcnt,
-			       (unsigned long long)bio->bi_sector, dev_bytenr,
-			       bio->bi_bdev);
+			       (unsigned long long)bio->bi_iter.bi_sector,
+			       dev_bytenr, bio->bi_bdev);
=20
 		mapped_datav =3D kmalloc(sizeof(*mapped_datav) * bio->bi_vcnt,
 				       GFP_NOFS);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6aad98c..06ab821 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -173,7 +173,8 @@ static void end_compressed_bio_read(struct bio *bio, =
int err)
 		goto out;
=20
 	inode =3D cb->inode;
-	ret =3D check_compressed_csum(inode, cb, (u64)bio->bi_sector << 9);
+	ret =3D check_compressed_csum(inode, cb,
+				    (u64)bio->bi_iter.bi_sector << 9);
 	if (ret)
 		goto csum_failed;
=20
@@ -373,7 +374,7 @@ int btrfs_submit_compressed_write(struct inode *inode=
, u64 start,
 	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {
 		page =3D compressed_pages[pg_index];
 		page->mapping =3D inode->i_mapping;
-		if (bio->bi_size)
+		if (bio->bi_iter.bi_size)
 			ret =3D io_tree->ops->merge_bio_hook(WRITE, page, 0,
 							   PAGE_CACHE_SIZE,
 							   bio, 0);
@@ -507,7 +508,7 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
=20
 		if (!em || last_offset < em->start ||
 		    (last_offset + PAGE_CACHE_SIZE > extent_map_end(em)) ||
-		    (em->block_start >> 9) !=3D cb->orig_bio->bi_sector) {
+		    (em->block_start >> 9) !=3D cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, last_offset, end);
 			unlock_page(page);
@@ -553,7 +554,7 @@ next:
  * in it.  We don't actually do IO on those pages but allocate new ones
  * to hold the compressed pages on disk.
  *
- * bio->bi_sector points to the compressed extent on disk
+ * bio->bi_iter.bi_sector points to the compressed extent on disk
  * bio->bi_io_vec points to all of the inode pages
  * bio->bi_vcnt is a count of pages
  *
@@ -574,7 +575,7 @@ int btrfs_submit_compressed_read(struct inode *inode,=
 struct bio *bio,
 	struct page *page;
 	struct block_device *bdev;
 	struct bio *comp_bio;
-	u64 cur_disk_byte =3D (u64)bio->bi_sector << 9;
+	u64 cur_disk_byte =3D (u64)bio->bi_iter.bi_sector << 9;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -660,7 +661,7 @@ int btrfs_submit_compressed_read(struct inode *inode,=
 struct bio *bio,
 		page->mapping =3D inode->i_mapping;
 		page->index =3D em_start >> PAGE_CACHE_SHIFT;
=20
-		if (comp_bio->bi_size)
+		if (comp_bio->bi_iter.bi_size)
 			ret =3D tree->ops->merge_bio_hook(READ, page, 0,
 							PAGE_CACHE_SIZE,
 							comp_bio, 0);
@@ -688,8 +689,8 @@ int btrfs_submit_compressed_read(struct inode *inode,=
 struct bio *bio,
 							comp_bio, sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
-			sums +=3D (comp_bio->bi_size + root->sectorsize - 1) /
-				root->sectorsize;
+			sums +=3D (comp_bio->bi_iter.bi_size +
+				 root->sectorsize - 1) / root->sectorsize;
=20
 			ret =3D btrfs_map_bio(root, READ, comp_bio,
 					    mirror_num, 0);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 51731b7..0df176a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1994,7 +1994,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info=
, u64 start,
 		return -EIO;
 	bio->bi_private =3D &compl;
 	bio->bi_end_io =3D repair_io_failure_callback;
-	bio->bi_size =3D 0;
+	bio->bi_iter.bi_size =3D 0;
 	map_length =3D length;
=20
 	ret =3D btrfs_map_block(fs_info, WRITE, logical,
@@ -2005,7 +2005,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info=
, u64 start,
 	}
 	BUG_ON(mirror_num !=3D bbio->mirror_num);
 	sector =3D bbio->stripes[mirror_num-1].physical >> 9;
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	dev =3D bbio->stripes[mirror_num-1].dev;
 	kfree(bbio);
 	if (!dev || !dev->bdev || !dev->writeable) {
@@ -2276,9 +2276,9 @@ static int bio_readpage_error(struct bio *failed_bi=
o, u64 phy_offset,
 		return -EIO;
 	}
 	bio->bi_end_io =3D failed_bio->bi_end_io;
-	bio->bi_sector =3D failrec->logical >> 9;
+	bio->bi_iter.bi_sector =3D failrec->logical >> 9;
 	bio->bi_bdev =3D BTRFS_I(inode)->root->fs_info->fs_devices->latest_bdev=
;
-	bio->bi_size =3D 0;
+	bio->bi_iter.bi_size =3D 0;
=20
 	btrfs_failed_bio =3D btrfs_io_bio(failed_bio);
 	if (btrfs_failed_bio->csum) {
@@ -2422,7 +2422,7 @@ static void end_bio_extent_readpage(struct bio *bio=
, int err)
 		struct inode *inode =3D page->mapping->host;
=20
 		pr_debug("end_bio_extent_readpage: bi_sector=3D%llu, err=3D%d, "
-			 "mirror=3D%lu\n", (u64)bio->bi_sector, err,
+			 "mirror=3D%lu\n", (u64)bio->bi_iter.bi_sector, err,
 			 io_bio->mirror_num);
 		tree =3D &BTRFS_I(inode)->io_tree;
=20
@@ -2555,9 +2555,9 @@ btrfs_bio_alloc(struct block_device *bdev, u64 firs=
t_sector, int nr_vecs,
 	}
=20
 	if (bio) {
-		bio->bi_size =3D 0;
+		bio->bi_iter.bi_size =3D 0;
 		bio->bi_bdev =3D bdev;
-		bio->bi_sector =3D first_sector;
+		bio->bi_iter.bi_sector =3D first_sector;
 		btrfs_bio =3D btrfs_io_bio(bio);
 		btrfs_bio->csum =3D NULL;
 		btrfs_bio->csum_allocated =3D NULL;
@@ -2651,7 +2651,7 @@ static int submit_extent_page(int rw, struct extent=
_io_tree *tree,
 	if (bio_ret && *bio_ret) {
 		bio =3D *bio_ret;
 		if (old_compressed)
-			contig =3D bio->bi_sector =3D=3D sector;
+			contig =3D bio->bi_iter.bi_sector =3D=3D sector;
 		else
 			contig =3D bio_end_sector(bio) =3D=3D sector;
=20
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4f53159..997f951 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -182,7 +182,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root =
*root,
 	if (!path)
 		return -ENOMEM;
=20
-	nblocks =3D bio->bi_size >> inode->i_sb->s_blocksize_bits;
+	nblocks =3D bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
 	if (!dst) {
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum_allocated =3D kmalloc(nblocks * csum_size,
@@ -201,7 +201,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root =
*root,
 		csum =3D (u8 *)dst;
 	}
=20
-	if (bio->bi_size > PAGE_CACHE_SIZE * 8)
+	if (bio->bi_iter.bi_size > PAGE_CACHE_SIZE * 8)
 		path->reada =3D 2;
=20
 	WARN_ON(bio->bi_vcnt <=3D 0);
@@ -217,7 +217,7 @@ static int __btrfs_lookup_bio_sums(struct btrfs_root =
*root,
 		path->skip_locking =3D 1;
 	}
=20
-	disk_bytenr =3D (u64)bio->bi_sector << 9;
+	disk_bytenr =3D (u64)bio->bi_iter.bi_sector << 9;
 	if (dio)
 		offset =3D logical_offset;
 	while (bio_index < bio->bi_vcnt) {
@@ -302,7 +302,7 @@ int btrfs_lookup_bio_sums_dio(struct btrfs_root *root=
, struct inode *inode,
 			      struct btrfs_dio_private *dip, struct bio *bio,
 			      u64 offset)
 {
-	int len =3D (bio->bi_sector << 9) - dip->disk_bytenr;
+	int len =3D (bio->bi_iter.bi_sector << 9) - dip->disk_bytenr;
 	u16 csum_size =3D btrfs_super_csum_size(root->fs_info->super_copy);
 	int ret;
=20
@@ -444,11 +444,12 @@ int btrfs_csum_one_bio(struct btrfs_root *root, str=
uct inode *inode,
 	u64 offset;
=20
 	WARN_ON(bio->bi_vcnt <=3D 0);
-	sums =3D kzalloc(btrfs_ordered_sum_size(root, bio->bi_size), GFP_NOFS);
+	sums =3D kzalloc(btrfs_ordered_sum_size(root, bio->bi_iter.bi_size),
+		       GFP_NOFS);
 	if (!sums)
 		return -ENOMEM;
=20
-	sums->len =3D bio->bi_size;
+	sums->len =3D bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
=20
 	if (contig)
@@ -458,7 +459,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struc=
t inode *inode,
=20
 	ordered =3D btrfs_lookup_ordered_extent(inode, offset);
 	BUG_ON(!ordered); /* Logic error */
-	sums->bytenr =3D (u64)bio->bi_sector << 9;
+	sums->bytenr =3D (u64)bio->bi_iter.bi_sector << 9;
 	index =3D 0;
=20
 	while (bio_index < bio->bi_vcnt) {
@@ -473,7 +474,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struc=
t inode *inode,
 			btrfs_add_ordered_sum(inode, ordered, sums);
 			btrfs_put_ordered_extent(ordered);
=20
-			bytes_left =3D bio->bi_size - total_bytes;
+			bytes_left =3D bio->bi_iter.bi_size - total_bytes;
=20
 			sums =3D kzalloc(btrfs_ordered_sum_size(root, bytes_left),
 				       GFP_NOFS);
@@ -481,7 +482,7 @@ int btrfs_csum_one_bio(struct btrfs_root *root, struc=
t inode *inode,
 			sums->len =3D bytes_left;
 			ordered =3D btrfs_lookup_ordered_extent(inode, offset);
 			BUG_ON(!ordered); /* Logic error */
-			sums->bytenr =3D ((u64)bio->bi_sector << 9) +
+			sums->bytenr =3D ((u64)bio->bi_iter.bi_sector << 9) +
 				       total_bytes;
 			index =3D 0;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0ef7b0..6f5a64d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1579,7 +1579,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page,=
 unsigned long offset,
 			 unsigned long bio_flags)
 {
 	struct btrfs_root *root =3D BTRFS_I(page->mapping->host)->root;
-	u64 logical =3D (u64)bio->bi_sector << 9;
+	u64 logical =3D (u64)bio->bi_iter.bi_sector << 9;
 	u64 length =3D 0;
 	u64 map_length;
 	int ret;
@@ -1587,7 +1587,7 @@ int btrfs_merge_bio_hook(int rw, struct page *page,=
 unsigned long offset,
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
 		return 0;
=20
-	length =3D bio->bi_size;
+	length =3D bio->bi_iter.bi_size;
 	map_length =3D length;
 	ret =3D btrfs_map_block(root->fs_info, rw, logical,
 			      &map_length, NULL, 0);
@@ -6883,7 +6883,8 @@ static void btrfs_end_dio_bio(struct bio *bio, int =
err)
 		printk(KERN_ERR "btrfs direct IO failed ino %llu rw %lu "
 		      "sector %#Lx len %u err no %d\n",
 		      btrfs_ino(dip->inode), bio->bi_rw,
-		      (unsigned long long)bio->bi_sector, bio->bi_size, err);
+		      (unsigned long long)bio->bi_iter.bi_sector,
+		      bio->bi_iter.bi_size, err);
 		dip->errors =3D 1;
=20
 		/*
@@ -6974,7 +6975,7 @@ static int btrfs_submit_direct_hook(int rw, struct =
btrfs_dio_private *dip,
 	struct bio *bio;
 	struct bio *orig_bio =3D dip->orig_bio;
 	struct bio_vec *bvec =3D orig_bio->bi_io_vec;
-	u64 start_sector =3D orig_bio->bi_sector;
+	u64 start_sector =3D orig_bio->bi_iter.bi_sector;
 	u64 file_offset =3D dip->logical_offset;
 	u64 submit_len =3D 0;
 	u64 map_length;
@@ -6982,7 +6983,7 @@ static int btrfs_submit_direct_hook(int rw, struct =
btrfs_dio_private *dip,
 	int ret =3D 0;
 	int async_submit =3D 0;
=20
-	map_length =3D orig_bio->bi_size;
+	map_length =3D orig_bio->bi_iter.bi_size;
 	ret =3D btrfs_map_block(root->fs_info, rw, start_sector << 9,
 			      &map_length, NULL, 0);
 	if (ret) {
@@ -6990,7 +6991,7 @@ static int btrfs_submit_direct_hook(int rw, struct =
btrfs_dio_private *dip,
 		return -EIO;
 	}
=20
-	if (map_length >=3D orig_bio->bi_size) {
+	if (map_length >=3D orig_bio->bi_iter.bi_size) {
 		bio =3D orig_bio;
 		goto submit;
 	}
@@ -7042,7 +7043,7 @@ static int btrfs_submit_direct_hook(int rw, struct =
btrfs_dio_private *dip,
 			bio->bi_private =3D dip;
 			bio->bi_end_io =3D btrfs_end_dio_bio;
=20
-			map_length =3D orig_bio->bi_size;
+			map_length =3D orig_bio->bi_iter.bi_size;
 			ret =3D btrfs_map_block(root->fs_info, rw,
 					      start_sector << 9,
 					      &map_length, NULL, 0);
@@ -7100,7 +7101,8 @@ static void btrfs_submit_direct(int rw, struct bio =
*dio_bio,
=20
 	if (!skip_sum && !write) {
 		csum_size =3D btrfs_super_csum_size(root->fs_info->super_copy);
-		sum_len =3D dio_bio->bi_size >> inode->i_sb->s_blocksize_bits;
+		sum_len =3D dio_bio->bi_iter.bi_size >>
+			inode->i_sb->s_blocksize_bits;
 		sum_len *=3D csum_size;
 	} else {
 		sum_len =3D 0;
@@ -7115,8 +7117,8 @@ static void btrfs_submit_direct(int rw, struct bio =
*dio_bio,
 	dip->private =3D dio_bio->bi_private;
 	dip->inode =3D inode;
 	dip->logical_offset =3D file_offset;
-	dip->bytes =3D dio_bio->bi_size;
-	dip->disk_bytenr =3D (u64)dio_bio->bi_sector << 9;
+	dip->bytes =3D dio_bio->bi_iter.bi_size;
+	dip->disk_bytenr =3D (u64)dio_bio->bi_iter.bi_sector << 9;
 	io_bio->bi_private =3D dip;
 	dip->errors =3D 0;
 	dip->orig_bio =3D io_bio;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d0ecfbd..03f7945 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1033,8 +1033,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *=
rbio,
=20
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		last_end =3D (u64)last->bi_sector << 9;
-		last_end +=3D last->bi_size;
+		last_end =3D (u64)last->bi_iter.bi_sector << 9;
+		last_end +=3D last->bi_iter.bi_size;
=20
 		/*
 		 * we can't merge these if they are from different
@@ -1054,9 +1054,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *=
rbio,
 	if (!bio)
 		return -ENOMEM;
=20
-	bio->bi_size =3D 0;
+	bio->bi_iter.bi_size =3D 0;
 	bio->bi_bdev =3D stripe->dev->bdev;
-	bio->bi_sector =3D disk_start >> 9;
+	bio->bi_iter.bi_sector =3D disk_start >> 9;
 	set_bit(BIO_UPTODATE, &bio->bi_flags);
=20
 	bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
@@ -1112,7 +1112,7 @@ static void index_rbio_pages(struct btrfs_raid_bio =
*rbio)
=20
 	spin_lock_irq(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list) {
-		start =3D (u64)bio->bi_sector << 9;
+		start =3D (u64)bio->bi_iter.bi_sector << 9;
 		stripe_offset =3D start - rbio->raid_map[0];
 		page_index =3D stripe_offset >> PAGE_CACHE_SHIFT;
=20
@@ -1273,7 +1273,7 @@ cleanup:
 static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 			   struct bio *bio)
 {
-	u64 physical =3D bio->bi_sector;
+	u64 physical =3D bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
 	struct btrfs_bio_stripe *stripe;
@@ -1299,7 +1299,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *r=
bio,
 static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 				   struct bio *bio)
 {
-	u64 logical =3D bio->bi_sector;
+	u64 logical =3D bio->bi_iter.bi_sector;
 	u64 stripe_start;
 	int i;
=20
@@ -1603,8 +1603,8 @@ static int plug_cmp(void *priv, struct list_head *a=
, struct list_head *b)
 						 plug_list);
 	struct btrfs_raid_bio *rb =3D container_of(b, struct btrfs_raid_bio,
 						 plug_list);
-	u64 a_sector =3D ra->bio_list.head->bi_sector;
-	u64 b_sector =3D rb->bio_list.head->bi_sector;
+	u64 a_sector =3D ra->bio_list.head->bi_iter.bi_sector;
+	u64 b_sector =3D rb->bio_list.head->bi_iter.bi_sector;
=20
 	if (a_sector < b_sector)
 		return -1;
@@ -1692,7 +1692,7 @@ int raid56_parity_write(struct btrfs_root *root, st=
ruct bio *bio,
 	if (IS_ERR(rbio))
 		return PTR_ERR(rbio);
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes =3D bio->bi_size;
+	rbio->bio_list_bytes =3D bio->bi_iter.bi_size;
=20
 	/*
 	 * don't plug on full rbios, just get them out the door
@@ -2045,7 +2045,7 @@ int raid56_parity_recover(struct btrfs_root *root, =
struct bio *bio,
=20
 	rbio->read_rebuild =3D 1;
 	bio_list_add(&rbio->bio_list, bio);
-	rbio->bio_list_bytes =3D bio->bi_size;
+	rbio->bio_list_bytes =3D bio->bi_iter.bi_size;
=20
 	rbio->faila =3D find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila =3D=3D -1) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a18e0e2..fe42870 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1308,7 +1308,7 @@ static void scrub_recheck_block(struct btrfs_fs_inf=
o *fs_info,
 			continue;
 		}
 		bio->bi_bdev =3D page->dev->bdev;
-		bio->bi_sector =3D page->physical >> 9;
+		bio->bi_iter.bi_sector =3D page->physical >> 9;
 		bio->bi_end_io =3D scrub_complete_bio_end_io;
 		bio->bi_private =3D &complete;
=20
@@ -1440,7 +1440,7 @@ static int scrub_repair_page_from_good_copy(struct =
scrub_block *sblock_bad,
 		if (!bio)
 			return -EIO;
 		bio->bi_bdev =3D page_bad->dev->bdev;
-		bio->bi_sector =3D page_bad->physical >> 9;
+		bio->bi_iter.bi_sector =3D page_bad->physical >> 9;
 		bio->bi_end_io =3D scrub_complete_bio_end_io;
 		bio->bi_private =3D &complete;
=20
@@ -1538,7 +1538,7 @@ again:
 		bio->bi_private =3D sbio;
 		bio->bi_end_io =3D scrub_wr_bio_end_io;
 		bio->bi_bdev =3D sbio->dev->bdev;
-		bio->bi_sector =3D sbio->physical >> 9;
+		bio->bi_iter.bi_sector =3D sbio->physical >> 9;
 		sbio->err =3D 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=3D
 		   spage->physical_for_dev_replace ||
@@ -1944,7 +1944,7 @@ again:
 		bio->bi_private =3D sbio;
 		bio->bi_end_io =3D scrub_bio_end_io;
 		bio->bi_bdev =3D sbio->dev->bdev;
-		bio->bi_sector =3D sbio->physical >> 9;
+		bio->bi_iter.bi_sector =3D sbio->physical >> 9;
 		sbio->err =3D 0;
 	} else if (sbio->physical + sbio->page_count * PAGE_SIZE !=3D
 		   spage->physical ||
@@ -3402,8 +3402,8 @@ static int write_page_nocow(struct scrub_ctx *sctx,
 	}
 	bio->bi_private =3D &compl;
 	bio->bi_end_io =3D scrub_complete_bio_end_io;
-	bio->bi_size =3D 0;
-	bio->bi_sector =3D physical_for_dev_replace >> 9;
+	bio->bi_iter.bi_size =3D 0;
+	bio->bi_iter.bi_sector =3D physical_for_dev_replace >> 9;
 	bio->bi_bdev =3D dev->bdev;
 	ret =3D bio_add_page(bio, page, PAGE_CACHE_SIZE, 0);
 	if (ret !=3D PAGE_CACHE_SIZE) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 043b215..ef48947 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5407,7 +5407,7 @@ static int bio_size_ok(struct block_device *bdev, s=
truct bio *bio,
 	if (!q->merge_bvec_fn)
 		return 1;
=20
-	bvm.bi_size =3D bio->bi_size - prev->bv_len;
+	bvm.bi_size =3D bio->bi_iter.bi_size - prev->bv_len;
 	if (q->merge_bvec_fn(q, &bvm, prev) < prev->bv_len)
 		return 0;
 	return 1;
@@ -5422,7 +5422,7 @@ static void submit_stripe_bio(struct btrfs_root *ro=
ot, struct btrfs_bio *bbio,
 	bio->bi_private =3D bbio;
 	btrfs_io_bio(bio)->stripe_index =3D dev_nr;
 	bio->bi_end_io =3D btrfs_end_bio;
-	bio->bi_sector =3D physical >> 9;
+	bio->bi_iter.bi_sector =3D physical >> 9;
 #ifdef DEBUG
 	{
 		struct rcu_string *name;
@@ -5460,7 +5460,7 @@ again:
 	while (bvec <=3D (first_bio->bi_io_vec + first_bio->bi_vcnt - 1)) {
 		if (bio_add_page(bio, bvec->bv_page, bvec->bv_len,
 				 bvec->bv_offset) < bvec->bv_len) {
-			u64 len =3D bio->bi_size;
+			u64 len =3D bio->bi_iter.bi_size;
=20
 			atomic_inc(&bbio->stripes_pending);
 			submit_stripe_bio(root, bbio, bio, physical, dev_nr,
@@ -5482,7 +5482,7 @@ static void bbio_error(struct btrfs_bio *bbio, stru=
ct bio *bio, u64 logical)
 		bio->bi_private =3D bbio->private;
 		bio->bi_end_io =3D bbio->end_io;
 		btrfs_io_bio(bio)->mirror_num =3D bbio->mirror_num;
-		bio->bi_sector =3D logical >> 9;
+		bio->bi_iter.bi_sector =3D logical >> 9;
 		kfree(bbio);
 		bio_endio(bio, -EIO);
 	}
@@ -5493,7 +5493,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, =
struct bio *bio,
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio =3D bio;
-	u64 logical =3D (u64)bio->bi_sector << 9;
+	u64 logical =3D (u64)bio->bi_iter.bi_sector << 9;
 	u64 length =3D 0;
 	u64 map_length;
 	u64 *raid_map =3D NULL;
@@ -5502,7 +5502,7 @@ int btrfs_map_bio(struct btrfs_root *root, int rw, =
struct bio *bio,
 	int total_devs =3D 1;
 	struct btrfs_bio *bbio =3D NULL;
=20
-	length =3D bio->bi_size;
+	length =3D bio->bi_iter.bi_size;
 	map_length =3D length;
=20
 	ret =3D __btrfs_map_block(root->fs_info, rw, logical, &map_length, &bbi=
o,
diff --git a/fs/buffer.c b/fs/buffer.c
index 4d74335..8f35e75 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2972,11 +2972,11 @@ static void guard_bh_eod(int rw, struct bio *bio,=
 struct buffer_head *bh)
 	 * let it through, and the IO layer will turn it into
 	 * an EIO.
 	 */
-	if (unlikely(bio->bi_sector >=3D maxsector))
+	if (unlikely(bio->bi_iter.bi_sector >=3D maxsector))
 		return;
=20
-	maxsector -=3D bio->bi_sector;
-	bytes =3D bio->bi_size;
+	maxsector -=3D bio->bi_iter.bi_sector;
+	bytes =3D bio->bi_iter.bi_size;
 	if (likely((bytes >> 9) <=3D maxsector))
 		return;
=20
@@ -2984,7 +2984,7 @@ static void guard_bh_eod(int rw, struct bio *bio, s=
truct buffer_head *bh)
 	bytes =3D maxsector << 9;
=20
 	/* Truncate the bio.. */
-	bio->bi_size =3D bytes;
+	bio->bi_iter.bi_size =3D bytes;
 	bio->bi_io_vec[0].bv_len =3D bytes;
=20
 	/* ..and clear the end of the buffer for reads */
@@ -3019,14 +3019,14 @@ int _submit_bh(int rw, struct buffer_head *bh, un=
signed long bio_flags)
 	 */
 	bio =3D bio_alloc(GFP_NOIO, 1);
=20
-	bio->bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev =3D bh->b_bdev;
 	bio->bi_io_vec[0].bv_page =3D bh->b_page;
 	bio->bi_io_vec[0].bv_len =3D bh->b_size;
 	bio->bi_io_vec[0].bv_offset =3D bh_offset(bh);
=20
 	bio->bi_vcnt =3D 1;
-	bio->bi_size =3D bh->b_size;
+	bio->bi_iter.bi_size =3D bh->b_size;
=20
 	bio->bi_end_io =3D end_bio_bh_io_sync;
 	bio->bi_private =3D bh;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0e04142..160a548 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -375,7 +375,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdi=
o,
 	bio =3D bio_alloc(GFP_KERNEL, nr_vecs);
=20
 	bio->bi_bdev =3D bdev;
-	bio->bi_sector =3D first_sector;
+	bio->bi_iter.bi_sector =3D first_sector;
 	if (dio->is_async)
 		bio->bi_end_io =3D dio_bio_end_aio;
 	else
@@ -719,7 +719,7 @@ static inline int dio_send_cur_page(struct dio *dio, =
struct dio_submit *sdio,
 	if (sdio->bio) {
 		loff_t cur_offset =3D sdio->cur_page_fs_offset;
 		loff_t bio_next_offset =3D sdio->logical_offset_in_bio +
-			sdio->bio->bi_size;
+			sdio->bio->bi_iter.bi_size;
=20
 		/*
 		 * See whether this new request is contiguous with the old.
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index d7d0c7b..2c1ca02 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -297,7 +297,7 @@ ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
 static void ext4_end_bio(struct bio *bio, int error)
 {
 	ext4_io_end_t *io_end =3D bio->bi_private;
-	sector_t bi_sector =3D bio->bi_sector;
+	sector_t bi_sector =3D bio->bi_iter.bi_sector;
=20
 	BUG_ON(!io_end);
 	bio->bi_end_io =3D NULL;
@@ -365,7 +365,7 @@ static int io_submit_init_bio(struct ext4_io_submit *=
io,
 	bio =3D bio_alloc(GFP_NOIO, min(nvecs, BIO_MAX_PAGES));
 	if (!bio)
 		return -ENOMEM;
-	bio->bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev =3D bh->b_bdev;
 	bio->bi_end_io =3D ext4_end_bio;
 	bio->bi_private =3D ext4_get_io_end(io->io_end);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 941f9b9..97d8b34 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -395,7 +395,7 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct pa=
ge *page,
 	bio =3D f2fs_bio_alloc(bdev, 1);
=20
 	/* Initialize the bio */
-	bio->bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
+	bio->bi_iter.bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
 	bio->bi_end_io =3D read_end_io;
=20
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 09af9c7..9d77ce1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -677,7 +677,7 @@ retry:
 		}
=20
 		sbi->bio[type] =3D f2fs_bio_alloc(bdev, max_hw_blocks(sbi));
-		sbi->bio[type]->bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
+		sbi->bio[type]->bi_iter.bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr)=
;
 		sbi->bio[type]->bi_private =3D priv;
 		/*
 		 * The end_io will be assigned at the sumbission phase.
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 010b9fb..985da94 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -272,7 +272,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd=
 *sdp, u64 blkno)
 		nrvecs =3D max(nrvecs/2, 1U);
 	}
=20
-	bio->bi_sector =3D blkno * (sb->s_blocksize >> 9);
+	bio->bi_iter.bi_sector =3D blkno * (sb->s_blocksize >> 9);
 	bio->bi_bdev =3D sb->s_bdev;
 	bio->bi_end_io =3D gfs2_end_log_write;
 	bio->bi_private =3D sdp;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 19ff5e8..dd77001 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -224,7 +224,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sect=
or_t sector, int silent)
 	lock_page(page);
=20
 	bio =3D bio_alloc(GFP_NOFS, 1);
-	bio->bi_sector =3D sector * (sb->s_blocksize >> 9);
+	bio->bi_iter.bi_sector =3D sector * (sb->s_blocksize >> 9);
 	bio->bi_bdev =3D sb->s_bdev;
 	bio_add_page(bio, page, PAGE_SIZE, 0);
=20
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index b51a607..5585a32 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -71,7 +71,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t=
 sector,
 	sector &=3D ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
=20
 	bio =3D bio_alloc(GFP_NOIO, 1);
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	bio->bi_bdev =3D sb->s_bdev;
 	bio->bi_end_io =3D hfsplus_end_io_sync;
 	bio->bi_private =3D &wait;
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 360d27c..8d811e0 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1998,20 +1998,20 @@ static int lbmRead(struct jfs_log * log, int pn, =
struct lbuf ** bpp)
=20
 	bio =3D bio_alloc(GFP_NOFS, 1);
=20
-	bio->bi_sector =3D bp->l_blkno << (log->l2bsize - 9);
+	bio->bi_iter.bi_sector =3D bp->l_blkno << (log->l2bsize - 9);
 	bio->bi_bdev =3D log->bdev;
 	bio->bi_io_vec[0].bv_page =3D bp->l_page;
 	bio->bi_io_vec[0].bv_len =3D LOGPSIZE;
 	bio->bi_io_vec[0].bv_offset =3D bp->l_offset;
=20
 	bio->bi_vcnt =3D 1;
-	bio->bi_size =3D LOGPSIZE;
+	bio->bi_iter.bi_size =3D LOGPSIZE;
=20
 	bio->bi_end_io =3D lbmIODone;
 	bio->bi_private =3D bp;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
-		bio->bi_size =3D 0;
+		bio->bi_iter.bi_size =3D 0;
 		lbmIODone(bio, 0);
 	} else {
 		submit_bio(READ_SYNC, bio);
@@ -2144,21 +2144,21 @@ static void lbmStartIO(struct lbuf * bp)
 	jfs_info("lbmStartIO\n");
=20
 	bio =3D bio_alloc(GFP_NOFS, 1);
-	bio->bi_sector =3D bp->l_blkno << (log->l2bsize - 9);
+	bio->bi_iter.bi_sector =3D bp->l_blkno << (log->l2bsize - 9);
 	bio->bi_bdev =3D log->bdev;
 	bio->bi_io_vec[0].bv_page =3D bp->l_page;
 	bio->bi_io_vec[0].bv_len =3D LOGPSIZE;
 	bio->bi_io_vec[0].bv_offset =3D bp->l_offset;
=20
 	bio->bi_vcnt =3D 1;
-	bio->bi_size =3D LOGPSIZE;
+	bio->bi_iter.bi_size =3D LOGPSIZE;
=20
 	bio->bi_end_io =3D lbmIODone;
 	bio->bi_private =3D bp;
=20
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
-		bio->bi_size =3D 0;
+		bio->bi_iter.bi_size =3D 0;
 		lbmIODone(bio, 0);
 	} else {
 		submit_bio(WRITE_SYNC, bio);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index d165cde..49ba7ff 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -416,7 +416,7 @@ static int metapage_writepage(struct page *page, stru=
ct writeback_control *wbc)
 			 * count from hitting zero before we're through
 			 */
 			inc_io(page);
-			if (!bio->bi_size)
+			if (!bio->bi_iter.bi_size)
 				goto dump_bio;
 			submit_bio(WRITE, bio);
 			nr_underway++;
@@ -438,7 +438,7 @@ static int metapage_writepage(struct page *page, stru=
ct writeback_control *wbc)
=20
 		bio =3D bio_alloc(GFP_NOFS, 1);
 		bio->bi_bdev =3D inode->i_sb->s_bdev;
-		bio->bi_sector =3D pblock << (inode->i_blkbits - 9);
+		bio->bi_iter.bi_sector =3D pblock << (inode->i_blkbits - 9);
 		bio->bi_end_io =3D metapage_write_end_io;
 		bio->bi_private =3D page;
=20
@@ -452,7 +452,7 @@ static int metapage_writepage(struct page *page, stru=
ct writeback_control *wbc)
 	if (bio) {
 		if (bio_add_page(bio, page, bio_bytes, bio_offset) < bio_bytes)
 				goto add_failed;
-		if (!bio->bi_size)
+		if (!bio->bi_iter.bi_size)
 			goto dump_bio;
=20
 		submit_bio(WRITE, bio);
@@ -517,7 +517,8 @@ static int metapage_readpage(struct file *fp, struct =
page *page)
=20
 			bio =3D bio_alloc(GFP_NOFS, 1);
 			bio->bi_bdev =3D inode->i_sb->s_bdev;
-			bio->bi_sector =3D pblock << (inode->i_blkbits - 9);
+			bio->bi_iter.bi_sector =3D
+				pblock << (inode->i_blkbits - 9);
 			bio->bi_end_io =3D metapage_read_end_io;
 			bio->bi_private =3D page;
 			len =3D xlen << inode->i_blkbits;
diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index 550475c..a1b161f 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -32,9 +32,9 @@ static int sync_request(struct page *page, struct block=
_device *bdev, int rw)
 	bio_vec.bv_len =3D PAGE_SIZE;
 	bio_vec.bv_offset =3D 0;
 	bio.bi_vcnt =3D 1;
-	bio.bi_size =3D PAGE_SIZE;
+	bio.bi_iter.bi_size =3D PAGE_SIZE;
 	bio.bi_bdev =3D bdev;
-	bio.bi_sector =3D page->index * (PAGE_SIZE >> 9);
+	bio.bi_iter.bi_sector =3D page->index * (PAGE_SIZE >> 9);
 	init_completion(&complete);
 	bio.bi_private =3D &complete;
 	bio.bi_end_io =3D request_complete;
@@ -107,9 +107,9 @@ static int __bdev_writeseg(struct super_block *sb, u6=
4 ofs, pgoff_t index,
 		if (i >=3D max_pages) {
 			/* Block layer cannot split bios :( */
 			bio->bi_vcnt =3D i;
-			bio->bi_size =3D i * PAGE_SIZE;
+			bio->bi_iter.bi_size =3D i * PAGE_SIZE;
 			bio->bi_bdev =3D super->s_bdev;
-			bio->bi_sector =3D ofs >> 9;
+			bio->bi_iter.bi_sector =3D ofs >> 9;
 			bio->bi_private =3D sb;
 			bio->bi_end_io =3D writeseg_end_io;
 			atomic_inc(&super->s_pending_writes);
@@ -134,9 +134,9 @@ static int __bdev_writeseg(struct super_block *sb, u6=
4 ofs, pgoff_t index,
 		unlock_page(page);
 	}
 	bio->bi_vcnt =3D nr_pages;
-	bio->bi_size =3D nr_pages * PAGE_SIZE;
+	bio->bi_iter.bi_size =3D nr_pages * PAGE_SIZE;
 	bio->bi_bdev =3D super->s_bdev;
-	bio->bi_sector =3D ofs >> 9;
+	bio->bi_iter.bi_sector =3D ofs >> 9;
 	bio->bi_private =3D sb;
 	bio->bi_end_io =3D writeseg_end_io;
 	atomic_inc(&super->s_pending_writes);
@@ -199,9 +199,9 @@ static int do_erase(struct super_block *sb, u64 ofs, =
pgoff_t index,
 		if (i >=3D max_pages) {
 			/* Block layer cannot split bios :( */
 			bio->bi_vcnt =3D i;
-			bio->bi_size =3D i * PAGE_SIZE;
+			bio->bi_iter.bi_size =3D i * PAGE_SIZE;
 			bio->bi_bdev =3D super->s_bdev;
-			bio->bi_sector =3D ofs >> 9;
+			bio->bi_iter.bi_sector =3D ofs >> 9;
 			bio->bi_private =3D sb;
 			bio->bi_end_io =3D erase_end_io;
 			atomic_inc(&super->s_pending_writes);
@@ -220,9 +220,9 @@ static int do_erase(struct super_block *sb, u64 ofs, =
pgoff_t index,
 		bio->bi_io_vec[i].bv_offset =3D 0;
 	}
 	bio->bi_vcnt =3D nr_pages;
-	bio->bi_size =3D nr_pages * PAGE_SIZE;
+	bio->bi_iter.bi_size =3D nr_pages * PAGE_SIZE;
 	bio->bi_bdev =3D super->s_bdev;
-	bio->bi_sector =3D ofs >> 9;
+	bio->bi_iter.bi_sector =3D ofs >> 9;
 	bio->bi_private =3D sb;
 	bio->bi_end_io =3D erase_end_io;
 	atomic_inc(&super->s_pending_writes);
diff --git a/fs/mpage.c b/fs/mpage.c
index 0face1c..92b125f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -94,7 +94,7 @@ mpage_alloc(struct block_device *bdev,
=20
 	if (bio) {
 		bio->bi_bdev =3D bdev;
-		bio->bi_sector =3D first_sector;
+		bio->bi_iter.bi_sector =3D first_sector;
 	}
 	return bio;
 }
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blockl=
ayout.c
index e242bbf..af73896 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -134,8 +134,8 @@ bl_submit_bio(int rw, struct bio *bio)
 	if (bio) {
 		get_parallel(bio->bi_private);
 		dprintk("%s submitting %s bio %u@%llu\n", __func__,
-			rw =3D=3D READ ? "read" : "write",
-			bio->bi_size, (unsigned long long)bio->bi_sector);
+			rw =3D=3D READ ? "read" : "write", bio->bi_iter.bi_size,
+			(unsigned long long)bio->bi_iter.bi_sector);
 		submit_bio(rw, bio);
 	}
 	return NULL;
@@ -156,7 +156,8 @@ static struct bio *bl_alloc_init_bio(int npg, sector_=
t isect,
 	}
=20
 	if (bio) {
-		bio->bi_sector =3D isect - be->be_f_offset + be->be_v_offset;
+		bio->bi_iter.bi_sector =3D isect - be->be_f_offset +
+			be->be_v_offset;
 		bio->bi_bdev =3D be->be_mdev;
 		bio->bi_end_io =3D end_io;
 		bio->bi_private =3D par;
@@ -519,7 +520,7 @@ bl_do_readpage_sync(struct page *page, struct pnfs_bl=
ock_extent *be,
 	isect =3D (page->index << PAGE_CACHE_SECTOR_SHIFT) +
 		(offset / SECTOR_SIZE);
=20
-	bio->bi_sector =3D isect - be->be_f_offset + be->be_v_offset;
+	bio->bi_iter.bi_sector =3D isect - be->be_f_offset + be->be_v_offset;
 	bio->bi_bdev =3D be->be_mdev;
 	bio->bi_end_io =3D bl_read_single_end_io;
=20
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 2d8be51..dc3a9efd 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -416,7 +416,8 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nil=
fs *nilfs, sector_t start,
 	}
 	if (likely(bio)) {
 		bio->bi_bdev =3D nilfs->ns_bdev;
-		bio->bi_sector =3D start << (nilfs->ns_blocksize_bits - 9);
+		bio->bi_iter.bi_sector =3D
+			start << (nilfs->ns_blocksize_bits - 9);
 	}
 	return bio;
 }
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 363f0dc..a90ad76 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -421,7 +421,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_reg=
ion *reg,
 	}
=20
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_sector =3D (reg->hr_start_block + cs) << (bits - 9);
+	bio->bi_iter.bi_sector =3D (reg->hr_start_block + cs) << (bits - 9);
 	bio->bi_bdev =3D reg->hr_bdev;
 	bio->bi_private =3D wc;
 	bio->bi_end_io =3D o2hb_bio_end_io;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index e51e581..3d3f957 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -404,7 +404,7 @@ xfs_alloc_ioend_bio(
 	struct bio		*bio =3D bio_alloc(GFP_NOIO, nvecs);
=20
 	ASSERT(bio->bi_private =3D=3D NULL);
-	bio->bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_iter.bi_sector =3D bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev =3D bh->b_bdev;
 	return bio;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 2634700..7b248e7 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1254,7 +1254,7 @@ next_chunk:
=20
 	bio =3D bio_alloc(GFP_NOIO, nr_pages);
 	bio->bi_bdev =3D bp->b_target->bt_bdev;
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	bio->bi_end_io =3D xfs_buf_bio_end_io;
 	bio->bi_private =3D bp;
=20
@@ -1276,7 +1276,7 @@ next_chunk:
 		total_nr_pages--;
 	}
=20
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
+#define bio_end_sector(bio)	((bio)->bi_iter.bi_sector + bio_sectors((bio=
)))
=20
 static inline unsigned int bio_cur_bytes(struct bio *bio)
 {
 	if (bio->bi_vcnt)
 		return bio_iovec(bio)->bv_len;
 	else /* dataless requests such as discard */
-		return bio->bi_size;
+		return bio->bi_iter.bi_size;
 }
=20
 static inline void *bio_data(struct bio *bio)
@@ -108,7 +108,7 @@ static inline void *bio_data(struct bio *bio)
  */
=20
 #define __BVEC_END(bio)		bio_iovec_idx((bio), (bio)->bi_vcnt - 1)
-#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_idx)
+#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_iter.bi_idx)
=20
 /* Default implementation of BIOVEC_PHYS_MERGEABLE */
 #define __BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
@@ -150,7 +150,7 @@ static inline void *bio_data(struct bio *bio)
 	     i++)
=20
 #define bio_for_each_segment(bvl, bio, i)				\
-	for (i =3D (bio)->bi_idx;						\
+	for (i =3D (bio)->bi_iter.bi_idx;					\
 	     bvl =3D bio_iovec_idx((bio), (i)), i < (bio)->bi_vcnt;	\
 	     i++)
=20
@@ -365,7 +365,7 @@ static inline char *__bio_kmap_irq(struct bio *bio, u=
nsigned short idx,
 #define __bio_kunmap_irq(buf, flags)	bvec_kunmap_irq(buf, flags)
=20
 #define bio_kmap_irq(bio, flags) \
-	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
+	__bio_kmap_irq((bio), (bio)->bi_iter.bi_idx, (flags))
 #define bio_kunmap_irq(buf,flags)	__bio_kunmap_irq(buf, flags)
=20
 /*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fa1abeb..d46e8a6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -28,13 +28,19 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
=20
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
=20
-	unsigned short		bi_vcnt;	/* how many bio_vec's */
-	unsigned short		bi_idx;		/* current index into bvl_vec */
+	struct bvec_iter	bi_iter;
=20
 	/* Number of segments in this BIO after
 	 * physical address coalescing is performed.
 	 */
 	unsigned int		bi_phys_segments;
=20
-	unsigned int		bi_size;	/* residual I/O count */
-
 	/*
 	 * To keep track of the max segment size, we account for the
 	 * sizes of the first and last mergeable segments in this bio.
@@ -74,11 +77,13 @@ struct bio {
 	struct bio_integrity_payload *bi_integrity;  /* data integrity */
 #endif
=20
+	unsigned short		bi_vcnt;	/* how many bio_vec's */
+
 	/*
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset(=
)
 	 */
=20
-	unsigned int		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
=20
 	atomic_t		bi_cnt;		/* pin count */
=20
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h
index 5ebda97..5b647cd 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -26,10 +26,10 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
 		__entry->orig_major	=3D s->d->disk->major;
 		__entry->orig_minor	=3D s->d->disk->first_minor;
-		__entry->sector		=3D bio->bi_sector;
-		__entry->orig_sector	=3D bio->bi_sector - 16;
-		__entry->nr_sector	=3D bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		=3D bio->bi_iter.bi_sector;
+		__entry->orig_sector	=3D bio->bi_iter.bi_sector - 16;
+		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
=20
 	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
@@ -101,9 +101,9 @@ DECLARE_EVENT_CLASS(bcache_bio,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
-		__entry->nr_sector	=3D bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		=3D bio->bi_iter.bi_sector;
+		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
=20
 	TP_printk("%d,%d  %s %llu + %u",
@@ -136,9 +136,9 @@ TRACE_EVENT(bcache_read,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
-		__entry->nr_sector	=3D bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		=3D bio->bi_iter.bi_sector;
+		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		__entry->cache_hit =3D hit;
 		__entry->bypass =3D bypass;
 	),
@@ -164,9 +164,9 @@ TRACE_EVENT(bcache_write,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
-		__entry->nr_sector	=3D bio->bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		__entry->sector		=3D bio->bi_iter.bi_sector;
+		__entry->nr_sector	=3D bio->bi_iter.bi_size >> 9;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		__entry->writeback =3D writeback;
 		__entry->bypass =3D bypass;
 	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 4c2301d..e76ae19 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -243,9 +243,9 @@ TRACE_EVENT(block_bio_bounce,
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev ?
 					  bio->bi_bdev->bd_dev : 0;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->nr_sector	=3D bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
=20
@@ -280,10 +280,10 @@ TRACE_EVENT(block_bio_complete,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->nr_sector	=3D bio_sectors(bio);
 		__entry->error		=3D error;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
=20
 	TP_printk("%d,%d %s %llu + %u [%d]",
@@ -308,9 +308,9 @@ DECLARE_EVENT_CLASS(block_bio_merge,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->nr_sector	=3D bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
=20
@@ -375,9 +375,9 @@ TRACE_EVENT(block_bio_queue,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->nr_sector	=3D bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
=20
@@ -403,7 +403,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio ? bio->bi_bdev->bd_dev : 0;
-		__entry->sector		=3D bio ? bio->bi_sector : 0;
+		__entry->sector		=3D bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	=3D bio ? bio_sectors(bio) : 0;
 		blk_fill_rwbs(__entry->rwbs,
 			      bio ? bio->bi_rw : 0, __entry->nr_sector);
@@ -538,9 +538,9 @@ TRACE_EVENT(block_split,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->new_sector	=3D new_sector;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
=20
@@ -579,11 +579,11 @@ TRACE_EVENT(block_bio_remap,
=20
 	TP_fast_assign(
 		__entry->dev		=3D bio->bi_bdev->bd_dev;
-		__entry->sector		=3D bio->bi_sector;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
 		__entry->nr_sector	=3D bio_sectors(bio);
 		__entry->old_dev	=3D dev;
 		__entry->old_sector	=3D from;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
 	),
=20
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 52ae548..a9531ad 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -611,8 +611,8 @@ TRACE_EVENT(f2fs_do_submit_bio,
 		__entry->dev		=3D sb->s_dev;
 		__entry->btype		=3D btype;
 		__entry->sync		=3D sync;
-		__entry->sector		=3D bio->bi_sector;
-		__entry->size		=3D bio->bi_size;
+		__entry->sector		=3D bio->bi_iter.bi_sector;
+		__entry->size		=3D bio->bi_iter.bi_size;
 	),
=20
 	TP_printk("dev =3D (%d,%d), type =3D %s, io =3D %s, sector =3D %lld, si=
ze =3D %u",
diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index d09dd10..9a58bc2 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -32,7 +32,7 @@ static int submit(int rw, struct block_device *bdev, se=
ctor_t sector,
 	struct bio *bio;
=20
 	bio =3D bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
-	bio->bi_sector =3D sector;
+	bio->bi_iter.bi_sector =3D sector;
 	bio->bi_bdev =3D bdev;
 	bio->bi_end_io =3D end_swap_bio_read;
=20
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b8b8560..2814a3e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -764,8 +764,8 @@ static void blk_add_trace_bio(struct request_queue *q=
, struct bio *bio,
 	if (!error && !bio_flagged(bio, BIO_UPTODATE))
 		error =3D EIO;
=20
-	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw, what,
-			error, 0, NULL);
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio->bi_rw, what, error, 0, NULL);
 }
=20
 static void blk_add_trace_bio_bounce(void *ignore,
@@ -868,8 +868,9 @@ static void blk_add_trace_split(void *ignore,
 	if (bt) {
 		__be64 rpdu =3D cpu_to_be64(pdu);
=20
-		__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw,
-				BLK_TA_SPLIT, !bio_flagged(bio, BIO_UPTODATE),
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio->bi_rw, BLK_TA_SPLIT,
+				!bio_flagged(bio, BIO_UPTODATE),
 				sizeof(rpdu), &rpdu);
 	}
 }
@@ -901,9 +902,9 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.device_to   =3D cpu_to_be32(bio->bi_bdev->bd_dev);
 	r.sector_from =3D cpu_to_be64(from);
=20
-	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw,
-			BLK_TA_REMAP, !bio_flagged(bio, BIO_UPTODATE),
-			sizeof(r), &r);
+	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			bio->bi_rw, BLK_TA_REMAP,
+			!bio_flagged(bio, BIO_UPTODATE), sizeof(r), &r);
 }
=20
 /**
diff --git a/mm/page_io.c b/mm/page_io.c
index 8c79a47..f14eded 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -31,13 +31,13 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
=20
 	bio =3D bio_alloc(gfp_flags, 1);
 	if (bio) {
-		bio->bi_sector =3D map_swap_page(page, &bio->bi_bdev);
-		bio->bi_sector <<=3D PAGE_SHIFT - 9;
+		bio->bi_iter.bi_sector =3D map_swap_page(page, &bio->bi_bdev);
+		bio->bi_iter.bi_sector <<=3D PAGE_SHIFT - 9;
 		bio->bi_io_vec[0].bv_page =3D page;
 		bio->bi_io_vec[0].bv_len =3D PAGE_SIZE;
 		bio->bi_io_vec[0].bv_offset =3D 0;
 		bio->bi_vcnt =3D 1;
-		bio->bi_size =3D PAGE_SIZE;
+		bio->bi_iter.bi_size =3D PAGE_SIZE;
 		bio->bi_end_io =3D end_io;
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
=20
--=20
1.8.4.rc3

