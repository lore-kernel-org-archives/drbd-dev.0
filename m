Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 234831056445
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:31:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 185AE40C150
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:31:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tc7fX6UAuyp6 for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 10:31:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E9F9940C167
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:31:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id biFVInwhr2sC for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 10:31:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id C14A840C150
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:31:23 +0200 (CEST)
Resent-Message-ID: <20160421083123.GL3078@soda.linbit>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.161.196]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B71E1011BA2
	for <drbd-dev@lists.linbit.com>; Sun, 17 Apr 2016 23:43:24 +0200 (CEST)
Received: by mail-yw0-f196.google.com with SMTP id o63so21473566ywe.0
	for <drbd-dev@lists.linbit.com>; Sun, 17 Apr 2016 14:43:24 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 18 Apr 2016 05:29:56 +0800
Message-Id: <1460928615-20894-8-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
References: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@canonical.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH v5 7/8] block: drbd: avoid to use BIO_MAX_SIZE
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

drbd is the only user of BIO_MAX_SIZE, so use BIO_MAX_PAGES
instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/drbd/drbd_int.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7a1cf7e..e6e4b08 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1327,14 +1327,14 @@ struct bm_extent {
 #endif
 #endif
 
-/* BIO_MAX_SIZE is 256 * PAGE_SIZE,
+/* Estimate max bio size as 256 * PAGE_SIZE,
  * so for typical PAGE_SIZE of 4k, that is (1<<20) Byte.
  * Since we may live in a mixed-platform cluster,
  * we limit us to a platform agnostic constant here for now.
  * A followup commit may allow even bigger BIO sizes,
  * once we thought that through. */
 #define DRBD_MAX_BIO_SIZE (1U << 20)
-#if DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
+#if DRBD_MAX_BIO_SIZE > (BIO_MAX_PAGES << PAGE_SHIFT)
 #error Architecture not supported: DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
 #endif
 #define DRBD_MAX_BIO_SIZE_SAFE (1U << 12)       /* Works always = 4k */
-- 
1.9.1

