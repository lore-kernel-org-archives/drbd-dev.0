Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 17A0F1056471
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0E9CC2EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id s-ReiWZE_9_G for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E3F022EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S9mlrPIqKriN for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:51 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BF4522EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:51 +0200 (CEST)
Resent-Message-ID: <20160912131151.GC14595@soda.linbit>
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CFC9F105646B
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:28:48 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <50817602-79d5-af47-8d97-6d6b01939e43@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Subject: [Drbd-dev] [PATCH 02/13] DRBD-receiver: Delete an error message for
 a failed kmalloc_array() call
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
Date: Sat, 10 Sep 2016 19:26:07 +0200

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3be9fbf..dab3f74 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4187,10 +4187,8 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	device = peer_device->device;
 
 	p_uuid = kmalloc_array(UI_EXTENDED_SIZE, sizeof(*p_uuid), GFP_NOIO);
-	if (!p_uuid) {
-		drbd_err(device, "kmalloc of p_uuid failed\n");
+	if (!p_uuid)
 		return false;
-	}
 
 	for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
 		p_uuid[i] = be64_to_cpu(p->uuid[i]);
-- 
2.10.0

