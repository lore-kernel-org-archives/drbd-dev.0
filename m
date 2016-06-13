Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 10907105647D
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:50 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:39 +0200
Message-Id: <1465856799-2151-31-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 30/30] drbd: correctly handle failed
	crypto_alloc_hash
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

crypto_alloc_hash returns an ERR_PTR(), not NULL.

Also reset peer_integrity_tfm to NULL, to not call crypto_free_hash()
on an errno in the cleanup path.

Reported-by: Insu Yun <wuninsu@gmail.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 include/linux/drbd.h               | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0d74602..df45713 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3681,7 +3681,8 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		 */
 
 		peer_integrity_tfm = crypto_alloc_ahash(integrity_alg, 0, CRYPTO_ALG_ASYNC);
-		if (!peer_integrity_tfm) {
+		if (IS_ERR(peer_integrity_tfm)) {
+			peer_integrity_tfm = NULL;
 			drbd_err(connection, "peer data-integrity-alg %s not supported\n",
 				 integrity_alg);
 			goto disconnect;
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 2b26156..002611c 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -51,7 +51,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.6"
+#define REL_VERSION "8.4.7"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
2.7.4

