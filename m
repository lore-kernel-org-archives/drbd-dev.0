Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328022;
	b=zQj4kA6el9TUibZbTIVtsU0we96mYN3DnOJfzqejJm86DsghiYDgK2bar9TARE0Aw4DL
	 QSMuOK1G+YOo2HU1zkynGb4Uff4u39LDIfaUFK90LtDoYI1YRSwjcaTkCQEtFljJAnaiU
	 RM1peOR5qzKVNmL6k/ZCnBR1DBmz/8ME3+8V4jY2Oo/ICMpmyoX/W4hkTSQwwA/TxyNh7
	 bXZymCe5+pBhyQRFljs/JutZas12YTioNyqFb2e+397d2la4KkDAGh0S3LxtyjCtTS+F/
	 ZznJ1wdI7lXgjxiDvl2ZhhFBomB2DTlk48oP/6sCq2713XewL1JiBqbjdEwJ0O6/kLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
	b=fyauJb247FuxQ5SG6+isJzO/h8POuAPlh/vk3y/7HP7jjejY5PtudjkbCNTYg5f3oell
	 GKR5VJHSp5q6nRR4ANgX1NL5zFhztFAI986ptoYT/vjIUEfD776KSuGzWpdF+48aJ6RKS
	 bxj1RNKv5HB4qveF/nWjWM5coP5F0xZhkdRVsAc/masgfDYfhi+Kr3jsYivXcGzq9786p
	 RMuB+CwzM6Hqs+HXIXr6E5vn9Fh796CZBicYxqAYMedmLyhaZS5KZEgycx33IsItqr2b7
	 4MWUU9Gb//sepsNkrOkvt/DvCSdomzVxM5CxhkDAtWc/Ui3c4MuFjEjO5NkmSMQat4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=oOXBRcMj;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BD606D7E6
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD7BD606D7E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=oOXBRcMj
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1506433f8f.3
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328020; x=1794932820; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
        b=oOXBRcMjE97L971lGxhrAvhLIFiT2o78Eaw/pKf5MEgSzDKcDU2khfPXvHF/csVu/Z
         BEl5x5J2+bKvTBhhvAf6gqpdcCSSAgUoCTC2XJo5stbgK5uWVHCyzDq0dJdpEsqqH/As
         WIuyrNj4+ujIMhw/U3AZwhvR5P7XJESREHpHZMB3EZw5s3QoR8uhIvqI8oyswEn+NKZJ
         1JeCk/rUrXpgc+80tDNzcBcZn4Wcx0ekTdrTPCJeueK6bhVe5296scz7ijYZLvJplORY
         6tRr68a/zQqhOjg0O1hqNTKKqb5GZpK60sWccDmk4N0YL61//9jsoR+xq9ZEh/CM0FSF
         M89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328020; x=1794932820;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
        b=ZN7hmfNb7/svmj9UIdRcC+tXZ5D69J6Vs/YJJUFBBXoH+DsGpnjl5RRqUI8bXSqx3n
         o+Wz/bZATshGh1E2cr7t+UW+j2LRulW4UuRbW1o0mMdLXd8PUV7dzzAa5ILcrce3ETaC
         CfKy4FKUFk+VziagaZhD2nItvDwvPO4LS4WOQXkgJop/Oxd/IcjQc2oBEvzUEFMa45Zi
         VPYMJsOrcdPp3m2AVZiNZ0vlli8sRwcpRER73HfYxMMb16Ih4FtgwU5NfPSot5E6djSP
         lQKTl+Yz6MxQjVxEO8UdeHHql5EEcrmPJSRrtzvO7bH5gdo2o/5sRg89PoJkjPhB/xnz
         6jHw==
X-Gm-Message-State: APuU4Z83Xq6ZYarsMVXeQYVxrjGSPVswUEF7FasRvAIv+AzRoQSWDbkN
	gxu9b8dyu+fCizQai2Ih7Cx/QM9VV2oCp4F6kKt9ER/K/Wjdz6y1XvCNg2oSv+hbHMg=
