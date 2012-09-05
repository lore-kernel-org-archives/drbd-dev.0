Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0ED3F1019A78
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 13:19:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id ECC5F1B40FC
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 13:19:02 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hagoHzOmMyUi for <drbd-dev@lists.linbit.com>;
	Wed,  5 Sep 2012 13:19:02 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id CE2C51B40FB
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 13:19:02 +0200 (CEST)
Resent-Message-ID: <20120905111902.GA28527@soda.linbit>
MIME-Version: 1.0
Date: Wed, 5 Sep 2012 15:09:25 +0800
Message-ID: <CAPgLHd_HTYgzRJWvM7wekcm+EiVj24WzrhcOXkj9c1k33z+ARg@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: use list_move_tail instead of
	list_del/list_add_tail
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using list_move_tail() instead of list_del() + list_add_tail().

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/block/drbd/drbd_worker.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 6bce2cc..a196281 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -141,8 +141,7 @@ static void drbd_endio_write_sec_final(struct drbd_epoch_entry *e) __releases(lo
 
 	spin_lock_irqsave(&mdev->req_lock, flags);
 	mdev->writ_cnt += e->size >> 9;
-	list_del(&e->w.list); /* has been on active_ee or sync_ee */
-	list_add_tail(&e->w.list, &mdev->done_ee);
+	list_move_tail(&e->w.list, &mdev->done_ee);
 
 	/* No hlist_del_init(&e->collision) here, we did not send the Ack yet,
 	 * neither did we wake possibly waiting conflicting requests.


