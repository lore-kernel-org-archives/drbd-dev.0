Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 13 Oct 2011 12:32:07 +0200
Message-Id: <1318501936-11689-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
References: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/10] drbd: allow ping-timeout of up to 30
	seconds
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Allow up to 300 centi-seconds to be configured for the "ping timeout".
There may be setups where heavy congestion, huge buffers, and asymmetric
bandwidth limitations may need a "huge" ping-timeout as work-around
for "spurious connection loss" problems.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/drbd_limits.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index dd8b8bf..f74334d 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -62,7 +62,7 @@
 
  /* timeout for the ping packets.*/
 #define DRBD_PING_TIMEO_MIN  1
-#define DRBD_PING_TIMEO_MAX  100
+#define DRBD_PING_TIMEO_MAX  300
 #define DRBD_PING_TIMEO_DEF  5
 
   /* max number of write requests between write barriers */
-- 
1.7.4.1

