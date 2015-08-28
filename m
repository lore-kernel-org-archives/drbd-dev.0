Return-Path: <BATV+bd67e5505ea4382539b6+4387+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5C77410556B0
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 09:30:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Date: Fri, 28 Aug 2015 09:27:16 +0200
Message-Id: <1440746842-19029-4-git-send-email-hch@lst.de>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: [Drbd-dev] [PATCH 3/9] amdkfd: use <linux/mman.h> instead of
	<uapi/asm-generic/mman-common.h>
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

The latter is a default version of <asm/mman.h> and not for driver use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index c991973..c6a1b4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -31,7 +31,7 @@
 #include <uapi/linux/kfd_ioctl.h>
 #include <linux/time.h>
 #include <linux/mm.h>
-#include <uapi/asm-generic/mman-common.h>
+#include <linux/mman.h>
 #include <asm/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 35b9875..2b65510 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -33,7 +33,7 @@
 #include <linux/time.h>
 #include "kfd_priv.h"
 #include <linux/mm.h>
-#include <uapi/asm-generic/mman-common.h>
+#include <linux/mman.h>
 #include <asm/processor.h>
 
 /*
-- 
1.9.1

