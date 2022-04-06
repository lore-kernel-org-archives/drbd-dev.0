Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
	[209.85.208.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E620420FE2
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:36 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id p23so3775856edi.8
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:36 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:13 +0200
Message-Id: <20220406190715.1938174-6-christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/7] drbd: Replace "unsigned" with "unsigned int"
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

when run checkpath.pl for the first patch, found that
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
so fix it. BTW

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c6c1843452ba..0825766ce910 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -364,7 +364,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 	struct page *page = NULL;
-	unsigned nr_pages = PFN_UP(payload_size);
+	unsigned int nr_pages = PFN_UP(payload_size);
 
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
@@ -1629,9 +1629,9 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	struct bio *bio;
 	struct page *page = peer_req->pages;
 	sector_t sector = peer_req->i.sector;
-	unsigned data_size = peer_req->i.size;
-	unsigned n_bios = 0;
-	unsigned nr_pages = PFN_UP(data_size);
+	unsigned int data_size = peer_req->i.size;
+	unsigned int n_bios = 0;
+	unsigned int nr_pages = PFN_UP(data_size);
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
-- 
2.35.1

