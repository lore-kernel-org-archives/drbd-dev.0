Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9A2011057880
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 18:22:14 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 25 Apr 2018 17:48:11 +0200
Message-Id: <20180425154827.32251-25-hch@lst.de>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 24/40] staging/rtl8192u: simplify procfs code
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

Unwind the registration loop into individual calls.  Switch to use
proc_create_single where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/rtl8192u/r8192U_core.c | 67 ++++++--------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d607c59761cf..7a0dbc0fa18e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -646,64 +646,25 @@ static void rtl8192_proc_module_init(void)
 	rtl8192_proc = proc_mkdir(RTL819xU_MODULE_NAME, init_net.proc_net);
 }
 
-/*
- * seq_file wrappers for procfile show routines.
- */
-static int rtl8192_proc_open(struct inode *inode, struct file *file)
-{
-	struct net_device *dev = proc_get_parent_data(inode);
-	int (*show)(struct seq_file *, void *) = PDE_DATA(inode);
-
-	return single_open(file, show, dev);
-}
-
-static const struct file_operations rtl8192_proc_fops = {
-	.open		= rtl8192_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-/*
- * Table of proc files we need to create.
- */
-struct rtl8192_proc_file {
-	char name[12];
-	int (*show)(struct seq_file *, void *);
-};
-
-static const struct rtl8192_proc_file rtl8192_proc_files[] = {
-	{ "stats-rx",	&proc_get_stats_rx },
-	{ "stats-tx",	&proc_get_stats_tx },
-	{ "stats-ap",	&proc_get_stats_ap },
-	{ "registers",	&proc_get_registers },
-	{ "" }
-};
-
 static void rtl8192_proc_init_one(struct net_device *dev)
 {
-	const struct rtl8192_proc_file *f;
 	struct proc_dir_entry *dir;
 
-	if (rtl8192_proc) {
-		dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
-		if (!dir) {
-			RT_TRACE(COMP_ERR,
-				 "Unable to initialize /proc/net/rtl8192/%s\n",
-				 dev->name);
-			return;
-		}
+	if (!rtl8192_proc)
+		return;
 
-		for (f = rtl8192_proc_files; f->name[0]; f++) {
-			if (!proc_create_data(f->name, S_IFREG | S_IRUGO, dir,
-					      &rtl8192_proc_fops, f->show)) {
-				RT_TRACE(COMP_ERR,
-					 "Unable to initialize /proc/net/rtl8192/%s/%s\n",
-					 dev->name, f->name);
-				return;
-			}
-		}
-	}
+	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
+	if (!dir)
+		return;
+
+	proc_create_single("stats-rx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_rx);
+	proc_create_single("stats-tx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_tx);
+	proc_create_single("stats-ap", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_ap);
+	proc_create_single("registers", S_IFREG | S_IRUGO, dir,
+			proc_get_registers);
 }
 
 static void rtl8192_proc_remove_one(struct net_device *dev)
-- 
2.17.0

