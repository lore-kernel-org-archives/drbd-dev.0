Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E490610567B0
	for <drbd-dev@lists.linbit.com>; Wed,  3 Aug 2011 20:58:11 +0200 (CEST)
Message-Id: <201108031857.p73IvRUY006738@imap1.linux-foundation.org>
To: hartleys@visionengravers.com, axboe@kernel.dk, drbd-dev@lists.linbit.com,
	hsweeten@visionengravers.com, philipp.reisner@linbit.com,
	mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Wed, 03 Aug 2011 11:59:58 -0700
Subject: [Drbd-dev] [merged]
	drivers-block-drbd-drbd_nlc-use-bitmap_parse-instead-of-__bitmap_parse.patch
	removed from -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


The patch titled
     drivers/block/drbd/drbd_nl.c: use bitmap_parse instead of __bitmap_parse
has been removed from the -mm tree.  Its filename was
     drivers-block-drbd-drbd_nlc-use-bitmap_parse-instead-of-__bitmap_parse.patch

This patch was dropped because it was merged into mainline or a subsystem tree

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: drivers/block/drbd/drbd_nl.c: use bitmap_parse instead of __bitmap_parse
From: H Hartley Sweeten <hartleys@visionengravers.com>

The buffer 'sc.cpu_mask' is a kernel buffer.  If bitmap_parse is used
instead of __bitmap_parse the extra parameter that indicates a kernel
buffer is not needed.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_nl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/drbd/drbd_nl.c~drivers-block-drbd-drbd_nlc-use-bitmap_parse-instead-of-__bitmap_parse drivers/block/drbd/drbd_nl.c
--- a/drivers/block/drbd/drbd_nl.c~drivers-block-drbd-drbd_nlc-use-bitmap_parse-instead-of-__bitmap_parse
+++ a/drivers/block/drbd/drbd_nl.c
@@ -1829,10 +1829,10 @@ static int drbd_nl_syncer_conf(struct dr
 
 	/* silently ignore cpu mask on UP kernel */
 	if (nr_cpu_ids > 1 && sc.cpu_mask[0] != 0) {
-		err = __bitmap_parse(sc.cpu_mask, 32, 0,
+		err = bitmap_parse(sc.cpu_mask, 32,
 				cpumask_bits(new_cpu_mask), nr_cpu_ids);
 		if (err) {
-			dev_warn(DEV, "__bitmap_parse() failed with %d\n", err);
+			dev_warn(DEV, "bitmap_parse() failed with %d\n", err);
 			retcode = ERR_CPU_MASK_PARSE;
 			goto fail;
 		}
_

Patches currently in -mm which might be from hartleys@visionengravers.com are

origin.patch
linux-next.patch

