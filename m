Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 316031057315
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:06:42 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Thu, 19 Apr 2018 14:41:11 +0200
Message-Id: <20180419124140.9309-11-hch@lst.de>
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/39] net/kcm: simplify proc registration
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

Remove a couple indirections to make the code look like most other
protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/kcm/kcmproc.c | 71 ++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/net/kcm/kcmproc.c b/net/kcm/kcmproc.c
index 1fac92543094..6d0667e62baf 100644
--- a/net/kcm/kcmproc.c
+++ b/net/kcm/kcmproc.c
@@ -15,12 +15,6 @@
 #include <net/tcp.h>
 
 #ifdef CONFIG_PROC_FS
-struct kcm_seq_muxinfo {
-	char				*name;
-	const struct file_operations	*seq_fops;
-	const struct seq_operations	seq_ops;
-};
-
 static struct kcm_mux *kcm_get_first(struct seq_file *seq)
 {
 	struct net *net = seq_file_net(seq);
@@ -86,14 +80,6 @@ struct kcm_proc_mux_state {
 	int idx;
 };
 
-static int kcm_seq_open(struct inode *inode, struct file *file)
-{
-	struct kcm_seq_muxinfo *muxinfo = PDE_DATA(inode);
-
-	return seq_open_net(inode, file, &muxinfo->seq_ops,
-			   sizeof(struct kcm_proc_mux_state));
-}
-
 static void kcm_format_mux_header(struct seq_file *seq)
 {
 	struct net *net = seq_file_net(seq);
@@ -246,6 +232,19 @@ static int kcm_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static const struct seq_operations kcm_seq_ops = {
+	.show	= kcm_seq_show,
+	.start	= kcm_seq_start,
+	.next	= kcm_seq_next,
+	.stop	= kcm_seq_stop,
+};
+
+static int kcm_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &kcm_seq_ops,
+			   sizeof(struct kcm_proc_mux_state));
+}
+
 static const struct file_operations kcm_seq_fops = {
 	.open		= kcm_seq_open,
 	.read		= seq_read,
@@ -253,37 +252,6 @@ static const struct file_operations kcm_seq_fops = {
 	.release	= seq_release_net,
 };
 
-static struct kcm_seq_muxinfo kcm_seq_muxinfo = {
-	.name		= "kcm",
-	.seq_fops	= &kcm_seq_fops,
-	.seq_ops	= {
-		.show	= kcm_seq_show,
-		.start	= kcm_seq_start,
-		.next	= kcm_seq_next,
-		.stop	= kcm_seq_stop,
-	}
-};
-
-static int kcm_proc_register(struct net *net, struct kcm_seq_muxinfo *muxinfo)
-{
-	struct proc_dir_entry *p;
-	int rc = 0;
-
-	p = proc_create_data(muxinfo->name, 0444, net->proc_net,
-			     muxinfo->seq_fops, muxinfo);
-	if (!p)
-		rc = -ENOMEM;
-	return rc;
-}
-EXPORT_SYMBOL(kcm_proc_register);
-
-static void kcm_proc_unregister(struct net *net,
-				struct kcm_seq_muxinfo *muxinfo)
-{
-	remove_proc_entry(muxinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL(kcm_proc_unregister);
-
 static int kcm_stats_seq_show(struct seq_file *seq, void *v)
 {
 	struct kcm_psock_stats psock_stats;
@@ -404,16 +372,11 @@ static const struct file_operations kcm_stats_seq_fops = {
 
 static int kcm_proc_init_net(struct net *net)
 {
-	int err;
-
 	if (!proc_create("kcm_stats", 0444, net->proc_net,
-			 &kcm_stats_seq_fops)) {
-		err = -ENOMEM;
+			 &kcm_stats_seq_fops))
 		goto out_kcm_stats;
-	}
 
-	err = kcm_proc_register(net, &kcm_seq_muxinfo);
-	if (err)
+	if (!proc_create("kcm", 0444, net->proc_net, &kcm_seq_fops))
 		goto out_kcm;
 
 	return 0;
@@ -421,12 +384,12 @@ static int kcm_proc_init_net(struct net *net)
 out_kcm:
 	remove_proc_entry("kcm_stats", net->proc_net);
 out_kcm_stats:
-	return err;
+	return -ENOMEM;
 }
 
 static void kcm_proc_exit_net(struct net *net)
 {
-	kcm_proc_unregister(net, &kcm_seq_muxinfo);
+	remove_proc_entry("kcm", net->proc_net);
 	remove_proc_entry("kcm_stats", net->proc_net);
 }
 
-- 
2.17.0

