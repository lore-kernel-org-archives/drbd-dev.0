Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103C4A1E06
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301596; cv=none; b=DLNxQAFzZoq+AFb+S3PgZJ8nU77+EXIRfXRYUav7tz2UI/1nSNPh7EHDteq4YQgbDrJVXdXZVkcl4KvclZxjeuRnWu/9ItZPWa/rIaz9RHjSgOiMMEGZddwh7g3nS8gPrCjNR2UsPEc1/pNo2YXDNJW7lFJ0DqIQGjpPmXDVioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301596; c=relaxed/simple;
	bh=scs6scIw56YwIm2sWClvC1VeYrC3GUyqGRf3ki0n6aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKFcy3kc1DlEd7a/gvwcE4uCj2r0+s2vwj8bz42fh9JZjTv5AQSoU18KYCIN6ZA/w5TDFs4Qc0RB8b/CjGQem5yHRhpr3jjKzCVj11zUUMbhehLSwXAi5Ebrr7VdHCrF5yll7APtxBmIqvRucboGDY7MdaMvuCeEcXZ+8E0z54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=sLq9+P7X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="sLq9+P7X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so34849625e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301590; x=1791906390; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GQB5iucrV2gMhIlEfGoyyksTWa683vxS1H9EbJw7Gwc=;
        b=sLq9+P7Xgt3+x/fYpnemlq9YBY1KLYU5fp4OeFOkuNQvlgm4YkrB30x4285/KxXpOF
         7q/r8z0N6a3YQPtQVmDK+iAnqcx13DvAUtEEsyOFLSAd+A7PLpw+EQWRptNlDaKL2zoX
         V/MCYxb5SmdU3CmSv1kIxZAjBzdOIYt1Oq+VwNE1fmiimsY32B8+VRuHYyhPodm7w20w
         TuI3Jl7lFZyT8VsQTui8TerWp+Uj4KxdZ1RcWbZ/W/zZbqpCaEEWymr781M+8cmZX9oR
         qYLwJP5RLToBauDU0HEJTpLnDCMPFhVXU9pbkxCfrZcPjRPDi1fKIfjn5ZJL8Wxf5AIF
         7W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301590; x=1791906390;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQB5iucrV2gMhIlEfGoyyksTWa683vxS1H9EbJw7Gwc=;
        b=eRih+VnsAini1sQQa0OHdI0iFPy/XcttvKsHJdlXamQrYD8igeXPzMQ1FiKgny9XmT
         /0Id4bXjoCmHydqAd+UB8kBsgjvprVJO5UQkul71nzXEzlD91dIkcDX5Mx1WwDh+/nL+
         nGhyIMkPNhtBWzRNEzxFN36elA8fuP35nloBSx0e1c7Ho+J9R8gwCsDXWq1rh2sOlgLw
         ojUd7J1Ude3Px/pAdr3abTVcrhBBHYLf9U5Ld5vT6Kpc2VEHy+V9CN/oZu/yePKutk98
         IsByJLqpQi/2+uAk47gI6Diy0bhCN0EQdCTHy4mTyPKqae+HAIMa5/0ztvAddlW/Oek7
         QjQw==
X-Forwarded-Encrypted: i=1; AKwUvBwnnNDdh1TEa6vwoznrwW9hpF24zIDMSsxrXYjJ6ajFWEHAk2xu98+zytFjjbMk9PgahmgEugBBig==@lists.linux.dev
X-Gm-Message-State: AFuF++meXQAu/QTxVa05CA3LMw646yb7qhIyprbFd6g9TjBZbhEw/yI2
	J1C3bx1YjW15RSCrIlORLhUT+aRbGj5DynnD6yTL2jXQQhOyTWTg3+1NsNiYSorG12A=
X-Gm-Gg: AYBFou3Ju3NWyGfa45k2l12tMR7Yr9iQ96dXZMskNRWSTZ4JRQ3jYqLKLKrkt+SW9E8
	0w/x5xvYuXqLXQSXoof+6Mrxl8fBZUbJ6/TpYDmwfoePDkhqeKRK/X87Y6D/wfWyoWRoSsjh7os
	BfZIHtTJj3FdfHXrCfwWdh+ypq7ouHhE3GOce0oG+TJ+b0O4QX4Yr+2Xzg+0muT+a8qSwoZHHbo
	PhxPhyL+pLoqnOlV8omemlACwXGBEbScTORulqlDQVlXI88512RD1H4NOxEoG0GklRsRxnXVVvK
	/wHPinAcIYgz+tDGY+LFOKUtB+23yp9kft3K/lPaPYWFMMWB7eT92KBmTCo+H/f4NuiY453X2A0
	E7r7koRi9v93Dqk3tPSeP/8e/b9dRfOv+KEgnUElXCzpsUKxHyo8c3fVZp8G9IQXKwwyoM/HSuk
	yQ/F9LT/YJbJcmXZGNq2BO637S3jGSAFEmQFcc0E75sIMO0CtmiZTWAUwteQvQIMlMDOOjd5e3Y
	9rNj5ityN73Xa41TxsWHs1iVGruAhtG
