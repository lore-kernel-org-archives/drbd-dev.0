Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:55:00 +0200
Message-Id: <1318247706-7732-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/13] drbd: Use more generic constant names
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

These constants are useful for the same purpose in more than one place.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/drbd_limits.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 07d5df9..2b364d5 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -111,10 +111,10 @@
 #define DRBD_AL_EXTENTS_MAX  6433
 #define DRBD_AL_EXTENTS_DEF  127
 
-#define DRBD_RESYNC_AFTER_MIN  -1
-#define DRBD_RESYNC_AFTER_MAX  (1<<30)
-#define DRBD_RESYNC_AFTER_DEF  -1
-#define DRBD_RESYNC_AFTER_SCALE '1'
+#define DRBD_MINOR_NUMBER_MIN  -1
+#define DRBD_MINOR_NUMBER_MAX  (1<<30)
+#define DRBD_MINOR_NUMBER_DEF  -1
+#define DRBD_MINOR_NUMBER_SCALE '1'
 
 /* } */
 
-- 
1.7.4.1

