Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 552D81005431
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:32:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 3DCCD1B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:32:31 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OpV2aYWP98lt for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:32:31 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 1DAF31B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:32:31 +0200 (CEST)
Resent-Message-ID: <20120726093229.GJ29767@soda.linbit>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 86CBF10000EC
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 17:21:16 +0200 (CEST)
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 25 Jul 2012 18:12:12 +0300
Message-Id: <1343229134-29487-15-git-send-email-artem.bityutskiy@linux.intel.com>
In-Reply-To: <1343229134-29487-1-git-send-email-artem.bityutskiy@linux.intel.com>
References: <1343229134-29487-1-git-send-email-artem.bityutskiy@linux.intel.com>
Cc: Linux FS Maling List <linux-fsdevel@vger.kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Linux Kernel Maling List <linux-kernel@vger.kernel.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/16] drbd: nuke pdflush from comments
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The pdflush thread is long gone, so this patch removes references to pdflush
from drbd comments.

Cc: drbd-dev@lists.linbit.com
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

I expect this patch to be merged via Al Viro's VFS tree.

 drivers/block/drbd/drbd_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 920ede2..974f2b6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3521,9 +3521,9 @@ static void drbd_cleanup(void)
 }
 
 /**
- * drbd_congested() - Callback for pdflush
+ * drbd_congested() - Callback for the flusher thread
  * @congested_data:	User data
- * @bdi_bits:		Bits pdflush is currently interested in
+ * @bdi_bits:		Bits the BDI flusher thread is currently interested in
  *
  * Returns 1<<BDI_async_congested and/or 1<<BDI_sync_congested if we are congested.
  */
-- 
1.7.10

