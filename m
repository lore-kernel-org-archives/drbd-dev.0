Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3AB611056317
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:30:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B52632A5A63
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:30:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SqBA72BEYbeF for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:30:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 92E782A59D3
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:30:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vYFntlrt4N95 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:30:52 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5F8972A5A63
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:30:52 +0100 (CET)
Resent-Message-ID: <20160108203051.GI28982@soda.linbit>
Date: Sun, 27 Dec 2015 21:18:09 +0700
From: Ivan Safonov <insafonov@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20151227141809.GA18632@alpha.sfu-kras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drivers: block: drbd: remove unused macros
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

div_ceil and div_floor macros duplicates round_up and round_down from kernel.h

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/block/drbd/drbd_int.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e66d453..08256ad 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -195,11 +195,6 @@ drbd_insert_fault(struct drbd_device *device, unsigned int type) {
 #endif
 }
 
-/* integer division, round _UP_ to the next integer */
-#define div_ceil(A, B) ((A)/(B) + ((A)%(B) ? 1 : 0))
-/* usual integer division */
-#define div_floor(A, B) ((A)/(B))
-
 extern struct ratelimit_state drbd_ratelimit_state;
 extern struct idr drbd_devices; /* RCU, updates: genl_lock() */
 extern struct list_head drbd_resources; /* RCU, updates: genl_lock() */
-- 
2.4.10

