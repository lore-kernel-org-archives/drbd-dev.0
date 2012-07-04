Return-Path: <acouvrard2@gmail.com>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A3D2310003F8
	for <drbd-dev@lists.linbit.com>; Wed,  4 Jul 2012 18:11:23 +0200 (CEST)
Received: by bkcje9 with SMTP id je9so2937189bkc.27
	for <drbd-dev@lists.linbit.com>; Wed, 04 Jul 2012 09:11:22 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 Jul 2012 16:11:22 +0000
Message-ID: <CAKb08JKL4hh2R2KH1kEPkowHy-EtK453qYFpfxa=PRN3hz=tdg@mail.gmail.com>
From: Alex Couvrard <acouvrard2@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary=000e0ce0d65e39623a04c4034810
Subject: [Drbd-dev] [PATCH] Fix spelling
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--000e0ce0d65e39623a04c4034810
Content-Type: text/plain; charset=ISO-8859-1

Fix spelling in source code and documentation. Found these with the
help of ispell.

diff --git a/ChangeLog b/ChangeLog
index 453e900..9a47fb4 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -129,14 +129,14 @@ Latest:
  * Fixed support for devices with 4k hard sector size (again)
  * Fixed a potential Oops in the disconnect code
  * Fixed a race condition that could cause DRBD to consider the peers disk
-   as Inconstent after resync instead of UpToDate (Bugz 271)
+   as Inconsistent after resync instead of UpToDate (Bugz 271)
  * Fixed a reace condition that could cause DRBD to consider the peers disk
    as Outdated instead of Inconsistent during resync (Bugz 277)
  * Disallow to start a resync with invalidate / invalidate-remote when the
    source disk is not UpToDate
  * Forcing primary works now also for Consistent, not only for Outdated and
    Inconsistent (Bugz 266)
- * Improved robustness against corrupt or malicous sector addresses when
+ * Improved robustness against corrupt or malicious sector addresses when
    receiving data
  * Added the initial-split-brain, it gets called also if the split-brain gets
    automatically resolved
@@ -174,7 +174,7 @@ Latest:
    resync is not possible but a full resync is necessary. Happens very rarely.
    (Bugz 260)
  * Do not drop into StandAlone mode when connection is lost during
authentication
- * Corrected a null test in the authentication code, found by conccinelle,
+ * Corrected a null test in the authentication code, found by coccinelle,
    thanks to upstream integration. The chance to trigger that was
probably 10^-9.
  * crm-fence-peer.sh is now also usable if DRBD is managed from the xen block
    helper script
@@ -285,7 +285,7 @@ Latest:
 8.3.0 (api:88/proto:86-89)
 --------
  * Fixed 'sleep with spinlock held' in case online verify found a difference
- * Fixed error code pathes in request processing.
+ * Fixed error code paths in request processing.
  * Fix for stack smashing in drbdmeta
  * Fixed a bug that could lead to a crash when detaching/attaching
    on the primary under heavy IO (Bugz 171)
@@ -404,7 +404,7 @@ Changelog for fixes propagated from 8.0.x:
 --------
  * Adding a missing range check in ensure_mdev()
  * Fix for several potential memory leaks when allocating a device (Bugz 135)
- * Fixed error code pathes in request processing (Bugz 149)
+ * Fixed error code paths in request processing (Bugz 149)
  * Fixed an minor issue with the exposed data UUID logic (Bugz 164)
  * Fixed tight attach/detach loops (Bugz 171)
  * Fixed drbdadm adjust, when a running config contains
"--discard-my-data" (Bugz 201)
@@ -421,9 +421,9 @@ Changelog for fixes propagated from 8.0.x:
  * reduce race possibilities in our thread restart code
  * linux 2.6.27 compatibility
  * latency improvements using TCP_QUICKACK
- * reduced spurious coding differrences between drbd-8.0 and drbd-8.2
+ * reduced spurious coding differences between drbd-8.0 and drbd-8.2
  * drbdsetup now checks for /proc/drbd instead of playing netlink ping-pong
-   to determin whether the drbd kernel module is present.
+   to determine whether the drbd kernel module is present.
  * fixed (harmless but annoying) stack corruption in drbdadm
  * adjusted timeouts on 'detach' and 'down'
  * fixed unit conversion of disk size configuration parameter
@@ -474,7 +474,7 @@ Changelog for fixes propagated from 8.0.x:
    Fixed.
  * Fixed a race that could deadlock worker and receiver while
    disconnecting a diskless node from a primary peer.
- * Fixed a minimal meory leak, upon each module unload of DRBD.
+ * Fixed a minimal memory leak, upon each module unload of DRBD.

 8.0.10 (api:86/proto:86)
 --------
diff --git a/Makefile.in b/Makefile.in
index fd6a744..8216551 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -84,7 +84,7 @@ ifeq ($(WITH_KM),yes)
 	@if ! test -e $(KDIR)/Makefile ; then \
 		echo "    SORRY, kernel makefile not found." ;\
 	        echo "    You need to tell me a correct KDIR," ;\
-	        echo "    Or install the neccessary kernel source packages." ;\
+	        echo "    Or install the necessary kernel source packages." ;\
 	        echo "" ;\
 		false;\
 	fi
diff --git a/benchmark/dm.c b/benchmark/dm.c
index d8224f7..617f0af 100644
--- a/benchmark/dm.c
+++ b/benchmark/dm.c
@@ -1,7 +1,7 @@
 /*
    dm.c

-   Copright 2001-2008 LINBIT Information Technologies
+   Copyright 2001-2008 LINBIT Information Technologies
    Philipp Reisner, Lars Ellenberg

    dm is free software; you can redistribute it and/or modify
diff --git a/debian/drbd8-utils.prerm b/debian/drbd8-utils.prerm
index 192a5c5..640cfa9 100644
--- a/debian/drbd8-utils.prerm
+++ b/debian/drbd8-utils.prerm
@@ -1,7 +1,7 @@
 #!/bin/sh

 # This script silently ignores the initscript return code if we remove
-# or deconfigure the package or carefully pay attention to it if we
+# or deconfigure the package or carefuly pay attention to it if we
 # upgrade the package.

 # Cyril Bouthors <cyril@bouthors.org>
diff --git a/documentation/drbd.conf.xml b/documentation/drbd.conf.xml
index 8bf8267..12e6df8 100644
--- a/documentation/drbd.conf.xml
+++ b/documentation/drbd.conf.xml
@@ -408,7 +408,7 @@
               </itemizedlist> <option>DRBD_PEER</option> is deprecated.</para>

             <para>Please note that not all of these might be set for
all handlers, and that some
-            values might not be useable for a
<option>floating</option> definition.</para>
+            values might not be usable for a
<option>floating</option> definition.</para>
           </listitem>
         </varlistentry>
       </variablelist>
diff --git a/drbd/Kbuild b/drbd/Kbuild
index eddddd8..4a04f2f 100644
--- a/drbd/Kbuild
+++ b/drbd/Kbuild
@@ -4,7 +4,7 @@ clean-files := compat.h .config.timestamp

 LINUXINCLUDE := -I$(src) $(LINUXINCLUDE)

-# Files in the standard include directories take precendence over files
+# Files in the standard include directories take precedence over files
 # in the compat directory.
 #
 # Add -I$(src) to EXTRA_CFLAGS again: some (rhel5, maybe other) kbuild does not
diff --git a/drbd/Makefile b/drbd/Makefile
index 2922cda..dad663d 100644
--- a/drbd/Makefile
+++ b/drbd/Makefile
@@ -32,7 +32,7 @@
 DESTDIR ?= /

 # since 2.6.16, KERNELRELEASE may be empty,
-# e.g. when building agains some (broken?) linux-header package.
+# e.g. when building against some (broken?) linux-header package.
 # Lets test on PATCHLEVEL, that won't change too soon...

 ifneq ($(PATCHLEVEL),)
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 102fdea..0a754e8 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -376,7 +376,7 @@ void req_may_be_completed(struct drbd_request
*req, struct bio_and_error *m)
 			req->master_bio = NULL;
 		} else {
 			/* Assert that this will be _req_is_done()
-			 * with this very invokation. */
+			 * with this very invocation. */
 			/* FIXME:
 			 * what about (RQ_LOCAL_PENDING | RQ_LOCAL_ABORTED)?
 			 */
diff --git a/drbd/drbd_state.h b/drbd/drbd_state.h
index b9290ab..ec0cd61 100644
--- a/drbd/drbd_state.h
+++ b/drbd/drbd_state.h
@@ -102,7 +102,7 @@ union drbd_dev_state {
 		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
 		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
 #else
-# error "this endianess is not supported"
+# error "this endianness is not supported"
 #endif
 	};
 	unsigned int i;
