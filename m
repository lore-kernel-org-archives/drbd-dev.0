Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5CDD7426837
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:38:58 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
	ffacd0b85a97d-3248e90f032so172329f8f.1
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:38:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:47 +0200
Message-ID: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/5] drbd: rename worker to sender
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

Some more refactoring commits from out-of-tree drbd.
Intended for 6.7.

Christoph Böhmwalder (5):
  drbd: Rename per-connection "worker" thread to "sender"
  drbd: Add new per-resource "worker" thread
  drbd: Move connection independent work from "sender" to "worker"
  drbd: Keep connection threads running while connection is up only
  drbd: Get rid of conn_reconfig_start() and conn_reconfig_done()

 drivers/block/drbd/Makefile                   |  2 +-
 drivers/block/drbd/drbd_int.h                 | 12 ++--
 drivers/block/drbd/drbd_main.c                | 21 +++---
 drivers/block/drbd/drbd_nl.c                  | 48 +++-----------
 drivers/block/drbd/drbd_receiver.c            |  2 +-
 drivers/block/drbd/drbd_req.c                 |  7 +-
 .../drbd/{drbd_worker.c => drbd_sender.c}     | 64 ++++++++++++++++---
 drivers/block/drbd/drbd_state.c               | 31 ++-------
 drivers/block/drbd/drbd_state.h               |  1 -
 9 files changed, 95 insertions(+), 93 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (97%)


base-commit: aa511ff8218b3fb328181fbaac48aa5e9c5c6d93
-- 
2.41.0

