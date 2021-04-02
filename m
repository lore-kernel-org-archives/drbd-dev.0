Return-Path: <lyl2019@mail.ustc.edu.cn>
Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F2E542016E
	for <drbd-dev@lists.linbit.com>; Fri,  2 Apr 2021 09:07:18 +0200 (CEST)
From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	axboe@kernel.dk
Date: Fri,  2 Apr 2021 00:07:13 -0700
Message-Id: <20210402070713.4069-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] drbd: Fix a use after free in
	get_initial_state
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

My patch converts the type of notify_initial_state_done() from void to
int. So when errors occurs in notify_initial_state_done(), it can
return an error code. My patch also use err propagate the error and avoid
use the freed skb.

Fixes: a29728463b254 ("drbd: Backport the "events2" command")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/block/drbd/drbd_nl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bf7de4c7b96c..21035ff460da 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4861,7 +4861,7 @@ void notify_helper(enum drbd_notification_type type,
 		 err, seq);
 }
 
-static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+static int notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 {
 	struct drbd_genlmsghdr *dh;
 	int err;
@@ -4875,11 +4875,12 @@ static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 	if (nla_put_notification_header(skb, NOTIFY_EXISTS))
 		goto nla_put_failure;
 	genlmsg_end(skb, dh);
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 	pr_err("Error %d sending event. Event seq:%u\n", err, seq);
+	return err;
 }
 
 static void free_state_changes(struct list_head *list)
@@ -4905,6 +4906,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
 	unsigned int seq = cb->args[2];
 	unsigned int n;
+	int err;
 	enum drbd_notification_type flags = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
@@ -4914,7 +4916,9 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
-		notify_initial_state_done(skb, seq);
+		err = notify_initial_state_done(skb, seq);
+		if (err)
+			return err;
 		goto out;
 	}
 	n = cb->args[4]++;
-- 
2.25.1


