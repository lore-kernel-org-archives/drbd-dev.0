Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 28EF110518A3
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jan 2013 11:00:38 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 30 Jan 2013 11:00:35 +0100
Message-ID: <2160183.nbHy6OVnEG@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] drbd: Fix flushes without data on a diskless
	primary node
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

Please consider to forward this fix for 3.8 to Linus.

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.drbd.org/linux-drbd.git for-jens-3.8-fix

for you to fetch changes up to d88c3ab963d4cce09b25ef661b871bd7af6dad0d:

  drbd: only fail empty flushes if no good data is reachable (2013-01-30 10:40:33 +0100)

----------------------------------------------------------------
Lars Ellenberg (1):
      drbd: only fail empty flushes if no good data is reachable

 drivers/block/drbd/drbd_req.c |   12 ++++++++----
 drivers/block/drbd/drbd_req.h |    8 ++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f58a4a4..41bb058 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -263,8 +263,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		else
 			root = &mdev->read_requests;
 		drbd_remove_request_interval(root, req);
-	} else if (!(s & RQ_POSTPONED))
-		D_ASSERT((s & (RQ_NET_MASK & ~RQ_NET_DONE)) == 0);
+	}
 
 	/* Before we can signal completion to the upper layers,
 	 * we may need to close the current transfer log epoch.
@@ -755,6 +754,11 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		D_ASSERT(req->rq_state & RQ_NET_PENDING);
 		mod_rq_state(req, m, RQ_NET_PENDING, RQ_NET_OK|RQ_NET_DONE);
 		break;
+
+	case QUEUE_AS_DRBD_BARRIER:
+		start_new_tl_epoch(mdev->tconn);
+		mod_rq_state(req, m, 0, RQ_NET_OK|RQ_NET_DONE);
+		break;
 	};
 
 	return rv;
@@ -975,8 +979,8 @@ static int drbd_process_write_request(struct drbd_request *req)
 		/* The only size==0 bios we expect are empty flushes. */
 		D_ASSERT(req->master_bio->bi_rw & REQ_FLUSH);
 		if (remote)
-			start_new_tl_epoch(mdev->tconn);
-		return 0;
+			_req_mod(req, QUEUE_AS_DRBD_BARRIER);
+		return remote;
 	}
 
 	if (!remote && !send_oos)
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 016de6b..c407f4a 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -88,6 +88,14 @@ enum drbd_req_event {
 	QUEUE_FOR_NET_READ,
 	QUEUE_FOR_SEND_OOS,
 
+	/* An empty flush is queued as P_BARRIER,
+	 * which will cause it to complete "successfully",
+	 * even if the local disk flush failed.
+	 *
+	 * Just like "real" requests, empty flushes (blkdev_issue_flush()) will
+	 * only see an error if neither local nor remote data is reachable. */
+	QUEUE_AS_DRBD_BARRIER,
+
 	SEND_CANCELED,
 	SEND_FAILED,
 	HANDED_OVER_TO_NETWORK,

