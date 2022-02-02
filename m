Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CF3E74201BB
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:37 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:04 +0100
Message-Id: <20220202160109.108149-9-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/13] dm: simplify the single bio fast path in
	__send_duplicate_bios
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

Most targets just need a single flush bio.  Open code that case in
__send_duplicate_bios without the need to add the bio to a list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c05b6ff1bb957..78df75f57288b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1241,15 +1241,6 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	struct bio *bio;
 	int try;
 
-	if (!num_bios)
-		return;
-
-	if (num_bios == 1) {
-		bio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-		bio_list_add(blist, bio);
-		return;
-	}
-
 	for (try = 0; try < 2; try++) {
 		int bio_nr;
 
@@ -1279,12 +1270,23 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	struct bio_list blist = BIO_EMPTY_LIST;
 	struct bio *clone;
 
-	alloc_multiple_bios(&blist, ci, ti, num_bios, len);
-
-	while ((clone = bio_list_pop(&blist))) {
+	switch (num_bios) {
+	case 0:
+		break;
+	case 1:
+		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		if (len)
 			bio_setup_sector(clone, ci->sector, *len);
 		__map_bio(clone);
+		break;
+	default:
+		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
+		while ((clone = bio_list_pop(&blist))) {
+			if (len)
+				bio_setup_sector(clone, ci->sector, *len);
+			__map_bio(clone);
+		}
+		break;
 	}
 }
 
-- 
2.30.2

