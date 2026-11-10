Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328026;
	b=bAhx8fIpMIw8RPrz1gtQgxdgjQbqC9hd5DscL08cVNdHFgJrIqdVmY3JSSps/9n3K9xV
	 t8cMBosbKD+165zu3di5vFJZuYifrG/eSNDGCy53fH23AaezBivOkpUljN0wBinlfiF//
	 M+mGOd+yRkqXTT5VRXGP/xR147PYROmH9O98t5o3yO1Fn6iudFrcsMFzxGIRqQxv3uGNL
	 /oL4tlHqMU39QL/fDGrzT7PXVwdt3FS/kTSUg9+3xQ3zgqshDz6eOEWMnHcdmQ5sgJuaV
	 thR+N8x5Honze9mn9TzpFAQIcfa4vzGgIEonqH/wwIhw123O7QLHALX27fcOzfCc6QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DvKoQYUA8YO38iyCS/TR64Li3qrQPpI5xw5GMTAlH4I=;
	b=AOCMorTrAoUaBTtlqTKDo+GmL553ncPROX+LPYaX/BOigJKoibzNDJh3Dz6IoJWeNq+F
	 inmx92zvc9ONlphPYgpuvuDCQItKbV3YquYR1potqTjq1mqUw542FdBTACEE8oaibJBs/
	 Yviauprn1bQT63893rZ4M2LK8P6NmS+mN0OTle9no9ix2fSH3+AjgHSFKQKqhNmq31Cqk
	 7R9yR4AifLwAOQsM1H+7xbqiVZjI2xR3QcczBQf3TdZblljlurodS+iGtTyGdO8Cj1p+X
	 Fh46kXVjUsKBsSiRPz4PZoM8+fLc19KBaO0+3Q0GZW/Bhacb/fpQO7kuylqXEj4VcKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=VKOCpOol;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E160A2622
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338E160A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=VKOCpOol
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so18414835e9.2
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328024; x=1794932824; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvKoQYUA8YO38iyCS/TR64Li3qrQPpI5xw5GMTAlH4I=;
        b=VKOCpOolpHU8vwqWrlRKPbxBvDsbM8Pb9lziJBO5gfdOAR5ukbhgXqkNPQ5VW6TcrC
         uXpn+e5gHlh0uCqG4UosNMy83jdbXAKcZs2WayddSSo2YUP1LB+dyYowEunkqGZFHbAm
         emYz4FZjpCVdX7ONvo57r8CZnS1KEzHy7cjT71uU0yAKvvAWKm8hXRd8uq2r5O8eCz71
         wpUGGFt0bPmFP7T8LmJ4/nhLlhnZvjJuOeNH9g3KOZe8FxUljffCycWZXTjKL3BB7QBI
         Eqnx+cTYL2lJLFZNT+v8zCaENNBjn0xeeuKq24wVnpmVenQTtgZlVwakcDK27VsJzYSj
         SuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328024; x=1794932824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvKoQYUA8YO38iyCS/TR64Li3qrQPpI5xw5GMTAlH4I=;
        b=Ql0rhwctlg/oqGHCoRB3/9K7f5Q2mIf0hkP0tWhJfuBknU3VvgWQ/SNw+J/TB237LU
         TyZKkveQQZYk4x8B7RurUco04Z8+ap5pOyWb+wW07pQmYA0cgAzzhsW0Hi1SLzVpBfMY
         /wCvCqQuQ6TXYWaMxIAX4sqIOyorZONmP45ShqhXvut3xj7/As7vD0fbKrAfNdSeVZLy
         QC6e41UWs07EanBILFmh53ZTpJaMn1vdNqFSWXEu4zHQ5aPaN/D/BB1AkWRMVjugcdrv
         rE7KFnbSM6GSje3MyN1Cgj2NE2sQjCzX1meY6PWQ2SJ4TO0XPun1zk2NwqAsNJwO2NeU
         7XMQ==
X-Gm-Message-State: APuU4Z8pRqx80q1/xGbLiWmTEiqekxxV6B5trVz+6PpHalcyc1vSEex3
	jlIF/VWo+RD5vln39w6b9q46EQS265GE/fiReT2UIiRkuzERhotrXcdk62dhgS07KzI=
X-Gm-Gg: AYBFou00ghVnJvLzY+aB1XeyCmatl7avBB0XvPrz/nAWVganPyRzcxpj4fJZKO2pfTC
	GYABCXyWbztdRj9caibfgFiC//NbGzj8mZNyxRcE05Y7fk2xhL8CMhWaGqkMUJfvM98un1L451B
	uMGknwJkyDKQzYu5nUWsTj4sDy3eCRlTEZBkZna0iGxTs/oZhTo5d2TeyTIAPZblBfK871d/7+1
	dTSfjHtJArq9DGmMqGuqF8T8cNxY0fyH9DFMIfzbzx9TAwy1vZ3/3bEiCEyOPI3pe1oxFfxssaQ
	oGzpgbzeyQG1BiXOXVwen8HVwVwnytKQxlNErPvt00GHHWblHrniPQht5U4REzIrqyrs5OUJuAe
	E1ESx78A5KcWzM9Jb7cAoDI2pEOioQwBRsbj3d6RVzfupRhCqi5TlidftcKSRwcF8HCO2Fa0c8J
	dkqlN+vzy8NX6nT7YCaXUbyEs/SITtaED1tvs6Oun/E+sOTgN3qaORKbCUnOpk++Myr/UVOdmwL
	KaSCllI85HutA8F+lHKZtvZ9SlOz5k6/uY0CVy+jMXGnjlovPRyk5njl6TRrgmQexGaAKi31XoT
	AUNa5I/E5cGvcmIyaBjUCzmV91jKhGBLqidoSGvAGKn+yruVA+tMf8wCeIz4zbUv5o/yEKJU0w=
	=
X-Received: by 2002:a05:600c:4f48:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4ba0234bc33mr62121105e9.24.1794328024456;
        Tue, 10 Nov 2026 08:27:04 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:27:03 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev
Subject: [PATCH v3 06/20] drbd: add DAX/PMEM support for metadata access
Date: Tue, 10 Nov 2026 17:26:31 +0100
Message-ID: <20261110162646.3028472-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
References: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
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
 drivers/block/drbd/drbd_dax_pmem.c | 175 +++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_dax_pmem.h |  43 +++++++
 3 files changed, 219 insertions(+)
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
index 000000000000..1fb22e57cf5d
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+ */
+
+/*
+ * In case DRBD's meta-data resides in persistent memory do a few things
+ * different.
+ *
+ * 1 direct access the bitmap in place. Do not load it into DRAM, do not
+ *   write it back from DRAM.
+ * 2 Use a better fitting format for the on-disk activity log. Instead of
+ *   writing transactions, the unmangled LRU-cache hash table is there.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/dax.h>
+#include <linux/libnvdimm.h>
+#include <linux/blkdev.h>
+#include <linux/sizes.h>
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
+	/* The activity log area holds the magic followed by the slots. */
+	int i, al_slots = device->ldev->md.al_size_4k * (SZ_4K / sizeof(*slots)) - 1;
+
+	al_on_pmem->magic = cpu_to_be32(DRBD_AL_PMEM_MAGIC);
+	/*
+	 * Initialize all slots rather than just the configured number in case
+	 * the configuration is later changed.
+	 */
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
2.56.0

