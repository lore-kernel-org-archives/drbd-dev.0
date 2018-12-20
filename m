Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:27 +0100
Message-Id: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/17] DRBD updates for 4.21
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


Hi Jens,

I hope this is not too late for your for-4.21 branch.

These are all from last April or even older,
I was convinced we sent these for 4.19 already.
But we didn't :-(

The interesting new feature is "introduce P_ZEROES", which is replacing
45c21793a660 drbd: implement REQ_OP_WRITE_ZEROES
because that led to "full allocation" for fstrim on dm-thin or similar,
which is certainly not the intended behavior.

Patch 3 to 8 help with recovery from odd corner cases in
multiple error scenarios in a cluster, potentially after some admin
already "tried things".

All others are sufficiently simple and supposedly "obvious".

Lars Ellenberg (13):
  drbd: must not use connection after kref_put(&connection->kref)
  drbd: centralize printk reporting of new size into drbd_set_my_capacity()
  drbd: ignore "all zero" peer volume sizes in handshake
  drbd: disconnect, if the wrong UUIDs are attached on a connected peer
  drbd: fix confusing error message during attach
  drbd: attach on connected diskless peer must not shrink a consistent device
  drbd: reject attach of unsuitable uuids even if connected
  drbd: fix comment typos
  drbd: do not block when adjusting "disk-options" while IO is frozen
  drbd: avoid spurious self-outdating with concurrent disconnect / down
  drbd: don't retry connection if peers do not agree on "authentication" settings
  drbd: skip spurious timeout (ping-timeo) when failing promote
  drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")

Luc Van Oostenryck (1):
  drbd: fix print_st_err()'s prototype to match the definition

Nathan Chancellor (2):
  drbd: Avoid Clang warning about pointless switch statment
  drbd: Change drbd_request_detach_interruptible's return type to int

Roland Kammerer (1):
  drbd: narrow rcu_read_lock in drbd_sync_handshake

 drivers/block/drbd/drbd_debugfs.c  |   2 +
 drivers/block/drbd/drbd_int.h      |  19 +--
 drivers/block/drbd/drbd_main.c     |  28 +++-
 drivers/block/drbd/drbd_nl.c       | 133 ++++++++++++---
 drivers/block/drbd/drbd_protocol.h |  47 ++++++
 drivers/block/drbd/drbd_receiver.c | 251 +++++++++++++++++++++++++----
 drivers/block/drbd/drbd_req.c      |  19 +--
 drivers/block/drbd/drbd_req.h      |   2 +
 drivers/block/drbd/drbd_state.c    |  11 +-
 drivers/block/drbd/drbd_state.h    |   5 +-
 drivers/block/drbd/drbd_worker.c   |   2 +-
 include/linux/drbd.h               |   2 +-
 include/linux/genl_magic_struct.h  |   5 +-
 13 files changed, 434 insertions(+), 92 deletions(-)

-- 
2.17.1

