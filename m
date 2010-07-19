Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 183211067950
	for <drbd-dev@lists.linbit.com>; Mon, 19 Jul 2010 10:00:57 +0200 (CEST)
Resent-Message-ID: <20100719080113.GB6031@barkeeper1-xen.linbit>
Received: from mail-gw0-f54.google.com (mail-gw0-f54.google.com [74.125.83.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ED7641067B12
	for <drbd-dev@lists.linbit.com>; Mon, 19 Jul 2010 06:57:39 +0200 (CEST)
Received: by gwb19 with SMTP id 19so2103610gwb.27
	for <drbd-dev@lists.linbit.com>; Sun, 18 Jul 2010 21:57:39 -0700 (PDT)
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: drbd-dev@lists.linbit.com
Date: Mon, 19 Jul 2010 01:50:16 -0300
Message-Id: <1279515016-25907-1-git-send-email-gustavo@padovan.org>
Cc: linux-kernel@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>,
	philipp.reisner@linbit.com, jens.axboe@oracle.com
Subject: [Drbd-dev] [PATCH] drbd: Remove __packed define
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Gustavo F. Padovan <padovan@profusion.mobi>

__packed is already defined on <compiler.h>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/block/drbd/drbd_int.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e9654c8..548b3fa 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -323,10 +323,6 @@ static inline void bm_xfer_ctx_bit_to_word_offset(struct bm_xfer_ctx *c)
 #endif
 }
 
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
 /* This is the layout for a packet on the wire.
  * The byteorder is the network byte order.
  *     (except block_id and barrier fields.
-- 
1.7.1.1

