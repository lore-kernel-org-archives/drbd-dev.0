Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7E270420621
	for <drbd-dev@lists.linbit.com>; Tue, 31 Aug 2021 00:59:39 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
	ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
	chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com,
	thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Date: Mon, 30 Aug 2021 15:09:50 -0700
Message-Id: <20210830221000.179369-6-mcgrof@kernel.org>
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Luis Chamberlain <mcgrof@kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/15] um/drivers/ubd_kern: add error handling
	support for add_disk()
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

ubd_disk_register() never returned an error, so just fix
that now and let the caller handle the error condition.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/um/drivers/ubd_kern.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index cd9dc0556e91..81045c199c30 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -854,8 +854,8 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static void ubd_disk_register(int major, u64 size, int unit,
-			      struct gendisk *disk)
+static int ubd_disk_register(int major, u64 size, int unit,
+			     struct gendisk *disk)
 {
 	disk->major = major;
 	disk->first_minor = unit << UBD_SHIFT;
@@ -872,7 +872,7 @@ static void ubd_disk_register(int major, u64 size, int unit,
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
-	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
+	return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
 }
 
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
@@ -919,10 +919,15 @@ static int ubd_add(int n, char **error_out)
 	blk_queue_write_cache(ubd_dev->queue, true, false);
 	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
 	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
-	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	if (err)
+		goto out_cleanup_disk;
+
 	ubd_gendisk[n] = disk;
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 out:
-- 
2.30.2

