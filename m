Return-Path: <ethantidmore06@gmail.com>
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
	[209.85.128.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CD0F41627AE
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 00:23:23 +0100 (CET)
Received: by mail-yw1-f173.google.com with SMTP id
	00721157ae682-79a610a32a6so19393847b3.0
	for <drbd-dev@lists.linbit.com>; Tue, 17 Mar 2026 16:23:23 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] drbd: Add missing error code in drbd_main.c
Date: Tue, 17 Mar 2026 18:23:17 -0500
Message-ID: <20260317232318.18923-4-ethantidmore06@gmail.com>
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

No error code is assigned in alloc_workqueue() error path.

Assign error code -ENOMEM.

Detected by Smatch:
drivers/block/drbd/drbd_main.c:4575 drbd_init() warn:
missing error code 'err'

Fixes: b2e550c8d1f54 ("drbd: rework module core for DRBD 9 transport and multi-peer")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e2c3530cfa13..689b7cac5ec2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -4569,6 +4569,7 @@ static int __init drbd_init(void)
 		goto fail;
 	}
 
+	err = -ENOMEM;
 	ping_ack_sender = alloc_workqueue("drbd_pas",
 			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!ping_ack_sender)
-- 
2.53.0

