Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 620FE105619E
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5314C2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 17Q2Wv29mc7D for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CC72A2ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:20 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cbJBecjjBkeC for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BC26D2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:19 +0100 (CET)
Resent-Message-ID: <20151130193019.GT22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C9A37105619E
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:48 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:27 +0100
Message-Id: <1448659775-13596-3-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/21] drbd: use true/false for bool
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

Fix 4 coccinelle warnings

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_worker.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d4c807c..ad9b99b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2065,13 +2065,13 @@ static inline int overlaps(sector_t s1, int l1, sector_t s2, int l2)
 static bool overlapping_resync_write(struct drbd_device *device, struct drbd_peer_request *peer_req)
 {
 	struct drbd_peer_request *rs_req;
-	bool rv = 0;
+	bool rv = false;
 
 	spin_lock_irq(&device->resource->req_lock);
 	list_for_each_entry(rs_req, &device->sync_ee, w.list) {
 		if (overlaps(peer_req->i.sector, peer_req->i.size,
 			     rs_req->i.sector, rs_req->i.size)) {
-			rv = 1;
+			rv = true;
 			break;
 		}
 	}
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index e427ba0..17874bc 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1627,7 +1627,7 @@ static bool use_checksum_based_resync(struct drbd_connection *connection, struct
 	rcu_read_unlock();
 	return connection->agreed_pro_version >= 89 &&		/* supported? */
 		connection->csums_tfm &&			/* configured? */
-		(csums_after_crash_only == 0			/* use for each resync? */
+		(csums_after_crash_only == false		/* use for each resync? */
 		 || test_bit(CRASHED_PRIMARY, &device->flags));	/* or only after Primary crash? */
 }
 
@@ -1762,7 +1762,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 			device->bm_resync_fo = 0;
 			device->use_csums = use_checksum_based_resync(connection, device);
 		} else {
-			device->use_csums = 0;
+			device->use_csums = false;
 		}
 
 		/* Since protocol 96, we must serialize drbd_gen_and_send_sync_uuid
-- 
2.1.4

