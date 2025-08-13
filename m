Return-Path: <liaoyuanhong@vivo.com>
Received: from OS8PR02CU002.outbound.protection.outlook.com
	(mail-japanwestazon11012050.outbound.protection.outlook.com
	[40.107.75.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1CF671608F0
	for <drbd-dev@lists.linbit.com>; Wed, 13 Aug 2025 13:14:16 +0200 (CEST)
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drbd: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:41:24 +0800
Message-Id: <20250813094124.553070-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c2b6c4d9729d..6616334d3813 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2274,7 +2274,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 static enum drbd_state_rv
 _conn_rq_cond(struct drbd_connection *connection, union drbd_state mask, union drbd_state val)
 {
-	enum drbd_state_rv err, rv = SS_UNKNOWN_ERROR; /* continue waiting */;
+	enum drbd_state_rv err, rv = SS_UNKNOWN_ERROR; /* continue waiting */
 
 	if (test_and_clear_bit(CONN_WD_ST_CHG_OKAY, &connection->flags))
 		rv = SS_CW_SUCCESS;
-- 
2.34.1

