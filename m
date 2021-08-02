Return-Path: <caihuoqing@baidu.com>
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 568A74203A6
	for <drbd-dev@lists.linbit.com>; Mon,  2 Aug 2021 10:16:12 +0200 (CEST)
From: Cai Huoqing <caihuoqing@baidu.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<axboe@kernel.dk>
Date: Mon, 2 Aug 2021 16:00:22 +0800
Message-ID: <20210802080023.1259-2-caihuoqing@baidu.com>
In-Reply-To: <20210802080023.1259-1-caihuoqing@baidu.com>
References: <20210802080023.1259-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Cai Huoqing <caihuoqing@baidu.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/2] drbd: Make use of PFN_UP helper macro
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

it's a refactor to make use of PFN_UP helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/block/drbd/drbd_bitmap.c   | 2 +-
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_worker.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index c1f816f896a8..88730542a59e 100644
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
index 1f740e42e457..8a73d7d3d16f 100644
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
@@ -1645,7 +1645,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	sector_t sector = peer_req->i.sector;
 	unsigned data_size = peer_req->i.size;
 	unsigned n_bios = 0;
-	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = PFN_UP(data_size);
 	int err = -ENOMEM;
 
 	/* TRIM/DISCARD: for now, always use the helper function
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 64563bfdf0da..1094cc75533e 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1035,7 +1035,7 @@ static void move_to_net_ee_or_free(struct drbd_device *device, struct drbd_peer_
 {
 	if (drbd_peer_req_has_active_page(peer_req)) {
 		/* This might happen if sendpage() has not finished */
-		int i = (peer_req->i.size + PAGE_SIZE -1) >> PAGE_SHIFT;
+		int i = PFN_UP(peer_req->i.size);
 		atomic_add(i, &device->pp_in_use_by_net);
 		atomic_sub(i, &device->pp_in_use);
 		spin_lock_irq(&device->resource->req_lock);
-- 
2.25.1

