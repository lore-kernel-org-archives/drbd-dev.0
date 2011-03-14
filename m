Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 34E3F1057026
	for <drbd-dev@lists.linbit.com>; Mon, 14 Mar 2011 10:33:39 +0100 (CET)
Resent-Message-ID: <20110314093338.GD11932@barkeeper1-xen.linbit>
Date: Mon, 14 Mar 2011 12:25:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20110314092511.GK2008@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: change int to unsigned int
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

These are changes to make my static checker happy.  I don't know the
code well enough to say if it makes a difference at run-time but it
doesn't hurt to fix these up.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index fe1564c..f33575c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1383,7 +1383,7 @@ static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
 	D_ASSERT(sector == bio->bi_sector);
 
 	bio_for_each_segment(bvec, bio, i) {
-		expect = min_t(int, data_size, bvec->bv_len);
+		expect = min_t(unsigned int, data_size, bvec->bv_len);
 		rr = drbd_recv(mdev,
 			     kmap(bvec->bv_page)+bvec->bv_offset,
 			     expect);
@@ -3996,7 +3996,7 @@ static int drbd_do_handshake(struct drbd_conf *mdev)
 	    PRO_VERSION_MIN > p->protocol_max)
 		goto incompat;
 
-	mdev->agreed_pro_version = min_t(int, PRO_VERSION_MAX, p->protocol_max);
+	mdev->agreed_pro_version = min_t(unsigned int, PRO_VERSION_MAX, p->protocol_max);
 
 	dev_info(DEV, "Handshake successful: "
 	     "Agreed network protocol version %d\n", mdev->agreed_pro_version);
@@ -4515,7 +4515,7 @@ struct asender_cmd {
 	int (*process)(struct drbd_conf *mdev, struct p_header80 *h);
 };
 
-static struct asender_cmd *get_asender_cmd(int cmd)
+static struct asender_cmd *get_asender_cmd(unsigned int cmd)
 {
 	static struct asender_cmd asender_tbl[] = {
 		/* anything missing from this table is in
