Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7A2B910561A3
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 67D232AE8C3
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T7OHM9X1VX9v for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 46C942AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3GkwMuJB4BTw for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 10A042ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Resent-Message-ID: <20151130193021.GV22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1655B1056198
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:53 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:29 +0100
Message-Id: <1448659775-13596-5-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/21] drbd: clean-up receive_SyncParam()
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

Initialize header_size then data_size once.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_receiver.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ad9b99b..3ca6516 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3556,18 +3556,16 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 		return -EIO;
 	}
 
-	if (apv <= 88) {
+	if (apv <= 88)
 		header_size = sizeof(struct p_rs_param);
-		data_size = pi->size - header_size;
-	} else if (apv <= 94) {
+	else if (apv <= 94)
 		header_size = sizeof(struct p_rs_param_89);
-		data_size = pi->size - header_size;
-		D_ASSERT(device, data_size == 0);
-	} else {
+	else
 		header_size = sizeof(struct p_rs_param_95);
-		data_size = pi->size - header_size;
+
+	data_size = pi->size - header_size;
+	if (apv > 88)
 		D_ASSERT(device, data_size == 0);
-	}
 
 	/* initialize verify_alg and csums_alg */
 	p = pi->data;
-- 
2.1.4

