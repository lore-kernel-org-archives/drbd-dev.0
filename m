Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ACE361011BAB
	for <drbd-dev@lists.linbit.com>; Fri, 12 Feb 2010 11:43:37 +0100 (CET)
Date: Fri, 12 Feb 2010 11:43:37 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100212104337.GA12119@soda.linbit>
References: <785112911002111446i1010e429kf36ae7dcecacaeb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <785112911002111446i1010e429kf36ae7dcecacaeb3@mail.gmail.com>
Subject: Re: [Drbd-dev] missing shift in snapshot-resync-target-lvm.sh
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Feb 11, 2010 at 05:46:30PM -0500, Nathan Faber wrote:
> Hi,
> 
> In 8.3.7 and in 8.3 git the shift on the percent arg is off by one and
> causes an infinite loop on before-resync-target execution.
> 
> --- snapshot-resync-target-lvm-orig.sh 2010-02-03 18:54:27.000000000 -0500
> +++ snapshot-resync-target-lvm.sh 2010-02-11 17:34:46.000000000 -0500
> @@ -44,7 +44,7 @@
>   case $1 in
>   -p|--percent)
>   SNAP_PERC="$2"
> - shift
> + shift 2
>   ;;
>   -a|--additional)
>   SNAP_ADDITIONAL="$2"

Right...
can you try this patch instead:

diff --git a/scripts/snapshot-resync-target-lvm.sh b/scripts/snapshot-resync-target-lvm.sh
index 8457e18..1971ae9 100755
--- a/scripts/snapshot-resync-target-lvm.sh
+++ b/scripts/snapshot-resync-target-lvm.sh
@@ -39,38 +39,39 @@ BE_VERBOSE=0
 SNAP_NAME=${BACKING_BDEV##*/}-before-resync
 DEFAULTFILE="/etc/default/drbd-snapshot"
 
+if [ -f $DEFAULTFILE ]; then
+	. $DEFAULTFILE
+fi
+
+## command line parameters override default file
+
 eval set -- "$TEMP"
 while true; do
 	case $1 in
-		-p|--percent)
-			SNAP_PERC="$2"
-			shift
-			;;
-		-a|--additional)
-			SNAP_ADDITIONAL="$2"
-			shift 2
-			;;
-		-n|--disconnect-on-error)
-			DISCONNECT_ON_ERROR=1
-			shift
-			;;
-		-v|--verbose)
-			BE_VERBOSE=1
-			shift
-			;;
-		--)
-			shift
-			break
-			;;
+	-p|--percent)
+		SNAP_PERC="$2"
+		shift
+		;;
+	-a|--additional)
+		SNAP_ADDITIONAL="$2"
+		shift
+		;;
+	-n|--disconnect-on-error)
+		DISCONNECT_ON_ERROR=1
+		;;
+	-v|--verbose)
+		BE_VERBOSE=1
+		;;
+	--)
+		break
+		;;
 	esac
+	shift
 done
+shift # the -- 
 
 LVC_OPTIONS="$@"
 
-if [ -f $DEFAULTFILE ]; then
-	. $DEFAULTFILE
-fi
-
 if [[ $0 == *unsnapshot* ]]; then
 	[ $BE_VERBOSE = 1 ] && set -x
 	VG_PATH=${BACKING_BDEV%/*}
@@ -80,8 +81,8 @@ else
 	(
 		set -e
 		[ $BE_VERBOSE = 1 ] && set -x
-		DRBD_DEV=$(drbdadm sh-dev $DRBD_RESOURCE)
-		DRBD_MINOR=${DRBD_DEV##/dev/drbd}
+		# it may even be a stacked resource :-/
+		DRBD_MINOR=$(drbdadm sh-minor $DRBD_RESOURCE || drbdadm -S sh-minor $DRBD_RESOURCE)
 		OUT_OF_SYNC=$(sed -ne "/^ *$DRBD_MINOR:/ "'{
 				n;
 				s/^.* oos:\([0-9]*\).*$/\1/;


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
