Return-Path: <mathias.krause@opensrcsec.com>
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
	[209.85.160.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 461E81608F2
	for <drbd-dev@lists.linbit.com>; Mon, 10 Nov 2025 13:59:32 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
	d75a77b69052e-4eda6a8cc12so20634971cf.0
	for <drbd-dev@lists.linbit.com>; Mon, 10 Nov 2025 04:59:32 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] compat: make block_device_operations tests grsec compatible
Message-ID: <20251110125924.511384-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mathias Krause <minipli@grsecurity.net>, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Mon, 10 Nov 2025 12:59:33 -0000

The grsecurity patch enforces that instances of certain types are always
constified, with the help of a compiler plugin. One of these types is
'struct block_device_operations'. Code that tries to modify a such-typed
object will cause compiler errors, leading to wrong results for the
kernel compatibility tests.

Change these tests to do direct type compare tests instead of trying to
modify the object, making them compatible with grsecurity kernels.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 .../tests/block_device_operations_open_takes_gendisk.c | 10 +++-------
 .../tests/have_blk_qc_t_submit_bio.c                   |  6 +++++-
 drbd/drbd-kernel-compat/tests/have_void_submit_bio.c   |  6 +++++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drbd/drbd-kernel-compat/tests/block_device_operations_open_takes_gendisk.c b/drbd/drbd-kernel-compat/tests/block_device_operations_open_takes_gendisk.c
index d5f20fd569fb..9d77f16d09d8 100644
--- a/drbd/drbd-kernel-compat/tests/block_device_operations_open_takes_gendisk.c
+++ b/drbd/drbd-kernel-compat/tests/block_device_operations_open_takes_gendisk.c
@@ -5,13 +5,9 @@
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 #endif
 
-int foo_open(struct gendisk *disk, unsigned int mode)
-{
-	return 0;
-}
+int foo_open(struct gendisk *disk, unsigned int mode);
 
-void foo(void)
+void foo(struct block_device_operations *ops)
 {
-	struct block_device_operations ops;
-	BUILD_BUG_ON(!(__same_type(ops.open, &foo_open)));
+	BUILD_BUG_ON(!(__same_type(ops->open, &foo_open)));
 }
diff --git a/drbd/drbd-kernel-compat/tests/have_blk_qc_t_submit_bio.c b/drbd/drbd-kernel-compat/tests/have_blk_qc_t_submit_bio.c
index d7f2310dfbbd..d3e6dd792ff1 100644
--- a/drbd/drbd-kernel-compat/tests/have_blk_qc_t_submit_bio.c
+++ b/drbd/drbd-kernel-compat/tests/have_blk_qc_t_submit_bio.c
@@ -2,9 +2,13 @@
 
 #include <linux/blkdev.h>
 
+#ifndef __same_type
+# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+#endif
+
 blk_qc_t submit(struct bio *bio);
 
 void foo(struct block_device_operations *ops)
 {
-	ops->submit_bio = submit;
+	BUILD_BUG_ON(!(__same_type(ops->submit_bio, &submit)));
 }
diff --git a/drbd/drbd-kernel-compat/tests/have_void_submit_bio.c b/drbd/drbd-kernel-compat/tests/have_void_submit_bio.c
index c638faf020e1..09b56a658a46 100644
--- a/drbd/drbd-kernel-compat/tests/have_void_submit_bio.c
+++ b/drbd/drbd-kernel-compat/tests/have_void_submit_bio.c
@@ -2,9 +2,13 @@
 
 #include <linux/blkdev.h>
 
+#ifndef __same_type
+# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+#endif
+
 void submit(struct bio *bio);
 
 void foo(struct block_device_operations *ops)
 {
-	ops->submit_bio = submit;
+	BUILD_BUG_ON(!(__same_type(ops->submit_bio, &submit)));
 }
-- 
2.47.3