diff --git a/drbd/linux/drbd_genl.h b/drbd/linux/drbd_genl.h
index 826008f..f591723 100644
--- a/drbd/linux/drbd_genl.h
+++ b/drbd/linux/drbd_genl.h
@@ -190,7 +190,7 @@ GENL_struct(DRBD_NLA_STATE_INFO, 8, state_info,

 	/* These are for broadcast from after state change work.
 	 * prev_state and new_state are from the moment the state change took
-	 * place, new_state is not neccessarily the same as current_state,
+	 * place, new_state is not necessarily the same as current_state,
 	 * there may have been more state changes since.  Which will be
 	 * broadcasted soon, in their respective after state change work.  */
 	__u32_field(5, DRBD_GENLA_F_MANDATORY,	prev_state)
diff --git a/scripts/Makefile.in b/scripts/Makefile.in
index 57eadfd..ee36ead 100644
--- a/scripts/Makefile.in
+++ b/scripts/Makefile.in
@@ -2,7 +2,7 @@
 #
 # This file is part of DRBD by Philipp Reisner & Lars Ellenberg.
 #
-# Copright 2001-2008 LINBIT Information Technologies
+# Copyright 2001-2008 LINBIT Information Technologies
 # Philipp Reisner, Lars Ellenberg
 #
 # drbd is free software; you can redistribute it and/or modify
diff --git a/scripts/block-drbd b/scripts/block-drbd
old mode 100755
new mode 100644
index 02d31a5..23a7b93
--- a/scripts/block-drbd
+++ b/scripts/block-drbd
@@ -57,16 +57,16 @@ dir=$(dirname "$0")
 . "$dir/block-common.sh"

 ##
-# canonicalise_mode mode
+# canonicalize_mode mode
 #
 # Takes the given mode, which may be r, w, ro, rw, w!, or rw!, or variations
-# thereof, and canonicalises them to one of
+# thereof, and canonicalizes them to one of
 #
 #   'r': perform checks for a new read-only mount;
 #   'w': perform checks for a read-write mount; or
 #   '!': perform no checks at all.
 #
-canonicalise_mode()
+canonicalize_mode()
 {
   local mode="$1"

@@ -174,7 +174,7 @@ same_vm()
 check_device_sharing()
 {
   local dev="$1"
-  local mode=$(canonicalise_mode "$2")
+  local mode=$(canonicalize_mode "$2")
   local result

   if [ "x$mode" = 'x!' ]
diff --git a/scripts/crm-fence-peer.sh b/scripts/crm-fence-peer.sh
old mode 100755
new mode 100644
index 0f50f7b..9e5e09d
--- a/scripts/crm-fence-peer.sh
+++ b/scripts/crm-fence-peer.sh
@@ -81,7 +81,7 @@ fence_peer_init()
 # shoot it, just to be sure.
 #
 # --dc-timeout is how long we try to contact a DC before we give up.
-# This is neccessary, because placing the constraint will fail (with some
+# This is necessary, because placing the constraint will fail (with some
 # internal timeout) if no DC was available when we request the constraint.
 # Which is likely if the DC crashed. Then the surviving DRBD Primary needs
 # to wait for a new DC to be elected. Usually such election takes only
@@ -105,7 +105,7 @@ fence_peer_init()
 #
 #       If peer is still reachable according to the cib,
 #	we first poll the cib until timeout has elapsed,
-#	or the peer becomes definetely unreachable.
+#	or the peer becomes definitely unreachable.
 #
 #	This gives STONITH the chance to kill us.
 #	With "fencing resource-and-stontith;" this protects us against
@@ -141,7 +141,7 @@ fence_peer_init()
 #	place the constraint - if the peer had better data, it should have a
 #	higher master score, and we should not have been asked to become
 #	primary.  If the peer is not reachable, we don't do anything, and drbd
-#	will refuse to be promoted. This is neccessary to avoid problems
+#	will refuse to be promoted. This is necessary to avoid problems
 #	With data diversion, in case this "crash" was due to a STONITH operation,
 #	maybe the reboot did not fix our cluster communications!
 #
@@ -244,7 +244,7 @@ drbd_peer_fencing()
 		if [[ -z $have_constraint ]] ; then
 			# try to place it.

-			# interessting:
+			# interesting:
 			# In case this is a two-node cluster (still common with
 			# drbd clusters) it does not have real quorum.
 			# If it is configured to do stonith, and reboot,
@@ -361,7 +361,7 @@ check_peer_node_reachable()
 		nr_other_nodes=$(echo "$state_lines" | grep -v -F
uname=\"$HOSTNAME\" | wc -l)
 		if [[ $nr_other_nodes -gt 1 ]]; then
 			# Many nodes cluster, look at $DRBD_PEER, if set.
-			# Note that this should not be neccessary.  The problem
+			# Note that this should not be necessary.  The problem
 			# we try to solve is relevant on two-node clusters
 			# (no real quorum)
 			if [[ $DRBD_PEER ]]; then
diff --git a/scripts/drbd.gentoo b/scripts/drbd.gentoo
index d34caaa..1c2b295 100644
--- a/scripts/drbd.gentoo
+++ b/scripts/drbd.gentoo
@@ -1,6 +1,6 @@
 #!/sbin/runscript
 # Distributed under the terms of the GNU General Public License v2
-# Copright 2001-2008 LINBIT Information Technologies
+# Copyright 2001-2008 LINBIT Information Technologies
 # Philipp Reisner, Lars Ellenberg
 # Original script adapted to gentoo environment

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
old mode 100644
new mode 100755
index 7d3e0f1..9c5df30
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -53,12 +53,18 @@ if test -n "${OCF_FUNCTIONS_DIR}" ; then
 		. "${OCF_FUNCTIONS_DIR}/ocf-shellfuncs"
 	elif test -e "${OCF_FUNCTIONS_DIR}/.ocf-shellfuncs" ; then
 		. "${OCF_FUNCTIONS_DIR}/.ocf-shellfuncs"
+	else
+		echo Error: ocf-shellfuncs not found
+		exit 1
 	fi
 else
 	if test -e "${OCF_ROOT}/lib/heartbeat/ocf-shellfuncs" ; then
 		. "${OCF_ROOT}/lib/heartbeat/ocf-shellfuncs"
 	elif test -e "${OCF_ROOT}/resource.d/heartbeat/.ocf-shellfuncs"; then
 		. "${OCF_ROOT}/resource.d/heartbeat/.ocf-shellfuncs"
+	else
+		echo Error: ocf-shellfuncs not found
+		exit 1
 	fi
 fi

@@ -209,7 +215,7 @@ do_drbdadm() {
 	do_cmd $DRBDADM "$@"
 	ret=$?

-	# having the version mismatch warning once per RA invokation
+	# having the version mismatch warning once per RA invocation
 	# should be enough.
 	export DRBD_DONT_WARN_ON_VERSION_MISMATCH=

@@ -334,7 +340,7 @@ drbd_update_master_score() {
 	# in case the scores given by this RA do not suffice, this is the
 	# value space you can work with:
 	# -INFINITY: Do not promote. Really. Won't work anyways.
-		# Too bad, at least with current (Oktober 2009) Pacemaker,
+		# Too bad, at least with current (October 2009) Pacemaker,
 		# negative master scores cause instance stop; restart cycle :(
 	# missing, zero: Do not promote.
 	#        I think my data is not good enough.
@@ -401,13 +407,13 @@ drbd_update_master_score() {
 		# the first time, which would cause a monitor to revoke the
 		# master score!
 		#
-		# At least some of our local disks are not really useable.
+		# At least some of our local disks are not really usable.
 		# Our peer is not all good either (or some previous case block
 		# would have matched).  We have no access to useful data.
 		# DRBD would refuse to be promoted, anyways.
 		#
 		# set_master_score -INFINITY
-		# Too bad, at least with current (Oktober 2009) Pacemaker,
+		# Too bad, at least with current (October 2009) Pacemaker,
 		# negative master scores cause instance stop; restart cycle :(
 		# Hope that this will suffice.
 		remove_master_score
@@ -687,7 +693,7 @@ drbd_stop() {
 			# Relevant for >= 8.4.
 			do_drbdadm down $DRBD_RESOURCE
 			# But ignore any return codes,
-			# we are not running, so stop is successfull.
+			# we are not running, so stop is successful.
 			rc=$OCF_SUCCESS
 			break
 			;;
@@ -715,7 +721,7 @@ drbd_notify() {
 	local n_type=$OCF_RESKEY_CRM_meta_notify_type
 	local n_op=$OCF_RESKEY_CRM_meta_notify_operation

-	# active_* and *_resource not really interessting
+	# active_* and *_resource not really interesting
 	# : "== DEBUG == active  = $OCF_RESKEY_CRM_meta_notify_active_uname"
 	: "== DEBUG == slave   = $OCF_RESKEY_CRM_meta_notify_slave_uname"
 	: "== DEBUG == master  = $OCF_RESKEY_CRM_meta_notify_master_uname"
diff --git a/scripts/drbddisk b/scripts/drbddisk
old mode 100755
new mode 100644
index f9f9822..27e315f
--- a/scripts/drbddisk
+++ b/scripts/drbddisk
@@ -2,7 +2,7 @@
 #
 # This script is inteded to be used as resource script by heartbeat
 #
-# Copright 2003-2008 LINBIT Information Technologies
+# Copyright 2003-2008 LINBIT Information Technologies
 # Philipp Reisner, Lars Ellenberg
 #
 ###
diff --git a/scripts/outdate-peer.sh b/scripts/outdate-peer.sh
old mode 100755
new mode 100644
index 684ddb4..8c72f12
--- a/scripts/outdate-peer.sh
+++ b/scripts/outdate-peer.sh
@@ -7,7 +7,7 @@
 #
 # It is expected that your clustermanager of choice brings its own
 # implementation of this ... E.g. Heartbeat's variant should be able
-# to use all of Heartbeat's communication pathes, including the
+# to use all of Heartbeat's communication paths, including the
 # serial connections.
 #

@@ -33,7 +33,7 @@
 # 4. Do this a second time for each IP address, now it should not ask
 #    any questions...
 #
-# Repeate this 4 steps for the other direction, BTW, you can not
+# Repeat this 4 steps for the other direction, BTW, you can not
 # copy the file over, since you have two distrinct keys.. and also
 # the IP addresses in the from="" part are different.
 #
diff --git a/scripts/snapshot-resync-target-lvm.sh
b/scripts/snapshot-resync-target-lvm.sh
old mode 100755
new mode 100644
index 8eec5d1..e35b8e7
--- a/scripts/snapshot-resync-target-lvm.sh
+++ b/scripts/snapshot-resync-target-lvm.sh
@@ -9,7 +9,7 @@
 ###########
 #
 # There will be no resync if this script terminates with an
-# exit code != 0. So be carefull with the exit code!
+# exit code != 0. So be careful with the exit code!
 #

 export LC_ALL=C LANG=C
diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index 33d9d28..dbed547 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -1365,11 +1365,11 @@ static void expand_common(void)
 	}
 }

-static void find_drbdcmd(char **cmd, char **pathes)
+static void find_drbdcmd(char **cmd, char **paths)
 {
 	char **path;

-	path = pathes;
+	path = paths;
 	while (*path) {
 		if (access(*path, X_OK) == 0) {
 			*cmd = *path;
@@ -3594,26 +3594,26 @@ int parse_options(int argc, char **argv,
struct adm_cmd **cmd, char ***resource_
 			break;
 		case 's':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbdsetup, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbdsetup, paths);
 			}
 			break;
 		case 'm':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbdmeta, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbdmeta, paths);
 			}
 			break;
 		case 'p':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbd_proxy_ctl, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbd_proxy_ctl, paths);
 			}
 			break;
 		case 'n':
diff --git a/user/drbdadm_parser.h b/user/drbdadm_parser.h
index 58f4f82..da24a43 100644
--- a/user/drbdadm_parser.h
+++ b/user/drbdadm_parser.h
@@ -65,7 +65,7 @@ enum yytokentype {
 	TK_NET,
 	TK_DISK,
 	TK_SKIP,
-	TK_SYNCER, /* depricated after 8.3 */
+	TK_SYNCER, /* deprecated after 8.3 */
 	TK_STARTUP,
 	TK_DISABLE_IP_VERIFICATION,
 	TK_DIALOG_REFRESH,
diff --git a/user/drbdmeta.c b/user/drbdmeta.c
index c34e6dc..ccd7f8b 100644
--- a/user/drbdmeta.c
+++ b/user/drbdmeta.c
@@ -288,7 +288,7 @@ struct format {
 	uint64_t bm_offset;

 	/* if create_md actually does convert,
-	 * we want to wipe the old meta data block _after_ convertion. */
+	 * we want to wipe the old meta data block _after_ conversion. */
 	uint64_t wipe_fixed;
 	uint64_t wipe_flex;

@@ -756,7 +756,7 @@ int v84_al_disk_to_cpu(struct al_4k_cpu *al_cpu,
struct al_4k_transaction_on_dis
 	al_cpu->context_size          = be16_to_cpu(al_disk->context_size.be);
 	al_cpu->context_start_slot_nr =
be16_to_cpu(al_disk->context_start_slot_nr.be);

-	/* reserverd al_disk->__reserved[4] */
+	/* reserved al_disk->__reserved[4] */

 	for (i=0; i < AL_UPDATES_PER_TRANSACTION; i++)
 		al_cpu->update_slot_nr[i] = be16_to_cpu(al_disk->update_slot_nr[i].be);
@@ -3437,7 +3437,7 @@ void check_internal_md_flavours(struct format * cfg) {
 	if (is_v08(cfg)) {
 		if (have_flex_v08) {
 			if (!confirmed("Do you really want to overwrite the existing v08
meta-data?")) {
-				printf("Operation cancelled.\n");
+				printf("Operation canceled.\n");
 				exit(1); // 1 to avoid online resource counting
 			}
 			/* no need to wipe flex offset,
@@ -3451,14 +3451,14 @@ void check_internal_md_flavours(struct format * cfg) {
 				md_convert_07_to_08(cfg);
 				/* goto wipe; */
 			} else if (!confirmed("So you want me to wipe out the v07 meta-data?")) {
-				printf("Operation cancelled.\n");
+				printf("Operation canceled.\n");
 				exit(1); // 1 to avoid online resource counting
 			}
 		}
 	} else { /* is_v07(cfg) */
 		if (have_fixed_v07 || have_flex_v07) {
 			if (!confirmed("Do you really want to overwrite the existing v07
meta-data?")) {
-				printf("Operation cancelled.\n");
+				printf("Operation canceled.\n");
 				exit(1); // 1 to avoid online resource counting
 			}
 			/* no need to wipe the requested flavor,
@@ -3506,7 +3506,7 @@ void check_external_md_flavours(struct format * cfg) {
 	if (cfg->md.magic) {
 		if (!confirmed("Valid meta data seems to be in place.\n"
 				"Do you really want to overwrite?")) {
-			printf("Operation cancelled.\n");
+			printf("Operation canceled.\n");
 			exit(1);
 		}
 		cfg->md.magic = 0; /* will be re-initialized below */
@@ -3524,7 +3524,7 @@ void check_external_md_flavours(struct format * cfg) {
 		}
 		if (!confirmed("So you want me to replace the v07 meta-data\n"
 				"with newly initialized v08 meta-data?")) {
-			printf("Operation cancelled.\n");
+			printf("Operation canceled.\n");
 			exit(1);
 		}
 	} else if (is_v07(cfg)) {
@@ -3538,7 +3538,7 @@ void check_external_md_flavours(struct format * cfg) {
 		}
 		if (!confirmed("So you want me to replace the v08 meta-data\n"
 				"with newly initialized v07 meta-data?")) {
-			printf("Operation cancelled.\n");
+			printf("Operation canceled.\n");
 			exit(1);
 		}
 	}
@@ -3681,7 +3681,7 @@ int meta_create_md(struct format *cfg, char
**argv __attribute((unused)), int ar
 	if (!cfg->md.magic) /* not converted: initialize */
 		err = cfg->ops->md_initialize(cfg); /* Clears on disk AL implicitly */
 	else
-		err = 0; /* we have sucessfully converted somthing */
+		err = 0; /* we have successfully converted somthing */

 	/* FIXME
 	 * if this converted fixed-size 128MB internal meta data
@@ -3717,7 +3717,7 @@ int meta_wipe_md(struct format *cfg, char **argv
__attribute((unused)), int argc
 	}

 	if (!confirmed("Do you really want to wipe out the DRBD meta data?")) {
-		printf("Operation cancelled.\n");
+		printf("Operation canceled.\n");
 		exit(1);
 	}

diff --git a/user/drbdsetup.c b/user/drbdsetup.c
index 33f2448..9d4be30 100644
--- a/user/drbdsetup.c
+++ b/user/drbdsetup.c
@@ -1665,7 +1665,7 @@ static int show_scmd(struct drbd_cmd *cm, struct
genl_info *info)
 	}
 	call_count++;

-	/* FIXME: Is the folowing check needed? */
+	/* FIXME: Is the following check needed? */
 	if (!global_attrs[DRBD_NLA_CFG_CONTEXT])
 		dbg(1, "unexpected packet, configuration context missing!\n");

diff --git a/user/drbdtool_common.c b/user/drbdtool_common.c
index 9e5f995..7de240f 100644
--- a/user/drbdtool_common.c
+++ b/user/drbdtool_common.c
@@ -536,7 +536,7 @@ char *lk_bdev_path(unsigned minor)
  * without scanning the full device for magic numbers.
  */

-/* these return 0 on sucess, error code if something goes wrong. */
+/* these return 0 on success, error code if something goes wrong. */

 /* NOTE: file format for now:
  * one line, starting with size in byte, followed by tab,
diff --git a/user/drbdtool_common.h b/user/drbdtool_common.h
index 57572e0..40c846b 100644
--- a/user/drbdtool_common.h
+++ b/user/drbdtool_common.h
@@ -101,7 +101,7 @@ struct bdev_info {
 	char *bd_name;
 };

-/* these return 0 on sucess, error code if something goes wrong. */
+/* these return 0 on success, error code if something goes wrong. */
 /* create (update) the last-known-bdev-info file */
 extern int lk_bdev_save(const unsigned minor, const struct bdev_info *bd);
 /* we may want to remove all stored information */
diff --git a/user/legacy/drbdadm_main.c b/user/legacy/drbdadm_main.c
index e31d5e2..235281b 100644
--- a/user/legacy/drbdadm_main.c
+++ b/user/legacy/drbdadm_main.c
@@ -1226,11 +1226,11 @@ static void expand_common(void)
 	}
 }

-static void find_drbdcmd(char **cmd, char **pathes)
+static void find_drbdcmd(char **cmd, char **paths)
 {
 	char **path;

-	path = pathes;
+	path = paths;
 	while (*path) {
 		if (access(*path, X_OK) == 0) {
 			*cmd = *path;
@@ -3010,26 +3010,26 @@ int parse_options(int argc, char **argv)
 			break;
 		case 's':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbdsetup, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbdsetup, paths);
 			}
 			break;
 		case 'm':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbdmeta, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbdmeta, paths);
 			}
 			break;
 		case 'p':
 			{
-				char *pathes[2];
-				pathes[0] = optarg;
-				pathes[1] = 0;
-				find_drbdcmd(&drbd_proxy_ctl, pathes);
+				char *paths[2];
+				paths[0] = optarg;
+				paths[1] = 0;
+				find_drbdcmd(&drbd_proxy_ctl, paths);
 			}
 			break;
 		case 'n':
diff --git a/user/legacy/drbdsetup.c b/user/legacy/drbdsetup.c
index bf2eb2b..33138be 100644
--- a/user/legacy/drbdsetup.c
+++ b/user/legacy/drbdsetup.c
@@ -456,7 +456,7 @@ static const char *error_messages[] = {
 	"the kernel. (Maybe you need to modprobe it, or modprobe hmac?)",
 	EM(ERR_AUTH_ALG_ND) = "The 'cram-hmac-alg' you specified is not a digest.",
 	EM(ERR_NOMEM) = "kmalloc() failed. Out of memory?",
-	EM(ERR_DISCARD) = "--discard-my-data not gllowed when primary.",
+	EM(ERR_DISCARD) = "--discard-my-data not allowed when primary.",
 	EM(ERR_DISK_CONFIGURED) = "Device is attached to a disk (use detach first)",
 	EM(ERR_NET_CONFIGURED) = "Device has a net-config (use disconnect first)",
 	EM(ERR_MANDATORY_TAG) = "UnknownMandatoryTag",
diff --git a/user/legacy/drbdtool_common.c b/user/legacy/drbdtool_common.c
index 2c7174d..323454e 100644
--- a/user/legacy/drbdtool_common.c
+++ b/user/legacy/drbdtool_common.c
@@ -560,7 +560,7 @@ char *lk_bdev_path(unsigned minor)
  * without scanning the full device for magic numbers.
  */

-/* these return 0 on sucess, error code if something goes wrong. */
+/* these return 0 on success, error code if something goes wrong. */

 /* NOTE: file format for now:
  * one line, starting with size in byte, followed by tab,
diff --git a/user/legacy/drbdtool_common.h b/user/legacy/drbdtool_common.h
index 8372640..c162eb5 100644
--- a/user/legacy/drbdtool_common.h
+++ b/user/legacy/drbdtool_common.h
@@ -104,7 +104,7 @@ struct bdev_info {
 	char *bd_name;
 };

-/* these return 0 on sucess, error code if something goes wrong. */
+/* these return 0 on success, error code if something goes wrong. */
 /* create (update) the last-known-bdev-info file */
 extern int lk_bdev_save(const unsigned minor, const struct bdev_info *bd);
 /* we may want to remove all stored information */
diff --git a/user/legacy/linux/drbd.h b/user/legacy/linux/drbd.h
index 63c0808..d2e8339 100644
--- a/user/legacy/linux/drbd.h
+++ b/user/legacy/linux/drbd.h
@@ -39,7 +39,7 @@

 /* Altough the Linux source code makes a difference between
    generic endianness and the bitfields' endianness, there is no
-   architecture as of Linux-2.6.24-rc4 where the bitfileds' endianness
+   architecture as of Linux-2.6.24-rc4 where the bitfields' endianness
    does not match the generic endianness. */

 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -178,7 +178,7 @@ enum drbd_conns {
 	/* These temporal states are all used on the way
 	 * from >= C_CONNECTED to Unconnected.
 	 * The 'disconnect reason' states
-	 * I do not allow to change beween them. */
+	 * I do not allow to change between them. */
 	C_TIMEOUT,
 	C_BROKEN_PIPE,
 	C_NETWORK_FAILURE,
@@ -230,7 +230,7 @@ union drbd_state {
  * pointed out by Maxim Uvarov q<muvarov@ru.mvista.com>
  * even though we transmit as "cpu_to_be32(state)",
  * the offsets of the bitfields still need to be swapped
- * on different endianess.
+ * on different endianness.
  */
 	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
@@ -260,7 +260,7 @@ union drbd_state {
 		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
 		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
 #else
-# error "this endianess is not supported"
+# error "this endianness is not supported"
 #endif
 #ifndef DRBD_DEBUG_STATE_CHANGES
 # ifdef CONFIG_DYNAMIC_DEBUG
diff --git a/user/legacy/linux/drbd_config.h b/user/legacy/linux/drbd_config.h
index 1a161a0..917a82f 100644
--- a/user/legacy/linux/drbd_config.h
+++ b/user/legacy/linux/drbd_config.h
@@ -103,7 +103,7 @@ extern const char *drbd_buildtag(void);

 #define KERNEL_HAS_KVEC

-/* Actually availabe since 2.6.26, but vendors have backported...
+/* Actually available since 2.6.26, but vendors have backported...
  */
 #define KERNEL_HAS_PROC_CREATE_DATA

diff --git a/user/legacy/linux/drbd_limits.h b/user/legacy/linux/drbd_limits.h
index 1e32193..26ab854 100644
--- a/user/legacy/linux/drbd_limits.h
+++ b/user/legacy/linux/drbd_limits.h
@@ -43,7 +43,7 @@

 /* net { */
   /* timeout, unit centi seconds
-   * more than one minute timeout is not usefull */
+   * more than one minute timeout is not useful */
 #define DRBD_TIMEOUT_MIN 1
 #define DRBD_TIMEOUT_MAX 600
 #define DRBD_TIMEOUT_DEF 60       /* 6 seconds */
@@ -73,7 +73,7 @@
 #define DRBD_MAX_EPOCH_SIZE_MAX 20000
 #define DRBD_MAX_EPOCH_SIZE_DEF 2048

-  /* I don't think that a tcp send buffer of more than 10M is usefull */
+  /* I don't think that a tcp send buffer of more than 10M is useful */
 #define DRBD_SNDBUF_SIZE_MIN  0
 #define DRBD_SNDBUF_SIZE_MAX  (10<<20)
 #define DRBD_SNDBUF_SIZE_DEF  0
@@ -106,7 +106,7 @@
 #define DRBD_RATE_MAX (4 << 20)
 #define DRBD_RATE_DEF 250  /* kb/second */

-  /* less than 7 would hit performance unneccessarily.
+  /* less than 7 would hit performance unnecessarily.
    * 3833 is the largest prime that still does fit
    * into 64 sectors of activity log */
 #define DRBD_AL_EXTENTS_MIN  7
diff --git a/user/legacy/unaligned.h b/user/legacy/unaligned.h
index eb9afd3..bb66239 100644
--- a/user/legacy/unaligned.h
+++ b/user/legacy/unaligned.h
@@ -24,7 +24,7 @@
 /* on some architectures we have to do it in program code */

 /* Better not use memcpy(). gcc generates broken code an ARM at higher
-   optimisation levels
+   optimization levels
 */

 #define __bad_unaligned_access_size() ({			\
diff --git a/user/libgenl.c b/user/libgenl.c
index c70427f..bbc84e0 100644
--- a/user/libgenl.c
+++ b/user/libgenl.c
@@ -473,7 +473,7 @@ static int validate_nla(struct nlattr *nla, int maxtype,
  *
  * Validates all attributes in the specified attribute stream against the
  * specified policy. Attributes with a type exceeding maxtype will be
- * ignored. See documenation of struct nla_policy for more details.
+ * ignored. See documentation of struct nla_policy for more details.
  *
  * Returns 0 on success or a negative error code.
  */
@@ -495,7 +495,7 @@ errout:
 }

 /**
- * nla_policy_len - Determin the max. length of a policy
+ * nla_policy_len - Determine the max. length of a policy
  * @policy: policy to use
  * @n: number of policies
  *
@@ -529,7 +529,7 @@ nla_policy_len(const struct nla_policy *p, int n)
  * @policy: validation policy
  *
  * Parses a stream of attributes and stores a pointer to each attribute in
- * the tb array accessable via the attribute type. Attributes with a type
+ * the tb array accessible via the attribute type. Attributes with a type
  * exceeding maxtype will be silently ignored for backwards compatibility
  * reasons. policy may be set to NULL if no validation is required.
  *
diff --git a/user/libgenl.h b/user/libgenl.h
index a37493a..272bff4 100644
--- a/user/libgenl.h
+++ b/user/libgenl.h
@@ -136,7 +136,7 @@ static inline void *msg_put(struct msg_buff *msg,
unsigned int len)
  *   nlmsg_new()			create a new netlink message
  *   nlmsg_put()			add a netlink message to an msg
  *   nlmsg_put_answer()			callback based nlmsg_put()
- *   nlmsg_end()			finanlize netlink message
+ *   nlmsg_end()			finalize netlink message
  *   nlmsg_get_pos()			return current position in message
  *   nlmsg_trim()			trim part of message
  *   nlmsg_cancel()			cancel message construction
@@ -253,7 +253,7 @@ static inline void *msg_put(struct msg_buff *msg,
unsigned int len)
  *   nla_find()				find attribute in stream of attributes
  *   nla_find_nested()			find attribute in nested attributes
  *   nla_parse()			parse and validate stream of attrs
- *   nla_parse_nested()			parse nested attribuets
+ *   nla_parse_nested()			parse nested attributes
  *   nla_for_each_attr()		loop over all attributes
  *   nla_for_each_nested()		loop over the nested attributes
  *=========================================================================
@@ -462,7 +462,7 @@ static inline int nlmsg_parse(const struct
nlmsghdr *nlh, int hdrlen,
 /**
  * nlmsg_find_attr - find a specific attribute in a netlink message
  * @nlh: netlink message header
- * @hdrlen: length of familiy specific header
+ * @hdrlen: length of family specific header
  * @attrtype: type of attribute to look for
  *
  * Returns the first attribute which matches the specified type.
@@ -476,8 +476,8 @@ static inline struct nlattr
*nlmsg_find_attr(struct nlmsghdr *nlh,

 /**
  * nlmsg_validate - validate a netlink message including attributes
- * @nlh: netlinket message header
- * @hdrlen: length of familiy specific header
+ * @nlh: netlink message header
+ * @hdrlen: length of family specific header
  * @maxtype: maximum attribute type to be expected
  * @policy: validation policy
  */
@@ -506,7 +506,7 @@ static inline int nlmsg_report(const struct nlmsghdr *nlh)
  * nlmsg_for_each_attr - iterate over a stream of attributes
  * @pos: loop counter, set to current attribute
  * @nlh: netlink message header
- * @hdrlen: length of familiy specific header
+ * @hdrlen: length of family specific header
  * @rem: initialized to len, holds bytes currently remaining in stream
  */
 #define nlmsg_for_each_attr(pos, nlh, hdrlen, rem) \
@@ -877,7 +877,7 @@ static inline int nla_nest_end(struct msg_buff
*msg, struct nlattr *start)
  *
  * Validates all attributes in the nested attribute stream against the
  * specified policy. Attributes with a type exceeding maxtype will be
- * ignored. See documenation of struct nla_policy for more details.
+ * ignored. See documentation of struct nla_policy for more details.
  *
  * Returns 0 on success or a negative error code.
  */
@@ -923,7 +923,7 @@ struct genl_multicast_group

 /**
  * struct genl_family - generic netlink family
- * @id: protocol family idenfitier
+ * @id: protocol family identifier
  * @hdrsize: length of user specific header in bytes
  * @name: name of family
  * @version: protocol version

--000e0ce0d65e39623a04c4034810
Content-Type: application/octet-stream; name="spelling.patch"
Content-Disposition: attachment; filename="spelling.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h48lrgle0

ZGlmZiAtLWdpdCBhL0NoYW5nZUxvZyBiL0NoYW5nZUxvZwppbmRleCA0NTNlOTAwLi45YTQ3ZmI0
IDEwMDY0NAotLS0gYS9DaGFuZ2VMb2cKKysrIGIvQ2hhbmdlTG9nCkBAIC0xMjksMTQgKzEyOSwx
NCBAQCBMYXRlc3Q6CiAgKiBGaXhlZCBzdXBwb3J0IGZvciBkZXZpY2VzIHdpdGggNGsgaGFyZCBz
ZWN0b3Igc2l6ZSAoYWdhaW4pCiAgKiBGaXhlZCBhIHBvdGVudGlhbCBPb3BzIGluIHRoZSBkaXNj
b25uZWN0IGNvZGUKICAqIEZpeGVkIGEgcmFjZSBjb25kaXRpb24gdGhhdCBjb3VsZCBjYXVzZSBE
UkJEIHRvIGNvbnNpZGVyIHRoZSBwZWVycyBkaXNrCi0gICBhcyBJbmNvbnN0ZW50IGFmdGVyIHJl
c3luYyBpbnN0ZWFkIG9mIFVwVG9EYXRlIChCdWd6IDI3MSkKKyAgIGFzIEluY29uc2lzdGVudCBh
ZnRlciByZXN5bmMgaW5zdGVhZCBvZiBVcFRvRGF0ZSAoQnVneiAyNzEpCiAgKiBGaXhlZCBhIHJl
YWNlIGNvbmRpdGlvbiB0aGF0IGNvdWxkIGNhdXNlIERSQkQgdG8gY29uc2lkZXIgdGhlIHBlZXJz
IGRpc2sKICAgIGFzIE91dGRhdGVkIGluc3RlYWQgb2YgSW5jb25zaXN0ZW50IGR1cmluZyByZXN5
bmMgKEJ1Z3ogMjc3KQogICogRGlzYWxsb3cgdG8gc3RhcnQgYSByZXN5bmMgd2l0aCBpbnZhbGlk
YXRlIC8gaW52YWxpZGF0ZS1yZW1vdGUgd2hlbiB0aGUKICAgIHNvdXJjZSBkaXNrIGlzIG5vdCBV
cFRvRGF0ZQogICogRm9yY2luZyBwcmltYXJ5IHdvcmtzIG5vdyBhbHNvIGZvciBDb25zaXN0ZW50
LCBub3Qgb25seSBmb3IgT3V0ZGF0ZWQgYW5kCiAgICBJbmNvbnNpc3RlbnQgKEJ1Z3ogMjY2KQot
ICogSW1wcm92ZWQgcm9idXN0bmVzcyBhZ2FpbnN0IGNvcnJ1cHQgb3IgbWFsaWNvdXMgc2VjdG9y
IGFkZHJlc3NlcyB3aGVuCisgKiBJbXByb3ZlZCByb2J1c3RuZXNzIGFnYWluc3QgY29ycnVwdCBv
ciBtYWxpY2lvdXMgc2VjdG9yIGFkZHJlc3NlcyB3aGVuCiAgICByZWNlaXZpbmcgZGF0YQogICog
QWRkZWQgdGhlIGluaXRpYWwtc3BsaXQtYnJhaW4sIGl0IGdldHMgY2FsbGVkIGFsc28gaWYgdGhl
IHNwbGl0LWJyYWluIGdldHMKICAgIGF1dG9tYXRpY2FsbHkgcmVzb2x2ZWQKQEAgLTE3NCw3ICsx
NzQsNyBAQCBMYXRlc3Q6CiAgICByZXN5bmMgaXMgbm90IHBvc3NpYmxlIGJ1dCBhIGZ1bGwgcmVz
eW5jIGlzIG5lY2Vzc2FyeS4gSGFwcGVucyB2ZXJ5IHJhcmVseS4KICAgIChCdWd6IDI2MCkKICAq
IERvIG5vdCBkcm9wIGludG8gU3RhbmRBbG9uZSBtb2RlIHdoZW4gY29ubmVjdGlvbiBpcyBsb3N0
IGR1cmluZyBhdXRoZW50aWNhdGlvbgotICogQ29ycmVjdGVkIGEgbnVsbCB0ZXN0IGluIHRoZSBh
dXRoZW50aWNhdGlvbiBjb2RlLCBmb3VuZCBieSBjb25jY2luZWxsZSwKKyAqIENvcnJlY3RlZCBh
IG51bGwgdGVzdCBpbiB0aGUgYXV0aGVudGljYXRpb24gY29kZSwgZm91bmQgYnkgY29jY2luZWxs
ZSwKICAgIHRoYW5rcyB0byB1cHN0cmVhbSBpbnRlZ3JhdGlvbi4gVGhlIGNoYW5jZSB0byB0cmln
Z2VyIHRoYXQgd2FzIHByb2JhYmx5IDEwXi05LgogICogY3JtLWZlbmNlLXBlZXIuc2ggaXMgbm93
IGFsc28gdXNhYmxlIGlmIERSQkQgaXMgbWFuYWdlZCBmcm9tIHRoZSB4ZW4gYmxvY2sKICAgIGhl
bHBlciBzY3JpcHQKQEAgLTI4NSw3ICsyODUsNyBAQCBMYXRlc3Q6CiA4LjMuMCAoYXBpOjg4L3By
b3RvOjg2LTg5KQogLS0tLS0tLS0KICAqIEZpeGVkICdzbGVlcCB3aXRoIHNwaW5sb2NrIGhlbGQn
IGluIGNhc2Ugb25saW5lIHZlcmlmeSBmb3VuZCBhIGRpZmZlcmVuY2UKLSAqIEZpeGVkIGVycm9y
IGNvZGUgcGF0aGVzIGluIHJlcXVlc3QgcHJvY2Vzc2luZy4KKyAqIEZpeGVkIGVycm9yIGNvZGUg
cGF0aHMgaW4gcmVxdWVzdCBwcm9jZXNzaW5nLgogICogRml4IGZvciBzdGFjayBzbWFzaGluZyBp
biBkcmJkbWV0YQogICogRml4ZWQgYSBidWcgdGhhdCBjb3VsZCBsZWFkIHRvIGEgY3Jhc2ggd2hl
biBkZXRhY2hpbmcvYXR0YWNoaW5nCiAgICBvbiB0aGUgcHJpbWFyeSB1bmRlciBoZWF2eSBJTyAo
QnVneiAxNzEpCkBAIC00MDQsNyArNDA0LDcgQEAgQ2hhbmdlbG9nIGZvciBmaXhlcyBwcm9wYWdh
dGVkIGZyb20gOC4wLng6CiAtLS0tLS0tLQogICogQWRkaW5nIGEgbWlzc2luZyByYW5nZSBjaGVj
ayBpbiBlbnN1cmVfbWRldigpCiAgKiBGaXggZm9yIHNldmVyYWwgcG90ZW50aWFsIG1lbW9yeSBs
ZWFrcyB3aGVuIGFsbG9jYXRpbmcgYSBkZXZpY2UgKEJ1Z3ogMTM1KQotICogRml4ZWQgZXJyb3Ig
Y29kZSBwYXRoZXMgaW4gcmVxdWVzdCBwcm9jZXNzaW5nIChCdWd6IDE0OSkKKyAqIEZpeGVkIGVy
cm9yIGNvZGUgcGF0aHMgaW4gcmVxdWVzdCBwcm9jZXNzaW5nIChCdWd6IDE0OSkKICAqIEZpeGVk
IGFuIG1pbm9yIGlzc3VlIHdpdGggdGhlIGV4cG9zZWQgZGF0YSBVVUlEIGxvZ2ljIChCdWd6IDE2
NCkKICAqIEZpeGVkIHRpZ2h0IGF0dGFjaC9kZXRhY2ggbG9vcHMgKEJ1Z3ogMTcxKQogICogRml4
ZWQgZHJiZGFkbSBhZGp1c3QsIHdoZW4gYSBydW5uaW5nIGNvbmZpZyBjb250YWlucyAiLS1kaXNj
YXJkLW15LWRhdGEiIChCdWd6IDIwMSkKQEAgLTQyMSw5ICs0MjEsOSBAQCBDaGFuZ2Vsb2cgZm9y
IGZpeGVzIHByb3BhZ2F0ZWQgZnJvbSA4LjAueDoKICAqIHJlZHVjZSByYWNlIHBvc3NpYmlsaXRp
ZXMgaW4gb3VyIHRocmVhZCByZXN0YXJ0IGNvZGUKICAqIGxpbnV4IDIuNi4yNyBjb21wYXRpYmls
aXR5CiAgKiBsYXRlbmN5IGltcHJvdmVtZW50cyB1c2luZyBUQ1BfUVVJQ0tBQ0sKLSAqIHJlZHVj
ZWQgc3B1cmlvdXMgY29kaW5nIGRpZmZlcnJlbmNlcyBiZXR3ZWVuIGRyYmQtOC4wIGFuZCBkcmJk
LTguMgorICogcmVkdWNlZCBzcHVyaW91cyBjb2RpbmcgZGlmZmVyZW5jZXMgYmV0d2VlbiBkcmJk
LTguMCBhbmQgZHJiZC04LjIKICAqIGRyYmRzZXR1cCBub3cgY2hlY2tzIGZvciAvcHJvYy9kcmJk
IGluc3RlYWQgb2YgcGxheWluZyBuZXRsaW5rIHBpbmctcG9uZwotICAgdG8gZGV0ZXJtaW4gd2hl
dGhlciB0aGUgZHJiZCBrZXJuZWwgbW9kdWxlIGlzIHByZXNlbnQuCisgICB0byBkZXRlcm1pbmUg
d2hldGhlciB0aGUgZHJiZCBrZXJuZWwgbW9kdWxlIGlzIHByZXNlbnQuCiAgKiBmaXhlZCAoaGFy
bWxlc3MgYnV0IGFubm95aW5nKSBzdGFjayBjb3JydXB0aW9uIGluIGRyYmRhZG0KICAqIGFkanVz
dGVkIHRpbWVvdXRzIG9uICdkZXRhY2gnIGFuZCAnZG93bicKICAqIGZpeGVkIHVuaXQgY29udmVy
c2lvbiBvZiBkaXNrIHNpemUgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXIKQEAgLTQ3NCw3ICs0NzQs
NyBAQCBDaGFuZ2Vsb2cgZm9yIGZpeGVzIHByb3BhZ2F0ZWQgZnJvbSA4LjAueDoKICAgIEZpeGVk
LgogICogRml4ZWQgYSByYWNlIHRoYXQgY291bGQgZGVhZGxvY2sgd29ya2VyIGFuZCByZWNlaXZl
ciB3aGlsZQogICAgZGlzY29ubmVjdGluZyBhIGRpc2tsZXNzIG5vZGUgZnJvbSBhIHByaW1hcnkg
cGVlci4KLSAqIEZpeGVkIGEgbWluaW1hbCBtZW9yeSBsZWFrLCB1cG9uIGVhY2ggbW9kdWxlIHVu
bG9hZCBvZiBEUkJELgorICogRml4ZWQgYSBtaW5pbWFsIG1lbW9yeSBsZWFrLCB1cG9uIGVhY2gg
bW9kdWxlIHVubG9hZCBvZiBEUkJELgogCiA4LjAuMTAgKGFwaTo4Ni9wcm90bzo4NikKIC0tLS0t
LS0tCmRpZmYgLS1naXQgYS9NYWtlZmlsZS5pbiBiL01ha2VmaWxlLmluCmluZGV4IGZkNmE3NDQu
LjgyMTY1NTEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLmluCisrKyBiL01ha2VmaWxlLmluCkBAIC04
NCw3ICs4NCw3IEBAIGlmZXEgKCQoV0lUSF9LTSkseWVzKQogCUBpZiAhIHRlc3QgLWUgJChLRElS
KS9NYWtlZmlsZSA7IHRoZW4gXAogCQllY2hvICIgICAgU09SUlksIGtlcm5lbCBtYWtlZmlsZSBu
b3QgZm91bmQuIiA7XAogCSAgICAgICAgZWNobyAiICAgIFlvdSBuZWVkIHRvIHRlbGwgbWUgYSBj
b3JyZWN0IEtESVIsIiA7XAotCSAgICAgICAgZWNobyAiICAgIE9yIGluc3RhbGwgdGhlIG5lY2Nl
c3Nhcnkga2VybmVsIHNvdXJjZSBwYWNrYWdlcy4iIDtcCisJICAgICAgICBlY2hvICIgICAgT3Ig
aW5zdGFsbCB0aGUgbmVjZXNzYXJ5IGtlcm5lbCBzb3VyY2UgcGFja2FnZXMuIiA7XAogCSAgICAg
ICAgZWNobyAiIiA7XAogCQlmYWxzZTtcCiAJZmkKZGlmZiAtLWdpdCBhL2JlbmNobWFyay9kbS5j
IGIvYmVuY2htYXJrL2RtLmMKaW5kZXggZDgyMjRmNy4uNjE3ZjBhZiAxMDA2NDQKLS0tIGEvYmVu
Y2htYXJrL2RtLmMKKysrIGIvYmVuY2htYXJrL2RtLmMKQEAgLTEsNyArMSw3IEBACiAvKgogICAg
ZG0uYwogCi0gICBDb3ByaWdodCAyMDAxLTIwMDggTElOQklUIEluZm9ybWF0aW9uIFRlY2hub2xv
Z2llcworICAgQ29weXJpZ2h0IDIwMDEtMjAwOCBMSU5CSVQgSW5mb3JtYXRpb24gVGVjaG5vbG9n
aWVzCiAgICBQaGlsaXBwIFJlaXNuZXIsIExhcnMgRWxsZW5iZXJnCiAKICAgIGRtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKZGlmZiAtLWdp
dCBhL2RlYmlhbi9kcmJkOC11dGlscy5wcmVybSBiL2RlYmlhbi9kcmJkOC11dGlscy5wcmVybQpp
bmRleCAxOTJhNWM1Li42NDBjZmE5IDEwMDY0NAotLS0gYS9kZWJpYW4vZHJiZDgtdXRpbHMucHJl
cm0KKysrIGIvZGViaWFuL2RyYmQ4LXV0aWxzLnByZXJtCkBAIC0xLDcgKzEsNyBAQAogIyEvYmlu
L3NoCiAKICMgVGhpcyBzY3JpcHQgc2lsZW50bHkgaWdub3JlcyB0aGUgaW5pdHNjcmlwdCByZXR1
cm4gY29kZSBpZiB3ZSByZW1vdmUKLSMgb3IgZGVjb25maWd1cmUgdGhlIHBhY2thZ2Ugb3IgY2Fy
ZWZ1bGx5IHBheSBhdHRlbnRpb24gdG8gaXQgaWYgd2UKKyMgb3IgZGVjb25maWd1cmUgdGhlIHBh
Y2thZ2Ugb3IgY2FyZWZ1bHkgcGF5IGF0dGVudGlvbiB0byBpdCBpZiB3ZQogIyB1cGdyYWRlIHRo
ZSBwYWNrYWdlLgogCiAjIEN5cmlsIEJvdXRob3JzIDxjeXJpbEBib3V0aG9ycy5vcmc+CmRpZmYg
LS1naXQgYS9kb2N1bWVudGF0aW9uL2RyYmQuY29uZi54bWwgYi9kb2N1bWVudGF0aW9uL2RyYmQu
Y29uZi54bWwKaW5kZXggOGJmODI2Ny4uMTJlNmRmOCAxMDA2NDQKLS0tIGEvZG9jdW1lbnRhdGlv
bi9kcmJkLmNvbmYueG1sCisrKyBiL2RvY3VtZW50YXRpb24vZHJiZC5jb25mLnhtbApAQCAtNDA4
LDcgKzQwOCw3IEBACiAgICAgICAgICAgICAgIDwvaXRlbWl6ZWRsaXN0PiA8b3B0aW9uPkRSQkRf
UEVFUjwvb3B0aW9uPiBpcyBkZXByZWNhdGVkLjwvcGFyYT4KIAogICAgICAgICAgICAgPHBhcmE+
UGxlYXNlIG5vdGUgdGhhdCBub3QgYWxsIG9mIHRoZXNlIG1pZ2h0IGJlIHNldCBmb3IgYWxsIGhh
bmRsZXJzLCBhbmQgdGhhdCBzb21lCi0gICAgICAgICAgICB2YWx1ZXMgbWlnaHQgbm90IGJlIHVz
ZWFibGUgZm9yIGEgPG9wdGlvbj5mbG9hdGluZzwvb3B0aW9uPiBkZWZpbml0aW9uLjwvcGFyYT4K
KyAgICAgICAgICAgIHZhbHVlcyBtaWdodCBub3QgYmUgdXNhYmxlIGZvciBhIDxvcHRpb24+Zmxv
YXRpbmc8L29wdGlvbj4gZGVmaW5pdGlvbi48L3BhcmE+CiAgICAgICAgICAgPC9saXN0aXRlbT4K
ICAgICAgICAgPC92YXJsaXN0ZW50cnk+CiAgICAgICA8L3ZhcmlhYmxlbGlzdD4KZGlmZiAtLWdp
dCBhL2RyYmQvS2J1aWxkIGIvZHJiZC9LYnVpbGQKaW5kZXggZWRkZGRkOC4uNGEwNGYyZiAxMDA2
NDQKLS0tIGEvZHJiZC9LYnVpbGQKKysrIGIvZHJiZC9LYnVpbGQKQEAgLTQsNyArNCw3IEBAIGNs
ZWFuLWZpbGVzIDo9IGNvbXBhdC5oIC5jb25maWcudGltZXN0YW1wCiAKIExJTlVYSU5DTFVERSA6
PSAtSSQoc3JjKSAkKExJTlVYSU5DTFVERSkKIAotIyBGaWxlcyBpbiB0aGUgc3RhbmRhcmQgaW5j
bHVkZSBkaXJlY3RvcmllcyB0YWtlIHByZWNlbmRlbmNlIG92ZXIgZmlsZXMKKyMgRmlsZXMgaW4g
dGhlIHN0YW5kYXJkIGluY2x1ZGUgZGlyZWN0b3JpZXMgdGFrZSBwcmVjZWRlbmNlIG92ZXIgZmls
ZXMKICMgaW4gdGhlIGNvbXBhdCBkaXJlY3RvcnkuCiAjCiAjIEFkZCAtSSQoc3JjKSB0byBFWFRS
QV9DRkxBR1MgYWdhaW46IHNvbWUgKHJoZWw1LCBtYXliZSBvdGhlcikga2J1aWxkIGRvZXMgbm90
CmRpZmYgLS1naXQgYS9kcmJkL01ha2VmaWxlIGIvZHJiZC9NYWtlZmlsZQppbmRleCAyOTIyY2Rh
Li5kYWQ2NjNkIDEwMDY0NAotLS0gYS9kcmJkL01ha2VmaWxlCisrKyBiL2RyYmQvTWFrZWZpbGUK
QEAgLTMyLDcgKzMyLDcgQEAKIERFU1RESVIgPz0gLwogCiAjIHNpbmNlIDIuNi4xNiwgS0VSTkVM
UkVMRUFTRSBtYXkgYmUgZW1wdHksCi0jIGUuZy4gd2hlbiBidWlsZGluZyBhZ2FpbnMgc29tZSAo
YnJva2VuPykgbGludXgtaGVhZGVyIHBhY2thZ2UuCisjIGUuZy4gd2hlbiBidWlsZGluZyBhZ2Fp
bnN0IHNvbWUgKGJyb2tlbj8pIGxpbnV4LWhlYWRlciBwYWNrYWdlLgogIyBMZXRzIHRlc3Qgb24g
UEFUQ0hMRVZFTCwgdGhhdCB3b24ndCBjaGFuZ2UgdG9vIHNvb24uLi4KIAogaWZuZXEgKCQoUEFU
Q0hMRVZFTCksKQpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX3JlcS5jIGIvZHJiZC9kcmJkX3JlcS5j
CmluZGV4IDEwMmZkZWEuLjBhNzU0ZTggMTAwNjQ0Ci0tLSBhL2RyYmQvZHJiZF9yZXEuYworKysg
Yi9kcmJkL2RyYmRfcmVxLmMKQEAgLTM3Niw3ICszNzYsNyBAQCB2b2lkIHJlcV9tYXlfYmVfY29t
cGxldGVkKHN0cnVjdCBkcmJkX3JlcXVlc3QgKnJlcSwgc3RydWN0IGJpb19hbmRfZXJyb3IgKm0p
CiAJCQlyZXEtPm1hc3Rlcl9iaW8gPSBOVUxMOwogCQl9IGVsc2UgewogCQkJLyogQXNzZXJ0IHRo
YXQgdGhpcyB3aWxsIGJlIF9yZXFfaXNfZG9uZSgpCi0JCQkgKiB3aXRoIHRoaXMgdmVyeSBpbnZv
a2F0aW9uLiAqLworCQkJICogd2l0aCB0aGlzIHZlcnkgaW52b2NhdGlvbi4gKi8KIAkJCS8qIEZJ
WE1FOgogCQkJICogd2hhdCBhYm91dCAoUlFfTE9DQUxfUEVORElORyB8IFJRX0xPQ0FMX0FCT1JU
RUQpPwogCQkJICovCmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfc3RhdGUuaCBiL2RyYmQvZHJiZF9z
dGF0ZS5oCmluZGV4IGI5MjkwYWIuLmVjMGNkNjEgMTAwNjQ0Ci0tLSBhL2RyYmQvZHJiZF9zdGF0
ZS5oCisrKyBiL2RyYmQvZHJiZF9zdGF0ZS5oCkBAIC0xMDIsNyArMTAyLDcgQEAgdW5pb24gZHJi
ZF9kZXZfc3RhdGUgewogCQl1bnNpZ25lZCBwZWVyOjIgOyAgIC8qIDMvNAkgcHJpbWFyeS9zZWNv
bmRhcnkvdW5rbm93biAqLwogCQl1bnNpZ25lZCByb2xlOjIgOyAgIC8qIDMvNAkgcHJpbWFyeS9z
ZWNvbmRhcnkvdW5rbm93biAqLwogI2Vsc2UKLSMgZXJyb3IgInRoaXMgZW5kaWFuZXNzIGlzIG5v
dCBzdXBwb3J0ZWQiCisjIGVycm9yICJ0aGlzIGVuZGlhbm5lc3MgaXMgbm90IHN1cHBvcnRlZCIK
ICNlbmRpZgogCX07CiAJdW5zaWduZWQgaW50IGk7CmRpZmYgLS1naXQgYS9kcmJkL2xpbnV4L2Ry
YmRfZ2VubC5oIGIvZHJiZC9saW51eC9kcmJkX2dlbmwuaAppbmRleCA4MjYwMDhmLi5mNTkxNzIz
IDEwMDY0NAotLS0gYS9kcmJkL2xpbnV4L2RyYmRfZ2VubC5oCisrKyBiL2RyYmQvbGludXgvZHJi
ZF9nZW5sLmgKQEAgLTE5MCw3ICsxOTAsNyBAQCBHRU5MX3N0cnVjdChEUkJEX05MQV9TVEFURV9J
TkZPLCA4LCBzdGF0ZV9pbmZvLAogCiAJLyogVGhlc2UgYXJlIGZvciBicm9hZGNhc3QgZnJvbSBh
ZnRlciBzdGF0ZSBjaGFuZ2Ugd29yay4KIAkgKiBwcmV2X3N0YXRlIGFuZCBuZXdfc3RhdGUgYXJl
IGZyb20gdGhlIG1vbWVudCB0aGUgc3RhdGUgY2hhbmdlIHRvb2sKLQkgKiBwbGFjZSwgbmV3X3N0
YXRlIGlzIG5vdCBuZWNjZXNzYXJpbHkgdGhlIHNhbWUgYXMgY3VycmVudF9zdGF0ZSwKKwkgKiBw
bGFjZSwgbmV3X3N0YXRlIGlzIG5vdCBuZWNlc3NhcmlseSB0aGUgc2FtZSBhcyBjdXJyZW50X3N0
YXRlLAogCSAqIHRoZXJlIG1heSBoYXZlIGJlZW4gbW9yZSBzdGF0ZSBjaGFuZ2VzIHNpbmNlLiAg
V2hpY2ggd2lsbCBiZQogCSAqIGJyb2FkY2FzdGVkIHNvb24sIGluIHRoZWlyIHJlc3BlY3RpdmUg
YWZ0ZXIgc3RhdGUgY2hhbmdlIHdvcmsuICAqLwogCV9fdTMyX2ZpZWxkKDUsIERSQkRfR0VOTEFf
Rl9NQU5EQVRPUlksCXByZXZfc3RhdGUpCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmlu
IGIvc2NyaXB0cy9NYWtlZmlsZS5pbgppbmRleCA1N2VhZGZkLi5lZTM2ZWFkIDEwMDY0NAotLS0g
YS9zY3JpcHRzL01ha2VmaWxlLmluCisrKyBiL3NjcmlwdHMvTWFrZWZpbGUuaW4KQEAgLTIsNyAr
Miw3IEBACiAjCiAjIFRoaXMgZmlsZSBpcyBwYXJ0IG9mIERSQkQgYnkgUGhpbGlwcCBSZWlzbmVy
ICYgTGFycyBFbGxlbmJlcmcuCiAjCi0jIENvcHJpZ2h0IDIwMDEtMjAwOCBMSU5CSVQgSW5mb3Jt
YXRpb24gVGVjaG5vbG9naWVzCisjIENvcHlyaWdodCAyMDAxLTIwMDggTElOQklUIEluZm9ybWF0
aW9uIFRlY2hub2xvZ2llcwogIyBQaGlsaXBwIFJlaXNuZXIsIExhcnMgRWxsZW5iZXJnCiAjCiAj
IGRyYmQgaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9ibG9jay1kcmJkIGIvc2NyaXB0cy9ibG9jay1kcmJk
Cm9sZCBtb2RlIDEwMDc1NQpuZXcgbW9kZSAxMDA2NDQKaW5kZXggMDJkMzFhNS4uMjNhN2I5Mwot
LS0gYS9zY3JpcHRzL2Jsb2NrLWRyYmQKKysrIGIvc2NyaXB0cy9ibG9jay1kcmJkCkBAIC01Nywx
NiArNTcsMTYgQEAgZGlyPSQoZGlybmFtZSAiJDAiKQogLiAiJGRpci9ibG9jay1jb21tb24uc2gi
CiAKICMjCi0jIGNhbm9uaWNhbGlzZV9tb2RlIG1vZGUKKyMgY2Fub25pY2FsaXplX21vZGUgbW9k
ZQogIwogIyBUYWtlcyB0aGUgZ2l2ZW4gbW9kZSwgd2hpY2ggbWF5IGJlIHIsIHcsIHJvLCBydywg
dyEsIG9yIHJ3ISwgb3IgdmFyaWF0aW9ucwotIyB0aGVyZW9mLCBhbmQgY2Fub25pY2FsaXNlcyB0
aGVtIHRvIG9uZSBvZgorIyB0aGVyZW9mLCBhbmQgY2Fub25pY2FsaXplcyB0aGVtIHRvIG9uZSBv
ZgogIwogIyAgICdyJzogcGVyZm9ybSBjaGVja3MgZm9yIGEgbmV3IHJlYWQtb25seSBtb3VudDsK
ICMgICAndyc6IHBlcmZvcm0gY2hlY2tzIGZvciBhIHJlYWQtd3JpdGUgbW91bnQ7IG9yCiAjICAg
JyEnOiBwZXJmb3JtIG5vIGNoZWNrcyBhdCBhbGwuCiAjCi1jYW5vbmljYWxpc2VfbW9kZSgpCitj
YW5vbmljYWxpemVfbW9kZSgpCiB7CiAgIGxvY2FsIG1vZGU9IiQxIgogCkBAIC0xNzQsNyArMTc0
LDcgQEAgc2FtZV92bSgpCiBjaGVja19kZXZpY2Vfc2hhcmluZygpCiB7CiAgIGxvY2FsIGRldj0i
JDEiCi0gIGxvY2FsIG1vZGU9JChjYW5vbmljYWxpc2VfbW9kZSAiJDIiKQorICBsb2NhbCBtb2Rl
PSQoY2Fub25pY2FsaXplX21vZGUgIiQyIikKICAgbG9jYWwgcmVzdWx0CiAKICAgaWYgWyAieCRt
b2RlIiA9ICd4IScgXQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jcm0tZmVuY2UtcGVlci5zaCBiL3Nj
cmlwdHMvY3JtLWZlbmNlLXBlZXIuc2gKb2xkIG1vZGUgMTAwNzU1Cm5ldyBtb2RlIDEwMDY0NApp
bmRleCAwZjUwZjdiLi45ZTVlMDlkCi0tLSBhL3NjcmlwdHMvY3JtLWZlbmNlLXBlZXIuc2gKKysr
IGIvc2NyaXB0cy9jcm0tZmVuY2UtcGVlci5zaApAQCAtODEsNyArODEsNyBAQCBmZW5jZV9wZWVy
X2luaXQoKQogIyBzaG9vdCBpdCwganVzdCB0byBiZSBzdXJlLgogIwogIyAtLWRjLXRpbWVvdXQg
aXMgaG93IGxvbmcgd2UgdHJ5IHRvIGNvbnRhY3QgYSBEQyBiZWZvcmUgd2UgZ2l2ZSB1cC4KLSMg
VGhpcyBpcyBuZWNjZXNzYXJ5LCBiZWNhdXNlIHBsYWNpbmcgdGhlIGNvbnN0cmFpbnQgd2lsbCBm
YWlsICh3aXRoIHNvbWUKKyMgVGhpcyBpcyBuZWNlc3NhcnksIGJlY2F1c2UgcGxhY2luZyB0aGUg
Y29uc3RyYWludCB3aWxsIGZhaWwgKHdpdGggc29tZQogIyBpbnRlcm5hbCB0aW1lb3V0KSBpZiBu
byBEQyB3YXMgYXZhaWxhYmxlIHdoZW4gd2UgcmVxdWVzdCB0aGUgY29uc3RyYWludC4KICMgV2hp
Y2ggaXMgbGlrZWx5IGlmIHRoZSBEQyBjcmFzaGVkLiBUaGVuIHRoZSBzdXJ2aXZpbmcgRFJCRCBQ
cmltYXJ5IG5lZWRzCiAjIHRvIHdhaXQgZm9yIGEgbmV3IERDIHRvIGJlIGVsZWN0ZWQuIFVzdWFs
bHkgc3VjaCBlbGVjdGlvbiB0YWtlcyBvbmx5CkBAIC0xMDUsNyArMTA1LDcgQEAgZmVuY2VfcGVl
cl9pbml0KCkKICMKICMgICAgICAgSWYgcGVlciBpcyBzdGlsbCByZWFjaGFibGUgYWNjb3JkaW5n
IHRvIHRoZSBjaWIsCiAjCXdlIGZpcnN0IHBvbGwgdGhlIGNpYiB1bnRpbCB0aW1lb3V0IGhhcyBl
bGFwc2VkLAotIwlvciB0aGUgcGVlciBiZWNvbWVzIGRlZmluZXRlbHkgdW5yZWFjaGFibGUuCisj
CW9yIHRoZSBwZWVyIGJlY29tZXMgZGVmaW5pdGVseSB1bnJlYWNoYWJsZS4KICMKICMJVGhpcyBn
aXZlcyBTVE9OSVRIIHRoZSBjaGFuY2UgdG8ga2lsbCB1cy4KICMJV2l0aCAiZmVuY2luZyByZXNv
dXJjZS1hbmQtc3RvbnRpdGg7IiB0aGlzIHByb3RlY3RzIHVzIGFnYWluc3QKQEAgLTE0MSw3ICsx
NDEsNyBAQCBmZW5jZV9wZWVyX2luaXQoKQogIwlwbGFjZSB0aGUgY29uc3RyYWludCAtIGlmIHRo
ZSBwZWVyIGhhZCBiZXR0ZXIgZGF0YSwgaXQgc2hvdWxkIGhhdmUgYQogIwloaWdoZXIgbWFzdGVy
IHNjb3JlLCBhbmQgd2Ugc2hvdWxkIG5vdCBoYXZlIGJlZW4gYXNrZWQgdG8gYmVjb21lCiAjCXBy
aW1hcnkuICBJZiB0aGUgcGVlciBpcyBub3QgcmVhY2hhYmxlLCB3ZSBkb24ndCBkbyBhbnl0aGlu
ZywgYW5kIGRyYmQKLSMJd2lsbCByZWZ1c2UgdG8gYmUgcHJvbW90ZWQuIFRoaXMgaXMgbmVjY2Vz
c2FyeSB0byBhdm9pZCBwcm9ibGVtcworIwl3aWxsIHJlZnVzZSB0byBiZSBwcm9tb3RlZC4gVGhp
cyBpcyBuZWNlc3NhcnkgdG8gYXZvaWQgcHJvYmxlbXMKICMJV2l0aCBkYXRhIGRpdmVyc2lvbiwg
aW4gY2FzZSB0aGlzICJjcmFzaCIgd2FzIGR1ZSB0byBhIFNUT05JVEggb3BlcmF0aW9uLAogIwlt
YXliZSB0aGUgcmVib290IGRpZCBub3QgZml4IG91ciBjbHVzdGVyIGNvbW11bmljYXRpb25zIQog
IwpAQCAtMjQ0LDcgKzI0NCw3IEBAIGRyYmRfcGVlcl9mZW5jaW5nKCkKIAkJaWYgW1sgLXogJGhh
dmVfY29uc3RyYWludCBdXSA7IHRoZW4KIAkJCSMgdHJ5IHRvIHBsYWNlIGl0LgogCi0JCQkjIGlu
dGVyZXNzdGluZzoKKwkJCSMgaW50ZXJlc3Rpbmc6CiAJCQkjIEluIGNhc2UgdGhpcyBpcyBhIHR3
by1ub2RlIGNsdXN0ZXIgKHN0aWxsIGNvbW1vbiB3aXRoCiAJCQkjIGRyYmQgY2x1c3RlcnMpIGl0
IGRvZXMgbm90IGhhdmUgcmVhbCBxdW9ydW0uCiAJCQkjIElmIGl0IGlzIGNvbmZpZ3VyZWQgdG8g
ZG8gc3Rvbml0aCwgYW5kIHJlYm9vdCwKQEAgLTM2MSw3ICszNjEsNyBAQCBjaGVja19wZWVyX25v
ZGVfcmVhY2hhYmxlKCkKIAkJbnJfb3RoZXJfbm9kZXM9JChlY2hvICIkc3RhdGVfbGluZXMiIHwg
Z3JlcCAtdiAtRiB1bmFtZT1cIiRIT1NUTkFNRVwiIHwgd2MgLWwpCiAJCWlmIFtbICRucl9vdGhl
cl9ub2RlcyAtZ3QgMSBdXTsgdGhlbgogCQkJIyBNYW55IG5vZGVzIGNsdXN0ZXIsIGxvb2sgYXQg
JERSQkRfUEVFUiwgaWYgc2V0LgotCQkJIyBOb3RlIHRoYXQgdGhpcyBzaG91bGQgbm90IGJlIG5l
Y2Nlc3NhcnkuICBUaGUgcHJvYmxlbQorCQkJIyBOb3RlIHRoYXQgdGhpcyBzaG91bGQgbm90IGJl
IG5lY2Vzc2FyeS4gIFRoZSBwcm9ibGVtCiAJCQkjIHdlIHRyeSB0byBzb2x2ZSBpcyByZWxldmFu
dCBvbiB0d28tbm9kZSBjbHVzdGVycwogCQkJIyAobm8gcmVhbCBxdW9ydW0pCiAJCQlpZiBbWyAk
RFJCRF9QRUVSIF1dOyB0aGVuCmRpZmYgLS1naXQgYS9zY3JpcHRzL2RyYmQuZ2VudG9vIGIvc2Ny
aXB0cy9kcmJkLmdlbnRvbwppbmRleCBkMzRjYWFhLi4xYzJiMjk1IDEwMDY0NAotLS0gYS9zY3Jp
cHRzL2RyYmQuZ2VudG9vCisrKyBiL3NjcmlwdHMvZHJiZC5nZW50b28KQEAgLTEsNiArMSw2IEBA
CiAjIS9zYmluL3J1bnNjcmlwdAogIyBEaXN0cmlidXRlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHYyCi0jIENvcHJpZ2h0IDIwMDEtMjAwOCBMSU5C
SVQgSW5mb3JtYXRpb24gVGVjaG5vbG9naWVzCisjIENvcHlyaWdodCAyMDAxLTIwMDggTElOQklU
IEluZm9ybWF0aW9uIFRlY2hub2xvZ2llcwogIyBQaGlsaXBwIFJlaXNuZXIsIExhcnMgRWxsZW5i
ZXJnCiAjIE9yaWdpbmFsIHNjcmlwdCBhZGFwdGVkIHRvIGdlbnRvbyBlbnZpcm9ubWVudAogCmRp
ZmYgLS1naXQgYS9zY3JpcHRzL2RyYmQub2NmIGIvc2NyaXB0cy9kcmJkLm9jZgpvbGQgbW9kZSAx
MDA2NDQKbmV3IG1vZGUgMTAwNzU1CmluZGV4IDdkM2UwZjEuLjljNWRmMzAKLS0tIGEvc2NyaXB0
cy9kcmJkLm9jZgorKysgYi9zY3JpcHRzL2RyYmQub2NmCkBAIC01MywxMiArNTMsMTggQEAgaWYg
dGVzdCAtbiAiJHtPQ0ZfRlVOQ1RJT05TX0RJUn0iIDsgdGhlbgogCQkuICIke09DRl9GVU5DVElP
TlNfRElSfS9vY2Ytc2hlbGxmdW5jcyIKIAllbGlmIHRlc3QgLWUgIiR7T0NGX0ZVTkNUSU9OU19E
SVJ9Ly5vY2Ytc2hlbGxmdW5jcyIgOyB0aGVuCiAJCS4gIiR7T0NGX0ZVTkNUSU9OU19ESVJ9Ly5v
Y2Ytc2hlbGxmdW5jcyIKKwllbHNlCisJCWVjaG8gRXJyb3I6IG9jZi1zaGVsbGZ1bmNzIG5vdCBm
b3VuZAorCQlleGl0IDEKIAlmaQogZWxzZQogCWlmIHRlc3QgLWUgIiR7T0NGX1JPT1R9L2xpYi9o
ZWFydGJlYXQvb2NmLXNoZWxsZnVuY3MiIDsgdGhlbgogCQkuICIke09DRl9ST09UfS9saWIvaGVh
cnRiZWF0L29jZi1zaGVsbGZ1bmNzIgogCWVsaWYgdGVzdCAtZSAiJHtPQ0ZfUk9PVH0vcmVzb3Vy
Y2UuZC9oZWFydGJlYXQvLm9jZi1zaGVsbGZ1bmNzIjsgdGhlbgogCQkuICIke09DRl9ST09UfS9y
ZXNvdXJjZS5kL2hlYXJ0YmVhdC8ub2NmLXNoZWxsZnVuY3MiCisJZWxzZQorCQllY2hvIEVycm9y
OiBvY2Ytc2hlbGxmdW5jcyBub3QgZm91bmQKKwkJZXhpdCAxCiAJZmkKIGZpCiAKQEAgLTIwOSw3
ICsyMTUsNyBAQCBkb19kcmJkYWRtKCkgewogCWRvX2NtZCAkRFJCREFETSAiJEAiCiAJcmV0PSQ/
CiAKLQkjIGhhdmluZyB0aGUgdmVyc2lvbiBtaXNtYXRjaCB3YXJuaW5nIG9uY2UgcGVyIFJBIGlu
dm9rYXRpb24KKwkjIGhhdmluZyB0aGUgdmVyc2lvbiBtaXNtYXRjaCB3YXJuaW5nIG9uY2UgcGVy
IFJBIGludm9jYXRpb24KIAkjIHNob3VsZCBiZSBlbm91Z2guCiAJZXhwb3J0IERSQkRfRE9OVF9X
QVJOX09OX1ZFUlNJT05fTUlTTUFUQ0g9CiAKQEAgLTMzNCw3ICszNDAsNyBAQCBkcmJkX3VwZGF0
ZV9tYXN0ZXJfc2NvcmUoKSB7CiAJIyBpbiBjYXNlIHRoZSBzY29yZXMgZ2l2ZW4gYnkgdGhpcyBS
QSBkbyBub3Qgc3VmZmljZSwgdGhpcyBpcyB0aGUKIAkjIHZhbHVlIHNwYWNlIHlvdSBjYW4gd29y
ayB3aXRoOgogCSMgLUlORklOSVRZOiBEbyBub3QgcHJvbW90ZS4gUmVhbGx5LiBXb24ndCB3b3Jr
IGFueXdheXMuCi0JCSMgVG9vIGJhZCwgYXQgbGVhc3Qgd2l0aCBjdXJyZW50IChPa3RvYmVyIDIw
MDkpIFBhY2VtYWtlciwKKwkJIyBUb28gYmFkLCBhdCBsZWFzdCB3aXRoIGN1cnJlbnQgKE9jdG9i
ZXIgMjAwOSkgUGFjZW1ha2VyLAogCQkjIG5lZ2F0aXZlIG1hc3RlciBzY29yZXMgY2F1c2UgaW5z
dGFuY2Ugc3RvcDsgcmVzdGFydCBjeWNsZSA6KAogCSMgbWlzc2luZywgemVybzogRG8gbm90IHBy
b21vdGUuCiAJIyAgICAgICAgSSB0aGluayBteSBkYXRhIGlzIG5vdCBnb29kIGVub3VnaC4KQEAg
LTQwMSwxMyArNDA3LDEzIEBAIGRyYmRfdXBkYXRlX21hc3Rlcl9zY29yZSgpIHsKIAkJIyB0aGUg
Zmlyc3QgdGltZSwgd2hpY2ggd291bGQgY2F1c2UgYSBtb25pdG9yIHRvIHJldm9rZSB0aGUKIAkJ
IyBtYXN0ZXIgc2NvcmUhCiAJCSMKLQkJIyBBdCBsZWFzdCBzb21lIG9mIG91ciBsb2NhbCBkaXNr
cyBhcmUgbm90IHJlYWxseSB1c2VhYmxlLgorCQkjIEF0IGxlYXN0IHNvbWUgb2Ygb3VyIGxvY2Fs
IGRpc2tzIGFyZSBub3QgcmVhbGx5IHVzYWJsZS4KIAkJIyBPdXIgcGVlciBpcyBub3QgYWxsIGdv
b2QgZWl0aGVyIChvciBzb21lIHByZXZpb3VzIGNhc2UgYmxvY2sKIAkJIyB3b3VsZCBoYXZlIG1h
dGNoZWQpLiAgV2UgaGF2ZSBubyBhY2Nlc3MgdG8gdXNlZnVsIGRhdGEuCiAJCSMgRFJCRCB3b3Vs
ZCByZWZ1c2UgdG8gYmUgcHJvbW90ZWQsIGFueXdheXMuCiAJCSMKIAkJIyBzZXRfbWFzdGVyX3Nj
b3JlIC1JTkZJTklUWQotCQkjIFRvbyBiYWQsIGF0IGxlYXN0IHdpdGggY3VycmVudCAoT2t0b2Jl
ciAyMDA5KSBQYWNlbWFrZXIsCisJCSMgVG9vIGJhZCwgYXQgbGVhc3Qgd2l0aCBjdXJyZW50IChP
Y3RvYmVyIDIwMDkpIFBhY2VtYWtlciwKIAkJIyBuZWdhdGl2ZSBtYXN0ZXIgc2NvcmVzIGNhdXNl
IGluc3RhbmNlIHN0b3A7IHJlc3RhcnQgY3ljbGUgOigKIAkJIyBIb3BlIHRoYXQgdGhpcyB3aWxs
IHN1ZmZpY2UuCiAJCXJlbW92ZV9tYXN0ZXJfc2NvcmUKQEAgLTY4Nyw3ICs2OTMsNyBAQCBkcmJk
X3N0b3AoKSB7CiAJCQkjIFJlbGV2YW50IGZvciA+PSA4LjQuCiAJCQlkb19kcmJkYWRtIGRvd24g
JERSQkRfUkVTT1VSQ0UKIAkJCSMgQnV0IGlnbm9yZSBhbnkgcmV0dXJuIGNvZGVzLAotCQkJIyB3
ZSBhcmUgbm90IHJ1bm5pbmcsIHNvIHN0b3AgaXMgc3VjY2Vzc2Z1bGwuCisJCQkjIHdlIGFyZSBu
b3QgcnVubmluZywgc28gc3RvcCBpcyBzdWNjZXNzZnVsLgogCQkJcmM9JE9DRl9TVUNDRVNTCiAJ
CQlicmVhawogCQkJOzsKQEAgLTcxNSw3ICs3MjEsNyBAQCBkcmJkX25vdGlmeSgpIHsKIAlsb2Nh
bCBuX3R5cGU9JE9DRl9SRVNLRVlfQ1JNX21ldGFfbm90aWZ5X3R5cGUKIAlsb2NhbCBuX29wPSRP
Q0ZfUkVTS0VZX0NSTV9tZXRhX25vdGlmeV9vcGVyYXRpb24KIAotCSMgYWN0aXZlXyogYW5kICpf
cmVzb3VyY2Ugbm90IHJlYWxseSBpbnRlcmVzc3RpbmcKKwkjIGFjdGl2ZV8qIGFuZCAqX3Jlc291
cmNlIG5vdCByZWFsbHkgaW50ZXJlc3RpbmcKIAkjIDogIj09IERFQlVHID09IGFjdGl2ZSAgPSAk
T0NGX1JFU0tFWV9DUk1fbWV0YV9ub3RpZnlfYWN0aXZlX3VuYW1lIgogCTogIj09IERFQlVHID09
IHNsYXZlICAgPSAkT0NGX1JFU0tFWV9DUk1fbWV0YV9ub3RpZnlfc2xhdmVfdW5hbWUiCiAJOiAi
PT0gREVCVUcgPT0gbWFzdGVyICA9ICRPQ0ZfUkVTS0VZX0NSTV9tZXRhX25vdGlmeV9tYXN0ZXJf
dW5hbWUiCmRpZmYgLS1naXQgYS9zY3JpcHRzL2RyYmRkaXNrIGIvc2NyaXB0cy9kcmJkZGlzawpv
bGQgbW9kZSAxMDA3NTUKbmV3IG1vZGUgMTAwNjQ0CmluZGV4IGY5Zjk4MjIuLjI3ZTMxNWYKLS0t
IGEvc2NyaXB0cy9kcmJkZGlzaworKysgYi9zY3JpcHRzL2RyYmRkaXNrCkBAIC0yLDcgKzIsNyBA
QAogIwogIyBUaGlzIHNjcmlwdCBpcyBpbnRlZGVkIHRvIGJlIHVzZWQgYXMgcmVzb3VyY2Ugc2Ny
aXB0IGJ5IGhlYXJ0YmVhdAogIwotIyBDb3ByaWdodCAyMDAzLTIwMDggTElOQklUIEluZm9ybWF0
aW9uIFRlY2hub2xvZ2llcworIyBDb3B5cmlnaHQgMjAwMy0yMDA4IExJTkJJVCBJbmZvcm1hdGlv
biBUZWNobm9sb2dpZXMKICMgUGhpbGlwcCBSZWlzbmVyLCBMYXJzIEVsbGVuYmVyZwogIwogIyMj
CmRpZmYgLS1naXQgYS9zY3JpcHRzL291dGRhdGUtcGVlci5zaCBiL3NjcmlwdHMvb3V0ZGF0ZS1w
ZWVyLnNoCm9sZCBtb2RlIDEwMDc1NQpuZXcgbW9kZSAxMDA2NDQKaW5kZXggNjg0ZGRiNC4uOGM3
MmYxMgotLS0gYS9zY3JpcHRzL291dGRhdGUtcGVlci5zaAorKysgYi9zY3JpcHRzL291dGRhdGUt
cGVlci5zaApAQCAtNyw3ICs3LDcgQEAKICMKICMgSXQgaXMgZXhwZWN0ZWQgdGhhdCB5b3VyIGNs
dXN0ZXJtYW5hZ2VyIG9mIGNob2ljZSBicmluZ3MgaXRzIG93bgogIyBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGlzIC4uLiBFLmcuIEhlYXJ0YmVhdCdzIHZhcmlhbnQgc2hvdWxkIGJlIGFibGUKLSMgdG8g
dXNlIGFsbCBvZiBIZWFydGJlYXQncyBjb21tdW5pY2F0aW9uIHBhdGhlcywgaW5jbHVkaW5nIHRo
ZQorIyB0byB1c2UgYWxsIG9mIEhlYXJ0YmVhdCdzIGNvbW11bmljYXRpb24gcGF0aHMsIGluY2x1
ZGluZyB0aGUKICMgc2VyaWFsIGNvbm5lY3Rpb25zLgogIwogCkBAIC0zMyw3ICszMyw3IEBACiAj
IDQuIERvIHRoaXMgYSBzZWNvbmQgdGltZSBmb3IgZWFjaCBJUCBhZGRyZXNzLCBub3cgaXQgc2hv
dWxkIG5vdCBhc2sKICMgICAgYW55IHF1ZXN0aW9ucy4uLgogIwotIyBSZXBlYXRlIHRoaXMgNCBz
dGVwcyBmb3IgdGhlIG90aGVyIGRpcmVjdGlvbiwgQlRXLCB5b3UgY2FuIG5vdAorIyBSZXBlYXQg
dGhpcyA0IHN0ZXBzIGZvciB0aGUgb3RoZXIgZGlyZWN0aW9uLCBCVFcsIHlvdSBjYW4gbm90CiAj
IGNvcHkgdGhlIGZpbGUgb3Zlciwgc2luY2UgeW91IGhhdmUgdHdvIGRpc3RyaW5jdCBrZXlzLi4g
YW5kIGFsc28KICMgdGhlIElQIGFkZHJlc3NlcyBpbiB0aGUgZnJvbT0iIiBwYXJ0IGFyZSBkaWZm
ZXJlbnQuCiAjCmRpZmYgLS1naXQgYS9zY3JpcHRzL3NuYXBzaG90LXJlc3luYy10YXJnZXQtbHZt
LnNoIGIvc2NyaXB0cy9zbmFwc2hvdC1yZXN5bmMtdGFyZ2V0LWx2bS5zaApvbGQgbW9kZSAxMDA3
NTUKbmV3IG1vZGUgMTAwNjQ0CmluZGV4IDhlZWM1ZDEuLmUzNWI4ZTcKLS0tIGEvc2NyaXB0cy9z
bmFwc2hvdC1yZXN5bmMtdGFyZ2V0LWx2bS5zaAorKysgYi9zY3JpcHRzL3NuYXBzaG90LXJlc3lu
Yy10YXJnZXQtbHZtLnNoCkBAIC05LDcgKzksNyBAQAogIyMjIyMjIyMjIyMKICMKICMgVGhlcmUg
d2lsbCBiZSBubyByZXN5bmMgaWYgdGhpcyBzY3JpcHQgdGVybWluYXRlcyB3aXRoIGFuCi0jIGV4
aXQgY29kZSAhPSAwLiBTbyBiZSBjYXJlZnVsbCB3aXRoIHRoZSBleGl0IGNvZGUhCisjIGV4aXQg
Y29kZSAhPSAwLiBTbyBiZSBjYXJlZnVsIHdpdGggdGhlIGV4aXQgY29kZSEKICMKIAogZXhwb3J0
IExDX0FMTD1DIExBTkc9QwpkaWZmIC0tZ2l0IGEvdXNlci9kcmJkYWRtX21haW4uYyBiL3VzZXIv
ZHJiZGFkbV9tYWluLmMKaW5kZXggMzNkOWQyOC4uZGJlZDU0NyAxMDA2NDQKLS0tIGEvdXNlci9k
cmJkYWRtX21haW4uYworKysgYi91c2VyL2RyYmRhZG1fbWFpbi5jCkBAIC0xMzY1LDExICsxMzY1
LDExIEBAIHN0YXRpYyB2b2lkIGV4cGFuZF9jb21tb24odm9pZCkKIAl9CiB9CiAKLXN0YXRpYyB2
b2lkIGZpbmRfZHJiZGNtZChjaGFyICoqY21kLCBjaGFyICoqcGF0aGVzKQorc3RhdGljIHZvaWQg
ZmluZF9kcmJkY21kKGNoYXIgKipjbWQsIGNoYXIgKipwYXRocykKIHsKIAljaGFyICoqcGF0aDsK
IAotCXBhdGggPSBwYXRoZXM7CisJcGF0aCA9IHBhdGhzOwogCXdoaWxlICgqcGF0aCkgewogCQlp
ZiAoYWNjZXNzKCpwYXRoLCBYX09LKSA9PSAwKSB7CiAJCQkqY21kID0gKnBhdGg7CkBAIC0zNTk0
LDI2ICszNTk0LDI2IEBAIGludCBwYXJzZV9vcHRpb25zKGludCBhcmdjLCBjaGFyICoqYXJndiwg
c3RydWN0IGFkbV9jbWQgKipjbWQsIGNoYXIgKioqcmVzb3VyY2VfCiAJCQlicmVhazsKIAkJY2Fz
ZSAncyc6CiAJCQl7Ci0JCQkJY2hhciAqcGF0aGVzWzJdOwotCQkJCXBhdGhlc1swXSA9IG9wdGFy
ZzsKLQkJCQlwYXRoZXNbMV0gPSAwOwotCQkJCWZpbmRfZHJiZGNtZCgmZHJiZHNldHVwLCBwYXRo
ZXMpOworCQkJCWNoYXIgKnBhdGhzWzJdOworCQkJCXBhdGhzWzBdID0gb3B0YXJnOworCQkJCXBh
dGhzWzFdID0gMDsKKwkJCQlmaW5kX2RyYmRjbWQoJmRyYmRzZXR1cCwgcGF0aHMpOwogCQkJfQog
CQkJYnJlYWs7CiAJCWNhc2UgJ20nOgogCQkJewotCQkJCWNoYXIgKnBhdGhlc1syXTsKLQkJCQlw
YXRoZXNbMF0gPSBvcHRhcmc7Ci0JCQkJcGF0aGVzWzFdID0gMDsKLQkJCQlmaW5kX2RyYmRjbWQo
JmRyYmRtZXRhLCBwYXRoZXMpOworCQkJCWNoYXIgKnBhdGhzWzJdOworCQkJCXBhdGhzWzBdID0g
b3B0YXJnOworCQkJCXBhdGhzWzFdID0gMDsKKwkJCQlmaW5kX2RyYmRjbWQoJmRyYmRtZXRhLCBw
YXRocyk7CiAJCQl9CiAJCQlicmVhazsKIAkJY2FzZSAncCc6CiAJCQl7Ci0JCQkJY2hhciAqcGF0
aGVzWzJdOwotCQkJCXBhdGhlc1swXSA9IG9wdGFyZzsKLQkJCQlwYXRoZXNbMV0gPSAwOwotCQkJ
CWZpbmRfZHJiZGNtZCgmZHJiZF9wcm94eV9jdGwsIHBhdGhlcyk7CisJCQkJY2hhciAqcGF0aHNb
Ml07CisJCQkJcGF0aHNbMF0gPSBvcHRhcmc7CisJCQkJcGF0aHNbMV0gPSAwOworCQkJCWZpbmRf
ZHJiZGNtZCgmZHJiZF9wcm94eV9jdGwsIHBhdGhzKTsKIAkJCX0KIAkJCWJyZWFrOwogCQljYXNl
ICduJzoKZGlmZiAtLWdpdCBhL3VzZXIvZHJiZGFkbV9wYXJzZXIuaCBiL3VzZXIvZHJiZGFkbV9w
YXJzZXIuaAppbmRleCA1OGY0ZjgyLi5kYTI0YTQzIDEwMDY0NAotLS0gYS91c2VyL2RyYmRhZG1f
cGFyc2VyLmgKKysrIGIvdXNlci9kcmJkYWRtX3BhcnNlci5oCkBAIC02NSw3ICs2NSw3IEBAIGVu
dW0geXl0b2tlbnR5cGUgewogCVRLX05FVCwKIAlUS19ESVNLLAogCVRLX1NLSVAsCi0JVEtfU1lO
Q0VSLCAvKiBkZXByaWNhdGVkIGFmdGVyIDguMyAqLworCVRLX1NZTkNFUiwgLyogZGVwcmVjYXRl
ZCBhZnRlciA4LjMgKi8KIAlUS19TVEFSVFVQLAogCVRLX0RJU0FCTEVfSVBfVkVSSUZJQ0FUSU9O
LAogCVRLX0RJQUxPR19SRUZSRVNILApkaWZmIC0tZ2l0IGEvdXNlci9kcmJkbWV0YS5jIGIvdXNl
ci9kcmJkbWV0YS5jCmluZGV4IGMzNGU2ZGMuLmNjZDdmOGIgMTAwNjQ0Ci0tLSBhL3VzZXIvZHJi
ZG1ldGEuYworKysgYi91c2VyL2RyYmRtZXRhLmMKQEAgLTI4OCw3ICsyODgsNyBAQCBzdHJ1Y3Qg
Zm9ybWF0IHsKIAl1aW50NjRfdCBibV9vZmZzZXQ7CiAKIAkvKiBpZiBjcmVhdGVfbWQgYWN0dWFs
bHkgZG9lcyBjb252ZXJ0LAotCSAqIHdlIHdhbnQgdG8gd2lwZSB0aGUgb2xkIG1ldGEgZGF0YSBi
bG9jayBfYWZ0ZXJfIGNvbnZlcnRpb24uICovCisJICogd2Ugd2FudCB0byB3aXBlIHRoZSBvbGQg
bWV0YSBkYXRhIGJsb2NrIF9hZnRlcl8gY29udmVyc2lvbi4gKi8KIAl1aW50NjRfdCB3aXBlX2Zp
eGVkOwogCXVpbnQ2NF90IHdpcGVfZmxleDsKIApAQCAtNzU2LDcgKzc1Niw3IEBAIGludCB2ODRf
YWxfZGlza190b19jcHUoc3RydWN0IGFsXzRrX2NwdSAqYWxfY3B1LCBzdHJ1Y3QgYWxfNGtfdHJh
bnNhY3Rpb25fb25fZGlzCiAJYWxfY3B1LT5jb250ZXh0X3NpemUgICAgICAgICAgPSBiZTE2X3Rv
X2NwdShhbF9kaXNrLT5jb250ZXh0X3NpemUuYmUpOwogCWFsX2NwdS0+Y29udGV4dF9zdGFydF9z
bG90X25yID0gYmUxNl90b19jcHUoYWxfZGlzay0+Y29udGV4dF9zdGFydF9zbG90X25yLmJlKTsK
IAotCS8qIHJlc2VydmVyZCBhbF9kaXNrLT5fX3Jlc2VydmVkWzRdICovCisJLyogcmVzZXJ2ZWQg
YWxfZGlzay0+X19yZXNlcnZlZFs0XSAqLwogCiAJZm9yIChpPTA7IGkgPCBBTF9VUERBVEVTX1BF
Ul9UUkFOU0FDVElPTjsgaSsrKQogCQlhbF9jcHUtPnVwZGF0ZV9zbG90X25yW2ldID0gYmUxNl90
b19jcHUoYWxfZGlzay0+dXBkYXRlX3Nsb3RfbnJbaV0uYmUpOwpAQCAtMzQzNyw3ICszNDM3LDcg
QEAgdm9pZCBjaGVja19pbnRlcm5hbF9tZF9mbGF2b3VycyhzdHJ1Y3QgZm9ybWF0ICogY2ZnKSB7
CiAJaWYgKGlzX3YwOChjZmcpKSB7CiAJCWlmIChoYXZlX2ZsZXhfdjA4KSB7CiAJCQlpZiAoIWNv
bmZpcm1lZCgiRG8geW91IHJlYWxseSB3YW50IHRvIG92ZXJ3cml0ZSB0aGUgZXhpc3RpbmcgdjA4
IG1ldGEtZGF0YT8iKSkgewotCQkJCXByaW50ZigiT3BlcmF0aW9uIGNhbmNlbGxlZC5cbiIpOwor
CQkJCXByaW50ZigiT3BlcmF0aW9uIGNhbmNlbGVkLlxuIik7CiAJCQkJZXhpdCgxKTsgLy8gMSB0
byBhdm9pZCBvbmxpbmUgcmVzb3VyY2UgY291bnRpbmcKIAkJCX0KIAkJCS8qIG5vIG5lZWQgdG8g
d2lwZSBmbGV4IG9mZnNldCwKQEAgLTM0NTEsMTQgKzM0NTEsMTQgQEAgdm9pZCBjaGVja19pbnRl
cm5hbF9tZF9mbGF2b3VycyhzdHJ1Y3QgZm9ybWF0ICogY2ZnKSB7CiAJCQkJbWRfY29udmVydF8w
N190b18wOChjZmcpOwogCQkJCS8qIGdvdG8gd2lwZTsgKi8KIAkJCX0gZWxzZSBpZiAoIWNvbmZp
cm1lZCgiU28geW91IHdhbnQgbWUgdG8gd2lwZSBvdXQgdGhlIHYwNyBtZXRhLWRhdGE/IikpIHsK
LQkJCQlwcmludGYoIk9wZXJhdGlvbiBjYW5jZWxsZWQuXG4iKTsKKwkJCQlwcmludGYoIk9wZXJh
dGlvbiBjYW5jZWxlZC5cbiIpOwogCQkJCWV4aXQoMSk7IC8vIDEgdG8gYXZvaWQgb25saW5lIHJl
c291cmNlIGNvdW50aW5nCiAJCQl9CiAJCX0KIAl9IGVsc2UgeyAvKiBpc192MDcoY2ZnKSAqLwog
CQlpZiAoaGF2ZV9maXhlZF92MDcgfHwgaGF2ZV9mbGV4X3YwNykgewogCQkJaWYgKCFjb25maXJt
ZWQoIkRvIHlvdSByZWFsbHkgd2FudCB0byBvdmVyd3JpdGUgdGhlIGV4aXN0aW5nIHYwNyBtZXRh
LWRhdGE/IikpIHsKLQkJCQlwcmludGYoIk9wZXJhdGlvbiBjYW5jZWxsZWQuXG4iKTsKKwkJCQlw
cmludGYoIk9wZXJhdGlvbiBjYW5jZWxlZC5cbiIpOwogCQkJCWV4aXQoMSk7IC8vIDEgdG8gYXZv
aWQgb25saW5lIHJlc291cmNlIGNvdW50aW5nCiAJCQl9CiAJCQkvKiBubyBuZWVkIHRvIHdpcGUg
dGhlIHJlcXVlc3RlZCBmbGF2b3IsCkBAIC0zNTA2LDcgKzM1MDYsNyBAQCB2b2lkIGNoZWNrX2V4
dGVybmFsX21kX2ZsYXZvdXJzKHN0cnVjdCBmb3JtYXQgKiBjZmcpIHsKIAlpZiAoY2ZnLT5tZC5t
YWdpYykgewogCQlpZiAoIWNvbmZpcm1lZCgiVmFsaWQgbWV0YSBkYXRhIHNlZW1zIHRvIGJlIGlu
IHBsYWNlLlxuIgogCQkJCSJEbyB5b3UgcmVhbGx5IHdhbnQgdG8gb3ZlcndyaXRlPyIpKSB7Ci0J
CQlwcmludGYoIk9wZXJhdGlvbiBjYW5jZWxsZWQuXG4iKTsKKwkJCXByaW50ZigiT3BlcmF0aW9u
IGNhbmNlbGVkLlxuIik7CiAJCQlleGl0KDEpOwogCQl9CiAJCWNmZy0+bWQubWFnaWMgPSAwOyAv
KiB3aWxsIGJlIHJlLWluaXRpYWxpemVkIGJlbG93ICovCkBAIC0zNTI0LDcgKzM1MjQsNyBAQCB2
b2lkIGNoZWNrX2V4dGVybmFsX21kX2ZsYXZvdXJzKHN0cnVjdCBmb3JtYXQgKiBjZmcpIHsKIAkJ
fQogCQlpZiAoIWNvbmZpcm1lZCgiU28geW91IHdhbnQgbWUgdG8gcmVwbGFjZSB0aGUgdjA3IG1l
dGEtZGF0YVxuIgogCQkJCSJ3aXRoIG5ld2x5IGluaXRpYWxpemVkIHYwOCBtZXRhLWRhdGE/Iikp
IHsKLQkJCXByaW50ZigiT3BlcmF0aW9uIGNhbmNlbGxlZC5cbiIpOworCQkJcHJpbnRmKCJPcGVy
YXRpb24gY2FuY2VsZWQuXG4iKTsKIAkJCWV4aXQoMSk7CiAJCX0KIAl9IGVsc2UgaWYgKGlzX3Yw
NyhjZmcpKSB7CkBAIC0zNTM4LDcgKzM1MzgsNyBAQCB2b2lkIGNoZWNrX2V4dGVybmFsX21kX2Zs
YXZvdXJzKHN0cnVjdCBmb3JtYXQgKiBjZmcpIHsKIAkJfQogCQlpZiAoIWNvbmZpcm1lZCgiU28g
eW91IHdhbnQgbWUgdG8gcmVwbGFjZSB0aGUgdjA4IG1ldGEtZGF0YVxuIgogCQkJCSJ3aXRoIG5l
d2x5IGluaXRpYWxpemVkIHYwNyBtZXRhLWRhdGE/IikpIHsKLQkJCXByaW50ZigiT3BlcmF0aW9u
IGNhbmNlbGxlZC5cbiIpOworCQkJcHJpbnRmKCJPcGVyYXRpb24gY2FuY2VsZWQuXG4iKTsKIAkJ
CWV4aXQoMSk7CiAJCX0KIAl9CkBAIC0zNjgxLDcgKzM2ODEsNyBAQCBpbnQgbWV0YV9jcmVhdGVf
bWQoc3RydWN0IGZvcm1hdCAqY2ZnLCBjaGFyICoqYXJndiBfX2F0dHJpYnV0ZSgodW51c2VkKSks
IGludCBhcgogCWlmICghY2ZnLT5tZC5tYWdpYykgLyogbm90IGNvbnZlcnRlZDogaW5pdGlhbGl6
ZSAqLwogCQllcnIgPSBjZmctPm9wcy0+bWRfaW5pdGlhbGl6ZShjZmcpOyAvKiBDbGVhcnMgb24g
ZGlzayBBTCBpbXBsaWNpdGx5ICovCiAJZWxzZQotCQllcnIgPSAwOyAvKiB3ZSBoYXZlIHN1Y2Vz
c2Z1bGx5IGNvbnZlcnRlZCBzb210aGluZyAqLworCQllcnIgPSAwOyAvKiB3ZSBoYXZlIHN1Y2Nl
c3NmdWxseSBjb252ZXJ0ZWQgc29tdGhpbmcgKi8KIAogCS8qIEZJWE1FCiAJICogaWYgdGhpcyBj
b252ZXJ0ZWQgZml4ZWQtc2l6ZSAxMjhNQiBpbnRlcm5hbCBtZXRhIGRhdGEKQEAgLTM3MTcsNyAr
MzcxNyw3IEBAIGludCBtZXRhX3dpcGVfbWQoc3RydWN0IGZvcm1hdCAqY2ZnLCBjaGFyICoqYXJn
diBfX2F0dHJpYnV0ZSgodW51c2VkKSksIGludCBhcmdjCiAJfQogCiAJaWYgKCFjb25maXJtZWQo
IkRvIHlvdSByZWFsbHkgd2FudCB0byB3aXBlIG91dCB0aGUgRFJCRCBtZXRhIGRhdGE/IikpIHsK
LQkJcHJpbnRmKCJPcGVyYXRpb24gY2FuY2VsbGVkLlxuIik7CisJCXByaW50ZigiT3BlcmF0aW9u
IGNhbmNlbGVkLlxuIik7CiAJCWV4aXQoMSk7CiAJfQogCmRpZmYgLS1naXQgYS91c2VyL2RyYmRz
ZXR1cC5jIGIvdXNlci9kcmJkc2V0dXAuYwppbmRleCAzM2YyNDQ4Li45ZDRiZTMwIDEwMDY0NAot
LS0gYS91c2VyL2RyYmRzZXR1cC5jCisrKyBiL3VzZXIvZHJiZHNldHVwLmMKQEAgLTE2NjUsNyAr
MTY2NSw3IEBAIHN0YXRpYyBpbnQgc2hvd19zY21kKHN0cnVjdCBkcmJkX2NtZCAqY20sIHN0cnVj
dCBnZW5sX2luZm8gKmluZm8pCiAJfQogCWNhbGxfY291bnQrKzsKIAotCS8qIEZJWE1FOiBJcyB0
aGUgZm9sb3dpbmcgY2hlY2sgbmVlZGVkPyAqLworCS8qIEZJWE1FOiBJcyB0aGUgZm9sbG93aW5n
IGNoZWNrIG5lZWRlZD8gKi8KIAlpZiAoIWdsb2JhbF9hdHRyc1tEUkJEX05MQV9DRkdfQ09OVEVY
VF0pCiAJCWRiZygxLCAidW5leHBlY3RlZCBwYWNrZXQsIGNvbmZpZ3VyYXRpb24gY29udGV4dCBt
aXNzaW5nIVxuIik7CiAKZGlmZiAtLWdpdCBhL3VzZXIvZHJiZHRvb2xfY29tbW9uLmMgYi91c2Vy
L2RyYmR0b29sX2NvbW1vbi5jCmluZGV4IDllNWY5OTUuLjdkZTI0MGYgMTAwNjQ0Ci0tLSBhL3Vz
ZXIvZHJiZHRvb2xfY29tbW9uLmMKKysrIGIvdXNlci9kcmJkdG9vbF9jb21tb24uYwpAQCAtNTM2
LDcgKzUzNiw3IEBAIGNoYXIgKmxrX2JkZXZfcGF0aCh1bnNpZ25lZCBtaW5vcikKICAqIHdpdGhv
dXQgc2Nhbm5pbmcgdGhlIGZ1bGwgZGV2aWNlIGZvciBtYWdpYyBudW1iZXJzLgogICovCiAKLS8q
IHRoZXNlIHJldHVybiAwIG9uIHN1Y2VzcywgZXJyb3IgY29kZSBpZiBzb21ldGhpbmcgZ29lcyB3
cm9uZy4gKi8KKy8qIHRoZXNlIHJldHVybiAwIG9uIHN1Y2Nlc3MsIGVycm9yIGNvZGUgaWYgc29t
ZXRoaW5nIGdvZXMgd3JvbmcuICovCiAKIC8qIE5PVEU6IGZpbGUgZm9ybWF0IGZvciBub3c6CiAg
KiBvbmUgbGluZSwgc3RhcnRpbmcgd2l0aCBzaXplIGluIGJ5dGUsIGZvbGxvd2VkIGJ5IHRhYiwK
ZGlmZiAtLWdpdCBhL3VzZXIvZHJiZHRvb2xfY29tbW9uLmggYi91c2VyL2RyYmR0b29sX2NvbW1v
bi5oCmluZGV4IDU3NTcyZTAuLjQwYzg0NmIgMTAwNjQ0Ci0tLSBhL3VzZXIvZHJiZHRvb2xfY29t
bW9uLmgKKysrIGIvdXNlci9kcmJkdG9vbF9jb21tb24uaApAQCAtMTAxLDcgKzEwMSw3IEBAIHN0
cnVjdCBiZGV2X2luZm8gewogCWNoYXIgKmJkX25hbWU7CiB9OwogCi0vKiB0aGVzZSByZXR1cm4g
MCBvbiBzdWNlc3MsIGVycm9yIGNvZGUgaWYgc29tZXRoaW5nIGdvZXMgd3JvbmcuICovCisvKiB0
aGVzZSByZXR1cm4gMCBvbiBzdWNjZXNzLCBlcnJvciBjb2RlIGlmIHNvbWV0aGluZyBnb2VzIHdy
b25nLiAqLwogLyogY3JlYXRlICh1cGRhdGUpIHRoZSBsYXN0LWtub3duLWJkZXYtaW5mbyBmaWxl
ICovCiBleHRlcm4gaW50IGxrX2JkZXZfc2F2ZShjb25zdCB1bnNpZ25lZCBtaW5vciwgY29uc3Qg
c3RydWN0IGJkZXZfaW5mbyAqYmQpOwogLyogd2UgbWF5IHdhbnQgdG8gcmVtb3ZlIGFsbCBzdG9y
ZWQgaW5mb3JtYXRpb24gKi8KZGlmZiAtLWdpdCBhL3VzZXIvbGVnYWN5L2RyYmRhZG1fbWFpbi5j
IGIvdXNlci9sZWdhY3kvZHJiZGFkbV9tYWluLmMKaW5kZXggZTMxZDVlMi4uMjM1MjgxYiAxMDA2
NDQKLS0tIGEvdXNlci9sZWdhY3kvZHJiZGFkbV9tYWluLmMKKysrIGIvdXNlci9sZWdhY3kvZHJi
ZGFkbV9tYWluLmMKQEAgLTEyMjYsMTEgKzEyMjYsMTEgQEAgc3RhdGljIHZvaWQgZXhwYW5kX2Nv
bW1vbih2b2lkKQogCX0KIH0KIAotc3RhdGljIHZvaWQgZmluZF9kcmJkY21kKGNoYXIgKipjbWQs
IGNoYXIgKipwYXRoZXMpCitzdGF0aWMgdm9pZCBmaW5kX2RyYmRjbWQoY2hhciAqKmNtZCwgY2hh
ciAqKnBhdGhzKQogewogCWNoYXIgKipwYXRoOwogCi0JcGF0aCA9IHBhdGhlczsKKwlwYXRoID0g
cGF0aHM7CiAJd2hpbGUgKCpwYXRoKSB7CiAJCWlmIChhY2Nlc3MoKnBhdGgsIFhfT0spID09IDAp
IHsKIAkJCSpjbWQgPSAqcGF0aDsKQEAgLTMwMTAsMjYgKzMwMTAsMjYgQEAgaW50IHBhcnNlX29w
dGlvbnMoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJYnJlYWs7CiAJCWNhc2UgJ3MnOgogCQkJ
ewotCQkJCWNoYXIgKnBhdGhlc1syXTsKLQkJCQlwYXRoZXNbMF0gPSBvcHRhcmc7Ci0JCQkJcGF0
aGVzWzFdID0gMDsKLQkJCQlmaW5kX2RyYmRjbWQoJmRyYmRzZXR1cCwgcGF0aGVzKTsKKwkJCQlj
aGFyICpwYXRoc1syXTsKKwkJCQlwYXRoc1swXSA9IG9wdGFyZzsKKwkJCQlwYXRoc1sxXSA9IDA7
CisJCQkJZmluZF9kcmJkY21kKCZkcmJkc2V0dXAsIHBhdGhzKTsKIAkJCX0KIAkJCWJyZWFrOwog
CQljYXNlICdtJzoKIAkJCXsKLQkJCQljaGFyICpwYXRoZXNbMl07Ci0JCQkJcGF0aGVzWzBdID0g
b3B0YXJnOwotCQkJCXBhdGhlc1sxXSA9IDA7Ci0JCQkJZmluZF9kcmJkY21kKCZkcmJkbWV0YSwg
cGF0aGVzKTsKKwkJCQljaGFyICpwYXRoc1syXTsKKwkJCQlwYXRoc1swXSA9IG9wdGFyZzsKKwkJ
CQlwYXRoc1sxXSA9IDA7CisJCQkJZmluZF9kcmJkY21kKCZkcmJkbWV0YSwgcGF0aHMpOwogCQkJ
fQogCQkJYnJlYWs7CiAJCWNhc2UgJ3AnOgogCQkJewotCQkJCWNoYXIgKnBhdGhlc1syXTsKLQkJ
CQlwYXRoZXNbMF0gPSBvcHRhcmc7Ci0JCQkJcGF0aGVzWzFdID0gMDsKLQkJCQlmaW5kX2RyYmRj
bWQoJmRyYmRfcHJveHlfY3RsLCBwYXRoZXMpOworCQkJCWNoYXIgKnBhdGhzWzJdOworCQkJCXBh
dGhzWzBdID0gb3B0YXJnOworCQkJCXBhdGhzWzFdID0gMDsKKwkJCQlmaW5kX2RyYmRjbWQoJmRy
YmRfcHJveHlfY3RsLCBwYXRocyk7CiAJCQl9CiAJCQlicmVhazsKIAkJY2FzZSAnbic6CmRpZmYg
LS1naXQgYS91c2VyL2xlZ2FjeS9kcmJkc2V0dXAuYyBiL3VzZXIvbGVnYWN5L2RyYmRzZXR1cC5j
CmluZGV4IGJmMmViMmIuLjMzMTM4YmUgMTAwNjQ0Ci0tLSBhL3VzZXIvbGVnYWN5L2RyYmRzZXR1
cC5jCisrKyBiL3VzZXIvbGVnYWN5L2RyYmRzZXR1cC5jCkBAIC00NTYsNyArNDU2LDcgQEAgc3Rh
dGljIGNvbnN0IGNoYXIgKmVycm9yX21lc3NhZ2VzW10gPSB7CiAJInRoZSBrZXJuZWwuIChNYXli
ZSB5b3UgbmVlZCB0byBtb2Rwcm9iZSBpdCwgb3IgbW9kcHJvYmUgaG1hYz8pIiwKIAlFTShFUlJf
QVVUSF9BTEdfTkQpID0gIlRoZSAnY3JhbS1obWFjLWFsZycgeW91IHNwZWNpZmllZCBpcyBub3Qg
YSBkaWdlc3QuIiwKIAlFTShFUlJfTk9NRU0pID0gImttYWxsb2MoKSBmYWlsZWQuIE91dCBvZiBt
ZW1vcnk/IiwKLQlFTShFUlJfRElTQ0FSRCkgPSAiLS1kaXNjYXJkLW15LWRhdGEgbm90IGdsbG93
ZWQgd2hlbiBwcmltYXJ5LiIsCisJRU0oRVJSX0RJU0NBUkQpID0gIi0tZGlzY2FyZC1teS1kYXRh
IG5vdCBhbGxvd2VkIHdoZW4gcHJpbWFyeS4iLAogCUVNKEVSUl9ESVNLX0NPTkZJR1VSRUQpID0g
IkRldmljZSBpcyBhdHRhY2hlZCB0byBhIGRpc2sgKHVzZSBkZXRhY2ggZmlyc3QpIiwKIAlFTShF
UlJfTkVUX0NPTkZJR1VSRUQpID0gIkRldmljZSBoYXMgYSBuZXQtY29uZmlnICh1c2UgZGlzY29u
bmVjdCBmaXJzdCkiLAogCUVNKEVSUl9NQU5EQVRPUllfVEFHKSA9ICJVbmtub3duTWFuZGF0b3J5
VGFnIiwKZGlmZiAtLWdpdCBhL3VzZXIvbGVnYWN5L2RyYmR0b29sX2NvbW1vbi5jIGIvdXNlci9s
ZWdhY3kvZHJiZHRvb2xfY29tbW9uLmMKaW5kZXggMmM3MTc0ZC4uMzIzNDU0ZSAxMDA2NDQKLS0t
IGEvdXNlci9sZWdhY3kvZHJiZHRvb2xfY29tbW9uLmMKKysrIGIvdXNlci9sZWdhY3kvZHJiZHRv
b2xfY29tbW9uLmMKQEAgLTU2MCw3ICs1NjAsNyBAQCBjaGFyICpsa19iZGV2X3BhdGgodW5zaWdu
ZWQgbWlub3IpCiAgKiB3aXRob3V0IHNjYW5uaW5nIHRoZSBmdWxsIGRldmljZSBmb3IgbWFnaWMg
bnVtYmVycy4KICAqLwogCi0vKiB0aGVzZSByZXR1cm4gMCBvbiBzdWNlc3MsIGVycm9yIGNvZGUg
aWYgc29tZXRoaW5nIGdvZXMgd3JvbmcuICovCisvKiB0aGVzZSByZXR1cm4gMCBvbiBzdWNjZXNz
LCBlcnJvciBjb2RlIGlmIHNvbWV0aGluZyBnb2VzIHdyb25nLiAqLwogCiAvKiBOT1RFOiBmaWxl
IGZvcm1hdCBmb3Igbm93OgogICogb25lIGxpbmUsIHN0YXJ0aW5nIHdpdGggc2l6ZSBpbiBieXRl
LCBmb2xsb3dlZCBieSB0YWIsCmRpZmYgLS1naXQgYS91c2VyL2xlZ2FjeS9kcmJkdG9vbF9jb21t
b24uaCBiL3VzZXIvbGVnYWN5L2RyYmR0b29sX2NvbW1vbi5oCmluZGV4IDgzNzI2NDAuLmMxNjJl
YjUgMTAwNjQ0Ci0tLSBhL3VzZXIvbGVnYWN5L2RyYmR0b29sX2NvbW1vbi5oCisrKyBiL3VzZXIv
bGVnYWN5L2RyYmR0b29sX2NvbW1vbi5oCkBAIC0xMDQsNyArMTA0LDcgQEAgc3RydWN0IGJkZXZf
aW5mbyB7CiAJY2hhciAqYmRfbmFtZTsKIH07CiAKLS8qIHRoZXNlIHJldHVybiAwIG9uIHN1Y2Vz
cywgZXJyb3IgY29kZSBpZiBzb21ldGhpbmcgZ29lcyB3cm9uZy4gKi8KKy8qIHRoZXNlIHJldHVy
biAwIG9uIHN1Y2Nlc3MsIGVycm9yIGNvZGUgaWYgc29tZXRoaW5nIGdvZXMgd3JvbmcuICovCiAv
KiBjcmVhdGUgKHVwZGF0ZSkgdGhlIGxhc3Qta25vd24tYmRldi1pbmZvIGZpbGUgKi8KIGV4dGVy
biBpbnQgbGtfYmRldl9zYXZlKGNvbnN0IHVuc2lnbmVkIG1pbm9yLCBjb25zdCBzdHJ1Y3QgYmRl
dl9pbmZvICpiZCk7CiAvKiB3ZSBtYXkgd2FudCB0byByZW1vdmUgYWxsIHN0b3JlZCBpbmZvcm1h
dGlvbiAqLwpkaWZmIC0tZ2l0IGEvdXNlci9sZWdhY3kvbGludXgvZHJiZC5oIGIvdXNlci9sZWdh
Y3kvbGludXgvZHJiZC5oCmluZGV4IDYzYzA4MDguLmQyZTgzMzkgMTAwNjQ0Ci0tLSBhL3VzZXIv
bGVnYWN5L2xpbnV4L2RyYmQuaAorKysgYi91c2VyL2xlZ2FjeS9saW51eC9kcmJkLmgKQEAgLTM5
LDcgKzM5LDcgQEAKIAogLyogQWx0b3VnaCB0aGUgTGludXggc291cmNlIGNvZGUgbWFrZXMgYSBk
aWZmZXJlbmNlIGJldHdlZW4KICAgIGdlbmVyaWMgZW5kaWFubmVzcyBhbmQgdGhlIGJpdGZpZWxk
cycgZW5kaWFubmVzcywgdGhlcmUgaXMgbm8KLSAgIGFyY2hpdGVjdHVyZSBhcyBvZiBMaW51eC0y
LjYuMjQtcmM0IHdoZXJlIHRoZSBiaXRmaWxlZHMnIGVuZGlhbm5lc3MKKyAgIGFyY2hpdGVjdHVy
ZSBhcyBvZiBMaW51eC0yLjYuMjQtcmM0IHdoZXJlIHRoZSBiaXRmaWVsZHMnIGVuZGlhbm5lc3MK
ICAgIGRvZXMgbm90IG1hdGNoIHRoZSBnZW5lcmljIGVuZGlhbm5lc3MuICovCiAKICNpZiBfX0JZ
VEVfT1JERVIgPT0gX19MSVRUTEVfRU5ESUFOCkBAIC0xNzgsNyArMTc4LDcgQEAgZW51bSBkcmJk
X2Nvbm5zIHsKIAkvKiBUaGVzZSB0ZW1wb3JhbCBzdGF0ZXMgYXJlIGFsbCB1c2VkIG9uIHRoZSB3
YXkKIAkgKiBmcm9tID49IENfQ09OTkVDVEVEIHRvIFVuY29ubmVjdGVkLgogCSAqIFRoZSAnZGlz
Y29ubmVjdCByZWFzb24nIHN0YXRlcwotCSAqIEkgZG8gbm90IGFsbG93IHRvIGNoYW5nZSBiZXdl
ZW4gdGhlbS4gKi8KKwkgKiBJIGRvIG5vdCBhbGxvdyB0byBjaGFuZ2UgYmV0d2VlbiB0aGVtLiAq
LwogCUNfVElNRU9VVCwKIAlDX0JST0tFTl9QSVBFLAogCUNfTkVUV09SS19GQUlMVVJFLApAQCAt
MjMwLDcgKzIzMCw3IEBAIHVuaW9uIGRyYmRfc3RhdGUgewogICogcG9pbnRlZCBvdXQgYnkgTWF4
aW0gVXZhcm92IHE8bXV2YXJvdkBydS5tdmlzdGEuY29tPgogICogZXZlbiB0aG91Z2ggd2UgdHJh
bnNtaXQgYXMgImNwdV90b19iZTMyKHN0YXRlKSIsCiAgKiB0aGUgb2Zmc2V0cyBvZiB0aGUgYml0
ZmllbGRzIHN0aWxsIG5lZWQgdG8gYmUgc3dhcHBlZAotICogb24gZGlmZmVyZW50IGVuZGlhbmVz
cy4KKyAqIG9uIGRpZmZlcmVudCBlbmRpYW5uZXNzLgogICovCiAJc3RydWN0IHsKICNpZiBkZWZp
bmVkKF9fTElUVExFX0VORElBTl9CSVRGSUVMRCkKQEAgLTI2MCw3ICsyNjAsNyBAQCB1bmlvbiBk
cmJkX3N0YXRlIHsKIAkJdW5zaWduZWQgcGVlcjoyIDsgICAvKiAzLzQJIHByaW1hcnkvc2Vjb25k
YXJ5L3Vua25vd24gKi8KIAkJdW5zaWduZWQgcm9sZToyIDsgICAvKiAzLzQJIHByaW1hcnkvc2Vj
b25kYXJ5L3Vua25vd24gKi8KICNlbHNlCi0jIGVycm9yICJ0aGlzIGVuZGlhbmVzcyBpcyBub3Qg
c3VwcG9ydGVkIgorIyBlcnJvciAidGhpcyBlbmRpYW5uZXNzIGlzIG5vdCBzdXBwb3J0ZWQiCiAj
ZW5kaWYKICNpZm5kZWYgRFJCRF9ERUJVR19TVEFURV9DSEFOR0VTCiAjIGlmZGVmIENPTkZJR19E
WU5BTUlDX0RFQlVHCmRpZmYgLS1naXQgYS91c2VyL2xlZ2FjeS9saW51eC9kcmJkX2NvbmZpZy5o
IGIvdXNlci9sZWdhY3kvbGludXgvZHJiZF9jb25maWcuaAppbmRleCAxYTE2MWEwLi45MTdhODJm
IDEwMDY0NAotLS0gYS91c2VyL2xlZ2FjeS9saW51eC9kcmJkX2NvbmZpZy5oCisrKyBiL3VzZXIv
bGVnYWN5L2xpbnV4L2RyYmRfY29uZmlnLmgKQEAgLTEwMyw3ICsxMDMsNyBAQCBleHRlcm4gY29u
c3QgY2hhciAqZHJiZF9idWlsZHRhZyh2b2lkKTsKIAogI2RlZmluZSBLRVJORUxfSEFTX0tWRUMK
IAotLyogQWN0dWFsbHkgYXZhaWxhYmUgc2luY2UgMi42LjI2LCBidXQgdmVuZG9ycyBoYXZlIGJh
Y2twb3J0ZWQuLi4KKy8qIEFjdHVhbGx5IGF2YWlsYWJsZSBzaW5jZSAyLjYuMjYsIGJ1dCB2ZW5k
b3JzIGhhdmUgYmFja3BvcnRlZC4uLgogICovCiAjZGVmaW5lIEtFUk5FTF9IQVNfUFJPQ19DUkVB
VEVfREFUQQogCmRpZmYgLS1naXQgYS91c2VyL2xlZ2FjeS9saW51eC9kcmJkX2xpbWl0cy5oIGIv
dXNlci9sZWdhY3kvbGludXgvZHJiZF9saW1pdHMuaAppbmRleCAxZTMyMTkzLi4yNmFiODU0IDEw
MDY0NAotLS0gYS91c2VyL2xlZ2FjeS9saW51eC9kcmJkX2xpbWl0cy5oCisrKyBiL3VzZXIvbGVn
YWN5L2xpbnV4L2RyYmRfbGltaXRzLmgKQEAgLTQzLDcgKzQzLDcgQEAKIAogLyogbmV0IHsgKi8K
ICAgLyogdGltZW91dCwgdW5pdCBjZW50aSBzZWNvbmRzCi0gICAqIG1vcmUgdGhhbiBvbmUgbWlu
dXRlIHRpbWVvdXQgaXMgbm90IHVzZWZ1bGwgKi8KKyAgICogbW9yZSB0aGFuIG9uZSBtaW51dGUg
dGltZW91dCBpcyBub3QgdXNlZnVsICovCiAjZGVmaW5lIERSQkRfVElNRU9VVF9NSU4gMQogI2Rl
ZmluZSBEUkJEX1RJTUVPVVRfTUFYIDYwMAogI2RlZmluZSBEUkJEX1RJTUVPVVRfREVGIDYwICAg
ICAgIC8qIDYgc2Vjb25kcyAqLwpAQCAtNzMsNyArNzMsNyBAQAogI2RlZmluZSBEUkJEX01BWF9F
UE9DSF9TSVpFX01BWCAyMDAwMAogI2RlZmluZSBEUkJEX01BWF9FUE9DSF9TSVpFX0RFRiAyMDQ4
CiAKLSAgLyogSSBkb24ndCB0aGluayB0aGF0IGEgdGNwIHNlbmQgYnVmZmVyIG9mIG1vcmUgdGhh
biAxME0gaXMgdXNlZnVsbCAqLworICAvKiBJIGRvbid0IHRoaW5rIHRoYXQgYSB0Y3Agc2VuZCBi
dWZmZXIgb2YgbW9yZSB0aGFuIDEwTSBpcyB1c2VmdWwgKi8KICNkZWZpbmUgRFJCRF9TTkRCVUZf
U0laRV9NSU4gIDAKICNkZWZpbmUgRFJCRF9TTkRCVUZfU0laRV9NQVggICgxMDw8MjApCiAjZGVm
aW5lIERSQkRfU05EQlVGX1NJWkVfREVGICAwCkBAIC0xMDYsNyArMTA2LDcgQEAKICNkZWZpbmUg
RFJCRF9SQVRFX01BWCAoNCA8PCAyMCkKICNkZWZpbmUgRFJCRF9SQVRFX0RFRiAyNTAgIC8qIGti
L3NlY29uZCAqLwogCi0gIC8qIGxlc3MgdGhhbiA3IHdvdWxkIGhpdCBwZXJmb3JtYW5jZSB1bm5l
Y2Nlc3NhcmlseS4KKyAgLyogbGVzcyB0aGFuIDcgd291bGQgaGl0IHBlcmZvcm1hbmNlIHVubmVj
ZXNzYXJpbHkuCiAgICAqIDM4MzMgaXMgdGhlIGxhcmdlc3QgcHJpbWUgdGhhdCBzdGlsbCBkb2Vz
IGZpdAogICAgKiBpbnRvIDY0IHNlY3RvcnMgb2YgYWN0aXZpdHkgbG9nICovCiAjZGVmaW5lIERS
QkRfQUxfRVhURU5UU19NSU4gIDcKZGlmZiAtLWdpdCBhL3VzZXIvbGVnYWN5L3VuYWxpZ25lZC5o
IGIvdXNlci9sZWdhY3kvdW5hbGlnbmVkLmgKaW5kZXggZWI5YWZkMy4uYmI2NjIzOSAxMDA2NDQK
LS0tIGEvdXNlci9sZWdhY3kvdW5hbGlnbmVkLmgKKysrIGIvdXNlci9sZWdhY3kvdW5hbGlnbmVk
LmgKQEAgLTI0LDcgKzI0LDcgQEAKIC8qIG9uIHNvbWUgYXJjaGl0ZWN0dXJlcyB3ZSBoYXZlIHRv
IGRvIGl0IGluIHByb2dyYW0gY29kZSAqLwogCiAvKiBCZXR0ZXIgbm90IHVzZSBtZW1jcHkoKS4g
Z2NjIGdlbmVyYXRlcyBicm9rZW4gY29kZSBhbiBBUk0gYXQgaGlnaGVyCi0gICBvcHRpbWlzYXRp
b24gbGV2ZWxzCisgICBvcHRpbWl6YXRpb24gbGV2ZWxzCiAqLwogCiAjZGVmaW5lIF9fYmFkX3Vu
YWxpZ25lZF9hY2Nlc3Nfc2l6ZSgpICh7CQkJXApkaWZmIC0tZ2l0IGEvdXNlci9saWJnZW5sLmMg
Yi91c2VyL2xpYmdlbmwuYwppbmRleCBjNzA0MjdmLi5iYmM4NGUwIDEwMDY0NAotLS0gYS91c2Vy
L2xpYmdlbmwuYworKysgYi91c2VyL2xpYmdlbmwuYwpAQCAtNDczLDcgKzQ3Myw3IEBAIHN0YXRp
YyBpbnQgdmFsaWRhdGVfbmxhKHN0cnVjdCBubGF0dHIgKm5sYSwgaW50IG1heHR5cGUsCiAgKgog
ICogVmFsaWRhdGVzIGFsbCBhdHRyaWJ1dGVzIGluIHRoZSBzcGVjaWZpZWQgYXR0cmlidXRlIHN0
cmVhbSBhZ2FpbnN0IHRoZQogICogc3BlY2lmaWVkIHBvbGljeS4gQXR0cmlidXRlcyB3aXRoIGEg
dHlwZSBleGNlZWRpbmcgbWF4dHlwZSB3aWxsIGJlCi0gKiBpZ25vcmVkLiBTZWUgZG9jdW1lbmF0
aW9uIG9mIHN0cnVjdCBubGFfcG9saWN5IGZvciBtb3JlIGRldGFpbHMuCisgKiBpZ25vcmVkLiBT
ZWUgZG9jdW1lbnRhdGlvbiBvZiBzdHJ1Y3QgbmxhX3BvbGljeSBmb3IgbW9yZSBkZXRhaWxzLgog
ICoKICAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4KICAq
LwpAQCAtNDk1LDcgKzQ5NSw3IEBAIGVycm91dDoKIH0KIAogLyoqCi0gKiBubGFfcG9saWN5X2xl
biAtIERldGVybWluIHRoZSBtYXguIGxlbmd0aCBvZiBhIHBvbGljeQorICogbmxhX3BvbGljeV9s
ZW4gLSBEZXRlcm1pbmUgdGhlIG1heC4gbGVuZ3RoIG9mIGEgcG9saWN5CiAgKiBAcG9saWN5OiBw
b2xpY3kgdG8gdXNlCiAgKiBAbjogbnVtYmVyIG9mIHBvbGljaWVzCiAgKgpAQCAtNTI5LDcgKzUy
OSw3IEBAIG5sYV9wb2xpY3lfbGVuKGNvbnN0IHN0cnVjdCBubGFfcG9saWN5ICpwLCBpbnQgbikK
ICAqIEBwb2xpY3k6IHZhbGlkYXRpb24gcG9saWN5CiAgKgogICogUGFyc2VzIGEgc3RyZWFtIG9m
IGF0dHJpYnV0ZXMgYW5kIHN0b3JlcyBhIHBvaW50ZXIgdG8gZWFjaCBhdHRyaWJ1dGUgaW4KLSAq
IHRoZSB0YiBhcnJheSBhY2Nlc3NhYmxlIHZpYSB0aGUgYXR0cmlidXRlIHR5cGUuIEF0dHJpYnV0
ZXMgd2l0aCBhIHR5cGUKKyAqIHRoZSB0YiBhcnJheSBhY2Nlc3NpYmxlIHZpYSB0aGUgYXR0cmli
dXRlIHR5cGUuIEF0dHJpYnV0ZXMgd2l0aCBhIHR5cGUKICAqIGV4Y2VlZGluZyBtYXh0eXBlIHdp
bGwgYmUgc2lsZW50bHkgaWdub3JlZCBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkKICAqIHJl
YXNvbnMuIHBvbGljeSBtYXkgYmUgc2V0IHRvIE5VTEwgaWYgbm8gdmFsaWRhdGlvbiBpcyByZXF1
aXJlZC4KICAqCmRpZmYgLS1naXQgYS91c2VyL2xpYmdlbmwuaCBiL3VzZXIvbGliZ2VubC5oCmlu
ZGV4IGEzNzQ5M2EuLjI3MmJmZjQgMTAwNjQ0Ci0tLSBhL3VzZXIvbGliZ2VubC5oCisrKyBiL3Vz
ZXIvbGliZ2VubC5oCkBAIC0xMzYsNyArMTM2LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICptc2df
cHV0KHN0cnVjdCBtc2dfYnVmZiAqbXNnLCB1bnNpZ25lZCBpbnQgbGVuKQogICogICBubG1zZ19u
ZXcoKQkJCWNyZWF0ZSBhIG5ldyBuZXRsaW5rIG1lc3NhZ2UKICAqICAgbmxtc2dfcHV0KCkJCQlh
ZGQgYSBuZXRsaW5rIG1lc3NhZ2UgdG8gYW4gbXNnCiAgKiAgIG5sbXNnX3B1dF9hbnN3ZXIoKQkJ
CWNhbGxiYWNrIGJhc2VkIG5sbXNnX3B1dCgpCi0gKiAgIG5sbXNnX2VuZCgpCQkJZmluYW5saXpl
IG5ldGxpbmsgbWVzc2FnZQorICogICBubG1zZ19lbmQoKQkJCWZpbmFsaXplIG5ldGxpbmsgbWVz
c2FnZQogICogICBubG1zZ19nZXRfcG9zKCkJCQlyZXR1cm4gY3VycmVudCBwb3NpdGlvbiBpbiBt
ZXNzYWdlCiAgKiAgIG5sbXNnX3RyaW0oKQkJCXRyaW0gcGFydCBvZiBtZXNzYWdlCiAgKiAgIG5s
bXNnX2NhbmNlbCgpCQkJY2FuY2VsIG1lc3NhZ2UgY29uc3RydWN0aW9uCkBAIC0yNTMsNyArMjUz
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICptc2dfcHV0KHN0cnVjdCBtc2dfYnVmZiAqbXNnLCB1
bnNpZ25lZCBpbnQgbGVuKQogICogICBubGFfZmluZCgpCQkJCWZpbmQgYXR0cmlidXRlIGluIHN0
cmVhbSBvZiBhdHRyaWJ1dGVzCiAgKiAgIG5sYV9maW5kX25lc3RlZCgpCQkJZmluZCBhdHRyaWJ1
dGUgaW4gbmVzdGVkIGF0dHJpYnV0ZXMKICAqICAgbmxhX3BhcnNlKCkJCQlwYXJzZSBhbmQgdmFs
aWRhdGUgc3RyZWFtIG9mIGF0dHJzCi0gKiAgIG5sYV9wYXJzZV9uZXN0ZWQoKQkJCXBhcnNlIG5l
c3RlZCBhdHRyaWJ1ZXRzCisgKiAgIG5sYV9wYXJzZV9uZXN0ZWQoKQkJCXBhcnNlIG5lc3RlZCBh
dHRyaWJ1dGVzCiAgKiAgIG5sYV9mb3JfZWFjaF9hdHRyKCkJCWxvb3Agb3ZlciBhbGwgYXR0cmli
dXRlcwogICogICBubGFfZm9yX2VhY2hfbmVzdGVkKCkJCWxvb3Agb3ZlciB0aGUgbmVzdGVkIGF0
dHJpYnV0ZXMKICAqPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpAQCAtNDYyLDcgKzQ2Miw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IG5sbXNnX3BhcnNlKGNvbnN0IHN0cnVjdCBubG1zZ2hkciAqbmxoLCBpbnQgaGRy
bGVuLAogLyoqCiAgKiBubG1zZ19maW5kX2F0dHIgLSBmaW5kIGEgc3BlY2lmaWMgYXR0cmlidXRl
IGluIGEgbmV0bGluayBtZXNzYWdlCiAgKiBAbmxoOiBuZXRsaW5rIG1lc3NhZ2UgaGVhZGVyCi0g
KiBAaGRybGVuOiBsZW5ndGggb2YgZmFtaWxpeSBzcGVjaWZpYyBoZWFkZXIKKyAqIEBoZHJsZW46
IGxlbmd0aCBvZiBmYW1pbHkgc3BlY2lmaWMgaGVhZGVyCiAgKiBAYXR0cnR5cGU6IHR5cGUgb2Yg
YXR0cmlidXRlIHRvIGxvb2sgZm9yCiAgKgogICogUmV0dXJucyB0aGUgZmlyc3QgYXR0cmlidXRl
IHdoaWNoIG1hdGNoZXMgdGhlIHNwZWNpZmllZCB0eXBlLgpAQCAtNDc2LDggKzQ3Niw4IEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IG5sYXR0ciAqbmxtc2dfZmluZF9hdHRyKHN0cnVjdCBubG1zZ2hk
ciAqbmxoLAogCiAvKioKICAqIG5sbXNnX3ZhbGlkYXRlIC0gdmFsaWRhdGUgYSBuZXRsaW5rIG1l
c3NhZ2UgaW5jbHVkaW5nIGF0dHJpYnV0ZXMKLSAqIEBubGg6IG5ldGxpbmtldCBtZXNzYWdlIGhl
YWRlcgotICogQGhkcmxlbjogbGVuZ3RoIG9mIGZhbWlsaXkgc3BlY2lmaWMgaGVhZGVyCisgKiBA
bmxoOiBuZXRsaW5rIG1lc3NhZ2UgaGVhZGVyCisgKiBAaGRybGVuOiBsZW5ndGggb2YgZmFtaWx5
IHNwZWNpZmljIGhlYWRlcgogICogQG1heHR5cGU6IG1heGltdW0gYXR0cmlidXRlIHR5cGUgdG8g
YmUgZXhwZWN0ZWQKICAqIEBwb2xpY3k6IHZhbGlkYXRpb24gcG9saWN5CiAgKi8KQEAgLTUwNiw3
ICs1MDYsNyBAQCBzdGF0aWMgaW5saW5lIGludCBubG1zZ19yZXBvcnQoY29uc3Qgc3RydWN0IG5s
bXNnaGRyICpubGgpCiAgKiBubG1zZ19mb3JfZWFjaF9hdHRyIC0gaXRlcmF0ZSBvdmVyIGEgc3Ry
ZWFtIG9mIGF0dHJpYnV0ZXMKICAqIEBwb3M6IGxvb3AgY291bnRlciwgc2V0IHRvIGN1cnJlbnQg
YXR0cmlidXRlCiAgKiBAbmxoOiBuZXRsaW5rIG1lc3NhZ2UgaGVhZGVyCi0gKiBAaGRybGVuOiBs
ZW5ndGggb2YgZmFtaWxpeSBzcGVjaWZpYyBoZWFkZXIKKyAqIEBoZHJsZW46IGxlbmd0aCBvZiBm
YW1pbHkgc3BlY2lmaWMgaGVhZGVyCiAgKiBAcmVtOiBpbml0aWFsaXplZCB0byBsZW4sIGhvbGRz
IGJ5dGVzIGN1cnJlbnRseSByZW1haW5pbmcgaW4gc3RyZWFtCiAgKi8KICNkZWZpbmUgbmxtc2df
Zm9yX2VhY2hfYXR0cihwb3MsIG5saCwgaGRybGVuLCByZW0pIFwKQEAgLTg3Nyw3ICs4NzcsNyBA
QCBzdGF0aWMgaW5saW5lIGludCBubGFfbmVzdF9lbmQoc3RydWN0IG1zZ19idWZmICptc2csIHN0
cnVjdCBubGF0dHIgKnN0YXJ0KQogICoKICAqIFZhbGlkYXRlcyBhbGwgYXR0cmlidXRlcyBpbiB0
aGUgbmVzdGVkIGF0dHJpYnV0ZSBzdHJlYW0gYWdhaW5zdCB0aGUKICAqIHNwZWNpZmllZCBwb2xp
Y3kuIEF0dHJpYnV0ZXMgd2l0aCBhIHR5cGUgZXhjZWVkaW5nIG1heHR5cGUgd2lsbCBiZQotICog
aWdub3JlZC4gU2VlIGRvY3VtZW5hdGlvbiBvZiBzdHJ1Y3QgbmxhX3BvbGljeSBmb3IgbW9yZSBk
ZXRhaWxzLgorICogaWdub3JlZC4gU2VlIGRvY3VtZW50YXRpb24gb2Ygc3RydWN0IG5sYV9wb2xp
Y3kgZm9yIG1vcmUgZGV0YWlscy4KICAqCiAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBhIG5l
Z2F0aXZlIGVycm9yIGNvZGUuCiAgKi8KQEAgLTkyMyw3ICs5MjMsNyBAQCBzdHJ1Y3QgZ2VubF9t
dWx0aWNhc3RfZ3JvdXAKIAogLyoqCiAgKiBzdHJ1Y3QgZ2VubF9mYW1pbHkgLSBnZW5lcmljIG5l
dGxpbmsgZmFtaWx5Ci0gKiBAaWQ6IHByb3RvY29sIGZhbWlseSBpZGVuZml0aWVyCisgKiBAaWQ6
IHByb3RvY29sIGZhbWlseSBpZGVudGlmaWVyCiAgKiBAaGRyc2l6ZTogbGVuZ3RoIG9mIHVzZXIg
c3BlY2lmaWMgaGVhZGVyIGluIGJ5dGVzCiAgKiBAbmFtZTogbmFtZSBvZiBmYW1pbHkKICAqIEB2
ZXJzaW9uOiBwcm90b2NvbCB2ZXJzaW9uCg==
--000e0ce0d65e39623a04c4034810--
