Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Jul 2013 11:41:10 +0200
Message-Id: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/5] RFC: DRBD Fixes
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

These are five independend fixes. Please see the commit messages
for descriptions.

The series is based on v3.11-rc3, and intended for the 3.12 merge
window.

I will post a second series targeted at the 3.12 merge window
in the next days. It will contain only renames (no functional changes)


Lars Ellenberg (3):
  drbd: fix NULL pointer deref in module init error path
  drbd: fix decoding of bitmap vli rle for device sizes > 64 TB
  drbd: avoid to shrink max_bio_size due to peer re-configuration

Philipp Reisner (2):
  drbd: Fix an connection drop issue after enabling allow-two-primaries
  drbd: Fix adding of new minors with freshly created meta data

 drivers/block/drbd/drbd_int.h      |    3 ++-
 drivers/block/drbd/drbd_main.c     |   19 ++++++++-------
 drivers/block/drbd/drbd_nl.c       |    6 ++---
 drivers/block/drbd/drbd_receiver.c |   45 +++++++++++++++++-------------------
 drivers/block/drbd/drbd_req.c      |    3 +++
 5 files changed, 38 insertions(+), 38 deletions(-)

-- 
1.7.9.5

