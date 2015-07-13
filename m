Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3BB75105058C
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:25 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:38:55 +0800
Message-Id: <1436776744-3135-2-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 01/10] drbd: Fix the wrong logic of moving
	history
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

Logic of moving history is wrong. May overlap
history when more than two history.
If won't extent more that two history. The loop
can be delete.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 9871894..a3dc39e 100644
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

