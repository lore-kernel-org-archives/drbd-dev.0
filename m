Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 38E051057327
	for <drbd-dev@lists.linbit.com>; Wed, 16 May 2018 12:06:45 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 16 May 2018 11:43:36 +0200
Message-Id: <20180516094346.20506-33-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 32/42] neigh: switch to proc_create_seq_data
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

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/core/neighbour.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ce519861be59..1fb43bff417d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -59,7 +59,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				    struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
-static const struct file_operations neigh_stat_seq_fops;
+static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
 /*
@@ -1558,8 +1558,8 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		panic("cannot create neighbour cache statistics");
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_data(tbl->id, 0, init_net.proc_net_stat,
-			      &neigh_stat_seq_fops, tbl))
+	if (!proc_create_seq_data(tbl->id, 0, init_net.proc_net_stat,
+			      &neigh_stat_seq_ops, tbl))
 		panic("cannot create neighbour proc dir entry");
 #endif
 
@@ -2786,7 +2786,7 @@ EXPORT_SYMBOL(neigh_seq_stop);
 
 static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	if (*pos == 0)
@@ -2803,7 +2803,7 @@ static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *neigh_stat_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
@@ -2822,7 +2822,7 @@ static void neigh_stat_seq_stop(struct seq_file *seq, void *v)
 
 static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	struct neigh_statistics *st = v;
 
 	if (v == SEQ_START_TOKEN) {
@@ -2861,25 +2861,6 @@ static const struct seq_operations neigh_stat_seq_ops = {
 	.stop	= neigh_stat_seq_stop,
 	.show	= neigh_stat_seq_show,
 };
-
-static int neigh_stat_seq_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &neigh_stat_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-};
-
-static const struct file_operations neigh_stat_seq_fops = {
-	.open 	 = neigh_stat_seq_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release,
-};
-
 #endif /* CONFIG_PROC_FS */
 
 static inline size_t neigh_nlmsg_size(void)
-- 
2.17.0

