Return-Path: <ethantidmore06@gmail.com>
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
	[209.85.128.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9B0C91622B5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 00:23:21 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
	00721157ae682-79a610a32a6so19393667b3.0
	for <drbd-dev@lists.linbit.com>; Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/4] drbd: A few bug fixes
Date: Tue, 17 Mar 2026 18:23:14 -0500
Message-ID: <20260317232318.18923-1-ethantidmore06@gmail.com>
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

Here are 4 bug fixes found with Smatch.

Ethan Tidmore (4):
  drbd: Fix out-of-bounds access
  drbd: Fix variable dereference before check
  drbd: Add missing error code in drbd_main.c
  drbd: Add check for error pointer

 drivers/block/drbd/drbd_main.c     | 1 +
 drivers/block/drbd/drbd_nl.c       | 2 +-
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 4 +++-
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.53.0

