Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 277C31055FB9
	for <drbd-dev@lists.linbit.com>; Thu, 25 Aug 2011 10:56:56 +0200 (CEST)
Resent-Message-ID: <20110825085653.GI14479@barkeeper1-xen.linbit>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E25711055FB9
	for <drbd-dev@lists.linbit.com>; Thu, 25 Aug 2011 10:31:23 +0200 (CEST)
From: =?UTF-8?q?Ren=C3=A9=20Nussbaumer?= <rn@google.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 25 Aug 2011 10:20:03 +0200
Message-Id: <1314260403-5572-1-git-send-email-rn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	=?UTF-8?q?Ren=C3=A9=20Nussbaumer?= <rn@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] [PATCH] DRBD: Fix /proc/drbd output
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Patch 4b0715f096 introduced an inconsistency in the output of /proc/drbd
while resyncing. Before that patch the "finish:"-line was places on a
new line with one tab indent. This is still true if the unit is KB but
not if it's MB.

This bug is not present in the upstream version of DRBD 8.3.11.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
Signed-off-by: René Nussbaumer <rn@google.com>
---
 drivers/block/drbd/drbd_proc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2959cdf..7340546 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -97,10 +97,12 @@ static void drbd_syncer_progress(struct drbd_conf *mdev, struct seq_file *seq)
 			    (unsigned long) Bit2KB(rs_left >> 10),
 			    (unsigned long) Bit2KB(mdev->rs_total >> 10));
 	else
-		seq_printf(seq, "(%lu/%lu)K\n\t",
+		seq_printf(seq, "(%lu/%lu)K",
 			    (unsigned long) Bit2KB(rs_left),
 			    (unsigned long) Bit2KB(mdev->rs_total));
 
+	seq_printf(seq, "\n\t");
+
 	/* see drivers/md/md.c
 	 * We do not want to overflow, so the order of operands and
 	 * the * 100 / 100 trick are important. We do a +1 to be
-- 
1.7.3.1

