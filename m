Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 083CB105733B
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 18:22:08 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 25 Apr 2018 17:48:12 +0200
Message-Id: <20180425154827.32251-26-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 25/40] resource: switch to proc_create_seq_data
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

And use the root resource directly from the proc private data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/resource.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2af6c03858b9..b589dda910b3 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -87,7 +87,7 @@ enum { MAX_IORES_LEVEL = 5 };
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
 {
-	struct resource *p = m->private;
+	struct resource *p = PDE_DATA(file_inode(m->file));
 	loff_t l = 0;
 	read_lock(&resource_lock);
 	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
@@ -103,7 +103,7 @@ static void r_stop(struct seq_file *m, void *v)
 
 static int r_show(struct seq_file *m, void *v)
 {
-	struct resource *root = m->private;
+	struct resource *root = PDE_DATA(file_inode(m->file));
 	struct resource *r = v, *p;
 	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
@@ -135,44 +135,11 @@ static const struct seq_operations resource_op = {
 	.show	= r_show,
 };
 
-static int ioports_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &ioport_resource;
-	}
-	return res;
-}
-
-static int iomem_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &iomem_resource;
-	}
-	return res;
-}
-
-static const struct file_operations proc_ioports_operations = {
-	.open		= ioports_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static const struct file_operations proc_iomem_operations = {
-	.open		= iomem_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int __init ioresources_init(void)
 {
-	proc_create("ioports", 0, NULL, &proc_ioports_operations);
-	proc_create("iomem", 0, NULL, &proc_iomem_operations);
+	proc_create_seq_data("ioports", 0, NULL, &resource_op,
+			&ioport_resource);
+	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
 	return 0;
 }
 __initcall(ioresources_init);
-- 
2.17.0

