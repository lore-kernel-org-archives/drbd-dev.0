Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 299F01056192
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 22A222A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Mf5diubCbBhM for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EC6C12ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:15 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z3kQbtiXfZBo for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:15 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 977C22A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:15 +0100 (CET)
Resent-Message-ID: <20151130193015.GP22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E4FE105618B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:28:50 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:13 +0100
Message-Id: <1448659575-13485-9-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/21] drbd: use unsigned for one bit fields
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

Fix sparse warnings and limit comments to fit in 80 columns

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_interval.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index f210543..23c5a94 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -6,13 +6,13 @@
 
 struct drbd_interval {
 	struct rb_node rb;
-	sector_t sector;	/* start sector of the interval */
-	unsigned int size;	/* size in bytes */
-	sector_t end;		/* highest interval end in subtree */
-	int local:1		/* local or remote request? */;
-	int waiting:1;		/* someone is waiting for this to complete */
-	int completed:1;	/* this has been completed already;
-				 * ignore for conflict detection */
+	sector_t sector;		/* start sector of the interval */
+	unsigned int size;		/* size in bytes */
+	sector_t end;			/* highest interval end in subtree */
+	unsigned int local:1		/* local or remote request? */;
+	unsigned int waiting:1;		/* someone is waiting for completion */
+	unsigned int completed:1;	/* this has been completed already;
+					 * ignore for conflict detection */
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)
-- 
2.1.4

