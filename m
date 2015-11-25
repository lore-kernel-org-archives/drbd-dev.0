Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7999C1056309
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:39 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:11 +0100
Message-Id: <1448448851-10343-39-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 38/38] drbd: fix error path during resize
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

In case the lower level device size changed, but some other internal
details of the resize did not work out, drbd_determine_dev_size() would
try to restore the previous settings, trusting
drbd_md_set_sector_offsets() to "do the right thing", but overlooked
that this internally may set the meta data base offset based on device size.

This could end up with incomplete on-disk meta data layout change, and
ultimately lead to data corruption (if the failure was not noticed or
ignored by the operator, and other things go wrong as well).

Just remember all meta data related offsets/sizes,
and on error restore them all.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f4ca273..c055c5e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -891,12 +891,18 @@ void drbd_resume_io(struct drbd_device *device)
 enum determine_dev_size
 drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct resize_parms *rs) __must_hold(local)
 {
-	sector_t prev_first_sect, prev_size; /* previous meta location */
-	sector_t la_size_sect, u_size;
+	struct md_offsets_and_sizes {
+		u64 last_agreed_sect;
+		u64 md_offset;
+		s32 al_offset;
+		s32 bm_offset;
+		u32 md_size_sect;
+
+		u32 al_stripes;
+		u32 al_stripe_size_4k;
+	} prev;
+	sector_t u_size, size;
 	struct drbd_md *md = &device->ldev->md;
-	u32 prev_al_stripe_size_4k;
-	u32 prev_al_stripes;
-	sector_t size;
 	char ppb[10];
 	void *buffer;
 
@@ -918,16 +924,17 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		return DS_ERROR;
 	}
 
-	prev_first_sect = drbd_md_first_sector(device->ldev);
-	prev_size = device->ldev->md.md_size_sect;
-	la_size_sect = device->ldev->md.la_size_sect;
+	/* remember current offset and sizes */
+	prev.last_agreed_sect = md->la_size_sect;
+	prev.md_offset = md->md_offset;
+	prev.al_offset = md->al_offset;
+	prev.bm_offset = md->bm_offset;
+	prev.md_size_sect = md->md_size_sect;
+	prev.al_stripes = md->al_stripes;
+	prev.al_stripe_size_4k = md->al_stripe_size_4k;
 
 	if (rs) {
 		/* rs is non NULL if we should change the AL layout only */
-
-		prev_al_stripes = md->al_stripes;
-		prev_al_stripe_size_4k = md->al_stripe_size_4k;
-
 		md->al_stripes = rs->al_stripes;
 		md->al_stripe_size_4k = rs->al_stripe_size / 4;
 		md->al_size_4k = (u64)rs->al_stripes * rs->al_stripe_size / 4;
@@ -940,7 +947,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	rcu_read_unlock();
 	size = drbd_new_dev_size(device, device->ldev, u_size, flags & DDSF_FORCED);
 
-	if (size < la_size_sect) {
+	if (size < prev.last_agreed_sect) {
 		if (rs && u_size == 0) {
 			/* Remove "rs &&" later. This check should always be active, but
 			   right now the receiver expects the permissive behavior */
@@ -961,30 +968,29 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		err = drbd_bm_resize(device, size, !(flags & DDSF_NO_RESYNC));
 		if (unlikely(err)) {
 			/* currently there is only one error: ENOMEM! */
-			size = drbd_bm_capacity(device)>>1;
+			size = drbd_bm_capacity(device);
 			if (size == 0) {
 				drbd_err(device, "OUT OF MEMORY! "
 				    "Could not allocate bitmap!\n");
 			} else {
 				drbd_err(device, "BM resizing failed. "
-				    "Leaving size unchanged at size = %lu KB\n",
-				    (unsigned long)size);
+				    "Leaving size unchanged\n");
 			}
 			rv = DS_ERROR;
 		}
 		/* racy, see comments above. */
 		drbd_set_my_capacity(device, size);
-		device->ldev->md.la_size_sect = size;
+		md->la_size_sect = size;
 		drbd_info(device, "size = %s (%llu KB)\n", ppsize(ppb, size>>1),
 		     (unsigned long long)size>>1);
 	}
 	if (rv <= DS_ERROR)
 		goto err_out;
 
-	la_size_changed = (la_size_sect != device->ldev->md.la_size_sect);
+	la_size_changed = (prev.last_agreed_sect != md->la_size_sect);
 
-	md_moved = prev_first_sect != drbd_md_first_sector(device->ldev)
-		|| prev_size	   != device->ldev->md.md_size_sect;
+	md_moved = prev.md_offset    != md->md_offset
+		|| prev.md_size_sect != md->md_size_sect;
 
 	if (la_size_changed || md_moved || rs) {
 		u32 prev_flags;
@@ -1024,20 +1030,22 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 				  md->al_stripes, md->al_stripe_size_4k * 4);
 	}
 
-	if (size > la_size_sect)
-		rv = la_size_sect ? DS_GREW : DS_GREW_FROM_ZERO;
-	if (size < la_size_sect)
+	if (size > prev.last_agreed_sect)
+		rv = prev.last_agreed_sect ? DS_GREW : DS_GREW_FROM_ZERO;
+	if (size < prev.last_agreed_sect)
 		rv = DS_SHRUNK;
 
 	if (0) {
 	err_out:
-		if (rs) {
-			md->al_stripes = prev_al_stripes;
-			md->al_stripe_size_4k = prev_al_stripe_size_4k;
-			md->al_size_4k = (u64)prev_al_stripes * prev_al_stripe_size_4k;
-
-			drbd_md_set_sector_offsets(device, device->ldev);
-		}
+		/* restore previous offset and sizes */
+		md->la_size_sect = prev.last_agreed_sect;
+		md->md_offset = prev.md_offset;
+		md->al_offset = prev.al_offset;
+		md->bm_offset = prev.bm_offset;
+		md->md_size_sect = prev.md_size_sect;
+		md->al_stripes = prev.al_stripes;
+		md->al_stripe_size_4k = prev.al_stripe_size_4k;
+		md->al_size_4k = (u64)prev.al_stripes * prev.al_stripe_size_4k;
 	}
 	lc_unlock(device->act_log);
 	wake_up(&device->al_wait);
-- 
1.9.1

