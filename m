Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 25 Jun 2013 16:50:07 +0200
Message-Id: <1372171808-30515-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1372171808-30515-1-git-send-email-philipp.reisner@linbit.com>
References: <1372171808-30515-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/6] drbd: Constants should be UPPERCASE
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

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    7 ++++++-
 drivers/block/drbd/drbd_nl.c       |   20 ++++++++++----------
 drivers/block/drbd/drbd_receiver.c |    6 +++---
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f104328..4519d63 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1467,7 +1467,12 @@ extern void drbd_suspend_io(struct drbd_conf *mdev);
 extern void drbd_resume_io(struct drbd_conf *mdev);
 extern char *ppsize(char *buf, unsigned long long size);
 extern sector_t drbd_new_dev_size(struct drbd_conf *, struct drbd_backing_dev *, sector_t, int);
-enum determine_dev_size { dev_size_error = -1, unchanged = 0, shrunk = 1, grew = 2 };
+enum determine_dev_size {
+	DS_ERROR = -1,
+	DS_UNCHANGED = 0,
+	DS_SHRUNK = 1,
+	DS_GREW = 2
+};
 extern enum determine_dev_size drbd_determine_dev_size(struct drbd_conf *, enum dds_flags) __must_hold(local);
 extern void resync_after_online_grow(struct drbd_conf *);
 extern void drbd_reconsider_max_bio_size(struct drbd_conf *mdev);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e25803b..45d1275 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -835,7 +835,7 @@ enum determine_dev_size drbd_determine_dev_size(struct drbd_conf *mdev, enum dds
 	char ppb[10];
 
 	int md_moved, la_size_changed;
-	enum determine_dev_size rv = unchanged;
+	enum determine_dev_size rv = DS_UNCHANGED;
 
 	/* race:
 	 * application request passes inc_ap_bio,
@@ -878,7 +878,7 @@ enum determine_dev_size drbd_determine_dev_size(struct drbd_conf *mdev, enum dds
 				    "Leaving size unchanged at size = %lu KB\n",
 				    (unsigned long)size);
 			}
-			rv = dev_size_error;
+			rv = DS_ERROR;
 		}
 		/* racy, see comments above. */
 		drbd_set_my_capacity(mdev, size);
@@ -886,7 +886,7 @@ enum determine_dev_size drbd_determine_dev_size(struct drbd_conf *mdev, enum dds
 		dev_info(DEV, "size = %s (%llu KB)\n", ppsize(ppb, size>>1),
 		     (unsigned long long)size>>1);
 	}
-	if (rv == dev_size_error)
+	if (rv == DS_ERROR)
 		goto out;
 
 	la_size_changed = (la_size_sect != mdev->ldev->md.la_size_sect);
@@ -905,16 +905,16 @@ enum determine_dev_size drbd_determine_dev_size(struct drbd_conf *mdev, enum dds
 		err = drbd_bitmap_io(mdev, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
 				     "size changed", BM_LOCKED_MASK);
 		if (err) {
-			rv = dev_size_error;
+			rv = DS_ERROR;
 			goto out;
 		}
 		drbd_md_mark_dirty(mdev);
 	}
 
 	if (size > la_size_sect)
-		rv = grew;
+		rv = DS_GREW;
 	if (size < la_size_sect)
-		rv = shrunk;
+		rv = DS_SHRUNK;
 out:
 	lc_unlock(mdev->act_log);
 	wake_up(&mdev->al_wait);
@@ -1619,10 +1619,10 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		set_bit(USE_DEGR_WFC_T, &mdev->flags);
 
 	dd = drbd_determine_dev_size(mdev, 0);
-	if (dd == dev_size_error) {
+	if (dd == DS_ERROR) {
 		retcode = ERR_NOMEM_BITMAP;
 		goto force_diskless_dec;
-	} else if (dd == grew)
+	} else if (dd == DS_GREW)
 		set_bit(RESYNC_AFTER_NEG, &mdev->flags);
 
 	if (drbd_md_test_flag(mdev->ldev, MDF_FULL_SYNC) ||
@@ -2387,13 +2387,13 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 	dd = drbd_determine_dev_size(mdev, ddsf);
 	drbd_md_sync(mdev);
 	put_ldev(mdev);
-	if (dd == dev_size_error) {
+	if (dd == DS_ERROR) {
 		retcode = ERR_NOMEM_BITMAP;
 		goto fail;
 	}
 
 	if (mdev->state.conn == C_CONNECTED) {
-		if (dd == grew)
+		if (dd == DS_GREW)
 			set_bit(RESIZE_PENDING, &mdev->flags);
 
 		drbd_send_uuids(mdev);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index adee58e..26852b8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3545,7 +3545,7 @@ static int receive_sizes(struct drbd_tconn *tconn, struct packet_info *pi)
 {
 	struct drbd_conf *mdev;
 	struct p_sizes *p = pi->data;
-	enum determine_dev_size dd = unchanged;
+	enum determine_dev_size dd = DS_UNCHANGED;
 	sector_t p_size, p_usize, my_usize;
 	int ldsc = 0; /* local disk size changed */
 	enum dds_flags ddsf;
@@ -3619,7 +3619,7 @@ static int receive_sizes(struct drbd_tconn *tconn, struct packet_info *pi)
 	if (get_ldev(mdev)) {
 		dd = drbd_determine_dev_size(mdev, ddsf);
 		put_ldev(mdev);
-		if (dd == dev_size_error)
+		if (dd == DS_ERROR)
 			return -EIO;
 		drbd_md_sync(mdev);
 	} else {
@@ -3647,7 +3647,7 @@ static int receive_sizes(struct drbd_tconn *tconn, struct packet_info *pi)
 			drbd_send_sizes(mdev, 0, ddsf);
 		}
 		if (test_and_clear_bit(RESIZE_PENDING, &mdev->flags) ||
-		    (dd == grew && mdev->state.conn == C_CONNECTED)) {
+		    (dd == DS_GREW && mdev->state.conn == C_CONNECTED)) {
 			if (mdev->state.pdsk >= D_INCONSISTENT &&
 			    mdev->state.disk >= D_INCONSISTENT) {
 				if (ddsf & DDSF_NO_RESYNC)
-- 
1.7.9.5

