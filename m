Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1634A1057583
	for <drbd-dev@lists.linbit.com>; Tue,  7 Nov 2017 09:43:25 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Nov 2017 16:43:05 +0800
Message-Id: <20171107084305.22757-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [PATCH] drbd-utils: Remove the hardcoded local5 of
	logfacility
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

It is able to override the loglevel with --logfacility 
in crm-fence-peer.sh. However, in other scripts still 
hardcoded to "local5.info". It is confusing only redirect 
part of scripts.

Support --logfacility in notify.sh and snapshot-resync-target-lvm.sh

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 scripts/notify.sh                     | 60 ++++++++++++++++++++++++++++-------
 scripts/snapshot-resync-target-lvm.sh | 29 +++++++++++++++--
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/scripts/notify.sh b/scripts/notify.sh
index c7bfb9c1..71cdbb7d 100755
--- a/scripts/notify.sh
+++ b/scripts/notify.sh
@@ -7,15 +7,54 @@
 # try to get possible output on stdout/err to syslog
 PROG=${0##*/}
 
-# Funky redirection to avoid logger feeding its own output to itself accidentally.
-# Funky double exec to avoid an intermediate sub-shell.
-# Sometimes, the sub-shell lingers around, keeps file descriptors open,
-# and logger then won't notice the main script has finished,
-# forever waiting for further input.
-# The second exec replaces the subshell, and logger will notice directly
-# when its stdin is closed once the main script exits.
-# This avoids the spurious logger processes.
-exec > >( exec 1>&- 2>&- logger -t "$PROG[$$]" -p local5.info) 2>&1
+redirect_to_logger()
+{
+	local lf=${1:-local5}
+	case $lf in
+	# do we want to exclude some?
+	auth|authpriv|cron|daemon|ftp|kern|lpr|mail|news|syslog|user|uucp|local[0-7])
+		: OK ;;
+	*)
+		echo >&2 "invalid logfacility: $lf"
+		return
+		;;
+	esac
+
+	# Funky redirection to avoid logger feeding its own output to itself accidentally.
+	# Funky double exec to avoid an intermediate sub-shell.
+	# Sometimes, the sub-shell lingers around, keeps file descriptors open,
+	# and logger then won't notice the main script has finished,
+	# forever waiting for further input.
+	# The second exec replaces the subshell, and logger will notice directly
+	# when its stdin is closed once the main script exits.
+	# This avoids the spurious logger processes.
+	exec > >( exec 1>&- 2>&- logger -t "$PROG[$$]" -p $lf.info ) 2>&1
+}
+
+if [[ $- != *x* ]]; then
+	# you may override with --logfacility below
+	redirect_to_logger local5
+fi
+
+TEMP=$(getopt -o l: --long logfacility: -- "$@")
+eval set -- "$TEMP"
+while [[ $# != 0 ]]; do
+	case $1 in
+	-l|--logfacility)
+		redirect_to_logger $2
+		shift
+		;;
+	--)
+		;;
+	*)
+		RECIPIENT=${1:-root}
+		;;
+	esac
+	shift
+done
+
+# Default to sending email to root, unless otherwise specified
+: ${RECIPIENT:=root}
 
 if [[ $DRBD_VOLUME ]]; then
 	pretty_print="$DRBD_RESOURCE/$DRBD_VOLUME (drbd$DRBD_MINOR)"
@@ -25,9 +64,6 @@ fi
 
 echo "invoked for $pretty_print"
 
-# Default to sending email to root, unless otherwise specified
-RECIPIENT=${1:-root}
-
 # check arguments specified on command line
 if [ -z "$RECIPIENT" ]; then
 	echo "You must specify a notification recipient when using this handler." >&2
diff --git a/scripts/snapshot-resync-target-lvm.sh b/scripts/snapshot-resync-target-lvm.sh
index 8eec5d13..0e6b91a8 100755
--- a/scripts/snapshot-resync-target-lvm.sh
+++ b/scripts/snapshot-resync-target-lvm.sh
@@ -21,10 +21,31 @@ if [[ -z "$DRBD_RESOURCE" || -z "$DRBD_LL_DISK" ]]; then
 fi
 
 PROG=$(basename $0)
-exec > >(exec 2>&- ; logger -t "$PROG[$$]" -p local5.info) 2>&1
+
+redirect_to_logger()
+{
+	local lf=${1:-local5}
+	case $lf in
+	# do we want to exclude some?
+	auth|authpriv|cron|daemon|ftp|kern|lpr|mail|news|syslog|user|uucp|local[0-7])
+		: OK ;;
+	*)
+		echo >&2 "invalid logfacility: $lf"
+		return
+		;;
+	esac
+
+	exec > >( exec 1>&- 2>&- logger -t "$PROG[$$]" -p $lf.info ) 2>&1
+}
+
+if [[ $- != *x* ]]; then
+	# you may override with --logfacility below
+	redirect_to_logger local5
+fi
+
 echo "invoked for $DRBD_RESOURCE/$DRBD_VOLUME (drbd$DRBD_MINOR)"
 
-TEMP=$(getopt -o p:a:nv --long percent:,additional:,disconnect-on-error,verbose -- "$@")
+TEMP=$(getopt -o p:a:l:nv --long percent:,additional:,logfacility:,disconnect-on-error,verbose -- "$@")
 
 if [ $? != 0 ]; then
 	echo "getopt failed"
@@ -88,6 +109,10 @@ while true; do
 	-v|--verbose)
 		BE_VERBOSE=1
 		;;
+	-l|--logfacility)
+		redirect_to_logger $2
+		shift
+		;;
 	--)
 		break
 		;;
-- 
2.12.0

