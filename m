Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9DBFA1057318
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:37:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Thu, 19 Apr 2018 14:41:32 +0200
Message-Id: <20180419124140.9309-32-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 31/39] netfilter/x_tables: switch to
	proc_create_seq_private
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

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 344dd01a5027..0e314f95a4a3 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1648,22 +1648,6 @@ static const struct seq_operations xt_match_seq_ops = {
 	.show	= xt_match_seq_show,
 };
 
-static int xt_match_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_match_ops = {
-	.open	 = xt_match_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 static void *xt_target_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	return xt_mttg_seq_start(seq, pos, true);
@@ -1698,22 +1682,6 @@ static const struct seq_operations xt_target_seq_ops = {
 	.show	= xt_target_seq_show,
 };
 
-static int xt_target_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_target_ops = {
-	.open	 = xt_target_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 #define FORMAT_TABLES	"_tables_names"
 #define	FORMAT_MATCHES	"_tables_matches"
 #define FORMAT_TARGETS 	"_tables_targets"
@@ -1787,8 +1755,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_match_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
+			(void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_tables;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
@@ -1796,8 +1765,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_target_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
+			 (void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_matches;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
-- 
2.17.0

