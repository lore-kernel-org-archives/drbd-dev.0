Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EBCC51056199
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CEEC12A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UpYuEQ8xn5cN for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B09F92A2BCB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J_6Wpgo9Anu8 for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6FBDA2A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:38 +0100 (CET)
Resent-Message-ID: <20151104170938.GO14472@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8166E1055F58
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 17:33:34 +0100 (CET)
From: mchristi@redhat.com
To: linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Date: Wed,  4 Nov 2015 10:32:56 -0600
Message-Id: <1446654807-6935-2-git-send-email-mchristi@redhat.com>
In-Reply-To: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 01/32] block/fs: add REQ_OP definitions.
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

This patch adds definitions for request/bio operations which
will be used in the next patches.

In the initial patches the REQ_OPs match the REQ ones for compat reasons
while all the code is converted in this set. In the last patches
that will be removed.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 include/linux/blk_types.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e813013..d7b6009 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -244,4 +244,11 @@ enum rq_flag_bits {
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
 #define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
 
+enum req_op {
+	REQ_OP_READ,
+	REQ_OP_WRITE		= REQ_WRITE,
+	REQ_OP_DISCARD		= REQ_DISCARD,
+	REQ_OP_WRITE_SAME	= REQ_WRITE_SAME,
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
1.8.3.1

