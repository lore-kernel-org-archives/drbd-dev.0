Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ECB4410003FC
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:05 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:21 +0800
Message-Id: <1433922509-10280-3-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 02/10] Add options zap_devices to
	new-current-uuid for zeroing out device before initial sync.
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

Add zap-devices options for new-current-uuid.
Need to change .h file in drbd-utils for user space.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_nl.c         | 9 +++++++++
 drbd/linux/drbd_genl.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 9c14cf3..1ef4551 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -4000,6 +4000,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_device *device;
 	enum drbd_ret_code retcode;
 	int skip_initial_sync = 0;
+	int zero_out_devices = 0;
 	int err;
 	struct new_c_uuid_parms args;
 
@@ -4034,6 +4035,14 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	    device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED && args.clear_bm) {
 		drbd_info(device, "Preparing to skip initial sync\n");
 		skip_initial_sync = 1;
+	/* this is "zero out" devices to make it all zero.
+	* ignore "zero out" if both "clear_bm" and "zap_devices" set. */
+	} else if (device->state.conn == C_CONNECTED &&
+	    first_peer_device(device)->connection->agreed_pro_version >= 90 &&
+	    device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
+		args.zap_devices) {
+		drbd_info(device, "Preparing to zero out devices, will take a long time\n");
+		zero_out_devices = 1;
 	} else if (device->state.conn != C_STANDALONE) {
 		retcode = ERR_CONNECTED;
 		goto out_dec;
diff --git a/drbd/linux/drbd_genl.h b/drbd/linux/drbd_genl.h
index 5db53f5..eef8d8c 100644
--- a/drbd/linux/drbd_genl.h
+++ b/drbd/linux/drbd_genl.h
@@ -240,6 +240,7 @@ GENL_struct(DRBD_NLA_START_OV_PARMS, 9, start_ov_parms,
 
 GENL_struct(DRBD_NLA_NEW_C_UUID_PARMS, 10, new_c_uuid_parms,
 	__flg_field(1, DRBD_GENLA_F_MANDATORY, clear_bm)
+	__flg_field(2, DRBD_GENLA_F_MANDATORY, zap_devices)
 )
 
 GENL_struct(DRBD_NLA_TIMEOUT_PARMS, 11, timeout_parms,
-- 
1.8.4.5

