Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EF81242062B
	for <drbd-dev@lists.linbit.com>; Tue, 28 Sep 2021 00:01:35 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
	ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
	chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com,
	thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Date: Mon, 27 Sep 2021 15:01:02 -0700
Message-Id: <20210927220110.1066271-8-mcgrof@kernel.org>
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Luis Chamberlain <mcgrof@kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 07/15] n64cart: add error handling support for
	add_disk()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/n64cart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 26798da661bd..35aa5d38f57d 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -117,6 +117,7 @@ static const struct block_device_operations n64cart_fops = {
 static int __init n64cart_probe(struct platform_device *pdev)
 {
 	struct gendisk *disk;
+	int err = -ENOMEM;
 
 	if (!start || !size) {
 		pr_err("start or size not specified\n");
@@ -134,7 +135,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 
 	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
-		return -ENOMEM;
+		goto out;
 
 	disk->first_minor = 0;
 	disk->flags = GENHD_FL_NO_PART_SCAN;
@@ -149,11 +150,18 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	blk_queue_physical_block_size(disk->queue, 4096);
 	blk_queue_logical_block_size(disk->queue, 4096);
 
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	pr_info("n64cart: %u kb disk\n", size / 1024);
 
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
+out:
+	return err;
 }
 
 static struct platform_driver n64cart_driver = {
-- 
2.30.2

