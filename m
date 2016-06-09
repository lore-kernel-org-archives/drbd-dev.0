Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CC0BA1056446
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jun 2016 16:40:15 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu,  9 Jun 2016 22:39:47 +0800
Message-Id: <1465483189-22696-2-git-send-email-nwang@suse.com>
In-Reply-To: <1465483189-22696-1-git-send-email-nwang@suse.com>
References: <1465483189-22696-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH-drbd9 1/2] compat: blk_queue_flush() is replaced
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

In v4.7(fe8fb75e), blk_queue_flush() switch to use
blk_queue_write_cache().

Signed-off-by: Nick Wang <nwang@suse.com>

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 drbd_wrappers.h              | 4 ++++
 tests/have_blk_queue_flush.c | 6 ++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tests/have_blk_queue_flush.c

diff --git a/drbd_wrappers.h b/drbd_wrappers.h
index 0f55d9c..2dcf6cd 100644
--- a/drbd_wrappers.h
+++ b/drbd_wrappers.h
@@ -677,6 +677,10 @@ static inline void blk_queue_max_hw_sectors(struct request_queue *q, unsigned in
 #define blk_queue_max_hw_sectors(q, max)	blk_queue_max_sectors(q, max)
 #endif
 
+#ifndef COMPAT_HAVE_BLK_QUEUE_FLUSH
+#define blk_queue_flush(q, f)	blk_queue_write_cache(q, true, true)
+#endif
+
 #ifndef COMPAT_HAVE_BLK_QUEUE_MAX_SEGMENTS
 static inline void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments)
 {
diff --git a/tests/have_blk_queue_flush.c b/tests/have_blk_queue_flush.c
new file mode 100644
index 0000000..a730dee
--- /dev/null
+++ b/tests/have_blk_queue_flush.c
@@ -0,0 +1,6 @@
+#include <linux/blkdev.h>
+
+void dummy(struct request_queue *q, unsigned int flush)
+{
+	blk_queue_flush(q, flush);
+}
-- 
1.8.5.6

