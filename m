Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2FB16105647A
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2ADB32EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aE19Yfj4S8_B for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 08ADD2EBCC3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kxainykzb2M7 for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D6DC72E5DD6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:58 +0200 (CEST)
Resent-Message-ID: <20160912131158.GK14595@soda.linbit>
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BB079105646B
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:33:29 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d5fb9e20-538f-b6d7-68a2-4b1b30207110@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:33:28 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Subject: [Drbd-dev] [PATCH 10/13] DRBD-receiver: Delete error messages for
 failed resource allocations in receive_SyncParam()
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
Date: Sat, 10 Sep 2016 22:00:10 +0200

Omit three messages for memory allocation failures in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6fbd968..3e1315a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3863,7 +3863,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 		if (!new_disk_conf) {
 			put_ldev(device);
 			mutex_unlock(&connection->resource->conf_update);
-			drbd_err(device, "Allocation of new disk_conf failed\n");
 			return -ENOMEM;
 		}
 
@@ -3938,7 +3937,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 			if (fifo_size != device->rs_plan_s->size) {
 				new_plan = fifo_alloc(fifo_size);
 				if (!new_plan) {
-					drbd_err(device, "kmalloc of fifo_buffer failed");
 					put_ldev(device);
 					goto disconnect;
 				}
@@ -3948,10 +3946,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 		if (verify_tfm || csums_tfm) {
 			new_net_conf = kzalloc(sizeof(*new_net_conf),
 					       GFP_KERNEL);
-			if (!new_net_conf) {
-				drbd_err(device, "Allocation of new net_conf failed\n");
+			if (!new_net_conf)
 				goto disconnect;
-			}
 
 			*new_net_conf = *old_net_conf;
 
-- 
2.10.0

