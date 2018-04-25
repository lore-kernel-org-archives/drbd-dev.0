Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 510F610575BF
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 18:22:11 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 25 Apr 2018 17:48:15 +0200
Message-Id: <20180425154827.32251-29-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 28/40] bonding: switch to proc_create_seq_data
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
 drivers/net/bonding/bond_procfs.c | 36 ++++++-------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 01059f1a7bca..9f7d83e827c3 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -10,7 +10,7 @@
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	loff_t off = 0;
@@ -29,7 +29,7 @@ static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bond_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	bool found = false;
@@ -56,7 +56,7 @@ static void bond_info_seq_stop(struct seq_file *seq, void *v)
 
 static void bond_info_show_master(struct seq_file *seq)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
 	int i;
@@ -167,7 +167,7 @@ static void bond_info_show_master(struct seq_file *seq)
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 
 	seq_printf(seq, "\nSlave Interface: %s\n", slave->dev->name);
 	seq_printf(seq, "MII Status: %s\n", bond_slave_link_status(slave->link));
@@ -257,38 +257,14 @@ static const struct seq_operations bond_info_seq_ops = {
 	.show  = bond_info_seq_show,
 };
 
-static int bond_info_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int res;
-
-	res = seq_open(file, &bond_info_seq_ops);
-	if (!res) {
-		/* recover the pointer buried in proc_dir_entry data */
-		seq = file->private_data;
-		seq->private = PDE_DATA(inode);
-	}
-
-	return res;
-}
-
-static const struct file_operations bond_info_fops = {
-	.owner   = THIS_MODULE,
-	.open    = bond_info_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 void bond_create_proc_entry(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct bond_net *bn = net_generic(dev_net(bond_dev), bond_net_id);
 
 	if (bn->proc_dir) {
-		bond->proc_entry = proc_create_data(bond_dev->name,
-						    0444, bn->proc_dir,
-						    &bond_info_fops, bond);
+		bond->proc_entry = proc_create_seq_data(bond_dev->name, 0444,
+				bn->proc_dir, &bond_info_seq_ops, bond);
 		if (bond->proc_entry == NULL)
 			netdev_warn(bond_dev, "Cannot create /proc/net/%s/%s\n",
 				    DRV_NAME, bond_dev->name);
-- 
2.17.0

