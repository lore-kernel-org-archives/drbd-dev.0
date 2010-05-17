Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E94D814777C3
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 14:48:47 +0200 (CEST)
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com
	[172.25.105.76]) by smtp-out.google.com with ESMTP id o4HCc25t003625
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 05:38:02 -0700
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 May 2010 14:37:59 +0200
Message-Id: <630013770d261363b113bd5971f76bb69a88a954.1274099535.git.iustin@google.com>
In-Reply-To: <cover.1274099535.git.iustin@google.com>
References: <cover.1274099535.git.iustin@google.com>
Cc: Iustin Pop <iustin@google.com>
Subject: [Drbd-dev] [PATCH 2/3] Make the drbd driver generate resync-source
	callbacks
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 drbd/drbd_worker.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index df50bef..bee4ce2 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -761,6 +761,9 @@ int drbd_resync_finished(struct drbd_conf *mdev)
 		if (os.conn == C_SYNC_TARGET || os.conn == C_PAUSED_SYNC_T)
 			khelper_cmd = "after-resync-target";
 
+		if (os.conn == C_SYNC_SOURCE || os.conn == C_PAUSED_SYNC_S)
+			khelper_cmd = "after-resync-source";
+
 		if (mdev->csums_tfm && mdev->rs_total) {
 			const unsigned long s = mdev->rs_same_csum;
 			const unsigned long t = mdev->rs_total;
@@ -1365,6 +1368,17 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 			drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
 			return;
 		}
+	} else {
+		/* Notify the user-space helper that we're becoming
+		   the source of a resync */
+		r = drbd_khelper(mdev, "before-resync-source");
+		r = (r >> 8) & 0xff;
+		if (r > 0) {
+			dev_info(DEV, "before-resync-source handler returned %d, "
+			     "dropping connection.\n", r);
+			drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+			return;
+		}
 	}
 
 	drbd_state_lock(mdev);
-- 
1.7.0.1

