Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CE6AC420372
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 15:53:32 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id e13so3394385edj.7
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 06:53:32 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Dec 2022 15:53:19 +0100
Message-Id: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/8] Miscellaneous DRBD reorganization
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

Some more mostly trivial "alignment patches" to (slowly but surely)
move further in the direction of re-upstreaming DRBD.

These should be fairly uncontroversial.

Andreas Gruenbacher (1):
  drbd: drbd_insert_interval(): Clarify comment

Christoph Böhmwalder (5):
  drbd: adjust drbd_limits license header
  drbd: make limits unsigned
  drbd: remove unnecessary assignment in vli_encode_bits
  drbd: remove macros using require_context
  MAINTAINERS: add drbd headers

Lars Ellenberg (1):
  drbd: interval tree: make removing an "empty" interval a no-op

Robert Altnoeder (1):
  drbd: fix DRBD_VOLUME_MAX 65535 -> 65534

 MAINTAINERS                        |   1 +
 drivers/block/drbd/drbd_int.h      |  12 +-
 drivers/block/drbd/drbd_interval.c |   6 +-
 drivers/block/drbd/drbd_vli.h      |   2 +-
 include/linux/drbd_limits.h        | 204 ++++++++++++++---------------
 5 files changed, 110 insertions(+), 115 deletions(-)


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

