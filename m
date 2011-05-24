Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 24 May 2011 10:50:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201105241050.24719.philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] DRBD bits for 2.6.40
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The following changes since commit 779d530632c98967820d3bbcae15d492fc20301e:

  Merge branches 'for-jens/xen-backend-fixes' and 'for-jens/xen-blkback-v3.3' 
of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen into 
for-2.6.40/drivers (2011-05-19 09:46:00 +0200)

are available in the git repository at:

  git://git.drbd.org/linux-2.6-drbd.git for-jens

DRBD's changelog:
8.3.11 (api:88/proto:86-96)
--------
 * Fixed handling of read errors during online verify runs
 * Fixes for possible distributed deadlocks during online verify and
   checksum based resync processes
 * Fixed handling of IO errors with an on-io-error=pass-on policy; the
   disk state goes to inconsistent
 * Fixed the behavior in case ping-timeout and ping-int are set to the
   same value
 * Fix for connecting on high latency network links
 * Fixed state transitions if fence-peer handler returns after connection was
   established again
 * Made die max_bio_size negotiation conservative instead of optimistic
 * Network timeouts for mirrored write requests are now always enforced,
   no longer only when the socket is congested



Andrew Morton (1):
      drbd: fix warning

Bart Van Assche (1):
      drbd: Fix spelling

Lars Ellenberg (5):
      lru_cache.h: fix comments referring to ts_ instead of lc_
      drbd: fix potential distributed deadlock
      drbd: fix disconnect/reconnect loop, if ping-timeout == ping-int
      drbd: fix potential activity log refcount imbalance in error path
      drbd: fix schedule in atomic

Philipp Reisner (7):
      drbd: Fix for application IO with the on-io-error=pass-on policy
      drbd: Only downgrade the disk state in case of disk failures
      drbd: Fix for the connection problems on high latency links
      drbd: Disallow the peer_disk_state to be D_OUTDATED while connected
      drbd: Fixed state transitions after async outdate-peer-handler returned
      drbd: Take a more conservative approach when deciding max_bio_size
      drbd: fix warning

 drivers/block/drbd/drbd_actlog.c   |    2 +-
 drivers/block/drbd/drbd_bitmap.c   |    6 +-
 drivers/block/drbd/drbd_int.h      |   19 ++++--
 drivers/block/drbd/drbd_main.c     |   37 +++++++++--
 drivers/block/drbd/drbd_nl.c       |  127 ++++++++++++++++++++++++++---------
 drivers/block/drbd/drbd_receiver.c |   68 ++++++++------------
 drivers/block/drbd/drbd_req.c      |   20 +++---
 drivers/block/drbd/drbd_req.h      |    5 +-
 drivers/block/drbd/drbd_worker.c   |   98 +++++++++++++++++-----------
 include/linux/drbd.h               |   10 ++--
 include/linux/drbd_tag_magic.h     |    2 +-
 include/linux/lru_cache.h          |   12 ++--
 12 files changed, 255 insertions(+), 151 deletions(-)
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
