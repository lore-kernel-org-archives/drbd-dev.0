Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:50 +0200
Message-Id: <1314284934-17999-55-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 054/118] drbd: Make the peer_seq updating code
	more obvious
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Make it more clear that update_peer_seq() is supposed to wake up the
seq_wait queue whenever the sequence number changes.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cde48f3..654c1c9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1654,15 +1654,15 @@ static u32 seq_max(u32 a, u32 b)
 	return seq_greater(a, b) ? a : b;
 }
 
-static void update_peer_seq(struct drbd_conf *mdev, unsigned int new_seq)
+static void update_peer_seq(struct drbd_conf *mdev, unsigned int peer_seq)
 {
-	unsigned int m;
+	unsigned int old_peer_seq;
 
 	spin_lock(&mdev->peer_seq_lock);
-	m = seq_max(mdev->peer_seq, new_seq);
-	mdev->peer_seq = m;
+	old_peer_seq = mdev->peer_seq;
+	mdev->peer_seq = seq_max(mdev->peer_seq, peer_seq);
 	spin_unlock(&mdev->peer_seq_lock);
-	if (m == new_seq)
+	if (old_peer_seq != peer_seq)
 		wake_up(&mdev->seq_wait);
 }
 
-- 
1.7.4.1

