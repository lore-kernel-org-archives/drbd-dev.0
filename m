Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E5EB210003E2
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2012 13:31:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D9AF91B4386
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2012 13:31:30 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WthnLb6ajLKE for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jun 2012 13:31:30 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A48BD1B4385
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2012 13:31:30 +0200 (CEST)
Resent-Message-ID: <20120612113130.GE4069@soda.linbit>
Date: Tue, 12 Jun 2012 10:43:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20120612074310.GC15060@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: potential integer overflow in
	receive_SyncParam()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I believe this comes from the network so there is a risk of integer
overflow on 32 bit.  Using kcalloc() is a little cleaner as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ea4836e..1e27876 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2902,7 +2902,7 @@ static int receive_SyncParam(struct drbd_conf *mdev, enum drbd_packets cmd, unsi
 
 			fifo_size = (mdev->sync_conf.c_plan_ahead * 10 * SLEEP_TIME) / HZ;
 			if (fifo_size != mdev->rs_plan_s.size && fifo_size > 0) {
-				rs_plan_s   = kzalloc(sizeof(int) * fifo_size, GFP_KERNEL);
+				rs_plan_s = kcalloc(fifo_size, sizeof(int), GFP_KERNEL);
 				if (!rs_plan_s) {
 					dev_err(DEV, "kmalloc of fifo_buffer failed");
 					goto disconnect;
