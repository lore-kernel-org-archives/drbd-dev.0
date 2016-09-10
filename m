Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 30F661056473
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2AC0D2EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JkeWDMYngJHQ for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CC25C2EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RvmpQ4oz64-r for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A1B622EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:52 +0200 (CEST)
Resent-Message-ID: <20160912131152.GD14595@soda.linbit>
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 84123105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:29:52 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <ac87a521-0dd3-b30c-caf4-ec0722b05a4f@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:24:42 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 03/13] DRBD-receiver: Move an assignment in
	receive_uuids()
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
Date: Sat, 10 Sep 2016 19:37:42 +0200

Move one assignment for the local variable "updated_uuids" so that
its setting will only be performed after corresponding memory
allocations succeeded by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index dab3f74..5526f6b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4179,7 +4179,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	struct drbd_device *device;
 	struct p_uuids *p = pi->data;
 	u64 *p_uuid;
-	int i, updated_uuids = 0;
+	int i, updated_uuids;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
@@ -4206,6 +4206,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 		return -EIO;
 	}
 
+	updated_uuids = 0;
 	if (get_ldev(device)) {
 		int skip_initial_sync =
 			device->state.conn == C_CONNECTED &&
-- 
2.10.0

