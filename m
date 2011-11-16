Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AFF2F105572F
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 18:38:44 +0100 (CET)
Received: by mail-bw0-f54.google.com with SMTP id zs8so1533725bkb.27
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 09:38:44 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 16 Nov 2011 18:38:24 +0100
Message-Id: <1321465105-13769-3-git-send-email-florian@hastexo.com>
In-Reply-To: <1321465105-13769-1-git-send-email-florian@hastexo.com>
References: <1321465105-13769-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH 2/3] User's Guide: add section about Dolphin
	SuperSockets replication
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 users-guide/hp-transports.txt |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/users-guide/hp-transports.txt b/users-guide/hp-transports.txt
index 428e6ae..35fa5bd 100644
--- a/users-guide/hp-transports.txt
+++ b/users-guide/hp-transports.txt
@@ -87,3 +87,43 @@ SDP.
     }
   }
 
+=== Replication over Dolphin Express interconnects
+
+DRBD replicates over Dolphin Express interconnects using the
+SuperSockets protocol.
+
+In order to replicate over SuperSockets, DRBD requires that
+
+- you have a working Dolphin Express hardware interconnect between
+  nodes;
+- you have installed the SuperSockets driver and libraries from the
+  Self-Installing Archive (SIA) available from Dolphin;
+- you have configured your nodes as a Dolphin cluster with valid
+  +/etc/dis/dishosts+ and +/etc/dis/networkmanager.conf+ files;
+- the +dis_nodemgr+ service is running.
+
+NOTE: A convenient way to configure the Dolphin cluster is the
+graphical +dis_netconfig+ utility. For further information regarding
+the installation and initial configuration of Dolphin Express
+interconnects on Linux, please refer to the
+http://ww.dolphinics.no/download/IX_4_0_X_LINUX_DOC/index.html[Dolphin
+Express IX Installation and Reference Guide].
+
+Once SuperSockets are properly installed and configured, set the
++ssocks+ keyword on your resource configuration:
+
+  resource ssocks {
+  [...]
+    on alice {
+      address ssocks 192.168.144.111:7788;
+    }
+    on bob {
+      address ssocks 192.168.144.112:7788;
+    }
+  }
+
+IMPORTANT: SuperSockets provide transparent, seamless fallback to
+Ethernet in case the Dolphin Express interconnect is
+interrupted. Thus, the IPv4 address specified after the +address
+ssocks+ keywords _must_ be an address available and configured on an
+Ethernet interface.
-- 
1.7.5.4

