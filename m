Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:37 +0200
Message-Id: <1314284934-17999-42-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 041/118] drbd: Do not access tconn after it was
	freed
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f464cfa..a9dea6d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3260,10 +3260,6 @@ static void drbd_delete_device(unsigned int minor)
 	kfree(mdev->p_uuid);
 	/* mdev->p_uuid = NULL; */
 
-	kfree(mdev->tconn->int_dig_out);
-	kfree(mdev->tconn->int_dig_in);
-	kfree(mdev->tconn->int_dig_vv);
-
 	/* cleanup the rest that has been
 	 * allocated from drbd_new_device
 	 * and actually free the mdev itself */
@@ -3377,6 +3373,9 @@ void drbd_free_tconn(struct drbd_tconn *tconn)
 	write_unlock_irq(&global_state_lock);
 
 	kfree(tconn->name);
+	kfree(tconn->int_dig_out);
+	kfree(tconn->int_dig_in);
+	kfree(tconn->int_dig_vv);
 	kfree(tconn);
 }
 
-- 
1.7.4.1

