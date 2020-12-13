Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
	[209.85.166.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 136D24205A9
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:08 +0100 (CET)
Received: by mail-il1-f169.google.com with SMTP id g1so12787620ilk.7
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:08 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:53 -0500
Message-Id: <20201213055859.3305-3-michael.d.labriola@gmail.com>
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 2/8] compat: fix include for blkdev_get_by_path
	test
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

This function lives in linux/blkdev.h

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd-kernel-compat/tests/have_blkdev_get_by_path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd-kernel-compat/tests/have_blkdev_get_by_path.c b/drbd/drbd-kernel-compat/tests/have_blkdev_get_by_path.c
index d0bae496..f795c1d1 100644
--- a/drbd/drbd-kernel-compat/tests/have_blkdev_get_by_path.c
+++ b/drbd/drbd-kernel-compat/tests/have_blkdev_get_by_path.c
@@ -1,4 +1,4 @@
-#include <linux/fs.h>
+#include <linux/blkdev.h>
 
 /*
  * In kernel version 2.6.38-rc1, open_bdev_exclusive() was replaced by
-- 
2.17.1

