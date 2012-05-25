Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8539110000BB
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id ADE191B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:07 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVpAEa4Y-4sG for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 81AA61B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:07 +0200 (CEST)
Resent-Message-ID: <20120525203005.GF1903@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 657A51013804
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:26:13 +0200 (CEST)
Received: by dadv36 with SMTP id v36so2229969dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 13:26:12 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Fri, 25 May 2012 13:25:25 -0700
Message-Id: <1337977539-16977-3-git-send-email-koverstreet@google.com>
In-Reply-To: <1337977539-16977-1-git-send-email-koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 02/16] dm: Use bioset's front_pad for
	dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Previously, dm_rq_clone_bio_info needed to be freed by the bio's
destructor to avoid a memory leak in the blk_rq_prep_clone() error path.
This gets rid of a memory allocation and means we can kill
dm_rq_bio_destructor.

Change-Id: I4ed2b9dbd1dffd44ad15bc3de89d3c3b6bc7714a

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/md/dm.c |   31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 40b7735..4014696 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -92,6 +92,7 @@ struct dm_rq_target_io {
 struct dm_rq_clone_bio_info {
 	struct bio *orig;
 	struct dm_rq_target_io *tio;
+	struct bio clone;
 };
 
 union map_info *dm_get_mapinfo(struct bio *bio)
@@ -467,16 +468,6 @@ static void free_rq_tio(struct dm_rq_target_io *tio)
 	mempool_free(tio, tio->md->tio_pool);
 }
 
-static struct dm_rq_clone_bio_info *alloc_bio_info(struct mapped_device *md)
-{
-	return mempool_alloc(md->io_pool, GFP_ATOMIC);
-}
-
-static void free_bio_info(struct dm_rq_clone_bio_info *info)
-{
-	mempool_free(info, info->tio->md->io_pool);
-}
-
 static int md_in_flight(struct mapped_device *md)
 {
 	return atomic_read(&md->pending[READ]) +
@@ -1438,30 +1429,17 @@ void dm_dispatch_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(dm_dispatch_request);
 
-static void dm_rq_bio_destructor(struct bio *bio)
-{
-	struct dm_rq_clone_bio_info *info = bio->bi_private;
-	struct mapped_device *md = info->tio->md;
-
-	free_bio_info(info);
-	bio_free(bio, md->bs);
-}
-
 static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
 				 void *data)
 {
 	struct dm_rq_target_io *tio = data;
-	struct mapped_device *md = tio->md;
-	struct dm_rq_clone_bio_info *info = alloc_bio_info(md);
-
-	if (!info)
-		return -ENOMEM;
+	struct dm_rq_clone_bio_info *info =
+		container_of(bio, struct dm_rq_clone_bio_info, clone);
 
 	info->orig = bio_orig;
 	info->tio = tio;
 	bio->bi_end_io = end_clone_bio;
 	bio->bi_private = info;
-	bio->bi_destructor = dm_rq_bio_destructor;
 
 	return 0;
 }
@@ -2696,7 +2674,8 @@ struct dm_md_mempools *dm_alloc_md_mempools(unsigned type, unsigned integrity)
 	if (!pools->tio_pool)
 		goto free_io_pool_and_out;
 
-	pools->bs = bioset_create(pool_size, 0);
+	pools->bs = bioset_create(pool_size,
+				  offsetof(struct dm_rq_clone_bio_info, orig));
 	if (!pools->bs)
 		goto free_tio_pool_and_out;
 
-- 
1.7.9.3.327.g2980b

