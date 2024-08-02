Return-Path: <yuehaibing@huawei.com>
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CB3C4204B5
	for <drbd-dev@lists.linbit.com>;
	Fri,  2 Aug 2024 12:14:41 +0200 (CEST)
From: Yue Haibing <yuehaibing@huawei.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
	<brauner@kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] drbd: Remove unused extern declarations
Date: Fri, 2 Aug 2024 17:51:47 +0800
Message-ID: <20240802095147.2788218-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

From: YueHaibing <yuehaibing@huawei.com>

Commit b411b3637fa7 ("The DRBD driver") declared but never implemented
drbd_read_remote(), is_valid_ar_handle() and drbd_set_recv_tcq().
And commit 668700b40a7c ("drbd: Create a dedicated workqueue for sending acks on the control connection")
never implemented drbd_send_ping_wf().

Commit 2451fc3b2bd3 ("drbd: Removed the BIO_RW_BARRIER support form the receiver/epoch code")
leave w_e_reissue() declaration unused.

Commit 8fe605513ab4 ("drbd: Rename drbdd_init() -> drbd_receiver()")
rename drbdd_init() and leave unsued declaration. Also drbd_asender() is removed in
commit 1c03e52083c8 ("drbd: Rename asender to ack_receiver").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/drbd/drbd_int.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 94dc0a235919..d2937bca1fe4 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -297,10 +297,6 @@ struct drbd_epoch {
 	unsigned long flags;
 };
 
-/* Prototype declaration of function defined in drbd_receiver.c */
-int drbdd_init(struct drbd_thread *);
-int drbd_asender(struct drbd_thread *);
-
 /* drbd_epoch flag bits */
 enum {
 	DE_HAVE_BARRIER_NUMBER,
@@ -1390,9 +1386,6 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *);
 void drbd_submit_bio(struct bio *bio);
-extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
-extern int is_valid_ar_handle(struct drbd_request *, sector_t);
-
 
 /* drbd_nl.c */
 
@@ -1474,7 +1467,6 @@ extern int w_resync_timer(struct drbd_work *, int);
 extern int w_send_write_hint(struct drbd_work *, int);
 extern int w_send_dblock(struct drbd_work *, int);
 extern int w_send_read_req(struct drbd_work *, int);
-extern int w_e_reissue(struct drbd_work *, int);
 extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
 
@@ -1488,7 +1480,6 @@ extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
 		sector_t start, unsigned int nr_sectors, int flags);
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
-extern void drbd_send_ping_wf(struct work_struct *ws);
 extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
@@ -1504,7 +1495,6 @@ extern void __drbd_free_peer_req(struct drbd_device *, struct drbd_peer_request
 #define drbd_free_peer_req(m,e) __drbd_free_peer_req(m, e, 0)
 #define drbd_free_net_peer_req(m,e) __drbd_free_peer_req(m, e, 1)
 extern struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned int, bool);
-extern void drbd_set_recv_tcq(struct drbd_device *device, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_head *to_be_freed);
 extern int drbd_connected(struct drbd_peer_device *);
 
-- 
2.34.1