X-Gm-Gg: AYBFou0L5LELn8RYsyNSPwDDysqrPX5EmaiR+7LaBPPu4JwC/monnL1f3Kjjq6cvEc9
	nDp+euAqoEIbLJLcEwCrnkmUHms/fOthwy+Ut+ghURdn8YrJAkfdm0nO8IVVRbtQO2O78Ksy1Bj
	F6A79SPgTchQuyGqBvPU9UvwgsC1WgkgZXoCUk2E9mVqqKMPWFZMjiQuFWqaSb5ySc5sYgLaQmO
	LelyByS3E2mGuY9vFvj5AkwwlXZE9m2lo0BzJP8W2+s8sG9zpHOZVhQJQYseOBMfZTCWl9V3Kj7
	3ezQSgyXmghnqDOSLBtqpNHk4m9FFv7dJgG6LilO8fgJxgepx9iqO7U0adknwU5+b3iV9DpvDG1
	6sHhkvayFBGVYds9xcwpOibu95SO4tOVfguXWewMnhl2Im3H7gXyuZxbBE/uhJO1XzSgQnjErX/
	fo4x/ErjJa3DKi8kQKVXxXFARJ3pBqehioomUaJCD+jGTC9qK79wDRnXObdDHHArMaRqrHuX97c
	/eDFJu27LFTX4QiuoVP03GI6T5l6IMYIaUY78DhWTZem59sAscBmf74agYxO/NhgsIggryz1TTn
	FaOuUY2a5C6SL5IUku7iSGoNI7VoTZ/qQT7+cEqA6P3n19VbzK2Ad3xXXIhphmAZpXiGZMzFjg=
	=
X-Received: by 2002:a05:600c:350c:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4ba0233ea4fmr53015075e9.9.1794328020191;
        Tue, 10 Nov 2026 08:27:00 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:26:59 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 03/20] drbd: introduce DRBD 9 on-disk metadata format
Date: Tue, 10 Nov 2026 17:26:28 +0100
Message-ID: <20261110162646.3028472-4-christoph.boehmwalder@linbit.com>
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

Add a new header that captures the DRBD 9 on-disk metadata layout,
enabling state tracking for multiple peers.
It includes the per-device superblock and per-peer slot structures
needed to track bitmap UUIDs and sync state for each peer.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_meta_data.h | 170 ++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_meta_data.h

