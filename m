Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
	[209.85.166.50])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D8F95103B4B8
	for <drbd-dev@lists.linbit.com>; Mon,  8 Jul 2019 20:16:46 +0200 (CEST)
Received: by mail-io1-f50.google.com with SMTP id g20so16295585ioc.12
	for <drbd-dev@lists.linbit.com>; Mon, 08 Jul 2019 11:16:46 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	t19sm15767775iog.41.2019.07.08.11.16.44
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Jul 2019 11:16:45 -0700 (PDT)
From: David Butterfield <dab21774@gmail.com>
To: drbd-dev@lists.linbit.com
Message-ID: <ef9fab02-3129-d733-2316-1c11a246c572@gmail.com>
Date: Mon, 8 Jul 2019 12:16:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] "missing-prototypes" warning under standard kernel
	compile options
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

This fixes a "missing-prototypes" compiler warning under the standard kernel compile
warning options.  It wants to see a prior declaration for externally-visible functions.
The function at issue does not need to be externally-visible, so make it static.

drbd_actlog.c:239:1: warning: no previous prototype for ‘set_bme_priority’ [-Wmissing-prototypes]
 set_bme_priority(struct get_activity_log_ref_ctx *al_ctx)



diff --git a/drbd/drbd_actlog.c b/drbd/drbd_actlog.c
index 44c5b2cc..20b72d5f 100644
--- a/drbd/drbd_actlog.c
+++ b/drbd/drbd_actlog.c
@@ -235,7 +235,7 @@ find_active_resync_extent(struct get_activity_log_ref_ctx *al_ctx)
 	return NULL;
 }
 
-void
+static void
 set_bme_priority(struct get_activity_log_ref_ctx *al_ctx)
 {
 	struct drbd_peer_device *peer_device;
