Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CB66F1056474
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C55FA2EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3HCTZthNxioe for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9E6E52EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ANO1HwaMDdhh for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 78BF82EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Resent-Message-ID: <20160912131153.GE14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DC964105645E
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:25:53 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <ab0f1fde-13cf-2bed-3874-14d214045e60@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 04/13] DRBD-receiver: Improve a size
 determination in drbd_do_features()
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
Date: Sat, 10 Sep 2016 19:46:05 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 5526f6b..b5a3cf0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5208,7 +5208,7 @@ static int drbd_do_features(struct drbd_connection *connection)
 {
 	/* ASSERT current == connection->receiver ... */
 	struct p_connection_features *p;
-	const int expect = sizeof(struct p_connection_features);
+	const int expect = sizeof(*p);
 	struct packet_info pi;
 	int err;
 
-- 
2.10.0

