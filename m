Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4FE991055F77
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4AEFA2A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:14 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id G5mHDxwKwApx for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2B2B93D84CB
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:14 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SJ4hvVkwT0fE for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:14 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 010E82A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:13 +0200 (CEST)
Resent-Message-ID: <20150527085812.GG18767@soda.linbit>
From: Shailendra Verma <shailendra.capricorn@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	drbd-user@lists.linbit.com
Date: Tue, 26 May 2015 01:45:09 +0530
Message-Id: <1432584909-5349-1-git-send-email-shailendra.capricorn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [Drbd-dev] [PATCH] block:drbd:drbd_receiver - Change 1/0 to
	true/false for bool type variable rv in function
	overlapping_resync_write().
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

In function overlapping_resync_write() variable rv is bool type.
Hence assigning the values as true/false instead of 1/0.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cee2035..78cc75f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2038,13 +2038,13 @@ static inline int overlaps(sector_t s1, int l1, sector_t s2, int l2)
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
-- 
1.7.9.5

