Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  7 Oct 2011 13:27:45 +0200
Message-Id: <1317986865-3706-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
References: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/12] drbd: Rename DISK_SIZE_SECT -> DISK_SIZE
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

We don't have the units in constant names in other places, either.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/drbd_limits.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 62e93b2..07d5df9 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -123,9 +123,10 @@
  * the upper limit with 64bit kernel, enough ram and flexible meta data
  * is 1 PiB, currently. */
 /* DRBD_MAX_SECTORS */
-#define DRBD_DISK_SIZE_SECT_MIN  0
-#define DRBD_DISK_SIZE_SECT_MAX  (1 * (2LLU << 40))
-#define DRBD_DISK_SIZE_SECT_DEF  0 /* = disabled = no user size... */
+#define DRBD_DISK_SIZE_MIN  0
+#define DRBD_DISK_SIZE_MAX  (16 * (2LLU << 30))
+#define DRBD_DISK_SIZE_DEF  0 /* = disabled = no user size... */
+#define DRBD_DISK_SIZE_SCALE 's'  /* sectors */
 
 #define DRBD_ON_IO_ERROR_DEF EP_DETACH
 #define DRBD_FENCING_DEF FP_DONT_CARE
-- 
1.7.4.1

