Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BC8581055F4A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B76CF2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YV-lc9yUCxFM for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8D37E2ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xYqHd9q3YeEK for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 652822A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:10 +0100 (CET)
Resent-Message-ID: <20151130193010.GK22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E0E4310518AB
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:27:27 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:08 +0100
Message-Id: <1448659575-13485-4-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/21] drbd: use seq_put instead of seq_print
	where possible
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

seq_putc/seq_puts give the following improvements:

text   data  bss    dec	    hex	filename
4661      0  8	   4669	   123d	drivers/block/drbd/drbd_proc.o
4603      0  8	   4611	   1203	drivers/block/drbd/drbd_proc-after.o

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_proc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 6537b25..233a710 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -122,18 +122,18 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 
 	x = res/50;
 	y = 20-x;
-	seq_printf(seq, "\t[");
+	seq_puts(seq, "\t[");
 	for (i = 1; i < x; i++)
-		seq_printf(seq, "=");
-	seq_printf(seq, ">");
+		seq_putc(seq, '=');
+	seq_putc(seq, '>');
 	for (i = 0; i < y; i++)
 		seq_printf(seq, ".");
-	seq_printf(seq, "] ");
+	seq_puts(seq, "] ");
 
 	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)
-		seq_printf(seq, "verified:");
+		seq_puts(seq, "verified:");
 	else
-		seq_printf(seq, "sync'ed:");
+		seq_puts(seq, "sync'ed:");
 	seq_printf(seq, "%3u.%u%% ", res / 10, res % 10);
 
 	/* if more than a few GB, display in MB */
@@ -146,7 +146,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 			    (unsigned long) Bit2KB(rs_left),
 			    (unsigned long) Bit2KB(rs_total));
 
-	seq_printf(seq, "\n\t");
+	seq_puts(seq, "\n\t");
 
 	/* see drivers/md/md.c
 	 * We do not want to overflow, so the order of operands and
@@ -175,9 +175,9 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 		rt / 3600, (rt % 3600) / 60, rt % 60);
 
 	dbdt = Bit2KB(db/dt);
-	seq_printf(seq, " speed: ");
+	seq_puts(seq, " speed: ");
 	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_printf(seq, " (");
+	seq_puts(seq, " (");
 	/* ------------------------- ~3s average ------------------------ */
 	if (proc_details >= 1) {
 		/* this is what drbd_rs_should_slow_down() uses */
@@ -188,7 +188,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 		db = device->rs_mark_left[i] - rs_left;
 		dbdt = Bit2KB(db/dt);
 		seq_printf_with_thousands_grouping(seq, dbdt);
-		seq_printf(seq, " -- ");
+		seq_puts(seq, " -- ");
 	}
 
 	/* --------------------- long term average ---------------------- */
@@ -200,11 +200,11 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	db = rs_total - rs_left;
 	dbdt = Bit2KB(db/dt);
 	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_printf(seq, ")");
+	seq_putc(seq, ')');
 
 	if (state.conn == C_SYNC_TARGET ||
 	    state.conn == C_VERIFY_S) {
-		seq_printf(seq, " want: ");
+		seq_puts(seq, " want: ");
 		seq_printf_with_thousands_grouping(seq, device->c_sync_rate);
 	}
 	seq_printf(seq, " K/sec%s\n", stalled ? " (stalled)" : "");
@@ -231,7 +231,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 			(unsigned long long)bm_bits * BM_SECT_PER_BIT);
 		if (stop_sector != 0 && stop_sector != ULLONG_MAX)
 			seq_printf(seq, " stop sector: %llu", stop_sector);
-		seq_printf(seq, "\n");
+		seq_putc(seq, '\n');
 	}
 }
 
@@ -276,7 +276,7 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 	rcu_read_lock();
 	idr_for_each_entry(&drbd_devices, device, i) {
 		if (prev_i != i - 1)
-			seq_printf(seq, "\n");
+			seq_putc(seq, '\n');
 		prev_i = i;
 
 		state = device->state;
-- 
2.1.4

