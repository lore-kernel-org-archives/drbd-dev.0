Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E21641055F71
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C99032A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0A9E6quwI0P0 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 994742ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BRF6PmwuMJQ1 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 76CF02A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Resent-Message-ID: <20151130193013.GN22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 56FD01055F58
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:28:49 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:12 +0100
Message-Id: <1448659575-13485-8-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/21] drbd: kerneldoc warning fix in
	w_e_end_data_req()
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

device in not passed to that function.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_worker.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index eff716c..e47bde9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -994,7 +994,6 @@ static void move_to_net_ee_or_free(struct drbd_device *device, struct drbd_peer_
 
 /**
  * w_e_end_data_req() - Worker callback, to send a P_DATA_REPLY packet in response to a P_DATA_REQUEST
- * @device:	DRBD device.
  * @w:		work object.
  * @cancel:	The connection will be closed anyways
  */
-- 
2.1.4

