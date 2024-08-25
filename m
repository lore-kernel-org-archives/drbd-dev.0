Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr
	[80.12.242.24])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3D72642004B
	for <drbd-dev@lists.linbit.com>; Sun, 25 Aug 2024 18:31:22 +0200 (CEST)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] drbd: Remove an unused field in struct drbd_device
Date: Sun, 25 Aug 2024 18:22:23 +0200
Message-ID: <d5322ef88d1d6f544963ee277cb0b427da8dceef.1724602922.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

'next_barrier_nr' is not used in this driver. Remove it.

It was already part of the original commit b411b3637fa7 ("The DRBD driver")
Apparently, it has never been used.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/block/drbd/drbd_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d2937bca1fe4..2a05d955e30b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -860,7 +860,6 @@ struct drbd_device {
 	struct list_head read_ee;   /* [RS]P_DATA_REQUEST being read */
 	struct list_head net_ee;    /* zero-copy network send in progress */
 
-	int next_barrier_nr;
 	struct list_head resync_reads;
 	atomic_t pp_in_use;		/* allocated from page pool */
 	atomic_t pp_in_use_by_net;	/* sendpage()d, still referenced by tcp */
-- 
2.46.0

