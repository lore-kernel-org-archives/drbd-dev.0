Return-Path: <ziyuzhang201@gmail.com>
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
	[209.85.216.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 69CC0160920
	for <drbd-dev@lists.linbit.com>; Mon,  4 May 2026 05:26:02 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
	98e67ed59e1d1-364da484a82so836959a91.2
	for <drbd-dev@lists.linbit.com>; Sun, 03 May 2026 20:26:02 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Subject: [PATCH] drbd: serialize UUID snapshot in drbd_md_write()
Date: Mon,  4 May 2026 11:25:50 +0800
Message-ID: <20260504032550.706749-1-ziyuzhang201@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, gality369@gmail.com, zhenghaoran154@gmail.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	baijiaju1990@gmail.com, zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>, r33s3n6@gmail.com,
	hanguidong02@gmail.com, drbd-dev@lists.linbit.com
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

drbd_md_write() copies device->ldev->md.uuid[] into the on-disk
metadata block without holding uuid_lock.

The write-side helpers drbd_uuid_new_current() and drbd_uuid_set_bm()
update md.uuid[] under uuid_lock, and some updates span multiple UUID
slots as one logical state transition. An unlocked drbd_md_write() can
therefore observe and persist a mixed UUID tuple assembled from two
different states.

This is problematic because the serialized UUID tuple is written to
stable storage and later consumed by reconnect and resync decision
logic, meaning an inconsistent on-disk snapshot can represent a state that
never existed atomically in memory.

Protect the UUID copy with uuid_lock so drbd_md_write() serializes one
coherent snapshot.

Fixes: b411b3637fa7 ("The DRBD driver")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a9e49b212..6f835dd05 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3004,13 +3004,17 @@ void drbd_md_write(struct drbd_device *device, void *b)
 {
 	struct meta_data_on_disk *buffer = b;
 	sector_t sector;
+	unsigned long flags;
 	int i;
 
 	memset(buffer, 0, sizeof(*buffer));
 
 	buffer->la_size_sect = cpu_to_be64(get_capacity(device->vdisk));
+	/* Serialize the UUID tuple as one coherent snapshot. */
+	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
 	for (i = UI_CURRENT; i < UI_SIZE; i++)
 		buffer->uuid[i] = cpu_to_be64(device->ldev->md.uuid[i]);
+	spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 	buffer->flags = cpu_to_be32(device->ldev->md.flags);
 	buffer->magic = cpu_to_be32(DRBD_MD_MAGIC_84_UNCLEAN);
 
-- 
2.43.0

