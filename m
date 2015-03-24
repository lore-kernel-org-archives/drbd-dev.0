Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 092A510556B0
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 044E03D4520
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:09 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lxJv0AP1VUg5 for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:46:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DCD8A3D4561
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:07 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6ChWiB75rBXQ for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:46:07 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 578193CBB2B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:07 +0100 (CET)
Resent-Message-ID: <20150327144607.GC13700@soda.linbit>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C9AF01050594
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2015 00:22:57 +0100 (CET)
Received: by igbqf9 with SMTP id qf9so11507286igb.1
	for <drbd-dev@lists.linbit.com>; Tue, 24 Mar 2015 16:22:56 -0700 (PDT)
Date: Tue, 24 Mar 2015 16:22:54 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1503241622360.21805@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [patch resend 3/3] block,
	drbd: use mempool_create_slab_pool()
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
 
