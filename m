Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EA0664203D3
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2020 17:18:28 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id a5so2094760wmb.0
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2020 09:18:28 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id d1sm3916641wrw.52.2020.03.10.09.18.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 10 Mar 2020 09:18:27 -0700 (PDT)
Resent-Message-ID: <20200310161825.GB10072@soda.linbit>
Received: from qq.com (smtpbg477.qq.com [59.36.132.88])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 33FF5420385
	for <drbd-dev@lists.linbit.com>; Sat,  7 Mar 2020 03:46:09 +0100 (CET)
From: Jackie Liu <liuyun01@tj.kylinos.cn>
To: axboe@kernel.dk
Date: Sat,  7 Mar 2020 10:39:25 +0800
Message-Id: <20200307023925.20789-1-liuyun01@tj.kylinos.cn>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: delete invalid function
	drbd_md_mark_dirty_
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

From: Jackie Liu <liuyun01@kylinos.cn>

We deleted last_md_mark_dirty long ago, this function no longer needs to
exist, delete it, otherwise a compilation error will occur when DEBUG is
opened.

Fixes: ac0acb9e39ac ("drbd: use drbd_device_post_work() in more place")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/block/drbd/drbd_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a18155cdce41..6fc776ccef3e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3414,22 +3414,11 @@ int drbd_md_read(struct drbd_device *device, struct drbd_backing_dev *bdev)
  * the meta-data super block. This function sets MD_DIRTY, and starts a
  * timer that ensures that within five seconds you have to call drbd_md_sync().
  */
-#ifdef DEBUG
-void drbd_md_mark_dirty_(struct drbd_device *device, unsigned int line, const char *func)
-{
-	if (!test_and_set_bit(MD_DIRTY, &device->flags)) {
-		mod_timer(&device->md_sync_timer, jiffies + HZ);
-		device->last_md_mark_dirty.line = line;
-		device->last_md_mark_dirty.func = func;
-	}
-}
-#else
 void drbd_md_mark_dirty(struct drbd_device *device)
 {
 	if (!test_and_set_bit(MD_DIRTY, &device->flags))
 		mod_timer(&device->md_sync_timer, jiffies + 5*HZ);
 }
-#endif
 
 void drbd_uuid_move_history(struct drbd_device *device) __must_hold(local)
 {
-- 
2.17.1



