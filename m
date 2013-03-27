Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:46 +0100
Message-Id: <1364389729-17559-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/17] drbd: add module_put() on error path in
	drbd_proc_open()
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

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

If single_open() fails in drbd_proc_open(), module refcount is left incremented.
The patch adds module_put() on the error path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
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

