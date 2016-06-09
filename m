Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C81891056446
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jun 2016 16:40:03 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu,  9 Jun 2016 22:39:46 +0800
Message-Id: <1465483189-22696-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH-drbd9] compat: i_mutex is replaced by i_rwsem
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

In v4.7(commit 9902af79), i_mutex is replaced by i_rwsem,
while inode_lock() work as usual.

This patch is for drbd-9.0.

Signed-off-by: Nick Wang <nwang@suse.com>

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 drbd/drbd_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drbd/drbd_debugfs.c b/drbd/drbd_debugfs.c
index 91292c3..959a576 100644
--- a/drbd/drbd_debugfs.c
+++ b/drbd/drbd_debugfs.c
@@ -1074,7 +1074,7 @@ static int drbd_single_open_peer_device(struct file *file,
 	parent = file->f_path.dentry->d_parent;
 	if (!parent || !parent->d_inode)
 		goto out;
-	mutex_lock(&parent->d_inode->i_mutex);
+	inode_lock(d_inode(parent));
 	if (!simple_positive(file->f_path.dentry))
 		goto out_unlock;
 
@@ -1083,7 +1083,7 @@ static int drbd_single_open_peer_device(struct file *file,
 
 	if (got_connection && got_device) {
 		int ret;
-		mutex_unlock(&parent->d_inode->i_mutex);
+		inode_unlock(d_inode(parent));
 		ret = single_open(file, show, peer_device);
 		if (ret) {
 			kref_put(&connection->kref, drbd_destroy_connection);
@@ -1097,7 +1097,7 @@ static int drbd_single_open_peer_device(struct file *file,
 	if (got_device)
 		kref_put(&device->kref, drbd_destroy_device);
 out_unlock:
-	mutex_unlock(&parent->d_inode->i_mutex);
+	inode_unlock(d_inode(parent));
 out:
 	return -ESTALE;
 }
-- 
1.8.5.6

