Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m25467.xmail.ntesmail.com (mail-m25467.xmail.ntesmail.com
	[103.129.254.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70453420621
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 08:32:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B99F47E06DB
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2024 13:46:20 +0800 (CST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 02/11] drbd_receiver: get_ldev before use device->ldev for
	drbd_reconsider_queue_parameters()
Date: Mon, 24 Jun 2024 13:46:10 +0800
Message-Id: <20240624054619.23212-2-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
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

From: Dongsheng Yang <dongsheng.yang@easystack.cn>

check ldev is not NULL before use it in drbd_reconsider_queue_parameters()

Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drbd/drbd_receiver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 49e7815ed..fd07b29d7 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -9845,7 +9845,12 @@ static void conn_disconnect(struct drbd_connection *connection)
 		rcu_read_unlock();
 
 		peer_device_disconnected(peer_device);
-		drbd_reconsider_queue_parameters(device, device->ldev);
+		if (get_ldev(device)) {
+			drbd_reconsider_queue_parameters(device, device->ldev);
+			put_ldev(device);
+		} else {
+			drbd_reconsider_queue_parameters(device, NULL);
+		}
 
 		kref_put(&device->kref, drbd_destroy_device);
 		rcu_read_lock();
-- 
2.27.0

