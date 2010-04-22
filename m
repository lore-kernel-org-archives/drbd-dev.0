Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D5A3D105A78D
	for <drbd-dev@lists.linbit.com>; Thu, 22 Apr 2010 14:45:47 +0200 (CEST)
Resent-Message-ID: <20100422124546.GR12540@soda.linbit>
Date: Thu, 22 Apr 2010 11:56:41 +0200
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20100422095641.GR29647@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-user@lists.linbit.com, Jens Axboe <jens.axboe@oracle.com>
Subject: [Drbd-dev] [patch] drbd: fix memory leak
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

We leak memory if "--dry-run" is not supported by the peer.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 67e0fc5..93d1f9b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1695,6 +1695,7 @@ int drbd_send_protocol(struct drbd_conf *mdev)
 			cf |= CF_DRY_RUN;
 		else {
 			dev_err(DEV, "--dry-run is not supported by peer");
+			kfree(p);
 			return 0;
 		}
 	}
