Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D8E3810518AC
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BE8F34615C4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id a7dZdyztUhKg for <drbd-dev@lists.linbit.com>;
	Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A06B54615F4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QQ8lzHvURKzw for <drbd-dev@lists.linbit.com>;
	Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 561C74615C4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:37:17 +0200 (CEST)
Resent-Message-ID: <20150917133716.GE7519@soda.linbit>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Date: Sun, 13 Sep 2015 14:15:14 +0200
Message-Id: <1442146532-9100-22-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/39] drbd: drop null test before destroy
	functions
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

Remove unneeded NULL test.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ expression x; @@
-if (x != NULL)
  \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/block/drbd/drbd_main.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 74d97f4..d98eeec 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2034,20 +2034,13 @@ static void drbd_destroy_mempools(void)
 
 	if (drbd_md_io_bio_set)
 		bioset_free(drbd_md_io_bio_set);
-	if (drbd_md_io_page_pool)
-		mempool_destroy(drbd_md_io_page_pool);
-	if (drbd_ee_mempool)
-		mempool_destroy(drbd_ee_mempool);
-	if (drbd_request_mempool)
-		mempool_destroy(drbd_request_mempool);
-	if (drbd_ee_cache)
-		kmem_cache_destroy(drbd_ee_cache);
-	if (drbd_request_cache)
-		kmem_cache_destroy(drbd_request_cache);
-	if (drbd_bm_ext_cache)
-		kmem_cache_destroy(drbd_bm_ext_cache);
-	if (drbd_al_ext_cache)
-		kmem_cache_destroy(drbd_al_ext_cache);
+	mempool_destroy(drbd_md_io_page_pool);
+	mempool_destroy(drbd_ee_mempool);
+	mempool_destroy(drbd_request_mempool);
+	kmem_cache_destroy(drbd_ee_cache);
+	kmem_cache_destroy(drbd_request_cache);
+	kmem_cache_destroy(drbd_bm_ext_cache);
+	kmem_cache_destroy(drbd_al_ext_cache);
 
 	drbd_md_io_bio_set   = NULL;
 	drbd_md_io_page_pool = NULL;

