Return-Path: <ogerlitz@voltaire.com>
Received: from Exil2010.voltaire.com (fwil.voltaire.com [193.47.165.2])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 338D01057D23
	for <drbd-dev@lists.linbit.com>; Sun, 23 Jan 2011 13:36:02 +0100 (CET)
Date: Sun, 23 Jan 2011 14:35:55 +0200
From: Or Gerlitz <ogerlitz@voltaire.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
In-Reply-To: <Pine.LNX.4.64.1101131625400.3887@zuben.voltaire.com>
Message-ID: <Pine.LNX.4.64.1101231433550.9560@zuben.voltaire.com>
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
	<Pine.LNX.4.64.1101131625400.3887@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

drop ifdef which is relevant to 2.6.28 and below

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>

---

changes from v2:
 	drop the include to inux/version.h from drbd_int.h

Hi Philipp, I realized that this cleanup can go a bit
further, can you use this patch instead of v2?

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 3803a03..926e8dd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -28,7 +28,6 @@

 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 11a75d3..6496b32 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1073,11 +1073,7 @@ int drbd_make_request_26(struct request_queue *q, struct bio *bio)
 		const int sps = 1 << HT_SHIFT; /* sectors per slot */
 		const int mask = sps - 1;
 		const sector_t first_sectors = sps - (sect & mask);
-		bp = bio_split(bio,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-				bio_split_pool,
-#endif
-				first_sectors);
+		bp = bio_split(bio, first_sectors);

 		/* we need to get a "reference count" (ap_bio_cnt)
 		 * to avoid races with the disconnect/reconnect/suspend code.

