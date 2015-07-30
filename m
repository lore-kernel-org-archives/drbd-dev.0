Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 612931019A36
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:36 +0200
Message-Id: <1438255314-14877-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/19] drbd: Remove pointless check
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

In drbd-8.4 there is always a single connection per resource,
and there is always exactly one peer_device for a device.
peer_device can not be NULL here.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 74df8cf..bdd405b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1478,7 +1478,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	device = adm_ctx.device;
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	peer_device = first_peer_device(device);
-	connection = peer_device ? peer_device->connection : NULL;
+	connection = peer_device->connection;
 	conn_reconfig_start(connection);
 
 	/* if you want to reconfigure, please tear down first */
-- 
1.9.1

