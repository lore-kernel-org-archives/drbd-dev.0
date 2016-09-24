Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4E6381056498
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 14:09:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3F57B425E19
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 14:09:44 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PZqAN_ebJaQS for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 14:09:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 76EDF425EF3
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 14:09:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vxc5elvoMZkG for <drbd-dev@lists.linbit.com>;
	Mon, 26 Sep 2016 14:09:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id F38F9425E19
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 14:09:42 +0200 (CEST)
Resent-Message-ID: <20160926120942.GB3302@soda.linbit>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 52ECD105646A
	for <drbd-dev@lists.linbit.com>; Sat, 24 Sep 2016 06:27:13 +0200 (CEST)
Received: by mail-pf0-f171.google.com with SMTP id 21so47980690pfy.0
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2016 21:27:12 -0700 (PDT)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Sat, 24 Sep 2016 12:19:00 +0800
Message-Id: <1474690740-10419-1-git-send-email-baoyou.xie@linaro.org>
Cc: xie.baoyou@zte.com.cn, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: mark symbols static where possible
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

We get 4 warnings when building kernel with W=1:
drivers/block/drbd/drbd_worker.c:197:6: warning: no previous prototype for 'drbd_panic_after_delayed_completion_of_aborted_request' [-Wmissing-prototypes]
drivers/block/drbd/drbd_receiver.c:1224:6: warning: no previous prototype for 'one_flush_endio' [-Wmissing-prototypes]
drivers/block/drbd/drbd_req.c:1450:6: warning: no previous prototype for 'send_and_submit_pending' [-Wmissing-prototypes]
drivers/block/drbd/drbd_main.c:924:6: warning: no previous prototype for 'assign_p_sizes_qlim' [-Wmissing-prototypes]

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
So this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/block/drbd/drbd_main.c     | 3 ++-
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 3 ++-
 drivers/block/drbd/drbd_worker.c   | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 100be55..c3133c5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -921,7 +921,8 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 }
 
 /* communicated if (agreed_features & DRBD_FF_WSAME) */
-void assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p, struct request_queue *q)
+static void assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
+				struct request_queue *q)
 {
 	if (q) {
 		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 942384f..432f39a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1221,7 +1221,7 @@ struct one_flush_context {
 	struct issue_flush_context *ctx;
 };
 
-void one_flush_endio(struct bio *bio)
+static void one_flush_endio(struct bio *bio)
 {
 	struct one_flush_context *octx = bio->bi_private;
 	struct drbd_device *device = octx->device;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index de279fe..c725bf5 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1447,7 +1447,8 @@ static bool prepare_al_transaction_nonblock(struct drbd_device *device,
 	return !list_empty(pending);
 }
 
-void send_and_submit_pending(struct drbd_device *device, struct list_head *pending)
+static void
+send_and_submit_pending(struct drbd_device *device, struct list_head *pending)
 {
 	struct drbd_request *req, *tmp;
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index c6755c9..70f2706 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -194,7 +194,8 @@ void drbd_peer_request_endio(struct bio *bio)
 	}
 }
 
-void drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
+static void
+drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
 {
 	panic("drbd%u %s/%u potential random memory corruption caused by delayed completion of aborted local request\n",
 		device->minor, device->resource->name, device->vnr);
-- 
2.7.4

