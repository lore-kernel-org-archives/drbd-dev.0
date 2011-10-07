Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  7 Oct 2011 13:27:37 +0200
Message-Id: <1317986865-3706-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
References: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/12] drbd: Make broadcast events return NO_ERROR
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Instead of returning a ret_code outside of the range of enum
drbd_ret_code, use NO_ERROR to indicate success.  This way,
ret_code has the same meaning in all packets.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 70f7dd8..caa8ba2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3229,7 +3229,7 @@ void drbd_bcast_event(struct drbd_conf *mdev, const struct sib_info *sib)
 	if (!d_out) /* cannot happen, but anyways. */
 		goto nla_put_failure;
 	d_out->minor = mdev_to_minor(mdev);
-	d_out->ret_code = 0;
+	d_out->ret_code = NO_ERROR;
 
 	pr_info("event: minor=%u, conn=%s\n", d_out->minor, mdev->tconn->name);
 
-- 
1.7.4.1

