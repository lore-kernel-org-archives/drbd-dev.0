Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AABB21056431
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A4BC5406FAB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5PmhKIEObMqo for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 88BF5406FDC
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8A1btOu_DWfp for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 45B33406FAB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:48 +0100 (CET)
Resent-Message-ID: <20160322105247.GN4437@soda.linbit>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 66B2C1056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:29:09 +0100 (CET)
Received: by mail-pf0-f195.google.com with SMTP id x3so34026450pfb.0
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:29:09 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:29 +0800
Message-Id: <1458627149-12988-9-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 8/8] block: bio: remove BIO_MAX_SIZE
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

No one need this macro now, so remove it. The motivation is
for supporting multipage bvecs, in which we only know
what the max count of bvecs is supported in the bio,
instead of max bio size.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bvec_iter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bvec_iter.h b/include/linux/bvec_iter.h
index a979690..8ddaacf 100644
--- a/include/linux/bvec_iter.h
+++ b/include/linux/bvec_iter.h
@@ -23,7 +23,6 @@
 #include <linux/blk_types.h>
 
 #define BIO_MAX_PAGES		256
-#define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
 
 /*
  * various member access, note that bio_data should of course not be used
-- 
1.9.1

