Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 541491056445
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 10D4F2B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LGBTG19Lgt98 for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:56:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E308A40C046
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YKcEUgLh8DiM for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:56:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BDBD92B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:06 +0200 (CEST)
Resent-Message-ID: <20160331085606.GF18788@soda.linbit>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 454CA1056440
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 18:17:58 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id t66so4198748pfb.2
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 09:17:58 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 31 Mar 2016 00:17:16 +0800
Message-Id: <1459354637-17415-8-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
References: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v1 7/8] block: drbd: avoid to use BIO_MAX_SIZE
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
index c227fd4..10bfff1 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1327,14 +1327,14 @@ struct bm_extent {
 #endif
 #endif
 
-/* BIO_MAX_SIZE is 256 * PAGE_CACHE_SIZE,
+/* Estimate max bio size as 256 * PAGE_CACHE_SIZE,
  * so for typical PAGE_CACHE_SIZE of 4k, that is (1<<20) Byte.
  * Since we may live in a mixed-platform cluster,
  * we limit us to a platform agnostic constant here for now.
  * A followup commit may allow even bigger BIO sizes,
  * once we thought that through. */
 #define DRBD_MAX_BIO_SIZE (1U << 20)
-#if DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
+#if DRBD_MAX_BIO_SIZE > (BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
 #error Architecture not supported: DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
 #endif
 #define DRBD_MAX_BIO_SIZE_SAFE (1U << 12)       /* Works always = 4k */
-- 
1.9.1

