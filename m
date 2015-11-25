Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 65DB810562BD
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:36 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:59 +0100
Message-Id: <1448448851-10343-27-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 26/38] drbd: avoid redefinition of BITS_PER_PAGE
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
index 9462d27..8bdc34d 100644
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

