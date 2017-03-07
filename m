Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CEDB81056487
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:29 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:54 +0800
Message-Id: <1488857279-29079-4-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 3/8] Adapt pointer backing_dev_info in struct
	request_queue
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

In dc3b17cc, struct request_queue use pointer to backing_dev_info,
so all related call should be converted.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 drbd/drbd_main.c        | 5 +++++
 drbd/drbd_nl.c          | 9 ++++++++
 drbd/drbd_req.c         | 4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index b2f839e..324239b 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3583,8 +3583,13 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	/* we have no partitions. we contain only ourselves. */
 	device->this_bdev->bd_contains = device->this_bdev;
 
+#ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO
+	q->backing_dev_info->congested_fn = drbd_congested;
+	q->backing_dev_info->congested_data = device;
+#else
 	q->backing_dev_info.congested_fn = drbd_congested;
 	q->backing_dev_info.congested_data = device;
+#endif
 
 	blk_queue_make_request(q, drbd_make_request);
 	blk_queue_write_cache(q, true, true);
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 22044ab..ace77c5 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -1882,12 +1882,21 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	if (b) {
 		blk_queue_stack_limits(q, b);
 
+#ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO
+		if (q->backing_dev_info->ra_pages != b->backing_dev_info->ra_pages) {
+			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
+				 q->backing_dev_info->ra_pages,
+				 b->backing_dev_info->ra_pages);
+			q->backing_dev_info->ra_pages = b->backing_dev_info->ra_pages;
+		}
+#else
 		if (q->backing_dev_info.ra_pages != b->backing_dev_info.ra_pages) {
 			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
 				 q->backing_dev_info.ra_pages,
 				 b->backing_dev_info.ra_pages);
 			q->backing_dev_info.ra_pages = b->backing_dev_info.ra_pages;
 		}
+#endif
 	}
 	fixup_discard_if_not_supported(q);
 }
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index e1e9595..d6d9dc1 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -1155,7 +1155,11 @@ static bool remote_due_to_read_balancing(struct drbd_device *device,
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
+#ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO
+		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
+#else
 		bdi = &device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
+#endif
 		return bdi_read_congested(bdi);
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
-- 
1.8.5.6

