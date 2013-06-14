Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Jun 2013 20:54:17 +0200
Message-Id: <1371236063-17198-1-git-send-email-philipp.reisner@linbit.com>
Cc: Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/6] RFC: DRBD fixes and one functional enhancemet
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

The first 4 patches are obvious fixes. The last patch adds
the capability to change the activity log layout online.
(al-stripes and al-stripe-size)

Andreas Gruenbacher (2):
  drbd: Do not sleep inside rcu
  drbd: Fix rcu_read_lock balance on error path

Philipp Reisner (3):
  drbd: Ignore the exit code of a fence-peer handler if it returns too late
  drbd: Constants should be UPPERCASE
  drbd: Allow online change of al-stripes and al-stripe-size

Wei Yongjun (1):
  drbd: fix error return code in drbd_init()

 drivers/block/drbd/drbd_actlog.c   |   21 ++++
 drivers/block/drbd/drbd_int.h      |   15 ++-
 drivers/block/drbd/drbd_main.c     |   61 ++++++------
 drivers/block/drbd/drbd_nl.c       |  185 ++++++++++++++++++++++++++++--------
 drivers/block/drbd/drbd_receiver.c |   12 +--
 drivers/block/drbd/drbd_state.c    |    4 +-
 include/linux/drbd.h               |    6 +-
 include/linux/drbd_genl.h          |    2 +
 include/linux/drbd_limits.h        |    9 ++
 9 files changed, 236 insertions(+), 79 deletions(-)

-- 
1.7.9.5

