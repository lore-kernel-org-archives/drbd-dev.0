Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:50 +0200
Message-Id: <1314284934-17999-115-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 114/118] drbd: Global_state_lock not necessary
	here...
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
 drivers/block/drbd/drbd_state.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index db2aee9..81f66b3 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1375,8 +1375,6 @@ _conn_request_state(struct drbd_tconn *tconn, union drbd_state mask, union drbd_
 	struct after_conn_state_chg_work *acscw;
 	enum drbd_conns oc = tconn->cstate;
 
-	read_lock(&global_state_lock);
-
 	rv = is_valid_conn_transition(oc, val.conn);
 	if (rv < SS_SUCCESS)
 		goto abort;
@@ -1418,8 +1416,6 @@ _conn_request_state(struct drbd_tconn *tconn, union drbd_state mask, union drbd_
 	}
 
 abort:
-	read_unlock(&global_state_lock);
-
 	return rv;
 }
 
-- 
1.7.4.1

