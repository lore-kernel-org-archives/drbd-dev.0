Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5F5074210DE
	for <drbd-dev@lists.linbit.com>; Thu,  1 Dec 2022 12:04:27 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id gu23so3282319ejb.10
	for <drbd-dev@lists.linbit.com>; Thu, 01 Dec 2022 03:04:27 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Dec 2022 12:03:45 +0100
Message-Id: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/5] Backported DRBD printk/debug improvements
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

Some changes to DRBD's logging infrastructure, backported from the
out-of-tree module.

Since the two code bases have diverged so much, it is tough to preserve
authorship information without "putting words into someone's mouth". So
I ended up using Originally-from tags to try and encode the original
authors of these patches.

Christoph Böhmwalder (5):
  drbd: unify how failed assertions are logged
  drbd: split polymorph printk to its own file
  drbd: introduce dynamic debug
  drbd: introduce drbd_ratelimit()
  drbd: add context parameter to expect() macro

 drivers/block/drbd/drbd_actlog.c           |   6 +-
 drivers/block/drbd/drbd_bitmap.c           |  60 ++++-----
 drivers/block/drbd/drbd_int.h              |  68 +---------
 drivers/block/drbd/drbd_main.c             |  10 +-
 drivers/block/drbd/drbd_nl.c               |   2 +-
 drivers/block/drbd/drbd_polymorph_printk.h | 141 +++++++++++++++++++++
 drivers/block/drbd/drbd_receiver.c         |  16 +--
 drivers/block/drbd/drbd_req.c              |   6 +-
 drivers/block/drbd/drbd_worker.c           |  12 +-
 9 files changed, 199 insertions(+), 122 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h


base-commit: b4c0482bfe89cd6c4f030314c86aae35642c44a5
-- 
2.38.1

