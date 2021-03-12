Return-Path: <lee.jones@linaro.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EADCA420231
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 11:55:34 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id g20so3530154wmk.3
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 02:55:34 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Date: Fri, 12 Mar 2021 10:55:19 +0000
Message-Id: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	xen-devel@lists.xenproject.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/11] Rid W=1 warnings from Block
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

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  block: rsxx: core: Remove superfluous const qualifier
  block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
    another header
  block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
    __maybe_unused
  block: drbd: drbd_state: Fix some function documentation issues
  block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
  block: drbd: drbd_main: Remove duplicate field initialisation
  block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
  block: drbd: drbd_main: Fix a bunch of function documentation
    discrepancies
  block: drbd: drbd_receiver: Demote less than half complete kernel-doc
    header
  block: xen-blkfront: Demote kernel-doc abuses
  block: drbd: drbd_nl: Demote half-complete kernel-doc headers

 drivers/block/drbd/drbd_interval.c |  8 +++++---
 drivers/block/drbd/drbd_main.c     | 30 +++++++++++++++---------------
 drivers/block/drbd/drbd_nl.c       | 17 ++++++++++-------
 drivers/block/drbd/drbd_receiver.c | 26 ++++++++++++--------------
 drivers/block/drbd/drbd_state.c    |  7 ++++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/rsxx/core.c          |  2 +-
 drivers/block/xen-blkfront.c       |  6 +++---
 8 files changed, 51 insertions(+), 47 deletions(-)

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: linux-block@vger.kernel.org
Cc: Philip Kelleher <pjk1939@linux.ibm.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
-- 
2.27.0

