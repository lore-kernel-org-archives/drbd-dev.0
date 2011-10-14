Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Oct 2011 23:57:46 +0200
Message-Id: <1318629472-11110-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
References: <1318629472-11110-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/11] drbd: Fix the maximum accepted minor
	device number
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

The maximum minor device number allowed by the kernel is (1<<20 - 1).  Reject
device numbers higher than that to earlier catch possible errors.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/drbd_limits.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 9b76984..d3ec9cc 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -137,7 +137,7 @@
 #define DRBD_AL_EXTENTS_SCALE '1'
 
 #define DRBD_MINOR_NUMBER_MIN  -1
-#define DRBD_MINOR_NUMBER_MAX  (1<<30)
+#define DRBD_MINOR_NUMBER_MAX  ((1 << 20) - 1)
 #define DRBD_MINOR_NUMBER_DEF  -1
 #define DRBD_MINOR_NUMBER_SCALE '1'
 
-- 
1.7.4.1

