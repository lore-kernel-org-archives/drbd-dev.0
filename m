Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 348191011BF7
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2019 13:39:27 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id e3so3919837wrs.11
	for <drbd-dev@lists.linbit.com>; Mon, 01 Jul 2019 04:39:27 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	v15sm9461026wrt.25.2019.07.01.04.39.26
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 01 Jul 2019 04:39:26 -0700 (PDT)
Resent-Message-ID: <20190701113925.GD6950@soda.linbit>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B56B1028A7C
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2019 15:00:13 +0200 (CEST)
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Date: Fri, 28 Jun 2019 09:30:29 -0300
Message-Id: <d3cd5d1309647bd16b3590419e7a2387eaf24bad.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Kukjin Kim <kgene@kernel.org>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-arm-kernel@lists.infradead.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 36/39] docs: add SPDX tags to new index files
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

All those new files I added are under GPL v2.0 license.

Add the corresponding SPDX headers to them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/blockdev/drbd/figures.rst | 2 ++
 Documentation/admin-guide/blockdev/index.rst        | 2 ++
 Documentation/admin-guide/laptops/index.rst         | 1 +
 Documentation/admin-guide/namespaces/index.rst      | 2 ++
 Documentation/admin-guide/perf/index.rst            | 2 ++
 Documentation/arm/index.rst                         | 2 ++
 Documentation/arm/nwfpe/index.rst                   | 2 ++
 Documentation/arm/omap/index.rst                    | 2 ++
 Documentation/arm/sa1100/index.rst                  | 2 ++
 Documentation/arm/samsung-s3c24xx/index.rst         | 2 ++
 Documentation/arm/samsung/index.rst                 | 2 ++
 Documentation/driver-api/early-userspace/index.rst  | 2 ++
 Documentation/driver-api/md/index.rst               | 2 ++
 Documentation/driver-api/memory-devices/index.rst   | 2 ++
 Documentation/driver-api/mmc/index.rst              | 2 ++
 Documentation/driver-api/mtd/index.rst              | 2 ++
 Documentation/driver-api/nfc/index.rst              | 2 ++
 Documentation/driver-api/nvdimm/index.rst           | 2 ++
 Documentation/driver-api/phy/index.rst              | 2 ++
 Documentation/driver-api/rapidio/index.rst          | 2 ++
 Documentation/driver-api/thermal/index.rst          | 2 ++
 Documentation/ia64/index.rst                        | 2 ++
 22 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/drbd/figures.rst b/Documentation/admin-guide/blockdev/drbd/figures.rst
index 3e3fd4b8a478..bd9a4901fe46 100644
--- a/Documentation/admin-guide/blockdev/drbd/figures.rst
+++ b/Documentation/admin-guide/blockdev/drbd/figures.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. The here included files are intended to help understand the implementation
 
 Data flows that Relate some functions, and write packets
diff --git a/Documentation/admin-guide/blockdev/index.rst b/Documentation/admin-guide/blockdev/index.rst
index 20a738d9d047..b903cf152091 100644
--- a/Documentation/admin-guide/blockdev/index.rst
+++ b/Documentation/admin-guide/blockdev/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 The Linux RapidIO Subsystem
 ===========================
diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
index 6b554e39863b..cd9a1c2695fd 100644
--- a/Documentation/admin-guide/laptops/index.rst
+++ b/Documentation/admin-guide/laptops/index.rst
@@ -1,3 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0
 
 ==============
 Laptop Drivers
diff --git a/Documentation/admin-guide/namespaces/index.rst b/Documentation/admin-guide/namespaces/index.rst
index 713ec4949fa7..384f2e0f33d2 100644
--- a/Documentation/admin-guide/namespaces/index.rst
+++ b/Documentation/admin-guide/namespaces/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==========
 Namespaces
 ==========
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9d445451ea18..ee4bfd2a740f 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 Performance monitor support
 ===========================
diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index 9c2f781f4685..5fc072dd0c5e 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ================
 ARM Architecture
 ================
diff --git a/Documentation/arm/nwfpe/index.rst b/Documentation/arm/nwfpe/index.rst
index 21fa8ce192ae..3c4d2f9aa10e 100644
--- a/Documentation/arm/nwfpe/index.rst
+++ b/Documentation/arm/nwfpe/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================================
 NetWinder's floating point emulator
 ===================================
