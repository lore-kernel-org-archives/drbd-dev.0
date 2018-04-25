Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C45C9105732E
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 18:06:44 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 25 Apr 2018 17:48:21 +0200
Message-Id: <20180425154827.32251-35-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 34/40] atm: simplify procfs code
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

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/atm/proc.c | 65 ++++++--------------------------------------------
 1 file changed, 7 insertions(+), 58 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index 55410c00c7e2..f272b0f59d82 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -257,18 +257,6 @@ static const struct seq_operations atm_dev_seq_ops = {
 	.show	= atm_dev_seq_show,
 };
 
-static int atm_dev_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &atm_dev_seq_ops);
-}
-
-static const struct file_operations devices_seq_fops = {
-	.open		= atm_dev_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int pvc_seq_show(struct seq_file *seq, void *v)
 {
 	static char atm_pvc_banner[] =
@@ -440,58 +428,19 @@ void atm_proc_dev_deregister(struct atm_dev *dev)
 	kfree(dev->proc_name);
 }
 
-static struct atm_proc_entry {
-	char *name;
-	const struct file_operations *proc_fops;
-	struct proc_dir_entry *dirent;
-} atm_proc_ents[] = {
-	{ .name = "devices",	.proc_fops = &devices_seq_fops },
-	{ .name = "pvc",	.proc_fops = &pvc_seq_fops },
-	{ .name = "svc",	.proc_fops = &svc_seq_fops },
-	{ .name = "vc",		.proc_fops = &vcc_seq_fops },
-	{ .name = NULL,		.proc_fops = NULL }
-};
-
-static void atm_proc_dirs_remove(void)
-{
-	static struct atm_proc_entry *e;
-
-	for (e = atm_proc_ents; e->name; e++) {
-		if (e->dirent)
-			remove_proc_entry(e->name, atm_proc_root);
-	}
-	remove_proc_entry("atm", init_net.proc_net);
-}
-
 int __init atm_proc_init(void)
 {
-	static struct atm_proc_entry *e;
-	int ret;
-
 	atm_proc_root = proc_net_mkdir(&init_net, "atm", init_net.proc_net);
 	if (!atm_proc_root)
-		goto err_out;
-	for (e = atm_proc_ents; e->name; e++) {
-		struct proc_dir_entry *dirent;
-
-		dirent = proc_create(e->name, 0444,
-				     atm_proc_root, e->proc_fops);
-		if (!dirent)
-			goto err_out_remove;
-		e->dirent = dirent;
-	}
-	ret = 0;
-out:
-	return ret;
-
-err_out_remove:
-	atm_proc_dirs_remove();
-err_out:
-	ret = -ENOMEM;
-	goto out;
+		return -ENOMEM;
+	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
+	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
+	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
+	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
+	return 0;
 }
 
 void atm_proc_exit(void)
 {
-	atm_proc_dirs_remove();
+	remove_proc_subtree("atm", init_net.proc_net);
 }
-- 
2.17.0

