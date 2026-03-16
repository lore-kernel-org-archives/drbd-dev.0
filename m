Return-Path: <colin.i.king@gmail.com>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CCAB91608F3
	for <drbd-dev@lists.linbit.com>; Mon, 16 Mar 2026 21:27:13 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
	5b1f17b1804b1-4853c1ca73aso42024505e9.2
	for <drbd-dev@lists.linbit.com>; Mon, 16 Mar 2026 13:27:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH][next] drbd: Fix typos: "receive_peer_dagatg" ->
	"receive_peer_dagtag"
Date: Mon, 16 Mar 2026 20:25:48 +0000
Message-ID: <20260316202549.33978-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

There are a couple of typos in drbd_info and drbd_err messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 06d83b5ffafb..100207623182 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -8850,14 +8850,14 @@ static int receive_peer_dagtag(struct drbd_connection *connection, struct packet
 			    strategy != SYNC_SOURCE_USE_BITMAP &&
 			    strategy != SYNC_TARGET_USE_BITMAP) {
 				drbd_info(peer_device,
-					  "receive_peer_dagatg(): %s by rule=%s\n",
+					  "receive_peer_dagtag(): %s by rule=%s\n",
 					  strategy_descriptor(strategy).name,
 					  drbd_sync_rule_str(rule));
 				goto out;
 			}
 		} else if (ps != strategy) {
 			drbd_err(peer_device,
-				 "receive_peer_dagatg(): Inconsistent resync directions %s %s\n",
+				 "receive_peer_dagtag(): Inconsistent resync directions %s %s\n",
 				 strategy_descriptor(strategy).name, strategy_descriptor(ps).name);
 			goto out;
 		}
-- 
2.53.0

