Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7ABA01056478
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 74D3B2EBCC3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XO28DOrCRmlM for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 21F812EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eMY6sfCTbXvW for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:57 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EFD242EBCC3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:56 +0200 (CEST)
Resent-Message-ID: <20160912131156.GI14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2A87E105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:31:11 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <59238c49-0c8a-fa28-4a4b-2d3924968acb@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 08/13] DRBD-receiver: Move an assignment in
	receive_sizes()
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
Date: Sat, 10 Sep 2016 21:50:18 +0200

Move one assignment for the local variable "ldsc" so that its setting
will only be performed after corresponding data processing succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6a9c16e..2fe58d1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4036,7 +4036,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	struct o_qlim *o = (connection->agreed_features & DRBD_FF_WSAME) ? p->qlim : NULL;
 	enum determine_dev_size dd = DS_UNCHANGED;
 	sector_t p_size, p_usize, p_csize, my_usize;
-	int ldsc = 0; /* local disk size changed */
+	int ldsc; /* local disk size changed */
 	enum dds_flags ddsf;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
@@ -4141,6 +4141,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		drbd_set_my_capacity(device, p_csize ?: p_usize ?: p_size);
 	}
 
+	ldsc = 0;
 	if (get_ldev(device)) {
 		if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev)) {
 			device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
-- 
2.10.0

