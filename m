Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 31B1C105CA48
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2012 20:39:53 +0100 (CET)
Resent-Message-ID: <20120307193953.GI3407@barkeeper1-xen.linbit>
Date: Wed, 7 Mar 2012 13:03:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20120307100301.GC25452@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: fix resync_dump_detail() output
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The tests here aren't correct.  It should be doing a shift before doing
the bitwise AND.  (bme->flags & BME_NO_WRITES) is always false and
(bme->flags & BME_LOCKED) checks for BME_NO_WRITES instead of checking
for locked.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2959cdf..ffe1ee4 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -187,8 +187,10 @@ static void resync_dump_detail(struct seq_file *seq, struct lc_element *e)
 	struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
 
 	seq_printf(seq, "%5d %s %s\n", bme->rs_left,
-		   bme->flags & BME_NO_WRITES ? "NO_WRITES" : "---------",
-		   bme->flags & BME_LOCKED ? "LOCKED" : "------"
+		   test_bit(BME_NO_WRITES, &bme->flags) ?
+			"NO_WRITES" : "---------",
+		   test_bit(BME_LOCKED, &bme->flags) ?
+			"LOCKED" : "------"
 		   );
 }
 
