Return-Path: <BATV+bd67e5505ea4382539b6+4387+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7E8721055722
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 09:31:15 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Date: Fri, 28 Aug 2015 09:27:22 +0200
Message-Id: <1440746842-19029-10-git-send-email-hch@lst.de>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: [Drbd-dev] [PATCH 9/9] gpio-mxc: stop including <asm-generic/bug>
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

<asm-generic/bug> contains the default implementation of BUG() and friends,
which architectures may decide to use.  The proper way to get them is
<linux/bug.h>, so use that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpio/gpio-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index ec1eb1b..95be265 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -33,7 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
-#include <asm-generic/bug.h>
+#include <linux/bug.h>
 
 enum mxc_gpio_hwtype {
 	IMX1_GPIO,	/* runs on i.mx1 */
-- 
1.9.1

