Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 816841622C4
	for <drbd-dev@lists.linbit.com>; Tue,  7 Apr 2026 19:34:10 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
	5b1f17b1804b1-4852a9c6309so49324795e9.0
	for <drbd-dev@lists.linbit.com>; Tue, 07 Apr 2026 10:34:10 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/4] drbd: switch from genl_magic to YNL
Date: Tue,  7 Apr 2026 19:33:52 +0200
Message-ID: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
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

First, shuffle some headers around because the YNL generator expects
to generate UAPI headers.
Then, add some optional extensions to the YNL generator to support a
minimal set of old genl_magic features required for backward
compatibility.
Then create a "genetlink-legacy" based spec for DRBD and switch to it.

Note: this family primarily aims for compatiblity with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Christoph Böhmwalder (4):
  drbd: move UAPI headers to include/uapi/linux/
  tools: ynl-gen-c: optionally emit structs and helpers
  drbd: add YNL genetlink specification
  drbd: switch from genl_magic macros to YNL-generated code

 Documentation/netlink/genetlink-legacy.yaml   |   23 +
 Documentation/netlink/specs/drbd.yaml         | 1109 +++++++
 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2610 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  399 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  363 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  293 +-
 20 files changed, 5087 insertions(+), 1469 deletions(-)
 create mode 100644 Documentation/netlink/specs/drbd.yaml
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

