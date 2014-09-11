Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7ED80101E07A
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:13 +0200
Message-Id: <1410438553-30440-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 9/9] drbd: Add missing newline in resync progress
	display in /proc/drbd
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

Was broken in 2010 with commit 4b0715f096

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 06e6147..3b10fa6 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -142,10 +142,12 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 			    (unsigned long) Bit2KB(rs_left >> 10),
 			    (unsigned long) Bit2KB(rs_total >> 10));
 	else
-		seq_printf(seq, "(%lu/%lu)K\n\t",
+		seq_printf(seq, "(%lu/%lu)K",
 			    (unsigned long) Bit2KB(rs_left),
 			    (unsigned long) Bit2KB(rs_total));
 
+	seq_printf(seq, "\n\t");
+
 	/* see drivers/md/md.c
 	 * We do not want to overflow, so the order of operands and
 	 * the * 100 / 100 trick are important. We do a +1 to be
-- 
1.9.1

