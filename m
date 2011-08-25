Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:04 +0200
Message-Id: <1314284934-17999-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 008/118] drbd: Update outdated comment
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index bafc233..26810ce 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1512,7 +1512,7 @@ static int receive_RSDataReply(struct drbd_conf *mdev, enum drbd_packets cmd, un
 	if (get_ldev(mdev)) {
 		/* data is submitted to disk within recv_resync_read.
 		 * corresponding put_ldev done below on error,
-		 * or in drbd_endio_write_sec. */
+		 * or in drbd_endio_sec. */
 		ok = recv_resync_read(mdev, sector, data_size);
 	} else {
 		if (__ratelimit(&drbd_ratelimit_state))
@@ -1673,7 +1673,7 @@ static int receive_Data(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned
 
 	/* get_ldev(mdev) successful.
 	 * Corresponding put_ldev done either below (on various errors),
-	 * or in drbd_endio_write_sec, if we successfully submit the data at
+	 * or in drbd_endio_sec, if we successfully submit the data at
 	 * the end of this function. */
 
 	sector = be64_to_cpu(p->sector);
-- 
1.7.4.1

