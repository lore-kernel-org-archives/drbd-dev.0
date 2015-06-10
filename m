Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6A07310518BF
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:20 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:23 +0800
Message-Id: <1433922509-10280-5-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 04/10] A function to send peer node about
	starting zero out, using UI_FLAGS 16.
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

Using UI_FLAGS(16) of P_UUIDS to start zeroing device of peer node.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_int.h  | 1 +
 drbd/drbd_main.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 9cc0ef9..d43adf2 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1205,6 +1205,7 @@ extern int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_pa
 extern int drbd_send_protocol(struct drbd_connection *connection);
 extern int drbd_send_uuids(struct drbd_peer_device *);
 extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
+extern int drbd_send_zero_out_start(struct drbd_peer_device *);
 extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
 extern int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags);
 extern int drbd_send_state(struct drbd_peer_device *, union drbd_state);
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 2ffb569..841ed30 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -908,6 +908,11 @@ int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *peer_device)
 	return _drbd_send_uuids(peer_device, 8);
 }
 
+int drbd_send_zero_out_start(struct drbd_peer_device *peer_device)
+{
+	return _drbd_send_uuids(peer_device, 16);
+}
+
 void drbd_print_uuids(struct drbd_device *device, const char *text)
 {
 	if (get_ldev_if_state(device, D_NEGOTIATING)) {
-- 
1.8.4.5