diff --git a/Documentation/arm/omap/index.rst b/Documentation/arm/omap/index.rst
index f1e9c11d9f9b..8b365b212e49 100644
--- a/Documentation/arm/omap/index.rst
+++ b/Documentation/arm/omap/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =======
 TI OMAP
 =======
diff --git a/Documentation/arm/sa1100/index.rst b/Documentation/arm/sa1100/index.rst
index fb2385b3accf..68c2a280a745 100644
--- a/Documentation/arm/sa1100/index.rst
+++ b/Documentation/arm/sa1100/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ====================
 Intel StrongARM 1100
 ====================
diff --git a/Documentation/arm/samsung-s3c24xx/index.rst b/Documentation/arm/samsung-s3c24xx/index.rst
index 6c7b241cbf37..5b8a7f9398d8 100644
--- a/Documentation/arm/samsung-s3c24xx/index.rst
+++ b/Documentation/arm/samsung-s3c24xx/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ﻿==========================
 Samsung S3C24XX SoC Family
 ==========================
diff --git a/Documentation/arm/samsung/index.rst b/Documentation/arm/samsung/index.rst
index f54d95734362..8142cce3d23e 100644
--- a/Documentation/arm/samsung/index.rst
+++ b/Documentation/arm/samsung/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========
 Samsung SoC
 ===========
diff --git a/Documentation/driver-api/early-userspace/index.rst b/Documentation/driver-api/early-userspace/index.rst
index 6f20c3c560d8..149c1822f06d 100644
--- a/Documentation/driver-api/early-userspace/index.rst
+++ b/Documentation/driver-api/early-userspace/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============
 Early Userspace
 ===============
diff --git a/Documentation/driver-api/md/index.rst b/Documentation/driver-api/md/index.rst
index 205080891a1a..18f54a7d7d6e 100644
--- a/Documentation/driver-api/md/index.rst
+++ b/Documentation/driver-api/md/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ====
 RAID
 ====
diff --git a/Documentation/driver-api/memory-devices/index.rst b/Documentation/driver-api/memory-devices/index.rst
index 87549828f6ab..28101458cda5 100644
--- a/Documentation/driver-api/memory-devices/index.rst
+++ b/Documentation/driver-api/memory-devices/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =========================
 Memory Controller drivers
 =========================
diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
index 9aaf64951a8c..7339736ac774 100644
--- a/Documentation/driver-api/mmc/index.rst
+++ b/Documentation/driver-api/mmc/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ========================
 MMC/SD/SDIO card support
 ========================
diff --git a/Documentation/driver-api/mtd/index.rst b/Documentation/driver-api/mtd/index.rst
index 2e0e7cc4055e..436ba5a851d7 100644
--- a/Documentation/driver-api/mtd/index.rst
+++ b/Documentation/driver-api/mtd/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 Memory Technology Device (MTD)
 ==============================
diff --git a/Documentation/driver-api/nfc/index.rst b/Documentation/driver-api/nfc/index.rst
index 3afb2c0c2e3c..b6e9eedbff29 100644
--- a/Documentation/driver-api/nfc/index.rst
+++ b/Documentation/driver-api/nfc/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ========================
 Near Field Communication
 ========================
diff --git a/Documentation/driver-api/nvdimm/index.rst b/Documentation/driver-api/nvdimm/index.rst
index 19dc8ee371dc..a4f8f98aeb94 100644
--- a/Documentation/driver-api/nvdimm/index.rst
+++ b/Documentation/driver-api/nvdimm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================================
 Non-Volatile Memory Device (NVDIMM)
 ===================================
diff --git a/Documentation/driver-api/phy/index.rst b/Documentation/driver-api/phy/index.rst
index fce9ffae2812..69ba1216de72 100644
--- a/Documentation/driver-api/phy/index.rst
+++ b/Documentation/driver-api/phy/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =====================
 Generic PHY Framework
 =====================
diff --git a/Documentation/driver-api/rapidio/index.rst b/Documentation/driver-api/rapidio/index.rst
index 4c5e51a05134..a41b4242d16f 100644
--- a/Documentation/driver-api/rapidio/index.rst
+++ b/Documentation/driver-api/rapidio/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 The Linux RapidIO Subsystem
 ===========================
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 68ceb6886561..5ba61d19c6ae 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =======
 Thermal
 =======
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
index ef99475f672b..0436e1034115 100644
--- a/Documentation/ia64/index.rst
+++ b/Documentation/ia64/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================
 IA-64 Architecture
 ==================
-- 
2.21.0

