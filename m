Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
	[209.85.128.178])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 86F261058012
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:11 +0200 (CEST)
Received: by mail-wr0-f178.google.com with SMTP id p8so2130963wrf.2
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:10 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:14 +0200
Message-Id: <1503609794-13233-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/17] drbd: switch from kmalloc() to
	kmalloc_array()
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

From: Roland Kammerer <roland.kammerer@linbit.com>

We had one call to kmalloc that actually allocates an array. Switch that
one to the kmalloc_array() function.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4e8a543..796eaf3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4126,7 +4126,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 		return config_unknown_volume(connection, pi);
 	device = peer_device->device;
 
-	p_uuid = kmalloc(sizeof(u64)*UI_EXTENDED_SIZE, GFP_NOIO);
+	p_uuid = kmalloc_array(UI_EXTENDED_SIZE, sizeof(*p_uuid), GFP_NOIO);
 	if (!p_uuid) {
 		drbd_err(device, "kmalloc of p_uuid failed\n");
 		return false;
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 002611c..2d02593 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -51,7 +51,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.7"
+#define REL_VERSION "8.4.10"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
2.7.4

