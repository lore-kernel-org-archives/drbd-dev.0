Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C6F6E10518AC
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BF08E2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DQ1SV35ZeKMP for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 860A82ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id snZ25IPqUMWI for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 596632A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:09 +0100 (CET)
Resent-Message-ID: <20151130193009.GJ22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F8201045C37
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:27:05 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:07 +0100
Message-Id: <1448659575-13485-3-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/21] drbd: simplify drbd_md_set_sector_offsets()
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

Some metadata informations were duplicated in layout switch.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_nl.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c055c5e..ef136a9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -794,20 +794,9 @@ static void drbd_md_set_sector_offsets(struct drbd_device *device,
 	unsigned int al_size_sect = bdev->md.al_size_4k * 8;
 
 	bdev->md.md_offset = drbd_md_ss(bdev);
+	md_size_sect = MD_128MB_SECT;
 
 	switch (bdev->md.meta_dev_idx) {
-	default:
-		/* v07 style fixed size indexed meta data */
-		bdev->md.md_size_sect = MD_128MB_SECT;
-		bdev->md.al_offset = MD_4kB_SECT;
-		bdev->md.bm_offset = MD_4kB_SECT + al_size_sect;
-		break;
-	case DRBD_MD_INDEX_FLEX_EXT:
-		/* just occupy the full device; unit: sectors */
-		bdev->md.md_size_sect = drbd_get_capacity(bdev->md_bdev);
-		bdev->md.al_offset = MD_4kB_SECT;
-		bdev->md.bm_offset = MD_4kB_SECT + al_size_sect;
-		break;
 	case DRBD_MD_INDEX_INTERNAL:
 	case DRBD_MD_INDEX_FLEX_INT:
 		/* al size is still fixed */
@@ -822,11 +811,20 @@ static void drbd_md_set_sector_offsets(struct drbd_device *device,
 		 * and the activity log; */
 		md_size_sect += MD_4kB_SECT + al_size_sect;
 
-		bdev->md.md_size_sect = md_size_sect;
 		/* bitmap offset is adjusted by 'super' block size */
 		bdev->md.bm_offset   = -md_size_sect + MD_4kB_SECT;
 		break;
+	case DRBD_MD_INDEX_FLEX_EXT:
+		/* just occupy the full device; unit: sectors */
+		md_size_sect = drbd_get_capacity(bdev->md_bdev);
+	default:
+		/* v07 style fixed size indexed meta data */
+		bdev->md.al_offset = MD_4kB_SECT;
+		bdev->md.bm_offset = MD_4kB_SECT + al_size_sect;
+		break;
 	}
+
+	bdev->md.md_size_sect = md_size_sect;
 }
 
 /* input size is expected to be in KB */
-- 
2.1.4

