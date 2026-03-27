Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AA76116084B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2026 23:38:46 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
	5b1f17b1804b1-4852b81c73aso23389425e9.3
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2026 15:38:46 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 00/20] DRBD 9 rework
Date: Fri, 27 Mar 2026 23:38:00 +0100
Message-ID: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

As discussed (context: [0]), here is the first version of our DRBD 9
rework series, intended for for-next via for-7.1/drbd.

This replays about 10-15 years of active out-of-tree development work
[1], depending on your way of counting. The out-of-tree module has
severely diverged from the in-tree version over the years, which is
what we are aiming to fix now.

Hopefully that somewhat excuses (or at least explains) the massive
diffs -- we've tried to come up with a way to group the changes by
topic, but I realize it's still not exactly trivial to review.

We've been polishing this series for a while now, and we have taken
great care to make it as "upstream-presentable" as possible. That said,
there are still probably imperfections. It's a start -- feedback welcome!

The main blocker that still remains is that this technically breaks
userspace: some ancient versions of the DRBD userspace utilities will
not be able to talk to this version of the driver (v8 and v9 genetlink
families are completely incompatible).
We will fix that by introducing a completely new genetlink family (think
"drbd2") that follows all modern conventions. Then we can register both
families, going through a compat layer for the old family.

A prerequisite for that is converting the genl_magic macro
infrastructure we use now to YNL. That is already in the pipeline, we
expect to have it ready by the 7.2 merge window.

The plan is to submit one new version of this series for every merge
window, which should end up in linux-next. Within a few kernel
releases, we will hopefully be close enough to get this over the line
and submitted for real.

Thanks,
Christoph

[0] https://lore.kernel.org/linux-next/899e0337-9642-4ca6-9050-aeab14fa22ef@kernel.dk/
[1] https://github.com/LINBIT/drbd

Christoph Böhmwalder (20):
  drbd: mark as BROKEN during DRBD 9 rework
  drbd: extend wire protocol definitions for DRBD 9
  drbd: introduce DRBD 9 on-disk metadata format
  drbd: add transport layer abstraction
  drbd: add TCP transport implementation
  drbd: add RDMA transport implementation
  drbd: add load-balancing TCP transport
  drbd: add DAX/PMEM support for metadata access
  drbd: add optional compatibility layer for DRBD 8.4
  drbd: rename drbd_worker.c to drbd_sender.c
  drbd: rework sender for DRBD 9 multi-peer
  drbd: replace per-device state model with multi-peer data structures
  drbd: rewrite state machine for DRBD 9 multi-peer clusters
  drbd: rework activity log and bitmap for multi-peer replication
  drbd: rework request processing for DRBD 9 multi-peer IO
  drbd: rework module core for DRBD 9 transport and multi-peer
  drbd: rework receiver for DRBD 9 transport and multi-peer protocol
  drbd: rework netlink management interface for DRBD 9
  drbd: update monitoring interfaces for multi-peer topology
  drbd: remove BROKEN for DRBD

 drivers/block/drbd/Kconfig                    |    58 +
 drivers/block/drbd/Makefile                   |     9 +-
 drivers/block/drbd/drbd_actlog.c              |  1122 +-
 drivers/block/drbd/drbd_bitmap.c              |  1824 +--
 drivers/block/drbd/drbd_buildtag.c            |     2 +-
 drivers/block/drbd/drbd_config.h              |    38 +
 drivers/block/drbd/drbd_dax_pmem.c            |   158 +
 drivers/block/drbd/drbd_dax_pmem.h            |    40 +
 drivers/block/drbd/drbd_debugfs.c             |  1657 ++-
 drivers/block/drbd/drbd_debugfs.h             |     2 +
 .../block/drbd}/drbd_genl_api.h               |    19 +-
 drivers/block/drbd/drbd_int.h                 |  3278 +++--
 drivers/block/drbd/drbd_interval.c            |    35 +-
 drivers/block/drbd/drbd_interval.h            |   156 +-
 drivers/block/drbd/drbd_legacy_84.c           |   564 +
 drivers/block/drbd/drbd_legacy_84.h           |    27 +
 drivers/block/drbd/drbd_main.c                |  6008 +++++---
 drivers/block/drbd/drbd_meta_data.h           |   126 +
 drivers/block/drbd/drbd_nl.c                  |  7248 ++++++---
 drivers/block/drbd/drbd_nla.c                 |     2 +-
 drivers/block/drbd/drbd_nla.h                 |     7 +-
 drivers/block/drbd/drbd_polymorph_printk.h    |   265 +-
 drivers/block/drbd/drbd_proc.c                |   320 +-
 drivers/block/drbd/drbd_protocol.h            |   519 +-
 drivers/block/drbd/drbd_receiver.c            | 12258 +++++++++++-----
 drivers/block/drbd/drbd_req.c                 |  2990 ++--
 drivers/block/drbd/drbd_req.h                 |   303 +-
 drivers/block/drbd/drbd_sender.c              |  3871 +++++
 drivers/block/drbd/drbd_state.c               |  7724 +++++++---
 drivers/block/drbd/drbd_state.h               |   298 +-
 drivers/block/drbd/drbd_state_change.h        |    66 +-
 drivers/block/drbd/drbd_strings.c             |   219 +-
 drivers/block/drbd/drbd_strings.h             |    25 +-
 drivers/block/drbd/drbd_transport.c           |   403 +
 drivers/block/drbd/drbd_transport.h           |   340 +
 drivers/block/drbd/drbd_transport_lb-tcp.c    |  1905 +++
 drivers/block/drbd/drbd_transport_rdma.c      |  3496 +++++
 drivers/block/drbd/drbd_transport_tcp.c       |  1670 +++
 drivers/block/drbd/drbd_transport_template.c  |   160 +
 drivers/block/drbd/drbd_worker.c              |  2223 ---
 include/linux/drbd.h                          |   190 +-
 include/linux/drbd_config.h                   |    16 -
 include/linux/drbd_genl.h                     |   352 +-
 include/linux/drbd_limits.h                   |   112 +-
 include/linux/genl_magic_func.h               |    50 +-
 45 files changed, 45891 insertions(+), 16264 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_config.h
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h
 rename {include/linux => drivers/block/drbd}/drbd_genl_api.h (68%)
 create mode 100644 drivers/block/drbd/drbd_legacy_84.c
 create mode 100644 drivers/block/drbd/drbd_legacy_84.h
 create mode 100644 drivers/block/drbd/drbd_meta_data.h
 create mode 100644 drivers/block/drbd/drbd_sender.c
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_lb-tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_rdma.c
 create mode 100644 drivers/block/drbd/drbd_transport_tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_template.c
 delete mode 100644 drivers/block/drbd/drbd_worker.c
 delete mode 100644 include/linux/drbd_config.h


base-commit: 67807fbaf12719fca46a622d759484652b79c7c3
-- 
2.53.0

