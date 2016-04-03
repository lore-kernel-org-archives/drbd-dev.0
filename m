Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C68BD1056447
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C00C6360CB8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id REZLa60iboCs for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 870C136CCD8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kO1m3RPuN_WG for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 528B5360CB8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:26 +0200 (CEST)
Resent-Message-ID: <20160404091925.GI3078@soda.linbit>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1F10B105643D
	for <drbd-dev@lists.linbit.com>; Sun,  3 Apr 2016 18:33:14 +0200 (CEST)
Received: by mail-pa0-f44.google.com with SMTP id fe3so126922505pab.1
	for <drbd-dev@lists.linbit.com>; Sun, 03 Apr 2016 09:33:14 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon,  4 Apr 2016 00:31:07 +0800
Message-Id: <1459701069-31406-7-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
References: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 6/8] block: bio: remove BIO_MAX_SECTORS
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

No one need this macro, so remove it. The motivation is
for supporting multipage bvecs, in which we only know
what the max count of bvecs is supported in the bio,
instead of max size or max sectors.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7f998ac..f7e1c27 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -42,7 +42,6 @@
 
 #define BIO_MAX_PAGES		256
 #define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
-#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
 
 /*
  * upper 16 bits of bi_rw define the io priority of this bio
-- 
1.9.1

