Return-Path: <imrep.amz@gmail.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 58D0E1028A4A
	for <drbd-dev@lists.linbit.com>; Mon,  9 Feb 2015 14:11:36 +0100 (CET)
Received: by mail-wg0-f54.google.com with SMTP id y19so577768wgg.13
	for <drbd-dev@lists.linbit.com>; Mon, 09 Feb 2015 05:11:36 -0800 (PST)
From: Imre Palik <imrep.amz@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Mon,  9 Feb 2015 14:05:38 +0100
Message-Id: <1423487138-6971-1-git-send-email-imrep.amz@gmail.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] [PATCH] drbd-utils: drbd service: specifying commands
	from /sbin/ with absolute path
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

From: "Palik, Imre" <imrep@amazon.de>

This change removes the dependance of the service on wether /sbin is
in the path or not.

Signed-off-by: Imre Palik <imrep@amazon.de>
---
 scripts/drbd |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/drbd b/scripts/drbd
index b6b0a2c..482c69d 100755
--- a/scripts/drbd
+++ b/scripts/drbd
@@ -27,6 +27,8 @@ DRBDSETUP="drbdsetup"
 PROC_DRBD="/proc/drbd"
 MODPROBE="/sbin/modprobe"
 RMMOD="/sbin/rmmod"
+UDEVADM="/sbin/udevadm"
+UDEVSETTLE="/sbin/udevsettle"
 UDEV_TIMEOUT=10
 ADD_MOD_PARAM=""
 
@@ -120,13 +122,13 @@ drbd_pretty_status()
 # But don't wait too long.
 _udev_settle()
 {
-	if udevadm version ; then
+	if $UDEVADM version ; then
 		# ok, we have udevadm, use it.
-		udevadm settle --timeout=5
+		$UDEVADM settle --timeout=5
 	else
 		# if udevsettle is not there,
 		# no matter.
-		udevsettle --timeout=5
+		$UDEVSETTLE --timeout=5
 	fi
 }
 
-- 
1.7.9.5

