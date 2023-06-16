Return-Path: <colin.i.king@gmail.com>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D23F4203B3
	for <drbd-dev@lists.linbit.com>; Fri, 16 Jun 2023 18:45:30 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
	5b1f17b1804b1-3f8d258f203so7592845e9.1
	for <drbd-dev@lists.linbit.com>; Fri, 16 Jun 2023 09:45:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Date: Fri, 16 Jun 2023 17:45:28 +0100
Message-Id: <20230616164528.2342460-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH][next] drbd: remove redundant assignment to
	variable owords
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

The variable owords is being assigned a value that is never
read, the exit path via label out returns before owords is ever
used again. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/block/drbd/drbd_bitmap.c:654:3: warning: Value stored to 'owords' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/drbd/drbd_bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..897bf211e985 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -651,7 +651,6 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 		spin_lock_irq(&b->bm_lock);
 		opages = b->bm_pages;
 		onpages = b->bm_number_of_pages;
-		owords = b->bm_words;
 		b->bm_pages = NULL;
 		b->bm_number_of_pages =
 		b->bm_set   =
-- 
2.39.2

