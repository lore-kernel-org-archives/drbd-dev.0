Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
	[209.85.218.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B97B442178D
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2022 14:35:11 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id ud5so46691680ejc.4
	for <drbd-dev@lists.linbit.com>; Wed, 09 Nov 2022 05:35:11 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  9 Nov 2022 14:34:52 +0100
Message-Id: <20221109133453.51652-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/3] drbd: disable discard support if granularity
	> max
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

From: Philipp Reisner <philipp.reisner@linbit.com>

The discard_granularity describes the minimum unit of a discard.
If that is larger than the maximal discard size, we need to disable
discards completely.

Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 249eba7d21c2..63f589926d85 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1256,6 +1256,18 @@ static void fixup_write_zeroes(struct drbd_device *device, struct request_queue
 		q->limits.max_write_zeroes_sectors = 0;
 }
 
+static void fixup_discard_support(struct drbd_device *device, struct request_queue *q)
+{
+	unsigned int max_discard = device->rq_queue->limits.max_discard_sectors;
+	unsigned int discard_granularity =
+		device->rq_queue->limits.discard_granularity >> SECTOR_SHIFT;
+
+	if (discard_granularity > max_discard) {
+		blk_queue_discard_granularity(q, 0);
+		blk_queue_max_discard_sectors(q, 0);
+	}
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
 				   unsigned int max_bio_size, struct o_qlim *o)
 {
@@ -1288,6 +1300,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		disk_update_readahead(device->vdisk);
 	}
 	fixup_write_zeroes(device, q);
+	fixup_discard_support(device, q);
 }
 
 void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
-- 
2.38.1

