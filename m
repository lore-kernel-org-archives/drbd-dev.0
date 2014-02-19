Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 19 Feb 2014 10:49:07 +0100
Message-Id: <1392803347-6075-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1392803347-6075-1-git-send-email-philipp.reisner@linbit.com>
References: <20140218202054.GD25515@kernel.dk>
	<1392803347-6075-1-git-send-email-philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Fix future possible NULL pointer
	dereference
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

From: Andreas Gruenbacher <agruen@linbit.com>

Right now every resource has exactly one connection. But we are preparing
for dynamic connections. I.e. in the future thre can be resources without
connections.

However smatch points this out as 'variable dereferenced before check',
which is correct.

This issue was introduced in
drbd: get_one_status(): Iterate over resource->devices instead of connection->peer_devices

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 2086b12..526414b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2776,7 +2776,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
 	if (device &&
 	    nla_put_u32(skb, T_ctx_volume, device->vnr))
 		goto nla_put_failure;
-	if (nla_put_string(skb, T_ctx_resource_name, connection->resource->name))
+	if (nla_put_string(skb, T_ctx_resource_name, resource->name))
 		goto nla_put_failure;
 	if (connection) {
 		if (connection->my_addr_len &&
-- 
1.7.9.5

