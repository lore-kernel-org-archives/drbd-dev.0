Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6F5014203AB
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 13:35:19 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id hw16so40155696ejc.10
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 04:35:19 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2023 13:35:03 +0100
Message-Id: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RESEND PATCH 0/3] DRBD file structure reorganization
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

To make our lives easier when sending future, more complex patches,
we want to align the file structure as best as possible with what we
have in the out-of-tree module.

Christoph Böhmwalder (3):
  drbd: split off drbd_buildtag into separate file
  drbd: drop API_VERSION define
  drbd: split off drbd_config into separate file

 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 drivers/block/drbd/drbd_main.c     | 20 +-------------------
 drivers/block/drbd/drbd_proc.c     |  2 +-
 include/linux/drbd.h               |  7 -------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 include/linux/drbd_genl_api.h      |  2 +-
 9 files changed, 44 insertions(+), 30 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c
 create mode 100644 include/linux/drbd_config.h


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

