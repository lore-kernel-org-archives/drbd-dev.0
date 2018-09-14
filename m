Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 48DED1011BAE
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 10:56:42 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so16343018wrb.12
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 01:56:42 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	b10-v6sm6444999wmc.28.2018.09.17.01.56.41
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 17 Sep 2018 01:56:41 -0700 (PDT)
Resent-Message-ID: <20180917085641.GC24385@soda.linbit>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 861E2101AC7B
	for <drbd-dev@lists.linbit.com>; Fri, 14 Sep 2018 07:07:28 +0200 (CEST)
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so640311wmc.2
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2018 22:07:28 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Date: Thu, 13 Sep 2018 22:00:47 -0700
Message-Id: <20180914050047.7079-1-natechancellor@gmail.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Change drbd_request_detach_interruptible's
	return type to int
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

Clang warns when an implicit conversion is done between enumerated
types:

drivers/block/drbd/drbd_state.c:708:8: warning: implicit conversion from
enumeration type 'enum drbd_ret_code' to different enumeration type
'enum drbd_state_rv' [-Wenum-conversion]
                rv = ERR_INTR;
                   ~ ^~~~~~~~

drbd_request_detach_interruptible's only call site is in the return
statement of adm_detach, which returns an int. Change the return type of
drbd_request_detach_interruptible to match, silencing Clang's warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 6 ++----
 drivers/block/drbd/drbd_state.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0813c654c893..b452359b6aae 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -688,11 +688,9 @@ request_detach(struct drbd_device *device)
 			CS_VERBOSE | CS_ORDERED | CS_INHIBIT_MD_IO);
 }
 
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device)
+int drbd_request_detach_interruptible(struct drbd_device *device)
 {
-	enum drbd_state_rv rv;
-	int ret;
+	int ret, rv;
 
 	drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
 	wait_event_interruptible(device->state_wait,
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0895..cff0a34c150b 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -162,8 +162,7 @@ static inline int drbd_request_state(struct drbd_device *device,
 }
 
 /* for use in adm_detach() (drbd_adm_detach(), drbd_adm_down()) */
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device);
+int drbd_request_detach_interruptible(struct drbd_device *device);
 
 enum drbd_role conn_highest_role(struct drbd_connection *connection);
 enum drbd_role conn_highest_peer(struct drbd_connection *connection);
-- 
2.18.0

