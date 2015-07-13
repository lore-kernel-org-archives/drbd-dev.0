Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6011110556B0
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:40 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:38:59 +0800
Message-Id: <1436776744-3135-6-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 05/10] drbd: Functions to notify peer node to
	zero out
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

Notify peer node to start zeroing out device.
Update state of peer node when both nodes are
finished zeroing.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h  |  2 ++
 drbd/drbd_main.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 014b65e..f43f957 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1208,6 +1208,8 @@ extern int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_pa
 extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
+extern int drbd_send_zero_out_start(struct drbd_peer_device *);
+extern int drbd_send_zero_out_finish(struct drbd_peer_device *);
 extern int drbd_send_zero_out_ok(struct drbd_peer_device *);
 extern int drbd_send_zero_out_fail(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 740015e..2b821cd 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -908,6 +908,25 @@ int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 8);
 }
 
+
+/**
+ * drbd_send_zero_out_start() - Notify peer node to start zero out
+ * @peer_device:	DRBD peer device.
+ */
+int drbd_send_zero_out_start(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 16);
+}
+
+/**
+ * drbd_send_zero_out_finish() - Notify both node finished zeroing out
+ * @peer_device:	DRBD peer device.
+ */
+int drbd_send_zero_out_finish(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 32);
+}
+
 /**
  * _drbd_send_zero_out_state() - Sends the drbd state to the peer
  * @peer_device:	DRBD peer device.
-- 
1.8.4.5

