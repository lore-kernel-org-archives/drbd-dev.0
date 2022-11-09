Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AAA842178D
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2022 14:35:05 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id kt23so46630968ejc.7
	for <drbd-dev@lists.linbit.com>; Wed, 09 Nov 2022 05:35:05 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  9 Nov 2022 14:34:50 +0100
Message-Id: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/3] Miscellaneous DRBD updates for 6.2
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

Here are some various updates for DRBD.
The first two are related to the handling of discards in DRBD, and the
third is a resend of [0].

[0] https://lore.kernel.org/all/20221024142424.25877-1-christoph.boehmwalder@linbit.com/

Christoph Böhmwalder (2):
  drbd: use blk_queue_max_discard_sectors helper
  drbd: Store op in drbd_peer_request

Philipp Reisner (1):
  drbd: disable discard support if granularity > max

 drivers/block/drbd/drbd_int.h      |  8 ++-
 drivers/block/drbd/drbd_nl.c       | 23 +++++++--
 drivers/block/drbd/drbd_receiver.c | 81 +++++++++++++++++-------------
 drivers/block/drbd/drbd_worker.c   |  4 +-
 4 files changed, 71 insertions(+), 45 deletions(-)

-- 
2.38.1

