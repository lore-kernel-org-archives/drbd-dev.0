Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D8E841059228
	for <drbd-dev@lists.linbit.com>; Wed, 27 Oct 2010 21:44:04 +0200 (CEST)
Message-Id: <201010271943.o9RJh9cY013845@imap1.linux-foundation.org>
To: axboe@kernel.dk
From: akpm@linux-foundation.org
Date: Wed, 27 Oct 2010 12:43:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Cc: nikai@nikai.net, akpm@linux-foundation.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch 4/4] drivers/block/drbd/drbd_main.c: fix error
	path
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Nicolas Kaiser <nikai@nikai.net>

Failure to create drbd_ee_mempool appears not to get checked.  Looks like
a copy-and-paste problem to me.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/drbd/drbd_main.c~drivers-block-drbd-drbd_mainc-fix-error-path drivers/block/drbd/drbd_main.c
--- a/drivers/block/drbd/drbd_main.c~drivers-block-drbd-drbd_mainc-fix-error-path
+++ a/drivers/block/drbd/drbd_main.c
@@ -2982,7 +2982,7 @@ static int drbd_create_mempools(void)
 
 	drbd_ee_mempool = mempool_create(number,
 		mempool_alloc_slab, mempool_free_slab, drbd_ee_cache);
-	if (drbd_request_mempool == NULL)
+	if (drbd_ee_mempool == NULL)
 		goto Enomem;
 
 	/* drbd's page pool */
_
