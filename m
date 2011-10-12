Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 12 Oct 2011 14:27:25 +0200
Message-Id: <1318422455-17539-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/13] drbd: cosmetic: fix accidental division
	instead of modulo when pretty printing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

For large resync rates, seq_printf_with_thousands_grouping()
accidentally only produced Y,000,00Y, instead of the real numbers.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 6b226cc..7e68d99 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -52,7 +52,7 @@ void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
 	if (unlikely(v >= 1000000)) {
 		/* cool: > GiByte/s */
 		seq_printf(seq, "%ld,", v / 1000000);
-		v /= 1000000;
+		v %= 1000000;
 		seq_printf(seq, "%03ld,%03ld", v/1000, v % 1000);
 	} else if (likely(v >= 1000))
 		seq_printf(seq, "%ld,%03ld", v/1000, v % 1000);
-- 
1.7.4.1

