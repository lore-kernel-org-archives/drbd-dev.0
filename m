Return-Path: <BATV+4fe6c3c60fc7db690b35+6722+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 785284202F4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jan 2022 08:55:23 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 18 Jan 2022 08:19:35 +0100
Message-Id: <20220118071952.1243143-3-hch@lst.de>
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
	dm-devel@redhat.com, "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
	Jack Wang <jinpu.wang@ionos.com>, Pavel Begunkov <asml.silence@gmail.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/19] nilfs2: remove nilfs_alloc_seg_bio
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

bio_alloc will never fail when it can sleep.  Remove the now simple
nilfs_alloc_seg_bio helper and open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nilfs2/segbuf.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 43287b0d3e9b6..53b7c6d21cdd8 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -371,29 +371,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 	return err;
 }
 
-/**
- * nilfs_alloc_seg_bio - allocate a new bio for writing log
- * @nilfs: nilfs object
- * @start: start block number of the bio
- * @nr_vecs: request size of page vector.
- *
- * Return Value: On success, pointer to the struct bio is returned.
- * On error, NULL is returned.
- */
-static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
-				       int nr_vecs)
-{
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_NOIO, nr_vecs);
-	if (likely(bio)) {
-		bio_set_dev(bio, nilfs->ns_bdev);
-		bio->bi_iter.bi_sector =
-			start << (nilfs->ns_blocksize_bits - 9);
-	}
-	return bio;
-}
-
 static void nilfs_segbuf_prepare_write(struct nilfs_segment_buffer *segbuf,
 				       struct nilfs_write_info *wi)
 {
@@ -414,10 +391,10 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 	BUG_ON(wi->nr_vecs <= 0);
  repeat:
 	if (!wi->bio) {
-		wi->bio = nilfs_alloc_seg_bio(wi->nilfs, wi->blocknr + wi->end,
-					      wi->nr_vecs);
-		if (unlikely(!wi->bio))
-			return -ENOMEM;
+		wi->bio = bio_alloc(GFP_NOIO, wi->nr_vecs);
+		bio_set_dev(wi->bio, wi->nilfs->ns_bdev);
+		wi->bio->bi_iter.bi_sector = (wi->blocknr + wi->end) <<
+			(wi->nilfs->ns_blocksize_bits - 9);
 	}
 
 	len = bio_add_page(wi->bio, bh->b_page, bh->b_size, bh_offset(bh));
-- 
2.30.2

