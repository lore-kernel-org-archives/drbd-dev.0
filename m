Return-Path: <jiangjian@cdjrlc.com>
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F373442060F
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 18:05:12 +0200 (CEST)
From: Jiang Jian <jiangjian@cdjrlc.com>
To: axboe@kernel.dk
Date: Wed, 22 Jun 2022 23:52:20 +0800
Message-Id: <20220622155220.8704-1-jiangjian@cdjrlc.com>
Cc: philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block: drbd: drbd_state: Fix typo in comments
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

Replace 'is' with 'it'

file: drivers/block/drbd/drbd_state.c
line: 1900

* But is is still not save to dreference ldev here, since

changed to:

* But it is still not save to dreference ldev here, since

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3f7bf9f2d874..99927c44f0c3 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1897,7 +1897,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		int was_io_error = 0;
 		/* corresponding get_ldev was in _drbd_set_state, to serialize
 		 * our cleanup here with the transition to D_DISKLESS.
-		 * But is is still not save to dreference ldev here, since
+		 * But it is still not save to dreference ldev here, since
 		 * we might come from an failed Attach before ldev was set. */
 		if (device->ldev) {
 			rcu_read_lock();
-- 
2.17.1

