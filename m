Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 531181056477
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 341B040A530
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7doT5UYwdhHa for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1471840A591
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZW9x63ArXs7p for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E219840A530
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:48 +0200 (CEST)
Resent-Message-ID: <20160414112648.GT3078@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 15B1F1056459
	for <drbd-dev@lists.linbit.com>; Wed, 13 Apr 2016 21:37:59 +0200 (CEST)
From: mchristi@redhat.com
To: linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	konrad.wilk@oracle.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
Date: Wed, 13 Apr 2016 14:36:22 -0500
Message-Id: <1460576188-5751-37-git-send-email-mchristi@redhat.com>
In-Reply-To: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
References: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 36/42] ide cd: do not set REQ_WRITE on requests.
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

From: Mike Christie <mchristi@redhat.com>

The block layer will set the correct READ/WRITE operation flags/fields
when creating a request, so there is not need for drivers to set the
REQ_WRITE flag.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-cd_ioctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 474173e..5887a7a 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -459,9 +459,6 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
 
-	if (cgc->data_direction == CGC_DATA_WRITE)
-		flags |= REQ_WRITE;
-
 	if (cgc->sense)
 		memset(cgc->sense, 0, sizeof(struct request_sense));
 
-- 
2.7.2

