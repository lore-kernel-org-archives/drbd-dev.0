Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DACE6105647D
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D5AB82EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QBJPCACaKUGR for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BA4F82EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kPKcFvxvqtMR for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 95D112EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:00 +0200 (CEST)
Resent-Message-ID: <20160912131200.GM14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C9FF2105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:35:50 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c0785561-c7ea-0b0e-b144-3b8f3eba46e0@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Subject: [Drbd-dev] [PATCH 12/13] DRBD-receiver: Delete error messages for
 failed resource allocations in receive_protocol()
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
Date: Sat, 10 Sep 2016 22:04:08 +0200

Omit two messages for memory allocation failures in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index bbccdb8..e4da335 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3691,17 +3691,13 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		hash_size = crypto_ahash_digestsize(peer_integrity_tfm);
 		int_dig_in = kmalloc(hash_size, GFP_KERNEL);
 		int_dig_vv = kmalloc(hash_size, GFP_KERNEL);
-		if (!(int_dig_in && int_dig_vv)) {
-			drbd_err(connection, "Allocation of buffers for data integrity checking failed\n");
+		if (!(int_dig_in && int_dig_vv))
 			goto disconnect;
-		}
 	}
 
 	new_net_conf = kmalloc(sizeof(*new_net_conf), GFP_KERNEL);
-	if (!new_net_conf) {
-		drbd_err(connection, "Allocation of new net_conf failed\n");
+	if (!new_net_conf)
 		goto disconnect;
-	}
 
 	mutex_lock(&connection->data.mutex);
 	mutex_lock(&connection->resource->conf_update);
-- 
2.10.0

