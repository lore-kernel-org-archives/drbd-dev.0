Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C7B5E1055731
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:58 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:30 +0200
Message-Id: <1438693003-17554-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/19] drbd: avoid redefinition of BITS_PER_PAGE
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Apparently we now implicitly get definitions for BITS_PER_PAGE and
BITS_PER_PAGE_MASK from the pid_namespace.h

Instead of renaming our defines, I chose to define only if not yet
defined, but to double check the value if already defined.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 434c77d..227deb0 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -479,8 +479,14 @@ void drbd_bm_cleanup(struct drbd_device *device)
  * this masks out the remaining bits.
  * Returns the number of bits cleared.
  */
+#ifndef BITS_PER_PAGE
 #define BITS_PER_PAGE		(1UL << (PAGE_SHIFT + 3))
 #define BITS_PER_PAGE_MASK	(BITS_PER_PAGE - 1)
+#else
+# if BITS_PER_PAGE != (1UL << (PAGE_SHIFT + 3))
+#  error "ambiguous BITS_PER_PAGE"
+# endif
+#endif
 #define BITS_PER_LONG_MASK	(BITS_PER_LONG - 1)
 static int bm_clear_surplus(struct drbd_bitmap *b)
 {
-- 
1.9.1

