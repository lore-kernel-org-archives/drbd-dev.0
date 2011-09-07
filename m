Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:39 +0200
Message-Id: <1315405061-1473-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/14] drbd: Remove useless error messages
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

These messages can only trigger in case there is a pretty obvious
internal programming error.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a4b24f9..227cddc 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2183,8 +2183,7 @@ static int receive_DataRequest(struct drbd_conf *mdev, enum drbd_packet cmd,
 			drbd_send_ack_ex(mdev, P_OV_RESULT, sector, size, ID_IN_SYNC);
 			break;
 		default:
-			dev_err(DEV, "unexpected command (%s) in receive_DataRequest\n",
-				cmdname(cmd));
+			BUG();
 		}
 		if (verb && __ratelimit(&drbd_ratelimit_state))
 			dev_err(DEV, "Can not satisfy peer's read request, "
@@ -2270,10 +2269,7 @@ static int receive_DataRequest(struct drbd_conf *mdev, enum drbd_packet cmd,
 		break;
 
 	default:
-		dev_err(DEV, "unexpected command (%s) in receive_DataRequest\n",
-		    cmdname(cmd));
-		fault_type = DRBD_FAULT_MAX;
-		goto out_free_e;
+		BUG();
 	}
 
 	/* Throttle, drbd_rs_begin_io and submit should become asynchronous
-- 
1.7.4.1

