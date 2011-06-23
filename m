Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E23C1056AA5
	for <drbd-dev@lists.linbit.com>; Fri, 24 Jun 2011 11:48:22 +0200 (CEST)
Resent-Message-ID: <20110624094821.GA29996@barkeeper1-xen.linbit>
Date: Fri, 24 Jun 2011 00:09:17 +0200 (CEST)
From: Jesper Juhl <jj@chaosbits.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1106240008200.17688@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, trivial@kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 08/37] Remove unneeded version.h includes from
 drivers/block/
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

It was pointed out by 'make versioncheck' that some includes of
linux/version.h are not needed in drivers/block/.
This patch removes them.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/block/drbd/drbd_int.h      |    1 -
 drivers/block/xen-blkback/common.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ef2ceed..1c3194d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -28,7 +28,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 9e40b28..0d04c7f 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -27,7 +27,6 @@
 #ifndef __XEN_BLKIF__BACKEND__COMMON_H__
 #define __XEN_BLKIF__BACKEND__COMMON_H__
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-- 
1.7.5.2


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

