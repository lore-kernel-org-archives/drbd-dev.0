Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com
	[209.85.128.182])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F1C61058038
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 14:56:28 +0200 (CEST)
Received: by mail-wr0-f182.google.com with SMTP id t76so8364095wrc.3
	for <drbd-dev@lists.linbit.com>; Wed, 04 Oct 2017 05:56:28 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n89sm11537156wmi.33.2017.10.04.05.56.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Oct 2017 05:56:27 -0700 (PDT)
Resent-Message-ID: <20171004125627.GG8989@soda.linbit>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7F187105801B
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 03:50:23 +0200 (CEST)
From: Jia-Ju Bai <baijiaju1990@163.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  4 Oct 2017 09:37:29 +0800
Message-Id: <1507081049-16838-1-git-send-email-baijiaju1990@163.com>
Cc: Jia-Ju Bai <baijiaju1990@163.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: Fix a sleep-in-atomic bug in
	notify_helper
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
      notify_helper
        genlmsg_new(GFP_NOIO) --> may sleep

To fix it, GFP_NOIO is replaced with GFP_ATOMIC.
This bug is found by my static analysis tool and my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a12f77e..ad093da 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4790,7 +4790,7 @@ void notify_helper(enum drbd_notification_type type,
 	helper_info.helper_name_len = min(strlen(name), sizeof(helper_info.helper_name));
 	helper_info.helper_status = status;
 
-	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	err = -ENOMEM;
 	if (!skb)
 		goto fail;
-- 
1.7.9.5


