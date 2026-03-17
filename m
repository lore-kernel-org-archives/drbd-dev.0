Return-Path: <ethantidmore06@gmail.com>
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
	[209.85.128.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 504B916276A
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 00:23:22 +0100 (CET)
Received: by mail-yw1-f175.google.com with SMTP id
	00721157ae682-79a46ebe2beso28145787b3.2
	for <drbd-dev@lists.linbit.com>; Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] drbd: Fix out-of-bounds access
Date: Tue, 17 Mar 2026 18:23:15 -0500
Message-ID: <20260317232318.18923-2-ethantidmore06@gmail.com>
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Ethan Tidmore <ethantidmore06@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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

The array sync_rule_names[] has 22 elements and rule is used to access
this array. The variable rule has the possibility of being index 22
because the condition (rule > ARRAY_SIZE(sync_rule_names)) could
evaluate to 22 > 22 which would be false and then rule would be used to
index sync_rule_names[] which would cause and out-of-bounds bug.

Change condition from (rule > ARRAY_SIZE(sync_rule_names)) to
(rule >= ARRAY_SIZE(sync_rule_names)).

Detected by Smatch:
drivers/block/drbd/drbd_receiver.c:280 drbd_sync_rule_str() error:
buffer overflow 'sync_rule_names' 22 <= 22

Fixes: 851f106c134a3 ("drbd: rework receiver for DRBD 9 transport and protocol")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 06d83b5ffafb..280be2ee7d7e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -273,7 +273,7 @@ static void drbd_cancel_conflicting_resync_requests(struct drbd_peer_device *pee
 
 static const char *drbd_sync_rule_str(enum sync_rule rule)
 {
-	if (rule < 0 || rule > ARRAY_SIZE(sync_rule_names)) {
+	if (rule < 0 || rule >= ARRAY_SIZE(sync_rule_names)) {
 		WARN_ON(true);
 		return "?";
 	}
-- 
2.53.0

