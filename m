Return-Path: <devnexen@gmail.com>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 240C8160920
	for <drbd-dev@lists.linbit.com>; Sun,  5 Apr 2026 17:47:10 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
	5b1f17b1804b1-48557c8ad47so26022655e9.0
	for <drbd-dev@lists.linbit.com>; Sun, 05 Apr 2026 08:47:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3] drbd: use get_random_u64() where appropriate
Date: Sun,  5 Apr 2026 16:47:04 +0100
Message-ID: <20260405154704.4610-1-devnexen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Carlier <devnexen@gmail.com>, linux-kernel@vger.kernel.org,
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

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 4 ++--
 drivers/block/drbd/drbd_nl.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 200d464e984b..b1a721dd0496 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -874,7 +874,7 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 	if (uuid && uuid != UUID_JUST_CREATED)
 		uuid = uuid + UUID_NEW_BM_OFFSET;
 	else
-		get_random_bytes(&uuid, sizeof(u64));
+		uuid = get_random_u64();
 	drbd_uuid_set(device, UI_BITMAP, uuid);
 	drbd_print_uuids(device, "updated sync UUID");
 	drbd_md_sync(device);
@@ -3337,7 +3337,7 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 	u64 val;
 	unsigned long long bm_uuid;
 
-	get_random_bytes(&val, sizeof(u64));
+	val = get_random_u64();
 
 	spin_lock_irq(&device->ldev->md.uuid_lock);
 	bm_uuid = device->ldev->md.uuid[UI_BITMAP];
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e201f0087a0f..377f60b40f28 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3173,7 +3173,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 			 * matching real data uuid exists).
 			 */
 			u64 val;
-			get_random_bytes(&val, sizeof(u64));
+			val = get_random_u64();
 			drbd_set_ed_uuid(device, val);
 			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
 		}
-- 
2.53.0

