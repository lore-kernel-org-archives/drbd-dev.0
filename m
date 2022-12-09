Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
	[209.85.218.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 55EDE420FC2
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 15:53:35 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id n20so12153266ejh.0
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 06:53:35 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Dec 2022 15:53:24 +0100
Message-Id: <20221209145327.2272271-6-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/8] drbd: remove macros using require_context
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

This require_context attribute originated in a proposed sparse patch by
Philipp Reisner back in 2008. Johannes Berg had a different solution to
a similar problem, and that patch "won" in the end; so the require_context
thing never got merged. The whole history can be read at [0].

DRBD kept using these annotations anyway for a while. Nowadays, on a
modern unmodified sparse, they obviously do nothing, and they are hardly
used anymore anyway.

So, just remove the definitions of these macros.

[0] https://www.spinics.net/lists/linux-sparse/msg01150.html

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ae713338aa46..edce1f7ac2da 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -39,16 +39,6 @@
 #include "drbd_protocol.h"
 #include "drbd_polymorph_printk.h"
 
-#ifdef __CHECKER__
-# define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
-# define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
-# define __protected_write_by(x) __attribute__((require_context(x,1,999,"write")))
-#else
-# define __protected_by(x)
-# define __protected_read_by(x)
-# define __protected_write_by(x)
-#endif
-
 /* shared module parameters, defined in drbd_main.c */
 #ifdef CONFIG_DRBD_FAULT_INJECTION
 extern int drbd_enable_faults;
@@ -774,7 +764,7 @@ struct drbd_device {
 	unsigned long flags;
 
 	/* configured by drbdsetup */
-	struct drbd_backing_dev *ldev __protected_by(local);
+	struct drbd_backing_dev *ldev;
 
 	sector_t p_size;     /* partner's disk size */
 	struct request_queue *rq_queue;
-- 
2.38.1

