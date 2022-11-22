Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C61184252B7
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 14:43:09 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id cl5so24783481wrb.9
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 05:43:09 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Nov 2022 14:42:57 +0100
Message-Id: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/4] lru_cache improvements,
	DRBD license identifiers
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

Here are some improvements to the lru_cache; mostly just cleanups that
we missed to send upstream over the years.

The last patch makes the SPDX license headers in DRBD consistent so
that they all represent GPL 2.0.

Christoph Böhmwalder (2):
  lru_cache: remove compiled out code
  drbd: use consistent license

Joel Colledge (1):
  lru_cache: remove unused lc_private, lc_set, lc_index_of

Lars Ellenberg (1):
  lru_cache: use atomic operations when accessing lc->flags, always

 drivers/block/drbd/Kconfig             |  2 +-
 drivers/block/drbd/Makefile            |  2 +-
 drivers/block/drbd/drbd_actlog.c       |  2 +-
 drivers/block/drbd/drbd_bitmap.c       |  2 +-
 drivers/block/drbd/drbd_debugfs.c      |  2 +-
 drivers/block/drbd/drbd_debugfs.h      |  2 +-
 drivers/block/drbd/drbd_int.h          |  2 +-
 drivers/block/drbd/drbd_interval.c     |  2 +-
 drivers/block/drbd/drbd_interval.h     |  2 +-
 drivers/block/drbd/drbd_main.c         |  2 +-
 drivers/block/drbd/drbd_nl.c           |  2 +-
 drivers/block/drbd/drbd_nla.c          |  2 +-
 drivers/block/drbd/drbd_nla.h          |  2 +-
 drivers/block/drbd/drbd_proc.c         |  2 +-
 drivers/block/drbd/drbd_protocol.h     |  2 +-
 drivers/block/drbd/drbd_receiver.c     |  2 +-
 drivers/block/drbd/drbd_req.c          |  2 +-
 drivers/block/drbd/drbd_req.h          |  2 +-
 drivers/block/drbd/drbd_state.c        |  2 +-
 drivers/block/drbd/drbd_state.h        |  2 +-
 drivers/block/drbd/drbd_state_change.h |  2 +-
 drivers/block/drbd/drbd_strings.c      |  2 +-
 drivers/block/drbd/drbd_strings.h      |  2 +-
 drivers/block/drbd/drbd_vli.h          |  2 +-
 drivers/block/drbd/drbd_worker.c       |  2 +-
 include/linux/lru_cache.h              |  3 --
 lib/lru_cache.c                        | 59 +-------------------------
 27 files changed, 27 insertions(+), 85 deletions(-)

-- 
2.38.1

