Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 12 Oct 2011 14:27:35 +0200
Message-Id: <1318422455-17539-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/13] DRBD: Fix comparison always false warning
	due to long/long long compare
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: David Howells <dhowells@redhat.com>

Fix warnings of the following nature in the drbd header:

In file included from drivers/block/drbd/drbd_bitmap.c:32:
drivers/block/drbd/drbd_int.h: In function 'drbd_get_syncer_progress':
drivers/block/drbd/drbd_int.h:2234: warning: comparison is always false due to limited range of data

where mdev->rs_total (an unsigned long) is being compared to 1ULL << 32, which
is always false on a 32-bit machine.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ece2e4a..de42c7c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2071,7 +2071,7 @@ static inline void drbd_get_syncer_progress(struct drbd_conf *mdev,
 		 * Note: currently we don't support such large bitmaps on 32bit
 		 * arch anyways, but no harm done to be prepared for it here.
 		 */
-		unsigned int shift = mdev->rs_total >= (1ULL << 32) ? 16 : 10;
+		unsigned int shift = mdev->rs_total > UINT_MAX ? 16 : 10;
 		unsigned long left = *bits_left >> shift;
 		unsigned long total = 1UL + (mdev->rs_total >> shift);
 		unsigned long tmp = 1000UL - left * 1000UL/total;
-- 
1.7.4.1

