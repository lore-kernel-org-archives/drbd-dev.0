Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 547661056479
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4EB412E5DD6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9IKRYSZa4-D3 for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 308652EBCC3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sh7_FNBfM7jT for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id C8D122E5DD6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Resent-Message-ID: <20160912131157.GJ14595@soda.linbit>
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 51FDC105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:32:19 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <334ae3df-8fff-025b-5311-af4522d9611f@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:32:17 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 09/13] DRBD-receiver: Improve determination of
 sizes in receive_SyncParam()
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Sep 2016 21:54:55 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2fe58d1..6fbd968 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3859,7 +3859,7 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 	mutex_lock(&connection->resource->conf_update);
 	old_net_conf = peer_device->connection->net_conf;
 	if (get_ldev(device)) {
-		new_disk_conf = kzalloc(sizeof(struct disk_conf), GFP_KERNEL);
+		new_disk_conf = kzalloc(sizeof(*new_disk_conf), GFP_KERNEL);
 		if (!new_disk_conf) {
 			put_ldev(device);
 			mutex_unlock(&connection->resource->conf_update);
@@ -3946,7 +3946,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 		}
 
 		if (verify_tfm || csums_tfm) {
-			new_net_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
+			new_net_conf = kzalloc(sizeof(*new_net_conf),
+					       GFP_KERNEL);
 			if (!new_net_conf) {
 				drbd_err(device, "Allocation of new net_conf failed\n");
 				goto disconnect;
-- 
2.10.0

