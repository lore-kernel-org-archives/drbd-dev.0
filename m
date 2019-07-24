Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7C8EB101AC4B
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 13:19:51 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id v19so41285193wmj.5
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 04:19:51 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id a2sm45620274wmj.9.2019.07.24.04.19.49
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jul 2019 04:19:50 -0700 (PDT)
Resent-Message-ID: <20190724111948.GG6697@soda.linbit>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 910C2101AC44
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 06:11:35 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id f5so11667972pgu.5
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 21:11:35 -0700 (PDT)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	axboe@kernel.dk
Date: Wed, 24 Jul 2019 11:49:26 +0800
Message-Id: <20190724034926.28755-1-baijiaju1990@gmail.com>
Cc: linux-block@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/2] block: drbd: Fix a possible null-pointer
	dereference in is_valid_state()
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

In is_valid_state(), there is an if statement on line 839 to check
whether nc is NULL:
    if (nc)

When nc is NULL, it is used on line 880:
    (nc->verify_alg[0] == 0)

Thus, a possible null-pointer dereference may occur.

To fix this bug, nc is also checked on line 880.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index eeaa3b49b264..3cf477e9cf6a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -877,7 +877,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 		rv = SS_CONNECTED_OUTDATES;
 
 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		 (nc->verify_alg[0] == 0))
+		 (nc && nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;
 
 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-- 
2.17.0

