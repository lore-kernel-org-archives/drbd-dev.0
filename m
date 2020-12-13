Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
	[209.85.222.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 516824205A9
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:07:20 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id z11so12703683qkj.7
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:07:20 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:06:57 -0500
Message-Id: <20201213050704.997-2-michael.d.labriola@gmail.com>
In-Reply-To: <20201213050704.997-1-michael.d.labriola@gmail.com>
References: <20201213050704.997-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 1/8] compat: fix include for submit_bio test
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

Looks like this test is including the wrong header to get at struct
block_device_operations.

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd-kernel-compat/tests/have_submit_bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd-kernel-compat/tests/have_submit_bio.c b/drbd/drbd-kernel-compat/tests/have_submit_bio.c
index 26bc7e8c..ca94cd27 100644
--- a/drbd/drbd-kernel-compat/tests/have_submit_bio.c
+++ b/drbd/drbd-kernel-compat/tests/have_submit_bio.c
@@ -1,6 +1,6 @@
 /* { "version": "v5.8", "commit": "c62b37d96b6eb3ec5ae4cbe00db107bf15aebc93", "comment": "Since 5.8 make_request_fn has been replaced by a block_device_operations method called submit_bio", "author": "Christoph Hellwig <hch@lst.de>", "date": "Wed Jul 1 10:59:43 2020 +0200" } */
 
-#include <linux/blk_types.h>
+#include <linux/blkdev.h>
 
 void foo(struct block_device_operations *ops)
 {
-- 
2.17.1

