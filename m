Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
	[209.85.218.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C77DC420FB2
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 10:07:16 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id bh17so2561334ejb.8
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 01:07:16 -0700 (PDT)
Message-ID: <bca64395-2c73-25f9-dbca-76479ef5d280@linbit.com>
Date: Wed, 6 Apr 2022 10:07:14 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] DRBD updates for Linux 5.19
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

these updates are mostly cosmetic; also stuff we missed over the years.

Please pull for 5.19.


The following changes since commit ff0f3f83175274daf2eb4fd4db6430ab71c66e80:

  Merge branch 'for-5.19/io_uring-xattr' into for-next (2022-04-04 17:59:51 -0600)

are available in the Git repository at:

  https://github.com/LINBIT/linux-drbd.git tags/drbd-5.19-2022-04-06

for you to fetch changes up to 7e4d200ceb13f404ab4f9332c81abb2c260eeff9:

  drbd: Return true/false (not 1/0) from bool functions (2022-04-06 09:06:27 +0200)

----------------------------------------------------------------
Miscellaneous DRBD updates for Linux 5.19

- return true/false instead of 1/0 from bool functions (Haowen Bai)
- use kvfree_rcu instead of synchronize_rcu() followed by kvfree()
  (Haowen Bai)
- prefer "unsigned int" over "unsigned" (Cai Huoqing)
- use the PFN_UP helper macro (Cai Huoqing)
- remove a redundant assignment (Jiapeng Chong)
- fix type mismatches for netlink return codes (Arnd Bergmann)
- fix array initializers for cmdnames (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (2):
      drbd: fix duplicate array initializer
      drbd: address enum mismatch warnings

Cai Huoqing (2):
      drbd: Make use of PFN_UP helper macro
      drbd: Replace "unsigned" with "unsigned int"

Haowen Bai (1):
      drbd: Return true/false (not 1/0) from bool functions

Jiapeng Chong (1):
      block: drbd: drbd_receiver: Remove redundant assignment to err

Uladzislau Rezki (Sony) (1):
      drdb: Switch to kvfree_rcu() API

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_main.c     | 11 ++++++-----
 drivers/block/drbd/drbd_nl.c       | 33 ++++++++++++++++-----------------
 drivers/block/drbd/drbd_receiver.c | 15 ++++++---------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    |  3 +--
 drivers/block/drbd/drbd_worker.c   |  2 +-
 7 files changed, 32 insertions(+), 36 deletions(-)
