Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:43 +0200
Message-Id: <1314284934-17999-108-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 107/118] drbd: Extracted
	is_valid_conn_transition() out of is_valid_transition()
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
 drivers/block/drbd/drbd_state.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3199bf9..b381faa 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -396,33 +396,42 @@ is_valid_soft_transition(union drbd_state os, union drbd_state ns)
 	return rv;
 }
 
-/**
- * is_valid_transition() - Returns an SS_ error code if the state transition is not possible
- * This limits hard state transitions. Hard state transitions are facts there are
- * imposed on DRBD by the environment. E.g. disk broke or network broke down.
- * But those hard state transitions are still not allowed to do everything.
- * @ns:		new state.
- * @os:		old state.
- */
 static enum drbd_state_rv
-is_valid_transition(union drbd_state os, union drbd_state ns)
+is_valid_conn_transition(enum drbd_conns oc, enum drbd_conns nc)
 {
 	enum drbd_state_rv rv = SS_SUCCESS;
 
 	/* Disallow Network errors to configure a device's network part */
-	if ((ns.conn >= C_TIMEOUT && ns.conn <= C_TEAR_DOWN) &&
-	    os.conn <= C_DISCONNECTING)
+	if ((nc >= C_TIMEOUT && nc <= C_TEAR_DOWN) && oc <= C_DISCONNECTING)
 		rv = SS_NEED_CONNECTION;
 
 	/* After a network error only C_UNCONNECTED or C_DISCONNECTING may follow. */
-	if (os.conn >= C_TIMEOUT && os.conn <= C_TEAR_DOWN &&
-	    ns.conn != C_UNCONNECTED && ns.conn != C_DISCONNECTING)
+	if (oc >= C_TIMEOUT && oc <= C_TEAR_DOWN && nc != C_UNCONNECTED && nc != C_DISCONNECTING)
 		rv = SS_IN_TRANSIENT_STATE;
 
 	/* After C_DISCONNECTING only C_STANDALONE may follow */
-	if (os.conn == C_DISCONNECTING && ns.conn != C_STANDALONE)
+	if (oc == C_DISCONNECTING && nc != C_STANDALONE)
 		rv = SS_IN_TRANSIENT_STATE;
 
+	return rv;
+}
+
+
+/**
+ * is_valid_transition() - Returns an SS_ error code if the state transition is not possible
+ * This limits hard state transitions. Hard state transitions are facts there are
+ * imposed on DRBD by the environment. E.g. disk broke or network broke down.
+ * But those hard state transitions are still not allowed to do everything.
+ * @ns:		new state.
+ * @os:		old state.
+ */
+static enum drbd_state_rv
+is_valid_transition(union drbd_state os, union drbd_state ns)
+{
+	enum drbd_state_rv rv;
+
+	rv = is_valid_conn_transition(os.conn, ns.conn);
+
 	/* we cannot fail (again) if we already detached */
 	if (ns.disk == D_FAILED && os.disk == D_DISKLESS)
 		rv = SS_IS_DISKLESS;
-- 
1.7.4.1

