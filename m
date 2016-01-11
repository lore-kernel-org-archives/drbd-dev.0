Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DF8931056335
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D872C360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qDmZ9J_vyHPe for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B69F8364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kFvA4ysQG8aj for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 91BAA360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:41 +0100 (CET)
Resent-Message-ID: <20160112100941.GP3313@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 37733105632B
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jan 2016 21:22:50 +0100 (CET)
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
Date: Mon, 11 Jan 2016 14:21:27 -0600
Message-Id: <1452543693-4440-30-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 29/35] ide cd: do not set REQ_WRITE on requests.
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
1.8.3.1

