Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CFDEE1061739
	for <drbd-dev@lists.linbit.com>; Wed,  9 Dec 2009 14:38:30 +0100 (CET)
Resent-Message-ID: <20091209133830.GF8954@barkeeper1-xen.linbit>
From: Huang Weiyi <weiyi.huang@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Wed,  9 Dec 2009 21:09:12 +0800
Message-Id: <1260364152-5000-1-git-send-email-weiyi.huang@gmail.com>
Cc: Huang Weiyi <weiyi.huang@gmail.com>, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/3] drbd: remove duplicated #include
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Remove duplicated #include('s) in
  drivers/block/drbd/drbd_worker.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/block/drbd/drbd_worker.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ed8796f..3e8b6bc 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -34,7 +34,6 @@
 #include <linux/mm_inline.h>
 #include <linux/slab.h>
 #include <linux/random.h>
-#include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
 
-- 
1.6.1.3

