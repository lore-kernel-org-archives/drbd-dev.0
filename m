Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F4B71017A24
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 85DDF1B44E6
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:30 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZ+4mknZcUu6 for <drbd-dev@lists.linbit.com>;
	Sun,  3 Mar 2013 20:48:30 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 3EFF71B44DE
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:30 +0100 (CET)
Resent-Message-ID: <20130303194830.GU2696@soda.linbit>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
Date: Sat,  2 Mar 2013 01:39:42 +0400
Message-Id: <1362173982-26454-1-git-send-email-khoroshilov@ispras.ru>
Cc: ldv-project@linuxtesting.org, drbd-user@lists.linbit.com,
	Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH] drbd: add module_put() on error path in
	drbd_proc_open()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If single_open() fails in drbd_proc_open(), module refcount is left incremented.
The patch adds module_put() on the error path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/block/drbd/drbd_proc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 56672a6..30fe0a5 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -313,8 +313,14 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 
 static int drbd_proc_open(struct inode *inode, struct file *file)
 {
-	if (try_module_get(THIS_MODULE))
-		return single_open(file, drbd_seq_show, PDE(inode)->data);
+	int err;
+
+	if (try_module_get(THIS_MODULE)) {
+		err = single_open(file, drbd_seq_show, PDE(inode)->data);
+		if (err)
+			module_put(THIS_MODULE);
+		return err;
+	}
 	return -ENODEV;
 }
 
-- 
1.7.9.5

