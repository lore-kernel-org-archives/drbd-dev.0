Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1B36C105572D
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 18:38:44 +0100 (CET)
Received: by mail-bw0-f54.google.com with SMTP id zs8so1533682bkb.27
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 09:38:44 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 16 Nov 2011 18:38:25 +0100
Message-Id: <1321465105-13769-4-git-send-email-florian@hastexo.com>
In-Reply-To: <1321465105-13769-1-git-send-email-florian@hastexo.com>
References: <1321465105-13769-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH 3/3] User's Guide: add chapter on
	high-performance replication
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Also, fix a whitespace issue in the preceding chapter.
---
 users-guide/drbd-users-guide.txt |    1 +
 users-guide/latency.txt          |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/users-guide/drbd-users-guide.txt b/users-guide/drbd-users-guide.txt
index f63d0e5..ddeaf13 100644
--- a/users-guide/drbd-users-guide.txt
+++ b/users-guide/drbd-users-guide.txt
@@ -37,6 +37,7 @@ include::xen.txt[]
 include::benchmark.txt[]
 include::throughput.txt[]
 include::latency.txt[]
+include::hp-transports.txt[]
 
 [[p-learn]]
 = Learning more about DRBD
diff --git a/users-guide/latency.txt b/users-guide/latency.txt
index 3f6fa11..deab8dc 100644
--- a/users-guide/latency.txt
+++ b/users-guide/latency.txt
@@ -176,3 +176,4 @@ You may also make a global I/O scheduler selection by passing the
 boot loader configuration (normally found in +/boot/grub/menu.lst+ if
 you are using the GRUB bootloader) and add +elevator=deadline+ to your
 list of kernel boot options.
+
-- 
1.7.5.4

