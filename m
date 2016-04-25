Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8CE081011BA2
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:21 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:27 +0200
Message-Id: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/30] DBRD updates
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

apart from the usual maintenance and bug fixes this time comes
support for WRITE_SAME and lots of improvemnts for DISCARD.

Overview:
As replication technology we want to use DISCARDs only if they
really zero the backing storage. Thin LVM does it but claims
not to do it. To make that reasonably usable with DRBD we
added this "discard_zeroes_if_aligned" hack^H^H^H^H configure
option. Please see the commit messages for all the details.

Please add it to your for-4.7/drivers branch.
Thanks!


Fabian Frederick (1):
  drbd: code cleanups without semantic changes

Lars Ellenberg (24):
  drbd: bitmap bulk IO: do not always suspend IO
  drbd: change bitmap write-out when leaving resync states
  drbd: adjust assert in w_bitmap_io to account for
    BM_LOCKED_CHANGE_ALLOWED
  drbd: fix regression: protocol A sometimes synchronous, C sometimes
    double-latency
  drbd: fix for truncated minor number in callback command line
  drbd: allow parallel flushes for multi-volume resources
  drbd: when receiving P_TRIM, zero-out partial unaligned chunks
  drbd: possibly disable discard support, if backend has
    discard_zeroes_data=0
  drbd: zero-out partial unaligned discards on local backend
  drbd: allow larger max_discard_sectors
  drbd: finish resync on sync source only by notification from sync
    target
  drbd: introduce unfence-peer handler
  drbd: don't forget error completion when "unsuspending" IO
  drbd: if there is no good data accessible, writes should be IO errors
  drbd: only restart frozen disk io when D_UP_TO_DATE
  drbd: discard_zeroes_if_aligned allows "thin" resync for
    discard_zeroes_data=0
  drbd: report sizes if rejecting too small peer disk
  drbd: introduce WRITE_SAME support
  drbd: sync_handshake: handle identical uuids with current (frozen)
    Primary
  drbd: disallow promotion during resync handshake, avoid deadlock and
    hard reset
  drbd: bump current uuid when resuming IO with diskless peer
  drbd: finally report ms, not jiffies, in log message
  drbd: al_write_transaction: skip re-scanning of bitmap page pointer
    array
  drbd: correctly handle failed crypto_alloc_hash

Philipp Reisner (4):
  drbd: Kill code duplication
  drbd: Implement handling of thinly provisioned storage on resync
    target nodes
  drbd: Introduce new disk config option rs-discard-granularity
  drbd: Create the protocol feature THIN_RESYNC

Roland Kammerer (1):
  drbd: get rid of empty statement in is_valid_state

 drivers/block/drbd/drbd_actlog.c   |  29 +-
 drivers/block/drbd/drbd_bitmap.c   |  84 ++++--
 drivers/block/drbd/drbd_debugfs.c  |  13 +-
 drivers/block/drbd/drbd_int.h      |  49 +++-
 drivers/block/drbd/drbd_interval.h |  14 +-
 drivers/block/drbd/drbd_main.c     | 115 +++++++-
 drivers/block/drbd/drbd_nl.c       | 282 +++++++++++++++-----
 drivers/block/drbd/drbd_proc.c     |  30 +--
 drivers/block/drbd/drbd_protocol.h |  77 +++++-
 drivers/block/drbd/drbd_receiver.c | 534 ++++++++++++++++++++++++++++++-------
 drivers/block/drbd/drbd_req.c      |  84 ++++--
 drivers/block/drbd/drbd_req.h      |   5 +-
 drivers/block/drbd/drbd_state.c    |  61 ++++-
 drivers/block/drbd/drbd_state.h    |   2 +-
 drivers/block/drbd/drbd_strings.c  |   8 +-
 drivers/block/drbd/drbd_worker.c   |  85 +++++-
 include/linux/drbd.h               |  10 +-
 include/linux/drbd_genl.h          |   7 +-
 include/linux/drbd_limits.h        |  15 +-
 19 files changed, 1205 insertions(+), 299 deletions(-)

-- 
1.9.1

