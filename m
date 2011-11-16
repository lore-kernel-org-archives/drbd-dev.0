Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A65C31055725
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 18:38:42 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so1533725bkb.27
	for <drbd-dev@lists.linbit.com>; Wed, 16 Nov 2011 09:38:42 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 16 Nov 2011 18:38:23 +0100
Message-Id: <1321465105-13769-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1321465105-13769-1-git-send-email-florian@hastexo.com>
References: <1321465105-13769-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH 1/3] User's Guide: add section on DRBD over
	InfiniBand
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 users-guide/hp-transports.txt |   89 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 users-guide/hp-transports.txt

diff --git a/users-guide/hp-transports.txt b/users-guide/hp-transports.txt
new file mode 100644
index 0000000..428e6ae
--- /dev/null
+++ b/users-guide/hp-transports.txt
@@ -0,0 +1,89 @@
+== High-performance replication transports
+
+This chapter outlines the configuration steps necessary to run DRBD
+over replication networks optimized for performance. DRBD supports two
+dedicated high-performance transports for replication:
+
+* *InfiniBand*, an industry standard implemented by several vendors,
+* *Dolphin Express*, a vendor specific interconnect available from
+  Dolphin Interconnect Solutions.
+
+=== Replication over InfiniBand networks
+
+DRBD supports replication with InfiniBand using two different
+approaches.
+
+==== IPoIB
+
+In *IP-over-InfiniBand* (IPoIB) an InfiniBand adapter is configured to
+host an IPv4 address, just like an Ethernet network card. For IPoIB,
+no specific changes to the DRBD configuration are necessary. You
+simply assign an IPv4 +address+ bound to an InfiniBand adapter in your
+resource configuration. DRBD then replicates using TCP over IP --
+albeit not based on Ethernet as it normally would, but on InfiniBand.
+
+To enable IPoIB, you need to enable the +ib_ipoib+ driver, typically
+available on any system stock kernel as a loadable module. Make sure
+that you configure the IPoIB driver to run in the Reliable Connected
+(RC) transport mode.
+
+NOTE: The configuration of an IP address on an IPoIB is beyond the
+scope of this guide, and may vary between distributions. However, it
+is usually equivalent to the configuration of an Ethernet interface --
+simply replace +ethX+ with +ibX+ in the interface configuration.
+
+In the example below, +192.168.144.111+ and +192.168.144.112+ would be
+bound to an IPoIB interface -- for example, +ib0+.
+
+  resource ib {
+  [...]
+    on alice {
+      address 192.168.144.111:7788;
+    }
+    on bob {
+      address 192.168.144.112:7788;
+    }
+  }
+
+==== SDP
+
+Sockets Direct Protocol (SDP) is an in-kernel BSD-style socket
+implementation for RDMA capable transports, such as InfiniBand. DRBD
+can use SDP for replication directly, without the intermediate TCP/IP
+layer that IPoIB requires. SDP uses IPoIB for an _addressing_
+purposes, however this does not imply that the _transport_ itself is
+IP (or TCP) based.
+
+SDP requires that
+
+* the +ib_sdp+ kernel module is present and loaded. Most distributions
+  ship this in a package separate from the standard stock kernel
+  image. A number of distributions ship SDP in a package named +ofed+
+  or similar.
+* an IPoIB address is configured on the InfiniBand adapter to be used
+  for SDP replication.
+
+NOTE: OFED is the Open Fabrics Enterprise Distribution, a stack of
+kernel drivers and userspace libraries for use with RDMA capable
+fabrics. It is maintained by the Open Fabrics Alliance (OFA).
+
+IMPORTANT: *Do not* use an OFED distribution prior to release 1.5 for
+DRBD-over-SDP replication. The SDP implementation in earlier OFED
+releases contains critical issues that make it unsuitable for DRBD
+replication.
+
+In the example below, +192.168.144.111+ and +192.168.144.112+ would be
+bound to an IPoIB interface -- for example, +ib0+. The +sdp+ keyword,
+prefixed to the replication address, configures DRBD to replicate over
+SDP.
+
+  resource ib {
+  [...]
+    on alice {
+      address sdp 192.168.144.111:7788;
+    }
+    on bob {
+      address sdp 192.168.144.112:7788;
+    }
+  }
+
-- 
1.7.5.4

