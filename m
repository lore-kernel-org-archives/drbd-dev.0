Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5167C105801D
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 14:56:23 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id t69so22611165wmt.2
	for <drbd-dev@lists.linbit.com>; Wed, 04 Oct 2017 05:56:23 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	x14sm8122445edd.10.2017.10.04.05.56.21
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Oct 2017 05:56:22 -0700 (PDT)
Resent-Message-ID: <20171004125621.GF8989@soda.linbit>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CA125105801B
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 03:46:46 +0200 (CEST)
From: Jia-Ju Bai <baijiaju1990@163.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  4 Oct 2017 09:33:18 +0800
Message-Id: <1507080798-16585-1-git-send-email-baijiaju1990@163.com>
Cc: Jia-Ju Bai <baijiaju1990@163.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: Fix a sleep-in-atomic bug in
	drbd_bcast_event
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

The driver may sleep under a RCU lock, and the function call path is:
drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      drbd_bcast_event
        genlmsg_new(GFP_NOIO) --> may sleep

To fix it, GFP_NOIO is replaced with GFP_ATOMIC.
This bug is found by my static analysis tool and my code review.


Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a12f77e..713c965 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4537,7 +4537,7 @@ void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib)
 	int err = -ENOMEM;
 
 	seq = atomic_inc_return(&drbd_genl_seq);
-	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (!msg)
 		goto failed;
 
-- 
1.7.9.5


