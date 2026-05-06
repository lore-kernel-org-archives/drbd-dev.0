Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D94A1622C5
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2026 14:45:47 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
	5b1f17b1804b1-488b150559bso44180275e9.1
	for <drbd-dev@lists.linbit.com>; Wed, 06 May 2026 05:45:47 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Date: Wed,  6 May 2026 14:45:39 +0200
Message-ID: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

DRBD's genetlink interface was defined using a custom multi-include
macro system, genl_magic_{func,struct}.h. This system generated struct
definitions, netlink policies, serialization functions and more
from a single "magic" header.
It never really caught on; DRBD is its only user, its internal macro
jungle is next to impossible to understand, and even harder to debug.

This series replaces it with the standard solution, YNL.
The *_gen.[ch] files were created with a modified YNL generator, but
these modifications are not shipped because the current DRBD family is
effectively frozen.

Note: this family primarily aims for compatibility with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Changes from v2:
- Fix compile error

Changes from v1:
- Remove YNL generator patches, ship just the generated code

Christoph Böhmwalder (2):
  drbd: move UAPI headers to include/uapi/linux/
  drbd: replace genl_magic with explicit netlink serialization

 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2606 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  395 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  359 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 17 files changed, 3653 insertions(+), 1466 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (86%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (99%)


base-commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31
-- 
2.53.0

