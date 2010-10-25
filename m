Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E22661058FBB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Oct 2010 00:50:23 +0200 (CEST)
Message-Id: <201010252250.o9PMoC5Q020891@imap1.linux-foundation.org>
To: mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Mon, 25 Oct 2010 15:50:12 -0700
Cc: nikai@nikai.net, axboe@kernel.dk, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] + drivers-block-drbd-drbd_mainc-fix-error-path.patch
	added to -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


The patch titled
     drivers/block/drbd/drbd_main.c: fix error path
has been added to the -mm tree.  Its filename is
     drivers-block-drbd-drbd_mainc-fix-error-path.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/SubmitChecklist when testing your code ***

See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
out what to do about this

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: drivers/block/drbd/drbd_main.c: fix error path
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

Patches currently in -mm which might be from nikai@nikai.net are

origin.patch
linux-next.patch
drivers-media-video-gspca-cpia1c-fix-error-check.patch
drivers-block-drbd-drbd_mainc-fix-error-path.patch
drivers-crypto-dubious-error-check.patch

