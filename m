Return-Path: <mrten@ii.nl>
Received: from mail1.ii.nl (mail1.ii.nl [82.94.191.120])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2A2DD105669B
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jul 2011 18:00:12 +0200 (CEST)
From: Mrten <mrten+drbd@ii.nl>
To: drbd-dev@lists.linbit.com
Date: Thu,  7 Jul 2011 17:44:21 +0200
Message-Id: <1310053461-15060-2-git-send-email-mrten+drbd@ii.nl>
In-Reply-To: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
References: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
Subject: [Drbd-dev] [PATCH 2/2] expand section on throughput tuning to
	highlight prime usecase of external metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 users-guide/throughput.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/users-guide/throughput.txt b/users-guide/throughput.txt
index f033db5..584d0bf 100644
--- a/users-guide/throughput.txt
+++ b/users-guide/throughput.txt
@@ -48,6 +48,7 @@ important to consider the following natural limitations:
 
 * DRBD throughput is limited by that of the raw I/O subsystem.
 * DRBD throughput is limited by the available network bandwidth.
+* DRBD throughput can be limited by head seeks with 'meta-disk internal'
 
 The _minimum_ between the two establishes the theoretical throughput
 _maximum_ available to DRBD. DRBD then reduces that throughput maximum
@@ -64,6 +65,16 @@ less than 3 percent.
 * By contrast, if the I/O subsystem is capable of only 100 MB/s for
   sustained writes, then it constitutes the bottleneck, and you would
   be able to expect only 97 MB/s maximum DRBD throughput.
+  
+* In case of meta-disk internal without a hardware write cache (which 
+  should be battery backupped!), DRBD metadata updates necessary to guarantee
+  data-completeness in case of failure can slow down 
+  write throughput significantly. If a raw device is normally capable of
+  250 MB/s write throughput it is not an anomaly to see writes as slow as 
+  70 MB/s with DRBD enabled (numbers are for rotational disks). This is 
+  purely caused by head seeks; 4MB data updates have to be followed by metadata updates
+  and the data-writes can only continue after the metadata has been reached the 
+  platters (caching and write reordering does not help).
 
 [[s-throughput-tuning]]
 === Tuning recommendations
@@ -204,3 +215,25 @@ resource <resource> {
   ...
 }
 ----------------------------
+
+[[s-tune-external-metadata]]
+==== Moving meta-disk to external device
+
+WARNING: The recommended configuration is running with internal meta-disk. 
+With external metadata, when underlying storage dies the metadata does not 
+die with it, so special care should be taken. See <<s-external-meta-data,external meta data>>.
+
+With a software raid (md) of rotational media it is often faster to move the metadata to a 
+dedicated set of platters. 
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
-- 
1.7.0.4

