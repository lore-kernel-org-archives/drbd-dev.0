Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A3D442038D
	for <drbd-dev@lists.linbit.com>; Tue, 28 Sep 2021 00:01:34 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
	ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
	chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com,
	thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Date: Mon, 27 Sep 2021 15:00:55 -0700
Message-Id: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Luis Chamberlain <mcgrof@kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 00/15] block: third batch of add_disk() error
	handling conversions
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

This is the 2nd version of the third batch of driver conversions for the
add_disk() error handling. This and the entire 7th series of driver
conversions can be found on my 20210927-for-axboe-add-disk-error-handling
branch [0].

On this v2 series the following changes have been made since the v1
series of this patch set:

  - rebased onto linux-next tag 20210927
  - z2ram: fixed compile warning reported by 0day and Geert Uytterhoe
  - um/drivers/ubd_kern: added the reviewed-by tag by Gabriel Krisman
    Bertazi

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

Christoph Hellwig (4):
  pcd: move the identify buffer into pcd_identify
  pcd: cleanup initialization
  pf: cleanup initialization
  pd: cleanup initialization

Luis Chamberlain (11):
  z2ram: add error handling support for add_disk()
  aoe: add error handling support for add_disk()
  m68k/emu/nfblock: add error handling support for add_disk()
  drbd: add error handling support for add_disk()
  um/drivers/ubd_kern: add error handling support for add_disk()
  xtensa/platforms/iss/simdisk: add error handling support for
    add_disk()
  n64cart: add error handling support for add_disk()
  pcd: add error handling support for add_disk()
  pcd: fix ordering of unregister_cdrom()
  pcd: capture errors on cdrom_register()
  pd: add error handling support for add_disk()

 arch/m68k/emu/nfblock.c             |   9 +-
 arch/um/drivers/ubd_kern.c          |  13 +-
 arch/xtensa/platforms/iss/simdisk.c |  13 +-
 drivers/block/aoe/aoeblk.c          |   6 +-
 drivers/block/drbd/drbd_main.c      |   6 +-
 drivers/block/n64cart.c             |  12 +-
 drivers/block/paride/pcd.c          | 304 +++++++++++++---------------
 drivers/block/paride/pd.c           | 144 ++++++-------
 drivers/block/paride/pf.c           | 223 +++++++++-----------
 drivers/block/z2ram.c               |   7 +-
 10 files changed, 364 insertions(+), 373 deletions(-)

-- 
2.30.2

