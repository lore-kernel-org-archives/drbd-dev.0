Return-Path: <bobo.shaobowang@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 39B75420964
	for <drbd-dev@lists.linbit.com>;
	Mon, 21 Nov 2022 12:52:30 +0100 (CET)
From: Wang ShaoBo <bobo.shaobowang@huawei.com>
To: 
Date: Mon, 21 Nov 2022 19:50:47 +0800
Message-ID: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bobo.shaobowang@huawei.com,
	liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RESEND PATCH] drbd: destroy workqueue when drbd device
	was freed
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

A submitter workqueue is dynamically allocated by init_submitter()
called by drbd_create_device(), we should destroy it when this
device is not needed or destroyed.

Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---

Changes in RESEND:
  put destroy_workqueue() before memset(device, ...)

 drivers/block/drbd/drbd_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8532b839a343..082bc34cd317 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2217,7 +2217,12 @@ void drbd_destroy_device(struct kref *kref)
 		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
 		kfree(peer_device);
 	}
+
+	if (device->submit.wq)
+		destroy_workqueue(device->submit.wq);
+
 	memset(device, 0xfd, sizeof(*device));
+
 	kfree(device);
 	kref_put(&resource->kref, drbd_destroy_resource);
 }
@@ -2810,6 +2815,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	put_disk(disk);
 out_no_disk:
 	kref_put(&resource->kref, drbd_destroy_resource);
+	if (device->submit.wq)
+		destroy_workqueue(device->submit.wq);
 	kfree(device);
 	return err;
 }
-- 
2.25.1

