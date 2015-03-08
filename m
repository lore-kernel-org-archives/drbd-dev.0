Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 25A5B1050584
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1ED3644D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:05 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QSLd_q0JqJkV for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F414844D398
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:04 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qFbdloGhAISq for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:04 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CAC5244D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:04 +0100 (CET)
Resent-Message-ID: <20150312230804.GM3961@soda.linbit>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 72C6F104B1D2
	for <drbd-dev@lists.linbit.com>; Sun,  8 Mar 2015 01:31:03 +0100 (CET)
Received: by iecrp18 with SMTP id rp18so26707463iec.10
	for <drbd-dev@lists.linbit.com>; Sat, 07 Mar 2015 16:31:03 -0800 (PST)
Date: Sat, 7 Mar 2015 16:24:30 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Jens Axboe <axboe@fb.com>, Lars Ellenberg <drbd-dev@lists.linbit.com>
In-Reply-To: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1503071624160.31688@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch 2/2] block, drbd: use mempool_create_slab_pool()
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

Mempools created for slab caches should use
mempool_create_slab_pool().

Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/block/drbd/drbd_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2107,13 +2107,12 @@ static int drbd_create_mempools(void)
 	if (drbd_md_io_page_pool == NULL)
 		goto Enomem;
 
-	drbd_request_mempool = mempool_create(number,
-		mempool_alloc_slab, mempool_free_slab, drbd_request_cache);
+	drbd_request_mempool = mempool_create_slab_pool(number,
+		drbd_request_cache);
 	if (drbd_request_mempool == NULL)
 		goto Enomem;
 
-	drbd_ee_mempool = mempool_create(number,
-		mempool_alloc_slab, mempool_free_slab, drbd_ee_cache);
+	drbd_ee_mempool = mempool_create_slab_pool(number, drbd_ee_cache);
 	if (drbd_ee_mempool == NULL)
 		goto Enomem;
 
