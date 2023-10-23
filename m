Return-Path: <chentao@kylinos.cn>
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 701174201C5
	for <drbd-dev@lists.linbit.com>; Mon, 23 Oct 2023 08:42:27 +0200 (CEST)
From: Kunwu Chan <chentao@kylinos.cn>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk
Date: Mon, 23 Oct 2023 14:31:55 +0800
Message-Id: <20231023063155.719469-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, kunwu.chan@hotmail.com,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Spelling fix in comment
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

protocoll -> protocol

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 380e6584a4ee..60e6e016829e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1745,7 +1745,7 @@ void request_timer_fn(struct timer_list *t)
 	 * but which is still waiting for an ACK. */
 	req_peer = connection->req_ack_pending;
 
-	/* if we don't have such request (e.g. protocoll A)
+	/* if we don't have such request (e.g. protocol A)
 	 * check the oldest requests which is still waiting on its epoch
 	 * closing barrier ack. */
 	if (!req_peer)
-- 
2.34.1

