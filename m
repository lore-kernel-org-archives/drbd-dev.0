Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1D5E510561B9
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EBB042A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:28 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BHvrmtd1PILV for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CF2362ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:28 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2HzodBqKbVM4 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:28 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AA5C12A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:28 +0100 (CET)
Resent-Message-ID: <20151130193028.GC22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 84EEE10561B9
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:30:49 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:30:36 +0100
Message-Id: <1448659836-13747-2-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659836-13747-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659836-13747-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/21] drbd: replace if/BUG by BUG_ON
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

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_state.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index a7631a3..5f16a11 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2150,9 +2150,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 			ns.disk = os.disk;
 
 		rv = _drbd_set_state(device, ns, flags, NULL);
-		if (rv < SS_SUCCESS)
-			BUG();
-
+		BUG_ON(rv < SS_SUCCESS);
 		ns.i = device->state.i;
 		ns_max.role = max_role(ns.role, ns_max.role);
 		ns_max.peer = max_role(ns.peer, ns_max.peer);
-- 
2.1.4

