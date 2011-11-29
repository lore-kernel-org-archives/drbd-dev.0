Return-Path: <florian@hastexo.com>
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com
	[209.85.215.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4A15E1055730
	for <drbd-dev@lists.linbit.com>; Tue, 29 Nov 2011 20:05:06 +0100 (CET)
Received: by mail-ey0-f182.google.com with SMTP id i12so6052086eaa.27
	for <drbd-dev@lists.linbit.com>; Tue, 29 Nov 2011 11:05:06 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 29 Nov 2011 19:57:25 +0100
Message-Id: <1322593045-678-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1322593045-678-1-git-send-email-florian@hastexo.com>
References: <1322593045-678-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH] udev rules file: skip if invoked for a subsystem
	other than block
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 scripts/drbd.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/scripts/drbd.rules b/scripts/drbd.rules
index 080635f..18708b7 100644
--- a/scripts/drbd.rules
+++ b/scripts/drbd.rules
@@ -1,5 +1,7 @@
 # This file contains the rules to create named DRBD devices.
 
+SUBSYSTEM!="block", GOTO="drbd_end"
+
 # DO NOT WRAP THIS LINE
 #
 # old udev does not understand some of it,
@@ -13,3 +15,5 @@
 #
 # DO NOT WRAP THIS LINE
 KERNEL=="drbd*", IMPORT{program}="/sbin/drbdadm sh-udev minor-%m", NAME="$env{DEVICE}", SYMLINK="drbd/by-res/$env{RESOURCE} drbd/by-disk/$env{DISK}"
+
+LABEL="drbd_end"
-- 
1.7.5.4

