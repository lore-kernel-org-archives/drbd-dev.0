Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DF4751011B99
	for <drbd-dev@lists.linbit.com>; Tue, 21 Jul 2015 04:43:37 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Tue, 21 Jul 2015 10:43:16 +0800
Message-Id: <1437446596-19004-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbdsetup: Allow zeroing out devices locally to
	instead of initial full sync.
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

Full sync for drbd initial usually take a long time,
allow "--zap-devices" on "new-current-uuid" to zero
out device on both side.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 documentation/v84/drbdsetup.xml | 9 +++++++++
 user/v84/config_flags.c         | 1 +
 user/v84/linux/drbd_genl.h      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/documentation/v84/drbdsetup.xml b/documentation/v84/drbdsetup.xml
index d4c4e87..a44b733 100644
--- a/documentation/v84/drbdsetup.xml
+++ b/documentation/v84/drbdsetup.xml
@@ -1705,6 +1705,15 @@
               <para>Clears the sync bitmap in addition to generating a new current UUID.</para>
             </listitem>
           </varlistentry>
+
+          <varlistentry>
+            <term><option>--zap-devices</option></term>
+
+            <listitem>
+              <para>Start to zeroing out the device on both side in addition to generating
+              a new current UUID .</para>
+            </listitem>
+          </varlistentry>
         </variablelist></para>
 
       <para>This can be used to skip the initial sync, if you want to start from scratch. This
diff --git a/user/v84/config_flags.c b/user/v84/config_flags.c
index 3b0303f..8712a11 100644
--- a/user/v84/config_flags.c
+++ b/user/v84/config_flags.c
@@ -1019,6 +1019,7 @@ struct context_def new_current_uuid_cmd_ctx = {
 	NLA_POLICY(new_c_uuid_parms),
 	.fields = {
 		{ "clear-bitmap", FLAG(clear_bm) },
+		{ "zap-devices", FLAG(zap_devices) },
 		{ } },
 };
 
diff --git a/user/v84/linux/drbd_genl.h b/user/v84/linux/drbd_genl.h
index 8ddedd1..0b850d3 100644
--- a/user/v84/linux/drbd_genl.h
+++ b/user/v84/linux/drbd_genl.h
@@ -238,6 +238,7 @@ GENL_struct(DRBD_NLA_START_OV_PARMS, 9, start_ov_parms,
 
 GENL_struct(DRBD_NLA_NEW_C_UUID_PARMS, 10, new_c_uuid_parms,
 	__flg_field(1, DRBD_GENLA_F_MANDATORY, clear_bm)
+	__flg_field(2, DRBD_GENLA_F_MANDATORY, zap_devices)
 )
 
 GENL_struct(DRBD_NLA_TIMEOUT_PARMS, 11, timeout_parms,
-- 
1.8.4.5

