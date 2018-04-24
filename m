Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 40AC31057315
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 11:57:56 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id 66so6056049wmd.3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 02:57:56 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	e50-v6sm40545175wre.4.2018.04.25.02.57.55
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Apr 2018 02:57:55 -0700 (PDT)
Resent-Message-ID: <20180425095754.GC13433@soda.linbit>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D81F1057318
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 15:21:06 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id l16so830210wmh.2
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 06:21:06 -0700 (PDT)
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Apr 2018 15:14:10 +0200
Message-Id: <20180424131410.1603-1-luc.vanoostenryck@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drdb: fix print_st_err()'s prototype
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

print_st_err() is defined with its 4th argument taking an
'enum drbd_state_rv' but its prototype use an int for it.

Fix this by using 'enum drbd_state_rv' in the prototype too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0..b2a390ba7 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -131,7 +131,7 @@ extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state
 					  enum chg_state_flags,
 					  struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, int);
+			union drbd_state, enum drbd_state_rv);
 
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
-- 
2.17.0

