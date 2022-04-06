Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
	[209.85.218.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 65DB2420FCC
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:34 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id qh7so6177766ejb.11
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:34 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:11 +0200
Message-Id: <20220406190715.1938174-4-christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/7] block: drbd: drbd_receiver: Remove redundant
	assignment to err
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable err is set to '-EIO' but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/block/drbd/drbd_receiver.c:3955:5: warning: Value stored to
'err' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 08da922f81d1..911c26753556 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3903,7 +3903,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 				drbd_err(device, "verify-alg of wrong size, "
 					"peer wants %u, accepting only up to %u byte\n",
 					data_size, SHARED_SECRET_MAX);
-				err = -EIO;
 				goto reconnect;
 			}
 
-- 
2.35.1

