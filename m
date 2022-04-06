Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
	[209.85.218.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 727384205EF
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:30 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id ot30so6169347ejb.12
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:30 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:08 +0200
Message-Id: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/7] DRBD updates for 5.19
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

Mostly cosmetic changes, bound for 5.19.

Arnd Bergmann (2):
  drbd: fix duplicate array initializer
  drbd: address enum mismatch warnings

Cai Huoqing (2):
  drbd: Make use of PFN_UP helper macro
  drbd: Replace "unsigned" with "unsigned int"

Haowen Bai (1):
  drbd: Return true/false (not 1/0) from bool functions

Jiapeng Chong (1):
  block: drbd: drbd_receiver: Remove redundant assignment to err

Uladzislau Rezki (Sony) (1):
  drdb: Switch to kvfree_rcu() API

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_main.c     | 11 +++++-----
 drivers/block/drbd/drbd_nl.c       | 33 +++++++++++++++---------------
 drivers/block/drbd/drbd_receiver.c | 15 ++++++--------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    |  3 +--
 drivers/block/drbd/drbd_worker.c   |  2 +-
 7 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.35.1

