Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EA1A61057318
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jan 2018 07:29:12 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 25 Jan 2018 14:28:49 +0800
Message-Id: <20180125062849.4337-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [PATCH] drbdadm: Support to pass force option to dump md
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

At least till v8.9.6, drbdadm dump-md support
"--force" option to dump the metadata while
the device still running.

drbdmeta still able to dump but drbdadm will
show "unrecognized option" to "--force"

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 user/v9/config_flags.c | 6 ++++++
 user/v9/config_flags.h | 1 +
 user/v9/drbdadm_main.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/user/v9/config_flags.c b/user/v9/config_flags.c
index 063edce7..ae24d0c8 100644
--- a/user/v9/config_flags.c
+++ b/user/v9/config_flags.c
@@ -1084,6 +1084,12 @@ struct context_def create_md_ctx = {
 		{ } },
 };
 
+struct context_def dump_md_ctx = {
+       .fields = {
+		{ .name = "force", .argument_is_optional = true },
+		{ } },
+};
+
 struct context_def adjust_ctx = {
 	.fields = {
 		{ "skip-disk", .argument_is_optional = true },
diff --git a/user/v9/config_flags.h b/user/v9/config_flags.h
index 8e192cb0..bcc9d634 100644
--- a/user/v9/config_flags.h
+++ b/user/v9/config_flags.h
@@ -100,6 +100,7 @@ extern struct context_def verify_cmd_ctx;
 extern struct context_def device_options_ctx;
 extern struct context_def invalidate_ctx;
 extern struct context_def create_md_ctx;
+extern struct context_def dump_md_ctx;
 extern struct context_def adjust_ctx;
 extern struct context_def peer_device_options_ctx;
 extern struct context_def handlers_ctx;
diff --git a/user/v9/drbdadm_main.c b/user/v9/drbdadm_main.c
index 6d76eb67..26759c80 100644
--- a/user/v9/drbdadm_main.c
+++ b/user/v9/drbdadm_main.c
@@ -357,7 +357,7 @@ static struct adm_cmd dump_xml_cmd = {"dump-xml", adm_dump_xml, ACF1_DUMP};
 static struct adm_cmd create_md_cmd = {"create-md", adm_create_md, &create_md_ctx, ACF1_MINOR_ONLY };
 static struct adm_cmd show_gi_cmd = {"show-gi", adm_setup_and_meta, ACF1_PEER_DEVICE .disk_required = 1};
 static struct adm_cmd get_gi_cmd = {"get-gi", adm_setup_and_meta, ACF1_PEER_DEVICE .disk_required = 1};
-static struct adm_cmd dump_md_cmd = {"dump-md", adm_drbdmeta, ACF1_MINOR_ONLY };
+static struct adm_cmd dump_md_cmd = {"dump-md", adm_drbdmeta, &dump_md_ctx, ACF1_MINOR_ONLY };
 static struct adm_cmd wipe_md_cmd = {"wipe-md", adm_drbdmeta, ACF1_MINOR_ONLY };
 static struct adm_cmd apply_al_cmd = {"apply-al", adm_drbdmeta, ACF1_MINOR_ONLY };
 static struct adm_cmd forget_peer_cmd = {"forget-peer", adm_forget_peer, ACF1_DISCONNECT };
-- 
2.12.0

