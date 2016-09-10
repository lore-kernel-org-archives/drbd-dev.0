Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1226105647E
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BBAE62EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7ZTuBegga3Jb for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9E4AD2EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fPucgwpfTu3c for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 79DA32EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:12:01 +0200 (CEST)
Resent-Message-ID: <20160912131201.GN14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3AC87105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:36:52 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5dd280c1-27ac-4e83-97eb-3a4f7fec6cd9@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:36:51 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 13/13] DRBD-receiver: Improve determination of
 sizes in receive_Barrier()
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
Date: Sat, 10 Sep 2016 22:06:21 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e4da335..32ac4a9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1747,7 +1747,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 
 		/* receiver context, in the writeout path of the other node.
 		 * avoid potential distributed deadlock */
-		epoch = kmalloc(sizeof(struct drbd_epoch), GFP_NOIO);
+		epoch = kmalloc(sizeof(*epoch), GFP_NOIO);
 		if (epoch)
 			break;
 		else
@@ -1760,7 +1760,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 		drbd_flush(connection);
 
 		if (atomic_read(&connection->current_epoch->epoch_size)) {
-			epoch = kmalloc(sizeof(struct drbd_epoch), GFP_NOIO);
+			epoch = kmalloc(sizeof(*epoch), GFP_NOIO);
 			if (epoch)
 				break;
 		}
-- 
2.10.0

