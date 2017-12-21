Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BE0D01057584
	for <drbd-dev@lists.linbit.com>; Thu, 21 Dec 2017 18:58:34 +0100 (CET)
From: johannes@johannesthoma.com
To: drbd-dev@lists.linbit.com
Date: Thu, 21 Dec 2017 18:53:30 +0100
Message-Id: <1513878810-6207-1-git-send-email-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH] Fixed possible use after free in
	drbd_thread_setup
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

From: Johannes Thoma <johannes@johannesthoma.com>

drbd_thread might already be freed when complete returns,
hence we shouldn't access the drbd_thread object (thi)
after calling complete().

I am not 100% sure if this creates any further races,
alternative would be to acquire the lock before freeing
the thread object (so that spin_unlock_irqrestore() has
exited already). Please let me know what you think.

Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
---
 drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index a2b5683..dbf2e41 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -563,8 +563,8 @@ restart:
 	else
 		drbd_info(resource, "Terminating %s thread\n", thi->name);
 
-	complete(&thi->stop);
 	spin_unlock_irqrestore(&thi->t_lock, flags);
+	complete(&thi->stop);
 
 	if (connection)
 		kref_put(&connection->kref, drbd_destroy_connection);
-- 
2.8.0-rc4

