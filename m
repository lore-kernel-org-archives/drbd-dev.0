Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:27 +0200
Message-Id: <1398703415-17780-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/24] drbd: keep max-bio size during
	detach/attach on disconnected primary
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

From: Lars Ellenberg <lars@linbit.com>

We want to store in persistent meta data what the peer DRBD can handle,
which, due to spreading requests to multiple bios,
may be more than its backing device can handle.

Otherwise, if a disconnected Primary temporarily loses access to its local data
as well, we may accidentally shrink the max-bio setting, portentially causing
already assembled, but not yet processed, application bios to be spuriously
failed due to device limits.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 2364b78..a187c5b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1194,8 +1194,14 @@ void drbd_reconsider_max_bio_size(struct drbd_device *device)
 			peer = DRBD_MAX_BIO_SIZE_P95;  /* drbd 8.3.8 onwards, before 8.4.0 */
 		else
 			peer = DRBD_MAX_BIO_SIZE;
-	}
 
+		/* We may later detach and re-attach on a disconnected Primary.
+		 * Avoid this setting to jump back in that case.
+		 * We want to store what we know the peer DRBD can handle,
+		 * not what the peer IO backend can handle. */
+		if (peer > device->peer_max_bio_size)
+			device->peer_max_bio_size = peer;
+	}
 	new = min(local, peer);
 
 	if (device->state.role == R_PRIMARY && new < now)
-- 
1.9.1

