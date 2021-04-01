Return-Path: <lyl2019@mail.ustc.edu.cn>
Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CFF4A420602
	for <drbd-dev@lists.linbit.com>; Thu,  1 Apr 2021 13:58:01 +0200 (CEST)
From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	axboe@kernel.dk
Date: Thu,  1 Apr 2021 04:57:53 -0700
Message-Id: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Fix a use after free in get_initial_state
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

In get_initial_state, it calls notify_initial_state_done(skb,..) if
cb->args[5]==1. I see that if genlmsg_put() failed in
notify_initial_state_done(), the skb will be freed by nlmsg_free(skb).
Then get_initial_state will goto out and the freed skb will be used by
return value skb->len.

My patch lets skb_len = skb->len and return the skb_len to avoid the uaf.

Fixes: a29728463b254 ("drbd: Backport the "events2" command")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/block/drbd/drbd_nl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bf7de4c7b96c..474f84675d0a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4905,6 +4905,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
 	unsigned int seq = cb->args[2];
 	unsigned int n;
+	unsigned int skb_len = skb->len;
 	enum drbd_notification_type flags = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
@@ -4915,7 +4916,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
 		notify_initial_state_done(skb, seq);
-		goto out;
+		return skb_len;
 	}
 	n = cb->args[4]++;
 	if (cb->args[4] < cb->args[3])
-- 
2.25.1


