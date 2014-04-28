Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:20 +0200
Message-Id: <1398703415-17780-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/24] drbd: Do not BUG() when connection breaks
	in a special way
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

When a 'cluster wide' disconnect executes, the result comes back
from the peer, and immediately after that the connection breaks
then _conn_rq_cond() reported back SS_CW_SUCCESS.
Therefore _conn_request_state() calls conn_set_state(), which
has a BUG() in it.
The BUG() is hit because conn_is_valid_transition() does not like
the transaction. Which goes back to is_valid_soft_transition()
returning SS_OUTDATE_WO_CONN.

This fix is to consider an error reported by is_valid_soft_transition()
even when the peer agreed to the transaction.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3796662..a5d8aae 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1765,19 +1765,19 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 static enum drbd_state_rv
 _conn_rq_cond(struct drbd_connection *connection, union drbd_state mask, union drbd_state val)
 {
-	enum drbd_state_rv rv;
+	enum drbd_state_rv err, rv = SS_UNKNOWN_ERROR; /* continue waiting */;
 
 	if (test_and_clear_bit(CONN_WD_ST_CHG_OKAY, &connection->flags))
-		return SS_CW_SUCCESS;
+		rv = SS_CW_SUCCESS;
 
 	if (test_and_clear_bit(CONN_WD_ST_CHG_FAIL, &connection->flags))
-		return SS_CW_FAILED_BY_PEER;
+		rv = SS_CW_FAILED_BY_PEER;
 
-	rv = conn_is_valid_transition(connection, mask, val, 0);
-	if (rv == SS_SUCCESS && connection->cstate == C_WF_REPORT_PARAMS)
-		rv = SS_UNKNOWN_ERROR; /* continue waiting */
+	err = conn_is_valid_transition(connection, mask, val, 0);
+	if (err == SS_SUCCESS && connection->cstate == C_WF_REPORT_PARAMS)
+		return rv;
 
-	return rv;
+	return err;
 }
 
 enum drbd_state_rv
-- 
1.9.1

