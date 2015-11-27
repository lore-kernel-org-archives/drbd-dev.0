Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5DACF1056199
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4EC112A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bDSa4cRdKIS3 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 050A92ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bdZ_wcJTTdQR for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BB5902A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Resent-Message-ID: <20151130193018.GS22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 905081056199
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:46 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:26 +0100
Message-Id: <1448659775-13596-2-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/21] drbd: use | for bitmask combination
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

Fix coccinelle warning: "sum of probable bitmasks, consider |"

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1c72991..d4c807c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2449,7 +2449,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	}
 
 out_interrupted:
-	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + EV_CLEANUP);
+	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT | EV_CLEANUP);
 	put_ldev(device);
 	drbd_free_peer_req(device, peer_req);
 	return err;
-- 
2.1.4

