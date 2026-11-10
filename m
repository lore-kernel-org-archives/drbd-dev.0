Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328029;
	b=DVRqXx2IwhE7clP3W0h+ZbwTJ7USNoBPmCCM2YBTv/R2fgE39ddqcdTS8V/YGBdsMHAd
	 qytuEAmk127/JypFdIjpz0vO8NJajczkVuhT1u5xed1boJDFTiGo2UCUfHfvaAnD6HWZj
	 HKPbZr3mKk82yxaCyPP2b5S41WIX+IXJvNvORNfEs69oWhVc7nch2hKFuyb5gw0Z1ZmxM
	 tCXT0X+4j2VcwIEmY0Fxpth1Eb221S9oHn+T+8L8X7uV/PUiWj1zMSW9PbHsxhavTFtmI
	 xWwLNd6Whd6vbNkVzXcIzKhntYtcCXSy0sf4oPKLnN9E9egEgNDxXjhk2VFjqLpT9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=X5+mHRIHgkZQ+mf7Y+p6ZVQ3EpK9F7NK+M4Q6s7dSU4=;
	b=UWaKvBQI5oM7yQsHJkN0bWenm5U5FWO9Z7DtFX5HYf/xUVUgkRoA7Lncbdt0XdIiL1yW
	 Eik/RUxwf229hLJJORglaVeBqQYhhw2wUF1wIJOOcN6ewltnPe0IR16UhKMesFSHjDuK0
	 ADbvimYWxudMVuQ5pGCrBHgyFe1kdOKZhAcJNC4sdvfJFMillEEr0vD/VOR7jdRlg5cRg
	 MUqNB4uGj9dtIQF2jYSKLd81rKcrHZ6wuFQrgzEanh9TbgA+TBwMsGBoevh0IS8EyoQpl
	 jv/dCTqxguCrDIGiIFCMfLe3pd+Y/93nXAnV8Nwp3a+mj4hsizoGO9yieEPH+UjvA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b="cK/yTSMP";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5984606D7D9
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5984606D7D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=cK/yTSMP
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso16254675e9.1
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328026; x=1794932826; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5+mHRIHgkZQ+mf7Y+p6ZVQ3EpK9F7NK+M4Q6s7dSU4=;
        b=cK/yTSMPlHQ35qPn6LoO80y43NNqk8fW/+rcGgEKvug09qPiAjqO6mZpqlkHhBzlOb
         i7ZAjZpcTwC1xFQg5UsKyurN2V4z0yu9RScVbSQSp6g75AkkvX7RB62jfqAPjtfwoDat
         8IDuS82awSTWW2Yk1RjtLKZvCCvcYty6awLo32vnXsiJ+yHA2NhLsdRlCQF/zJgmlMVR
         IecvrUzI16hvtKk9D6uZ3cIcdh35KBLKal2vu7P8k8g55pwVxKnKusatqAFtSYnQGIw7
         L7575lO2E3LxVdjjvntIWnfWYoCuHhp5R4atWyLZN1MSi+84Oy4lG4FgKiro9Nn2bO+C
         QKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328026; x=1794932826;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5+mHRIHgkZQ+mf7Y+p6ZVQ3EpK9F7NK+M4Q6s7dSU4=;
        b=DeZY4fNn0n1sNByPrYq2g0Cv0WITHaBvZszgqeLJiwZK6399sD8V4YL4VjzWAuibmx
         Ngy5Oq00zkuIxnvTJqYwJLa3XSMepToEpO63uactAEgXk3VUe4As6iyZN8WfVBe2W80m
         R/9W46Lxmu29JPFL+HsgDtilA/OCZvdce+SmG6WfjJFRewD4mR6WAzviGvEQBpprcSZi
         ev3DaEz6l65rqHrEhFYFTLbJJvFID+15WLjA6/CPQLyXQ2k1yuZELPr9PCE30LBE1lBt
         KKtDTwvPMVwOFiSzuqJ6ivYFaL2OEfYZ12zP8YPoCBnUVZU06RxoLB0TXo5VQrcE7rY7
         mPkg==
X-Gm-Message-State: APuU4Z9Kc+a1Wl2WL3GCJI6Shnp8RW+wyzOhEsSEZWQNe/EwzmMd2iG0
	8DBP0VoZoclLh8Z8r/+69Wayr2Xedvynjn91FqqLFu7BpsUVbIszqw5pcvspoR+JNZM=
X-Gm-Gg: AYBFou3OIFdi6DPa/uTDrhntUe5wQnrs4CpFHY8Csg9IskZNTLPWrU/PGrGN2fWS6CE
	aIPOWXNnh5GNK7QsN6AcaCk4/rH3yk/vzGjF7OfNK0UDQDngvevzNtp4ndwyCSkYum9+HvQqTW4
	Z0F7YNfS1wLVHMpLchdJ7KUMAJugldsOFTWh2XoaFGoncqyre5/pEognP8z1MP9xeeNndlmGhkT
	VzQW5Glp/0l+GquZFwtwhqcOOnj7hY2Ms9crBylgr5t8rRf9CbW+WHg+SLlMLL7Nj4Kt+5F9MIp
	2WNq+ip8wjF+iYLBYGvjtEICXgkZ9EZgoQ70OHWzZ7+rLFPwFnpv8uLSFedKkZwLrbVRPsckKt+
	QZ4MLQ1n6OM2hlPNE+S3YE91VCHzDsjQrhqvbz3Uyb8aWzISdrh17MuJuX7mG2Z7WHuxjlFk6U9
	Ip+OBAdgPAVcqhwGVe5XwwQE4TFjevmk/cDVkAITFxcVYGXC5e4ALvcOvOgZJRaaKT4uLMltdHR
	lzP+kziDbsy3obK2DWdr86h5VyReqTtjN+L0Ug/Qo/kMMsb64d2fwrupQsnfuao4ERpN8kPFgBA
	gVyBp6dgtZZaXbjsFmBkKiQOvVdG2sSwEG4DRyeWcabnXKFVcJXyWzHLJudrRE6ribxjvw5Rg1N
	II55KW82cUj8royf05fo=
