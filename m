Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:38 +0100
Message-Id: <20181220162344.8430-12-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/17] drbd: avoid spurious self-outdating with
	concurrent disconnect / down
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

If peers are "simultaneously" told to disconnect from each other,
either explicitly, or implicitly by taking down the resource,
with bad timing, one side may see its disconnect "fail" with
a result of "state change failed by peer", and interpret this as
"please oudate yourself".

Try to catch this by checking for current connection status,
and possibly retry as local-only state change instead.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1958eb33b643..82915880c5e9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2711,8 +2711,10 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection, bool force)
 {
+	enum drbd_conns cstate;
 	enum drbd_state_rv rv;
 
+repeat:
 	rv = conn_request_state(connection, NS(conn, C_DISCONNECTING),
 			force ? CS_HARD : 0);
 
@@ -2730,6 +2732,11 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection
 
 		break;
 	case SS_CW_FAILED_BY_PEER:
+		spin_lock_irq(&connection->resource->req_lock);
+		cstate = connection->cstate;
+		spin_unlock_irq(&connection->resource->req_lock);
+		if (cstate <= C_WF_CONNECTION)
+			goto repeat;
 		/* The peer probably wants to see us outdated. */
 		rv = conn_request_state(connection, NS2(conn, C_DISCONNECTING,
 							disk, D_OUTDATED), 0);
-- 
2.17.1

