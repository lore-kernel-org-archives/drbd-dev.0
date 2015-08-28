Return-Path: <BATV+bd67e5505ea4382539b6+4387+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4851210518BD
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 09:30:44 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Date: Fri, 28 Aug 2015 09:27:14 +0200
Message-Id: <1440746842-19029-2-git-send-email-hch@lst.de>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: [Drbd-dev] [PATCH 1/9] move io-64-nonatomic*.h out of asm-generic
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

These are not implementations of default architecture code but helpers
for drivers. Move them to the place they belong to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/acpi/nfit.c                            |  2 +-
 drivers/block/nvme-core.c                      |  2 +-
 drivers/edac/i3200_edac.c                      |  2 +-
 drivers/edac/ie31200_edac.c                    |  2 +-
 drivers/edac/x38_edac.c                        |  2 +-
 drivers/i2c/busses/i2c-ismt.c                  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h   |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_osdep.h |  2 +-
 drivers/net/ethernet/rocker/rocker.c           |  2 +-
 drivers/platform/x86/ibm_rtl.c                 |  2 +-
 drivers/platform/x86/intel_ips.c               |  2 +-
 drivers/scsi/qla4xxx/ql4_nx.c                  |  2 +-
 include/asm-generic/io-64-nonatomic-hi-lo.h    | 32 --------------------------
 include/asm-generic/io-64-nonatomic-lo-hi.h    | 32 --------------------------
 include/linux/io-64-nonatomic-hi-lo.h          | 32 ++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h          | 32 ++++++++++++++++++++++++++
 16 files changed, 76 insertions(+), 76 deletions(-)
 delete mode 100644 include/asm-generic/io-64-nonatomic-hi-lo.h
 delete mode 100644 include/asm-generic/io-64-nonatomic-lo-hi.h
 create mode 100644 include/linux/io-64-nonatomic-hi-lo.h
 create mode 100644 include/linux/io-64-nonatomic-lo-hi.h

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index bb29e56..16c8c94 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -26,7 +26,7 @@
  * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
  * irrelevant.
  */
-#include <asm-generic/io-64-nonatomic-hi-lo.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 
 static bool force_enable_dimms;
 module_param(force_enable_dimms, bool, S_IRUGO|S_IWUSR);
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..b3033d3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -41,7 +41,7 @@
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <scsi/sg.h>
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 4ad062b..1f45338 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include "edac_core.h"
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #define I3200_REVISION        "1.1"
 
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index a981dc6..18d77ac 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -39,7 +39,7 @@
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "edac_core.h"
 
 #define IE31200_REVISION "1.0"
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 7c5cdc6..314cf5c 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -15,7 +15,7 @@
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "edac_core.h"
 
 #define X38_REVISION		"1.1"
diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index f994712..39becbb 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -67,7 +67,7 @@
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /* PCI Address Constants */
 #define SMBBAR		0
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index ad802dd..5b6feb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -35,7 +35,7 @@
 #include <linux/highuid.h>
 
 /* get readq/writeq support for 32 bit kernels, use the low-first version */
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /* File to be the magic between shared code and
  * actual OS primitives
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
index 21a91b1..5e314fd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
@@ -34,7 +34,7 @@
 #include <linux/pci.h>
 
 /* get readq/writeq support for 32 bit kernels, use the low-first version */
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /* File to be the magic between shared code and
  * actual OS primitives
diff --git a/drivers/net/ethernet/rocker/rocker.c b/drivers/net/ethernet/rocker/rocker.c
index 2e7f9a2..be06cf6 100644
--- a/drivers/net/ethernet/rocker/rocker.c
+++ b/drivers/net/ethernet/rocker/rocker.c
@@ -36,7 +36,7 @@
 #include <net/ip_fib.h>
 #include <net/netevent.h>
 #include <net/arp.h>
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <generated/utsrelease.h>
 
 #include "rocker.h"
diff --git a/drivers/platform/x86/ibm_rtl.c b/drivers/platform/x86/ibm_rtl.c
index 97c2be1..c62e5e1 100644
--- a/drivers/platform/x86/ibm_rtl.c
+++ b/drivers/platform/x86/ibm_rtl.c
@@ -33,7 +33,7 @@
 #include <linux/mutex.h>
 #include <asm/bios_ebda.h>
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 static bool force;
 module_param(force, bool, 0);
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index e2065e0..55663b3 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -78,7 +78,7 @@
 #include <asm/processor.h>
 #include "intel_ips.h"
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #define PCI_DEVICE_ID_INTEL_THERMAL_SENSOR 0x3b32
 
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index 7c33658..ae87d6c 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -12,7 +12,7 @@
 #include "ql4_glbl.h"
 #include "ql4_inline.h"
 
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #define TIMEOUT_100_MS	100
 #define MASK(n)		DMA_BIT_MASK(n)
diff --git a/include/asm-generic/io-64-nonatomic-hi-lo.h b/include/asm-generic/io-64-nonatomic-hi-lo.h
deleted file mode 100644
index 2e29d13..0000000
--- a/include/asm-generic/io-64-nonatomic-hi-lo.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef _ASM_IO_64_NONATOMIC_HI_LO_H_
-#define _ASM_IO_64_NONATOMIC_HI_LO_H_
-
-#include <linux/io.h>
-#include <asm-generic/int-ll64.h>
-
-static inline __u64 hi_lo_readq(const volatile void __iomem *addr)
-{
-	const volatile u32 __iomem *p = addr;
-	u32 low, high;
-
-	high = readl(p + 1);
-	low = readl(p);
-
-	return low + ((u64)high << 32);
-}
-
-static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
-{
-	writel(val >> 32, addr + 4);
-	writel(val, addr);
-}
-
-#ifndef readq
-#define readq hi_lo_readq
-#endif
-
-#ifndef writeq
-#define writeq hi_lo_writeq
-#endif
-
-#endif	/* _ASM_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/asm-generic/io-64-nonatomic-lo-hi.h b/include/asm-generic/io-64-nonatomic-lo-hi.h
deleted file mode 100644
index 0efacff..0000000
--- a/include/asm-generic/io-64-nonatomic-lo-hi.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef _ASM_IO_64_NONATOMIC_LO_HI_H_
-#define _ASM_IO_64_NONATOMIC_LO_HI_H_
-
-#include <linux/io.h>
-#include <asm-generic/int-ll64.h>
-
-static inline __u64 lo_hi_readq(const volatile void __iomem *addr)
-{
-	const volatile u32 __iomem *p = addr;
-	u32 low, high;
-
-	low = readl(p);
-	high = readl(p + 1);
-
-	return low + ((u64)high << 32);
-}
-
-static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
-{
-	writel(val, addr);
-	writel(val >> 32, addr + 4);
-}
-
-#ifndef readq
-#define readq lo_hi_readq
-#endif
-
-#ifndef writeq
-#define writeq lo_hi_writeq
-#endif
-
-#endif	/* _ASM_IO_64_NONATOMIC_LO_HI_H_ */
diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
new file mode 100644
index 0000000..11d7e84
--- /dev/null
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -0,0 +1,32 @@
+#ifndef _LINUX_IO_64_NONATOMIC_HI_LO_H_
+#define _LINUX_IO_64_NONATOMIC_HI_LO_H_
+
+#include <linux/io.h>
+#include <asm-generic/int-ll64.h>
+
+static inline __u64 hi_lo_readq(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	high = readl(p + 1);
+	low = readl(p);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
+{
+	writel(val >> 32, addr + 4);
+	writel(val, addr);
+}
+
+#ifndef readq
+#define readq hi_lo_readq
+#endif
+
+#ifndef writeq
+#define writeq hi_lo_writeq
+#endif
+
+#endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
new file mode 100644
index 0000000..1a4315f
--- /dev/null
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -0,0 +1,32 @@
+#ifndef _LINUX_IO_64_NONATOMIC_LO_HI_H_
+#define _LINUX_IO_64_NONATOMIC_LO_HI_H_
+
+#include <linux/io.h>
+#include <asm-generic/int-ll64.h>
+
+static inline __u64 lo_hi_readq(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	low = readl(p);
+	high = readl(p + 1);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
+{
+	writel(val, addr);
+	writel(val >> 32, addr + 4);
+}
+
+#ifndef readq
+#define readq lo_hi_readq
+#endif
+
+#ifndef writeq
+#define writeq lo_hi_writeq
+#endif
+
+#endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
-- 
1.9.1