X-Received: by 2002:a05:600c:6383:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4ba022c9c97mr54366155e9.0.1794328025660;
        Tue, 10 Nov 2026 08:27:05 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:27:05 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH v3 07/20] drbd: add optional compatibility layer for DRBD 8.4
Date: Tue, 10 Nov 2026 17:26:32 +0100
Message-ID: <20261110162646.3028472-8-christoph.boehmwalder@linbit.com>
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

Introduce a Kconfig option, DRBD_COMPAT_84, that enables a
self-contained source module that encapsulates everything needed to
interoperate with the userspace and on-disk formats of DRBD 8.4 (the
version that has been shipped with the kernel until now).

This ensures compatibility with existing userspace tooling is kept.

The main DRBD code is deliberately kept as clean as possible from any
backward compatibility hacks, so that this acts as the "main switch" for
enabling compatibility with old DRBD userspace utilities.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig          |  26 ++
 drivers/block/drbd/Makefile         |   1 +
 drivers/block/drbd/drbd_legacy_84.c | 641 ++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_legacy_84.h | 116 +++++
 4 files changed, 784 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_legacy_84.c
 create mode 100644 drivers/block/drbd/drbd_legacy_84.h

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 49b75cbe1def..1b8b3f6efc1b 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -83,3 +83,29 @@ config BLK_DEV_DRBD_TCP
 	  for DRBD replication over TCP/IP networks.
 
 	  If unsure, say Y.
+
+config DRBD_COMPAT_84
+	bool "Enable legacy (8.4) /proc/drbd and metadata compatibility"
+	depends on BLK_DEV_DRBD
+	default y
+	help
+
+	  This option enables the DRBD-8.4 style representation of
+	  DRBD devices in /proc/drbd. With DRBD 9.0, released in 2015,
+	  we deprecated this interface. The replacement is `drbdsetup
+	  status [--json] <resname>`. The new interface is optionally
+	  machine-readable, extensible, and scales to 1000s of
+	  resources. The deprecated interface had issues with all
+	  three areas.
+	  At the same time, this option also enables the DRBD driver
+	  to read and write the deprecated 8.4 version of the
+	  metadata.
+	  Only when you create a DRBD resource in the legacy way
+	  `drbdsetup new-resource <resname>` (no node-id positional
+	  argument), then the resource is put into legacy mode, and
+	  shows up in /proc/drbd, is capable of reading and writing
+	  the 8.4 metadata, and can have only a single peer. Without
+	  this compile-time option, creating a resource without a node
+	  ID is not possible.
+
+	  If unsure, say Y.
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 8ec1ad360449..f184b99d6a93 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -7,6 +7,7 @@ drbd-y += drbd_nl_gen.o
 drbd-y += drbd_transport.o
 drbd-$(CONFIG_DEV_DAX_PMEM) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
+drbd-$(CONFIG_DRBD_COMPAT_84) += drbd_legacy_84.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
 obj-$(CONFIG_BLK_DEV_DRBD_TCP) += drbd_transport_tcp.o
