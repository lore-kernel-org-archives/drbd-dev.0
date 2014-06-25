Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 59170101AC7F
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jun 2014 17:52:39 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 25 Jun 2014 17:52:38 +0200
Message-Id: <1403711558-27267-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1403711558-27267-1-git-send-email-philipp.reisner@linbit.com>
References: <1403711558-27267-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: fix NULL pointer deref in
	blk_add_request_payload
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

Discards don't have any payload.
But the scsi layer still expects a bio_vec it can use internally,
see sd_setup_discard_cmnd() and blk_add_request_payload().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index b6c8aaf..5b17ec8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1337,8 +1337,11 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		return 0;
 	}
 
+	/* Discards don't have any payload.
+	 * But the scsi layer still expects a bio_vec it can use internally,
+	 * see sd_setup_discard_cmnd() and blk_add_request_payload(). */
 	if (peer_req->flags & EE_IS_TRIM)
-		nr_pages = 0; /* discards don't have any payload. */
+		nr_pages = 1;
 
 	/* In most cases, we will only need one bio.  But in case the lower
 	 * level restrictions happen to be different at this offset on this
-- 
1.9.1

