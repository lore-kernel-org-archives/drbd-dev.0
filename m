Return-Path: <BATV+bd67e5505ea4382539b6+4387+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2F08B1055707
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 09:31:01 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Date: Fri, 28 Aug 2015 09:27:19 +0200
Message-Id: <1440746842-19029-7-git-send-email-hch@lst.de>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: [Drbd-dev] [PATCH 6/9] mlx5: stop including
	<asm-generic/kmap_types.h>
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

<linux/highmem.h> is the placace the get the kmap type flags, asm-generic
files are generic implementations only to be used by architecture code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/hw/mlx5/main.c                   | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 085c24b..37d7c0e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 75ff58d..594a149 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 06e3e1e..b9140b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 8a64542..fda02ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  */
 
-#include <asm-generic/kmap_types.h>
+#include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mlx5/driver.h>
-- 
1.9.1

