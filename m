Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9B5D710561A7
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8E9602A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id oVKfaEYiS2BL for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6046E2ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BVezr0hfjpkq for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 333322A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:24 +0100 (CET)
Resent-Message-ID: <20151130193023.GX22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 931EA10561A7
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:57 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:31 +0100
Message-Id: <1448659775-13596-7-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/21] drbd: fix maybe_pull_ahead() locking
	comments
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

maybe_pull_ahead() calls rcu_read_lock() itself and is only
called within req_lock (locked by drbd_send_and_submit()

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 2255dcf..2228012 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -995,7 +995,7 @@ static void complete_conflicting_writes(struct drbd_request *req)
 	finish_wait(&device->misc_wait, &wait);
 }
 
-/* called within req_lock and rcu_read_lock() */
+/* called within req_lock */
 static void maybe_pull_ahead(struct drbd_device *device)
 {
 	struct drbd_connection *connection = first_peer_device(device)->connection;
-- 
2.1.4

