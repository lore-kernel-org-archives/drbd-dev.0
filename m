Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2B6A81056452
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:24 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:36 +0200
Message-Id: <1461586077-11581-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/30] drbd: fix for truncated minor number in
	callback command line
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

The command line parameter the kernel module uses to communicate the
device minor to userland helper is flawed in a way that the device
indentifier "minor-%d" is being truncated to minors with a maximum
of 5 digits.

But DRBD 8.4 allows 2^20 == 1048576 minors,
thus a minimum of 7 digits must be supported.

Reported by Veit Wahlich on drbd-dev.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index ee4642f..e63c5c4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -343,7 +343,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 			 (char[20]) { }, /* address family */
 			 (char[60]) { }, /* address */
 			NULL };
-	char mb[12];
+	char mb[14];
 	char *argv[] = {usermode_helper, cmd, mb, NULL };
 	struct drbd_connection *connection = first_peer_device(device)->connection;
 	struct sib_info sib;
@@ -352,7 +352,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	if (current == connection->worker.task)
 		set_bit(CALLBACK_PENDING, &connection->flags);
 
-	snprintf(mb, 12, "minor-%d", device_to_minor(device));
+	snprintf(mb, 14, "minor-%d", device_to_minor(device));
 	setup_khelper_env(connection, envp);
 
 	/* The helper may take some time.
-- 
1.9.1

