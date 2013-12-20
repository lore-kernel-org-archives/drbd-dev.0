Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:28:58 +0100
Message-Id: <1387542563-6833-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/26] drbd: Add missing error goto
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c706d50..e75c6db 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1273,6 +1273,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
 		drbd_msg_put_info(from_attrs_err_to_txt(err));
+		goto fail_unlock;
 	}
 
 	if (!expect(new_disk_conf->resync_rate >= 1))
-- 
1.7.9.5

