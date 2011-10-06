Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  6 Oct 2011 15:37:46 +0200
Message-Id: <1317908280-28951-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
References: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/15] drbd: Removed dead code
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
 drivers/block/drbd/drbd_nl.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d596900..13230d9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2285,7 +2285,6 @@ int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 	enum drbd_ret_code retcode;
 	cpumask_var_t new_cpu_mask;
 	struct drbd_tconn *tconn;
-	int *rs_plan_s = NULL;
 	struct res_opts res_opts;
 	int err;
 
@@ -2336,7 +2335,6 @@ int drbd_adm_resource_opts(struct sk_buff *skb, struct genl_info *info)
 	}
 
 fail:
-	kfree(rs_plan_s);
 	free_cpumask_var(new_cpu_mask);
 
 	drbd_adm_finish(info, retcode);
-- 
1.7.4.1

