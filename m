Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CBB621057FCE
	for <drbd-dev@lists.linbit.com>; Tue,  6 Jun 2017 13:59:17 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id x70so35381033wme.0
	for <drbd-dev@lists.linbit.com>; Tue, 06 Jun 2017 04:59:17 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	e73sm13514503wmd.1.2017.06.06.04.59.16
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Jun 2017 04:59:16 -0700 (PDT)
Resent-Message-ID: <20170606115913.GD13239@soda.linbit>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 138E81057FD4
	for <drbd-dev@lists.linbit.com>; Mon,  5 Jun 2017 11:34:08 +0200 (CEST)
Date: Mon, 5 Jun 2017 11:26:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20170605092623.GA20170@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: rename "usermode_helper" to
	"drbd_usermode_helper"
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nothing like having a very generic global variable in a tiny driver
subsystem to make a mess of the global namespace...

Note, there are many other "generic" named global variables in the drbd
subsystem, someone should fix those up one day before they hit a linking
error.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |    4 ++--
 drivers/block/drbd/drbd_nl.c   |   20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -75,7 +75,7 @@ extern int fault_rate;
 extern int fault_devs;
 #endif
 
-extern char usermode_helper[];
+extern char drbd_usermode_helper[];
 
 
 /* This is used to stop/restart our threads.
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -109,9 +109,9 @@ int proc_details;       /* Detail level
 
 /* Module parameter for setting the user mode helper program
  * to run. Default is /sbin/drbdadm */
-char usermode_helper[80] = "/sbin/drbdadm";
+char drbd_usermode_helper[80] = "/sbin/drbdadm";
 
-module_param_string(usermode_helper, usermode_helper, sizeof(usermode_helper), 0644);
+module_param_string(usermode_helper, drbd_usermode_helper, sizeof(drbd_usermode_helper), 0644);
 
 /* in 2.6.x, our device mapping and config info contains our virtual gendisks
  * as member "struct gendisk *vdisk;"
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -344,7 +344,7 @@ int drbd_khelper(struct drbd_device *dev
 			 (char[60]) { }, /* address */
 			NULL };
 	char mb[14];
-	char *argv[] = {usermode_helper, cmd, mb, NULL };
+	char *argv[] = {drbd_usermode_helper, cmd, mb, NULL };
 	struct drbd_connection *connection = first_peer_device(device)->connection;
 	struct sib_info sib;
 	int ret;
@@ -359,19 +359,19 @@ int drbd_khelper(struct drbd_device *dev
 	 * write out any unsynced meta data changes now */
 	drbd_md_sync(device);
 
-	drbd_info(device, "helper command: %s %s %s\n", usermode_helper, cmd, mb);
+	drbd_info(device, "helper command: %s %s %s\n", drbd_usermode_helper, cmd, mb);
 	sib.sib_reason = SIB_HELPER_PRE;
 	sib.helper_name = cmd;
 	drbd_bcast_event(device, &sib);
 	notify_helper(NOTIFY_CALL, device, connection, cmd, 0);
-	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
+	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
 		drbd_warn(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				usermode_helper, cmd, mb,
+				drbd_usermode_helper, cmd, mb,
 				(ret >> 8) & 0xff, ret);
 	else
 		drbd_info(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				usermode_helper, cmd, mb,
+				drbd_usermode_helper, cmd, mb,
 				(ret >> 8) & 0xff, ret);
 	sib.sib_reason = SIB_HELPER_POST;
 	sib.helper_exit_code = ret;
@@ -396,24 +396,24 @@ enum drbd_peer_state conn_khelper(struct
 			 (char[60]) { }, /* address */
 			NULL };
 	char *resource_name = connection->resource->name;
-	char *argv[] = {usermode_helper, cmd, resource_name, NULL };
+	char *argv[] = {drbd_usermode_helper, cmd, resource_name, NULL };
 	int ret;
 
 	setup_khelper_env(connection, envp);
 	conn_md_sync(connection);
 
-	drbd_info(connection, "helper command: %s %s %s\n", usermode_helper, cmd, resource_name);
+	drbd_info(connection, "helper command: %s %s %s\n", drbd_usermode_helper, cmd, resource_name);
 	/* TODO: conn_bcast_event() ?? */
 	notify_helper(NOTIFY_CALL, NULL, connection, cmd, 0);
 
-	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
+	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
 		drbd_warn(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  usermode_helper, cmd, resource_name,
+			  drbd_usermode_helper, cmd, resource_name,
 			  (ret >> 8) & 0xff, ret);
 	else
 		drbd_info(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  usermode_helper, cmd, resource_name,
+			  drbd_usermode_helper, cmd, resource_name,
 			  (ret >> 8) & 0xff, ret);
 	/* TODO: conn_bcast_event() ?? */
 	notify_helper(NOTIFY_RESPONSE, NULL, connection, cmd, ret);
