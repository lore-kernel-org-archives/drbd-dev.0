Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
	[209.85.218.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2093F420FB2
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 10:06:58 +0200 (CEST)
Received: by mail-ej1-f43.google.com with SMTP id qh7so2526759ejb.11
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 01:06:58 -0700 (PDT)
Message-ID: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
Date: Wed, 6 Apr 2022 10:06:56 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] DRBD fixes for Linux 5.18
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

Hi Jens,

this is the first batch of DRBD updates, catching up from the last few years.
These fixes are a bit more substantial, so it would be great if they could still
go into 5.18.

Please pull.


The following changes since commit ff0f3f83175274daf2eb4fd4db6430ab71c66e80:

  Merge branch 'for-5.19/io_uring-xattr' into for-next (2022-04-04 17:59:51 -0600)

are available in the Git repository at:

  https://github.com/LINBIT/linux-drbd.git tags/drbd-fixes-5.18-2022-04-06

for you to fetch changes up to 0ab5e2117763190f684fdedb6f171abd4b939f1b:

  drbd: set QUEUE_FLAG_STABLE_WRITES (2022-04-06 09:16:13 +0200)

----------------------------------------------------------------
DRBD fixes for Linux 5.18

- enable stable writes for DRBD (Christoph Böhmwalder)
- fix a potential invalid memory access (Xiaomeng Tong)
- fix a use-after-free bug (Lv Yunlong)

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: set QUEUE_FLAG_STABLE_WRITES

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
      drbd: fix an invalid memory access caused by incorrect use of list iterator

 drivers/block/drbd/drbd_int.h          |  8 ++++----
 drivers/block/drbd/drbd_main.c         |  7 +++----
 drivers/block/drbd/drbd_nl.c           | 41 +++++++++++++++++++++++++----------------
 drivers/block/drbd/drbd_state.c        | 18 +++++++++---------
 drivers/block/drbd/drbd_state_change.h |  8 ++++----
 5 files changed, 45 insertions(+), 37 deletions(-)
