Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EEE501050592
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:05 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:20 +0800
Message-Id: <1433922509-10280-2-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 01/10] drbd: Fix potenial risk of overlap the old
	history when move history.
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

Fix the potential history overlap when using more than two history uuids.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index f41aa8a..2ffb569 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3466,8 +3466,8 @@ void drbd_uuid_move_history(struct drbd_device *device) __must_hold(local)
 {
 	int i;
 
-	for (i = UI_HISTORY_START; i < UI_HISTORY_END; i++)
-		device->ldev->md.uuid[i+1] = device->ldev->md.uuid[i];
+	for (i = UI_HISTORY_END; i > UI_HISTORY_START; i--)
+		device->ldev->md.uuid[i] = device->ldev->md.uuid[i-1];
 }
 
 void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __must_hold(local)
-- 
1.8.4.5

