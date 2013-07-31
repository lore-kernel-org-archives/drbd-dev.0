Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Jul 2013 11:41:14 +0200
Message-Id: <1375263675-18410-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
References: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/5] drbd: fix decoding of bitmap vli rle for
	device sizes > 64 TB
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Symptoms: disconnect after bitmap exchange due to
bitmap overflow (e:49731075554) while decoding bm RLE packet

In the decoding step of the variable length integer run length encoding
there was potentially an uncatched bitshift by wordsize (variable >> 64).

The result of which is "undefined" :(
(only "sometimes" the result is the desired 0)

Fix: don't do any bit shift magic for shift == 64, just assign.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 12c59eb..6fa6673 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4125,7 +4125,11 @@ recv_bm_rle_bits(struct drbd_conf *mdev,
 				(unsigned int)bs.buf_len);
 			return -EIO;
 		}
-		look_ahead >>= bits;
+		/* if we consumed all 64 bits, assign 0; >> 64 is "undefined"; */
+		if (likely(bits < 64))
+			look_ahead >>= bits;
+		else
+			look_ahead = 0;
 		have -= bits;
 
 		bits = bitstream_get_bits(&bs, &tmp, 64 - have);
-- 
1.7.9.5

