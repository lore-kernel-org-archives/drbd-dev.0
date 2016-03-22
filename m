Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B6168105642F
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B0403406FAB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NC1Ydq4_05od for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 93A98406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZQPn1bYRI8fs for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 687C2406FAB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:47 +0100 (CET)
Resent-Message-ID: <20160322105247.GM4437@soda.linbit>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BCD681056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:28:06 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id q129so34578303pfb.3
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:28:06 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:23 +0800
Message-Id: <1458627149-12988-3-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/8] block: make 'struct bvec_iter' not depend on
	CONFIG_BLOCK
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

We will use bvec iterator to implement iterate_bvec(): lib/iov_iter.c.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/blk_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 86a38ea..fd8527b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -26,8 +26,6 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
-#ifdef CONFIG_BLOCK
-
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
@@ -39,6 +37,8 @@ struct bvec_iter {
 						   current bvec */
 };
 
+#ifdef CONFIG_BLOCK
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
-- 
1.9.1

