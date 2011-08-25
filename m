Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:48 +0200
Message-Id: <1314284934-17999-53-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 052/118] drbd: Remove unnecessary reference
	counting left-over
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Nothing in this function accesses mdev->tconn->net_conf, so there is no
need for get_net_conf() / put_net_conf() anymore.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index df5f106..e11ea47 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -328,9 +328,6 @@ static int _req_conflicts(struct drbd_request *req)
 
 	D_ASSERT(drbd_interval_empty(&req->i));
 
-	if (!get_net_conf(mdev->tconn))
-		return 0;
-
 	i = drbd_find_overlap(&mdev->write_requests, sector, size);
 	if (i) {
 		dev_alert(DEV, "%s[%u] Concurrent %s write detected! "
@@ -340,17 +337,9 @@ static int _req_conflicts(struct drbd_request *req)
 		      i->local ? "local" : "remote",
 		      (unsigned long long)sector, size,
 		      (unsigned long long)i->sector, i->size);
-		goto out_conflict;
+		return 1;
 	}
-
-	/* this is like it should be, and what we expected.
-	 * our users do behave after all... */
-	put_net_conf(mdev->tconn);
 	return 0;
-
-out_conflict:
-	put_net_conf(mdev->tconn);
-	return 1;
 }
 
 /* obviously this could be coded as many single functions
-- 
1.7.4.1

