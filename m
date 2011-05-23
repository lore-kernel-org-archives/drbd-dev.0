Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F13BA1057453
	for <drbd-dev@lists.linbit.com>; Tue, 24 May 2011 00:29:43 +0200 (CEST)
Message-Id: <201105232229.p4NMTWGo016167@imap1.linux-foundation.org>
To: jens.axboe@oracle.com
From: akpm@linux-foundation.org
Date: Mon, 23 May 2011 15:29:32 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, akpm@linux-foundation.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch 1/1] drbd: fix warning
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andrew Morton <akpm@linux-foundation.org>

In file included from drivers/block/drbd/drbd_main.c:54:                        drivers/block/drbd/drbd_int.h:1190: warning: parameter has incomplete type

Forward declarations of enums do not work.

Fix it unpleasantly by moving the prototype.

Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_int.h |    2 --
 drivers/block/drbd/drbd_req.h |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/block/drbd/drbd_int.h~drbd-fix-warning drivers/block/drbd/drbd_int.h
--- a/drivers/block/drbd/drbd_int.h~drbd-fix-warning
+++ a/drivers/block/drbd/drbd_int.h
@@ -1218,8 +1218,6 @@ extern void drbd_free_resources(struct d
 extern void tl_release(struct drbd_conf *mdev, unsigned int barrier_nr,
 		       unsigned int set_size);
 extern void tl_clear(struct drbd_conf *mdev);
-enum drbd_req_event;
-extern void tl_restart(struct drbd_conf *mdev, enum drbd_req_event what);
 extern void _tl_add_barrier(struct drbd_conf *, struct drbd_tl_epoch *);
 extern void drbd_free_sock(struct drbd_conf *mdev);
 extern int drbd_send(struct drbd_conf *mdev, struct socket *sock,
diff -puN drivers/block/drbd/drbd_req.h~drbd-fix-warning drivers/block/drbd/drbd_req.h
--- a/drivers/block/drbd/drbd_req.h~drbd-fix-warning
+++ a/drivers/block/drbd/drbd_req.h
@@ -323,6 +323,7 @@ extern int __req_mod(struct drbd_request
 extern void complete_master_bio(struct drbd_conf *mdev,
 		struct bio_and_error *m);
 extern void request_timer_fn(unsigned long data);
+extern void tl_restart(struct drbd_conf *mdev, enum drbd_req_event what);
 
 /* use this if you don't want to deal with calling complete_master_bio()
  * outside the spinlock, e.g. when walking some list on cleanup. */
_
