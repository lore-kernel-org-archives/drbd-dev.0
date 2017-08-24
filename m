Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 335471058019
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:53 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id b189so4599511wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:53 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:08 +0200
Message-Id: <1503609794-13233-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/17] drbd: A single dot should be put into a
	sequence.
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

From: Markus Elfring <elfring@users.sourceforge.net>

Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 8378142..fc0f627 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -127,7 +127,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 		seq_putc(seq, '=');
 	seq_putc(seq, '>');
 	for (i = 0; i < y; i++)
-		seq_printf(seq, ".");
+		seq_putc(seq, '.');
 	seq_puts(seq, "] ");
 
 	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)
-- 
2.7.4