diff --git a/drivers/block/drbd/drbd_legacy_84.c b/drivers/block/drbd/drbd_legacy_84.c
new file mode 100644
index 000000000000..0c2f0851f58a
--- /dev/null
+++ b/drivers/block/drbd/drbd_legacy_84.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, LINBIT HA-Solutions GmbH.
+ */
+
+#include "drbd_legacy_84.h"
+#include "drbd_meta_data.h"
+
+/* MDF_84_* masks and the flags table they encode are declared in
+ * drbd_legacy_84.h, shared with drbd_nl_84.c (GET_STATUS's disk_flags).
+ */
+
+struct meta_data_on_disk_84 {
+	u64 la_size_sect;      /* last agreed size. */
+	u64 uuid[UI_SIZE];   /* UUIDs. */
+	u64 device_uuid;
+	u64 reserved_u64_1;
+	u32 flags;             /* MDF */
+	u32 magic;
+	u32 md_size_sect;
+	u32 al_offset;         /* offset to this block */
+	u32 al_nr_extents;     /* important for restoring the AL (userspace) */
+	      /* `-- act_log->nr_elements <-- ldev->dc.al_extents */
+	u32 bm_offset;         /* offset to the bitmap, from here */
+	u32 bm_bytes_per_bit;  /* 4k. Treat as magic number, must keep it compatible. */
+	u32 la_peer_max_bio_size;   /* last peer max_bio_size */
+
+	/* see al_tr_number_to_on_disk_sector() */
+	u32 al_stripes;
+	u32 al_stripe_size_4k;
+
+	u8 reserved_u8[4096 - (7*8 + 10*4)];
+} __packed;
+
+
+static const char * const drbd_conn_s_names[] = {
+	[C_STANDALONE]       = "StandAlone",
+	[C_DISCONNECTING]    = "Disconnecting",
+	[C_UNCONNECTED]      = "Unconnected",
+	[C_TIMEOUT]          = "Timeout",
+	[C_BROKEN_PIPE]      = "BrokenPipe",
+	[C_NETWORK_FAILURE]  = "NetworkFailure",
+	[C_PROTOCOL_ERROR]   = "ProtocolError",
+	[C_CONNECTING]       = "WFConnection",
+	/* [C_WF_REPORT_PARAMS] = "WFReportParams", does no longer exist in drbd-9.x */
+	[C_TEAR_DOWN]        = "TearDown",
+	[C_CONNECTED]        = "WFReportParams", /* drbd-8.4 for "Negotiating" or "Off" */
+	[L_ESTABLISHED]      = "Connected",
+	[L_STARTING_SYNC_S]  = "StartingSyncS",
+	[L_STARTING_SYNC_T]  = "StartingSyncT",
+	[L_WF_BITMAP_S]      = "WFBitMapS",
+	[L_WF_BITMAP_T]      = "WFBitMapT",
+	[L_WF_SYNC_UUID]     = "WFSyncUUID",
+	[L_SYNC_SOURCE]      = "SyncSource",
+	[L_SYNC_TARGET]      = "SyncTarget",
+	[L_PAUSED_SYNC_S]    = "PausedSyncS",
+	[L_PAUSED_SYNC_T]    = "PausedSyncT",
+	[L_VERIFY_S]         = "VerifyS",
+	[L_VERIFY_T]         = "VerifyT",
+	[L_AHEAD]            = "Ahead",
+	[L_BEHIND]           = "Behind",
+};
+
+static const char write_ordering_chars[] = {
+	[WO_NONE] = 'n',
+	[WO_DRAIN_IO] = 'd',
+	[WO_BDEV_FLUSH] = 'f',
+	[WO_BIO_BARRIER] = 'b',
+};
+
+
+static int seq_print_device_proc_drbd(struct seq_file *m, struct drbd_device *device);
+
+atomic_t nr_drbd8_devices;
+
+void drbd_md_decode_84(struct meta_data_on_disk_84 *on_disk, struct drbd_md *md)
+{
+	struct drbd_peer_md *peer_md;
+	const int peer_node_id = 0; /* setup_node_ids_84() moves it later */
+	u32 on_disk_flags;
+	unsigned long flags;
+	int i;
+
+	md->effective_size = be64_to_cpu(on_disk->la_size_sect);
+	md->current_uuid = be64_to_cpu(on_disk->uuid[UI_CURRENT]);
+	md->prev_members = 0;
+	md->prev_features = 0; /* no features field in the drbd-8.4 meta-data */
+	md->device_uuid = be64_to_cpu(on_disk->device_uuid);
+	md->md_size_sect = be32_to_cpu(on_disk->md_size_sect);
+	md->al_offset = be32_to_cpu(on_disk->al_offset);
+
+	md->bm_offset = be32_to_cpu(on_disk->bm_offset);
+
+	on_disk_flags = be32_to_cpu(on_disk->flags);
+	md->flags = on_disk_flags & MDF_84_MASK;
+
+	md->max_peers = 1;
+	md->bm_block_size = be32_to_cpu(on_disk->bm_bytes_per_bit);
+	md->node_id = -1; /* no node_id in the drbd-8.4 meta-data */
+	md->al_stripes = be32_to_cpu(on_disk->al_stripes);
+	md->al_stripe_size_4k = be32_to_cpu(on_disk->al_stripe_size_4k);
+
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		peer_md = &md->peers[i];
+
+		peer_md->bitmap_uuid = 0;
+		peer_md->bitmap_dagtag = 0;
+		peer_md->flags = 0;
+		peer_md->bitmap_index = -1;
+	}
+
+	peer_md = &md->peers[peer_node_id];
+	peer_md->bitmap_index = 0;
+
+	flags = (on_disk_flags & MDF_84_PEER_MASK) | MDF_HAVE_BITMAP;
+	flags |= on_disk_flags & MDF_84_PEER_OUTDATED ? MDF_PEER_OUTDATED : 0;
+	flags |= on_disk_flags & MDF_84_CONNECTED_IND ? MDF_PEER_CONNECTED : 0;
+	peer_md->flags = flags;
+	/* An 8.4 bitmap fully records the divergence; set the UUID (and its
+	 * divergence flag) after the other flags so it is not overwritten.
+	 */
+	drbd_set_peer_bitmap_uuid(peer_md, be64_to_cpu(on_disk->uuid[UI_BITMAP]), 0);
+
+
+	for (i = UI_HISTORY_START; i < UI_HISTORY_END; i++)
+		md->history_uuids[i - UI_HISTORY_START] = be64_to_cpu(on_disk->uuid[i]);
+}
+
+void drbd_md_encode_84(struct drbd_device *device, struct meta_data_on_disk_84 *buffer)
+{
+	struct drbd_md *md = &device->ldev->md;
+	int peer_node_id = !md->node_id;
+	struct drbd_peer_md *peer_md = &md->peers[peer_node_id];
+	u32 flags = (md->flags & MDF_84_MASK) | (peer_md->flags & MDF_84_PEER_MASK);
+	int i;
+
+	if (device->bitmap == NULL)
+		flags |= MDF_PEER_FULL_SYNC;
+
+	flags |= test_bit(__MDF_PEER_OUTDATED, &peer_md->flags) ? MDF_84_PEER_OUTDATED : 0;
+	flags |= test_bit(__MDF_PEER_CONNECTED, &peer_md->flags) ? MDF_84_CONNECTED_IND : 0;
+	buffer->la_size_sect = cpu_to_be64(md->effective_size);
+	buffer->device_uuid = cpu_to_be64(md->device_uuid);
+	buffer->uuid[UI_CURRENT] = cpu_to_be64(md->current_uuid);
+	buffer->uuid[UI_BITMAP] = cpu_to_be64(peer_md->bitmap_uuid);
+	for (i = UI_HISTORY_START; i < UI_HISTORY_END; i++)
+		buffer->uuid[i] = cpu_to_be64(md->history_uuids[i - UI_HISTORY_START]);
+	buffer->reserved_u64_1 = 0;
+	buffer->flags = cpu_to_be32(flags);
+	buffer->magic = cpu_to_be32(DRBD_MD_MAGIC_84_UNCLEAN);
+	buffer->md_size_sect = cpu_to_be32(md->md_size_sect);
+	buffer->al_offset = cpu_to_be32(md->al_offset);
+	buffer->al_nr_extents = cpu_to_be32(device->act_log->nr_elements);
+	buffer->bm_offset = cpu_to_be32(md->bm_offset);
+	buffer->bm_bytes_per_bit = cpu_to_be32(BM_BLOCK_SIZE_4k); /* treat as magic number */
+	buffer->la_peer_max_bio_size = cpu_to_be32(device->device_conf.max_bio_size);
+
+	buffer->al_stripes = cpu_to_be32(md->al_stripes);
+	buffer->al_stripe_size_4k = cpu_to_be32(md->al_stripe_size_4k);
+}
+
+
+/*
+ * This is DRBD 8 userspace compatibility mode, so we do not have a node ID
+ * yet. We derive our own node ID from the peer node ID. drbdsetup gives us the
+ * peer-node-id, which it determines by comparing the IP addresses.
+ */
+int drbd_setup_node_ids_84(struct drbd_connection *connection, struct drbd_path *path,
+			    unsigned int peer_node_id)
+{
+	int vnr, my_node_id, nr_legacy = 0, nr_v9 = 0;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+
+	my_node_id = !peer_node_id;
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (test_bit(LEGACY_84_MD, &device->flags)) {
+			nr_legacy++;
+		} else {
+			nr_v9++;
+			if (get_ldev(device)) {
+				int md_my_node_id = device->ldev->md.node_id;
+
+				put_ldev(device);
+				if (my_node_id != md_my_node_id) {
+					drbd_err(connection, "inconsistent node_ids %d %d\n",
+						 my_node_id, md_my_node_id);
+					return -ENOTUNIQ;
+				}
+			}
+		}
+	}
+
+	if (nr_legacy && nr_v9)
+		drbd_warn(connection, "legacy-84 and drbd-9 metadata in one resource\n");
+
+	drbd_info(connection, "drbd8 userspace compat mode: setting my node id to %d\n",
+		  my_node_id);
+
+	/* setting up all node_ids*/
+	resource->res_opts.node_id = my_node_id;
+	connection->peer_node_id = peer_node_id;
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		peer_device = list_first_entry_or_null(&device->peer_devices,
+						       struct drbd_peer_device, peer_devices);
+		peer_device->node_id = peer_node_id;
+		peer_device->bitmap_index = 0;
+
+		if (get_ldev(device)) {
+			const struct drbd_peer_md clear = { .bitmap_index = -1 };
+			struct drbd_md *md = &device->ldev->md;
+			struct drbd_peer_md *to = &md->peers[peer_node_id];
+			int i;
+
+			md->node_id = my_node_id;
+
+			for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+				struct drbd_peer_md *from = &md->peers[i];
+
+				if (from->bitmap_index != -1) {
+					if (from != to) {
+						*to = *from;
+						*from = clear;
+					}
+					break;
+				}
+			}
+			put_ldev(device);
+		}
+	}
+
+	return 0;
+}
+
+
+/*
+ * Some resources may be operating in "DRBD 8 compatibility mode", where the
+ * user created the resource using the old drbd8-style drbdsetup command line
+ * syntax.
+ * This implies that the user probably also expects the old drbd8-style
+ * /proc/drbd output showing the device state.
+ * If the flag is set for a resource, we show the old-style output for that
+ * resource.
+ * If any resource is in DRBD 8 compatibility mode, this function returns true.
+ */
+bool drbd_show_legacy_device(struct seq_file *seq, void *v)
+{
+	struct drbd_device *device;
+	int i, prev_i = -1;
+
+	if (!atomic_read(&nr_drbd8_devices))
+		return false;
+
+	rcu_read_lock();
+	idr_for_each_entry(&drbd_devices, device, i) {
+		if (!device->resource->res_opts.drbd8_compat_mode)
+			continue;
+
+		if (prev_i != i - 1)
+			seq_putc(seq, '\n');
+		prev_i = i;
+
+		seq_print_device_proc_drbd(seq, device);
+	}
+	rcu_read_unlock();
+	return true;
+}
+
+static void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
+{
+	/* v is in kB/sec. We don't expect TiByte/sec yet.
+	 * v can be negative: while the resync loses ground to incoming
+	 * application writes the out-of-sync count grows, so the rate at
+	 * which it shrinks is negative. Show that honestly.
+	 */
+	if (v < 0) {
+		seq_putc(seq, '-');
+		v = -v;
+	}
+	if (unlikely(v >= 1000000)) {
+		/* cool: > GiByte/s */
+		seq_printf(seq, "%ld,", v / 1000000);
+		v %= 1000000;
+		seq_printf(seq, "%03ld,%03ld", v/1000, v % 1000);
+	} else if (likely(v >= 1000))
+		seq_printf(seq, "%ld,%03ld", v/1000, v % 1000);
+	else
+		seq_printf(seq, "%ld", v);
+}
+
+/* like bit_to_kb(), but accepts a signed bit count so we can express a
+ * negative kB/sec rate when the out-of-sync set is growing.
+ */
+static long signed_bit_to_kb(long bits, unsigned int bm_block_shift)
+{
+	if (bits < 0)
+		return -(long)bit_to_kb(-bits, bm_block_shift);
+	return bit_to_kb(bits, bm_block_shift);
+}
+
+void drbd_get_syncer_progress_84(struct drbd_peer_device *pd,
+		enum drbd_repl_state repl_state, unsigned long *rs_total,
+		unsigned long *bits_left, unsigned int *per_mil_done)
+{
+	/* this is to break it at compile time when we change that, in case we
+	 * want to support more than (1<<32) bits on a 32bit arch.
+	 */
+	typecheck(unsigned long, pd->rs_total);
+	*rs_total = pd->rs_total;
+
+	/* note: both rs_total and rs_left are in bits, i.e. in
+	 * units of BM_BLOCK_SIZE.
+	 * for the percentage, we don't care.
+	 */
+
+	if (repl_state == L_VERIFY_S || repl_state == L_VERIFY_T)
+		*bits_left = atomic64_read(&pd->ov_left);
+	else
+		*bits_left = drbd_bm_total_weight(pd) - pd->rs_failed;
+	/* >> 10 to prevent overflow,
+	 * +1 to prevent division by zero
+	 */
+	if (*bits_left > *rs_total) {
+		/* D'oh. Maybe a logic bug somewhere.  More likely just a race
+		 * between state change and reset of rs_total.
+		 */
+		*bits_left = *rs_total;
+		*per_mil_done = *rs_total ? 0 : 1000;
+	} else {
+		/* Make sure the division happens in long context.
+		 * We allow up to one petabyte storage right now,
+		 * at a granularity of 4k per bit that is 2**38 bits.
+		 * After shift right and multiplication by 1000,
+		 * this should still fit easily into a 32bit long,
+		 * so we don't need a 64bit division on 32bit arch.
+		 * Note: currently we don't support such large bitmaps on 32bit
+		 * arch anyways, but no harm done to be prepared for it here.
+		 */
+		unsigned int shift = *rs_total > UINT_MAX ? 16 : 10;
+		unsigned long left = *bits_left >> shift;
+		unsigned long total = 1UL + (*rs_total >> shift);
+		unsigned long tmp = 1000UL - left * 1000UL/total;
+		*per_mil_done = tmp;
+	}
+}
+
+static void drbd_syncer_progress(struct drbd_peer_device *pd, struct seq_file *seq,
+		enum drbd_repl_state repl_state)
+{
+	unsigned long dt, rt, rs_total, rs_left;
+	long db, dbdt;
+	unsigned int res;
+	int i, x, y;
+	int stalled = 0;
+	unsigned int bm_block_shift = pd->device->last_bm_block_shift;
+
+	drbd_get_syncer_progress_84(pd, repl_state, &rs_total, &rs_left, &res);
+
+	x = res/50;
+	y = 20-x;
+	seq_puts(seq, "\t[");
+	for (i = 1; i < x; i++)
+		seq_putc(seq, '=');
+	seq_putc(seq, '>');
+	for (i = 0; i < y; i++)
+		seq_putc(seq, '.');
+	seq_puts(seq, "] ");
+
+	if (repl_state == L_VERIFY_S || repl_state == L_VERIFY_T)
+		seq_puts(seq, "verified:");
+	else
+		seq_puts(seq, "sync'ed:");
+	seq_printf(seq, "%3u.%u%% ", res / 10, res % 10);
+
+	/* if more than a few GB, display in MB */
+	if (rs_total > (4UL << (30 - bm_block_shift)))
+		seq_printf(seq, "(%llu/%llu)M",
+			    bit_to_kb(rs_left >> 10, bm_block_shift),
+			    bit_to_kb(rs_total >> 10, bm_block_shift));
+	else
+		seq_printf(seq, "(%llu/%llu)K",
+			    bit_to_kb(rs_left, bm_block_shift),
+			    bit_to_kb(rs_total, bm_block_shift));
+
+	seq_puts(seq, "\n\t");
+
+	/* see drivers/md/md.c
+	 * We do not want to overflow, so the order of operands and
+	 * the * 100 / 100 trick are important. We do a +1 to be
+	 * safe against division by zero. We only estimate anyway.
+	 *
+	 * dt: time from mark until now
+	 * db: blocks written from mark until now
+	 * rt: remaining time
+	 */
+	/* Rolling marks. last_mark+1 may just now be modified.  last_mark+2 is
+	 * at least (DRBD_SYNC_MARKS-2)*DRBD_SYNC_MARK_STEP old, and has at
+	 * least DRBD_SYNC_MARK_STEP time before it will be modified.
+	 */
+	/* ------------------------ ~18s average ------------------------ */
+	i = (pd->rs_last_mark + 2) % DRBD_SYNC_MARKS;
+	dt = (jiffies - pd->rs_mark_time[i]) / HZ;
+	if (dt > 180)
+		stalled = 1;
+
+	if (!dt)
+		dt++;
+	db = (long)pd->rs_mark_left[i] - (long)rs_left;
+	if (db <= 0) {
+		/* out-of-sync is not shrinking: under this write load the
+		 * resync is not converging, so there is no finish time.
+		 */
+		seq_puts(seq, "finish: ∞");
+	} else {
+		rt = (dt * (rs_left / ((unsigned long)db/100+1)))/100; /* seconds */
+		seq_printf(seq, "finish: %lu:%02lu:%02lu",
+			rt / 3600, (rt % 3600) / 60, rt % 60);
+	}
+
+	dbdt = signed_bit_to_kb(db / (long)dt, bm_block_shift);
+	seq_puts(seq, " speed: ");
+	seq_printf_with_thousands_grouping(seq, dbdt);
+	seq_puts(seq, " (");
+	/* ------------------------- ~3s average ------------------------ */
+	if (1) {
+		/* this is what drbd_rs_should_slow_down() uses */
+		i = (pd->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
+		dt = (jiffies - pd->rs_mark_time[i]) / HZ;
+		if (!dt)
+			dt++;
+		db = (long)pd->rs_mark_left[i] - (long)rs_left;
+		dbdt = signed_bit_to_kb(db / (long)dt, bm_block_shift);
+		seq_printf_with_thousands_grouping(seq, dbdt);
+		seq_puts(seq, " -- ");
+	}
+
+	/* --------------------- long term average ---------------------- */
+	/* mean speed since syncer started we do account for PausedSync periods */
+	dt = (jiffies - pd->rs_start - pd->rs_paused) / HZ;
+	if (dt == 0)
+		dt = 1;
+	db = (long)rs_total - (long)rs_left;
+	dbdt = signed_bit_to_kb(db / (long)dt, bm_block_shift);
+	seq_printf_with_thousands_grouping(seq, dbdt);
+	seq_putc(seq, ')');
+
+	if (repl_state == L_SYNC_TARGET ||
+	    repl_state == L_VERIFY_S) {
+		seq_puts(seq, " want: ");
+		seq_printf_with_thousands_grouping(seq, pd->c_sync_rate);
+	}
+	seq_printf(seq, " K/sec%s\n", stalled ? " (stalled)" : "");
+
+	{
+		/* 64 bit: we convert to sectors in the display below. */
+		unsigned long bm_bits = drbd_bm_bits(pd->device);
+		unsigned long bit_pos;
+		unsigned long long stop_sector = 0;
+
+		if (repl_state == L_VERIFY_S ||
+		    repl_state == L_VERIFY_T) {
+			bit_pos = bm_bits - (unsigned long)atomic64_read(&pd->ov_left);
+			if (verify_can_do_stop_sector(pd))
+				stop_sector = pd->ov_stop_sector;
+		} else
+			bit_pos = pd->resync_next_bit;
+		/* Total sectors may be slightly off for oddly sized devices. So what. */
+		seq_printf(seq,
+			"\t%3d%% sector pos: %llu/%llu",
+			(int)(bit_pos / (bm_bits/100+1)),
+			(unsigned long long)bit_pos * sect_per_bit(bm_block_shift),
+			(unsigned long long)bm_bits * sect_per_bit(bm_block_shift));
+		if (stop_sector != 0 && stop_sector != ULLONG_MAX)
+			seq_printf(seq, " stop sector: %llu", stop_sector);
+		seq_putc(seq, '\n');
+	}
+}
+
+static const char *drbd_conn_str_84(enum drbd_conn_state s)
+{
+	/* enums are unsigned... */
+	return (int)s > (int)L_BEHIND ? "TOO_LARGE" : drbd_conn_s_names[s];
+}
+
+/*
+ * Select an 8.4-mode device's peer device (there is at most one: an
+ * 8.4-mode resource has one connection, which creates a peer device for
+ * every device) and fetch the raw state: the peer device's if one exists,
+ * else the device's own.
+ *
+ * The result is DRBD 9's unpacked union drbd_state, with DRBD 9's own
+ * disk/pdsk numbering and quorum bit still in place; drbd_pack_state_84()
+ * applies the v1 wire remap on top, seq_print_device_proc_drbd() feeds it
+ * to DRBD 9's own name lookups and must not.
+ *
+ * The caller holds rcu_read_lock() across this call and for as long as it
+ * keeps using *peer_device_r: the peer device is found without taking a
+ * reference.
+ *
+ * @peer_device_r: the selected peer device or NULL; may be NULL.
+ */
+static union drbd_state drbd_get_state_84(struct drbd_device *device,
+					  struct drbd_peer_device **peer_device_r)
+{
+	struct drbd_peer_device *peer_device;
+
+	peer_device = list_first_or_null_rcu(&device->peer_devices, struct drbd_peer_device,
+					     peer_devices);
+	if (peer_device_r)
+		*peer_device_r = peer_device;
+
+	return peer_device ? drbd_get_peer_device_state(peer_device, NOW)
+			    : drbd_get_device_state(device, NOW);
+}
+
+/*
+ * Pack a device's current state into an 8.4 wire state word (union
+ * drbd_state as u32).
+ *
+ * conn/repl numbering needs no translation: DRBD 9 split 8.4's enum
+ * drbd_conns into drbd_conn_state and drbd_repl_state but kept the numeric
+ * values. disk/pdsk do: DRBD 9 inserted D_DETACHING at index 2, so
+ * drbd_disk_state_84() shifts everything above it by one, the same remap
+ * send_state() uses for a pre-9.0 peer. s.quorum (bit 23) is _pad on 8.4
+ * and must read as 0.
+ *
+ * The result carries 8.4 numbering: do not feed it to drbd_disk_str() and
+ * friends.
+ */
+u32 drbd_pack_state_84(struct drbd_device *device)
+{
+	union drbd_state s;
+
+	rcu_read_lock();
+	s = drbd_get_state_84(device, NULL);
+	rcu_read_unlock();
+
+	s.disk = drbd_disk_state_84(s.disk);
+	s.pdsk = drbd_disk_state_84(s.pdsk);
+	s.quorum = 0;	/* bit 23 is _pad to 8.4 */
+
+	return s.i;
+}
+
+static int seq_print_device_proc_drbd(struct seq_file *m, struct drbd_device *device)
+{
+	unsigned int send_kb, recv_kb, pending_cnt, unacked_cnt, epochs;
+	struct drbd_connection *connection = NULL;
+	struct drbd_peer_device *peer_device;
+	union drbd_state state;
+	const char *sn;
+	bool have_ldev;
+	char wp;
+
+	/*
+	 * Unpacked on purpose: state.disk/state.pdsk go to DRBD 9's own
+	 * drbd_disk_str() below. The caller holds rcu_read_lock().
+	 */
+	state = drbd_get_state_84(device, &peer_device);
+
+	if (peer_device) {
+		connection = peer_device->connection;
+		send_kb = peer_device->send_cnt/2;
+		recv_kb = peer_device->recv_cnt/2;
+		pending_cnt = atomic_read(&peer_device->ap_pending_cnt) +
+			atomic_read(&peer_device->rs_pending_cnt);
+		unacked_cnt = atomic_read(&peer_device->unacked_cnt);
+	} else {
+		connection = list_first_or_null_rcu(&device->resource->connections,
+						    struct drbd_connection, connections);
+		send_kb = 0;
+		recv_kb = 0;
+		pending_cnt = 0;
+		unacked_cnt = 0;
+	}
+	if (connection) {
+		struct drbd_net_conf *nc = rcu_dereference(connection->transport.net_conf);
+
+		wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
+		epochs = connection->epochs;
+	} else {
+		wp = 'C';
+		epochs = 0;
+	}
+
+	sn = drbd_conn_str_84(state.conn);
+	have_ldev = get_ldev_if_state(device, D_FAILED);
+
+	if (state.conn == C_STANDALONE &&
+	    state.disk == D_DISKLESS &&
+	    state.role == R_SECONDARY) {
+		seq_printf(m, "%2d: cs:Unconfigured\n", device->minor);
+	} else {
+		seq_printf(m,
+			   "%2d: cs:%s ro:%s/%s ds:%s/%s %c %c%c%c%c%c%c\n"
+			   "    ns:%u nr:%u dw:%u dr:%u al:%u bm:%u "
+			   "lo:%d pe:%d ua:%d ap:%d ep:%d wo:%c",
+			   device->minor, sn,
+			   drbd_role_str(state.role),
+			   drbd_role_str(state.peer),
+			   drbd_disk_str(state.disk),
+			   drbd_disk_str(state.pdsk),
+			   wp,
+			   drbd_suspended(device) ? 's' : 'r',
+			   state.aftr_isp ? 'a' : '-',
+			   state.peer_isp ? 'p' : '-',
+			   state.user_isp ? 'u' : '-',
+			   '-' /* congestion reason... FIXME */,
+			   test_bit(AL_SUSPENDED, &device->flags) ? 's' : '-',
+			   send_kb,
+			   recv_kb,
+			   device->writ_cnt/2,
+			   device->read_cnt/2,
+			   device->al_writ_cnt,
+			   device->bm_writ_cnt,
+			   atomic_read(&device->local_cnt),
+			   pending_cnt,
+			   unacked_cnt,
+			   atomic_read(&device->ap_bio_cnt[WRITE]) +
+			   atomic_read(&device->ap_bio_cnt[READ]),
+			   epochs,
+			   write_ordering_chars[device->resource->write_ordering]
+			);
+		seq_printf(m, " oos:%llu\n", (peer_device && have_ldev) ?
+				device_bit_to_kb(device, drbd_bm_total_weight(peer_device)) : 0);
+	}
+	if (have_ldev) {
+		if (state.conn == L_SYNC_SOURCE ||
+		    state.conn == L_SYNC_TARGET ||
+		    state.conn == L_VERIFY_S ||
+		    state.conn == L_VERIFY_T)
+			drbd_syncer_progress(peer_device, m, state.conn);
+
+		put_ldev(device);
+	}
+	/* drbd_proc_details 1 or 2 missing */
+
+	return 0;
+}
diff --git a/drivers/block/drbd/drbd_legacy_84.h b/drivers/block/drbd/drbd_legacy_84.h
new file mode 100644
index 000000000000..0cd7d4322dd6
--- /dev/null
+++ b/drivers/block/drbd/drbd_legacy_84.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025, LINBIT HA-Solutions GmbH.
+ */
+
+#ifndef __DRBD_LEGACY_84_H
+#define __DRBD_LEGACY_84_H
+
+#include "drbd_int.h"
+
+struct meta_data_on_disk_84;
+
+/*
+ *   drbd-8.4                      drbd-9 md.flags                   drbd-9 peer-md.flags
+ * MDF_CONSISTENT      1 << 0  MDF_CONSISTENT =        1 << 0,   MDF_PEER_CONNECTED =    1 << 0,
+ * MDF_PRIMARY_IND     1 << 1  MDF_PRIMARY_IND =       1 << 1,   MDF_PEER_OUTDATED =     1 << 1,
+ * MDF_CONNECTED_IND   1 << 2                                    MDF_PEER_FENCING =      1 << 2,
+ * MDF_FULL_SYNC       1 << 3                                    MDF_PEER_FULL_SYNC =    1 << 3,
+ * MDF_WAS_UP_TO_DATE  1 << 4  MDF_WAS_UP_TO_DATE =    1 << 4,   MDF_PEER_DEVICE_SEEN =  1 << 4,
+ * MDF_PEER_OUT_DATED  1 << 5                                    MDF_PEER_DIVERGENCE_BITMAP = 1 << 5
+ * MDF_CRASHED_PRIMARY 1 << 6  MDF_CRASHED_PRIMARY =   1 << 6,   MDF_PEER_BITMAP_AUTHORITATIVE
+ *                                                                                       = 1 << 6
+ * MDF_AL_CLEAN        1 << 7  MDF_AL_CLEAN =          1 << 7,
+ * MDF_AL_DISABLED     1 << 8  MDF_AL_DISABLED =       1 << 8,
+ *                             MDF_PRIMARY_LOST_QUORUM = 1 << 9,
+ *                             MDF_HAVE_QUORUM =       1 << 10,
+ *                                                                MDF_NODE_EXISTS =      1 << 16,
+ */
+
+#define MDF_84_MASK (MDF_CONSISTENT | MDF_PRIMARY_IND | MDF_WAS_UP_TO_DATE | \
+		     MDF_CRASHED_PRIMARY | MDF_AL_CLEAN | MDF_AL_DISABLED)
+#define MDF_84_PEER_MASK (MDF_PEER_FULL_SYNC)
+#define MDF_84_CONNECTED_IND (1<<2)
+#define MDF_84_PEER_OUTDATED (1<<5)
+
+/*
+ * Mask for the v1 DEVICE_STATISTICS dev_disk_flags and
+ * PEER_DEVICE_STATISTICS peer_dev_flags attributes. DRBD 9 keeps 8.4's
+ * bit positions for every bit 8.4 knows about, so masking off the newer
+ * bits is enough; nothing needs remapping.
+ */
+#define PEER_DEV_FLAGS_84_MASK (MDF_PEER_CONNECTED | MDF_PEER_OUTDATED | \
+				 MDF_PEER_FENCING | MDF_PEER_FULL_SYNC)
+
+#ifdef CONFIG_DRBD_COMPAT_84
+extern atomic_t nr_drbd8_devices;
+
+void drbd_md_decode_84(struct meta_data_on_disk_84 *on_disk, struct drbd_md *md);
+void drbd_md_encode_84(struct drbd_device *device, struct meta_data_on_disk_84 *buffer);
+int drbd_setup_node_ids_84(struct drbd_connection *connection, struct drbd_path *path,
+			   unsigned int peer_node_id);
+bool drbd_show_legacy_device(struct seq_file *seq, void *v);
+u32 drbd_pack_state_84(struct drbd_device *device);
+void drbd_get_syncer_progress_84(struct drbd_peer_device *pd,
+		enum drbd_repl_state repl_state, unsigned long *rs_total,
+		unsigned long *bits_left, unsigned int *per_mil_done);
+
+/*
+ * Remap a DRBD 9 enum drbd_state_rv value to one 8.4 userland's own SS_*
+ * string table can render truthfully. SS_UNKNOWN_ERROR (0) through
+ * SS_O_VOL_PEER_PRI (-20), every success code and every enum drbd_ret_code
+ * are numerically identical in both dialects. From SS_INTERRUPTED (-21)
+ * down, DRBD 9 has nine codes 8.4 numbers differently (SS_INTERRUPTED
+ * collides with 8.4's SS_OUTDATE_WO_CONN) or lacks entirely (8.4 ends at
+ * SS_AFTER_LAST_ERROR = -22); passed through raw they would print a wrong
+ * message or "unknown error code". Map each to the nearest 8.4 code whose
+ * string does not mislead: the interrupted, timed-out and retried
+ * handshake cases to SS_IN_TRANSIENT_STATE ("retry"), a blocking
+ * read-only opener to SS_DEVICE_IN_USE, a handshake-forced disconnect to
+ * SS_CW_FAILED_BY_PEER, and the quorum, weak-connectivity, bitmap
+ * negotiation and sentinel codes, which have no 8.4 meaning, to
+ * SS_UNKNOWN_ERROR. compat84_put_outcome() is the only place a
+ * drbd_state_rv reaches the v1 wire.
+ */
+static inline enum drbd_state_rv drbd_state_rv_84(enum drbd_state_rv rv)
+{
+	switch (rv) {
+	case SS_INTERRUPTED:
+	case SS_TIMEOUT:
+	case SS_HANDSHAKE_RETRY:
+		return SS_IN_TRANSIENT_STATE;
+	case SS_PRIMARY_READER:
+		return SS_DEVICE_IN_USE;
+	case SS_HANDSHAKE_DISCONNECT:
+		return SS_CW_FAILED_BY_PEER;
+	case SS_WEAKLY_CONNECTED:
+	case SS_NO_QUORUM:
+	case SS_ATTACH_NO_BITMAP:
+	case SS_AFTER_LAST_ERROR:
+		return SS_UNKNOWN_ERROR;
+	default:
+		return rv;
+	}
+}
+
+/*
+ * Fused v1 SIB_SYNC_PROGRESS event, called from update_on_disk_bitmap()
+ * (drbd_sender.c), mainline 8.4's own call site; already throttled there
+ * by drbd_lazy_bitmap_update_due().
+ */
+void compat84_notify_sync_progress(struct drbd_peer_device *peer_device);
+#else
+static inline void drbd_md_decode_84(struct meta_data_on_disk_84 *on_disk, struct drbd_md *md) {};
+static inline void drbd_md_encode_84(struct drbd_device *device,
+	struct meta_data_on_disk_84 *buffer) {};
+static inline int drbd_setup_node_ids_84(struct drbd_connection *connection, struct drbd_path *path,
+			   unsigned int peer_node_id) { return 0; };
+static inline bool drbd_show_legacy_device(struct seq_file *seq, void *v) { return false; };
+static inline u32 drbd_pack_state_84(struct drbd_device *device) { return 0; };
+static inline void drbd_get_syncer_progress_84(struct drbd_peer_device *pd,
+		enum drbd_repl_state repl_state, unsigned long *rs_total,
+		unsigned long *bits_left, unsigned int *per_mil_done) {};
+static inline void compat84_notify_sync_progress(struct drbd_peer_device *peer_device) {};
+#endif  /* CONFIG_DRBD_COMPAT_84 */
+
+#endif  /* __DRBD_LEGACY_84_H */
-- 
2.56.0

