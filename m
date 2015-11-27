Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 62159105619F
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 567A82ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:22 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id o4jwV0LdhW6u for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A71C52A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DaADePIIRxSq for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:21 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 428892AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:20 +0100 (CET)
Resent-Message-ID: <20151130193020.GU22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AF77D105619F
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:50 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:28 +0100
Message-Id: <1448659775-13596-4-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/21] drbd: fix drbd_bm_init() comments
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

Function is also called by drbd_create_device() so original comment
is now obsolete.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_bitmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 92d6fc0..aa2ced7 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -427,8 +427,7 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
 }
 
 /*
- * called on driver init only. TODO call when a device is created.
- * allocates the drbd_bitmap, and stores it in device->bitmap.
+ * allocates the drbd_bitmap and stores it in device->bitmap.
  */
 int drbd_bm_init(struct drbd_device *device)
 {
-- 
2.1.4

