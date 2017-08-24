Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C40D31058011
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:03 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id b189so4587374wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:03 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:03 +0200
Message-Id: <1503609794-13233-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/17] drbd: Fix resource role for newly created
	resources in events2
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

The conn_higest_role() (a terribly misnamed function) returns
the role of the resource. It returned R_UNKNOWN as long as the
resource has not a single device.

Resources without devices are short living objects.

But it matters for the NOTIFY_CREATE netwlink message. It makes
a lot more sense to report R_SECONDARY for the newly created
resource than R_UNKNOWN.

I reviewd all call sites of conn_highest_role(), that change
does not matter for the other call sites.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index eea0c4a..306f116 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -346,7 +346,7 @@ static enum drbd_role min_role(enum drbd_role role1, enum drbd_role role2)
 
 enum drbd_role conn_highest_role(struct drbd_connection *connection)
 {
-	enum drbd_role role = R_UNKNOWN;
+	enum drbd_role role = R_SECONDARY;
 	struct drbd_peer_device *peer_device;
 	int vnr;
 
-- 
2.7.4

