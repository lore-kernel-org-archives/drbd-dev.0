Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:36 +0100
Message-Id: <20181220162344.8430-10-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/17] drbd: fix comment typos
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

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_state.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 76d74b2122d6..3a0fe357b68b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4428,7 +4428,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 		       (peer_state.disk == D_NEGOTIATING ||
 			os.disk == D_NEGOTIATING));
 		/* if we have both been inconsistent, and the peer has been
-		 * forced to be UpToDate with --overwrite-data */
+		 * forced to be UpToDate with --force */
 		cr |= test_bit(CONSIDER_RESYNC, &device->flags);
 		/* if we had been plain connected, and the admin requested to
 		 * start a sync by "invalidate" or "invalidate-remote" */
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 18d53fe60d1d..883155657273 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1124,7 +1124,7 @@ static union drbd_state sanitize_state(struct drbd_device *device, union drbd_st
 			ns.pdsk = D_UP_TO_DATE;
 	}
 
-	/* Implications of the connection stat on the disk states */
+	/* Implications of the connection state on the disk states */
 	disk_min = D_DISKLESS;
 	disk_max = D_UP_TO_DATE;
 	pdsk_min = D_INCONSISTENT;
-- 
2.17.1