X-Received: by 2002:a05:600c:4e91:b0:4a1:7811:6cc4 with SMTP id 5b1f17b1804b1-4a178116ce2mr59785645e9.34.1791301590487;
        Tue, 06 Oct 2026 08:46:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:29 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 06/20] drbd: add DAX/PMEM support for metadata access
Date: Tue,  6 Oct 2026 17:45:53 +0200
Message-ID: <20261006154607.3936501-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When DRBD's metadata device resides on persistent memory (PMEM/NVDIMM),
accessing it by reading and writing full blocks is unnecessarily
costly.
Add a DAX-based metadata path that directly maps the metadata region,
enabling byte-granular, IRQ-safe access without having to go through
the block layer.

The PMEM path also introduces a more efficient activity log layout:
instead of writing journal transactions, the in-memory LRU-cache hash
table is stored directly in persistent memory and updated in-place.
Similarly, the resync bitmap is accessed directly from PMEM rather than
being loaded into and flushed from DRAM.

This is compiled in only when CONFIG_DEV_DAX_PMEM is enabled.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile        |   1 +
 drivers/block/drbd/drbd_dax_pmem.c | 172 +++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_dax_pmem.h |  43 ++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 9f05f74e619c..8ec1ad360449 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -5,6 +5,7 @@ drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
 drbd-y += drbd_transport.o
