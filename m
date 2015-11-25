Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7068810562DA
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:38 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:06 +0100
Message-Id: <1448448851-10343-34-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 33/38] drbd: fix memory leak in drbd_adm_resize
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
index ee34739..6137789 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2706,6 +2706,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		mutex_unlock(&device->resource->conf_update);
 		synchronize_rcu();
 		kfree(old_disk_conf);
+		new_disk_conf = NULL;
 	}
 
 	ddsf = (rs.resize_force ? DDSF_FORCED : 0) | (rs.no_resync ? DDSF_NO_RESYNC : 0);
@@ -2739,6 +2740,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 
  fail_ldev:
 	put_ldev(device);
+	kfree(new_disk_conf);
 	goto fail;
 }
 
-- 
1.9.1

