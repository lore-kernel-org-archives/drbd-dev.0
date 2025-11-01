Return-Path: <i.shihao.999@gmail.com>
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
	[209.85.215.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 09ADC162276
	for <drbd-dev@lists.linbit.com>; Sat,  1 Nov 2025 06:44:36 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
	41be03b00d2f7-b6cea7c527bso2445285a12.3
	for <drbd-dev@lists.linbit.com>; Fri, 31 Oct 2025 22:44:36 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: philipp.reisner@linbit.com
Subject: [PATCH] drbd: replace kmap() with kmap_local_page() in receiver path
Date: Sat,  1 Nov 2025 11:14:22 +0530
Message-ID: <20251101054422.17045-1-i.shihao.999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, i.shihao.999@gmail.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
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

Use kmap_local_page() instead of kmap() to avoid
CPU contention.

kmap() uses a global set of mapping slots that can cause contention
between multiple CPUs, while kmap_local_page() uses per-CPU slots
eliminating this contention. It also ensures non-sleeping operation
and provides better cache locality.

Convert kmap() to kmap_local_page() as it aligns with ongoing
kernel efforts to modernize kmap() usage for better multi-core
scalability.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index caaf2781136d..14821420ea50 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1736,13 +1736,13 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	page = peer_req->pages;
 	page_chain_for_each(page) {
 		unsigned len = min_t(int, ds, PAGE_SIZE);
-		data = kmap(page);
+		data = kmap_local_page(page);
 		err = drbd_recv_all_warn(peer_device->connection, data, len);
 		if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
 			drbd_err(device, "Fault injection: Corrupting data on receive\n");
 			data[0] = data[0] ^ (unsigned long)-1;
 		}
-		kunmap(page);
+		kunmap_local(data);
 		if (err) {
 			drbd_free_peer_req(device, peer_req);
 			return NULL;
@@ -1777,7 +1777,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)

 	page = drbd_alloc_pages(peer_device, 1, 1);

-	data = kmap(page);
+	data = kmap_local_page(page);
 	while (data_size) {
 		unsigned int len = min_t(int, data_size, PAGE_SIZE);

@@ -1786,7 +1786,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 			break;
 		data_size -= len;
 	}
-	kunmap(page);
+	kunmap_local(data);
 	drbd_free_pages(peer_device->device, page);
 	return err;
 }
--
2.51.0

