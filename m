Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:48:49 +0200
Message-Id: <1314881345-6420-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/18] drbd: only wakeup if something changed in
	update_peer_seq
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

This commit got it wrong:
    drbd: Make the peer_seq updating code more obvious

    Make it more clear that update_peer_seq() is supposed to wake up the
    seq_wait queue whenever the sequence number changes.

We don't need to wake up everytime we receive a sequence number
that is _different_ from our currently stored "newest" sequence number,
but only if we receive a sequence number _newer_ than what we already
have, when we actually change mdev->peer_seq.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 620f27f..64f658b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1737,14 +1737,15 @@ static bool need_peer_seq(struct drbd_conf *mdev)
 
 static void update_peer_seq(struct drbd_conf *mdev, unsigned int peer_seq)
 {
-	unsigned int old_peer_seq;
+	unsigned int newest_peer_seq;
 
 	if (need_peer_seq(mdev)) {
 		spin_lock(&mdev->peer_seq_lock);
-		old_peer_seq = mdev->peer_seq;
-		mdev->peer_seq = seq_max(mdev->peer_seq, peer_seq);
+		newest_peer_seq = seq_max(mdev->peer_seq, peer_seq);
+		mdev->peer_seq = newest_peer_seq;
 		spin_unlock(&mdev->peer_seq_lock);
-		if (old_peer_seq != peer_seq)
+		/* wake up only if we actually changed mdev->peer_seq */
+		if (peer_seq == newest_peer_seq)
 			wake_up(&mdev->seq_wait);
 	}
 }
-- 
1.7.4.1

