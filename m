Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 95F78420FCC
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:05:04 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id p15so6216955ejc.7
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:05:04 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:04:42 +0200
Message-Id: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/3] DRBD fixes for Linux 5.18
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

Assortment of more relevant fixes for DRBD to go into 5.18.

Christoph Böhmwalder (1):
  drbd: set QUEUE_FLAG_STABLE_WRITES

Lv Yunlong (1):
  drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
  drbd: fix an invalid memory access caused by incorrect use of list
    iterator

 drivers/block/drbd/drbd_int.h          |  8 ++---
 drivers/block/drbd/drbd_main.c         |  7 ++---
 drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
 drivers/block/drbd/drbd_state.c        | 18 +++++------
 drivers/block/drbd/drbd_state_change.h |  8 ++---
 5 files changed, 45 insertions(+), 37 deletions(-)

-- 
2.35.1