diff --git a/drivers/block/drbd/drbd_meta_data.h b/drivers/block/drbd/drbd_meta_data.h
new file mode 100644
index 000000000000..400803267c83
--- /dev/null
+++ b/drivers/block/drbd/drbd_meta_data.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_META_DATA_H
+#define DRBD_META_DATA_H
+
+#ifdef __KERNEL__
+#define be_u64 __be64
+#define be_s64 __be64
+#define be_u32 __be32
+#define be_s32 __be32
+#define be_u16 __be16
+#else
+#define be_u64 struct { uint64_t be; }
+#define be_s64 struct { int64_t be; }
+#define be_u32 struct { uint32_t be; }
+#define be_s32 struct { int32_t be; }
+#define be_u16 struct { uint16_t be; }
+#endif
+
+/* how I came up with this magic?
+ * base64 decode "actlog==" ;)
+ */
+#define DRBD_AL_MAGIC 0x69cb65a2
+
+#define BM_BLOCK_SHIFT_4k	12			 /* 4k per bit */
+#define BM_BLOCK_SHIFT_MIN	BM_BLOCK_SHIFT_4k
+#define BM_BLOCK_SHIFT_MAX	20
+#define BM_BLOCK_SIZE_4k	4096
+#define BM_BLOCK_SIZE_MIN	(1<<BM_BLOCK_SHIFT_MIN)
+#define BM_BLOCK_SIZE_MAX	(1<<BM_BLOCK_SHIFT_MAX)
+
+struct peer_dev_md_on_disk_9 {
+	be_u64 bitmap_uuid;
+	be_u64 bitmap_dagtag;
+	be_u32 flags;
+	be_s32 bitmap_index;
+	be_u32 reserved_u32[2];
+} __packed;
+
+/* Changed block tracking: one bitmap slot, not owned by a peer, records every
+ * write to the backing device since the bookmark "id". Valid only with
+ * DRBD_MDFF_CBT in the features.
+ */
+struct cbt_bookmark_on_disk_9 {
+	be_u64 id;		/* the slot records changes since this bookmark */
+	be_u64 bitmap_uuid;	/* current UUID at cbt-start */
+	be_u64 bitmap_dagtag;	/* the Primary's dagtag at cbt-start */
+	be_s64 since;		/* time of cbt-start, seconds since the epoch */
+	be_u32 flags;		/* CBT_BOOKMARK_* */
+	be_s32 bitmap_index;
+} __packed;
+
+struct meta_data_on_disk_9 {
+	be_u64 effective_size;    /* last agreed size */
+	be_u64 current_uuid;
+	be_u64 members;		/* only if MDF_HAVE_MEMBERS_MASK is in the flags */
+	/* Feature flags. Values prefixed with "DRBD_MDFF".
+	 * Separate from "flags": Unknown features bits are cleared; unknown flags bits are kept.
+	 */
+	be_u64 features;
+	be_u64 reserved_u64[2];   /* to have the magic at the same position as in v07, and v08 */
+	be_u64 device_uuid;
+	be_u32 flags;             /* MDF */
+	be_u32 magic;
+	be_u32 md_size_sect;
+	be_u32 al_offset;         /* offset to this block */
+	be_u32 al_nr_extents;     /* important for restoring the AL */
+	be_u32 bm_offset;         /* offset to the bitmap, from here */
+	be_u32 bm_bytes_per_bit;  /* BM_BLOCK_SIZE */
+	be_u32 la_peer_max_bio_size;   /* last peer max_bio_size */
+	be_u32 bm_max_peers;
+	be_s32 node_id;
+
+	/* see al_tr_number_to_on_disk_sector() */
+	be_u32 al_stripes;
+	be_u32 al_stripe_size_4k;
+
+	be_u32 reserved_u32[2];
+
+	struct peer_dev_md_on_disk_9 peers[DRBD_PEERS_MAX];
+	be_u64 history_uuids[HISTORY_UUIDS];
+	struct cbt_bookmark_on_disk_9 cbt_bookmark;
+
+	unsigned char padding_start[0];
+	unsigned char padding_end[0] __attribute__((aligned(4096)));
+} __packed;
+
+/* Attention, these two are defined in drbd_int.h as well! */
+#define AL_UPDATES_PER_TRANSACTION 64
+#define AL_CONTEXT_PER_TRANSACTION 919
+
+enum al_transaction_types {
+	AL_TR_UPDATE = 0,
+	AL_TR_INITIALIZED = 0xffff
+};
+/* all fields on disc in big endian */
+struct __packed al_transaction_on_disk {
+	/* don't we all like magic */
+	be_u32	magic;
+
+	/* to identify the most recent transaction block
+	 * in the on disk ring buffer
+	 */
+	be_u32	tr_number;
+
+	/* checksum on the full 4k block, with this field set to 0. */
+	be_u32	crc32c;
+
+	/* type of transaction, special transaction types like:
+	 * purge-all, set-all-idle, set-all-active, ... to-be-defined
+	 * see also enum al_transaction_types
+	 */
+	be_u16	transaction_type;
+
+	/* we currently allow only a few thousand extents,
+	 * so 16bit will be enough for the slot number.
+	 */
+
+	/* how many updates in this transaction */
+	be_u16	n_updates;
+
+	/* maximum slot number, "al-extents" in drbd.conf speak.
+	 * Having this in each transaction should make reconfiguration
+	 * of that parameter easier.
+	 */
+	be_u16	context_size;
+
+	/* slot number the context starts with */
+	be_u16	context_start_slot_nr;
+
+	/* Some reserved bytes.  Expected usage is a 64bit counter of
+	 * sectors-written since device creation, and other data generation tag
+	 * supporting usage
+	 */
+	be_u32	__reserved[4];
+
+	/* --- 36 byte used --- */
+
+	/* Reserve space for up to AL_UPDATES_PER_TRANSACTION changes
+	 * in one transaction, then use the remaining byte in the 4k block for
+	 * context information.  "Flexible" number of updates per transaction
+	 * does not help, as we have to account for the case when all update
+	 * slots are used anyways, so it would only complicate code without
+	 * additional benefit.
+	 */
+	be_u16	update_slot_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* but the extent number is 32bit, which at an extent size of 4 MiB
+	 * allows to cover device sizes of up to 2**54 Byte (16 PiB)
+	 */
+	be_u32	update_extent_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* --- 420 bytes used (36 + 64*6) --- */
+
+	/* 4096 - 420 = 3676 = 919 * 4 */
+	be_u32	context[AL_CONTEXT_PER_TRANSACTION];
+};
+
+#define DRBD_AL_PMEM_MAGIC 0x6aa667a6 /* "al==pmem" */
+
+struct __packed al_on_pmem {
+	be_u32 magic;
+	be_u32 slots[];
+};
+
+#undef be_u64
+#undef be_u32
+#undef be_s32
+#undef be_u16
+
+#endif
-- 
2.56.0

