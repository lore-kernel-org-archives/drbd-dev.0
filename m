Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:48:54 +0200
Message-Id: <1314881345-6420-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/18] drbd: get rid of drbd_bcast_ee,
	it is of no use anymore
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

This function was used to broadcast the (leading part of the)
bio payload in case we see a data integrity error.  It could be received
from userland with the drbdsetup events subcommand,
to have a peek into the payload that caused the checksum mismatch,
and guess from there what may have caused the mismatch,
mainly to guess wether it was modification of in-flight data,
or data corruption by broken hardware or software bugs.

Meanwhile we support bios that are larger than the maximum payload a
netlink datagram can carry.
And we have means to reliably detect modification of in-flight data by
calculating, and comparing, the checksum before and after sendmsg.
There is no need to carry this around anymore.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 12b1533..6dfea2f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1356,8 +1356,6 @@ read_in_block(struct drbd_conf *mdev, u64 id, sector_t sector,
 		if (memcmp(dig_in, dig_vv, dgs)) {
 			dev_err(DEV, "Digest integrity check FAILED: %llus +%u\n",
 				(unsigned long long)sector, data_size);
-			drbd_bcast_ee(mdev, "digest failed",
-					dgs, dig_in, dig_vv, peer_req);
 			drbd_free_ee(mdev, peer_req);
 			return NULL;
 		}
-- 
1.7.4.1

