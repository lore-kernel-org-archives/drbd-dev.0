Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B4CD42035F
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2024 15:04:14 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
	4fb4d7f45d1cf-564fd9eea75so2643229a12.3
	for <drbd-dev@lists.linbit.com>; Wed, 06 Mar 2024 06:04:14 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/7] drbd atomic queue limits conversion
Date: Wed,  6 Mar 2024 15:03:25 +0100
Message-Id: <20240306140332.623759-1-philipp.reisner@linbit.com>
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

Hello Jens,

Here, with the Reviewed-by and Tested-by trailers.

Christoph Hellwig (7):
  drbd: pass the max_hw_sectors limit to blk_alloc_disk
  drbd: refactor drbd_reconsider_queue_parameters
  drbd: refactor the backing dev max_segments calculation
  drbd: merge drbd_setup_queue_param into
    drbd_reconsider_queue_parameters
  drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
  drbd: split out a drbd_discard_supported helper
  drbd: atomically update queue limits in
    drbd_reconsider_queue_parameters

 drivers/block/drbd/drbd_main.c |  13 +-
 drivers/block/drbd/drbd_nl.c   | 210 ++++++++++++++++-----------------
 2 files changed, 110 insertions(+), 113 deletions(-)

-- 
2.40.1

