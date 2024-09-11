Return-Path: <chenqiuji666@gmail.com>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 27E4D4202C8
	for <drbd-dev@lists.linbit.com>; Wed, 11 Sep 2024 11:16:36 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id
	d9443c01a7336-20688fbaeafso66996885ad.0
	for <drbd-dev@lists.linbit.com>; Wed, 11 Sep 2024 02:16:35 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk
Subject: [PATCH] brbd: Fix atomicity violation in drbd_uuid_set_bm()
Date: Wed, 11 Sep 2024 17:16:19 +0800
Message-Id: <20240911091619.4430-1-chenqiuji666@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Qiu-ji Chen <chenqiuji666@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	baijiaju1990@gmail.com, drbd-dev@lists.linbit.com
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

The violation of atomicity occurs when the brbd_uuid_set_bm function is
executed simultaneously with modifying the value of
device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
zero. In this case, the check in brbd_uuid_set_bm might refer to the old
value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
an invalid value to pass the validity check, resulting in inconsistency.

To address this issue, it is recommended to include the data validity check
within the locked section of the function. This modification ensures that
the value of device->ldev->md.uuid[UI_BITMAP] does not change during the
validation process, thereby maintaining its integrity.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 9f2247bb9b75 ("drbd: Protect accesses to the uuid set with a spinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a9e49b212341..abafc4edf9ed 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
 {
 	unsigned long flags;
-	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0)
+	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
+	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0) {
+		spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
 	if (val == 0) {
 		drbd_uuid_move_history(device);
 		device->ldev->md.uuid[UI_HISTORY_START] = device->ldev->md.uuid[UI_BITMAP];
-- 
2.34.1

