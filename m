Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9C66D1056444
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:40 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:09 +0200
Message-Id: <1465856799-2151-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/30] DRBD updates
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

[...]
> If you want me to add it to that branch (which is where it should go),
> then why aren't the patches against that branch? I get rejects on
> several of the patches, mainly because they are not done on top of this
> particular branch.
>
> We can do two things here. I can skip patches, I don't like doing that.
> Or you can respin against the proper branch, as it should have been from
> the beginning. What do you want to do?

Sorry. It was based on Linus' 4.7-rc3. Shame on me. I rebased it onto your
for-4.8/drivers.

cheers,
 Phil

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
 drivers/block/drbd/drbd_nl.c       | 282 ++++++++++++++-----
 drivers/block/drbd/drbd_proc.c     |  30 +--
 drivers/block/drbd/drbd_protocol.h |  77 +++++-
 drivers/block/drbd/drbd_receiver.c | 535 ++++++++++++++++++++++++++++++-------
 drivers/block/drbd/drbd_req.c      |  84 ++++--
 drivers/block/drbd/drbd_req.h      |   5 +-
 drivers/block/drbd/drbd_state.c    |  61 ++++-
 drivers/block/drbd/drbd_state.h    |   2 +-
 drivers/block/drbd/drbd_strings.c  |   8 +-
 drivers/block/drbd/drbd_worker.c   |  85 +++++-
 include/linux/drbd.h               |  10 +-
 include/linux/drbd_genl.h          |   7 +-
 include/linux/drbd_limits.h        |  15 +-
 19 files changed, 1206 insertions(+), 299 deletions(-)

-- 
2.7.4

