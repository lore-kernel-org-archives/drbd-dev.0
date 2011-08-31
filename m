Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Aug 2011 17:10:55 +0200
Message-Id: <1314803468-1201-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
References: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/16] drbd: Use ping-timeout when waiting for
	missing ack packets
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

When the node with the discard flag resolves write conflicts in
dual-primary mode, it may determine that its peer has sent ack packets
on the metadata socket which did not arrive, yet.  Wait for the next ack
with ping-timeout instead of a hard-coded 30 seconds.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 987af1a..07fc7c1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1713,11 +1713,12 @@ static int drbd_wait_peer_seq(struct drbd_conf *mdev, const u32 packet_seq)
 		}
 		p_seq = mdev->peer_seq;
 		spin_unlock(&mdev->peer_seq_lock);
-		timeout = schedule_timeout(30*HZ);
+		timeout = mdev->tconn->net_conf->ping_timeo*HZ/10;
+		timeout = schedule_timeout(timeout);
 		spin_lock(&mdev->peer_seq_lock);
 		if (timeout == 0 && p_seq == mdev->peer_seq) {
 			ret = -ETIMEDOUT;
-			dev_err(DEV, "ASSERT FAILED waited 30 seconds for sequence update, forcing reconnect\n");
+			dev_err(DEV, "Timed out waiting for missing ack packets; disconnecting\n");
 			break;
 		}
 	}
-- 
1.7.4.1

