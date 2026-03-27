Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 754241627CC
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2026 23:38:48 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
	5b1f17b1804b1-486fd5360d4so32697425e9.1
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2026 15:38:48 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/20] drbd: mark as BROKEN during DRBD 9 rework
Date: Fri, 27 Mar 2026 23:38:01 +0100
Message-ID: <20260327223820.2244227-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..b907b07468bb 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,6 +8,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
+	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.53.0

