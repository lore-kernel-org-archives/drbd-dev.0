Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C22A01058025
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:31:53 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id r187so634035wma.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:31:53 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:11 +0200
Message-Id: <1503609794-13233-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/17] drbd: rename "usermode_helper" to
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 74a7d0b..61596af 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -75,7 +75,7 @@ extern int fault_rate;
 extern int fault_devs;
 #endif
 
-extern char usermode_helper[];
+extern char drbd_usermode_helper[];
 
 
 /* This is used to stop/restart our threads.
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8b8dd82..bdd9ab2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -109,9 +109,9 @@ int proc_details;       /* Detail level in proc drbd*/
 
 /* Module parameter for setting the user mode helper program
  * to run. Default is /sbin/drbdadm */
-char usermode_helper[80] = "/sbin/drbdadm";
+char drbd_usermode_helper[80] = "/sbin/drbdadm";
 
-module_param_string(usermode_helper, usermode_helper, sizeof(usermode_helper), 0644);
+module_param_string(usermode_helper, drbd_usermode_helper, sizeof(drbd_usermode_helper), 0644);
 
 /* in 2.6.x, our device mapping and config info contains our virtual gendisks
  * as member "struct gendisk *vdisk;"
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 6bb58a6..a12f77e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -344,7 +344,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 			 (char[60]) { }, /* address */
 			NULL };
 	char mb[14];
-	char *argv[] = {usermode_helper, cmd, mb, NULL };
+	char *argv[] = {drbd_usermode_helper, cmd, mb, NULL };
 	struct drbd_connection *connection = first_peer_device(device)->connection;
 	struct sib_info sib;
 	int ret;
@@ -359,19 +359,19 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
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
@@ -396,24 +396,24 @@ enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd)
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
-- 
2.7.4

