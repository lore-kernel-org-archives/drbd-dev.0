Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3DCFA1011BE7
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jun 2012 20:47:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 2FF0A4CE003
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jun 2012 20:47:06 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZMVphZA+eL8 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jun 2012 20:47:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 0279A4CE001
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jun 2012 20:47:06 +0200 (CEST)
Resent-Message-ID: <20120608184705.GB8030@soda.linbit>
Date: Fri, 8 Jun 2012 15:31:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20120608123128.GA18293@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch -resend] drbd: fix resync_dump_detail() output
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
---
I sent this to the drbd-user list in March, but never recieved a
response.

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
 
