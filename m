Return-Path: <xiam0nd.tong@gmail.com>
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
	[209.85.215.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ECBE74205D8
	for <drbd-dev@lists.linbit.com>; Sun, 27 Mar 2022 09:09:26 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id w21so9827490pgm.7
	for <drbd-dev@lists.linbit.com>; Sun, 27 Mar 2022 00:09:26 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: philipp.reisner@linbit.com
Date: Sun, 27 Mar 2022 15:09:18 +0800
Message-Id: <20220327070918.8465-1-xiam0nd.tong@gmail.com>
Cc: axboe@kernel.dk, agruen@linbit.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	Xiaomeng Tong <xiam0nd.tong@gmail.com>,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: fix an invalid memory access caused by
	incorrect use of list iterator
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

The bug is here:
	idr_remove(&connection->peer_devices, vnr);

If the previous for_each_connection() don't exit early (no goto hit
inside the loop), the iterator 'connection' after the loop will be a
bogus pointer to an invalid structure object containing the HEAD
(&resource->connections). As a result, the use of 'connection' above
will lead to a invalid memory access (including a possible invalid free
as idr_remove could call free_layer).

The original intention should have been to remove all peer_devices,
but the following lines have already done the work. So just remove
this line and the unneeded label, to fix this bug.

Cc: stable@vger.kernel.org
Fixes: c06ece6ba6f1b ("drbd: Turn connection->volumes into connection->peer_devices")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6f450816c4fa..5d5beeba3ed4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2793,12 +2793,12 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	if (init_submitter(device)) {
 		err = ERR_NOMEM;
-		goto out_idr_remove_vol;
+		goto out_idr_remove_from_resource;
 	}
 
 	err = add_disk(disk);
 	if (err)
-		goto out_idr_remove_vol;
+		goto out_idr_remove_from_resource;
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
@@ -2812,8 +2812,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	drbd_debugfs_device_add(device);
 	return NO_ERROR;
 
-out_idr_remove_vol:
-	idr_remove(&connection->peer_devices, vnr);
 out_idr_remove_from_resource:
 	for_each_connection(connection, resource) {
 		peer_device = idr_remove(&connection->peer_devices, vnr);
-- 
2.17.1

