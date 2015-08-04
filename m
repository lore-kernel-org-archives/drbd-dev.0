Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 101BC1055F56
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:57:00 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:37 +0200
Message-Id: <1438693003-17554-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/19] drbd: fix memory leak in drbd_adm_resize
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

From: Oleg Drokin <green@linuxhacker.ru>

new_disk_conf could be leaked if the follow on checks fail,
so make sure to free it on error if it was not assigned yet.

Found with smatch.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3925f8e..1d42c4f 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2705,6 +2705,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		mutex_unlock(&device->resource->conf_update);
 		synchronize_rcu();
 		kfree(old_disk_conf);
+		new_disk_conf = NULL;
 	}
 
 	ddsf = (rs.resize_force ? DDSF_FORCED : 0) | (rs.no_resync ? DDSF_NO_RESYNC : 0);
@@ -2738,6 +2739,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 
  fail_ldev:
 	put_ldev(device);
+	kfree(new_disk_conf);
 	goto fail;
 }
 
-- 
1.9.1

