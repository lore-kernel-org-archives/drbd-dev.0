Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:39 +0100
Message-Id: <1364389729-17559-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/17] drbd: fix spurious warning about bitmap
	being locked from detach
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

Introduced in drbd: always write bitmap on detach,
the bitmap bulk writeout on detach was indicating
it expected exclusive bitmap access.

Where I meant to say: expect no more modifications,
but testing/counting is still allowed.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a150b59..67d2bb3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3412,8 +3412,12 @@ static int w_go_diskless(struct drbd_work *w, int unused)
 	 * end up here after a failed attach, before ldev was even assigned.
 	 */
 	if (mdev->bitmap && mdev->ldev) {
+		/* An interrupted resync or similar is allowed to recounts bits
+		 * while we detach.
+		 * Any modifications would not be expected anymore, though.
+		 */
 		if (drbd_bitmap_io_from_worker(mdev, drbd_bm_write,
-					"detach", BM_LOCKED_MASK)) {
+					"detach", BM_LOCKED_TEST_ALLOWED)) {
 			if (test_bit(WAS_READ_ERROR, &mdev->flags)) {
 				drbd_md_set_flag(mdev, MDF_FULL_SYNC);
 				drbd_md_sync(mdev);
-- 
1.7.9.5

