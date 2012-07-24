Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 019351055F42
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id E87801B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:43 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvUiRnqt+cUf for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id B4D4C1B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:43 +0200 (CEST)
Resent-Message-ID: <20120726093543.GW29767@soda.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 771E010000EC
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 22:19:59 +0200 (CEST)
Received: by mail-yx0-f182.google.com with SMTP id l8so10375101yen.27
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 13:19:59 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Tue, 24 Jul 2012 13:11:21 -0700
Message-Id: <1343160689-12378-5-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-1-git-send-email-koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v4 04/12] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is prep work for killing bi_destructor - previously, pktcdvd had
its own pkt_bio_alloc which was basically duplication bio_kmalloc(),
necessitating its own bi_destructor implementation.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/block/pktcdvd.c |  115 ++++++++++++++++-------------------------------
 1 files changed, 39 insertions(+), 76 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ba66e44..6fe693a 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -522,36 +522,38 @@ static void pkt_bio_finished(struct pktcdvd_device *pd)
 	}
 }
 
-static void pkt_bio_destructor(struct bio *bio)
+static void pkt_end_io_read(struct bio *bio, int err)
 {
-	kfree(bio->bi_io_vec);
-	kfree(bio);
-}
+	struct packet_data *pkt = bio->bi_private;
+	struct pktcdvd_device *pd = pkt->pd;
+	BUG_ON(!pd);
 
-static struct bio *pkt_bio_alloc(int nr_iovecs)
-{
-	struct bio_vec *bvl = NULL;
-	struct bio *bio;
+	VPRINTK("pkt_end_io_read: bio=%p sec0=%llx sec=%llx err=%d\n", bio,
+		(unsigned long long)pkt->sector, (unsigned long long)bio->bi_sector, err);
 
-	bio = kmalloc(sizeof(struct bio), GFP_KERNEL);
-	if (!bio)
-		goto no_bio;
-	bio_init(bio);
+	if (err)
+		atomic_inc(&pkt->io_errors);
+	if (atomic_dec_and_test(&pkt->io_wait)) {
+		atomic_inc(&pkt->run_sm);
+		wake_up(&pd->wqueue);
+	}
+	pkt_bio_finished(pd);
+}
 
-	bvl = kcalloc(nr_iovecs, sizeof(struct bio_vec), GFP_KERNEL);
-	if (!bvl)
-		goto no_bvl;
+static void pkt_end_io_packet_write(struct bio *bio, int err)
+{
+	struct packet_data *pkt = bio->bi_private;
+	struct pktcdvd_device *pd = pkt->pd;
+	BUG_ON(!pd);
 
-	bio->bi_max_vecs = nr_iovecs;
-	bio->bi_io_vec = bvl;
-	bio->bi_destructor = pkt_bio_destructor;
+	VPRINTK("pkt_end_io_packet_write: id=%d, err=%d\n", pkt->id, err);
 
-	return bio;
+	pd->stats.pkt_ended++;
 
- no_bvl:
-	kfree(bio);
- no_bio:
-	return NULL;
+	pkt_bio_finished(pd);
+	atomic_dec(&pkt->io_wait);
+	atomic_inc(&pkt->run_sm);
+	wake_up(&pd->wqueue);
 }
 
 /*
@@ -567,10 +569,13 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
 		goto no_pkt;
 
 	pkt->frames = frames;
-	pkt->w_bio = pkt_bio_alloc(frames);
+	pkt->w_bio = bio_kmalloc(GFP_KERNEL, frames);
 	if (!pkt->w_bio)
 		goto no_bio;
 
+	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
+	pkt->w_bio->bi_private = pkt;
+
 	for (i = 0; i < frames / FRAMES_PER_PAGE; i++) {
 		pkt->pages[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
 		if (!pkt->pages[i])
@@ -581,9 +586,12 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
 	bio_list_init(&pkt->orig_bios);
 
 	for (i = 0; i < frames; i++) {
-		struct bio *bio = pkt_bio_alloc(1);
+		struct bio *bio = bio_kmalloc(GFP_KERNEL, 1);
 		if (!bio)
 			goto no_rd_bio;
+
+		bio->bi_end_io = pkt_end_io_read;
+		bio->bi_private = pkt;
 		pkt->r_bios[i] = bio;
 	}
 
@@ -1036,40 +1044,6 @@ static void pkt_make_local_copy(struct packet_data *pkt, struct bio_vec *bvec)
 	}
 }
 
-static void pkt_end_io_read(struct bio *bio, int err)
-{
-	struct packet_data *pkt = bio->bi_private;
-	struct pktcdvd_device *pd = pkt->pd;
-	BUG_ON(!pd);
-
-	VPRINTK("pkt_end_io_read: bio=%p sec0=%llx sec=%llx err=%d\n", bio,
-		(unsigned long long)pkt->sector, (unsigned long long)bio->bi_sector, err);
-
-	if (err)
-		atomic_inc(&pkt->io_errors);
-	if (atomic_dec_and_test(&pkt->io_wait)) {
-		atomic_inc(&pkt->run_sm);
-		wake_up(&pd->wqueue);
-	}
-	pkt_bio_finished(pd);
-}
-
-static void pkt_end_io_packet_write(struct bio *bio, int err)
-{
-	struct packet_data *pkt = bio->bi_private;
-	struct pktcdvd_device *pd = pkt->pd;
-	BUG_ON(!pd);
-
-	VPRINTK("pkt_end_io_packet_write: id=%d, err=%d\n", pkt->id, err);
-
-	pd->stats.pkt_ended++;
-
-	pkt_bio_finished(pd);
-	atomic_dec(&pkt->io_wait);
-	atomic_inc(&pkt->run_sm);
-	wake_up(&pd->wqueue);
-}
-
 /*
  * Schedule reads for the holes in a packet
  */
@@ -1111,21 +1085,15 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	 * Schedule reads for missing parts of the packet.
 	 */
 	for (f = 0; f < pkt->frames; f++) {
-		struct bio_vec *vec;
-
 		int p, offset;
+
 		if (written[f])
 			continue;
+
 		bio = pkt->r_bios[f];
-		vec = bio->bi_io_vec;
-		bio_init(bio);
-		bio->bi_max_vecs = 1;
-		bio->bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
-		bio->bi_bdev = pd->bdev;
-		bio->bi_end_io = pkt_end_io_read;
-		bio->bi_private = pkt;
-		bio->bi_io_vec = vec;
-		bio->bi_destructor = pkt_bio_destructor;
+		bio_reset(bio);
+		bio->bi_sector	= pkt->sector + f * (CD_FRAMESIZE >> 9);
+		bio->bi_bdev	= pd->bdev;
 
 		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
 		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
@@ -1418,14 +1386,9 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	}
 
 	/* Start the write request */
-	bio_init(pkt->w_bio);
-	pkt->w_bio->bi_max_vecs = PACKET_MAX_SIZE;
+	bio_reset(pkt->w_bio);
 	pkt->w_bio->bi_sector = pkt->sector;
 	pkt->w_bio->bi_bdev = pd->bdev;
-	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
-	pkt->w_bio->bi_private = pkt;
-	pkt->w_bio->bi_io_vec = bvec;
-	pkt->w_bio->bi_destructor = pkt_bio_destructor;
 	for (f = 0; f < pkt->frames; f++)
 		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
 			BUG();
-- 
1.7.7.3

