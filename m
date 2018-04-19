Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6859B1057325
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:38:37 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Thu, 19 Apr 2018 14:41:33 +0200
Message-Id: <20180419124140.9309-33-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 32/39] bluetooth: switch to proc_create_seq_data
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
through seq->private and private state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/bluetooth/af_bluetooth.c | 40 +++++-------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 84d92a077834..3264e1873219 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -605,15 +605,10 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 EXPORT_SYMBOL(bt_sock_wait_ready);
 
 #ifdef CONFIG_PROC_FS
-struct bt_seq_state {
-	struct bt_sock_list *l;
-};
-
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_lock(&l->lock);
 	return seq_hlist_start_head(&l->head, *pos);
@@ -621,8 +616,7 @@ static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	return seq_hlist_next(v, &l->head, pos);
 }
@@ -630,16 +624,14 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void bt_seq_stop(struct seq_file *seq, void *v)
 	__releases(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_unlock(&l->lock);
 }
 
 static int bt_seq_show(struct seq_file *seq, void *v)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Parent");
@@ -681,35 +673,13 @@ static const struct seq_operations bt_seq_ops = {
 	.show  = bt_seq_show,
 };
 
-static int bt_seq_open(struct inode *inode, struct file *file)
-{
-	struct bt_sock_list *sk_list;
-	struct bt_seq_state *s;
-
-	sk_list = PDE_DATA(inode);
-	s = __seq_open_private(file, &bt_seq_ops,
-			       sizeof(struct bt_seq_state));
-	if (!s)
-		return -ENOMEM;
-
-	s->l = sk_list;
-	return 0;
-}
-
-static const struct file_operations bt_fops = {
-	.open = bt_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release_private
-};
-
 int bt_procfs_init(struct net *net, const char *name,
 		   struct bt_sock_list *sk_list,
 		   int (* seq_show)(struct seq_file *, void *))
 {
 	sk_list->custom_seq_show = seq_show;
 
-	if (!proc_create_data(name, 0, net->proc_net, &bt_fops, sk_list))
+	if (!proc_create_seq_data(name, 0, net->proc_net, &bt_seq_ops, sk_list))
 		return -ENOMEM;
 	return 0;
 }
-- 
2.17.0

