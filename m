Return-Path: <mrten@ii.nl>
Received: from mail1.ii.nl (mail1.ii.nl [82.94.191.120])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 29E5E10567A3
	for <drbd-dev@lists.linbit.com>; Thu,  4 Aug 2011 17:37:06 +0200 (CEST)
From: mrten+drbd@ii.nl
To: drbd-dev@lists.linbit.com
Date: Thu,  4 Aug 2011 17:34:49 +0200
Message-Id: <1312472089-4215-2-git-send-email-mrten+drbd@ii.nl>
In-Reply-To: <1312472089-4215-1-git-send-email-mrten+drbd@ii.nl>
References: <1312472089-4215-1-git-send-email-mrten+drbd@ii.nl>
Subject: [Drbd-dev] [PATCH] expand section on throughput tuning to highlight
	prime usecase of external metadata florians comments applied,
	added section replacing metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Mrten <mrten+drbd@ii.nl>

---
 users-guide/throughput.txt |   66 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/users-guide/throughput.txt b/users-guide/throughput.txt
index 1cdf1b7..dd32d56 100644
--- a/users-guide/throughput.txt
+++ b/users-guide/throughput.txt
@@ -48,11 +48,12 @@ important to consider the following natural limitations:
 
 * DRBD throughput is limited by that of the raw I/O subsystem.
 * DRBD throughput is limited by the available network bandwidth.
+* DRBD throughput can possibly be limited by head seeks with '+meta-disk internal+'
 
-The _minimum_ between the two establishes the theoretical throughput
-_maximum_ available to DRBD. DRBD then reduces that throughput maximum
+The _minimum_ of the first two establishes the _maximum_ theoretical throughput
+available to DRBD. DRBD then reduces that throughput maximum
 by its additional throughput overhead, which can be expected to be
-less than 3 percent.
+less than 3 percent. 
 
 * Consider the example of two cluster nodes containing I/O subsystems
   capable of 200 MB/s throughput, with a Gigabit Ethernet link
@@ -64,6 +65,18 @@ less than 3 percent.
 * By contrast, if the I/O subsystem is capable of only 100 MB/s for
   sustained writes, then it constitutes the bottleneck, and you would
   be able to expect only 97 MB/s maximum DRBD throughput.
+  
+* In case of +meta-disk+ internal and without a hardware write cache, DRBD
+metadata updates to the <<s-activity-log,activity log>> can slow down write
+throughput significantly. If a raw software RAID-0 device with rotational disks
+is normally capable of 250 MB/s linear write throughput it is not an anomaly to
+see writes of 70 MB/s with DRBD. This is purely caused by head seeks; data
+writes have to be followed by activity log updates and data writes can only
+continue after the meta data update has _reached the platters_. With RAID-0,
+activity log updates can get concentrated on one harddrive, which is then
+seeking most of the time instead of writing, lowering throughput. External meta
+data on a different device (which is not on a disk used by the RAID-0 device)
+can be used to mitigate this.
 
 [[s-throughput-tuning]]
 === Tuning recommendations
@@ -204,3 +217,50 @@ resource <resource> {
   ...
 }
 ----------------------------
+
+[[s-tune-external-metadata]]
+==== Moving meta-disk to external device
+
+WARNING: The recommended configuration is running with internal +meta-disk+. 
+With external meta data, when underlying storage dies the meta data does not 
+die with it, so special care should be taken. See <<s-external-meta-data,external meta data>>.
+
+With a software raid (md) of rotational media it is often faster to create the meta data on a 
+dedicated device.
+
+[source,drbd]
+----------------------------
+resource <resource> {
+  disk {
+    disk /dev/md3;
+    flexible-meta-disk /dev/md4;
+    ...
+  }
+  ...
+}
+----------------------------
+
+
+To move meta-data from one device to another:
+
+Make sure the device is stopped:
+----------------------------
+drbdadm down [resource]
+----------------------------
+
+Save a textual representation of the current meta data to a temporary file:
+----------------------------
+drbdadm dump-md [resource] > savefile
+----------------------------
+
+Wipe the current meta data so that DRBD isn't confronted with it in a later stage:
+----------------------------
+drbdadm wipe-md [resource] 
+----------------------------
+
+Write the meta data to another device:
+----------------------------
+drbdmeta /dev/[drbd-device] v08 [new metadevice] 0 restore-md savefile
+----------------------------
+
+Adjust your config, and start the device again.
-- 
1.7.0.4

