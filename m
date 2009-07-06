Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Mon,  6 Jul 2009 17:39:35 +0200
Message-Id: <1246894775-10855-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1246894775-10855-16-git-send-email-philipp.reisner@linbit.com>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-2-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-3-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-4-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-5-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-6-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-7-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-8-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-9-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-10-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-11-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-12-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-13-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-14-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-15-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-16-git-send-email-philipp.reisner@linbit.com>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/16] drbd: Kconfig and Makefile bits
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

---
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index bb72ada..f4a0988 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -271,6 +271,8 @@ config BLK_DEV_CRYPTOLOOP
 	  instead, which can be configured to be on-disk compatible with the
 	  cryptoloop device.
 
+source "drivers/block/drbd/Kconfig"
+
 config BLK_DEV_NBD
 	tristate "Network block device support"
 	depends on NET
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 7755a5e..33f0046 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -35,5 +35,6 @@ obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
 
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
+obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
 
 swim_mod-objs	:= swim.o swim_asm.o
diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
new file mode 100644
index 0000000..f133a89
--- /dev/null
+++ b/drivers/block/drbd/Kconfig
@@ -0,0 +1,80 @@
+#
+# DRBD device driver configuration
+#
+
+comment "DRBD disabled because PROC_FS, INET or CONNECTOR not selected"
+	depends on !PROC_FS || !INET || !CONNECTOR
+
+config BLK_DEV_DRBD
+	tristate "DRBD Distributed Replicated Block Device support"
+	depends on PROC_FS && INET && CONNECTOR
+	select LRU_CACHE
+	help
+
+	  NOTE: In order to authenticate connections you have to select
+	  CRYPTO_HMAC and a hash function as well.
+
+	  DRBD is a shared-nothing, synchronously replicated block device. It
+	  is designed to serve as a building block for high availability
+	  clusters and in this context, is a "drop-in" replacement for shared
+	  storage. Simplistically, you could see it as a network RAID 1.
+
+	  Each minor device has a role, which can be 'primary' or 'secondary'.
+	  On the node with the primary device the application is supposed to
+	  run and to access the device (/dev/drbdX). Every write is sent to
+	  the local 'lower level block device' and, across the network, to the
+	  node with the device in 'secondary' state.  The secondary device
+	  simply writes the data to its lower level block device.
+
+	  DRBD can also be used in dual-Primary mode (device writable on both
+	  nodes), which means it can exhibit shared disk semantics in a
+	  shared-nothing cluster.  Needless to say, on top of dual-Primary
+	  DRBD utilizing a cluster file system is necessary to maintain for
+	  cache coherency.
+
+	  For automatic failover you need a cluster manager (e.g. heartbeat).
+	  See also: http://www.drbd.org/, http://www.linux-ha.org
+
+	  If unsure, say N.
+
+config DRBD_TRACE
+	tristate "DRBD tracing"
+	depends on BLK_DEV_DRBD
+	select TRACEPOINTS
+	help
+
+	  Say Y here if you want to be able to trace various events in DRBD.
+
+	  If unsure, say N.
+
+config DRBD_FAULT_INJECTION
+	bool "DRBD fault injection"
+	depends on BLK_DEV_DRBD
+	help
+
+	  Say Y here if you want to simulate IO errors, in order to test DRBD's
+	  behavior.
+
+	  The actual simulation of IO errors is done by writing 3 values to
+	  /sys/module/drbd/parameters/
+
+	  enable_faults: bitmask of...
+	  1	meta data write
+	  2               read
+	  4	resync data write
+	  8	            read
+	  16	data write
+	  32	data read
+	  64	read ahead
+	  128	kmalloc of bitmap
+	  256	allocation of EE (epoch_entries)
+
+	  fault_devs: bitmask of minor numbers
+	  fault_rate: frequency in percent
+
+	  Example: Simulate data write errors on /dev/drbd0 with a probability of 5%.
+		echo 16 > /sys/module/drbd/parameters/enable_faults
+		echo 1 > /sys/module/drbd/parameters/fault_devs
+		echo 5 > /sys/module/drbd/parameters/fault_rate
+
+	  If unsure, say N.
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
new file mode 100644
index 0000000..68d1e7c
--- /dev/null
+++ b/drivers/block/drbd/Makefile
@@ -0,0 +1,8 @@
+drbd-y := drbd_bitmap.o drbd_proc.o
+drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
+
+drbd_trace-y := drbd_tracing.o drbd_strings.o
+
+obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
+obj-$(CONFIG_DRBD_TRACE)       += drbd_trace.o
