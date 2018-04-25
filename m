Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0004E1057332
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 17:50:12 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 25 Apr 2018 17:48:00 +0200
Message-Id: <20180425154827.32251-14-hch@lst.de>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Subject: [Drbd-dev] =?utf-8?q?=5BPATCH_13/40=5D_netfilter/x=5Ftables=3A_si?=
	=?utf-8?q?mplify_=D1=95eq=5Ffile_code?=
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

Just use the address family from the proc private data instead of copying
it into per-file data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 71325fef647d..3704101af27f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1489,15 +1489,10 @@ void *xt_unregister_table(struct xt_table *table)
 EXPORT_SYMBOL_GPL(xt_unregister_table);
 
 #ifdef CONFIG_PROC_FS
-struct xt_names_priv {
-	struct seq_net_private p;
-	u_int8_t af;
-};
 static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct xt_names_priv *priv = seq->private;
 	struct net *net = seq_file_net(seq);
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	mutex_lock(&xt[af].mutex);
 	return seq_list_start(&net->xt.tables[af], *pos);
@@ -1505,17 +1500,15 @@ static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *xt_table_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct xt_names_priv *priv = seq->private;
 	struct net *net = seq_file_net(seq);
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	return seq_list_next(v, &net->xt.tables[af], pos);
 }
 
 static void xt_table_seq_stop(struct seq_file *seq, void *v)
 {
-	struct xt_names_priv *priv = seq->private;
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	mutex_unlock(&xt[af].mutex);
 }
@@ -1538,16 +1531,8 @@ static const struct seq_operations xt_table_seq_ops = {
 
 static int xt_table_open(struct inode *inode, struct file *file)
 {
-	int ret;
-	struct xt_names_priv *priv;
-
-	ret = seq_open_net(inode, file, &xt_table_seq_ops,
-			   sizeof(struct xt_names_priv));
-	if (!ret) {
-		priv = ((struct seq_file *)file->private_data)->private;
-		priv->af = (unsigned long)PDE_DATA(inode);
-	}
-	return ret;
+	return seq_open_net(inode, file, &xt_table_seq_ops,
+			sizeof(struct seq_net_private));
 }
 
 static const struct file_operations xt_table_ops = {
@@ -1563,7 +1548,7 @@ static const struct file_operations xt_table_ops = {
  */
 struct nf_mttg_trav {
 	struct list_head *head, *curr;
-	uint8_t class, nfproto;
+	uint8_t class;
 };
 
 enum {
@@ -1580,6 +1565,7 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 		[MTTG_TRAV_NFP_UNSPEC] = MTTG_TRAV_NFP_SPEC,
 		[MTTG_TRAV_NFP_SPEC]   = MTTG_TRAV_DONE,
 	};
+	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	switch (trav->class) {
@@ -1594,9 +1580,9 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 		if (trav->curr != trav->head)
 			break;
 		mutex_unlock(&xt[NFPROTO_UNSPEC].mutex);
-		mutex_lock(&xt[trav->nfproto].mutex);
+		mutex_lock(&xt[nfproto].mutex);
 		trav->head = trav->curr = is_target ?
-			&xt[trav->nfproto].target : &xt[trav->nfproto].match;
+			&xt[nfproto].target : &xt[nfproto].match;
 		trav->class = next_class[trav->class];
 		break;
 	case MTTG_TRAV_NFP_SPEC:
@@ -1628,6 +1614,7 @@ static void *xt_mttg_seq_start(struct seq_file *seq, loff_t *pos,
 
 static void xt_mttg_seq_stop(struct seq_file *seq, void *v)
 {
+	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	switch (trav->class) {
@@ -1635,7 +1622,7 @@ static void xt_mttg_seq_stop(struct seq_file *seq, void *v)
 		mutex_unlock(&xt[NFPROTO_UNSPEC].mutex);
 		break;
 	case MTTG_TRAV_NFP_SPEC:
-		mutex_unlock(&xt[trav->nfproto].mutex);
+		mutex_unlock(&xt[nfproto].mutex);
 		break;
 	}
 }
@@ -1680,8 +1667,6 @@ static int xt_match_open(struct inode *inode, struct file *file)
 	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
 	if (!trav)
 		return -ENOMEM;
-
-	trav->nfproto = (unsigned long)PDE_DATA(inode);
 	return 0;
 }
 
@@ -1732,8 +1717,6 @@ static int xt_target_open(struct inode *inode, struct file *file)
 	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
 	if (!trav)
 		return -ENOMEM;
-
-	trav->nfproto = (unsigned long)PDE_DATA(inode);
 	return 0;
 }
 
-- 
2.17.0

