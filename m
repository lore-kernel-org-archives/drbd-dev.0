Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B2CC01056475
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B86382EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Bot_WvAfzHJ9 for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 80CFA2EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wgVl8vZtQOpl for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 58FA62EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:54 +0200 (CEST)
Resent-Message-ID: <20160912131154.GF14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4AAC9105645E
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:26:54 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2baa8e08-1bc5-2497-9d86-391a347df56d@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:26:53 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 05/13] DRBD-receiver: Delete an unnecessary
 initialisation in receive_sizes()
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
Date: Sat, 10 Sep 2016 20:04:02 +0200

A local variable was assigned a null pointer despite of the detail
that it was immediately reassigned by the following statement.
Thus remove such an unnecessary initialisation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index b5a3cf0..7666212 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4083,7 +4083,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		}
 
 		if (my_usize != p_usize) {
-			struct disk_conf *old_disk_conf, *new_disk_conf = NULL;
+			struct disk_conf *old_disk_conf, *new_disk_conf;
 
 			new_disk_conf = kzalloc(sizeof(struct disk_conf), GFP_KERNEL);
 			if (!new_disk_conf) {
-- 
2.10.0

