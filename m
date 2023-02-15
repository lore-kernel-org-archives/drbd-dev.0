Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EBAFE422092
	for <drbd-dev@lists.linbit.com>; Wed, 15 Feb 2023 17:32:11 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id y1so19778254wru.2
	for <drbd-dev@lists.linbit.com>; Wed, 15 Feb 2023 08:32:11 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 15 Feb 2023 17:32:02 +0100
Message-Id: <20230215163204.2856631-6-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/7] drbd: pass a peer_device to more bitmap
	functions
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

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   |  6 ++++--
 drivers/block/drbd/drbd_int.h      | 15 ++++++++++-----
 drivers/block/drbd/drbd_main.c     |  4 ++--
 drivers/block/drbd/drbd_nl.c       |  5 +++--
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_state.c    | 12 +++++++-----
 drivers/block/drbd/drbd_worker.c   |  3 ++-
 7 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 7d8e3b02a1da..6ac8c54b44c7 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1241,7 +1241,8 @@ int drbd_bm_write(struct drbd_device *device,
  *
  * Will write all pages.
  */
-int drbd_bm_write_all(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1267,7 +1268,8 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
  * verify is aborted due to a failed peer disk, while local IO continues, or
  * pending resync acks are still being processed.
  */
-int drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8b4d06e10365..345e96ceb47c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -66,6 +66,7 @@ extern int drbd_proc_details;
 
 struct drbd_device;
 struct drbd_connection;
+struct drbd_peer_device;
 
 /* Defines to control fault insertion */
 enum {
@@ -1068,13 +1069,15 @@ extern void drbd_md_mark_dirty(struct drbd_device *device);
 extern void drbd_queue_bitmap_io(struct drbd_device *device,
 				 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 				 void (*done)(struct drbd_device *, int),
-				 char *why, enum bm_flag flags);
+				 char *why, enum bm_flag flags,
+				 struct drbd_peer_device *peer_device);
 extern int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags);
+		char *why, enum bm_flag flags, struct drbd_peer_device *);
 extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags);
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_set_n_write(struct drbd_device *device,
 		struct drbd_peer_device *peer_device) __must_hold(local);
 extern int drbd_bmio_clear_n_write(struct drbd_device *device,
@@ -1295,8 +1298,10 @@ extern int  drbd_bm_write(struct drbd_device *device,
 extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_hold(local);
-extern int drbd_bm_write_all(struct drbd_device *device) __must_hold(local);
-extern int  drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local);
+extern int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
+extern int  drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 extern size_t	     drbd_bm_words(struct drbd_device *device);
 extern unsigned long drbd_bm_bits(struct drbd_device *device);
 extern sector_t      drbd_bm_capacity(struct drbd_device *device);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6f2955f2dcc9..6647f84f3879 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1198,7 +1198,7 @@ static int fill_bitmap_rle_bits(struct drbd_device *device,
  * code upon failure.
  */
 static int
-send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
+send_bitmap_rle_or_plain(struct drbd_peer_device *peer_device, struct bm_xfer_ctx *c)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_socket *sock = &peer_device->connection->data;
@@ -1269,7 +1269,7 @@ static int _drbd_send_bitmap(struct drbd_device *device,
 		if (drbd_md_test_flag(device->ldev, MDF_FULL_SYNC)) {
 			drbd_info(device, "Writing the whole bitmap, MDF_FullSync was set.\n");
 			drbd_bm_set_all(device);
-			if (drbd_bm_write(device)) {
+			if (drbd_bm_write(device, peer_device)) {
 				/* write_bm did fail! Leave full sync flag set in Meta P_DATA
 				 * but otherwise process as per normal - need to tell other
 				 * side that a full resync is required! */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 07a52c5a2989..8967298968f3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3007,11 +3007,12 @@ static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *
 	return 0;
 }
 
-static int drbd_bmio_set_susp_al(struct drbd_device *device) __must_hold(local)
+static int drbd_bmio_set_susp_al(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	int rv;
 
-	rv = drbd_bmio_set_n_write(device);
+	rv = drbd_bmio_set_n_write(device, peer_device);
 	drbd_suspend_al(device);
 	return rv;
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8605b5154a7e..e352880c70b5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4878,7 +4878,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
 
-		err = drbd_send_bitmap(device);
+		err = drbd_send_bitmap(device, peer_device);
 		if (err)
 			goto out;
 		/* Omit CS_ORDERED with this state transition to avoid deadlocks. */
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0b335ddd6d12..c92dc6093b0a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1810,7 +1810,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	    device->state.conn == C_WF_BITMAP_S)
 		drbd_queue_bitmap_io(device, &drbd_send_bitmap, NULL,
 				"send_bitmap (WFBitMapS)",
-				BM_LOCKED_TEST_ALLOWED);
+				BM_LOCKED_TEST_ALLOWED, peer_device);
 
 	/* Lost contact to peer's copy of the data */
 	if (lost_contact_to_peer_data(os.pdsk, ns.pdsk)) {
@@ -1840,7 +1840,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			 * No harm done if the bitmap still changes,
 			 * redirtied pages will follow later. */
 			drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote diskless peer", BM_LOCKED_SET_ALLOWED);
+				"demote diskless peer", BM_LOCKED_SET_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1852,7 +1852,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* No changes to the bitmap expected this time, so assert that,
 		 * even though no harm was done if it did change. */
 		drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote", BM_LOCKED_TEST_ALLOWED);
+				"demote", BM_LOCKED_TEST_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1889,7 +1889,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* no other bitmap changes expected during this phase */
 		drbd_queue_bitmap_io(device,
 			&drbd_bmio_set_n_write, &abw_start_sync,
-			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED);
+			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED,
+			peer_device);
 
 	/* first half of local IO error, failure to attach,
 	 * or administrative detach */
@@ -2012,7 +2013,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	if ((os.conn > C_CONNECTED && os.conn < C_AHEAD) &&
 	    (ns.conn == C_CONNECTED || ns.conn >= C_AHEAD) && get_ldev(device)) {
 		drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
-			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED);
+			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED,
+			peer_device);
 		put_ldev(device);
 	}
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f46738040d6b..68d5ba4af17d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1945,6 +1945,7 @@ static void drbd_ldev_destroy(struct drbd_device *device)
 
 static void go_diskless(struct drbd_device *device)
 {
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	D_ASSERT(device, device->state.disk == D_FAILED);
 	/* we cannot assert local_cnt == 0 here, as get_ldev_if_state will
 	 * inc/dec it frequently. Once we are D_DISKLESS, no one will touch
@@ -1970,7 +1971,7 @@ static void go_diskless(struct drbd_device *device)
 		 * Any modifications would not be expected anymore, though.
 		 */
 		if (drbd_bitmap_io_from_worker(device, drbd_bm_write,
-					"detach", BM_LOCKED_TEST_ALLOWED)) {
+					"detach", BM_LOCKED_TEST_ALLOWED, peer_device)) {
 			if (test_bit(WAS_READ_ERROR, &device->flags)) {
 				drbd_md_set_flag(device, MDF_FULL_SYNC);
 				drbd_md_sync(device);
-- 
2.39.1

