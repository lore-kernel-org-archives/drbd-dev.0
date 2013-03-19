Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Mar 2013 18:16:49 +0100
Message-Id: <1363713419-17803-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
References: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/18] drbd: drbd_al_being_io: short circuit to
	reduce latency
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

A request hitting an already "hot" extent should proceed right away,
even if some other requests need to wait for pending transactions.

Without that short-circuit, several simultaneous make_request contexts
race for committing the transaction, possibly penalizing the innocent.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 82199d9..1d7244d 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -256,6 +256,7 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i, bool dele
 	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last = i->size == 0 ? first : (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
 	unsigned enr;
+	bool need_transaction = false;
 	bool locked = false;
 
 	/* When called through generic_make_request(), we must delegate
@@ -273,8 +274,17 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i, bool dele
 	D_ASSERT(first <= last);
 	D_ASSERT(atomic_read(&mdev->local_cnt) > 0);
 
-	for (enr = first; enr <= last; enr++)
-		wait_event(mdev->al_wait, _al_get(mdev, enr) != NULL);
+	for (enr = first; enr <= last; enr++) {
+		struct lc_element *al_ext;
+		wait_event(mdev->al_wait, (al_ext = _al_get(mdev, enr)) != NULL);
+		if (al_ext->lc_number != enr)
+			need_transaction = true;
+	}
+
+	/* If *this* request was to an already active extent,
+	 * we're done, even if there are pending changes. */
+	if (!need_transaction)
+		return;
 
 	/* Serialize multiple transactions.
 	 * This uses test_and_set_bit, memory barrier is implicit.
-- 
1.7.9.5

