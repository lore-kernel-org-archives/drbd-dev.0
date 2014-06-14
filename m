Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7D93101AC76
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:58:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 998FD3C0052
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:58:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0ZGcB2740p22 for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jun 2014 14:58:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7C6AB3C0EF6
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:58:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rK7zv_40HyWQ for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jun 2014 14:58:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DC80D3D0048
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:58:05 +0200 (CEST)
Resent-Message-ID: <20140616125804.GA28884@soda.linbit>
From: Martin Kepplinger <martink@posteo.de>
To: drbd-dev@lists.linbit.com
Date: Sun, 15 Jun 2014 01:07:55 +0200
Message-Id: <1402787275-12258-1-git-send-email-martink@posteo.de>
Cc: Martin Kepplinger <martink@posteo.de>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: change one-bit bitfield to be an unsigned
	int
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

The one-bit bitfield has no negative values and thus becomes an
unsigned int.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
No idea if you take such small changes. Please ignore if not.
This applies to next-20140613 and fixes a sparse error.


 drivers/block/drbd/drbd_interval.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index f38fcb0..68b4301 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -9,8 +9,8 @@ struct drbd_interval {
 	sector_t sector;	/* start sector of the interval */
 	unsigned int size;	/* size in bytes */
 	sector_t end;		/* highest interval end in subtree */
-	int local:1		/* local or remote request? */;
-	int waiting:1;
+	unsigned int local:1		/* local or remote request? */;
+	unsigned int waiting:1;
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)
-- 
1.7.10.4