+drbd-$(CONFIG_DEV_DAX_PMEM) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
diff --git a/drivers/block/drbd/drbd_dax_pmem.c b/drivers/block/drbd/drbd_dax_pmem.c
new file mode 100644
index 000000000000..138bf2af2bd1
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+ */
+
+/*
+  In case DRBD's meta-data resides in persistent memory do a few things
+   different.
+
+   1 direct access the bitmap in place. Do not load it into DRAM, do not
+     write it back from DRAM.
+   2 Use a better fitting format for the on-disk activity log. Instead of
+     writing transactions, the unmangled LRU-cache hash table is there.
+*/
+
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/dax.h>
+#include <linux/libnvdimm.h>
+#include <linux/blkdev.h>
+#include "drbd_int.h"
+#include "drbd_dax_pmem.h"
+#include "drbd_meta_data.h"
+
+/*
+ * Unit conversions for addressing the metadata area through DAX.
+ * DRBD keeps metadata offsets in sectors, dax_direct_access() works in pages.
+ */
+static pgoff_t md_sector_to_pgoff(sector_t sector)
+{
+	return sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+}
+
+static long md_sectors_to_pages(sector_t nr_sectors)
+{
+	return nr_sectors >> (PAGE_SHIFT - SECTOR_SHIFT);
+}
+
+/* Signed, since the bitmap offset relative to the superblock may be negative. */
+static long md_sector_offset_to_bytes(long sector_offset)
+{
+	return sector_offset * SECTOR_SIZE;
+}
+
+static int map_superblock_for_dax(struct drbd_backing_dev *bdev, struct dax_device *dax_dev)
+{
+	long want = 1;
+	pgoff_t pgoff = md_sector_to_pgoff(bdev->md.md_offset);
+	void *kaddr;
+	long len;
+	int id;
+
+	id = dax_read_lock();
+	len = dax_direct_access(dax_dev, pgoff, want, DAX_ACCESS, &kaddr, NULL);
+	dax_read_unlock(id);
+
+	if (len < want)
+		return -EIO;
+
+	bdev->md_on_pmem = kaddr;
+
+	return 0;
+}
+
+/**
+ * drbd_dax_open() - Open device for dax and map metadata superblock
+ * @bdev: backing device to be opened
+ */
+int drbd_dax_open(struct drbd_backing_dev *bdev)
+{
+	struct dax_device *dax_dev;
+	int err;
+	u64 part_off;
+
+	dax_dev = fs_dax_get_by_bdev(bdev->md_bdev, &part_off, NULL, NULL);
+	if (!dax_dev)
+		return -ENODEV;
+
+	err = map_superblock_for_dax(bdev, dax_dev);
+	if (!err)
+		bdev->dax_dev = dax_dev;
+	else
+		put_dax(dax_dev);
+
+	return err;
+}
+
+void drbd_dax_close(struct drbd_backing_dev *bdev)
+{
+	put_dax(bdev->dax_dev);
+}
+
+/**
+ * drbd_dax_map() - Map metadata for dax
+ * @bdev: backing device whose metadata is to be mapped
+ */
+int drbd_dax_map(struct drbd_backing_dev *bdev)
+{
+	struct dax_device *dax_dev = bdev->dax_dev;
+	sector_t first_sector = drbd_md_first_sector(bdev);
+	sector_t al_sector = bdev->md.md_offset + bdev->md.al_offset;
+	long want = md_sectors_to_pages(drbd_md_last_sector(bdev) + 1 - first_sector);
+	pgoff_t pgoff = md_sector_to_pgoff(first_sector);
+	long md_offset_byte = md_sector_offset_to_bytes(bdev->md.md_offset - first_sector);
+	long al_offset_byte = md_sector_offset_to_bytes(al_sector - first_sector);
+	void *kaddr;
+	long len;
+	int id;
+
+	id = dax_read_lock();
+	len = dax_direct_access(dax_dev, pgoff, want, DAX_ACCESS, &kaddr, NULL);
+	dax_read_unlock(id);
+
+	if (len < want)
+		return -EIO;
+
+	bdev->md_on_pmem = kaddr + md_offset_byte;
+	bdev->al_on_pmem = kaddr + al_offset_byte;
+
+	return 0;
+}
+
+void drbd_dax_al_update(struct drbd_device *device, struct lc_element *al_ext)
+{
+	struct al_on_pmem *al_on_pmem = device->ldev->al_on_pmem;
+	__be32 *slot = &al_on_pmem->slots[al_ext->lc_index];
+
+	*slot = cpu_to_be32(al_ext->lc_new_number);
+	arch_wb_cache_pmem(slot, sizeof(*slot));
+}
+
+
+void drbd_dax_al_begin_io_commit(struct drbd_device *device)
+{
+	struct lc_element *e;
+
+	spin_lock_irq(&device->al_lock);
+
+	list_for_each_entry(e, &device->act_log->to_be_changed, list)
+		drbd_dax_al_update(device, e);
+
+	lc_committed(device->act_log);
+
+	spin_unlock_irq(&device->al_lock);
+}
+
+int drbd_dax_al_initialize(struct drbd_device *device)
+{
+	struct al_on_pmem *al_on_pmem = device->ldev->al_on_pmem;
+	__be32 *slots = al_on_pmem->slots;
+	int i, al_slots = (device->ldev->md.al_size_4k << (12 - 2)) - 1;
+
+	al_on_pmem->magic = cpu_to_be32(DRBD_AL_PMEM_MAGIC);
+	/* initialize all slots rather than just the configured number in case
+	 * the configuration is later changed */
+	for (i = 0; i < al_slots; i++) {
+		unsigned int extent_nr = i < device->act_log->nr_elements ?
+			lc_element_by_index(device->act_log, i)->lc_number :
+			LC_FREE;
+		slots[i] = cpu_to_be32(extent_nr);
+	}
+
+	return 0;
+}
+
+void *drbd_dax_bitmap(struct drbd_device *device, unsigned long want)
+{
+	struct drbd_backing_dev *bdev = device->ldev;
+	unsigned char *md_on_pmem = (unsigned char *)bdev->md_on_pmem;
+
+	return md_on_pmem + md_sector_offset_to_bytes(bdev->md.bm_offset);
+}
diff --git a/drivers/block/drbd/drbd_dax_pmem.h b/drivers/block/drbd/drbd_dax_pmem.h
new file mode 100644
index 000000000000..52b116300122
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+ */
+#ifndef DRBD_DAX_H
+#define DRBD_DAX_H
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_DEV_DAX_PMEM)
+
+int drbd_dax_open(struct drbd_backing_dev *bdev);
+void drbd_dax_close(struct drbd_backing_dev *bdev);
+int drbd_dax_map(struct drbd_backing_dev *bdev);
+void drbd_dax_al_update(struct drbd_device *device, struct lc_element *al_ext);
+void drbd_dax_al_begin_io_commit(struct drbd_device *device);
+int drbd_dax_al_initialize(struct drbd_device *device);
+void *drbd_dax_bitmap(struct drbd_device *device, unsigned long want);
+
+static inline bool drbd_md_dax_active(struct drbd_backing_dev *bdev)
+{
+	return bdev->dax_dev != NULL;
+}
+static inline struct meta_data_on_disk_9 *drbd_dax_md_addr(struct drbd_backing_dev *bdev)
+{
+	return bdev->md_on_pmem;
+}
+#else
+
+#define drbd_dax_open(B) do { } while (0)
+#define drbd_dax_close(B) do { } while (0)
+#define drbd_dax_map(B) (-ENOTSUPP)
+#define drbd_dax_al_begin_io_commit(D) do { } while (0)
+#define drbd_dax_al_initialize(D) (-EIO)
+#define drbd_dax_bitmap(D, L) (NULL)
+#define drbd_md_dax_active(B) (false)
+#define drbd_dax_md_addr(B) (NULL)
+
+#define arch_wb_cache_pmem(A, L) do { } while (0)
+
+#endif /* IS_ENABLED(CONFIG_DEV_DAX_PMEM) */
+
+#endif /* DRBD_DAX_H */
-- 
2.55.0

