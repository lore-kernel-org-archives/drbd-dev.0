Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C647A1057589
	for <drbd-dev@lists.linbit.com>; Wed, 16 May 2018 12:06:48 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 16 May 2018 11:43:37 +0200
Message-Id: <20180516094346.20506-34-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 33/42] netfilter/xt_hashlimit: switch to
	proc_create_{seq, single}_data
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
 net/netfilter/xt_hashlimit.c | 92 +++++++-----------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 0cd73567e7ff..9b16402f29af 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -57,9 +57,9 @@ static inline struct hashlimit_net *hashlimit_pernet(struct net *net)
 }
 
 /* need to declare this at the top */
-static const struct file_operations dl_file_ops_v2;
-static const struct file_operations dl_file_ops_v1;
-static const struct file_operations dl_file_ops;
+static const struct seq_operations dl_seq_ops_v2;
+static const struct seq_operations dl_seq_ops_v1;
+static const struct seq_operations dl_seq_ops;
 
 /* hash table crap */
 struct dsthash_dst {
@@ -272,7 +272,7 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
 	struct xt_hashlimit_htable *hinfo;
-	const struct file_operations *fops;
+	const struct seq_operations *ops;
 	unsigned int size, i;
 	int ret;
 
@@ -321,19 +321,19 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 
 	switch (revision) {
 	case 1:
-		fops = &dl_file_ops_v1;
+		ops = &dl_seq_ops_v1;
 		break;
 	case 2:
-		fops = &dl_file_ops_v2;
+		ops = &dl_seq_ops_v2;
 		break;
 	default:
-		fops = &dl_file_ops;
+		ops = &dl_seq_ops;
 	}
 
-	hinfo->pde = proc_create_data(name, 0,
+	hinfo->pde = proc_create_seq_data(name, 0,
 		(family == NFPROTO_IPV4) ?
 		hashlimit_net->ipt_hashlimit : hashlimit_net->ip6t_hashlimit,
-		fops, hinfo);
+		ops, hinfo);
 	if (hinfo->pde == NULL) {
 		kfree(hinfo->name);
 		vfree(hinfo);
@@ -1057,7 +1057,7 @@ static struct xt_match hashlimit_mt_reg[] __read_mostly = {
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket;
 
 	spin_lock_bh(&htable->lock);
@@ -1074,7 +1074,7 @@ static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	*pos = ++(*bucket);
@@ -1088,7 +1088,7 @@ static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	if (!IS_ERR(bucket))
@@ -1130,7 +1130,7 @@ static void dl_seq_print(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1145,7 +1145,7 @@ static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1160,7 +1160,7 @@ static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1174,7 +1174,7 @@ static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = (unsigned int *)v;
 	struct dsthash_ent *ent;
 
@@ -1188,7 +1188,7 @@ static int dl_seq_show_v2(struct seq_file *s, void *v)
 
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1202,7 +1202,7 @@ static int dl_seq_show_v1(struct seq_file *s, void *v)
 
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1235,62 +1235,6 @@ static const struct seq_operations dl_seq_ops = {
 	.show  = dl_seq_show
 };
 
-static int dl_proc_open_v2(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v2);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open_v1(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v1);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations dl_file_ops_v2 = {
-	.open    = dl_proc_open_v2,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops_v1 = {
-	.open    = dl_proc_open_v1,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops = {
-	.open    = dl_proc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
 static int __net_init hashlimit_proc_net_init(struct net *net)
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
-- 
2.17.0

