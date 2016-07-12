Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BE8F21056468
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B40DF2AB5D5
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bzS99jJQcsKE for <drbd-dev@lists.linbit.com>;
	Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9725442C03F
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fqTLbLlpGMH3 for <drbd-dev@lists.linbit.com>;
	Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 703AA2AB5D5
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:17:34 +0200 (CEST)
Resent-Message-ID: <20160713101734.GF29779@soda.linbit>
Received: from mailrelay113.isp.belgacom.be (mailrelay113.isp.belgacom.be
	[195.238.20.140]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 51A861056444
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 20:28:05 +0200 (CEST)
From: Fabian Frederick <fabf@skynet.be>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 12 Jul 2016 20:28:00 +0200
Message-Id: <1468348080-7196-1-git-send-email-fabf@skynet.be>
Cc: fabf@skynet.be, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/1 linux-next] drbd: remove __packed definition
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

__packed is already defined in compiler-gcc.h under __GNUC__
(see include/linux/compiler.h)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_protocol.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 4d29680..0fc0172 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -80,10 +80,6 @@ enum drbd_packet {
 	P_CONNECTION_FEATURES = 0xfffe	/* FIXED for the next century! */
 };
 
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
 /* This is the layout for a packet on the wire.
  * The byteorder is the network byte order.
  *     (except block_id and barrier fields.
-- 
2.8.1

