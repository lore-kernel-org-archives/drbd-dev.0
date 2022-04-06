Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
	[209.85.218.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B2DAC420FE0
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:35 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id l7so837897ejn.2
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:35 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:12 +0200
Message-Id: <20220406190715.1938174-5-christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/7] drbd: Make use of PFN_UP helper macro
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

From: Cai Huoqing <caihuoqing@baidu.com>

it's a refactor to make use of PFN_UP helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   | 2 +-
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_worker.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index df25eecf80af..9e060e49b3f8 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -683,7 +683,7 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 		}
 	}
 
-	want = ALIGN(words*sizeof(long), PAGE_SIZE) >> PAGE_SHIFT;
+	want = PFN_UP(words*sizeof(long));
 	have = b->bm_number_of_pages;
 	if (want == have) {
 		D_ASSERT(device, b->bm_pages != NULL);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 911c26753556..c6c1843452ba 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -364,7 +364,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 	struct page *page = NULL;
-	unsigned nr_pages = (payload_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = PFN_UP(payload_size);
 
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
@@ -1631,7 +1631,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	sector_t sector = peer_req->i.sector;
 	unsigned data_size = peer_req->i.size;
 	unsigned n_bios = 0;
-	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = PFN_UP(data_size);
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0f9956f4e9c4..af3051dd8912 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1030,7 +1030,7 @@ static void move_to_net_ee_or_free(struct drbd_device *device, struct drbd_peer_
 {
 	if (drbd_peer_req_has_active_page(peer_req)) {
 		/* This might happen if sendpage() has not finished */
-		int i = (peer_req->i.size + PAGE_SIZE -1) >> PAGE_SHIFT;
+		int i = PFN_UP(peer_req->i.size);
 		atomic_add(i, &device->pp_in_use_by_net);
 		atomic_sub(i, &device->pp_in_use);
 		spin_lock_irq(&device->resource->req_lock);
-- 
2.35.1

