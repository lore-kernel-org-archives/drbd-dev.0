Return-Path: <florian@hastexo.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6DECA106DCC8
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 13:45:09 +0100 (CET)
Received: by wibhm17 with SMTP id hm17so604527wib.15
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 05:45:09 -0700 (PDT)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 22 Mar 2012 13:44:36 +0100
Message-Id: <1332420276-29946-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1332420276-29946-1-git-send-email-florian@hastexo.com>
References: <1332420276-29946-1-git-send-email-florian@hastexo.com>
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

