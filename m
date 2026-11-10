Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328046;
	b=pSlNOQg+GAV9zEmzx9SvOVuWnwAR9GKhRCIrocsm+P6ya0mPZQSXifKmCtxdkykvWhy0
	 jCeXu+FxWfob4g7VwoUUpvZpTnvZxgsv/vJoefrjRvI5Q2z8dEPTMGGUrdoQN6c9BSC7t
	 B3gOq5D7pu67g0A2ydEaA8x8bnuVeWTHpg9Wvc+AcVyGCbRKfiGXMxt8aqpyBWy4SgM+J
	 ochbYxEasnoTsh14fX20+e58FCxmbF5y1yod9sIR25X8SNOKMPkx8l4+aAWggRlY1967s
	 11xn/IO/Nky46kVGxh4lavcnA/Tc0golDF3AtQbhV85uU0txZcnfjUCLSaY8OBPdibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FaNqdmdjQPtFtEs8mm3ZhU88kcSec2F+SFM7EET7HB8=;
	b=XolA+Uu1R48PS7A3pMZigfFEpauVDaTZ08wVFAEcERy3GpXaJyUEPNC/xd+BghB2kIUE
	 IENhld+msfFq52tZMj1nNPb20/ePMgbLXEmwSTkvlk4YozFOGcxh7JV/KnCHv+QNWjqjs
	 7RgGJnn8ALlk6WEGCkR7xkJzRe057rSptPdMaDPK7I6rqtZiSnhJ7Pb6jYjPCW9bbOzgj
	 nXPQl4Y9QkpN2a2/gNXtkei/1os0FmSQ/ans9aruTTgHcAlZmbfMc2fCbVE4H+82C/ILl
	 cEWdvtGeWkqIzuK/MWBlvxtZ4ajJ7pUiCLc/3k+KrqyiAFj/PuFKNeLB7sFUlPNJk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=fHY9+Zba;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43D606A201
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E43D606A201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=fHY9+Zba
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4919a880834so1398195f8f.0
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328042; x=1794932842; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FaNqdmdjQPtFtEs8mm3ZhU88kcSec2F+SFM7EET7HB8=;
        b=fHY9+ZbafgANFhqGRWXbdS4tSJ1hEHYC24CfD8ZlX+ajOtVzPaxjMVaZhZ+bMtv3h6
         apIK6RkqNy7TYOz3XEBA5UvvSa+3ZatWfHHeXfCSahyb2RkJ0SvPSJBxPMHXf4LvMl7d
         IuLlFAAKqYTObTC65RjrXmPcqNZ7JFlGQZn7cu4acy2mxqIKhVOM7XNVbFFh4gma5hBu
         oU89PMkp05dIE5eCu8Uz3+8cz15ZJ01JnH5VNBrTaB90MB1P1T2JO4g6GNcNWKe0hDc4
         FOXX2BMt1B+cfd8bqFTSeosZCJ7WcV9sqMyWkOYTTQfI9v8YpM7w6ooVqNbZkR09VQSa
         ICKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328042; x=1794932842;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaNqdmdjQPtFtEs8mm3ZhU88kcSec2F+SFM7EET7HB8=;
        b=OpwgKB9hC/Z4XIcY6HrBwAZ+eNdmn6rlh2XIjV7ft1m5mEJv+SzL2upAZh7lY3ZAU/
         U+atn8KXWBmR2vS/fXDe3jwJOTMVeQII4jIfpkxEfcNCMO5tO6XVzL3ZMdH549x9qUaR
         LCYyOKYr++wGXRKExn5lOicoumT1FU3+kkD8t8JwHWMLtIKxbirMz61WJIdJR6W7lQ9I
         hy3G41jQXQF6Zri7uPdQPFnRvfRYrtCmRLuXBW64n+rt74dbkHT/kDUF5qu8oIV2RRqj
         ePrdwX98s3YO/gOPaliwAmo7YjuL5OcX934rgESyG9vUhd90l94mEMLO5aD9cyN8gLxk
         fzaQ==
X-Gm-Message-State: APuU4Z95nkIzaVBWfweTPWYshvTSDEwhTI/qE2XJceSUshmKZdBs0io3
	gXSRgbW1u2HT4KvI6Zym8jMQrChPOlePKHIp7DGlLo8jhoByuNpxlQv9H85rr83VlME=
X-Gm-Gg: AYBFou2ZQtIaOMe4SxT8fLtI7U9Q56d7gOdE4T7hl/ZLcSkCyziHD+csuD9MnC/GlCa
	sPfRnkkKcnYJXEnl8Z8X3zzxHqD9M8D3uzuEvC0774dtJ1PkQEnQdrK4tKAWd2mRXkCfUEDKhjc
	vJRhMJVbh0dsjYoLuH0bW0/FZ3iVKcNPKM7LtTYKI9uv6VYYGUuUs9xWJjBX161rdSs0G9qQ1re
	1apX1VxuPW/2Z9tWNcyIFYe4vXpzPQ/GEMWk//Yhjkfe2BUn6nWU4IohPQdl+aEIb2ZOdxmCRVA
	l9FPJUYp2x7Bp+gi+HCNLBaBqieM7K0Pa023hPwbnscZ6vpjisYPt3Qy2P5+S4s2cvMJFdmcuYz
	FKcfzWpsc8XVtPqK/f50HetrpJ++zI9AsEfjG4LHsMaL55vXObgNQbqmH5CfP44qXAs0FwXpOIc
	McO9bQgzam2M0hvnbA5noMEpO2dGwfwHN843zForp349Myogx02u3w4iyJJG3JgPK6bKhBoniFJ
	6DzfMpiJj44+oU5ozatAJiJ0YumiTnRzi5NwP5zo3rTlKM7xTdJd2qh46nmcOCUZv8VJvHgY2TK
	lVAkXXr8EZTAp5E5uoOu9AwH04LL44vOHCHKENlxZhaJ7FiFL/GZkfjTJRDUQyZNgmZ94iYdeg=
	=
X-Received: by 2002:a05:600c:3b86:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4ba0234e2fdmr65691295e9.21.1794328039495;
        Tue, 10 Nov 2026 08:27:19 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:27:17 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	Moritz Tanner <moritz.tanner@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [PATCH v3 15/20] drbd: rework receiver for DRBD 9 transport and multi-peer protocol
Date: Tue, 10 Nov 2026 17:26:40 +0100
Message-ID: <20261110162646.3028472-16-christoph.boehmwalder@linbit.com>
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

Adapt the receiver to the DRBD 9 multi-peer architecture.
Replace all direct socket I/O by calls through the transport abstraction
layer, with the transport managing buffer allocation.
Move peer request tracking from per-device lists to connection-level
structures, enabling a single receiver thread to serve all volumes on
a connection.

UUID-based resync decisions replace the old integer heuristic with enums
for strategies and rules, so each sync handshake outcome and its reason
are self-describing and logged by name.
Update UUID comparison for multi-peer: each peer now carries per-node
bitmap UUIDs and a history array, replacing the fixed four-slot layout.

Introduce DAG-tag ordering as a causal consistency mechanism, letting
peer requests declare dependencies on writes seen at another node and
waiting until those dependencies are resolved.

Add two-phase commit handling so that coordinated state changes (role
transitions, resync initiation, resize) can be propagated to all nodes
atomically.

Write conflict detection moves from a flag-based approach to an
interval-tree with typed intervals, using asynchronous deferred
submission for conflicting requests.

The disconnect path is restructured at the connection level: it
cancels dagtag-dependent requests, drains resync activity, flushes
workqueues, and performs per-peer-device teardown before returning
the connection to the unconnected state.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Co-developed-by: Moritz Tanner <moritz.tanner@linbit.com>
Signed-off-by: Moritz Tanner <moritz.tanner@linbit.com>
Co-developed-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 17304 ++++++++++++++++++++-------
 1 file changed, 13128 insertions(+), 4176 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 101192d8398f..95cf8db197d8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -6,41 +6,53 @@
  * Copyright (C) 2008, LINBIT HA-Solutions GmbH.
  */
 
-#include <linux/module.h>
-
-#include <linux/uaccess.h>
 #include <net/sock.h>
 
+#include <linux/bio.h>
 #include <linux/drbd.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/in.h>
 #include <linux/mm.h>
-#include <linux/memcontrol.h>
+#include <linux/memcontrol.h> /* needed on kernels <4.3 */
 #include <linux/mm_inline.h>
 #include <linux/slab.h>
-#include <uapi/linux/sched/types.h>
-#include <linux/sched/signal.h>
 #include <linux/pkt_sched.h>
-#include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/random.h>
-#include <linux/string.h>
-#include <linux/scatterlist.h>
+#include <net/ipv6.h>
 #include <linux/part_stat.h>
-#include <linux/mempool.h>
+
 #include "drbd_int.h"
+#include "drbd_meta_data.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
 #include "drbd_vli.h"
 
-#define PRO_FEATURES (DRBD_FF_TRIM|DRBD_FF_THIN_RESYNC|DRBD_FF_WSAME|DRBD_FF_WZEROES)
 
-struct packet_info {
-	enum drbd_packet cmd;
-	unsigned int size;
-	unsigned int vnr;
-	void *data;
+enum ao_op {
+	OUTDATE_DISKS,
+	OUTDATE_DISKS_AND_DISCONNECT,
+};
+
+struct flush_work {
+	struct drbd_work w;
+	struct drbd_epoch *epoch;
+};
+
+struct update_peers_work {
+	struct drbd_work w;
+	struct drbd_peer_device *peer_device;
+	sector_t sector_start;
+	sector_t sector_end;
+};
+
+enum epoch_event {
+	EV_PUT,
+	EV_GOT_BARRIER_NR,
+	EV_BARRIER_DONE,
+	EV_BECAME_LAST,
+	EV_CLEANUP = 32, /* used as flag */
 };
 
 enum finish_epoch {
@@ -49,201 +61,600 @@ enum finish_epoch {
 	FE_RECYCLED,
 };
 
-static int drbd_do_features(struct drbd_connection *connection);
-static int drbd_do_auth(struct drbd_connection *connection);
-static int drbd_disconnected(struct drbd_peer_device *);
-static void conn_wait_active_ee_empty(struct drbd_connection *connection);
+enum resync_reason {
+	AFTER_UNSTABLE,
+	DISKLESS_PRIMARY,
+};
+
+enum sync_rule {
+	RULE_SYNC_SOURCE_MISSED_FINISH,
+	RULE_SYNC_SOURCE_PEER_MISSED_FINISH,
+	RULE_SYNC_TARGET_MISSED_FINISH,
+	RULE_SYNC_TARGET_PEER_MISSED_FINISH,
+	RULE_SYNC_TARGET_MISSED_START,
+	RULE_SYNC_SOURCE_MISSED_START,
+	RULE_INITIAL_HANDSHAKE_CHANGED,
+	RULE_JUST_CREATED_PEER,
+	RULE_JUST_CREATED_SELF,
+	RULE_JUST_CREATED_BOTH,
+	RULE_CRASHED_PRIMARY,
+	RULE_LOST_QUORUM,
+	RULE_RECONNECTED,
+	RULE_BOTH_OFF,
+	RULE_RECONCILE_BITMAP,
+	RULE_RECONCILE_DAGTAG,
+	RULE_BITMAP_PEER,
+	RULE_BITMAP_PEER_OTHER,
+	RULE_BITMAP_SELF,
+	RULE_BITMAP_SELF_OTHER,
+	RULE_BITMAP_BOTH,
+	RULE_HISTORY_PEER,
+	RULE_HISTORY_SELF,
+	RULE_HISTORY_BOTH,
+};
+
+static const char * const sync_rule_names[] = {
+	[RULE_SYNC_SOURCE_MISSED_FINISH] = "sync-source-missed-finish",
+	[RULE_SYNC_SOURCE_PEER_MISSED_FINISH] = "sync-source-peer-missed-finish",
+	[RULE_SYNC_TARGET_MISSED_FINISH] = "sync-target-missed-finish",
+	[RULE_SYNC_TARGET_PEER_MISSED_FINISH] = "sync-target-peer-missed-finish",
+	[RULE_SYNC_TARGET_MISSED_START] = "sync-target-missed-start",
+	[RULE_SYNC_SOURCE_MISSED_START] = "sync-source-missed-start",
+	[RULE_INITIAL_HANDSHAKE_CHANGED] = "initial-handshake-changed",
+	[RULE_JUST_CREATED_PEER] = "just-created-peer",
+	[RULE_JUST_CREATED_SELF] = "just-created-self",
+	[RULE_JUST_CREATED_BOTH] = "just-created-both",
+	[RULE_CRASHED_PRIMARY] = "crashed-primary",
+	[RULE_LOST_QUORUM] = "lost-quorum",
+	[RULE_RECONNECTED] = "reconnected",
+	[RULE_BOTH_OFF] = "both-off",
+	[RULE_RECONCILE_BITMAP] = "reconcile-bitmap",
+	[RULE_RECONCILE_DAGTAG] = "reconcile-dagtag",
+	[RULE_BITMAP_PEER] = "bitmap-peer",
+	[RULE_BITMAP_PEER_OTHER] = "bitmap-peer-other",
+	[RULE_BITMAP_SELF] = "bitmap-self",
+	[RULE_BITMAP_SELF_OTHER] = "bitmap-self-other",
+	[RULE_BITMAP_BOTH] = "bitmap-both",
+	[RULE_HISTORY_PEER] = "history-peer",
+	[RULE_HISTORY_SELF] = "history-self",
+	[RULE_HISTORY_BOTH] = "history-both",
+};
+
+enum sync_strategy {
+	UNDETERMINED = 0,
+	NO_SYNC,
+	SYNC_SOURCE_IF_BOTH_FAILED,
+	SYNC_SOURCE_USE_BITMAP,
+	SYNC_SOURCE_SET_BITMAP,
+	SYNC_SOURCE_COPY_BITMAP,
+	SYNC_TARGET_IF_BOTH_FAILED,
+	SYNC_TARGET_USE_BITMAP,
+	SYNC_TARGET_SET_BITMAP,
+	SYNC_TARGET_CLEAR_BITMAP,
+	SPLIT_BRAIN_AUTO_RECOVER,
+	SPLIT_BRAIN_DISCONNECT,
+	UNRELATED_DATA,
+	RETRY_CONNECT,
+	REQUIRES_PROTO_91,
+	REQUIRES_PROTO_96,
+	REQUIRES_PROTO_124,
+	SYNC_TARGET_PRIMARY_RECONNECT,
+	SYNC_TARGET_PRIMARY_DISCONNECT,
+	DRY_RUN,
+};
+
+struct sync_descriptor {
+	char * const name;
+	int required_protocol;
+	bool is_split_brain;
+	bool is_sync_source;
+	bool is_sync_target;
+	bool reconnect;
+	bool disconnect;
+	int resync_peer_preference;
+	enum sync_strategy full_sync_equivalent;
+	enum sync_strategy reverse;
+};
+
+static const struct sync_descriptor sync_descriptors[] = {
+	[UNDETERMINED] = {
+		.name = "?",
+	},
+	[NO_SYNC] = {
+		.name = "no-sync",
+		.resync_peer_preference = 5,
+	},
+	[SYNC_SOURCE_IF_BOTH_FAILED] = {
+		.name = "source-if-both-failed",
+		.is_sync_source = true,
+		.reverse = SYNC_TARGET_IF_BOTH_FAILED,
+	},
+	[SYNC_SOURCE_USE_BITMAP] = {
+		.name = "source-use-bitmap",
+		.is_sync_source = true,
+		.full_sync_equivalent = SYNC_SOURCE_SET_BITMAP,
+		.reverse = SYNC_TARGET_USE_BITMAP,
+	},
+	[SYNC_SOURCE_SET_BITMAP] = {
+		.name = "source-set-bitmap",
+		.is_sync_source = true,
+		.reverse = SYNC_TARGET_SET_BITMAP,
+	},
+	[SYNC_SOURCE_COPY_BITMAP] = {
+		.name = "source-copy-other-bitmap",
+		.is_sync_source = true,
+	},
+	[SYNC_TARGET_IF_BOTH_FAILED] = {
+		.name = "target-if-both-failed",
+		.is_sync_target = true,
+		.resync_peer_preference = 4,
+		.reverse = SYNC_SOURCE_IF_BOTH_FAILED,
+	},
+	[SYNC_TARGET_USE_BITMAP] = {
+		.name = "target-use-bitmap",
+		.is_sync_target = true,
+		.full_sync_equivalent = SYNC_TARGET_SET_BITMAP,
+		.resync_peer_preference = 3,
+		.reverse = SYNC_SOURCE_USE_BITMAP,
+	},
+	[SYNC_TARGET_SET_BITMAP] = {
+		.name = "target-set-bitmap",
+		.is_sync_target = true,
+		.resync_peer_preference = 2,
+		.reverse = SYNC_SOURCE_SET_BITMAP,
+	},
+	[SYNC_TARGET_CLEAR_BITMAP] = {
+		.name = "target-clear-bitmap",
+		.is_sync_target = true,
+		.resync_peer_preference = 1,
+	},
+	[SPLIT_BRAIN_AUTO_RECOVER] = {
+		.name = "split-brain-auto-recover",
+		.is_split_brain = true,
+		.disconnect = true,
+	},
+	[SPLIT_BRAIN_DISCONNECT] = {
+		.name = "split-brain-disconnect",
+		.is_split_brain = true,
+		.disconnect = true,
+	},
+	[UNRELATED_DATA] = {
+		.name = "unrelated-data",
+		.disconnect = true,
+	},
+	[RETRY_CONNECT] = {
+		.name = "retry-connect",
+		.reconnect = true,
+	},
+	[REQUIRES_PROTO_91] = {
+		.name = "requires-proto-91",
+		.required_protocol = 91,
+		.disconnect = true,
+	},
+	[REQUIRES_PROTO_96] = {
+		.name = "requires-proto-96",
+		.required_protocol = 96,
+		.disconnect = true,
+	},
+	[REQUIRES_PROTO_124] = {
+		.name = "requires-proto-124",
+		.required_protocol = 124,
+		.disconnect = true,
+	},
+	[SYNC_TARGET_PRIMARY_RECONNECT] = {
+		.name = "sync-target-primary-reconnect",
+		.is_sync_target = true,
+		.reconnect = true,
+	},
+	[SYNC_TARGET_PRIMARY_DISCONNECT] = {
+		.name = "sync-target-primary-disconnect",
+		.is_sync_target = true,
+		.disconnect = true,
+	},
+	[DRY_RUN] = {
+		.name = "dry-run",
+		.disconnect = true,
+	},
+};
+
+enum rcv_timeou_kind {
+	PING_TIMEOUT,
+	REGULAR_TIMEOUT,
+};
+
+int drbd_do_features(struct drbd_connection *connection);
+int drbd_do_auth(struct drbd_connection *connection);
+static void conn_disconnect(struct drbd_connection *connection);
+
 static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *, struct drbd_epoch *, enum epoch_event);
 static int e_end_block(struct drbd_work *, int);
+static void cleanup_unacked_peer_requests(struct drbd_connection *connection);
+static void cleanup_peer_ack_list(struct drbd_connection *connection);
+static u64 node_ids_to_bitmap(struct drbd_device *device, u64 node_ids);
+static void process_twopc(struct drbd_connection *, struct twopc_reply *, struct packet_info *, unsigned long);
+static void drbd_resync(struct drbd_peer_device *, enum resync_reason);
+static void drbd_unplug_all_devices(struct drbd_connection *connection);
+static int decode_header(struct drbd_connection *, const void *, struct packet_info *);
+static void check_resync_source(struct drbd_peer_device *primary_pd, u64 weak_nodes);
+static void set_rcvtimeo(struct drbd_connection *connection, enum rcv_timeou_kind kind);
+static bool disconnect_expected(struct drbd_connection *connection);
+static bool uuid_in_peer_history(struct drbd_peer_device *peer_device, u64 uuid);
+static bool uuid_in_my_history(struct drbd_device *device, u64 uuid);
+static int find_common_lost_primary_node_id(struct drbd_connection *self);
+static void drbd_cancel_conflicting_resync_requests(struct drbd_peer_device *peer_device);
+
+static const char *drbd_sync_rule_str(enum sync_rule rule)
+{
+	if (rule < 0 || rule >= ARRAY_SIZE(sync_rule_names)) {
+		WARN_ON(true);
+		return "?";
+	}
+	return sync_rule_names[rule];
+}
+
+static struct sync_descriptor strategy_descriptor(enum sync_strategy strategy)
+{
+	if (strategy < 0 || strategy >= ARRAY_SIZE(sync_descriptors)) {
+		WARN_ON(true);
+		return sync_descriptors[UNDETERMINED];
+	}
+	return sync_descriptors[strategy];
+}
+
+static bool is_strategy_determined(enum sync_strategy strategy)
+{
+	return strategy == NO_SYNC ||
+			strategy_descriptor(strategy).is_sync_source ||
+			strategy_descriptor(strategy).is_sync_target;
+}
+
+static struct drbd_epoch *previous_epoch(struct drbd_connection *connection, struct drbd_epoch *epoch)
+{
+	struct drbd_epoch *prev;
+
+	spin_lock(&connection->epoch_lock);
+	prev = list_entry(epoch->list.prev, struct drbd_epoch, list);
+	if (prev == epoch || prev == connection->current_epoch)
+		prev = NULL;
+	spin_unlock(&connection->epoch_lock);
+	return prev;
+}
 
+static void rs_sectors_came_in(struct drbd_peer_device *peer_device, int size)
+{
+	int rs_sect_in = atomic_add_return(size >> 9, &peer_device->rs_sect_in);
 
-#define GFP_TRY	(__GFP_HIGHMEM | __GFP_NOWARN)
+	/* When resync runs faster than anticipated, consider running the
+	 * resync_work early. */
+	if (rs_sect_in >= drbd_rs_outstanding(peer_device))
+		drbd_rs_all_in_flight_came_back(peer_device, rs_sect_in);
+}
 
-static struct page *__drbd_alloc_pages(unsigned int number)
+static void drbd_strip_bio_list(struct drbd_transport *transport, struct bio_list *bios)
 {
-	struct page *page = NULL;
-	struct page *tmp = NULL;
-	unsigned int i = 0;
-
-	/* GFP_TRY, because we must not cause arbitrary write-out: in a DRBD
-	 * "criss-cross" setup, that might cause write-out on some other DRBD,
-	 * which in turn might block on the other node at this very place.  */
-	for (i = 0; i < number; i++) {
-		tmp = mempool_alloc(&drbd_buffer_page_pool, GFP_TRY);
-		if (!tmp)
-			goto fail;
-		set_page_private(tmp, (unsigned long)page);
-		page = tmp;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	struct bio *bio;
+
+	while ((bio = bio_list_pop(bios))) {
+		bio_for_each_bvec(bvec, bio, iter) {
+			struct page *page = bvec.bv_page;
+			unsigned int end = bvec.bv_offset + bvec.bv_len;
+			unsigned int pos = 0;
+
+			/* bio_add_page() may have merged contiguous pages from
+			 * separate allocations into a single bvec, and a bvec may
+			 * start mid-page. Drop one reference per allocation unit the bvec
+			 * touches, stepping by compound_order.
+			 */
+			while (pos < end) {
+				unsigned int order = compound_order(page);
+
+				drbd_free_page(transport, page);
+				page += 1 << order;
+				pos += PAGE_SIZE << order;
+			}
+		}
+		bio_put(bio);
 	}
+}
+
+void drbd_peer_req_strip_bio(struct drbd_peer_request *peer_req)
+{
+	drbd_strip_bio_list(&peer_req->peer_device->connection->transport, &peer_req->bios);
+}
+
+static struct page *
+__drbd_alloc_pages(struct drbd_connection *connection, gfp_t gfp_mask, int order)
+{
+	struct page *page;
+	unsigned int mxb;
+
+	rcu_read_lock();
+	mxb = rcu_dereference(connection->transport.net_conf)->max_buffers;
+	rcu_read_unlock();
+
+	if (atomic_read(&connection->pp_in_use) >= mxb)
+		schedule_timeout_interruptible(HZ / 10);
+
+	if (order == 0)
+		page = mempool_alloc(&drbd_buffer_page_pool, gfp_mask);
+	else
+		page = alloc_pages(gfp_mask | __GFP_COMP | __GFP_NORETRY, order);
+
+	if (page)
+		atomic_add(1 << order, &connection->pp_in_use);
+
 	return page;
-fail:
-	page_chain_for_each_safe(page, tmp) {
-		set_page_private(page, 0);
-		mempool_free(page, &drbd_buffer_page_pool);
-	}
-	return NULL;
 }
 
 /**
- * drbd_alloc_pages() - Returns @number pages, retries forever (or until signalled)
- * @peer_device:	DRBD device.
- * @number:		number of pages requested
- * @retry:		whether to retry, if not enough pages are available right now
- *
- * Tries to allocate number pages, first from our own page pool, then from
- * the kernel.
- * Possibly retry until DRBD frees sufficient pages somewhere else.
+ * drbd_alloc_pages() - Returns a page, which might be a single or compound page
+ * @transport:	DRBD transport
+ * @gfp_mask:	how to allocate and whether to loop until we succeed
+ * @size:	Desired size, gets rounded down to the closest power of two
  *
- * If this allocation would exceed the max_buffers setting, we throttle
- * allocation (schedule_timeout) to give the system some room to breathe.
+ * Allocates a page from the kernel or from the private mempool. When this
+ * allocation exceeds the max_buffers setting, throttle the allocation via
+ * schedule_timeout.
  *
- * We do not use max-buffers as hard limit, because it could lead to
- * congestion and further to a distributed deadlock during online-verify or
- * (checksum based) resync, if the max-buffers, socket buffer sizes and
+ * We do not use max-buffers as a hard limit, because it could lead to
+ * congestion and, further, to a distributed deadlock during online-verify or
+ * (checksum-based) resync, if the max-buffers, socket buffer sizes, and
  * resync-rate settings are mis-configured.
- *
- * Returns a page chain linked via page->private.
  */
-struct page *drbd_alloc_pages(struct drbd_peer_device *peer_device, unsigned int number,
-			      bool retry)
+struct page *drbd_alloc_pages(struct drbd_transport *transport, gfp_t gfp_mask, unsigned int size)
 {
-	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	int order = max(ilog2(size) - PAGE_SHIFT, 0);
 	struct page *page;
-	struct net_conf *nc;
+
+	if (order && drbd_insert_fault_conn(connection, DRBD_FAULT_BIO_TOO_SMALL))
+		order = 0;
+
+	page = __drbd_alloc_pages(connection, gfp_mask | __GFP_NOWARN, order);
+	if (!page && order)
+		page = __drbd_alloc_pages(connection, gfp_mask, 0);
+
+	return page;
+}
+EXPORT_SYMBOL(drbd_alloc_pages); /* for transports */
+
+/**
+ * drbd_alloc_pages_split() - Allocate a physically contiguous, non-compound region
+ * @transport:	DRBD transport
+ * @gfp_mask:	how to allocate
+ * @order:	in/out: on entry the desired (maximum) order, on return the order
+ *		actually allocated
+ *
+ * Allocates 2^*order physically contiguous pages and runs split_page() so that
+ * each constituent page becomes an independently refcounted order-0 page.
+ *
+ * Tries the requested order first and falls back to successively smaller orders
+ * when the high-order, physically-contiguous allocation fails.
+ * The caller uses *order to learn how large a region it actually got, so it can
+ * fill its receive window with as few, as-large-as-possible regions.
+ *
+ * The same max_buffers throttle as __drbd_alloc_pages() applies.
+ *
+ * Returns the head page (representing 1 << *order linear pages), or NULL.
+ */
+struct page *drbd_alloc_pages_split(struct drbd_transport *transport, gfp_t gfp_mask, int *order)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	struct page *page = NULL;
 	unsigned int mxb;
+	int o = *order;
 
 	rcu_read_lock();
-	nc = rcu_dereference(peer_device->connection->net_conf);
-	mxb = nc ? nc->max_buffers : 1000000;
+	mxb = rcu_dereference(connection->transport.net_conf)->max_buffers;
 	rcu_read_unlock();
 
-	if (atomic_read(&device->pp_in_use) >= mxb)
+	if (atomic_read(&connection->pp_in_use) >= mxb)
 		schedule_timeout_interruptible(HZ / 10);
-	page = __drbd_alloc_pages(number);
 
-	if (page)
-		atomic_add(number, &device->pp_in_use);
+	for (; o > 0; o--) {
+		page = alloc_pages(gfp_mask | __GFP_NORETRY | __GFP_NOWARN, o);
+		if (page)
+			break;
+	}
+	if (!page) {
+		o = 0;
+		page = alloc_pages(gfp_mask | __GFP_NOWARN, 0);
+		if (!page)
+			return NULL;
+	}
+
+	if (o)
+		split_page(page, o);
+
+	atomic_add(1 << o, &connection->pp_in_use);
+	*order = o;
+
 	return page;
 }
+EXPORT_SYMBOL(drbd_alloc_pages_split); /* for transports */
 
-/* Must not be used from irq, as that may deadlock: see drbd_alloc_pages.
- * Is also used from inside an other spin_lock_irq(&resource->req_lock);
- * Either links the page chain back to the global pool,
+/* Must not be used from irq, as that may deadlock: see drbd_alloc_pages().
+ * Either links the page chain back to the pool of free pages,
  * or returns all pages to the system. */
-static void drbd_free_pages(struct drbd_device *device, struct page *page)
+void drbd_free_page(struct drbd_transport *transport, struct page *page)
 {
-	struct page *tmp;
-	int i = 0;
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	int order = compound_order(page), i = 0;
 
 	if (page == NULL)
 		return;
 
-	page_chain_for_each_safe(page, tmp) {
-		set_page_private(page, 0);
-		if (page_count(page) == 1)
-			mempool_free(page, &drbd_buffer_page_pool);
-		else
-			put_page(page);
-		i++;
-	}
-	i = atomic_sub_return(i, &device->pp_in_use);
+	if (page_count(page) == 1 && order == 0)
+		mempool_free(page, &drbd_buffer_page_pool);
+	else
+		put_page(page);
+
+	i = atomic_sub_return(1 << order, &connection->pp_in_use);
 	if (i < 0)
-		drbd_warn(device, "ASSERTION FAILED: pp_in_use: %d < 0\n", i);
+		drbd_warn(connection, "ASSERTION FAILED: pp_in_use: %d < 0\n", i);
 }
+EXPORT_SYMBOL(drbd_free_page);
 
-/*
-You need to hold the req_lock:
- _drbd_wait_ee_list_empty()
-
-You must not have the req_lock:
- drbd_free_peer_req()
- drbd_alloc_peer_req()
- drbd_free_peer_reqs()
- drbd_ee_fix_bhs()
- drbd_finish_peer_reqs()
- drbd_clear_done_ee()
- drbd_wait_ee_list_empty()
-*/
+/* Take an additional reference on a page from drbd_alloc_pages() /
+ * drbd_alloc_pages_split(), to be released with drbd_free_page(). pp_in_use
+ * counts references, so a page shared by two holders counts twice while
+ * shared. Safe from irq context.
+ */
+void drbd_get_page(struct drbd_transport *transport, struct page *page)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+
+	get_page(page);
+	atomic_add(1 << compound_order(page), &connection->pp_in_use);
+}
+EXPORT_SYMBOL(drbd_get_page);
+
+static int
+peer_req_alloc_bio(struct drbd_peer_request *peer_req, size_t size, gfp_t gfp_mask, blk_opf_t opf)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_transport *transport = &peer_device->connection->transport;
+	struct drbd_device *device = peer_device->device;
+	enum req_op op = opf & REQ_OP_MASK;
+	unsigned short nr_vecs;
+	struct page *page;
+	struct bio *bio;
+
+	nr_vecs = DIV_ROUND_UP(size, PAGE_SIZE);
+	if (nr_vecs > BIO_MAX_VECS)
+		nr_vecs = BIO_MAX_VECS;
+
+	if (drbd_insert_fault(device, DRBD_FAULT_BIO_TOO_SMALL))
+		nr_vecs = DIV_ROUND_UP(nr_vecs, 4);
+
+	bio = bio_alloc_bioset(device->ldev->backing_bdev, nr_vecs, opf, gfp_mask,
+			       &drbd_peer_bio_set);
+	if (!bio)
+		return -ENOMEM;
+
+	bio_list_add(&peer_req->bios, bio);
 
-/* normal: payload_size == request size (bi_size)
- * w_same: payload_size == logical_block_size
- * trim: payload_size == 0 */
+	if (op == REQ_OP_READ) {
+		while (size) {
+			int len;
+
+			page = drbd_alloc_pages(transport, gfp_mask, size);
+			if (!page)
+				goto out_free_pages;
+			len = min(PAGE_SIZE << compound_order(page), size);
+
+			len = drbd_bio_add_page(transport, &peer_req->bios, page, len, 0);
+			if (len < 0)
+				goto out_free_pages;
+			size -= len;
+		}
+		if (!mempool_is_saturated(&drbd_buffer_page_pool))
+			peer_req->flags |= EE_RELEASE_TO_MEMPOOL;
+	}
+	return 0;
+
+out_free_pages:
+	drbd_peer_req_strip_bio(peer_req);
+	return -ENOMEM;
+}
+
+/**
+ * drbd_alloc_peer_req() - Allocate a drbd_peer_request
+ * @peer_device:      peer device object
+ * @gfp_mask:	      how to allocate and whether to loop until we succeed
+ * @size:	      size (normal I/O), logical_block_size (w_same), 0 (trim)
+ * @opf:              REQ_OP_READ or REQ_OP_WRITE
+ *
+ * For REQ_OP_READ, it allocates the peer_req with a BIO and populates it
+ * entirely with buffer pages. Otherwise it allocates the peer_req with
+ * an empty BIO.
+ *
+ * Return: the new peer request, or NULL if the allocation failed.
+ */
 struct drbd_peer_request *
-drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-		    unsigned int request_size, unsigned int payload_size, gfp_t gfp_mask) __must_hold(local)
+drbd_alloc_peer_req(struct drbd_peer_device *peer_device, gfp_t gfp_mask,
+		    size_t size, blk_opf_t opf)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
-	struct page *page = NULL;
-	unsigned int nr_pages = PFN_UP(payload_size);
+	int err;
 
+	gfp_mask &= ~__GFP_HIGHMEM;
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
 
-	peer_req = mempool_alloc(&drbd_ee_mempool, gfp_mask & ~__GFP_HIGHMEM);
+	peer_req = mempool_alloc(&drbd_ee_mempool, gfp_mask);
 	if (!peer_req) {
 		if (!(gfp_mask & __GFP_NOWARN))
 			drbd_err(device, "%s: allocation failed\n", __func__);
 		return NULL;
 	}
-
-	if (nr_pages) {
-		page = drbd_alloc_pages(peer_device, nr_pages,
-					gfpflags_allow_blocking(gfp_mask));
-		if (!page)
-			goto fail;
-		if (!mempool_is_saturated(&drbd_buffer_page_pool))
-			peer_req->flags |= EE_RELEASE_TO_MEMPOOL;
-	}
-
 	memset(peer_req, 0, sizeof(*peer_req));
+
 	INIT_LIST_HEAD(&peer_req->w.list);
 	drbd_clear_interval(&peer_req->i);
-	peer_req->i.size = request_size;
-	peer_req->i.sector = sector;
+	INIT_LIST_HEAD(&peer_req->recv_order);
 	peer_req->submit_jif = jiffies;
+	kref_get(&device->kref); /* this kref holds the peer_req->peer_device object alive */
 	peer_req->peer_device = peer_device;
-	peer_req->pages = page;
-	/*
-	 * The block_id is opaque to the receiver.  It is not endianness
-	 * converted, and sent back to the sender unchanged.
-	 */
-	peer_req->block_id = id;
+	peer_req->block_id = (unsigned long) peer_req;
+
+	if (opf == REQ_NO_BIO)
+		return peer_req;
+
+	err = peer_req_alloc_bio(peer_req, size, gfp_mask, opf);
+	if (err)
+		goto out_free_peer_req;
 
 	return peer_req;
 
- fail:
+out_free_peer_req:
+	kref_put(&device->kref, drbd_destroy_device);
 	mempool_free(peer_req, &drbd_ee_mempool);
 	return NULL;
 }
 
-void drbd_free_peer_req(struct drbd_device *device, struct drbd_peer_request *peer_req)
+void drbd_free_peer_req(struct drbd_peer_request *peer_req)
 {
-	might_sleep();
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
+
+	if (peer_req->flags & EE_ON_RECV_ORDER) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		if (peer_req->i.type == INTERVAL_RESYNC_WRITE)
+			drbd_list_del_resync_request(peer_req);
+		else
+			list_del(&peer_req->recv_order);
+		spin_unlock_irq(&connection->peer_reqs_lock);
+	}
+	D_ASSERT(peer_device, !(peer_req->flags & EE_ON_SEND_OOS));
 	if (peer_req->flags & EE_HAS_DIGEST)
 		kfree(peer_req->digest);
-	drbd_free_pages(device, peer_req->pages);
-	D_ASSERT(device, atomic_read(&peer_req->pending_bios) == 0);
-	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
-	if (!expect(device, !(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
-		peer_req->flags &= ~EE_CALL_AL_COMPLETE_IO;
-		drbd_al_complete_io(device, &peer_req->i);
-	}
+	D_ASSERT(peer_device, atomic_read(&peer_req->pending_bios) == 0);
+	D_ASSERT(peer_device, drbd_interval_empty(&peer_req->i));
+	drbd_peer_req_strip_bio(peer_req);
+	kref_put(&peer_device->device->kref, drbd_destroy_device);
 	mempool_free(peer_req, &drbd_ee_mempool);
 }
 
-int drbd_free_peer_reqs(struct drbd_device *device, struct list_head *list)
+int drbd_free_peer_reqs(struct drbd_connection *connection, struct list_head *list)
 {
 	LIST_HEAD(work_list);
 	struct drbd_peer_request *peer_req, *t;
 	int count = 0;
 
-	spin_lock_irq(&device->resource->req_lock);
+	spin_lock_irq(&connection->peer_reqs_lock);
 	list_splice_init(list, &work_list);
-	spin_unlock_irq(&device->resource->req_lock);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
 	list_for_each_entry_safe(peer_req, t, &work_list, w.list) {
-		drbd_free_peer_req(device, peer_req);
+		drbd_free_peer_req(peer_req);
 		count++;
 	}
 	return count;
@@ -252,109 +663,139 @@ int drbd_free_peer_reqs(struct drbd_device *device, struct list_head *list)
 /*
  * See also comments in _req_mod(,BARRIER_ACKED) and receive_Barrier.
  */
-static int drbd_finish_peer_reqs(struct drbd_device *device)
+static int drbd_finish_peer_reqs(struct drbd_connection *connection)
 {
 	LIST_HEAD(work_list);
 	struct drbd_peer_request *peer_req, *t;
 	int err = 0;
+	int n = 0;
 
-	spin_lock_irq(&device->resource->req_lock);
-	list_splice_init(&device->done_ee, &work_list);
-	spin_unlock_irq(&device->resource->req_lock);
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_splice_init(&connection->done_ee, &work_list);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
 	/* possible callbacks here:
-	 * e_end_block, and e_end_resync_block, e_send_superseded.
+	 * e_end_block, and e_end_resync_block.
 	 * all ignore the last argument.
 	 */
 	list_for_each_entry_safe(peer_req, t, &work_list, w.list) {
 		int err2;
 
+		++n;
 		/* list_del not necessary, next/prev members not touched */
+		/* The callback may free peer_req. */
 		err2 = peer_req->w.cb(&peer_req->w, !!err);
 		if (!err)
 			err = err2;
-		drbd_free_peer_req(device, peer_req);
 	}
-	wake_up(&device->ee_wait);
+	if (atomic_sub_and_test(n, &connection->done_ee_cnt))
+		wake_up(&connection->ee_wait);
 
 	return err;
 }
 
-static void _drbd_wait_ee_list_empty(struct drbd_device *device,
-				     struct list_head *head)
+/* conn_connect() arms a data stream receive timeout to bound the connect;
+ * receive_state() disarms it per peer device, so a connection that has none
+ * keeps it over a data stream that is now legitimately idle. Disarm here
+ * instead, from the timeout it caused: a receive already waiting took its
+ * timeout when it started, so disarming elsewhere comes too late for it.
+ */
+static bool disarm_stale_connect_timeout(struct drbd_connection *connection)
 {
-	DEFINE_WAIT(wait);
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_transport_ops *tr_ops = &transport->class->ops;
 
-	/* avoids spin_lock/unlock
-	 * and calling prepare_to_wait in the fast path */
-	while (!list_empty(head)) {
-		prepare_to_wait(&device->ee_wait, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock_irq(&device->resource->req_lock);
-		io_schedule();
-		finish_wait(&device->ee_wait, &wait);
-		spin_lock_irq(&device->resource->req_lock);
-	}
-}
+	if (connection->cstate[NOW] != C_CONNECTED)
+		return false;
 
-static void drbd_wait_ee_list_empty(struct drbd_device *device,
-				    struct list_head *head)
-{
-	spin_lock_irq(&device->resource->req_lock);
-	_drbd_wait_ee_list_empty(device, head);
-	spin_unlock_irq(&device->resource->req_lock);
+	if (tr_ops->get_rcvtimeo(transport, DATA_STREAM) == MAX_SCHEDULE_TIMEOUT)
+		return false;
+
+	drbd_info(connection, "Idle data stream on an established connection; "
+		  "disarming the connect receive timeout\n");
+	tr_ops->set_rcvtimeo(transport, DATA_STREAM, MAX_SCHEDULE_TIMEOUT);
+
+	return true;
 }
 
-static int drbd_recv_short(struct socket *sock, void *buf, size_t size, int flags)
+/* Before C_CONNECTED, the peer cannot announce a disconnect with a
+ * two-phase commit; closing the socket is its regular way to give up.
+ */
+static void conn_closed_by_peer(struct drbd_connection *connection)
 {
-	struct kvec iov = {
-		.iov_base = buf,
-		.iov_len = size,
-	};
-	struct msghdr msg = {
-		.msg_flags = (flags ? flags : MSG_WAITALL | MSG_NOSIGNAL)
-	};
-	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
-	return sock_recvmsg(sock, &msg, msg.msg_flags);
+	struct drbd_resource *resource = connection->resource;
+	unsigned long irq_flags;
+
+	/* lock_order_ok: no CS_SERIALIZE, state_sem is not taken */
+	begin_state_change(resource, &irq_flags, CS_HARD);
+	__change_cstate(connection, connection->cstate[NOW] == C_CONNECTING ?
+			C_TEAR_DOWN : C_BROKEN_PIPE);
+	end_state_change(resource, &irq_flags, NULL);
 }
 
-static int drbd_recv(struct drbd_connection *connection, void *buf, size_t size)
+static int drbd_recv(struct drbd_connection *connection, void **buf, size_t size, int flags)
 {
+	struct drbd_transport_ops *tr_ops = &connection->transport.class->ops;
 	int rv;
 
-	rv = drbd_recv_short(connection->data.socket, buf, size, 0);
+retry:
+	rv = tr_ops->recv(&connection->transport, DATA_STREAM, buf, size, flags);
+
+	/* At most one retry: the disarm makes the second attempt untimed. */
+	if (rv == -EAGAIN && disarm_stale_connect_timeout(connection))
+		goto retry;
 
 	if (rv < 0) {
 		if (rv == -ECONNRESET)
 			drbd_info(connection, "sock was reset by peer\n");
 		else if (rv != -ERESTARTSYS)
-			drbd_err(connection, "sock_recvmsg returned %d\n", rv);
+			drbd_info(connection, "sock_recvmsg returned %d\n", rv);
 	} else if (rv == 0) {
-		if (test_bit(DISCONNECT_SENT, &connection->flags)) {
+		if (test_bit(DISCONNECT_EXPECTED, &connection->flags)) {
 			long t;
+
 			rcu_read_lock();
-			t = rcu_dereference(connection->net_conf)->ping_timeo * HZ/10;
+			t = rcu_dereference(connection->transport.net_conf)->ping_timeo * HZ/10;
 			rcu_read_unlock();
 
-			t = wait_event_timeout(connection->ping_wait, connection->cstate < C_WF_REPORT_PARAMS, t);
+			t = wait_event_timeout(connection->resource->state_wait,
+					       connection->cstate[NOW] < C_CONNECTED, t);
 
 			if (t)
 				goto out;
 		}
 		drbd_info(connection, "sock was shut down by peer\n");
+		conn_closed_by_peer(connection);
+		goto out;
 	}
 
 	if (rv != size)
-		conn_request_state(connection, NS(conn, C_BROKEN_PIPE), CS_HARD);
+		change_cstate(connection, C_BROKEN_PIPE, CS_HARD);
 
 out:
 	return rv;
 }
 
-static int drbd_recv_all(struct drbd_connection *connection, void *buf, size_t size)
+static int drbd_recv_into(struct drbd_connection *connection, void *buf, size_t size)
+{
+	int err;
+
+	err = drbd_recv(connection, &buf, size, CALLER_BUFFER);
+
+	if (err != size) {
+		if (err >= 0)
+			err = -EIO;
+	} else
+		err = 0;
+	return err;
+}
+
+static int drbd_recv_all(struct drbd_connection *connection, void **buf, size_t size)
 {
 	int err;
 
-	err = drbd_recv(connection, buf, size);
+	err = drbd_recv(connection, buf, size, 0);
+
 	if (err != size) {
 		if (err >= 0)
 			err = -EIO;
@@ -363,7 +804,7 @@ static int drbd_recv_all(struct drbd_connection *connection, void *buf, size_t s
 	return err;
 }
 
-static int drbd_recv_all_warn(struct drbd_connection *connection, void *buf, size_t size)
+static int drbd_recv_all_warn(struct drbd_connection *connection, void **buf, size_t size)
 {
 	int err;
 
@@ -373,628 +814,746 @@ static int drbd_recv_all_warn(struct drbd_connection *connection, void *buf, siz
 	return err;
 }
 
-/* quoting tcp(7):
- *   On individual connections, the socket buffer size must be set prior to the
- *   listen(2) or connect(2) calls in order to have it take effect.
- * This is our wrapper to do so.
- */
-static void drbd_setbufsize(struct socket *sock, unsigned int snd,
-		unsigned int rcv)
+static int drbd_send_disconnect(struct drbd_connection *connection)
 {
-	/* open coded SO_SNDBUF, SO_RCVBUF */
-	if (snd) {
-		sock->sk->sk_sndbuf = snd;
-		sock->sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
-	}
-	if (rcv) {
-		sock->sk->sk_rcvbuf = rcv;
-		sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-	}
+	if (connection->agreed_pro_version < 118)
+		return 0;
+
+	if (!conn_prepare_command(connection, 0, DATA_STREAM))
+		return -EIO;
+	return send_command(connection, -1, P_DISCONNECT, DATA_STREAM);
 }
 
-static struct socket *drbd_try_connect(struct drbd_connection *connection)
+static void initialize_send_buffer(struct drbd_connection *connection, enum drbd_stream drbd_stream)
 {
-	const char *what;
-	struct socket *sock;
-	struct sockaddr_in6 src_in6;
-	struct sockaddr_in6 peer_in6;
-	struct net_conf *nc;
-	int err, peer_addr_len, my_addr_len;
-	int sndbuf_size, rcvbuf_size, connect_int;
-	int disconnect_on_error = 1;
+	struct drbd_send_buffer *sbuf = &connection->send_buffer[drbd_stream];
 
-	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	if (!nc) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	sndbuf_size = nc->sndbuf_size;
-	rcvbuf_size = nc->rcvbuf_size;
-	connect_int = nc->connect_int;
-	rcu_read_unlock();
+	sbuf->unsent =
+	sbuf->pos = page_address(sbuf->page);
+	sbuf->allocated_size = 0;
+	sbuf->additional_size = 0;
+	sbuf->dead = false;
+}
+
+/* Gets called if a connection is established, or if a new minor gets created
+   in a connection */
+int drbd_connected(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	u64 weak_nodes = 0;
+	int err;
 
-	my_addr_len = min_t(int, connection->my_addr_len, sizeof(src_in6));
-	memcpy(&src_in6, &connection->my_addr, my_addr_len);
+	atomic_set(&peer_device->packet_seq, 0);
+	peer_device->peer_seq = 0;
 
-	if (((struct sockaddr *)&connection->my_addr)->sa_family == AF_INET6)
-		src_in6.sin6_port = 0;
-	else
-		((struct sockaddr_in *)&src_in6)->sin_port = 0; /* AF_INET & AF_SCI */
+	if (device->resource->role[NOW] == R_PRIMARY)
+		weak_nodes = drbd_weak_nodes_device(device);
 
-	peer_addr_len = min_t(int, connection->peer_addr_len, sizeof(src_in6));
-	memcpy(&peer_in6, &connection->peer_addr, peer_addr_len);
+	err = drbd_send_sync_param(peer_device);
 
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&src_in6)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &sock);
-	if (err < 0) {
-		sock = NULL;
-		goto out;
+	if (!err)
+		err = drbd_send_enable_replication_next(peer_device);
+	if (!err)
+		err = drbd_send_sizes(peer_device, 0, 0);
+	if (!err)
+		err = drbd_send_uuids(peer_device, 0, weak_nodes);
+	if (!err) {
+		set_bit(INITIAL_STATE_SENT, peer_device->flags);
+		err = drbd_send_current_state(peer_device);
 	}
 
-	sock->sk->sk_rcvtimeo =
-	sock->sk->sk_sndtimeo = connect_int * HZ;
-	drbd_setbufsize(sock, sndbuf_size, rcvbuf_size);
-
-       /* explicitly bind to the configured IP as source IP
-	*  for the outgoing connections.
-	*  This is needed for multihomed hosts and to be
-	*  able to use lo: interfaces for drbd.
-	* Make sure to use 0 as port number, so linux selects
-	*  a free one dynamically.
-	*/
-	what = "bind before connect";
-	err = sock->ops->bind(sock, (struct sockaddr_unsized *) &src_in6, my_addr_len);
-	if (err < 0)
-		goto out;
+	clear_bit(USE_DEGR_WFC_T, peer_device->flags);
+	clear_bit(RESIZE_PENDING, peer_device->flags);
+	mod_timer(&device->request_timer, jiffies + HZ); /* just start it here. */
+	return err;
+}
 
-	/* connect may fail, peer not yet available.
-	 * stay C_WF_CONNECTION, don't go Disconnecting! */
-	disconnect_on_error = 0;
-	what = "connect";
-	err = sock->ops->connect(sock, (struct sockaddr_unsized *) &peer_in6, peer_addr_len, 0);
+void conn_connect2(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
 
-out:
-	if (err < 0) {
-		if (sock) {
-			sock_release(sock);
-			sock = NULL;
-		}
-		switch (-err) {
-			/* timeout, busy, signal pending */
-		case ETIMEDOUT: case EAGAIN: case EINPROGRESS:
-		case EINTR: case ERESTARTSYS:
-			/* peer not (yet) available, network problem */
-		case ECONNREFUSED: case ENETUNREACH:
-		case EHOSTDOWN:    case EHOSTUNREACH:
-			disconnect_on_error = 0;
-			break;
-		default:
-			drbd_err(connection, "%s failed, err = %d\n", what, err);
+	/*
+	 * If a common primary is currently absent and we have a dagtag toward
+	 * it, hand the peer our position in its change stream before the UUID
+	 * and state packets below. drbd_uuid_compare() on the peer uses it to
+	 * roll an equal-UUID both-dirty reconcile forward (the node further
+	 * along the stream becomes the source). Feature-gated; a peer without
+	 * the feature never receives it and falls back to a node-id choice.
+	 */
+	if (connection->agreed_features & DRBD_FF_RECONCILE_RECONNECT) {
+		int lost_node_id = find_common_lost_primary_node_id(connection);
+		struct drbd_connection *lost_peer = lost_node_id == -1 ? NULL :
+			drbd_get_connection_by_node_id(connection->resource, lost_node_id);
+
+		if (lost_peer) {
+			if (!drbd_send_peer_dagtag(connection, lost_peer))
+				connection->reconcile_handshake.sent_lost_node = true;
+			kref_put(&lost_peer->kref, drbd_destroy_connection);
 		}
-		if (disconnect_on_error)
-			conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
 	}
 
-	return sock;
-}
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
 
-struct accept_wait_data {
-	struct drbd_connection *connection;
-	struct socket *s_listen;
-	struct completion door_bell;
-	void (*original_sk_state_change)(struct sock *sk);
+		kref_get(&device->kref);
 
-};
+		/* connection cannot go away: caller holds a reference. */
+		rcu_read_unlock();
 
-static void drbd_incoming_connection(struct sock *sk)
-{
-	struct accept_wait_data *ad = sk->sk_user_data;
-	void (*state_change)(struct sock *sk);
+		/* In the compatibility case with protocol version < 110, that
+		 * is DRBD 8.4, we do not hold uuid_sem while exchanging the
+		 * initial UUID and state packets. There is no need because
+		 * there are no other peers which could interfere. */
+		if (connection->agreed_pro_version >= 110) {
+			down_read_non_owner(&device->uuid_sem);
+			set_bit(HOLDING_UUID_READ_LOCK, peer_device->flags);
+			/* since drbd_connected() is also called from drbd_create_device()
+			   aquire lock here before calling drbd_connected(). */
+		}
+		drbd_connected(peer_device);
 
-	state_change = ad->original_sk_state_change;
-	if (sk->sk_state == TCP_ESTABLISHED)
-		complete(&ad->door_bell);
-	state_change(sk);
+		rcu_read_lock();
+		kref_put(&device->kref, drbd_destroy_device);
+	}
+	rcu_read_unlock();
+	drbd_uncork(connection, DATA_STREAM);
 }
 
-static int prepare_listen_socket(struct drbd_connection *connection, struct accept_wait_data *ad)
+static bool initial_states_received(struct drbd_connection *connection)
 {
-	int err, sndbuf_size, rcvbuf_size, my_addr_len;
-	struct sockaddr_in6 my_addr;
-	struct socket *s_listen;
-	struct net_conf *nc;
-	const char *what;
-
+	struct drbd_peer_device *peer_device;
+	int vnr;
+	bool rv = true;
+
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	if (!nc) {
-		rcu_read_unlock();
-		return -EIO;
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags)) {
+			rv = false;
+			break;
+		}
 	}
-	sndbuf_size = nc->sndbuf_size;
-	rcvbuf_size = nc->rcvbuf_size;
 	rcu_read_unlock();
 
-	my_addr_len = min_t(int, connection->my_addr_len, sizeof(struct sockaddr_in6));
-	memcpy(&my_addr, &connection->my_addr, my_addr_len);
-
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&my_addr)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &s_listen);
-	if (err) {
-		s_listen = NULL;
-		goto out;
-	}
-
-	s_listen->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
-	drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
-
-	what = "bind before listen";
-	err = s_listen->ops->bind(s_listen, (struct sockaddr_unsized *)&my_addr, my_addr_len);
-	if (err < 0)
-		goto out;
+	return rv;
+}
 
-	ad->s_listen = s_listen;
-	write_lock_bh(&s_listen->sk->sk_callback_lock);
-	ad->original_sk_state_change = s_listen->sk->sk_state_change;
-	s_listen->sk->sk_state_change = drbd_incoming_connection;
-	s_listen->sk->sk_user_data = ad;
-	write_unlock_bh(&s_listen->sk->sk_callback_lock);
+void wait_initial_states_received(struct drbd_connection *connection)
+{
+	struct drbd_net_conf *nc;
+	long timeout;
 
-	what = "listen";
-	err = s_listen->ops->listen(s_listen, 5);
-	if (err < 0)
-		goto out;
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	timeout = nc->ping_timeo * HZ/10;
+	rcu_read_unlock();
+	wait_event_interruptible_timeout(connection->ee_wait,
+					 initial_states_received(connection),
+					 timeout);
+}
 
-	return 0;
-out:
-	if (s_listen)
-		sock_release(s_listen);
-	if (err < 0) {
-		if (err != -EAGAIN && err != -EINTR && err != -ERESTARTSYS) {
-			drbd_err(connection, "%s failed, err = %d\n", what, err);
-			conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-		}
-	}
+void connect_timer_fn(struct timer_list *t)
+{
+	struct drbd_connection *connection = timer_container_of(connection, t, connect_timer);
 
-	return -EIO;
+	drbd_queue_work(&connection->sender_work, &connection->connect_timer_work);
 }
 
-static void unregister_state_change(struct sock *sk, struct accept_wait_data *ad)
+static void arm_connect_timer(struct drbd_connection *connection, unsigned long expires)
 {
-	write_lock_bh(&sk->sk_callback_lock);
-	sk->sk_state_change = ad->original_sk_state_change;
-	sk->sk_user_data = NULL;
-	write_unlock_bh(&sk->sk_callback_lock);
+	bool was_pending = mod_timer(&connection->connect_timer, expires);
+
+	if (was_pending) {
+		kref_put(&connection->kref, drbd_destroy_connection);
+	}
 }
 
-static struct socket *drbd_wait_for_connect(struct drbd_connection *connection, struct accept_wait_data *ad)
+static bool retry_by_rr_conflict(struct drbd_connection *connection)
 {
-	int timeo, connect_int, err = 0;
-	struct socket *s_estab = NULL;
-	struct net_conf *nc;
+	enum drbd_after_sb_p rr_conflict;
+	struct drbd_net_conf *nc;
 
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	if (!nc) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	connect_int = nc->connect_int;
+	nc = rcu_dereference(connection->transport.net_conf);
+	rr_conflict = nc->rr_conflict;
 	rcu_read_unlock();
 
-	timeo = connect_int * HZ;
-	/* 28.5% random jitter */
-	timeo += get_random_u32_below(2) ? timeo / 7 : -timeo / 7;
-
-	err = wait_for_completion_interruptible_timeout(&ad->door_bell, timeo);
-	if (err <= 0)
-		return NULL;
+	return rr_conflict == ASB_RETRY_CONNECT;
+}
 
-	err = kernel_accept(ad->s_listen, &s_estab, 0);
-	if (err < 0) {
-		if (err != -EAGAIN && err != -EINTR && err != -ERESTARTSYS) {
-			drbd_err(connection, "accept failed, err = %d\n", err);
-			conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-		}
-	}
+static void apply_local_state_change(struct drbd_connection *connection, enum ao_op ao_op, bool force_demote)
+{
+	/* Although the connect failed, outdate local disks if we learn from the
+	 * handshake that the peer has more recent data */
+	struct drbd_resource *resource = connection->resource;
+	unsigned long irq_flags;
+	int vnr;
 
-	if (s_estab)
-		unregister_state_change(s_estab->sk, ad);
+	mutex_lock(&resource->open_release);
+	begin_state_change(resource, &irq_flags, CS_HARD | (force_demote ? CS_FS_IGN_OPENERS : 0));
+	if (ao_op == OUTDATE_DISKS_AND_DISCONNECT)
+		__change_cstate(connection, C_DISCONNECTING);
+	if (resource->role[NOW] == R_SECONDARY ||
+	    (resource->cached_susp && (
+		    resource->res_opts.on_no_data == OND_IO_ERROR ||
+		    resource->res_opts.on_susp_primary_outdated == SPO_FORCE_SECONDARY))) {
+		/* One day we might relax the above condition to
+		 * resource->role[NOW] == R_SECONDARY || resource->cached_susp
+		 * Right now it is that way, because we do not offer a way to gracefully
+		 * get out of a Primary/Outdated state */
+		struct drbd_peer_device *peer_device;
+		bool set_fail_io = false;
 
-	return s_estab;
-}
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			enum drbd_repl_state r = peer_device->connect_state.conn;
+			struct drbd_device *device = peer_device->device;
 
-static int decode_header(struct drbd_connection *, void *, struct packet_info *);
+			if (r == L_WF_BITMAP_T || r == L_SYNC_TARGET || r == L_PAUSED_SYNC_T)
+				__change_disk_state(device, D_OUTDATED);
 
-static int send_first_packet(struct drbd_connection *connection, struct drbd_socket *sock,
-			     enum drbd_packet cmd)
-{
-	if (!conn_prepare_command(connection, sock))
-		return -EIO;
-	return conn_send_command(connection, sock, cmd, 0, NULL, 0);
+			if (device->open_cnt)
+				set_fail_io = true;
+		}
+		if (resource->role[NOW] == R_PRIMARY && force_demote) {
+			drbd_warn(connection, "Remote node has more recent data;"
+				  " force secondary!\n");
+			resource->role[NEW] = R_SECONDARY;
+			if (set_fail_io)
+				resource->fail_io[NEW] = true;
+		}
+	}
+	end_state_change(resource, &irq_flags, "connect-failed");
+	mutex_unlock(&resource->open_release);
 }
 
-static int receive_first_packet(struct drbd_connection *connection, struct socket *sock)
+/* Without the initial state of every volume finish_nested_twopc() never sets
+ * CONN_HANDSHAKE_READY, and the connect runs to twopc-timeout for good.
+ */
+static void report_missing_initial_states(struct drbd_connection *connection)
 {
-	unsigned int header_size = drbd_header_size(connection);
-	struct packet_info pi;
-	struct net_conf *nc;
-	int err;
+	struct drbd_peer_device *peer_device;
+	int vnr;
 
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	if (!nc) {
-		rcu_read_unlock();
-		return -EIO;
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags))
+			drbd_warn(connection,
+				  "Connect cannot complete: the peer sent no state for volume %d\n",
+				  vnr);
 	}
-	sock->sk->sk_rcvtimeo = nc->ping_timeo * 4 * HZ / 10;
 	rcu_read_unlock();
-
-	err = drbd_recv_short(sock, connection->data.rbuf, header_size, 0);
-	if (err != header_size) {
-		if (err >= 0)
-			err = -EIO;
-		return err;
-	}
-	err = decode_header(connection, connection->data.rbuf, &pi);
-	if (err)
-		return err;
-	return pi.cmd;
 }
 
-/**
- * drbd_socket_okay() - Free the socket if its connection is not okay
- * @sock:	pointer to the pointer to the socket.
+/* Ends a burst of connect attempts: the transport session is given up, so
+ * connect-int becomes the cool-down instead of another 50 ms re-arm.
  */
-static bool drbd_socket_okay(struct socket **sock)
-{
-	int rr;
-	char tb[4];
+#define CONNECT_TRIES_PER_SESSION 10
 
-	if (!*sock)
-		return false;
+static unsigned long connect_retry_delay(struct drbd_connection *connection,
+					 unsigned long elapsed)
+{
+	/* Idle at least as long as the attempt was busy, so a connect that keeps
+	 * failing cannot hold the transaction more than half of the time.
+	 */
+	return clamp_t(unsigned long, elapsed, HZ / 20,
+		       twopc_timeout(connection->resource));
+}
 
-	rr = drbd_recv_short(*sock, tb, 4, MSG_DONTWAIT | MSG_PEEK);
+static bool connect_retry_allowed(struct drbd_connection *connection,
+				  enum drbd_state_rv rv, unsigned long elapsed)
+{
+	/* Yielding to a concurrent state change gives up before the prepare, so
+	 * such an attempt costs nothing and does not spend one of the tries.
+	 */
+	if (rv == SS_CONCURRENT_ST_CHG && elapsed < HZ / 20)
+		return true;
 
-	if (rr > 0 || rr == -EAGAIN) {
+	if (++connection->connect_tries <= CONNECT_TRIES_PER_SESSION)
 		return true;
-	} else {
-		sock_release(*sock);
-		*sock = NULL;
-		return false;
-	}
+
+	drbd_info(connection, "Connect keeps failing (%s); retrying after connect-int\n",
+		  drbd_set_st_err_str(rv));
+	return false;
 }
 
-static bool connection_established(struct drbd_connection *connection,
-				   struct socket **sock1,
-				   struct socket **sock2)
+static int connect_work(struct drbd_work *work, int cancel)
 {
-	struct net_conf *nc;
-	int timeout;
-	bool ok;
+	struct drbd_connection *connection =
+		container_of(work, struct drbd_connection, connect_timer_work);
+	struct drbd_resource *resource = connection->resource;
+	enum drbd_state_rv rv;
+	long t = resource->res_opts.auto_promote_timeout * HZ / 10;
+	bool retry = retry_by_rr_conflict(connection);
+	bool incompat_states, force_demote;
+	unsigned long start_time;
 
-	if (!*sock1 || !*sock2)
-		return false;
+	if (connection->cstate[NOW] != C_CONNECTING)
+		goto out_put;
 
-	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	timeout = (nc->sock_check_timeo ?: nc->ping_timeo) * HZ / 10;
-	rcu_read_unlock();
-	schedule_timeout_interruptible(timeout);
+	if (connection->agreed_pro_version == 117)
+		wait_initial_states_received(connection);
+
+	start_time = jiffies;
+	do {
+		/* Carefully check if it is okay to do a two_phase_commit from sender context */
+		if (down_trylock(&resource->state_sem)) {
+			rv = SS_CONCURRENT_ST_CHG;
+			break;
+		}
+		rv = change_cstate_tag(connection, C_CONNECTED, CS_SERIALIZE |
+				   CS_ALREADY_SERIALIZED | CS_VERBOSE | CS_DONT_RETRY,
+				   "connected", NULL);
+		up(&resource->state_sem);
+		if (rv != SS_PRIMARY_READER)
+			break;
 
-	ok = drbd_socket_okay(sock1);
-	ok = drbd_socket_okay(sock2) && ok;
+		/* We have a connection established, peer is primary. On my side is a
+		   read-only opener, probably udev or some other scanning after device creating.
+		   This short lived read-only open prevents now that we can continue.
+		   Better retry after the read-only opener goes away. */
+
+		t = wait_event_interruptible_timeout(resource->state_wait,
+						     !drbd_open_ro_count(resource),
+						     t);
+	} while (t > 0);
+
+	incompat_states = (rv == SS_CW_FAILED_BY_PEER || rv == SS_TWO_PRIMARIES);
+	force_demote = resource->role[NOW] == R_PRIMARY &&
+		resource->res_opts.on_susp_primary_outdated == SPO_FORCE_SECONDARY;
+	retry = retry || force_demote;
+
+	if (rv >= SS_SUCCESS) {
+		if (connection->agreed_pro_version < 117)
+			conn_connect2(connection);
+	} else if (rv == SS_TIMEOUT || rv == SS_CONCURRENT_ST_CHG) {
+		unsigned long elapsed = jiffies - start_time;
+
+		if (connection->cstate[NOW] != C_CONNECTING)
+			goto out_put;
+		/* Only after a timeout: SS_CONCURRENT_ST_CHG gives up before the
+		 * prepare, so no state can have arrived for this attempt.
+		 */
+		if (rv == SS_TIMEOUT)
+			report_missing_initial_states(connection);
+		if (connect_retry_allowed(connection, rv, elapsed)) {
+			arm_connect_timer(connection, jiffies +
+				connect_retry_delay(connection, elapsed));
+			return 0; /* Return early. Keep the reference on the connection! */
+		}
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+	} else if (rv == SS_HANDSHAKE_RETRY || (incompat_states && retry)) {
+		bool again = connect_retry_allowed(connection, rv, jiffies - start_time);
+
+		if (again)
+			arm_connect_timer(connection, jiffies + HZ);
+		apply_local_state_change(connection, OUTDATE_DISKS, force_demote);
+		if (again)
+			return 0; /* Keep reference */
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+	} else if (rv == SS_HANDSHAKE_DISCONNECT || (incompat_states && !retry)) {
+		drbd_send_disconnect(connection);
+		apply_local_state_change(connection, OUTDATE_DISKS_AND_DISCONNECT, force_demote);
+	} else {
+		drbd_info(connection, "Failure to connect: %s (%d); retrying\n",
+			  drbd_set_st_err_str(rv), rv);
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+	}
 
-	return ok;
+ out_put:
+	kref_put(&connection->kref, drbd_destroy_connection);
+	return 0;
 }
 
-/* Gets called if a connection is established, or if a new minor gets created
-   in a connection */
-int drbd_connected(struct drbd_peer_device *peer_device)
+static int drbd_transport_connect(struct drbd_connection *connection)
 {
-	struct drbd_device *device = peer_device->device;
-	int err;
-
-	atomic_set(&device->packet_seq, 0);
-	device->peer_seq = 0;
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_resource *resource = connection->resource;
+	int err = 0;
 
-	device->state_mutex = peer_device->connection->agreed_pro_version < 100 ?
-		&peer_device->connection->cstate_mutex :
-		&device->own_state_mutex;
+	mutex_lock(&resource->conf_update);
+	err = transport->class->ops.prepare_connect(transport);
+	mutex_unlock(&resource->conf_update);
 
-	err = drbd_send_sync_param(peer_device);
 	if (!err)
-		err = drbd_send_sizes(peer_device, 0, 0);
-	if (!err)
-		err = drbd_send_uuids(peer_device);
-	if (!err)
-		err = drbd_send_current_state(peer_device);
-	clear_bit(USE_DEGR_WFC_T, &device->flags);
-	clear_bit(RESIZE_PENDING, &device->flags);
-	atomic_set(&device->ap_in_flight, 0);
-	mod_timer(&device->request_timer, jiffies + HZ); /* just start it here. */
+		err = transport->class->ops.connect(transport);
+
+	mutex_lock(&resource->conf_update);
+	transport->class->ops.finish_connect(transport);
+	mutex_unlock(&resource->conf_update);
+
 	return err;
 }
 
-/*
- * return values:
- *   1 yes, we have a valid connection
- *   0 oops, did not work out, please try again
- *  -1 peer talks different language,
- *     no point in trying again, please go standalone.
- *  -2 We do not have a network config...
+/* A peer returning while this volume owes a new data generation for writes that
+ * already completed is accepted at the still equal current UUID and then adopts
+ * the generation that is minted a moment later: once it is connected
+ * drbd_weak_nodes_device() no longer counts it weak, so no bitmap slot is
+ * stamped toward it, and the writes it missed survive only as other replicas'
+ * out-of-sync bits, which order no resync at equal current UUIDs.  Order the
+ * local handshake behind the mint, so the UUIDs sent below carry it and the
+ * returner resyncs.  A latent obligation owes nothing to a returner -- the data
+ * is identical -- and is left to the next write.
+ *
+ * Sleeps.  Called from the connection's receiver thread while the peer is still
+ * C_CONNECTING and D_UNKNOWN, holding no lock.
  */
-static int conn_connect(struct drbd_connection *connection)
+static void device_mint_before_handshake(struct drbd_device *device, long timeout)
 {
-	struct drbd_socket sock, msock;
-	struct drbd_peer_device *peer_device;
-	struct net_conf *nc;
-	int vnr, timeout, h;
-	bool discard_my_data, ok;
-	enum drbd_state_rv rv;
-	struct accept_wait_data ad = {
-		.connection = connection,
-		.door_bell = COMPLETION_INITIALIZER_ONSTACK(ad.door_bell),
-	};
+	switch (drbd_gen_obligation_state(device)) {
+	case GEN_OBL_ARMED:
+		/* Latent: no completed write is missing on the returner, so it is
+		 * data identical at the equal current UUID -- no hold, no mint.
+		 */
+		if (!drbd_gen_obligation_materialized(device))
+			break;
+		/* Materialized, and still armed: its mandatory mint failed at the
+		 * completing edge.  Retry it here, in the receiver thread, before
+		 * the UUID exchange; the executor's exit decides what remains.
+		 */
+		if (drbd_gen_obligation_mint_start(device))
+			drbd_gen_obligation_mint_run(device);
+		break;
+	case GEN_OBL_MINTING:
+		/* Another consumer is evaluating this obligation; wait for its
+		 * outcome.  On timeout proceed -- the connect retry loop comes
+		 * around again.
+		 */
+		wait_event_timeout(device->misc_wait,
+				   drbd_gen_obligation_state(device) != GEN_OBL_MINTING,
+				   timeout);
+		break;
+	case GEN_OBL_UNCONFIRMED:
+		/* Wait for the confirmation, but proceed when it does not come:
+		 * it may be one only this peer can give.  A diskless primary
+		 * whose sole peer is the returner needs that peer's barrier ack,
+		 * which needs this connect to complete -- an unbounded wait
+		 * would deadlock against it.  A returner one generation behind
+		 * is then handled by the diskless reconnect handshake, which
+		 * replays it forward or parks it until a resync.
+		 */
+		wait_event_timeout(device->misc_wait,
+				   drbd_gen_obligation_state(device) != GEN_OBL_UNCONFIRMED,
+				   timeout);
+		break;
+	case GEN_OBL_PARKED:
+		/* No hold: while writers fail fast no write completes, so a
+		 * returner at an equal current UUID is data identical, and the
+		 * mint of the unpark reaches it in order once connected.
+		 */
+		break;
+	case GEN_OBL_NONE:
+	case GEN_OBL_DISCHARGED:
+		break;
+	}
+}
 
-	clear_bit(DISCONNECT_SENT, &connection->flags);
-	if (conn_request_state(connection, NS(conn, C_WF_CONNECTION), CS_VERBOSE) < SS_SUCCESS)
-		return -2;
+static void conn_mint_before_handshake(struct drbd_connection *connection, long timeout)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
 
-	mutex_init(&sock.mutex);
-	sock.sbuf = connection->data.sbuf;
-	sock.rbuf = connection->data.rbuf;
-	sock.socket = NULL;
-	mutex_init(&msock.mutex);
-	msock.sbuf = connection->meta.sbuf;
-	msock.rbuf = connection->meta.rbuf;
-	msock.socket = NULL;
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
 
-	/* Assume that the peer only understands protocol 80 until we know better.  */
-	connection->agreed_pro_version = 80;
+		kref_get(&device->kref);
 
-	if (prepare_listen_socket(connection, &ad))
-		return 0;
+		/* connection cannot go away: caller holds a reference. */
+		rcu_read_unlock();
 
-	do {
-		struct socket *s;
-
-		s = drbd_try_connect(connection);
-		if (s) {
-			if (!sock.socket) {
-				sock.socket = s;
-				send_first_packet(connection, &sock, P_INITIAL_DATA);
-			} else if (!msock.socket) {
-				clear_bit(RESOLVE_CONFLICTS, &connection->flags);
-				msock.socket = s;
-				send_first_packet(connection, &msock, P_INITIAL_META);
-			} else {
-				drbd_err(connection, "Logic error in conn_connect()\n");
-				goto out_release_sockets;
-			}
-		}
+		device_mint_before_handshake(device, timeout);
 
-		if (connection_established(connection, &sock.socket, &msock.socket))
-			break;
+		rcu_read_lock();
+		kref_put(&device->kref, drbd_destroy_device);
+	}
+	rcu_read_unlock();
+}
 
-retry:
-		s = drbd_wait_for_connect(connection, &ad);
-		if (s) {
-			int fp = receive_first_packet(connection, s);
-			drbd_socket_okay(&sock.socket);
-			drbd_socket_okay(&msock.socket);
-			switch (fp) {
-			case P_INITIAL_DATA:
-				if (sock.socket) {
-					drbd_warn(connection, "initial packet S crossed\n");
-					sock_release(sock.socket);
-					sock.socket = s;
-					goto randomize;
-				}
-				sock.socket = s;
-				break;
-			case P_INITIAL_META:
-				set_bit(RESOLVE_CONFLICTS, &connection->flags);
-				if (msock.socket) {
-					drbd_warn(connection, "initial packet M crossed\n");
-					sock_release(msock.socket);
-					msock.socket = s;
-					goto randomize;
-				}
-				msock.socket = s;
-				break;
-			default:
-				drbd_warn(connection, "Error receiving initial packet\n");
-				sock_release(s);
-randomize:
-				if (get_random_u32_below(2))
-					goto retry;
-			}
-		}
+/*
+ * Returns true if we have a valid connection.
+ */
+static bool conn_connect(struct drbd_connection *connection)
+{
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_resource *resource = connection->resource;
+	int ping_timeo, ping_int, h, err, vnr, in_flight;
+	struct drbd_peer_device *peer_device;
+	enum drbd_stream stream;
+	struct drbd_net_conf *nc;
+	bool discard_my_data;
+	bool have_mutex;
+	bool no_addr = false;
+
+start:
+	have_mutex = false;
+	clear_bit(PING_PENDING, &connection->flags);
+	clear_bit(DISCONNECT_EXPECTED, &connection->flags);
+	/* A send that failed on the previous socket must not fail this attempt:
+	 * C_CONNECTING lets other threads flush before the transport is up.
+	 */
+	for (stream = DATA_STREAM; stream <= CONTROL_STREAM; stream++) {
+		mutex_lock(&connection->mutex[stream]);
+		initialize_send_buffer(connection, stream);
+		mutex_unlock(&connection->mutex[stream]);
+	}
+	if (change_cstate_tag(connection, C_CONNECTING, CS_VERBOSE, "connecting", NULL)
+			< SS_SUCCESS) {
+		/* We do not have a network config. */
+		return false;
+	}
 
-		if (connection->cstate <= C_DISCONNECTING)
-			goto out_release_sockets;
-		if (signal_pending(current)) {
-			flush_signals(current);
-			smp_rmb();
-			if (get_t_state(&connection->receiver) == EXITING)
-				goto out_release_sockets;
-		}
+	/* Assume that the peer only understands our minimum supported
+	 * protocol version; until we know better. */
+	connection->agreed_pro_version = drbd_protocol_version_min;
 
-		ok = connection_established(connection, &sock.socket, &msock.socket);
-	} while (!ok);
+	err = drbd_transport_connect(connection);
+	if (err == -EAGAIN) {
+		enum drbd_conn_state cstate;
 
-	if (ad.s_listen)
-		sock_release(ad.s_listen);
+		read_lock_irq(&resource->state_rwlock); /* See commit message */
+		cstate = connection->cstate[NOW];
+		read_unlock_irq(&resource->state_rwlock);
+		if (cstate == C_DISCONNECTING)
+			return false;
+		goto retry;
+	} else if (err == -EADDRNOTAVAIL) {
+		struct drbd_net_conf *nc;
+		int connect_int;
+		long t;
 
-	sock.socket->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
-	msock.socket->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
+		rcu_read_lock();
+		nc = rcu_dereference(transport->net_conf);
+		connect_int = nc ? nc->connect_int : 10;
+		rcu_read_unlock();
 
-	sock.socket->sk->sk_allocation = GFP_NOIO;
-	msock.socket->sk->sk_allocation = GFP_NOIO;
+		if (!no_addr) {
+			drbd_warn(connection,
+				  "Configured local address not found, retrying every %d sec, "
+				  "err=%d\n", connect_int, err);
+			no_addr = true;
+		}
 
-	sock.socket->sk->sk_use_task_frag = false;
-	msock.socket->sk->sk_use_task_frag = false;
+		t = schedule_timeout_interruptible(connect_int * HZ);
+		if (t || connection->cstate[NOW] == C_DISCONNECTING)
+			return false;
+		goto start;
+	} else if (err == -EDESTADDRREQ) {
+		/*
+		 * No destination address, we cannot possibly make a connection.
+		 * Maybe a resource was partially left over due to some other bug?
+		 * Either way, abort here and go StandAlone to prevent reconnection.
+		 */
+		drbd_err(connection, "No destination address, err=%d\n", err);
+		change_cstate_tag(connection, C_STANDALONE, CS_HARD, "no-dest-addr", NULL);
+		return false;
+	} else if (err < 0) {
+		drbd_warn(connection, "Failed to initiate connection, err=%d\n", err);
+		goto abort;
+	}
 
-	sock.socket->sk->sk_priority = TC_PRIO_INTERACTIVE_BULK;
-	msock.socket->sk->sk_priority = TC_PRIO_INTERACTIVE;
+	connection->reassemble_buffer.avail = 0;
 
-	/* NOT YET ...
-	 * sock.socket->sk->sk_sndtimeo = connection->net_conf->timeout*HZ/10;
-	 * sock.socket->sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
-	 * first set it to the P_CONNECTION_FEATURES timeout,
-	 * which we set to 4x the configured ping_timeout. */
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-
-	sock.socket->sk->sk_sndtimeo =
-	sock.socket->sk->sk_rcvtimeo = nc->ping_timeo*4*HZ/10;
-
-	msock.socket->sk->sk_rcvtimeo = nc->ping_int*HZ;
-	timeout = nc->timeout * HZ / 10;
-	discard_my_data = nc->discard_my_data;
+	nc = rcu_dereference(connection->transport.net_conf);
+	ping_timeo = nc->ping_timeo;
+	ping_int = nc->ping_int;
 	rcu_read_unlock();
 
-	msock.socket->sk->sk_sndtimeo = timeout;
-
-	/* we don't want delays.
-	 * we use TCP_CORK where appropriate, though */
-	tcp_sock_set_nodelay(sock.socket->sk);
-	tcp_sock_set_nodelay(msock.socket->sk);
+	/* Make sure we are "uncorked", otherwise we risk timeouts,
+	 * in case this is a reconnect and we had been corked before. */
+	for (stream = DATA_STREAM; stream <= CONTROL_STREAM; stream++) {
+		initialize_send_buffer(connection, stream);
+		drbd_uncork(connection, stream);
+	}
 
-	connection->data.socket = sock.socket;
-	connection->meta.socket = msock.socket;
-	connection->last_received = jiffies;
+	/* Make sure the handshake happens without interference from other threads,
+	 * or the challenge response authentication could be garbled. */
+	mutex_lock(&connection->mutex[DATA_STREAM]);
+	have_mutex = true;
+	clear_bit(PING_TIMEOUT_ACTIVE, &connection->flags);
+	transport->class->ops.set_rcvtimeo(transport, DATA_STREAM, ping_timeo * 4 * HZ/10);
+	transport->class->ops.set_rcvtimeo(transport, CONTROL_STREAM, ping_int * HZ);
 
 	h = drbd_do_features(connection);
-	if (h <= 0)
-		return h;
+	if (h < 0)
+		goto abort;
+	if (h == 0)
+		goto retry;
 
 	if (connection->cram_hmac_tfm) {
-		/* drbd_request_state(device, NS(conn, WFAuth)); */
 		switch (drbd_do_auth(connection)) {
 		case -1:
 			drbd_err(connection, "Authentication of peer failed\n");
-			return -1;
+			goto abort;
 		case 0:
 			drbd_err(connection, "Authentication of peer failed, trying again.\n");
-			return 0;
+			goto retry;
 		}
 	}
 
-	connection->data.socket->sk->sk_sndtimeo = timeout;
-	connection->data.socket->sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
-
-	if (drbd_send_protocol(connection) == -EOPNOTSUPP)
-		return -1;
-
-	/* Prevent a race between resync-handshake and
-	 * being promoted to Primary.
-	 *
-	 * Grab and release the state mutex, so we know that any current
-	 * drbd_set_role() is finished, and any incoming drbd_set_role
-	 * will see the STATE_SENT flag, and wait for it to be cleared.
-	 */
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
-		mutex_lock(peer_device->device->state_mutex);
-
-	/* avoid a race with conn_request_state( C_DISCONNECTING ) */
-	spin_lock_irq(&connection->resource->req_lock);
-	set_bit(STATE_SENT, &connection->flags);
-	spin_unlock_irq(&connection->resource->req_lock);
+	discard_my_data = test_bit(CONN_DISCARD_MY_DATA, &connection->flags);
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
-		mutex_unlock(peer_device->device->state_mutex);
+	if (__drbd_send_protocol(connection, P_PROTOCOL) == -EOPNOTSUPP)
+		goto abort;
 
 	rcu_read_lock();
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		kref_get(&device->kref);
-		rcu_read_unlock();
-
-		if (discard_my_data)
-			set_bit(DISCARD_MY_DATA, &device->flags);
-		else
-			clear_bit(DISCARD_MY_DATA, &device->flags);
-
-		drbd_connected(peer_device);
-		kref_put(&device->kref, drbd_destroy_device);
-		rcu_read_lock();
+		set_bit(REPLICATION_NEXT, peer_device->flags);
+		assign_bit(DISCARD_MY_DATA, peer_device->flags,
+			   discard_my_data);
 	}
 	rcu_read_unlock();
+	mutex_unlock(&connection->mutex[DATA_STREAM]);
+	have_mutex = false;
 
-	rv = conn_request_state(connection, NS(conn, C_WF_REPORT_PARAMS), CS_VERBOSE);
-	if (rv < SS_SUCCESS || connection->cstate != C_WF_REPORT_PARAMS) {
-		clear_bit(STATE_SENT, &connection->flags);
-		return 0;
-	}
-
-	drbd_thread_start(&connection->ack_receiver);
-	/* opencoded create_singlethread_workqueue(),
-	 * to be able to use format string arguments */
 	connection->ack_sender =
-		alloc_ordered_workqueue("drbd_as_%s", WQ_MEM_RECLAIM, connection->resource->name);
+		alloc_ordered_workqueue("drbd_as_%s", WQ_MEM_RECLAIM, resource->name);
 	if (!connection->ack_sender) {
 		drbd_err(connection, "Failed to create workqueue ack_sender\n");
-		return 0;
+		schedule_timeout_uninterruptible(HZ);
+		goto retry;
 	}
 
-	mutex_lock(&connection->resource->conf_update);
-	/* The discard_my_data flag is a single-shot modifier to the next
-	 * connection attempt, the handshake of which is now well underway.
-	 * No need for rcu style copying of the whole struct
-	 * just to clear a single value. */
-	connection->net_conf->discard_my_data = 0;
-	mutex_unlock(&connection->resource->conf_update);
+	atomic_set(&connection->rs_in_flight, 0);
+	/* A teardown while IO was suspended keeps requests for a resend, and
+	 * their sectors stay counted until the resend sends them again.  With
+	 * no such request left, or with a count below zero, what is left is an
+	 * accounting error from an earlier connection: do not carry it over.
+	 */
+	in_flight = atomic_read(&connection->ap_in_flight);
+	if (in_flight < 0 || (in_flight > 0 && !READ_ONCE(connection->req_not_net_done))) {
+		drbd_warn(connection, "ap_in_flight = %d on connect, expected 0\n", in_flight);
+		atomic_set(&connection->ap_in_flight, 0);
+	}
+	clear_bit(DAGTAG_STREAM_GONE, &connection->flags);
 
-	return h;
+	/* The last point before both the UUID exchange and arm_connect_timer():
+	 * conn_connect2() sends the UUIDs, and on every path but the pre-110 one
+	 * it runs inside the connect two-phase commit's prepare phase.
+	 */
+	conn_mint_before_handshake(connection, ping_timeo * HZ / 10);
+
+	if (connection->agreed_pro_version >= 110) {
+		/* Allow 10 times the ping_timeo for two-phase commits. That is
+		 * 5 seconds by default. The unit of ping_timeo is tenths of a
+		 * second. */
+		transport->class->ops.set_rcvtimeo(transport, DATA_STREAM, ping_timeo * HZ);
+
+		if (connection->agreed_pro_version == 117)
+			conn_connect2(connection);
+
+		if (resource->res_opts.node_id < connection->peer_node_id) {
+			kref_get(&connection->kref);
+			connection->connect_timer_work.cb = connect_work;
+			connection->connect_tries = 0;
+			arm_connect_timer(connection, jiffies);
+		}
+	} else {
+		enum drbd_state_rv rv;
 
-out_release_sockets:
-	if (ad.s_listen)
-		sock_release(ad.s_listen);
-	if (sock.socket)
-		sock_release(sock.socket);
-	if (msock.socket)
-		sock_release(msock.socket);
-	return -1;
+		rv = change_cstate(connection, C_CONNECTED,
+				   CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE | CS_LOCAL_ONLY);
+		if (rv < SS_SUCCESS || connection->cstate[NOW] != C_CONNECTED)
+			goto retry;
+		conn_connect2(connection);
+	}
+
+	clear_bit(PING_TIMEOUT_ACTIVE, &connection->flags);
+	return true;
+
+retry:
+	if (have_mutex)
+		mutex_unlock(&connection->mutex[DATA_STREAM]);
+	conn_disconnect(connection);
+	schedule_timeout_interruptible(HZ);
+	drbd_thread_consume_restart(&connection->receiver);
+	goto start;
+
+abort:
+	if (have_mutex)
+		mutex_unlock(&connection->mutex[DATA_STREAM]);
+	change_cstate(connection, C_DISCONNECTING, CS_HARD);
+	return false;
 }
 
-static int decode_header(struct drbd_connection *connection, void *header, struct packet_info *pi)
+static unsigned int decode_header_size(const void *header)
 {
-	unsigned int header_size = drbd_header_size(connection);
+	const u32 first_dword = *(u32 *)header;
+	const u16 first_word = *(u16 *)header;
 
-	if (header_size == sizeof(struct p_header100) &&
-	    *(__be32 *)header == cpu_to_be32(DRBD_MAGIC_100)) {
-		struct p_header100 *h = header;
-		if (h->pad != 0) {
-			drbd_err(connection, "Header padding is not zero\n");
-			return -EINVAL;
-		}
-		pi->vnr = be16_to_cpu(h->volume);
+	return first_dword == cpu_to_be32(DRBD_MAGIC_100) ? sizeof(struct p_header100) :
+		first_word == cpu_to_be16(DRBD_MAGIC_BIG) ? sizeof(struct p_header95) :
+		sizeof(struct p_header80);
+}
+
+static int __decode_header(const void *header, struct packet_info *pi)
+{
+	const u32 first_dword = *(u32 *)header;
+	const u16 first_word = *(u16 *)header;
+	unsigned int header_size;
+	int header_version;
+
+	if (first_dword == cpu_to_be32(DRBD_MAGIC_100)) {
+		const struct p_header100 *h = header;
+		u16 vnr = be16_to_cpu(h->volume);
+
+		if (h->pad != 0)
+			return -ENOENT;
+
+		pi->vnr = vnr == ((u16) 0xFFFF) ? -1 : vnr;
 		pi->cmd = be16_to_cpu(h->command);
 		pi->size = be32_to_cpu(h->length);
-	} else if (header_size == sizeof(struct p_header95) &&
-		   *(__be16 *)header == cpu_to_be16(DRBD_MAGIC_BIG)) {
-		struct p_header95 *h = header;
+		header_size = sizeof(*h);
+		header_version = 100;
+	} else if (first_word == cpu_to_be16(DRBD_MAGIC_BIG)) {
+		const struct p_header95 *h = header;
+
 		pi->cmd = be16_to_cpu(h->command);
 		pi->size = be32_to_cpu(h->length);
 		pi->vnr = 0;
-	} else if (header_size == sizeof(struct p_header80) &&
-		   *(__be32 *)header == cpu_to_be32(DRBD_MAGIC)) {
-		struct p_header80 *h = header;
+		header_size = sizeof(*h);
+		header_version = 95;
+	} else if (first_dword == cpu_to_be32(DRBD_MAGIC)) {
+		const struct p_header80 *h = header;
+
 		pi->cmd = be16_to_cpu(h->command);
 		pi->size = be16_to_cpu(h->length);
 		pi->vnr = 0;
+		header_size = sizeof(*h);
+		header_version = 80;
 	} else {
-		drbd_err(connection, "Wrong magic value 0x%08x in protocol version %d\n",
-			 be32_to_cpu(*(__be32 *)header),
-			 connection->agreed_pro_version);
 		return -EINVAL;
 	}
-	pi->data = header + header_size;
+
+	pi->data = (void *)(header + header_size); /* casting away 'const'! */
+	return header_version;
+}
+
+static bool header_version_good(int header_version, int protocol_version)
+{
+	switch (header_version) {
+	case 100: return protocol_version >= 100;
+	case 95: return protocol_version < 100;
+	case 80: return protocol_version < 95;
+	default: return false;
+	}
+}
+
+static int decode_header(struct drbd_connection *connection, const void *header,
+			 struct packet_info *pi)
+{
+	const int agreed_pro_version = connection->agreed_pro_version;
+	int header_version = __decode_header(header, pi);
+
+	if (header_version == -ENOENT) {
+		drbd_err(connection, "Header padding is not zero\n");
+		return -EINVAL;
+	} else if (header_version < 0 || !header_version_good(header_version, agreed_pro_version)) {
+		drbd_err(connection, "Wrong magic value 0x%08x in protocol version %d, %d [data]\n",
+			 be32_to_cpu(*(__be32 *)header), agreed_pro_version, header_version);
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1008,49 +1567,58 @@ static void drbd_unplug_all_devices(struct drbd_connection *connection)
 
 static int drbd_recv_header(struct drbd_connection *connection, struct packet_info *pi)
 {
-	void *buffer = connection->data.rbuf;
+	void *buffer;
 	int err;
 
-	err = drbd_recv_all_warn(connection, buffer, drbd_header_size(connection));
+	err = drbd_recv_all_warn(connection, &buffer, drbd_header_size(connection));
 	if (err)
 		return err;
 
 	err = decode_header(connection, buffer, pi);
-	connection->last_received = jiffies;
 
 	return err;
 }
 
 static int drbd_recv_header_maybe_unplug(struct drbd_connection *connection, struct packet_info *pi)
 {
-	void *buffer = connection->data.rbuf;
+	struct drbd_transport_ops *tr_ops = &connection->transport.class->ops;
 	unsigned int size = drbd_header_size(connection);
+	void *buffer;
 	int err;
 
-	err = drbd_recv_short(connection->data.socket, buffer, size, MSG_NOSIGNAL|MSG_DONTWAIT);
+	err = tr_ops->recv(&connection->transport, DATA_STREAM, &buffer,
+			   size, MSG_NOSIGNAL | MSG_DONTWAIT);
 	if (err != size) {
+		int rflags = 0;
+
 		/* If we have nothing in the receive buffer now, to reduce
 		 * application latency, try to drain the backend queues as
 		 * quickly as possible, and let remote TCP know what we have
 		 * received so far. */
 		if (err == -EAGAIN) {
-			tcp_sock_set_quickack(connection->data.socket->sk, 2);
+			tr_ops->hint(&connection->transport, DATA_STREAM, QUICKACK);
 			drbd_unplug_all_devices(connection);
-		}
-		if (err > 0) {
-			buffer += err;
+		} else if (err > 0) {
 			size -= err;
+			rflags |= GROW_BUFFER;
 		}
-		err = drbd_recv_all_warn(connection, buffer, size);
+
+		err = drbd_recv(connection, &buffer, size, rflags);
+		if (err != size) {
+			if (err >= 0)
+				err = -EIO;
+		} else
+			err = 0;
+
 		if (err)
 			return err;
 	}
 
-	err = decode_header(connection, connection->data.rbuf, pi);
-	connection->last_received = jiffies;
+	err = decode_header(connection, buffer, pi);
 
 	return err;
 }
+
 /* This is blkdev_issue_flush, but asynchronous.
  * We want to submit to all component volumes in parallel,
  * then wait for all completions.
@@ -1071,9 +1639,11 @@ static void one_flush_endio(struct bio *bio)
 	struct drbd_device *device = octx->device;
 	struct issue_flush_context *ctx = octx->ctx;
 
-	if (bio->bi_status) {
-		ctx->error = blk_status_to_errno(bio->bi_status);
-		drbd_info(device, "local disk FLUSH FAILED with status %d\n", bio->bi_status);
+	blk_status_t status = bio->bi_status;
+
+	if (status) {
+		ctx->error = blk_status_to_errno(status);
+		drbd_info(device, "local disk FLUSH FAILED with status %d\n", status);
 	}
 	kfree(octx);
 	bio_put(bio);
@@ -1089,7 +1659,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
+			REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc_obj(*octx, GFP_NOIO);
 
 	if (!octx) {
@@ -1116,10 +1686,12 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	submit_bio(bio);
 }
 
-static void drbd_flush(struct drbd_connection *connection)
+static enum finish_epoch drbd_flush_after_epoch(struct drbd_connection *connection, struct drbd_epoch *epoch)
 {
-	if (connection->resource->write_ordering >= WO_BDEV_FLUSH) {
-		struct drbd_peer_device *peer_device;
+	struct drbd_resource *resource = connection->resource;
+
+	if (resource->write_ordering >= WO_BDEV_FLUSH) {
+		struct drbd_device *device;
 		struct issue_flush_context ctx;
 		int vnr;
 
@@ -1128,9 +1700,7 @@ static void drbd_flush(struct drbd_connection *connection)
 		init_completion(&ctx.done);
 
 		rcu_read_lock();
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-			struct drbd_device *device = peer_device->device;
-
+		idr_for_each_entry(&resource->devices, device, vnr) {
 			if (!get_ldev(device))
 				continue;
 			kref_get(&device->kref);
@@ -1155,6 +1725,88 @@ static void drbd_flush(struct drbd_connection *connection)
 			drbd_bump_write_ordering(connection->resource, NULL, WO_DRAIN_IO);
 		}
 	}
+
+	/* If called before sending P_CONFIRM_STABLE, we don't have the epoch
+	 * (and must not finish it yet, anyways) */
+	if (epoch == NULL)
+		return FE_STILL_LIVE;
+	return drbd_may_finish_epoch(connection, epoch, EV_BARRIER_DONE);
+}
+
+static int w_flush(struct drbd_work *w, int cancel)
+{
+	struct flush_work *fw = container_of(w, struct flush_work, w);
+	struct drbd_epoch *epoch = fw->epoch;
+	struct drbd_connection *connection = epoch->connection;
+
+	kfree(fw);
+
+	if (!test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags))
+		drbd_flush_after_epoch(connection, epoch);
+
+	drbd_may_finish_epoch(connection, epoch, EV_PUT |
+			      (connection->cstate[NOW] < C_CONNECTED ? EV_CLEANUP : 0));
+
+	return 0;
+}
+
+static void drbd_send_b_ack(struct drbd_connection *connection, u32 barrier_nr, u32 set_size)
+{
+	struct p_barrier_ack *p;
+
+	if (connection->cstate[NOW] < C_CONNECTED)
+		return;
+
+	p = conn_prepare_command(connection, sizeof(*p), CONTROL_STREAM);
+	if (!p)
+		return;
+	p->barrier = barrier_nr;
+	p->set_size = cpu_to_be32(set_size);
+	send_command(connection, -1, P_BARRIER_ACK, CONTROL_STREAM);
+}
+
+static void drbd_send_confirm_stable(struct drbd_peer_request *peer_req)
+{
+	struct drbd_connection *connection = peer_req->peer_device->connection;
+	struct drbd_epoch *epoch = peer_req->epoch;
+	struct drbd_peer_request *oldest, *youngest;
+	struct p_confirm_stable *p;
+	int count;
+
+	if (connection->cstate[NOW] < C_CONNECTED)
+		return;
+
+	/* peer_req is not on stable storage yet, but the only one in this epoch.
+	 * Nothing to confirm, just wait for the normal barrier_ack and peer_ack
+	 * to do their work. */
+	oldest = epoch->oldest_unconfirmed_peer_req;
+	if (oldest == peer_req)
+		return;
+
+	p = conn_prepare_command(connection, sizeof(*p), CONTROL_STREAM);
+	if (!p)
+		return;
+
+	/* peer_req has not been added to connection->peer_requests yet, so
+	 * connection->peer_requests.prev is the youngest request that should
+	 * now be on stable storage. */
+	spin_lock_irq(&connection->peer_reqs_lock);
+	youngest = list_entry(connection->peer_requests.prev, struct drbd_peer_request, recv_order);
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	count = atomic_read(&epoch->epoch_size) - atomic_read(&epoch->confirmed) - 1;
+	atomic_add(count, &epoch->confirmed);
+	epoch->oldest_unconfirmed_peer_req = peer_req;
+
+	D_ASSERT(connection, oldest->epoch == youngest->epoch);
+	D_ASSERT(connection, count > 0);
+
+	p->oldest_block_id = oldest->block_id;
+	p->youngest_block_id = youngest->block_id;
+	p->set_size = cpu_to_be32(count);
+	p->pad = 0;
+
+	send_command(connection, -1, P_CONFIRM_STABLE, CONTROL_STREAM);
 }
 
 /**
@@ -1167,13 +1819,16 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 					       struct drbd_epoch *epoch,
 					       enum epoch_event ev)
 {
-	int epoch_size;
+	int finish, epoch_size;
 	struct drbd_epoch *next_epoch;
+	int schedule_flush = 0;
 	enum finish_epoch rv = FE_STILL_LIVE;
+	struct drbd_resource *resource = connection->resource;
 
 	spin_lock(&connection->epoch_lock);
 	do {
 		next_epoch = NULL;
+		finish = 0;
 
 		epoch_size = atomic_read(&epoch->epoch_size);
 
@@ -1183,6 +1838,16 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 			break;
 		case EV_GOT_BARRIER_NR:
 			set_bit(DE_HAVE_BARRIER_NUMBER, &epoch->flags);
+
+			/* Special case: If we just switched from WO_BIO_BARRIER to
+			   WO_BDEV_FLUSH we should not finish the current epoch */
+			if (test_bit(DE_CONTAINS_A_BARRIER, &epoch->flags) && epoch_size == 1 &&
+			    resource->write_ordering != WO_BIO_BARRIER &&
+			    epoch == connection->current_epoch)
+				clear_bit(DE_CONTAINS_A_BARRIER, &epoch->flags);
+			break;
+		case EV_BARRIER_DONE:
+			set_bit(DE_BARRIER_IN_NEXT_EPOCH_DONE, &epoch->flags);
 			break;
 		case EV_BECAME_LAST:
 			/* nothing to do*/
@@ -1191,18 +1856,30 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 
 		if (epoch_size != 0 &&
 		    atomic_read(&epoch->active) == 0 &&
-		    (test_bit(DE_HAVE_BARRIER_NUMBER, &epoch->flags) || ev & EV_CLEANUP)) {
+		    (test_bit(DE_HAVE_BARRIER_NUMBER, &epoch->flags) || ev & EV_CLEANUP) &&
+		    epoch->list.prev == &connection->current_epoch->list &&
+		    !test_bit(DE_IS_FINISHING, &epoch->flags)) {
+			/* Nearly all conditions are met to finish that epoch... */
+			if (test_bit(DE_BARRIER_IN_NEXT_EPOCH_DONE, &epoch->flags) ||
+			    resource->write_ordering == WO_NONE ||
+			    (epoch_size == 1 && test_bit(DE_CONTAINS_A_BARRIER, &epoch->flags)) ||
+			    ev & EV_CLEANUP) {
+				finish = 1;
+				set_bit(DE_IS_FINISHING, &epoch->flags);
+			} else if (!test_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags) &&
+				 resource->write_ordering == WO_BIO_BARRIER) {
+				atomic_inc(&epoch->active);
+				schedule_flush = 1;
+			}
+		}
+		if (finish) {
 			if (!(ev & EV_CLEANUP)) {
+				/* adjust for nr requests already confirmed via P_CONFIRM_STABLE, if any. */
+				epoch_size -= atomic_read(&epoch->confirmed);
 				spin_unlock(&connection->epoch_lock);
 				drbd_send_b_ack(epoch->connection, epoch->barrier_nr, epoch_size);
 				spin_lock(&connection->epoch_lock);
 			}
-#if 0
-			/* FIXME: dec unacked on connection, once we have
-			 * something to count pending connection packets in. */
-			if (test_bit(DE_HAVE_BARRIER_NUMBER, &epoch->flags))
-				dec_unacked(epoch->connection);
-#endif
 
 			if (connection->current_epoch != epoch) {
 				next_epoch = list_entry(epoch->list.next, struct drbd_epoch, list);
@@ -1214,9 +1891,11 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 				if (rv == FE_STILL_LIVE)
 					rv = FE_DESTROYED;
 			} else {
+				epoch->oldest_unconfirmed_peer_req = NULL;
 				epoch->flags = 0;
 				atomic_set(&epoch->epoch_size, 0);
-				/* atomic_set(&epoch->active, 0); is already zero */
+				atomic_set(&epoch->confirmed, 0);
+				/* atomic_set(&epoch->active, 0); is alrady zero */
 				if (rv == FE_STILL_LIVE)
 					rv = FE_RECYCLED;
 			}
@@ -1230,16 +1909,35 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 
 	spin_unlock(&connection->epoch_lock);
 
+	if (schedule_flush) {
+		struct flush_work *fw;
+
+		fw = kmalloc_obj(*fw, GFP_ATOMIC);
+		if (fw) {
+			fw->w.cb = w_flush;
+			fw->epoch = epoch;
+			drbd_queue_work(&resource->work, &fw->w);
+		} else {
+			drbd_warn(resource, "Could not kmalloc a flush_work obj\n");
+			set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags);
+			/* That is not a recursion, only one level */
+			drbd_may_finish_epoch(connection, epoch, EV_BARRIER_DONE);
+			drbd_may_finish_epoch(connection, epoch, EV_PUT);
+		}
+	}
+
 	return rv;
 }
 
 static enum write_ordering_e
 max_allowed_wo(struct drbd_backing_dev *bdev, enum write_ordering_e wo)
 {
-	struct disk_conf *dc;
+	struct drbd_disk_conf *dc;
 
 	dc = rcu_dereference(bdev->disk_conf);
 
+	if (wo == WO_BIO_BARRIER && !dc->disk_barrier)
+		wo = WO_BDEV_FLUSH;
 	if (wo == WO_BDEV_FLUSH && !dc->disk_flushes)
 		wo = WO_DRAIN_IO;
 	if (wo == WO_DRAIN_IO && !dc->disk_drain)
@@ -1257,18 +1955,22 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 {
 	struct drbd_device *device;
 	enum write_ordering_e pwo;
-	int vnr;
+	int vnr, i = 0;
 	static char *write_ordering_str[] = {
 		[WO_NONE] = "none",
 		[WO_DRAIN_IO] = "drain",
 		[WO_BDEV_FLUSH] = "flush",
+		[WO_BIO_BARRIER] = "barrier",
 	};
 
 	pwo = resource->write_ordering;
-	if (wo != WO_BDEV_FLUSH)
+	if (wo != WO_BIO_BARRIER)
 		wo = min(pwo, wo);
 	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (i++ == 1 && wo == WO_BIO_BARRIER)
+			wo = WO_BDEV_FLUSH; /* WO = barrier does not handle multiple volumes */
+
 		if (get_ldev(device)) {
 			wo = max_allowed_wo(device->ldev, wo);
 			if (device->ldev == bdev)
@@ -1283,21 +1985,11 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 	rcu_read_unlock();
 
 	resource->write_ordering = wo;
-	if (pwo != resource->write_ordering || wo == WO_BDEV_FLUSH)
+	if (pwo != resource->write_ordering || wo == WO_BIO_BARRIER)
 		drbd_info(resource, "Method to ensure write ordering: %s\n", write_ordering_str[resource->write_ordering]);
 }
 
 /*
- * Mapping "discard" to ZEROOUT with UNMAP does not work for us:
- * Drivers have to "announce" q->limits.max_write_zeroes_sectors, or it
- * will directly go to fallback mode, submitting normal writes, and
- * never even try to UNMAP.
- *
- * And dm-thin does not do this (yet), mostly because in general it has
- * to assume that "skip_block_zeroing" is set.  See also:
- * https://www.mail-archive.com/dm-devel%40redhat.com/msg07965.html
- * https://www.redhat.com/archives/dm-devel/2018-January/msg00271.html
- *
  * We *may* ignore the discard-zeroes-data setting, if so configured.
  *
  * Assumption is that this "discard_zeroes_data=0" is only because the backend
@@ -1320,6 +2012,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, unsigned int nr_sectors, int flags)
 {
 	struct block_device *bdev = device->ldev->backing_bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t tmp, nr;
 	unsigned int max_discard_sectors, granularity;
 	int alignment;
@@ -1329,7 +2022,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 		goto zero_out;
 
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(bdev_discard_granularity(bdev) >> 9, 1U);
+	granularity = max(q->limits.discard_granularity >> 9, 1U);
 	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
 
 	max_discard_sectors = min(bdev_max_discard_sectors(bdev), (1U << 22));
@@ -1356,8 +2049,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 		start = tmp;
 	}
 	while (nr_sectors >= max_discard_sectors) {
-		err |= blkdev_issue_discard(bdev, start, max_discard_sectors,
-					    GFP_NOIO);
+		err |= blkdev_issue_discard(bdev, start, max_discard_sectors, GFP_NOIO);
 		nr_sectors -= max_discard_sectors;
 		start += max_discard_sectors;
 	}
@@ -1384,7 +2076,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 
 static bool can_do_reliable_discards(struct drbd_device *device)
 {
-	struct disk_conf *dc;
+	struct drbd_disk_conf *dc;
 	bool can_do;
 
 	if (!bdev_max_discard_sectors(device->ldev->backing_bdev))
@@ -1414,11 +2106,11 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
 
 static int peer_request_fault_type(struct drbd_peer_request *peer_req)
 {
-	if (peer_req_op(peer_req) == REQ_OP_READ) {
-		return peer_req->flags & EE_APPLICATION ?
+	if (bio_op(peer_req->bios.head) == REQ_OP_READ) {
+		return drbd_interval_is_application(&peer_req->i) ?
 			DRBD_FAULT_DT_RD : DRBD_FAULT_RS_RD;
 	} else {
-		return peer_req->flags & EE_APPLICATION ?
+		return drbd_interval_is_application(&peer_req->i) ?
 			DRBD_FAULT_DT_WR : DRBD_FAULT_RS_WR;
 	}
 }
@@ -1436,18 +2128,28 @@ static int peer_request_fault_type(struct drbd_peer_request *peer_req)
  *  single page to an empty bio (which should never happen and likely indicates
  *  that the lower level IO stack is in some way broken). This has been observed
  *  on certain Xen deployments.
+ *
+ *  When this function returns 0, it "consumes" an ldev reference; the
+ *  reference is released when the request completes.
  */
 /* TODO allocate from our own bio_set. */
 int drbd_submit_peer_request(struct drbd_peer_request *peer_req)
 {
 	struct drbd_device *device = peer_req->peer_device->device;
-	struct bio *bios = NULL;
-	struct bio *bio;
-	struct page *page = peer_req->pages;
+	struct bio *bio, *next_bio;
 	sector_t sector = peer_req->i.sector;
-	unsigned int data_size = peer_req->i.size;
-	unsigned int n_bios = 0;
-	unsigned int nr_pages = PFN_UP(data_size);
+	struct bio_list bios;
+	int fault_type, err, nr_bios = 0;
+
+	if (peer_req->flags & EE_SET_OUT_OF_SYNC)
+		drbd_set_out_of_sync(peer_req->peer_device,
+				sector, peer_req->i.size);
+
+	if (peer_req->flags & (EE_TRIM|EE_ZEROOUT) ||
+	    bio_op(bio_list_peek(&peer_req->bios)) == REQ_OP_WRITE) {
+		/* ldev_safe: the caller passes its ldev reference to this function */
+		drbd_cbt_mark(device, sector, peer_req->i.size >> SECTOR_SHIFT);
+	}
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
@@ -1455,27 +2157,18 @@ int drbd_submit_peer_request(struct drbd_peer_request *peer_req)
 	 * Correctness first, performance later.  Next step is to code an
 	 * asynchronous variant of the same.
 	 */
-	if (peer_req->flags & (EE_TRIM | EE_ZEROOUT)) {
-		/* wait for all pending IO completions, before we start
-		 * zeroing things out. */
-		conn_wait_active_ee_empty(peer_req->peer_device->connection);
-		/* add it to the active list now,
-		 * so we can find it to present it in debugfs */
+	if (peer_req->flags & (EE_TRIM|EE_ZEROOUT)) {
 		peer_req->submit_jif = jiffies;
-		peer_req->flags |= EE_SUBMITTED;
-
-		/* If this was a resync request from receive_rs_deallocated(),
-		 * it is already on the sync_ee list */
-		if (list_empty(&peer_req->w.list)) {
-			spin_lock_irq(&device->resource->req_lock);
-			list_add_tail(&peer_req->w.list, &device->active_ee);
-			spin_unlock_irq(&device->resource->req_lock);
-		}
 
+		/* ldev_safe: a peer_req has a ldev reference */
 		drbd_issue_peer_discard_or_zero_out(device, peer_req);
 		return 0;
 	}
 
+	fault_type = peer_request_fault_type(peer_req);
+	bios = peer_req->bios;
+	bio_list_init(&peer_req->bios);
+
 	/* In most cases, we will only need one bio.  But in case the lower
 	 * level restrictions happen to be different at this offset on this
 	 * side than those of the sending peer, we may need to submit the
@@ -1484,90 +2177,166 @@ int drbd_submit_peer_request(struct drbd_peer_request *peer_req)
 	 * Plain bio_alloc is good enough here, this is no DRBD internally
 	 * generated bio, but a bio allocated on behalf of the peer.
 	 */
-next_bio:
 	/* _DISCARD, _WRITE_ZEROES handled above.
 	 * REQ_OP_FLUSH (empty flush) not expected,
 	 * should have been mapped to a "drbd protocol barrier".
 	 * REQ_OP_SECURE_ERASE: I don't see how we could ever support that.
 	 */
-	if (!(peer_req_op(peer_req) == REQ_OP_WRITE ||
-				peer_req_op(peer_req) == REQ_OP_READ)) {
-		drbd_err(device, "Invalid bio op received: 0x%x\n", peer_req->opf);
-		return -EINVAL;
+	bio = bio_list_peek(&bios);
+	if (!(bio_op(bio) == REQ_OP_WRITE || bio_op(bio) == REQ_OP_READ)) {
+		drbd_err(device, "Invalid bio op received: 0x%x\n", bio->bi_opf);
+		err = -EINVAL;
+		goto fail;
 	}
 
-	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, peer_req->opf, GFP_NOIO);
-	/* > peer_req->i.sector, unless this is the first bio */
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_private = peer_req;
-	bio->bi_end_io = drbd_peer_request_endio;
+	/* we special case some flags in the multi-bio case, see below
+	 * (REQ_PREFLUSH, or BIO_RW_BARRIER in older kernels) */
 
-	bio->bi_next = bios;
-	bios = bio;
-	++n_bios;
+	/* Get reference for the first bio */
+	atomic_inc(&peer_req->pending_bios);
 
-	page_chain_for_each(page) {
-		unsigned len = min_t(unsigned, data_size, PAGE_SIZE);
-		if (!bio_add_page(bio, page, len, 0))
-			goto next_bio;
-		data_size -= len;
-		sector += len >> 9;
-		--nr_pages;
-	}
-	D_ASSERT(device, data_size == 0);
-	D_ASSERT(device, page == NULL);
-
-	atomic_set(&peer_req->pending_bios, n_bios);
 	/* for debugfs: update timestamp, mark as submitted */
 	peer_req->submit_jif = jiffies;
-	peer_req->flags |= EE_SUBMITTED;
-	do {
-		bio = bios;
-		bios = bios->bi_next;
-		bio->bi_next = NULL;
+	while ((bio = bio_list_pop(&bios))) {
+		/* bio_list_pop() clears bio->bi_next; it is a kernel-private
+		 * field used during I/O; used temprorarily by DRBD pre submit
+		 * and post completion
+		 */
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_private = peer_req;
+		bio->bi_end_io = drbd_peer_request_endio;
+
+		/* Save sector offset and size for restoration after I/O. */
+		to_drbd_peer_bio(bio)->sector_offset = sector - peer_req->i.sector;
+		to_drbd_peer_bio(bio)->size = bio->bi_iter.bi_size;
+
+		sector += bio_sectors(bio);
+
+		nr_bios++;
+
+		/* Get reference for the next bio (if any) now to prevent premature completion */
+		next_bio = bio_list_peek(&bios);
+		if (next_bio)
+			atomic_inc(&peer_req->pending_bios);
+		drbd_submit_bio_noacct(device, fault_type, bio);
+
+		/* strip off REQ_PREFLUSH,
+		 * unless it is the first or last bio */
+		if (next_bio && next_bio->bi_next)
+			next_bio->bi_opf &= ~REQ_PREFLUSH;
+	}
+	if (nr_bios > 1)
+		device->multi_bio_cnt++;
 
-		drbd_submit_bio_noacct(device, peer_request_fault_type(peer_req), bio);
-	} while (bios);
 	return 0;
+
+fail:
+	while ((bio = bio_list_pop(&bios)))
+		bio_put(bio);
+	return err;
 }
 
-static void drbd_remove_epoch_entry_interval(struct drbd_device *device,
-					     struct drbd_peer_request *peer_req)
+void drbd_remove_peer_req_interval(struct drbd_peer_request *peer_req)
 {
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
 	struct drbd_interval *i = &peer_req->i;
+	unsigned long flags;
 
-	drbd_remove_interval(&device->write_requests, i);
+	spin_lock_irqsave(&device->interval_lock, flags);
+	D_ASSERT(device, !drbd_interval_empty(i));
+	drbd_remove_interval(&device->requests, i);
 	drbd_clear_interval(i);
-
-	/* Wake up any processes waiting for this peer request to complete.  */
-	if (test_bit(INTERVAL_WAITING, &i->flags))
-		wake_up(&device->misc_wait);
+	if (!drbd_interval_is_verify(&peer_req->i))
+		drbd_release_conflicts(device, i);
+	spin_unlock_irqrestore(&device->interval_lock, flags);
 }
 
-static void conn_wait_active_ee_empty(struct drbd_connection *connection)
+/**
+ * w_e_reissue() - Worker callback; Resubmit a bio
+ * @w:		work object.
+ * @cancel:	The connection will be closed anyways (unused in this callback)
+ */
+int w_e_reissue(struct drbd_work *w, int cancel)
 {
-	struct drbd_peer_device *peer_device;
-	int vnr;
+	struct drbd_peer_request *peer_req =
+		container_of(w, struct drbd_peer_request, w);
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	int err;
+	/* We leave DE_CONTAINS_A_BARRIER and EE_IS_BARRIER in place,
+	   (and DE_BARRIER_IN_NEXT_EPOCH_ISSUED in the previous Epoch)
+	   so that we can finish that epoch in drbd_may_finish_epoch().
+	   That is necessary if we already have a long chain of Epochs, before
+	   we realize that BARRIER is actually not supported */
+
+	/* As long as the -ENOTSUPP on the barrier is reported immediately
+	   that will never trigger. If it is reported late, we will just
+	   print that warning and continue correctly for all future requests
+	   with WO_BDEV_FLUSH */
+	if (previous_epoch(connection, peer_req->epoch))
+		drbd_warn(device, "Write ordering was not enforced (one time event)\n");
+
+	/* we still have a local reference,
+	 * get_ldev was done in receive_Data. */
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
+	peer_req->w.cb = e_end_block;
+	err = drbd_submit_peer_request(peer_req);
+	switch (err) {
+	case -ENOMEM:
+		peer_req->w.cb = w_e_reissue;
+		drbd_queue_work(&connection->sender_work,
+				&peer_req->w);
+		/* retry later */
+		fallthrough;
+	case 0:
+		/* keep worker happy and connection up */
+		return 0;
 
-		kref_get(&device->kref);
-		rcu_read_unlock();
-		drbd_wait_ee_list_empty(device, &device->active_ee);
-		kref_put(&device->kref, drbd_destroy_device);
-		rcu_read_lock();
+	case -ENOSPC:
+		/* no other error expected, but anyways: */
+	default:
+		/* forget the object,
+		 * and cause a "Network failure" */
+		drbd_remove_peer_req_interval(peer_req);
+		drbd_al_complete_io(device, &peer_req->i);
+		drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT | EV_CLEANUP);
+		drbd_free_peer_req(peer_req);
+		drbd_err(device, "submit failed, triggering re-connect\n");
+		return err;
 	}
-	rcu_read_unlock();
+}
+
+static void conn_wait_done_ee_empty_or_disconnect(struct drbd_connection *connection)
+{
+	wait_event(connection->ee_wait,
+		atomic_read(&connection->done_ee_cnt) == 0
+		|| connection->cstate[NOW] < C_CONNECTED);
+}
+
+static void conn_wait_active_ee_empty_or_disconnect(struct drbd_connection *connection)
+{
+	if (atomic_read(&connection->active_ee_cnt) == 0)
+		return;
+
+	drbd_unplug_all_devices(connection);
+
+	wait_event(connection->ee_wait,
+		atomic_read(&connection->active_ee_cnt) == 0
+		|| connection->cstate[NOW] < C_CONNECTED);
 }
 
 static int receive_Barrier(struct drbd_connection *connection, struct packet_info *pi)
 {
-	int rv;
+	struct drbd_transport_ops *tr_ops = &connection->transport.class->ops;
+	int rv, issue_flush;
 	struct p_barrier *p = pi->data;
 	struct drbd_epoch *epoch;
 
+	tr_ops->hint(&connection->transport, DATA_STREAM, QUICKACK);
+	drbd_unplug_all_devices(connection);
+
 	/* FIXME these are unacked on connection,
 	 * not a specific (peer)device.
 	 */
@@ -1581,41 +2350,48 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 	 * Therefore we must send the barrier_ack after the barrier request was
 	 * completed. */
 	switch (connection->resource->write_ordering) {
+	case WO_BIO_BARRIER:
 	case WO_NONE:
 		if (rv == FE_RECYCLED)
 			return 0;
-
-		/* receiver context, in the writeout path of the other node.
-		 * avoid potential distributed deadlock */
-		epoch = kmalloc_obj(struct drbd_epoch, GFP_NOIO);
-		if (epoch)
-			break;
-		else
-			drbd_warn(connection, "Allocation of an epoch failed, slowing down\n");
-		fallthrough;
+		break;
 
 	case WO_BDEV_FLUSH:
 	case WO_DRAIN_IO:
-		conn_wait_active_ee_empty(connection);
-		drbd_flush(connection);
+		if (rv == FE_STILL_LIVE) {
+			set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &connection->current_epoch->flags);
+			conn_wait_active_ee_empty_or_disconnect(connection);
+			rv = drbd_flush_after_epoch(connection, connection->current_epoch);
+		}
+		if (rv == FE_RECYCLED)
+			return 0;
 
-		if (atomic_read(&connection->current_epoch->epoch_size)) {
-			epoch = kmalloc_obj(struct drbd_epoch, GFP_NOIO);
-			if (epoch)
-				break;
+		/*
+		 * The ack_sender will send all the ACKs and barrier ACKs out,
+		 * since all EEs added to done_ee. We need to provide a new
+		 * epoch object for the EEs that come in soon.
+		 */
+		break;
+	}
+
+	/* receiver context, in the writeout path of the other node.
+	 * avoid potential distributed deadlock */
+	epoch = kzalloc_obj(struct drbd_epoch, GFP_NOIO);
+	if (!epoch) {
+		drbd_warn(connection, "Allocation of an epoch failed, slowing down\n");
+		issue_flush = !test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &connection->current_epoch->flags);
+		conn_wait_active_ee_empty_or_disconnect(connection);
+		if (issue_flush) {
+			rv = drbd_flush_after_epoch(connection, connection->current_epoch);
+			if (rv == FE_RECYCLED)
+				return 0;
 		}
 
+		conn_wait_done_ee_empty_or_disconnect(connection);
+
 		return 0;
-	default:
-		drbd_err(connection, "Strangeness in connection->write_ordering %d\n",
-			 connection->resource->write_ordering);
-		return -EIO;
 	}
 
-	epoch->flags = 0;
-	atomic_set(&epoch->epoch_size, 0);
-	atomic_set(&epoch->active, 0);
-
 	spin_lock(&connection->epoch_lock);
 	if (atomic_read(&connection->current_epoch->epoch_size)) {
 		list_add(&epoch->list, &connection->current_epoch->list);
@@ -1630,15 +2406,158 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 	return 0;
 }
 
-/* quick wrapper in case payload size != request_size (write same) */
-static void drbd_csum_ee_size(struct crypto_shash *h,
-			      struct drbd_peer_request *r, void *d,
-			      unsigned int payload_size)
+/* pi->data points into some recv buffer, which may be
+ * re-used/recycled/overwritten by the next receive operation.
+ * (read_in_block via recv_resync_read) */
+static void p_req_detail_from_pi(struct drbd_connection *connection,
+		struct drbd_peer_request_details *d, struct packet_info *pi)
+{
+	struct p_trim *p = pi->data;
+	bool is_trim_or_zeroes = pi->cmd == P_TRIM || pi->cmd == P_ZEROES;
+	unsigned int digest_size =
+		pi->cmd != P_TRIM && connection->peer_integrity_tfm ?
+		crypto_shash_digestsize(connection->peer_integrity_tfm) : 0;
+
+	d->sector = be64_to_cpu(p->p_data.sector);
+	d->block_id = p->p_data.block_id;
+	d->peer_seq = be32_to_cpu(p->p_data.seq_num);
+	d->dp_flags = be32_to_cpu(p->p_data.dp_flags);
+	d->length = pi->size;
+	d->bi_size = is_trim_or_zeroes ? be32_to_cpu(p->size) : pi->size - digest_size;
+	d->digest_size = digest_size;
+}
+
+/* A cluster-wide size change is agreed by a two-phase commit and then applied
+ * node by node, and applying it takes a different amount of time everywhere: a
+ * diskless node only sets the new capacity, a diskful one first grows its resync
+ * bitmap. So a peer that is further along legitimately sends us requests for the
+ * newly added tail of the device while we still consider that tail out of range.
+ * Wait for our own half of the size change and look again, instead of failing the
+ * request: an error return from a packet handler destroys the connection.
+ *
+ * remote_state_change plus TWOPC_RESIZE covers the whole window on every node:
+ * it is set when this node joins the resize two-phase commit and cleared after
+ * drbd_commit_size_change() has applied the new size locally.
+ *
+ * The wait is bounded, and it is skipped while an application read is
+ * outstanding here: a diskful node's size change waits for its application IO to
+ * drain (drbd_suspend_io), and a remote read completes through this very receiver
+ * thread, so waiting for both at once would deadlock. Falling through in either
+ * case leaves the old behaviour, which is what a peer sending a genuinely
+ * out-of-range request deserves.
+ */
+#define DRBD_SIZE_CHANGE_TIMEOUT (HZ)
+
+static bool resize_in_progress(struct drbd_resource *resource)
+{
+	bool rv;
+
+	read_lock_irq(&resource->state_rwlock);
+	rv = resource->remote_state_change && resource->twopc.type == TWOPC_RESIZE;
+	read_unlock_irq(&resource->state_rwlock);
+
+	return rv;
+}
+
+static bool in_range_after_size_change(struct drbd_device *device, sector_t sector,
+				       unsigned int size)
+{
+	struct drbd_resource *resource = device->resource;
+
+	if (atomic_read(&device->ap_bio_cnt[READ]))
+		return false;
+
+	wait_event_timeout(resource->twopc_wait, !resize_in_progress(resource),
+			   DRBD_SIZE_CHANGE_TIMEOUT);
+
+	return sector + (size >> 9) <= get_capacity(device->vdisk);
+}
+
+static void copy_bio_list(struct bio_list *dst, struct bio_list *src)
+{
+	struct bio *sb = src->head, *db = dst->head;
+	struct bvec_iter si = sb->bi_iter, di = db->bi_iter;
+
+	while (sb && db) {
+		struct bio_vec sv = bio_iter_iovec(sb, si);
+		struct bio_vec dv = bio_iter_iovec(db, di);
+		unsigned int len = min(sv.bv_len, dv.bv_len);
+		void *s, *d;
+
+		s = kmap_local_page(sv.bv_page);
+		d = kmap_local_page(dv.bv_page);
+		memcpy(d + dv.bv_offset, s + sv.bv_offset, len);
+		kunmap_local(d);
+		kunmap_local(s);
+
+		bio_advance_iter(sb, &si, len);
+		if (!si.bi_size) {
+			sb = sb->bi_next;
+			if (sb)
+				si = sb->bi_iter;
+		}
+		bio_advance_iter(db, &di, len);
+		if (!di.bi_size) {
+			db = db->bi_next;
+			if (db)
+				di = db->bi_iter;
+		}
+	}
+}
+
+/* The backing device's queue dma_alignment constrains the offset and length of
+ * every bvec submitted to it; a violating bio fails in the block layer. A
+ * transport that lands received payload at sub-page offsets (rdma2) aligns it
+ * to the value the core announces via set_rx_alignment(), but a region
+ * announced before that value changed (a later attach of a device with a
+ * coarser requirement) can still deliver misaligned payload for a while. Copy
+ * such payload into freshly allocated, page-aligned pages.
+ */
+static int peer_req_align_bios(struct drbd_peer_request *peer_req, unsigned int size)
 {
-	unsigned int tmp = r->i.size;
-	r->i.size = payload_size;
-	drbd_csum_ee(h, r, d);
-	r->i.size = tmp;
+	struct drbd_connection *connection = peer_req->peer_device->connection;
+	struct drbd_transport *transport = &connection->transport;
+	struct bio_list received;
+	unsigned int remaining;
+	int err;
+
+	received = peer_req->bios;
+	bio_list_init(&peer_req->bios);
+
+	err = peer_req_alloc_bio(peer_req, size, GFP_NOIO, received.head->bi_opf);
+	if (err)
+		goto out_restore;
+
+	remaining = size;
+	while (remaining) {
+		struct page *page;
+		int len;
+
+		page = drbd_alloc_pages(transport, GFP_NOIO, remaining);
+		if (!page) {
+			err = -ENOMEM;
+			goto out_strip_restore;
+		}
+		len = min_t(unsigned int, PAGE_SIZE << compound_order(page), remaining);
+		len = drbd_bio_add_page(transport, &peer_req->bios, page, len, 0);
+		if (len < 0) {
+			drbd_free_page(transport, page);
+			err = len;
+			goto out_strip_restore;
+		}
+		remaining -= len;
+	}
+
+	copy_bio_list(&peer_req->bios, &received);
+	drbd_strip_bio_list(transport, &received);
+	connection->rx_misaligned_copies++;
+	return 0;
+
+out_strip_restore:
+	drbd_strip_bio_list(transport, &peer_req->bios);
+out_restore:
+	peer_req->bios = received;
+	return err;
 }
 
 /* used from receive_RSDataReply (recv_resync_read)
@@ -1650,140 +2569,130 @@ static void drbd_csum_ee_size(struct crypto_shash *h,
  * both trim and write same have the bi_size ("data len to be affected")
  * as extra argument in the packet header.
  */
-static struct drbd_peer_request *
-read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-	      struct packet_info *pi) __must_hold(local)
+static int
+read_in_block(struct drbd_peer_request *peer_req, struct drbd_peer_request_details *d)
 {
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
 	struct drbd_device *device = peer_device->device;
-	const sector_t capacity = get_capacity(device->vdisk);
-	struct drbd_peer_request *peer_req;
-	struct page *page;
-	int digest_size, err;
-	unsigned int data_size = pi->size, ds;
-	void *dig_in = peer_device->connection->int_dig_in;
-	void *dig_vv = peer_device->connection->int_dig_vv;
-	unsigned long *data;
-	struct p_trim *trim = (pi->cmd == P_TRIM) ? pi->data : NULL;
-	struct p_trim *zeroes = (pi->cmd == P_ZEROES) ? pi->data : NULL;
-
-	digest_size = 0;
-	if (!trim && peer_device->connection->peer_integrity_tfm) {
-		digest_size = crypto_shash_digestsize(peer_device->connection->peer_integrity_tfm);
-		/*
-		 * FIXME: Receive the incoming digest into the receive buffer
-		 *	  here, together with its struct p_data?
-		 */
-		err = drbd_recv_all_warn(peer_device->connection, dig_in, digest_size);
+	struct drbd_connection *connection = peer_device->connection;
+	const uint64_t capacity = get_capacity(device->vdisk);
+	void *dig_in = connection->int_dig_in;
+	void *dig_vv = connection->int_dig_vv;
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_transport_ops *tr_ops = &transport->class->ops;
+	unsigned int misalign_bits;
+	int size, err;
+
+	if (d->digest_size) {
+		err = drbd_recv_into(connection, dig_in, d->digest_size);
 		if (err)
-			return NULL;
-		data_size -= digest_size;
-	}
-
-	/* assume request_size == data_size, but special case trim. */
-	ds = data_size;
-	if (trim) {
-		if (!expect(peer_device, data_size == 0))
-			return NULL;
-		ds = be32_to_cpu(trim->size);
-	} else if (zeroes) {
-		if (!expect(peer_device, data_size == 0))
-			return NULL;
-		ds = be32_to_cpu(zeroes->size);
+			return err;
 	}
 
-	if (!expect(peer_device, IS_ALIGNED(ds, 512)))
-		return NULL;
-	if (trim || zeroes) {
-		if (!expect(peer_device, ds <= (DRBD_MAX_BBIO_SECTORS << 9)))
-			return NULL;
-	} else if (!expect(peer_device, ds <= DRBD_MAX_BIO_SIZE))
-		return NULL;
+	if (!expect(peer_device, IS_ALIGNED(d->bi_size, 512)))
+		return -EINVAL;
+	/* The WSAME mechanism was removed in Linux 5.18,
+	 * and subsequently from drbd.
+	 * In theory, a "modern" drbd will never advertise support for
+	 * WRITE_SAME, so a compliant peer should never send a DP_WSAME
+	 * packet. If we receive one anyway, that's a protocol error.
+	 */
+	if (!expect(peer_device, (d->dp_flags & DP_WSAME) == 0))
+		return -EINVAL;
+	if (d->dp_flags & (DP_DISCARD|DP_ZEROES)) {
+		if (!expect(peer_device, d->bi_size <= (DRBD_MAX_BBIO_SECTORS << 9)))
+			return -EINVAL;
+	} else if (!expect(peer_device, d->bi_size <= DRBD_MAX_BIO_SIZE))
+		return -EINVAL;
 
-	/* even though we trust out peer,
+	/* even though we trust our peer,
 	 * we sometimes have to double check. */
-	if (sector + (ds>>9) > capacity) {
+	if (d->sector + (d->bi_size>>9) > capacity &&
+	    !in_range_after_size_change(device, d->sector, d->bi_size)) {
 		drbd_err(device, "request from peer beyond end of local disk: "
 			"capacity: %llus < sector: %llus + size: %u\n",
-			(unsigned long long)capacity,
-			(unsigned long long)sector, ds);
-		return NULL;
+			capacity, d->sector, d->bi_size);
+		return -EINVAL;
 	}
 
-	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
-	 * "criss-cross" setup, that might cause write-out on some other DRBD,
-	 * which in turn might block on the other node at this very place.  */
-	peer_req = drbd_alloc_peer_req(peer_device, id, sector, ds, data_size, GFP_NOIO);
-	if (!peer_req)
-		return NULL;
+	peer_req->block_id = d->block_id;
 
-	peer_req->flags |= EE_WRITE;
-	if (trim) {
-		peer_req->flags |= EE_TRIM;
-		return peer_req;
+	if (d->length == 0)
+		return 0;
+
+	size = d->length - d->digest_size;
+	if (bio_list_empty(&peer_req->bios)) {
+		/* For a checksum resync, the bio was consumed for reading. */
+		err = peer_req_alloc_bio(peer_req, size, GFP_NOIO, REQ_OP_WRITE);
+		if (err)
+			return err;
 	}
-	if (zeroes) {
-		peer_req->flags |= EE_ZEROOUT;
-		return peer_req;
+
+	err = tr_ops->recv_bio(transport, &peer_req->bios, size, &misalign_bits);
+	if (err < 0) {
+		if (err == -ECONNRESET)
+			drbd_info(connection, "sock was reset by peer while receiving data\n");
+		else if (err != -ERESTARTSYS)
+			drbd_info(connection, "recvmsg returned %d while receiving data\n", err);
+	} else if (err == 0) {
+		drbd_info(connection, "sock was shut down by peer while receiving data\n");
+		err = -EIO;
 	}
 
-	/* receive payload size bytes into page chain */
-	ds = data_size;
-	page = peer_req->pages;
-	page_chain_for_each(page) {
-		unsigned len = min_t(int, ds, PAGE_SIZE);
-		data = kmap_local_page(page);
-		err = drbd_recv_all_warn(peer_device->connection, data, len);
-		if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
-			drbd_err(device, "Fault injection: Corrupting data on receive\n");
-			data[0] = data[0] ^ (unsigned long)-1;
-		}
-		kunmap_local(data);
-		if (err) {
-			drbd_free_peer_req(device, peer_req);
-			return NULL;
-		}
-		ds -= len;
+	if (err != size) {
+		change_cstate(connection, C_BROKEN_PIPE, CS_HARD);
+		return err;
 	}
 
-	if (digest_size) {
-		drbd_csum_ee_size(peer_device->connection->peer_integrity_tfm, peer_req, dig_vv, data_size);
-		if (memcmp(dig_in, dig_vv, digest_size)) {
+	if (misalign_bits & queue_dma_alignment(bdev_get_queue(device->ldev->backing_bdev))) {
+		err = peer_req_align_bios(peer_req, size);
+		if (err)
+			return err;
+	}
+
+	if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
+		struct bio *bio = bio_list_peek(&peer_req->bios);
+		unsigned long *data;
+
+		drbd_err(device, "Fault injection: Corrupting data on receive, sector %llu\n",
+				d->sector);
+
+		data = bvec_virt(&bio->bi_io_vec[0]);
+		data[0] = ~data[0];
+	}
+
+	if (d->digest_size) {
+		drbd_csum_bios(connection->peer_integrity_tfm, &peer_req->bios, dig_vv);
+		if (memcmp(dig_in, dig_vv, d->digest_size)) {
 			drbd_err(device, "Digest integrity check FAILED: %llus +%u\n",
-				(unsigned long long)sector, data_size);
-			drbd_free_peer_req(device, peer_req);
-			return NULL;
+				d->sector, d->bi_size);
+			return -EINVAL;
 		}
 	}
-	device->recv_cnt += data_size >> 9;
-	return peer_req;
+	peer_device->recv_cnt += d->bi_size >> 9;
+	return 0;
 }
 
-/* drbd_drain_block() just takes a data block
- * out of the socket input buffer, and discards it.
- */
-static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
+static int ignore_remaining_packet(struct drbd_connection *connection, int size)
 {
-	struct page *page;
-	int err = 0;
-	void *data;
+	void *data_to_ignore;
 
-	if (!data_size)
-		return 0;
+	if (size < 0) {
+		drbd_err(connection, "Invalid packet size\n");
+		return -EIO;
+	}
 
-	page = drbd_alloc_pages(peer_device, 1, 1);
+	while (size) {
+		int s = min_t(int, size, DRBD_SOCKET_BUFFER_SIZE);
+		int rv = drbd_recv(connection, &data_to_ignore, s, 0);
 
-	data = kmap_local_page(page);
-	while (data_size) {
-		unsigned int len = min_t(int, data_size, PAGE_SIZE);
+		if (rv < 0)
+			return rv;
 
-		err = drbd_recv_all_warn(peer_device->connection, data, len);
-		if (err)
-			break;
-		data_size -= len;
+		size -= rv;
 	}
-	kunmap_local(data);
-	drbd_free_pages(peer_device->device, page);
-	return err;
+
+	return 0;
 }
 
 static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_request *req,
@@ -1799,7 +2708,7 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 	digest_size = 0;
 	if (peer_device->connection->peer_integrity_tfm) {
 		digest_size = crypto_shash_digestsize(peer_device->connection->peer_integrity_tfm);
-		err = drbd_recv_all_warn(peer_device->connection, dig_in, digest_size);
+		err = drbd_recv_into(peer_device->connection, dig_in, digest_size);
 		if (err)
 			return err;
 		data_size -= digest_size;
@@ -1812,15 +2721,16 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 
 	/* optimistically update recv_cnt.  if receiving fails below,
 	 * we disconnect anyways, and counters will be reset. */
-	peer_device->device->recv_cnt += data_size>>9;
+	peer_device->recv_cnt += data_size >> 9;
 
 	bio = req->master_bio;
 	D_ASSERT(peer_device->device, sector == bio->bi_iter.bi_sector);
 
 	bio_for_each_segment(bvec, bio, iter) {
 		void *mapped = bvec_kmap_local(&bvec);
+
 		expect = min_t(int, data_size, bvec.bv_len);
-		err = drbd_recv_all_warn(peer_device->connection, mapped, expect);
+		err = drbd_recv_into(peer_device->connection, mapped, expect);
 		kunmap_local(mapped);
 		if (err)
 			return err;
@@ -1839,3901 +2749,11878 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 	return 0;
 }
 
-/*
- * e_end_resync_block() is called in ack_sender context via
- * drbd_finish_peer_reqs().
- */
-static int e_end_resync_block(struct drbd_work *w, int unused)
+static bool bits_in_sync(struct drbd_peer_device *peer_device, sector_t sector_start, sector_t sector_end)
 {
-	struct drbd_peer_request *peer_req =
-		container_of(w, struct drbd_peer_request, w);
-	struct drbd_peer_device *peer_device = peer_req->peer_device;
 	struct drbd_device *device = peer_device->device;
-	sector_t sector = peer_req->i.sector;
-	int err;
+	struct drbd_bitmap *bm = device->bitmap;
+
+	if (peer_device->repl_state[NOW] == L_ESTABLISHED ||
+			peer_device->repl_state[NOW] == L_SYNC_SOURCE ||
+			peer_device->repl_state[NOW] == L_SYNC_TARGET ||
+			peer_device->repl_state[NOW] == L_PAUSED_SYNC_S ||
+			peer_device->repl_state[NOW] == L_PAUSED_SYNC_T) {
+		/* An Inconsistent peer is receiving a resync. Unless we are the
+		 * source, that data is not ours and our bitmap does not know it.
+		 */
+		if (peer_device->disk_state[NOW] == D_INCONSISTENT &&
+		    peer_device->repl_state[NOW] != L_SYNC_SOURCE)
+			return false;
+		if (drbd_bm_total_weight(peer_device) == 0)
+			return true;
+		if (drbd_bm_count_bits(device, peer_device->bitmap_index,
+					bm_sect_to_bit(bm, sector_start),
+					bm_sect_to_bit(bm, sector_end - 1)) == 0)
+			return true;
+	}
+	return false;
+}
 
-	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
+static void update_peers_for_interval(struct drbd_peer_device *peer_device,
+		struct drbd_interval *interval)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_bitmap *bm = device->bitmap;
+	u64 mask = NODE_MASK(peer_device->node_id), im;
+	struct drbd_peer_device *p;
+	sector_t sector_end = interval->sector + (interval->size >> SECTOR_SHIFT);
+
+	/* Only send P_PEERS_IN_SYNC if we are actually in sync with this peer. */
+	if (drbd_bm_count_bits(device, peer_device->bitmap_index,
+				bm_sect_to_bit(bm, interval->sector),
+				bm_sect_to_bit(bm, sector_end - 1)))
+		return;
 
-	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
-		drbd_set_in_sync(peer_device, sector, peer_req->i.size);
-		err = drbd_send_ack(peer_device, P_RS_WRITE_ACK, peer_req);
-	} else {
-		/* Record failure to sync */
-		drbd_rs_failed_io(peer_device, sector, peer_req->i.size);
+	for_each_peer_device_ref(p, im, device) {
+		if (p == peer_device)
+			continue;
 
-		err  = drbd_send_ack(peer_device, P_NEG_ACK, peer_req);
+		if (bits_in_sync(p, interval->sector, sector_end))
+			mask |= NODE_MASK(p->node_id);
 	}
-	dec_unacked(device);
 
-	return err;
+	for_each_peer_device_ref(p, im, device) {
+		/* Only send to the peer whose bitmap bits have been cleared if
+		 * we are connected to that peer. The bits may have been
+		 * cleared by a P_PEERS_IN_SYNC from another peer while we are
+		 * connecting to this one. We mustn't send P_PEERS_IN_SYNC
+		 * during the initial connection handshake. */
+		if (p == peer_device && p->connection->cstate[NOW] != C_CONNECTED)
+			continue;
+
+		if (mask & NODE_MASK(p->node_id))
+			drbd_send_peers_in_sync(p, mask, interval->sector, interval->size);
+	}
 }
 
-static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t sector,
-			    struct packet_info *pi) __releases(local)
+/* Potentially send P_PEERS_IN_SYNC for a range with size that fits in an int. */
+static void update_peers_for_small_range(struct drbd_peer_device *peer_device,
+		sector_t sector, int size)
 {
 	struct drbd_device *device = peer_device->device;
-	struct drbd_peer_request *peer_req;
+	struct drbd_interval interval;
 
-	peer_req = read_in_block(peer_device, ID_SYNCER, sector, pi);
-	if (!peer_req)
-		goto fail;
+	memset(&interval, 0, sizeof(interval));
+	drbd_clear_interval(&interval);
+	interval.sector = sector;
+	interval.size = size;
+	interval.type = INTERVAL_PEERS_IN_SYNC_LOCK;
 
-	peer_req->i.type = INTERVAL_RESYNC_WRITE;
+	spin_lock_irq(&device->interval_lock);
+	if (drbd_find_conflict(device, &interval, 0)) {
+		spin_unlock_irq(&device->interval_lock);
+		return;
+	}
+	drbd_insert_interval(&device->requests, &interval);
+	/* Interval is not waiting for conflicts to resolve so mark as "submitted". */
+	set_bit(INTERVAL_SUBMITTED, &interval.flags);
+	spin_unlock_irq(&device->interval_lock);
 
-	dec_rs_pending(peer_device);
+	/* Check for activity in the activity log extent _after_ locking the
+	 * interval. Otherwise a write might occur between checking and
+	 * locking. */
+	if (!drbd_al_active(device, sector, size))
+		update_peers_for_interval(peer_device, &interval);
 
-	inc_unacked(device);
-	/* corresponding dec_unacked() in e_end_resync_block()
-	 * respective _drbd_clear_done_ee */
+	spin_lock_irq(&device->interval_lock);
+	drbd_remove_interval(&device->requests, &interval);
+	drbd_release_conflicts(device, &interval);
+	spin_unlock_irq(&device->interval_lock);
+}
 
-	peer_req->w.cb = e_end_resync_block;
-	peer_req->opf = REQ_OP_WRITE;
-	peer_req->submit_jif = jiffies;
+static void update_peers_for_range(struct drbd_peer_device *peer_device,
+		sector_t sector_start, sector_t sector_end)
+{
+	struct drbd_device *device = peer_device->device;
+	unsigned int enr_start = sector_start >> (AL_EXTENT_SHIFT - SECTOR_SHIFT);
+	unsigned int enr_end = ((sector_end - 1) >> (AL_EXTENT_SHIFT - SECTOR_SHIFT)) + 1;
+	unsigned int enr;
 
-	spin_lock_irq(&device->resource->req_lock);
-	list_add_tail(&peer_req->w.list, &device->sync_ee);
-	spin_unlock_irq(&device->resource->req_lock);
+	if (!get_ldev(device))
+		return;
 
-	atomic_add(pi->size >> 9, &device->rs_sect_ev);
-	if (drbd_submit_peer_request(peer_req) == 0)
-		return 0;
+	for (enr = enr_start; enr < enr_end; enr++) {
+		sector_t enr_start_sector = max(sector_start,
+				((sector_t) enr) << (AL_EXTENT_SHIFT - SECTOR_SHIFT));
+		sector_t enr_end_sector = min(sector_end,
+				((sector_t) (enr + 1)) << (AL_EXTENT_SHIFT - SECTOR_SHIFT));
 
-	/* don't care for the reason here */
-	drbd_err(device, "submit failed, triggering re-connect\n");
-	spin_lock_irq(&device->resource->req_lock);
-	list_del(&peer_req->w.list);
-	spin_unlock_irq(&device->resource->req_lock);
+		update_peers_for_small_range(peer_device,
+				enr_start_sector, (enr_end_sector - enr_start_sector) << SECTOR_SHIFT);
+	}
 
-	drbd_free_peer_req(device, peer_req);
-fail:
 	put_ldev(device);
-	return -EIO;
 }
 
-static struct drbd_request *
-find_request(struct drbd_device *device, struct rb_root *root, u64 id,
-	     sector_t sector, bool missing_ok, const char *func)
+static int w_update_peers(struct drbd_work *w, int unused)
 {
-	struct drbd_request *req;
+	struct update_peers_work *upw = container_of(w, struct update_peers_work, w);
+	struct drbd_peer_device *peer_device = upw->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
 
-	/* Request object according to our peer */
-	req = (struct drbd_request *)(unsigned long)id;
-	if (drbd_contains_interval(root, sector, &req->i) && drbd_interval_is_local(&req->i))
-		return req;
-	if (!missing_ok) {
-		drbd_err(device, "%s: failed to find request 0x%lx, sector %llus\n", func,
-			(unsigned long)id, (unsigned long long)sector);
-	}
-	return NULL;
+	if (connection->agreed_pro_version >= 110)
+		update_peers_for_range(peer_device, upw->sector_start, upw->sector_end);
+
+	kfree(upw);
+	kref_put(&device->kref, drbd_destroy_device);
+	kref_put(&connection->kref, drbd_destroy_connection);
+
+	return 0;
 }
 
-static int receive_DataReply(struct drbd_connection *connection, struct packet_info *pi)
+void drbd_queue_update_peers(struct drbd_peer_device *peer_device,
+		sector_t sector_start, sector_t sector_end)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct drbd_request *req;
-	sector_t sector;
-	int err;
-	struct p_data *p = pi->data;
-
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	struct drbd_device *device = peer_device->device;
+	struct update_peers_work *upw;
 
-	sector = be64_to_cpu(p->sector);
+	upw = kmalloc_obj(*upw, GFP_ATOMIC | __GFP_NOWARN);
+	if (upw) {
+		upw->sector_start = sector_start;
+		upw->sector_end = sector_end;
+		upw->w.cb = w_update_peers;
 
-	spin_lock_irq(&device->resource->req_lock);
-	req = find_request(device, &device->read_requests, p->block_id, sector, false, __func__);
-	spin_unlock_irq(&device->resource->req_lock);
-	if (unlikely(!req))
-		return -EIO;
+		kref_get(&peer_device->device->kref);
 
-	err = recv_dless_read(peer_device, req, sector, pi->size);
-	if (!err)
-		req_mod(req, DATA_RECEIVED, peer_device);
-	/* else: nothing. handled from drbd_disconnect...
-	 * I don't think we may complete this just yet
-	 * in case we are "on-disconnect: freeze" */
+		kref_get(&peer_device->connection->kref);
 
-	return err;
+		upw->peer_device = peer_device;
+		drbd_queue_work(&device->resource->work, &upw->w);
+	} else {
+		if (drbd_ratelimit())
+			drbd_warn(peer_device, "kmalloc(upw) failed.\n");
+	}
 }
 
-static int receive_RSDataReply(struct drbd_connection *connection, struct packet_info *pi)
+static void drbd_peers_in_sync_progress(struct drbd_peer_device *peer_device,
+		sector_t sector_start, sector_t sector_end)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	sector_t sector;
-	int err;
-	struct p_data *p = pi->data;
+	/* P_PEERS_IN_SYNC "steps" are represented by their start sector */
+	sector_t step = sector_start & ~PEERS_IN_SYNC_STEP_SECT_MASK;
+	sector_t end_step = sector_end & ~PEERS_IN_SYNC_STEP_SECT_MASK;
+	sector_t last_end = peer_device->last_in_sync_end;
+	sector_t last_step = last_end & ~PEERS_IN_SYNC_STEP_SECT_MASK;
+	sector_t last_step_end = min(get_capacity(peer_device->device->vdisk),
+			last_step + PEERS_IN_SYNC_STEP_SECT);
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	/* Send for last request if it was part way through a different step */
+	if (last_end > last_step && step != last_step)
+		drbd_queue_update_peers(peer_device, last_step, last_step_end);
 
-	sector = be64_to_cpu(p->sector);
-	D_ASSERT(device, p->block_id == ID_SYNCER);
+	/* Send if the request reaches or passes a step boundary */
+	if (end_step != step)
+		drbd_queue_update_peers(peer_device, step, end_step);
 
-	if (get_ldev(device)) {
-		/* data is submitted to disk within recv_resync_read.
-		 * corresponding put_ldev done below on error,
-		 * or in drbd_peer_request_endio. */
-		err = recv_resync_read(peer_device, sector, pi);
-	} else {
-		drbd_err_ratelimit(device, "Can not write resync data to local disk.\n");
+	peer_device->last_in_sync_end = sector_end;
+
+	/*
+	 * Consider scheduling a bitmap update to reduce the size of the next
+	 * resync if this one is disrupted.
+	 */
+	if (drbd_lazy_bitmap_update_due(peer_device))
+		drbd_peer_device_post_work(peer_device, RS_LAZY_BM_WRITE);
+}
 
-		err = drbd_drain_block(peer_device, pi->size);
+static void drbd_check_peers_in_sync_progress(struct drbd_peer_device *peer_device)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	LIST_HEAD(completed);
+	struct drbd_peer_request *peer_req, *tmp;
 
-		drbd_send_ack_dp(peer_device, P_NEG_ACK, p, pi->size);
-	}
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_for_each_entry_safe(peer_req, tmp, &peer_device->resync_requests, recv_order) {
+		if (!test_bit(INTERVAL_COMPLETED, &peer_req->i.flags))
+			break;
 
-	atomic_add(pi->size >> 9, &device->rs_sect_in);
+		drbd_peers_in_sync_progress(peer_device, peer_req->i.sector,
+			peer_req->i.sector + (peer_req->i.size >> SECTOR_SHIFT));
 
-	return err;
+		drbd_list_del_resync_request(peer_req);
+		list_add_tail(&peer_req->recv_order, &completed);
+	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	list_for_each_entry_safe(peer_req, tmp, &completed, recv_order)
+		drbd_free_peer_req(peer_req);
 }
 
-static void restart_conflicting_writes(struct drbd_device *device,
-				       sector_t sector, int size)
+static void drbd_resync_request_complete(struct drbd_peer_request *peer_req)
 {
-	struct drbd_interval *i;
-	struct drbd_request *req;
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
 
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
-		if (!drbd_interval_is_local(i))
-			continue;
-		req = container_of(i, struct drbd_request, i);
-		if (req->rq_state & RQ_LOCAL_PENDING ||
-		    !(req->rq_state & RQ_POSTPONED))
-			continue;
-		/* as it is RQ_POSTPONED, this will cause it to
-		 * be queued on the retry workqueue. */
-		__req_mod(req, CONFLICT_RESOLVED, NULL, NULL);
-	}
+	/*
+	 * Free the pages now but leave the peer request until the
+	 * corresponding peers-in-sync has been scheduled.
+	 */
+	drbd_peer_req_strip_bio(peer_req);
+
+	/*
+	 * The interval is no longer in the tree, but use this flag anyway,
+	 * since it has an appropriate meaning. After setting the flag,
+	 * peer_req may be freed by another thread.
+	 */
+	set_bit(INTERVAL_COMPLETED, &peer_req->i.flags);
+	peer_req = NULL;
+
+	drbd_check_peers_in_sync_progress(peer_device);
 }
 
 /*
- * e_end_block() is called in ack_sender context via drbd_finish_peer_reqs().
+ * e_end_resync_block() is called in ack_sender context via
+ * drbd_finish_peer_reqs().
  */
-static int e_end_block(struct drbd_work *w, int cancel)
+static int e_end_resync_block(struct drbd_work *w, int unused)
 {
 	struct drbd_peer_request *peer_req =
 		container_of(w, struct drbd_peer_request, w);
 	struct drbd_peer_device *peer_device = peer_req->peer_device;
-	struct drbd_device *device = peer_device->device;
 	sector_t sector = peer_req->i.sector;
-	int err = 0, pcmd;
+	unsigned int size = peer_req->requested_size;
+	u64 block_id = peer_req->block_id;
+	int err;
 
-	if (peer_req->flags & EE_SEND_WRITE_ACK) {
-		if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
-			pcmd = (device->state.conn >= C_SYNC_SOURCE &&
-				device->state.conn <= C_PAUSED_SYNC_T &&
-				peer_req->flags & EE_MAY_SET_IN_SYNC) ?
-				P_RS_WRITE_ACK : P_WRITE_ACK;
-			err = drbd_send_ack(peer_device, pcmd, peer_req);
-			if (pcmd == P_RS_WRITE_ACK)
-				drbd_set_in_sync(peer_device, sector, peer_req->i.size);
-		} else {
-			err = drbd_send_ack(peer_device, P_NEG_ACK, peer_req);
-			/* we expect it to be marked out of sync anyways...
-			 * maybe assert this?  */
-		}
-		dec_unacked(device);
+	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
+		drbd_set_in_sync(peer_device, sector, size);
+		err = drbd_send_ack_be(peer_device, P_RS_WRITE_ACK, sector, size, block_id);
+	} else {
+		/* Record failure to sync */
+		drbd_rs_failed_io(peer_device, sector, size);
+
+		err = drbd_send_ack_be(peer_device, P_RS_NEG_ACK, sector, size, block_id);
 	}
 
-	/* we delete from the conflict detection hash _after_ we sent out the
-	 * P_WRITE_ACK / P_NEG_ACK, to get the sequence number right.  */
-	if (peer_req->flags & EE_IN_INTERVAL_TREE) {
-		spin_lock_irq(&device->resource->req_lock);
-		D_ASSERT(device, !drbd_interval_empty(&peer_req->i));
-		drbd_remove_epoch_entry_interval(device, peer_req);
-		if (peer_req->flags & EE_RESTART_REQUESTS)
-			restart_conflicting_writes(device, sector, peer_req->i.size);
-		spin_unlock_irq(&device->resource->req_lock);
-	} else
-		D_ASSERT(device, drbd_interval_empty(&peer_req->i));
+	dec_unacked(peer_device);
 
-	drbd_may_finish_epoch(peer_device->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
+	/*
+	 * If INTERVAL_SUBMITTED is not set, this request was merged into
+	 * another discard. It has already been removed from the interval tree.
+	 */
+	if (test_bit(INTERVAL_SUBMITTED, &peer_req->i.flags))
+		drbd_remove_peer_req_interval(peer_req);
 
+	drbd_resync_request_complete(peer_req);
 	return err;
 }
 
-static int e_send_ack(struct drbd_work *w, enum drbd_packet ack)
+static struct drbd_peer_request *__find_resync_request(struct drbd_peer_device *peer_device,
+		unsigned long type_mask, sector_t sector, unsigned int size, u64 block_id,
+		bool expected)
 {
-	struct drbd_peer_request *peer_req =
-		container_of(w, struct drbd_peer_request, w);
-	struct drbd_peer_device *peer_device = peer_req->peer_device;
-	int err;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_interval *i;
+	struct drbd_peer_request *peer_req = NULL;
 
-	err = drbd_send_ack(peer_device, ack, peer_req);
-	dec_unacked(peer_device->device);
+	spin_lock_irq(&device->interval_lock);
+	drbd_for_each_overlap(i, &device->requests, sector, size) {
+		struct drbd_peer_request *pr;
 
-	return err;
-}
+		if (!test_bit(INTERVAL_READY_TO_SEND, &i->flags))
+			continue;
 
-static int e_send_superseded(struct drbd_work *w, int unused)
-{
-	return e_send_ack(w, P_SUPERSEDED);
-}
+		if (!(INTERVAL_TYPE_MASK(i->type) & type_mask))
+			continue;
 
-static int e_send_retry_write(struct drbd_work *w, int unused)
-{
-	struct drbd_peer_request *peer_req =
-		container_of(w, struct drbd_peer_request, w);
-	struct drbd_connection *connection = peer_req->peer_device->connection;
+		if (i->sector != sector || i->size != size)
+			continue;
 
-	return e_send_ack(w, connection->agreed_pro_version >= 100 ?
-			     P_RETRY_WRITE : P_SUPERSEDED);
-}
+		pr = container_of(i, struct drbd_peer_request, i);
+		/* With agreed_pro_version < 122, block_id is always ID_SYNCER. */
+		if (pr->peer_device == peer_device &&
+				(block_id == ID_SYNCER || pr->block_id == block_id)) {
+			peer_req = pr;
+			break;
+		}
+	}
+	spin_unlock_irq(&device->interval_lock);
 
-static bool seq_greater(u32 a, u32 b)
-{
-	/*
-	 * We assume 32-bit wrap-around here.
-	 * For 24-bit wrap-around, we would have to shift:
-	 *  a <<= 8; b <<= 8;
-	 */
-	return (s32)a - (s32)b > 0;
+	if (peer_req)
+		D_ASSERT(peer_device, peer_req->i.size == size);
+	else if (expected && drbd_ratelimit())
+		drbd_err(peer_device, "Unexpected resync reply at %llus+%u\n",
+				(unsigned long long) sector, size);
+
+	return peer_req;
 }
 
-static u32 seq_max(u32 a, u32 b)
+static struct drbd_peer_request *find_resync_request(struct drbd_peer_device *peer_device,
+		unsigned long type_mask, sector_t sector, unsigned int size, u64 block_id)
 {
-	return seq_greater(a, b) ? a : b;
+	return __find_resync_request(peer_device, type_mask, sector, size, block_id, true);
 }
 
-static void update_peer_seq(struct drbd_peer_device *peer_device, unsigned int peer_seq)
+static void drbd_cleanup_received_resync_write(struct drbd_peer_request *peer_req)
 {
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
 	struct drbd_device *device = peer_device->device;
-	unsigned int newest_peer_seq;
 
-	if (test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags)) {
-		spin_lock(&device->peer_seq_lock);
-		newest_peer_seq = seq_max(device->peer_seq, peer_seq);
-		device->peer_seq = newest_peer_seq;
-		spin_unlock(&device->peer_seq_lock);
-		/* wake up only if we actually changed device->peer_seq */
-		if (peer_seq == newest_peer_seq)
-			wake_up(&device->seq_wait);
-	}
-}
-
-static inline int overlaps(sector_t s1, int l1, sector_t s2, int l2)
-{
-	return !((s1 + (l1>>9) <= s2) || (s1 >= s2 + (l2>>9)));
-}
+	drbd_remove_peer_req_interval(peer_req);
 
-/* maybe change sync_ee into interval trees as well? */
-static bool overlapping_resync_write(struct drbd_device *device, struct drbd_peer_request *peer_req)
-{
-	struct drbd_peer_request *rs_req;
-	bool rv = false;
+	dec_unacked(peer_device);
 
-	spin_lock_irq(&device->resource->req_lock);
-	list_for_each_entry(rs_req, &device->sync_ee, w.list) {
-		if (overlaps(peer_req->i.sector, peer_req->i.size,
-			     rs_req->i.sector, rs_req->i.size)) {
-			rv = true;
-			break;
-		}
-	}
-	spin_unlock_irq(&device->resource->req_lock);
+	drbd_free_peer_req(peer_req);
+	put_ldev(device);
 
-	return rv;
+	if (atomic_dec_and_test(&connection->backing_ee_cnt))
+		wake_up(&connection->ee_wait);
 }
 
-/* Called from receive_Data.
- * Synchronize packets on sock with packets on msock.
+/* How much resync IO may be queued at the backing device at once, in sectors.
  *
- * This is here so even when a P_DATA packet traveling via sock overtook an Ack
- * packet traveling on msock, they are still processed in the order they have
- * been sent.
- *
- * Note: we don't care for Ack packets overtaking P_DATA packets.
+ * We try to keep the queue of "in-flight" resync IO small-ish even
+ * while we do not see application activity so application IO does not
+ * suffer extreme latency tails even after "quiet" periods.
  *
- * In case packet_seq is larger than device->peer_seq number, there are
- * outstanding packets on the msock. We wait for them to arrive.
- * In case we are the logically next packet, we update device->peer_seq
- * ourselves. Correctly handles 32bit wrap around.
+ * drbd_rs_depth_completed() measures how fast resync IO is worked off.
+ * RS_DEPTH_TARGET_MS of that rate is the delay an ongoing resync may add
+ * to one application request.
  *
- * Assume we have a 10 GBit connection, that is about 1<<30 byte per second,
- * about 1<<21 sectors per second. So "worst" case, we have 1<<3 == 8 seconds
- * for the 24bit wrap (historical atomic_t guarantee on some archs), and we have
- * 1<<9 == 512 seconds aka ages for the 32bit wrap around...
+ * The rate is measured rather than taken from c-max-rate because a device that
+ * does not deliver what c-max-rate permits would get a target overstating its
+ * queue by the same factor -- widest on the slow device where an application
+ * request suffers most. A device that needs longer than RS_DEPTH_TARGET_MS for
+ * RS_DEPTH_MIN_SECT ends up at that floor, which is as far as bounding a queue
+ * can go: below it a resync queues no more than the request the device is
+ * working on, and an application request waits for that one in any case.
  *
- * returns 0 if we may process the packet,
- * -ERESTARTSYS if we were interrupted (by disconnect signal). */
-static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, const u32 peer_seq)
+ * On a high latency device (clat > RS_DEPTH_TARGET_MS), that alone
+ * would not keep it busy. Add the device's service time.
+ */
+static unsigned int rs_depth_target_sect(struct drbd_device *device)
 {
-	struct drbd_device *device = peer_device->device;
-	DEFINE_WAIT(wait);
-	long timeout;
-	int ret = 0, tp;
-
-	if (!test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags))
-		return 0;
-
-	spin_lock(&device->peer_seq_lock);
-	for (;;) {
-		if (!seq_greater(peer_seq - 1, device->peer_seq)) {
-			device->peer_seq = seq_max(device->peer_seq, peer_seq);
-			break;
-		}
-
-		if (signal_pending(current)) {
-			ret = -ERESTARTSYS;
-			break;
-		}
-
-		rcu_read_lock();
-		tp = rcu_dereference(peer_device->connection->net_conf)->two_primaries;
-		rcu_read_unlock();
+	u64 ns = (u64)RS_DEPTH_TARGET_MS * NSEC_PER_MSEC + READ_ONCE(device->rs_lat_ns);
+	u64 sect = (u64)READ_ONCE(device->rs_drain_rate) * ns;
 
-		if (!tp)
-			break;
+	sect = div64_u64(sect, NSEC_PER_SEC);
 
-		/* Only need to wait if two_primaries is enabled */
-		prepare_to_wait(&device->seq_wait, &wait, TASK_INTERRUPTIBLE);
-		spin_unlock(&device->peer_seq_lock);
-		rcu_read_lock();
-		timeout = rcu_dereference(peer_device->connection->net_conf)->ping_timeo*HZ/10;
-		rcu_read_unlock();
-		timeout = schedule_timeout(timeout);
-		spin_lock(&device->peer_seq_lock);
-		if (!timeout) {
-			ret = -ETIMEDOUT;
-			drbd_err(device, "Timed out waiting for missing ack packets; disconnecting\n");
-			break;
-		}
-	}
-	spin_unlock(&device->peer_seq_lock);
-	finish_wait(&device->seq_wait, &wait);
-	return ret;
+	return clamp_t(u64, sect, RS_DEPTH_MIN_SECT, INT_MAX);
 }
 
-static enum req_op wire_flags_to_bio_op(u32 dpf)
+/* Busy time the drain rate is measured over: at least one service time,
+ * so that a sample does not end on a burst of completions the device
+ * worked on concurrently.
+ */
+static u64 rs_drain_sample_ns(struct drbd_device *device)
 {
-	if (dpf & DP_ZEROES)
-		return REQ_OP_WRITE_ZEROES;
-	if (dpf & DP_DISCARD)
-		return REQ_OP_DISCARD;
-	else
-		return REQ_OP_WRITE;
+	return max_t(u64, READ_ONCE(device->rs_lat_ns), RS_DRAIN_SAMPLE_NS);
 }
 
-/* see also bio_flags_to_wire() */
-static blk_opf_t wire_flags_to_bio(struct drbd_connection *connection, u32 dpf)
+/* Sectors the backing device delivers in one sample interval at the rate
+ * measured so far, and RS_DEPTH_MIN_SECT until there is a rate.
+ * Computed where the rate or the service time changes, not per IO.
+ */
+static unsigned int rs_drain_sample_sect(struct drbd_device *device)
 {
-	return wire_flags_to_bio_op(dpf) |
-		(dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
-		(dpf & DP_FUA ? REQ_FUA : 0) |
-		(dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
+	u64 sect = (u64)READ_ONCE(device->rs_drain_rate) * rs_drain_sample_ns(device);
+
+	sect = div64_u64(sect, NSEC_PER_SEC);
+
+	return clamp_t(u64, sect, RS_DEPTH_MIN_SECT, UINT_MAX);
 }
 
-static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
-				    unsigned int size)
+/* May more resync IO go to the backing device?
+ * While a probe is due, only into an empty queue.
+ */
+static bool rs_depth_room(struct drbd_device *device)
 {
-	struct drbd_peer_device *peer_device = first_peer_device(device);
-	struct drbd_interval *i;
-
-    repeat:
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
-		struct drbd_request *req;
-		struct bio_and_error m;
+	unsigned int queued = atomic_read(&device->rs_sect_queued);
 
-		if (!drbd_interval_is_local(i))
-			continue;
-		req = container_of(i, struct drbd_request, i);
-		if (!(req->rq_state & RQ_POSTPONED))
-			continue;
-		req->rq_state &= ~RQ_POSTPONED;
-		__req_mod(req, NEG_ACKED, peer_device, &m);
-		spin_unlock_irq(&device->resource->req_lock);
-		if (m.bio)
-			complete_master_bio(device, &m);
-		spin_lock_irq(&device->resource->req_lock);
-		goto repeat;
-	}
+	if (READ_ONCE(device->rs_lat_probe) == RS_LAT_DRAIN)
+		return queued == 0;
+	return queued < rs_depth_target_sect(device);
 }
 
-static int handle_write_conflicts(struct drbd_device *device,
-				  struct drbd_peer_request *peer_req)
+bool drbd_rs_depth_exceeded(struct drbd_peer_device *peer_device)
 {
-	struct drbd_connection *connection = peer_req->peer_device->connection;
-	bool resolve_conflicts = test_bit(RESOLVE_CONFLICTS, &connection->flags);
-	sector_t sector = peer_req->i.sector;
-	const unsigned int size = peer_req->i.size;
+	struct drbd_device *device = peer_device->device;
+	unsigned int c_min_rate;
+
+	rcu_read_lock();
+	c_min_rate = rcu_dereference(peer_device->conf)->c_min_rate;
+	rcu_read_unlock();
+
+	/* the extra throttle is disabled, and with it this bound */
+	if (c_min_rate == 0)
+		return false;
+
+	return !rs_depth_room(device);
+}
+
+static void rs_depth_resume(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+
+	if (!test_and_clear_bit(RS_DEPTH_WAITERS, &device->flags))
+		return;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (test_and_clear_bit(RS_DEPTH_DEFERRED, peer_device->flags))
+			drbd_queue_work_if_unqueued(&peer_device->connection->sender_work,
+						    &peer_device->resync_work);
+	}
+	rcu_read_unlock();
+}
+
+/* A checksum resync round that stopped at the depth bound starts again as soon
+ * as the queue has room, instead of at the next resync timer tick.
+ */
+void drbd_rs_depth_defer(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+
+	set_bit(RS_DEPTH_DEFERRED, peer_device->flags);
+	set_bit(RS_DEPTH_WAITERS, &device->flags);
+
+	/* The completion that makes room may have run since the check. */
+	smp_mb__after_atomic(); /* pairs with drbd_rs_depth_release() */
+	if (!drbd_rs_depth_exceeded(peer_device))
+		rs_depth_resume(device);
+}
+
+/* An application write waits for the resync requests it conflicts with.
+ * Do not let it wait for the depth bound as well: exempt those
+ * requests from the bound, and release the ones already parked there.
+ */
+void drbd_rs_depth_exempt(struct drbd_device *device, struct drbd_interval *interval)
+{
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
 	struct drbd_interval *i;
-	bool equal;
-	int err;
+	bool parked = false;
 
-	/*
-	 * Inserting the peer request into the write_requests tree will prevent
-	 * new conflicting local requests from being added.
-	 */
-	drbd_insert_interval(&device->write_requests, &peer_req->i);
+	lockdep_assert_held(&device->interval_lock);
 
-    repeat:
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
-		if (i == &peer_req->i)
+	drbd_for_each_overlap(i, &device->requests, interval->sector, interval->size) {
+		if (i == interval || test_bit(INTERVAL_SUBMITTED, &i->flags) ||
+		    !drbd_should_defer_to_resync(interval, i))
 			continue;
-		if (test_bit(INTERVAL_COMPLETED, &i->flags))
+		if (test_and_set_bit(INTERVAL_APP_WAITS, &i->flags))
 			continue;
+		if (test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags))
+			parked = true;
+	}
 
-		if (!drbd_interval_is_local(i)) {
-			/*
-			 * Our peer has sent a conflicting remote request; this
-			 * should not happen in a two-node setup.  Wait for the
-			 * earlier peer request to complete.
-			 */
-			err = drbd_wait_misc(device, i);
-			if (err)
-				goto out;
-			goto repeat;
-		}
+	if (parked)
+		queue_work(submit_conflict->wq, &submit_conflict->worker);
+}
 
-		equal = i->sector == sector && i->size == size;
-		if (resolve_conflicts) {
-			/*
-			 * If the peer request is fully contained within the
-			 * overlapping request, it can be considered overwritten
-			 * and thus superseded; otherwise, it will be retried
-			 * once all overlapping requests have completed.
-			 */
-			bool superseded = i->sector <= sector && i->sector +
-				       (i->size >> 9) >= sector + (size >> 9);
-
-			if (!equal)
-				drbd_alert(device, "Concurrent writes detected: "
-					       "local=%llus +%u, remote=%llus +%u, "
-					       "assuming %s came first\n",
-					  (unsigned long long)i->sector, i->size,
-					  (unsigned long long)sector, size,
-					  superseded ? "local" : "remote");
-
-			peer_req->w.cb = superseded ? e_send_superseded :
-						   e_send_retry_write;
-			list_add_tail(&peer_req->w.list, &device->done_ee);
-			/* put is in drbd_send_acks_wf() */
-			kref_get(&device->kref);
-			if (!queue_work(connection->ack_sender,
-					&peer_req->peer_device->send_acks_work))
-				kref_put(&device->kref, drbd_destroy_device);
+/* Resync IO completed at the backing device, so the queue is shorter than it
+ * was. Let the conflict submitter look again at what it is holding.
+ */
+void drbd_rs_depth_release(struct drbd_device *device)
+{
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
 
-			err = -ENOENT;
-			goto out;
-		} else {
-			struct drbd_request *req =
-				container_of(i, struct drbd_request, i);
+	if (!list_empty_careful(&submit_conflict->resync_writes) ||
+	    !list_empty_careful(&submit_conflict->resync_reads))
+		queue_work(submit_conflict->wq, &submit_conflict->worker);
 
-			if (!equal)
-				drbd_alert(device, "Concurrent writes detected: "
-					       "local=%llus +%u, remote=%llus +%u\n",
-					  (unsigned long long)i->sector, i->size,
-					  (unsigned long long)sector, size);
+	if (test_bit(RS_DEPTH_WAITERS, &device->flags) && rs_depth_room(device))
+		rs_depth_resume(device);
+}
 
-			if (req->rq_state & RQ_LOCAL_PENDING ||
-			    !(req->rq_state & RQ_POSTPONED)) {
-				/*
-				 * Wait for the node with the discard flag to
-				 * decide if this request has been superseded
-				 * or needs to be retried.
-				 * Requests that have been superseded will
-				 * disappear from the write_requests tree.
-				 *
-				 * In addition, wait for the conflicting
-				 * request to finish locally before submitting
-				 * the conflicting peer request.
-				 */
-				err = drbd_wait_misc(device, &req->i);
-				if (err) {
-					_conn_request_state(connection, NS(conn, C_TIMEOUT), CS_HARD);
-					fail_postponed_requests(device, sector, size);
-					goto out;
-				}
-				goto repeat;
-			}
-			/*
-			 * Remember to restart the conflicting requests after
-			 * the new peer request has completed.
-			 */
-			peer_req->flags |= EE_RESTART_REQUESTS;
+/* Resync IO submitted to the backing device. */
+void drbd_rs_depth_queued(struct drbd_device *device, unsigned int sect)
+{
+	if (!sect)
+		return;
+
+	/* Time the device from where it becomes busy: how long it was idle
+	 * says nothing about how fast it works resync IO off.
+	 */
+	if (atomic_add_return(sect, &device->rs_sect_queued) == sect) {
+		ktime_t now = ktime_get();
+
+		device->rs_drain_since = now;
+		if (READ_ONCE(device->rs_lat_probe) == RS_LAT_DRAIN) {
+			device->rs_lat_probe_kt = now;
+			WRITE_ONCE(device->rs_lat_probe, RS_LAT_TIMING);
 		}
 	}
-	err = 0;
-
-    out:
-	if (err)
-		drbd_remove_epoch_entry_interval(device, peer_req);
-	return err;
 }
 
-/* mirrored write */
-static int receive_Data(struct drbd_connection *connection, struct packet_info *pi)
+/* Does resync completion latency, read in jiffies, show a service time other
+ * than the one probed? Only one more than a jiffy away in either direction
+ * counts: lat_jif is a difference of two jiffies values.
+ */
+static bool rs_lat_changed(struct drbd_device *device, unsigned long lat_jif)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct net_conf *nc;
-	sector_t sector;
-	struct drbd_peer_request *peer_req;
-	struct p_data *p = pi->data;
-	u32 peer_seq = be32_to_cpu(p->seq_num);
-	u32 dp_flags;
-	int err, tp;
+	u64 lat_ns = READ_ONCE(device->rs_lat_ns);
+	u64 lo = lat_jif ? (u64)jiffies_to_msecs(lat_jif - 1) * NSEC_PER_MSEC : 0;
+	u64 hi = (u64)jiffies_to_msecs(lat_jif + 1) * NSEC_PER_MSEC;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	return lo > lat_ns + (u64)RS_DEPTH_TARGET_MS * NSEC_PER_MSEC || hi < lat_ns;
+}
 
-	if (!get_ldev(device)) {
-		int err2;
+/* Watch resync completion latency in jiffies, which costs no clock read.
+ * Its minimum over a window is the service time plus the queue the
+ * bound allows; probe again when that disagrees with the probed
+ * service time, and every RS_LAT_PROBE_INTV in any case.
+ */
+static void rs_lat_watch(struct drbd_device *device, unsigned long submit_jif)
+{
+	unsigned long now = jiffies, lat = now - submit_jif + 1;
+	unsigned long wmin = device->rs_lat_wmin;
 
-		err = wait_for_and_update_peer_seq(peer_device, peer_seq);
-		drbd_send_ack_dp(peer_device, P_NEG_ACK, p, pi->size);
-		atomic_inc(&connection->current_epoch->epoch_size);
-		err2 = drbd_drain_block(peer_device, pi->size);
-		if (!err)
-			err = err2;
-		return err;
+	if (!wmin || lat < wmin) {
+		wmin = lat;
+		device->rs_lat_wmin = wmin;
 	}
+	if (time_before(now, device->rs_lat_wend))
+		return;
 
-	/*
-	 * Corresponding put_ldev done either below (on various errors), or in
-	 * drbd_peer_request_endio, if we successfully submit the data at the
-	 * end of this function.
+	device->rs_lat_wmin = 0;
+	device->rs_lat_wend = now + RS_LAT_WINDOW;
+	if (rs_lat_changed(device, wmin - 1) ||
+	    time_after_eq(now, device->rs_lat_due))
+		WRITE_ONCE(device->rs_lat_probe, RS_LAT_DRAIN);
+}
+
+/* Resync IO completed at the backing device: the queue is shorter than it was,
+ * and the device just showed how fast it works that queue off. Measure that
+ * over busy time, so the rate is the device's own and not a function of how
+ * much resync work happened to be there -- at the RS_DEPTH_MIN_SECT floor a
+ * completion empties the queue, and that has to measure as well as any depth.
+ *
+ * The service time is timed on a probe: hold resync IO until the queue
+ * is empty, then time the first completion after the next submission.
+ * Every request that can complete first was submitted no earlier than
+ * the probe and completes no later, so that time is the service time
+ * of an idle queue.
+ */
+void drbd_rs_depth_completed(struct drbd_device *device, unsigned int sect,
+			     unsigned long submit_jif)
+{
+	unsigned int drained, sect_since;
+	s64 busy_ns, elapsed_ns;
+	ktime_t now;
+	bool idle;
+	int probe;
+
+	drained = atomic_add_return(sect, &device->rs_drain_sect);
+	idle = atomic_sub_return(sect, &device->rs_sect_queued) == 0;
+	sect_since = drained - device->rs_drain_mark;
+
+	probe = READ_ONCE(device->rs_lat_probe);
+	if (probe == RS_LAT_IDLE)
+		rs_lat_watch(device, submit_jif);
+
+	/* Reading the clock can be costly.
+	 * Read it only where the answer is used: when the queue just ran empty
+	 * and the busy time has to stop there, when this completion carries
+	 * enough sectors to end the sample, or when it ends a probe.
 	 */
+	if (!idle && sect_since < READ_ONCE(device->rs_drain_sample_sect) &&
+	    probe != RS_LAT_TIMING)
+		goto release;
 
-	sector = be64_to_cpu(p->sector);
-	peer_req = read_in_block(peer_device, p->block_id, sector, pi);
-	if (!peer_req) {
-		put_ldev(device);
-		return -EIO;
+	now = ktime_get();
+	if (probe == RS_LAT_TIMING) {
+		WRITE_ONCE(device->rs_lat_ns,
+			   clamp_t(s64, ktime_to_ns(ktime_sub(now, device->rs_lat_probe_kt)),
+				   1, RS_LAT_MAX_NS));
+		device->rs_lat_due = jiffies + RS_LAT_PROBE_INTV;
+		device->rs_lat_wend = jiffies + RS_LAT_WINDOW;
+		device->rs_lat_wmin = 0;
+		WRITE_ONCE(device->rs_lat_probe, RS_LAT_IDLE);
+		WRITE_ONCE(device->rs_drain_sample_sect, rs_drain_sample_sect(device));
 	}
+	elapsed_ns = ktime_to_ns(ktime_sub(now, device->rs_drain_since));
+	busy_ns = device->rs_drain_busy_ns + (elapsed_ns > 0 ? elapsed_ns : 0);
 
-	peer_req->i.type = INTERVAL_PEER_WRITE;
-	peer_req->w.cb = e_end_block;
-	peer_req->submit_jif = jiffies;
-	peer_req->flags |= EE_APPLICATION;
+	if (idle)
+		device->rs_drain_busy_ns = busy_ns;  /* idle from here */
 
-	dp_flags = be32_to_cpu(p->dp_flags);
-	peer_req->opf = wire_flags_to_bio(connection, dp_flags);
-	if (pi->cmd == P_TRIM) {
-		D_ASSERT(peer_device, peer_req->i.size > 0);
-		D_ASSERT(peer_device, peer_req_op(peer_req) == REQ_OP_DISCARD);
-		D_ASSERT(peer_device, peer_req->pages == NULL);
-		/* need to play safe: an older DRBD sender
-		 * may mean zero-out while sending P_TRIM. */
-		if (0 == (connection->agreed_features & DRBD_FF_WZEROES))
-			peer_req->flags |= EE_ZEROOUT;
-	} else if (pi->cmd == P_ZEROES) {
-		D_ASSERT(peer_device, peer_req->i.size > 0);
-		D_ASSERT(peer_device, peer_req_op(peer_req) == REQ_OP_WRITE_ZEROES);
-		D_ASSERT(peer_device, peer_req->pages == NULL);
-		/* Do (not) pass down BLKDEV_ZERO_NOUNMAP? */
-		if (dp_flags & DP_DISCARD)
-			peer_req->flags |= EE_TRIM;
-	} else if (peer_req->pages == NULL) {
-		D_ASSERT(device, peer_req->i.size == 0);
-		D_ASSERT(device, dp_flags & DP_FLUSH);
-	}
+	if (busy_ns >= rs_drain_sample_ns(device)) {
+		u64 rate = (u64)sect_since * NSEC_PER_SEC;
 
-	if (dp_flags & DP_MAY_SET_IN_SYNC)
-		peer_req->flags |= EE_MAY_SET_IN_SYNC;
+		WRITE_ONCE(device->rs_drain_rate,
+			   min_t(u64, div64_u64(rate, busy_ns), RS_DRAIN_RATE_MAX));
+		device->rs_drain_mark = drained;
+		device->rs_drain_busy_ns = 0;
+		device->rs_drain_since = now;
+		WRITE_ONCE(device->rs_drain_sample_sect, rs_drain_sample_sect(device));
+	}
 
-	spin_lock(&connection->epoch_lock);
-	peer_req->epoch = connection->current_epoch;
-	atomic_inc(&peer_req->epoch->epoch_size);
-	atomic_inc(&peer_req->epoch->active);
-	spin_unlock(&connection->epoch_lock);
+release:
+	drbd_rs_depth_release(device);
+}
 
-	rcu_read_lock();
-	nc = rcu_dereference(peer_device->connection->net_conf);
-	tp = nc->two_primaries;
-	if (peer_device->connection->agreed_pro_version < 100) {
-		switch (nc->wire_protocol) {
-		case DRBD_PROT_C:
-			dp_flags |= DP_SEND_WRITE_ACK;
-			break;
-		case DRBD_PROT_B:
-			dp_flags |= DP_SEND_RECEIVE_ACK;
-			break;
-		}
-	}
-	rcu_read_unlock();
+void drbd_conflict_submit_resync_request(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
+	bool conflict;
+	bool canceled;
+	bool too_deep;
+
+	spin_lock_irq(&device->interval_lock);
+	if (peer_req->flags & EE_RS_DEPTH_PARKED) {
+		peer_req->flags &= ~EE_RS_DEPTH_PARKED;
+		atomic_sub(peer_req->i.size >> 9, &peer_device->rs_sect_parked);
+	}
+	clear_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags);
+	canceled = test_bit(INTERVAL_CANCELED, &peer_req->i.flags);
+	set_bit(INTERVAL_RECEIVED, &peer_req->i.flags);
+	conflict = drbd_find_conflict(device, &peer_req->i, 0);
+	/* A discard queues nothing at the device, so holding it back would
+	 * shorten no queue. Its zero-out fallback does, and is not bounded.
+	 */
+	too_deep = !conflict && !canceled && !(peer_req->flags & EE_TRIM) &&
+		!test_bit(INTERVAL_APP_WAITS, &peer_req->i.flags) &&
+		drbd_rs_depth_exceeded(peer_device);
+	if (too_deep)
+		set_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags);
+	else if (!conflict && !canceled)
+		set_bit(INTERVAL_SUBMITTED, &peer_req->i.flags);
+	if (too_deep) {
+		peer_req->flags |= EE_RS_DEPTH_PARKED;
+		atomic_add(peer_req->i.size >> 9, &peer_device->rs_sect_parked);
+	}
+	spin_unlock_irq(&device->interval_lock);
+
+	if (too_deep) {
+		/* Wait for the backing device the same way a conflicting interval
+		 * waits: on the conflict submitter's list, so the receiver goes
+		 * back to the stream. It must -- on a shared data stream the
+		 * application's writes are queued behind this one.
+		 */
+		spin_lock_irq(&submit_conflict->lock);
+		list_add_tail(&peer_req->w.list, &submit_conflict->resync_writes);
+		spin_unlock_irq(&submit_conflict->lock);
 
-	if (dp_flags & DP_SEND_WRITE_ACK) {
-		peer_req->flags |= EE_SEND_WRITE_ACK;
-		inc_unacked(device);
-		/* corresponding dec_unacked() in e_end_block()
-		 * respective _drbd_clear_done_ee */
+		/* The completion that empties the queue may have run since the
+		 * check above, and then it did not see this request.
+		 */
+		smp_mb(); /* list_add vs. re-check; see drbd_rs_depth_completed() */
+		if (!drbd_rs_depth_exceeded(peer_device))
+			queue_work(submit_conflict->wq, &submit_conflict->worker);
+		return;
 	}
 
-	if (dp_flags & DP_SEND_RECEIVE_ACK) {
-		/* I really don't like it that the receiver thread
-		 * sends on the msock, but anyways */
-		drbd_send_ack(peer_device, P_RECV_ACK, peer_req);
-	}
+	if (!conflict && !canceled) {
+		unsigned int size = peer_req->flags & EE_TRIM ? 0 : peer_req->i.size;
+		int err;
 
-	if (tp) {
-		/* two primaries implies protocol C */
-		D_ASSERT(device, dp_flags & DP_SEND_WRITE_ACK);
-		peer_req->flags |= EE_IN_INTERVAL_TREE;
-		err = wait_for_and_update_peer_seq(peer_device, peer_seq);
-		if (err)
-			goto out_interrupted;
-		spin_lock_irq(&device->resource->req_lock);
-		err = handle_write_conflicts(device, peer_req);
+		drbd_rs_depth_queued(device, size >> 9);
+		err = drbd_submit_peer_request(peer_req);
 		if (err) {
-			spin_unlock_irq(&device->resource->req_lock);
-			if (err == -ENOENT) {
-				put_ldev(device);
-				return 0;
-			}
-			goto out_interrupted;
-		}
-	} else {
-		update_peer_seq(peer_device, peer_seq);
-		spin_lock_irq(&device->resource->req_lock);
-	}
-	/* TRIM and is processed synchronously,
-	 * we wait for all pending requests, respectively wait for
-	 * active_ee to become empty in drbd_submit_peer_request();
-	 * better not add ourselves here. */
-	if ((peer_req->flags & (EE_TRIM | EE_ZEROOUT)) == 0)
-		list_add_tail(&peer_req->w.list, &device->active_ee);
-	spin_unlock_irq(&device->resource->req_lock);
-
-	if (device->state.conn == C_SYNC_TARGET)
-		wait_event(device->ee_wait, !overlapping_resync_write(device, peer_req));
-
-	if (device->state.pdsk < D_INCONSISTENT) {
-		/* In case we have the only disk of the cluster, */
-		drbd_set_out_of_sync(peer_device, peer_req->i.sector, peer_req->i.size);
-		peer_req->flags &= ~EE_MAY_SET_IN_SYNC;
-		drbd_al_begin_io(device, &peer_req->i);
-		peer_req->flags |= EE_CALL_AL_COMPLETE_IO;
-	}
-
-	err = drbd_submit_peer_request(peer_req);
-	if (!err)
-		return 0;
+			atomic_sub(size >> 9, &device->rs_sect_queued);
+			if (drbd_ratelimit())
+				drbd_err(device, "submit failed, triggering re-connect\n");
 
-	/* don't care for the reason here */
-	drbd_err(device, "submit failed, triggering re-connect\n");
-	spin_lock_irq(&device->resource->req_lock);
-	list_del(&peer_req->w.list);
-	drbd_remove_epoch_entry_interval(device, peer_req);
-	spin_unlock_irq(&device->resource->req_lock);
-	if (peer_req->flags & EE_CALL_AL_COMPLETE_IO) {
-		peer_req->flags &= ~EE_CALL_AL_COMPLETE_IO;
-		drbd_al_complete_io(device, &peer_req->i);
+			drbd_cleanup_received_resync_write(peer_req);
+			change_cstate(peer_device->connection, C_PROTOCOL_ERROR, CS_HARD);
+		}
+	} else if (canceled) {
+		drbd_cleanup_received_resync_write(peer_req);
 	}
-
-out_interrupted:
-	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT | EV_CLEANUP);
-	put_ldev(device);
-	drbd_free_peer_req(device, peer_req);
-	return err;
 }
 
-/* We may throttle resync, if the lower device seems to be busy,
- * and current sync rate is above c_min_rate.
- *
- * To decide whether or not the lower device is busy, we use a scheme similar
- * to MD RAID is_mddev_idle(): if the partition stats reveal "significant"
- * (more than 64 sectors) of activity we cannot account for with our own resync
- * activity, it obviously is "busy".
- *
- * The current sync rate used here uses only the most recent two step marks,
- * to have a short time average so we can react faster.
- */
-bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
-		bool throttle_if_app_is_waiting)
+static int recv_resync_read(struct drbd_peer_device *peer_device,
+			    struct drbd_peer_request *peer_req,
+			    struct drbd_peer_request_details *d)
 {
+	struct drbd_connection *connection = peer_device->connection;
 	struct drbd_device *device = peer_device->device;
-	struct lc_element *tmp;
-	bool throttle = drbd_rs_c_min_rate_throttle(device);
+	unsigned int size;
+	sector_t sector;
+	int err;
+	u64 im;
 
-	if (!throttle || throttle_if_app_is_waiting)
-		return throttle;
+	err = read_in_block(peer_req, d);
+	if (err)
+		return err;
 
-	spin_lock_irq(&device->al_lock);
-	tmp = lc_find(device->resync, BM_SECT_TO_EXT(sector));
-	if (tmp) {
-		struct bm_extent *bm_ext = lc_entry(tmp, struct bm_extent, lce);
-		if (test_bit(BME_PRIORITY, &bm_ext->flags))
-			throttle = false;
-		/* Do not slow down if app IO is already waiting for this extent,
-		 * and our progress is necessary for application IO to complete. */
-	}
-	spin_unlock_irq(&device->al_lock);
+	if (test_bit(UNSTABLE_RESYNC, peer_device->flags))
+		clear_bit(STABLE_RESYNC, &device->flags);
 
-	return throttle;
-}
+	dec_rs_pending(peer_device);
 
-bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
-{
-	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
-	unsigned long db, dt, dbdt;
-	unsigned int c_min_rate;
-	int curr_events;
+	inc_unacked(peer_device);
+	/* corresponding dec_unacked() in e_end_resync_block()
+	 * respective _drbd_clear_done_ee */
 
-	rcu_read_lock();
-	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
-	rcu_read_unlock();
+	peer_req->w.cb = e_end_resync_block;
+	peer_req->submit_jif = jiffies;
 
-	/* feature disabled? */
-	if (c_min_rate == 0)
-		return false;
+	sector = peer_req->i.sector;
+	size = peer_req->i.size;
 
-	curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			atomic_read(&device->rs_sect_ev);
+	/* Setting all peers out of sync here. The sync source peer will be
+	 * set in sync when the write completes. The sync source will soon
+	 * set other peers in sync with a P_PEERS_IN_SYNC packet.
+	 */
+	drbd_set_all_out_of_sync(device, peer_device->node_id, sector, size);
 
-	if (atomic_read(&device->ap_actlog_cnt)
-	    || curr_events - device->rs_last_events > 64) {
-		unsigned long rs_left;
-		int i;
+	atomic_inc(&connection->backing_ee_cnt);
+	drbd_conflict_submit_resync_request(peer_req);
+	peer_req = NULL; /* since submitted, might be destroyed already */
 
-		device->rs_last_events = curr_events;
+	drbd_process_rs_discards(peer_device, false);
 
-		/* sync speed average over the last 2*DRBD_SYNC_MARK_STEP,
-		 * approx. */
-		i = (device->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
+	for_each_peer_device_ref(peer_device, im, device) {
+		enum drbd_repl_state repl_state = peer_device->repl_state[NOW];
 
-		if (device->state.conn == C_VERIFY_S || device->state.conn == C_VERIFY_T)
-			rs_left = device->ov_left;
-		else
-			rs_left = drbd_bm_total_weight(device) - device->rs_failed;
+		if (repl_is_sync_source(repl_state) || repl_state == L_WF_BITMAP_S)
+			drbd_send_out_of_sync(peer_device, sector, size);
+	}
+	return 0;
+}
 
-		dt = ((long)jiffies - (long)device->rs_mark_time[i]) / HZ;
-		if (!dt)
-			dt++;
-		db = device->rs_mark_left[i] - rs_left;
-		dbdt = Bit2KB(db/dt);
+/* caller must hold interval_lock */
+static struct drbd_request *
+find_request(struct drbd_device *device, enum drbd_interval_type type, u64 id,
+	     sector_t sector, bool missing_ok, const char *func)
+{
+	struct rb_root *root = type == INTERVAL_LOCAL_READ ? &device->read_requests : &device->requests;
+	struct drbd_request *req;
 
-		if (dbdt > c_min_rate)
-			return true;
+	/* Request object according to our peer */
+	req = (struct drbd_request *)(unsigned long)id;
+	if (drbd_contains_interval(root, sector, &req->i) && req->i.type == type)
+		return req;
+	if (!missing_ok) {
+		drbd_err(device, "%s: failed to find request 0x%lx, sector %llus\n", func,
+			(unsigned long)id, (unsigned long long)sector);
 	}
-	return false;
+	return NULL;
 }
 
-static int receive_DataRequest(struct drbd_connection *connection, struct packet_info *pi)
+static int receive_DataReply(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
+	struct drbd_request *req;
 	sector_t sector;
-	sector_t capacity;
-	struct drbd_peer_request *peer_req;
-	struct digest_info *di = NULL;
-	int size, verb;
-	struct p_block_req *p =	pi->data;
+	int err;
+	struct p_data *p = pi->data;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
 	device = peer_device->device;
-	capacity = get_capacity(device->vdisk);
 
 	sector = be64_to_cpu(p->sector);
-	size   = be32_to_cpu(p->blksize);
 
-	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
-		drbd_err(device, "%s:%d: sector: %llus, size: %u\n", __FILE__, __LINE__,
-				(unsigned long long)sector, size);
-		return -EINVAL;
-	}
-	if (sector + (size>>9) > capacity) {
-		drbd_err(device, "%s:%d: sector: %llus, size: %u\n", __FILE__, __LINE__,
-				(unsigned long long)sector, size);
-		return -EINVAL;
-	}
+	spin_lock_irq(&device->interval_lock);
+	req = find_request(device, INTERVAL_LOCAL_READ, p->block_id, sector, false, __func__);
+	spin_unlock_irq(&device->interval_lock);
+	if (unlikely(!req))
+		return -EIO;
 
-	if (!get_ldev_if_state(device, D_UP_TO_DATE)) {
-		verb = 1;
-		switch (pi->cmd) {
-		case P_DATA_REQUEST:
-			drbd_send_ack_rp(peer_device, P_NEG_DREPLY, p);
-			break;
-		case P_RS_THIN_REQ:
-		case P_RS_DATA_REQUEST:
-		case P_CSUM_RS_REQUEST:
-		case P_OV_REQUEST:
-			drbd_send_ack_rp(peer_device, P_NEG_RS_DREPLY , p);
-			break;
-		case P_OV_REPLY:
-			verb = 0;
-			dec_rs_pending(peer_device);
-			drbd_send_ack_ex(peer_device, P_OV_RESULT, sector, size, ID_IN_SYNC);
-			break;
-		default:
-			BUG();
-		}
-		if (verb)
-			drbd_err_ratelimit(device,
-					   "Can not satisfy peer's read request, no local data.\n");
-
-		/* drain possibly payload */
-		return drbd_drain_block(peer_device, pi->size);
-	}
-
-	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
-	 * "criss-cross" setup, that might cause write-out on some other DRBD,
-	 * which in turn might block on the other node at this very place.  */
-	peer_req = drbd_alloc_peer_req(peer_device, p->block_id, sector, size,
-			size, GFP_NOIO);
-	if (!peer_req) {
-		put_ldev(device);
-		return -ENOMEM;
-	}
-	peer_req->opf = REQ_OP_READ;
+	err = recv_dless_read(peer_device, req, sector, pi->size);
+	if (!err)
+		req_mod(req, DATA_RECEIVED, peer_device);
+	/* else: nothing. handled from drbd_disconnect...
+	 * I don't think we may complete this just yet
+	 * in case we are "on-disconnect: freeze" */
 
-	switch (pi->cmd) {
-	case P_DATA_REQUEST:
-		peer_req->i.type = INTERVAL_PEER_READ;
-		peer_req->w.cb = w_e_end_data_req;
-		/* application IO, don't drbd_rs_begin_io */
-		peer_req->flags |= EE_APPLICATION;
-		goto submit;
+	return err;
+}
 
-	case P_RS_THIN_REQ:
-		/* If at some point in the future we have a smart way to
-		   find out if this data block is completely deallocated,
-		   then we would do something smarter here than reading
-		   the block... */
-		peer_req->flags |= EE_RS_THIN_REQ;
-		fallthrough;
-	case P_RS_DATA_REQUEST:
-		peer_req->i.type = INTERVAL_RESYNC_READ;
-		peer_req->w.cb = w_e_end_rsdata_req;
-		/* used in the sector offset progress display */
-		device->bm_resync_fo = BM_SECT_TO_BIT(sector);
-		break;
+/**
+ * _drbd_send_ack() - Sends an ack packet
+ * @peer_device: DRBD peer device.
+ * @cmd:	Packet command code.
+ * @sector:	sector, needs to be in big endian byte order
+ * @blksize:	size in byte, needs to be in big endian byte order
+ * @block_id:	Id, big endian byte order
+ */
+static int _drbd_send_ack(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
+			  u64 sector, u32 blksize, u64 block_id)
+{
+	struct p_block_ack *p;
 
-	case P_OV_REPLY:
-	case P_CSUM_RS_REQUEST:
-		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
-		if (!di)
-			goto out_free_e;
-
-		di->digest_size = pi->size;
-		di->digest = (((char *)di)+sizeof(struct digest_info));
-
-		peer_req->digest = di;
-		peer_req->flags |= EE_HAS_DIGEST;
-
-		if (drbd_recv_all(peer_device->connection, di->digest, pi->size))
-			goto out_free_e;
-
-		if (pi->cmd == P_CSUM_RS_REQUEST) {
-			D_ASSERT(device, peer_device->connection->agreed_pro_version >= 89);
-			peer_req->i.type = INTERVAL_RESYNC_READ;
-			peer_req->w.cb = w_e_end_csum_rs_req;
-			/* used in the sector offset progress display */
-			device->bm_resync_fo = BM_SECT_TO_BIT(sector);
-			/* remember to report stats in drbd_resync_finished */
-			device->use_csums = true;
-		} else if (pi->cmd == P_OV_REPLY) {
-			/* track progress, we may need to throttle */
-			atomic_add(size >> 9, &device->rs_sect_in);
-			peer_req->i.type = INTERVAL_OV_READ_SOURCE;
-			peer_req->w.cb = w_e_end_ov_reply;
-			dec_rs_pending(peer_device);
-			/* drbd_rs_begin_io done when we sent this request,
-			 * but accounting still needs to be done. */
-			goto submit_for_resync;
-		}
-		break;
+	if (peer_device->repl_state[NOW] < L_ESTABLISHED)
+		return -EIO;
 
-	case P_OV_REQUEST:
-		if (device->ov_start_sector == ~(sector_t)0 &&
-		    peer_device->connection->agreed_pro_version >= 90) {
-			unsigned long now = jiffies;
-			int i;
-			device->ov_start_sector = sector;
-			device->ov_position = sector;
-			device->ov_left = drbd_bm_bits(device) - BM_SECT_TO_BIT(sector);
-			device->rs_total = device->ov_left;
-			for (i = 0; i < DRBD_SYNC_MARKS; i++) {
-				device->rs_mark_left[i] = device->ov_left;
-				device->rs_mark_time[i] = now;
-			}
-			drbd_info(device, "Online Verify start sector: %llu\n",
-					(unsigned long long)sector);
+	p = drbd_prepare_command(peer_device, sizeof(*p), CONTROL_STREAM);
+	if (!p)
+		return -EIO;
+	p->sector = sector;
+	p->block_id = block_id;
+	p->blksize = blksize;
+	p->seq_num = cpu_to_be32(atomic_inc_return(&peer_device->packet_seq));
+
+	if (peer_device->connection->agreed_pro_version < 122) {
+		switch (cmd) {
+		case P_RS_NEG_ACK:
+			cmd = P_NEG_ACK;
+			p->block_id = ID_SYNCER;
+			break;
+		case P_WRITE_ACK_IN_SYNC:
+			cmd = P_RS_WRITE_ACK;
+			break;
+		case P_RS_WRITE_ACK:
+			p->block_id = ID_SYNCER;
+			break;
+		default:
+			break;
 		}
-		peer_req->i.type = INTERVAL_OV_READ_TARGET;
-		peer_req->w.cb = w_e_end_ov_req;
-		break;
-
-	default:
-		BUG();
 	}
 
-	/* Throttle, drbd_rs_begin_io and submit should become asynchronous
-	 * wrt the receiver, but it is not as straightforward as it may seem.
-	 * Various places in the resync start and stop logic assume resync
-	 * requests are processed in order, requeuing this on the worker thread
-	 * introduces a bunch of new code for synchronization between threads.
-	 *
-	 * Unlimited throttling before drbd_rs_begin_io may stall the resync
-	 * "forever", throttling after drbd_rs_begin_io will lock that extent
-	 * for application writes for the same time.  For now, just throttle
-	 * here, where the rest of the code expects the receiver to sleep for
-	 * a while, anyways.
-	 */
+	return drbd_send_command(peer_device, cmd, CONTROL_STREAM);
+}
 
-	/* Throttle before drbd_rs_begin_io, as that locks out application IO;
-	 * this defers syncer requests for some time, before letting at least
-	 * on request through.  The resync controller on the receiving side
-	 * will adapt to the incoming rate accordingly.
-	 *
-	 * We cannot throttle here if remote is Primary/SyncTarget:
-	 * we would also throttle its application reads.
-	 * In that case, throttling is done on the SyncTarget only.
-	 */
+static int drbd_send_ack_dp(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
+		  struct drbd_peer_request_details *d)
+{
+	return _drbd_send_ack(peer_device, cmd,
+			      cpu_to_be64(d->sector),
+			      cpu_to_be32(d->bi_size),
+			      d->block_id);
+}
 
-	/* Even though this may be a resync request, we do add to "read_ee";
-	 * "sync_ee" is only used for resync WRITEs.
-	 * Add to list early, so debugfs can find this request
-	 * even if we have to sleep below. */
-	spin_lock_irq(&device->resource->req_lock);
-	list_add_tail(&peer_req->w.list, &device->read_ee);
-	spin_unlock_irq(&device->resource->req_lock);
-
-	update_receiver_timing_details(connection, drbd_rs_should_slow_down);
-	if (device->state.peer != R_PRIMARY
-	&& drbd_rs_should_slow_down(peer_device, sector, false))
-		schedule_timeout_uninterruptible(HZ/10);
-	update_receiver_timing_details(connection, drbd_rs_begin_io);
-	if (drbd_rs_begin_io(device, sector))
-		goto out_free_e;
+/* Send an ack packet wih a block ID that is already in big endian byte order. */
+int drbd_send_ack_be(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
+		      sector_t sector, int size, u64 block_id)
+{
+	return _drbd_send_ack(peer_device, cmd, cpu_to_be64(sector), cpu_to_be32(size), block_id);
+}
 
-submit_for_resync:
-	atomic_add(size >> 9, &device->rs_sect_ev);
+/**
+ * drbd_send_ack() - Sends an ack packet
+ * @peer_device: DRBD peer device
+ * @cmd:	packet command code
+ * @peer_req:	peer request
+ */
+int drbd_send_ack(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
+		  struct drbd_peer_request *peer_req)
+{
+	return _drbd_send_ack(peer_device, cmd,
+			      cpu_to_be64(peer_req->i.sector),
+			      cpu_to_be32(peer_req->i.size),
+			      peer_req->block_id);
+}
 
-submit:
-	update_receiver_timing_details(connection, drbd_submit_peer_request);
-	inc_unacked(device);
-	if (drbd_submit_peer_request(peer_req) == 0)
-		return 0;
+int drbd_send_ov_result(struct drbd_peer_device *peer_device, sector_t sector, int blksize,
+		u64 block_id, enum ov_result result)
+{
+	struct p_ov_result *p;
 
-	/* don't care for the reason here */
-	drbd_err(device, "submit failed, triggering re-connect\n");
+	if (peer_device->connection->agreed_pro_version < 122)
+		/* Misuse the block_id field to signal if the blocks are is sync or not. */
+		return _drbd_send_ack(peer_device, P_OV_RESULT,
+				cpu_to_be64(sector),
+				cpu_to_be32(blksize),
+				cpu_to_be64(drbd_ov_result_to_block_id(result)));
 
-out_free_e:
-	spin_lock_irq(&device->resource->req_lock);
-	list_del(&peer_req->w.list);
-	spin_unlock_irq(&device->resource->req_lock);
-	/* no drbd_rs_complete_io(), we are dropping the connection anyways */
+	if (peer_device->repl_state[NOW] < L_ESTABLISHED)
+		return -EIO;
 
-	put_ldev(device);
-	drbd_free_peer_req(device, peer_req);
-	return -EIO;
+	p = drbd_prepare_command(peer_device, sizeof(*p), CONTROL_STREAM);
+	if (!p)
+		return -EIO;
+	p->sector = cpu_to_be64(sector);
+	p->block_id = block_id;
+	p->blksize = cpu_to_be32(blksize);
+	p->seq_num = cpu_to_be32(atomic_inc_return(&peer_device->packet_seq));
+	p->result = cpu_to_be32(result);
+	p->pad = 0;
+
+	return drbd_send_command(peer_device, P_OV_RESULT_ID, CONTROL_STREAM);
 }
 
-/*
- * drbd_asb_recover_0p  -  Recover after split-brain with no remaining primaries
- */
-static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold(local)
+static int receive_RSDataReply(struct drbd_connection *connection, struct packet_info *pi)
 {
-	struct drbd_device *device = peer_device->device;
-	int self, peer, rv = -100;
-	unsigned long ch_self, ch_peer;
-	enum drbd_after_sb_p after_sb_0p;
+	struct drbd_peer_request_details d;
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct drbd_peer_request *peer_req;
+	int err;
 
-	self = device->ldev->md.uuid[UI_BITMAP] & 1;
-	peer = device->p_uuid[UI_BITMAP] & 1;
+	p_req_detail_from_pi(connection, &d, pi);
+	pi->data = NULL;
 
-	ch_peer = device->p_uuid[UI_SIZE];
-	ch_self = device->comm_bm_set;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
 
-	rcu_read_lock();
-	after_sb_0p = rcu_dereference(peer_device->connection->net_conf)->after_sb_0p;
-	rcu_read_unlock();
-	switch (after_sb_0p) {
-	case ASB_CONSENSUS:
-	case ASB_DISCARD_SECONDARY:
-	case ASB_CALL_HELPER:
-	case ASB_VIOLENTLY:
-		drbd_err(device, "Configuration error.\n");
-		break;
-	case ASB_DISCONNECT:
-		break;
-	case ASB_DISCARD_YOUNGER_PRI:
-		if (self == 0 && peer == 1) {
-			rv = -1;
-			break;
-		}
-		if (self == 1 && peer == 0) {
-			rv =  1;
-			break;
-		}
-		fallthrough;	/* to one of the other strategies */
-	case ASB_DISCARD_OLDER_PRI:
-		if (self == 0 && peer == 1) {
-			rv = 1;
-			break;
-		}
-		if (self == 1 && peer == 0) {
-			rv = -1;
-			break;
-		}
-		/* Else fall through to one of the other strategies... */
-		drbd_warn(device, "Discard younger/older primary did not find a decision\n"
-		     "Using discard-least-changes instead\n");
-		fallthrough;
-	case ASB_DISCARD_ZERO_CHG:
-		if (ch_peer == 0 && ch_self == 0) {
-			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags)
-				? -1 : 1;
-			break;
-		} else {
-			if (ch_peer == 0) { rv =  1; break; }
-			if (ch_self == 0) { rv = -1; break; }
-		}
-		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
-			break;
-		fallthrough;
-	case ASB_DISCARD_LEAST_CHG:
-		if	(ch_self < ch_peer)
-			rv = -1;
-		else if (ch_self > ch_peer)
-			rv =  1;
-		else /* ( ch_self == ch_peer ) */
-		     /* Well, then use something else. */
-			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags)
-				? -1 : 1;
-		break;
-	case ASB_DISCARD_LOCAL:
-		rv = -1;
-		break;
-	case ASB_DISCARD_REMOTE:
-		rv =  1;
-	}
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_WRITE),
+			d.sector, d.bi_size, d.block_id);
+	if (!peer_req)
+		return -EIO;
 
-	return rv;
-}
+	if (get_ldev(device)) {
+		err = recv_resync_read(peer_device, peer_req, &d);
+		if (err)
+			put_ldev(device);
+	} else {
+		drbd_err_ratelimit(device, "Cannot write resync data to local disk.\n");
 
-/*
- * drbd_asb_recover_1p  -  Recover after split-brain with one remaining primary
- */
-static int drbd_asb_recover_1p(struct drbd_peer_device *peer_device) __must_hold(local)
-{
-	struct drbd_device *device = peer_device->device;
-	int hg, rv = -100;
-	enum drbd_after_sb_p after_sb_1p;
+		err = ignore_remaining_packet(connection, pi->size);
 
-	rcu_read_lock();
-	after_sb_1p = rcu_dereference(peer_device->connection->net_conf)->after_sb_1p;
-	rcu_read_unlock();
-	switch (after_sb_1p) {
-	case ASB_DISCARD_YOUNGER_PRI:
-	case ASB_DISCARD_OLDER_PRI:
-	case ASB_DISCARD_LEAST_CHG:
-	case ASB_DISCARD_LOCAL:
-	case ASB_DISCARD_REMOTE:
-	case ASB_DISCARD_ZERO_CHG:
-		drbd_err(device, "Configuration error.\n");
-		break;
-	case ASB_DISCONNECT:
-		break;
-	case ASB_CONSENSUS:
-		hg = drbd_asb_recover_0p(peer_device);
-		if (hg == -1 && device->state.role == R_SECONDARY)
-			rv = hg;
-		if (hg == 1  && device->state.role == R_PRIMARY)
-			rv = hg;
-		break;
-	case ASB_VIOLENTLY:
-		rv = drbd_asb_recover_0p(peer_device);
-		break;
-	case ASB_DISCARD_SECONDARY:
-		return device->state.role == R_PRIMARY ? 1 : -1;
-	case ASB_CALL_HELPER:
-		hg = drbd_asb_recover_0p(peer_device);
-		if (hg == -1 && device->state.role == R_PRIMARY) {
-			enum drbd_state_rv rv2;
-
-			 /* drbd_change_state() does not sleep while in SS_IN_TRANSIENT_STATE,
-			  * we might be here in C_WF_REPORT_PARAMS which is transient.
-			  * we do not need to wait for the after state change work either. */
-			rv2 = drbd_change_state(device, CS_VERBOSE, NS(role, R_SECONDARY));
-			if (rv2 != SS_SUCCESS) {
-				drbd_khelper(device, "pri-lost-after-sb");
-			} else {
-				drbd_warn(device, "Successfully gave up primary role.\n");
-				rv = hg;
-			}
-		} else
-			rv = hg;
+		drbd_send_ack_dp(peer_device, P_RS_NEG_ACK, &d);
+
+		dec_rs_pending(peer_device);
+		drbd_remove_peer_req_interval(peer_req);
+		drbd_free_peer_req(peer_req);
 	}
 
-	return rv;
+	rs_sectors_came_in(peer_device, d.bi_size);
+
+	return err;
 }
 
-/*
- * drbd_asb_recover_2p  -  Recover after split-brain with two remaining primaries
+/* The tail of e_end_block(): send the answer this write earned, then release
+ * the peer request. Also reached from teardown, where no answer goes out.
  */
-static int drbd_asb_recover_2p(struct drbd_peer_device *peer_device) __must_hold(local)
+static int e_end_block_tail(struct drbd_peer_request *peer_req, int cancel)
 {
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
 	struct drbd_device *device = peer_device->device;
-	int hg, rv = -100;
-	enum drbd_after_sb_p after_sb_2p;
+	struct drbd_connection *connection = peer_device->connection;
+	sector_t sector = peer_req->i.sector;
+	int err = 0, pcmd;
 
-	rcu_read_lock();
-	after_sb_2p = rcu_dereference(peer_device->connection->net_conf)->after_sb_2p;
-	rcu_read_unlock();
-	switch (after_sb_2p) {
-	case ASB_DISCARD_YOUNGER_PRI:
-	case ASB_DISCARD_OLDER_PRI:
-	case ASB_DISCARD_LEAST_CHG:
-	case ASB_DISCARD_LOCAL:
-	case ASB_DISCARD_REMOTE:
-	case ASB_CONSENSUS:
-	case ASB_DISCARD_SECONDARY:
-	case ASB_DISCARD_ZERO_CHG:
-		drbd_err(device, "Configuration error.\n");
-		break;
-	case ASB_VIOLENTLY:
-		rv = drbd_asb_recover_0p(peer_device);
-		break;
-	case ASB_DISCONNECT:
-		break;
-	case ASB_CALL_HELPER:
-		hg = drbd_asb_recover_0p(peer_device);
-		if (hg == -1) {
-			enum drbd_state_rv rv2;
-
-			 /* drbd_change_state() does not sleep while in SS_IN_TRANSIENT_STATE,
-			  * we might be here in C_WF_REPORT_PARAMS which is transient.
-			  * we do not need to wait for the after state change work either. */
-			rv2 = drbd_change_state(device, CS_VERBOSE, NS(role, R_SECONDARY));
-			if (rv2 != SS_SUCCESS) {
-				drbd_khelper(device, "pri-lost-after-sb");
-			} else {
-				drbd_warn(device, "Successfully gave up primary role.\n");
-				rv = hg;
-			}
+	if (peer_req->flags & EE_SEND_WRITE_ACK) {
+		if (unlikely(peer_req->flags & EE_WAS_ERROR)) {
+			pcmd = P_NEG_ACK;
+			/* we expect it to be marked out of sync anyways...
+			 * maybe assert this?  */
+		} else if (peer_req->flags & EE_POSTPONE) {
+			/* The sync source can not get this write; the writer
+			 * counts it as not processed and retries it.
+			 */
+			pcmd = P_RETRY_WRITE;
+		} else if (peer_device->repl_state[NOW] >= L_SYNC_SOURCE &&
+			   peer_device->repl_state[NOW] <= L_PAUSED_SYNC_T &&
+			   peer_req->flags & EE_MAY_SET_IN_SYNC) {
+			pcmd = P_WRITE_ACK_IN_SYNC;
+			drbd_set_in_sync(peer_device, sector, peer_req->i.size);
 		} else
-			rv = hg;
+			pcmd = P_WRITE_ACK;
+		err = drbd_send_ack(peer_device, pcmd, peer_req);
+		dec_unacked(peer_device);
 	}
 
-	return rv;
-}
+	drbd_remove_peer_req_interval(peer_req);
 
-static void drbd_uuid_dump(struct drbd_device *device, char *text, u64 *uuid,
-			   u64 bits, u64 flags)
-{
-	if (!uuid) {
-		drbd_info(device, "%s uuid info vanished while I was looking!\n", text);
-		return;
+	if (connection->agreed_pro_version < 110) {
+		drbd_al_complete_io(device, &peer_req->i);
+		drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
+		drbd_free_peer_req(peer_req);
+	} else {
+		drbd_peer_req_strip_bio(peer_req);
+		/* The write stays on peer_requests until the peer ack. The
+		 * interval is no longer in the tree; the flag only tells
+		 * debugfs that this write is done here.
+		 */
+		set_bit(INTERVAL_COMPLETED, &peer_req->i.flags);
+		drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
+		/* Do not use peer_req after this point. We may have sent the
+		 * corresponding barrier and received the corresponding peer ack. As a
+		 * result, peer_req may have been freed. */
 	}
-	drbd_info(device, "%s %016llX:%016llX:%016llX:%016llX bits:%llu flags:%llX\n",
-	     text,
-	     (unsigned long long)uuid[UI_CURRENT],
-	     (unsigned long long)uuid[UI_BITMAP],
-	     (unsigned long long)uuid[UI_HISTORY_START],
-	     (unsigned long long)uuid[UI_HISTORY_END],
-	     (unsigned long long)bits,
-	     (unsigned long long)flags);
+
+	return err;
 }
 
-/*
-  100	after split brain try auto recover
-    2	C_SYNC_SOURCE set BitMap
-    1	C_SYNC_SOURCE use BitMap
-    0	no Sync
-   -1	C_SYNC_TARGET use BitMap
-   -2	C_SYNC_TARGET set BitMap
- -100	after split brain, disconnect
--1000	unrelated data
--1091   requires proto 91
--1096   requires proto 96
+/* Resumed on the sender once the exchange with the sync source is decided.
+ * The epoch arm of e_end_block() already ran before this write was parked.
  */
-
-static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
-		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+static int e_end_block_resume(struct drbd_work *w, int cancel)
 {
-	struct drbd_connection *const connection = peer_device->connection;
-	struct drbd_device *device = peer_device->device;
-	u64 self, peer;
-	int i, j;
-
-	self = device->ldev->md.uuid[UI_CURRENT] & ~((u64)1);
-	peer = device->p_uuid[UI_CURRENT] & ~((u64)1);
+	struct drbd_peer_request *peer_req =
+		container_of(w, struct drbd_peer_request, w);
 
-	*rule_nr = 10;
-	if (self == UUID_JUST_CREATED && peer == UUID_JUST_CREATED)
-		return 0;
+	return e_end_block_tail(peer_req, cancel);
+}
 
-	*rule_nr = 20;
-	if ((self == UUID_JUST_CREATED || self == (u64)0) &&
-	     peer != UUID_JUST_CREATED)
-		return -2;
+/* The write's full bitmap-granularity range. The resync replies in this unit,
+ * so this is the unit that can roll the write back, and the unit that must
+ * follow the source's content once the write is refused.
+ */
+static void unsecured_write_range(struct drbd_peer_request *peer_req,
+				  sector_t *sector, unsigned int *size)
+{
+	struct drbd_bitmap *bm = peer_req->peer_device->device->bitmap;
+	unsigned int sectors = peer_req->i.size >> SECTOR_SHIFT;
+	unsigned long first_bit = bm_sect_to_bit(bm, peer_req->i.sector);
+	unsigned long last_bit = bm_sect_to_bit(bm, peer_req->i.sector + sectors - 1);
 
-	*rule_nr = 30;
-	if (self != UUID_JUST_CREATED &&
-	    (peer == UUID_JUST_CREATED || peer == (u64)0))
-		return 2;
+	*sector = bm_bit_to_sect(bm, first_bit);
+	*size = (last_bit - first_bit + 1) * bm_block_size(bm);
+}
 
-	if (self == peer) {
-		int rct, dc; /* roles at crash time */
+static void drbd_mark_unsecured_write_out_of_sync(struct drbd_peer_request *peer_req)
+{
+	struct drbd_device *device = peer_req->peer_device->device;
+	struct drbd_peer_device *source;
+	struct drbd_connection *pinned = NULL;
 
-		if (device->p_uuid[UI_BITMAP] == (u64)0 && device->ldev->md.uuid[UI_BITMAP] != (u64)0) {
+	rcu_read_lock();
+	source = peer_device_by_node_id(device, peer_req->wait_source_node_id);
+	if (source) {
+		pinned = source->connection;
+		kref_get(&pinned->kref);
+	}
+	rcu_read_unlock();
 
-			if (connection->agreed_pro_version < 91)
-				return -1091;
+	if (!source)
+		return;
 
-			if ((device->ldev->md.uuid[UI_BITMAP] & ~((u64)1)) == (device->p_uuid[UI_HISTORY_START] & ~((u64)1)) &&
-			    (device->ldev->md.uuid[UI_HISTORY_START] & ~((u64)1)) == (device->p_uuid[UI_HISTORY_START + 1] & ~((u64)1))) {
-				drbd_info(device, "was SyncSource, missed the resync finished event, corrected myself:\n");
-				drbd_uuid_move_history(device);
-				device->ldev->md.uuid[UI_HISTORY_START] = device->ldev->md.uuid[UI_BITMAP];
-				device->ldev->md.uuid[UI_BITMAP] = 0;
+	if (get_ldev(device)) {
+		sector_t sector;
+		unsigned int size;
 
-				drbd_uuid_dump(device, "self", device->ldev->md.uuid,
-					       device->state.disk >= D_NEGOTIATING ? drbd_bm_total_weight(device) : 0, 0);
-				*rule_nr = 34;
-			} else {
-				drbd_info(device, "was SyncSource (peer failed to write sync_uuid)\n");
-				*rule_nr = 36;
-			}
+		unsecured_write_range(peer_req, &sector, &size);
+		drbd_set_out_of_sync(source, sector, size);
+		put_ldev(device);
+	}
+	kref_put(&pinned->kref, drbd_destroy_connection);
+}
 
-			return 1;
-		}
+/* Whether drbd_refuse_unsecured_write() can take this write back from its
+ * writer: a protocol C write, still unacknowledged. The writer retries it
+ * (DRBD_FF_WRITE_POSTPONE) or holds it pending across a severed connection;
+ * either way the range may be overwritten. A protocol A or B write is
+ * complete for the writer already.
+ */
+static bool unsecured_write_refusable(struct drbd_peer_request *peer_req)
+{
+	return peer_req->flags & EE_SEND_WRITE_ACK;
+}
 
-		if (device->ldev->md.uuid[UI_BITMAP] == (u64)0 && device->p_uuid[UI_BITMAP] != (u64)0) {
+/* A protocol A or B write in a range the sync source can not get: the writer
+ * already completed it and can not take it back, so it can not be refused. The
+ * source's copy would roll it back, so end the resync towards that source
+ * instead, the way check_resync_source() ends one from a weak source; the
+ * write then survives on this node, unacknowledged (protocol A and B send no
+ * write acknowledgment).
+ */
+static void drbd_end_resync_for_unsecured_write(struct drbd_peer_request *peer_req)
+{
+	struct drbd_device *device = peer_req->peer_device->device;
+	struct drbd_peer_device *source;
+	struct drbd_connection *pinned = NULL;
 
-			if (connection->agreed_pro_version < 91)
-				return -1091;
+	rcu_read_lock();
+	source = peer_device_by_node_id(device, peer_req->wait_source_node_id);
+	if (source) {
+		pinned = source->connection;
+		kref_get(&pinned->kref);
+	}
+	rcu_read_unlock();
 
-			if ((device->ldev->md.uuid[UI_HISTORY_START] & ~((u64)1)) == (device->p_uuid[UI_BITMAP] & ~((u64)1)) &&
-			    (device->ldev->md.uuid[UI_HISTORY_START + 1] & ~((u64)1)) == (device->p_uuid[UI_HISTORY_START] & ~((u64)1))) {
-				drbd_info(device, "was SyncTarget, peer missed the resync finished event, corrected peer:\n");
+	if (!source)
+		return;
 
-				device->p_uuid[UI_HISTORY_START + 1] = device->p_uuid[UI_HISTORY_START];
-				device->p_uuid[UI_HISTORY_START] = device->p_uuid[UI_BITMAP];
-				device->p_uuid[UI_BITMAP] = 0UL;
+	if (repl_is_sync_target(source->repl_state[NOW])) {
+		drbd_info(source, "Holding a write the sync source can not get, ending the resync\n");
+		change_repl_state(source, L_ESTABLISHED, CS_VERBOSE, "unsecured-write");
+	}
+	kref_put(&pinned->kref, drbd_destroy_connection);
+}
 
-				drbd_uuid_dump(device, "peer", device->p_uuid, device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
-				*rule_nr = 35;
-			} else {
-				drbd_info(device, "was SyncTarget (failed to write sync_uuid)\n");
-				*rule_nr = 37;
-			}
+/* Outcome "unreachable" for a write withheld from acknowledgment: the sync
+ * source can not get this write any more, so this node must not let it stand
+ * as it is. The write's full range is marked out of sync toward the source, so
+ * the running resync overwrites every part of it with the source's content.
+ *
+ * A protocol C write that agreed DRBD_FF_WRITE_POSTPONE is answered
+ * P_RETRY_WRITE: the writer retries it once the cluster can order it again.
+ *
+ * A protocol C write that did not agree the feature can not be told to retry,
+ * and it can not be answered either way: a positive ack would confirm a write
+ * this node can not keep, and a negative ack tells the writer this node's disk
+ * failed -- it did not -- and makes the writer distrust it and refuse to hand
+ * over the primary role. The writer is instead an older primary that has lost
+ * every up-to-date peer and suspended, so it is only waiting for this leg.
+ * Sever that leg with a stated reason: the writer holds the write pending and
+ * retransmits it once a peer holds the data again, the way it holds any write
+ * across a lost connection -- honest, and not mistaken for a network fault or
+ * a failed disk. Leaving the write unacknowledged would reach the same
+ * connection loss through the writer's request timeout, only later and blamed
+ * on the network.
+ *
+ * A protocol A or B write can not be answered (its writer already completed
+ * it); it ends the resync and survives on this node instead.
+ */
+static void drbd_refuse_unsecured_write(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *writer = peer_req->peer_device;
 
-			return -1;
+	if (peer_req->flags & EE_SEND_WRITE_ACK) {
+		drbd_mark_unsecured_write_out_of_sync(peer_req);
+		if (writer->connection->agreed_features & DRBD_FF_WRITE_POSTPONE) {
+			peer_req->flags |= EE_POSTPONE;
+			drbd_info_ratelimit(writer,
+					    "Sync source can not get this write, postponing it towards the writer\n");
+		} else {
+			drbd_warn(writer,
+				  "Sync source can not get this write and the writer can not retry it; disconnecting so it holds the write pending\n");
+			peer_req->flags &= ~EE_SEND_WRITE_ACK;
+			dec_unacked(writer);
+			change_cstate_tag(writer->connection, C_NETWORK_FAILURE,
+					  CS_HARD, "unsecured-write", NULL);
 		}
+	} else {
+		drbd_end_resync_for_unsecured_write(peer_req);
+	}
+	peer_req->flags &= ~(EE_WAIT_FOR_SOURCE | EE_SOURCE_UNREACHABLE);
+	peer_req->w.cb = e_end_block_resume;
+	drbd_queue_work(&writer->connection->sender_work, &peer_req->w);
+}
 
-		/* Common power [off|failure] */
-		rct = (test_bit(CRASHED_PRIMARY, &device->flags) ? 1 : 0) +
-			(device->p_uuid[UI_FLAGS] & 2);
-		/* lowest bit is set when we were primary,
-		 * next bit (weight 2) is set when peer was primary */
-		*rule_nr = 40;
+/* Whether the resync this write was withheld for still runs. Serializes
+ * against drbd_refuse_unsecured_writes() through peer_reqs_lock: hold
+ * it across this test and the parking.
+ */
+static bool wait_source_still_syncing(struct drbd_peer_request *peer_req)
+{
+	struct drbd_device *device = peer_req->peer_device->device;
+	struct drbd_peer_device *source;
+	bool syncing = false;
 
-		/* Neither has the "crashed primary" flag set,
-		 * only a replication link hickup. */
-		if (rct == 0)
-			return 0;
+	rcu_read_lock();
+	source = peer_device_by_node_id(device, peer_req->wait_source_node_id);
+	if (source)
+		syncing = repl_is_sync_target(source->repl_state[NOW]);
+	rcu_read_unlock();
 
-		/* Current UUID equal and no bitmap uuid; does not necessarily
-		 * mean this was a "simultaneous hard crash", maybe IO was
-		 * frozen, so no UUID-bump happened.
-		 * This is a protocol change, overload DRBD_FF_WSAME as flag
-		 * for "new-enough" peer DRBD version. */
-		if (device->state.role == R_PRIMARY || peer_role == R_PRIMARY) {
-			*rule_nr = 41;
-			if (!(connection->agreed_features & DRBD_FF_WSAME)) {
-				drbd_warn(peer_device, "Equivalent unrotated UUIDs, but current primary present.\n");
-				return -(0x10000 | PRO_VERSION_MAX | (DRBD_FF_WSAME << 8));
-			}
-			if (device->state.role == R_PRIMARY && peer_role == R_PRIMARY) {
-				/* At least one has the "crashed primary" bit set,
-				 * both are primary now, but neither has rotated its UUIDs?
-				 * "Can not happen." */
-				drbd_err(peer_device, "Equivalent unrotated UUIDs, but both are primary. Can not resolve this.\n");
-				return -100;
+	return syncing;
+}
+
+/*
+ * e_end_block() is called in ack_sender context via drbd_finish_peer_reqs().
+ */
+static int e_end_block(struct drbd_work *w, int cancel)
+{
+	struct drbd_peer_request *peer_req =
+		container_of(w, struct drbd_peer_request, w);
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_epoch *epoch;
+
+	if (peer_req->flags & EE_IS_BARRIER) {
+		epoch = previous_epoch(connection, peer_req->epoch);
+		if (epoch)
+			drbd_may_finish_epoch(connection, epoch,
+					      EV_BARRIER_DONE + (cancel ? EV_CLEANUP : 0));
+	}
+
+	if (!cancel) {
+		unsigned long answer = 0;
+		bool parked = false;
+
+		/* The sync source may have answered before this write
+		 * completed locally (the answer is recorded on the request,
+		 * which is findable on peer_requests): act on it now. Only
+		 * park while the answer is still out and the resync this
+		 * write was withheld for still runs; once that resync is
+		 * gone, no answer settles the exchange any more.
+		 *
+		 * A write that is not parked has its answer decided here,
+		 * under the lock drbd_secure_resync_range() takes to arm a
+		 * write it still finds undecided.
+		 */
+		spin_lock_irq(&connection->peer_reqs_lock);
+		if (peer_req->flags & EE_WAIT_FOR_SOURCE) {
+			answer = peer_req->flags &
+				(EE_SOURCE_REACHED | EE_SOURCE_UNREACHABLE);
+			if (!answer && wait_source_still_syncing(peer_req)) {
+				peer_req->w.cb = e_end_block_resume;
+				list_add_tail(&peer_req->w.list, &connection->source_wait_ee);
+				parked = true;
 			}
-			if (device->state.role == R_PRIMARY)
-				return 1;
-			return -1;
 		}
+		if (!parked && !(answer & EE_SOURCE_UNREACHABLE))
+			peer_req->flags |= EE_ACK_DECIDED;
+		spin_unlock_irq(&connection->peer_reqs_lock);
+		if (parked)
+			return 0;
 
-		/* Both are secondary.
-		 * Really looks like recovery from simultaneous hard crash.
-		 * Check which had been primary before, and arbitrate. */
-		switch (rct) {
-		case 0: /* !self_pri && !peer_pri */ return 0; /* already handled */
-		case 1: /*  self_pri && !peer_pri */ return 1;
-		case 2: /* !self_pri &&  peer_pri */ return -1;
-		case 3: /*  self_pri &&  peer_pri */
-			dc = test_bit(RESOLVE_CONFLICTS, &connection->flags);
-			return dc ? -1 : 1;
+		if (peer_req->flags & EE_WAIT_FOR_SOURCE) {
+			if (answer & EE_SOURCE_REACHED) {
+				peer_req->flags &= ~(EE_WAIT_FOR_SOURCE | EE_SOURCE_REACHED);
+			} else {
+				drbd_refuse_unsecured_write(peer_req);
+				return 0;
+			}
 		}
 	}
 
-	*rule_nr = 50;
-	peer = device->p_uuid[UI_BITMAP] & ~((u64)1);
-	if (self == peer)
-		return -1;
-
-	*rule_nr = 51;
-	peer = device->p_uuid[UI_HISTORY_START] & ~((u64)1);
-	if (self == peer) {
-		if (connection->agreed_pro_version < 96 ?
-		    (device->ldev->md.uuid[UI_HISTORY_START] & ~((u64)1)) ==
-		    (device->p_uuid[UI_HISTORY_START + 1] & ~((u64)1)) :
-		    peer + UUID_NEW_BM_OFFSET == (device->p_uuid[UI_BITMAP] & ~((u64)1))) {
-			/* The last P_SYNC_UUID did not get though. Undo the last start of
-			   resync as sync source modifications of the peer's UUIDs. */
+	return e_end_block_tail(peer_req, cancel);
+}
 
-			if (connection->agreed_pro_version < 91)
-				return -1091;
+static bool seq_greater(u32 a, u32 b)
+{
+	/*
+	 * We assume 32-bit wrap-around here.
+	 * For 24-bit wrap-around, we would have to shift:
+	 *  a <<= 8; b <<= 8;
+	 */
+	return (s32)a - (s32)b > 0;
+}
 
-			device->p_uuid[UI_BITMAP] = device->p_uuid[UI_HISTORY_START];
-			device->p_uuid[UI_HISTORY_START] = device->p_uuid[UI_HISTORY_START + 1];
+static u32 seq_max(u32 a, u32 b)
+{
+	return seq_greater(a, b) ? a : b;
+}
 
-			drbd_info(device, "Lost last syncUUID packet, corrected:\n");
-			drbd_uuid_dump(device, "peer", device->p_uuid, device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
+static void update_peer_seq(struct drbd_peer_device *peer_device, unsigned int peer_seq)
+{
+	unsigned int newest_peer_seq;
 
-			return -1;
-		}
+	if (test_bit(RESOLVE_CONFLICTS, &peer_device->connection->transport.flags)) {
+		spin_lock_bh(&peer_device->peer_seq_lock);
+		newest_peer_seq = seq_max(peer_device->peer_seq, peer_seq);
+		peer_device->peer_seq = newest_peer_seq;
+		spin_unlock_bh(&peer_device->peer_seq_lock);
+		/* wake up only if we actually changed peer_device->peer_seq */
+		if (peer_seq == newest_peer_seq)
+			wake_up(&peer_device->device->seq_wait);
 	}
+}
 
-	*rule_nr = 60;
-	self = device->ldev->md.uuid[UI_CURRENT] & ~((u64)1);
-	for (i = UI_HISTORY_START; i <= UI_HISTORY_END; i++) {
-		peer = device->p_uuid[i] & ~((u64)1);
-		if (self == peer)
-			return -2;
-	}
+/* Called from receive_Data.
+ * Synchronize packets on sock with packets on msock.
+ *
+ * This is here so even when a P_DATA packet traveling via sock overtook an Ack
+ * packet traveling on msock, they are still processed in the order they have
+ * been sent.
+ *
+ * Note: we don't care for Ack packets overtaking P_DATA packets.
+ *
+ * In case packet_seq is larger than peer_device->peer_seq number, there are
+ * outstanding packets on the msock. We wait for them to arrive.
+ * In case we are the logically next packet, we update peer_device->peer_seq
+ * ourselves. Correctly handles 32bit wrap around.
+ *
+ * Assume we have a 10 GBit connection, that is about 1<<30 byte per second,
+ * about 1<<21 sectors per second. So "worst" case, we have 1<<3 == 8 seconds
+ * for the 24bit wrap (historical atomic_t guarantee on some archs), and we have
+ * 1<<9 == 512 seconds aka ages for the 32bit wrap around...
+ *
+ * returns 0 if we may process the packet,
+ * -ERESTARTSYS if we were interrupted (by disconnect signal). */
+static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, const u32 peer_seq)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	DEFINE_WAIT(wait);
+	long timeout;
+	int ret = 0, tp;
 
-	*rule_nr = 70;
-	self = device->ldev->md.uuid[UI_BITMAP] & ~((u64)1);
-	peer = device->p_uuid[UI_CURRENT] & ~((u64)1);
-	if (self == peer)
-		return 1;
+	if (!test_bit(RESOLVE_CONFLICTS, &connection->transport.flags))
+		return 0;
 
-	*rule_nr = 71;
-	self = device->ldev->md.uuid[UI_HISTORY_START] & ~((u64)1);
-	if (self == peer) {
-		if (connection->agreed_pro_version < 96 ?
-		    (device->ldev->md.uuid[UI_HISTORY_START + 1] & ~((u64)1)) ==
-		    (device->p_uuid[UI_HISTORY_START] & ~((u64)1)) :
-		    self + UUID_NEW_BM_OFFSET == (device->ldev->md.uuid[UI_BITMAP] & ~((u64)1))) {
-			/* The last P_SYNC_UUID did not get though. Undo the last start of
-			   resync as sync source modifications of our UUIDs. */
+	spin_lock_bh(&peer_device->peer_seq_lock);
+	for (;;) {
+		if (!seq_greater(peer_seq - 1, peer_device->peer_seq)) {
+			peer_device->peer_seq = seq_max(peer_device->peer_seq, peer_seq);
+			break;
+		}
 
-			if (connection->agreed_pro_version < 91)
-				return -1091;
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 
-			__drbd_uuid_set(device, UI_BITMAP, device->ldev->md.uuid[UI_HISTORY_START]);
-			__drbd_uuid_set(device, UI_HISTORY_START, device->ldev->md.uuid[UI_HISTORY_START + 1]);
+		rcu_read_lock();
+		tp = rcu_dereference(connection->transport.net_conf)->two_primaries;
+		rcu_read_unlock();
 
-			drbd_info(device, "Last syncUUID did not get through, corrected:\n");
-			drbd_uuid_dump(device, "self", device->ldev->md.uuid,
-				       device->state.disk >= D_NEGOTIATING ? drbd_bm_total_weight(device) : 0, 0);
+		if (!tp)
+			break;
 
-			return 1;
+		/* Only need to wait if two_primaries is enabled */
+		prepare_to_wait(&peer_device->device->seq_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_bh(&peer_device->peer_seq_lock);
+		rcu_read_lock();
+		timeout = rcu_dereference(connection->transport.net_conf)->ping_timeo*HZ/10;
+		rcu_read_unlock();
+		timeout = schedule_timeout(timeout);
+		spin_lock_bh(&peer_device->peer_seq_lock);
+		if (!timeout) {
+			ret = -ETIMEDOUT;
+			drbd_err(peer_device, "Timed out waiting for missing ack packets; disconnecting\n");
+			break;
 		}
 	}
+	spin_unlock_bh(&peer_device->peer_seq_lock);
+	finish_wait(&peer_device->device->seq_wait, &wait);
+	return ret;
+}
 
+static enum req_op wire_flags_to_bio_op(u32 dpf)
+{
+	if (dpf & DP_ZEROES)
+		return REQ_OP_WRITE_ZEROES;
+	if (dpf & DP_DISCARD)
+		return REQ_OP_DISCARD;
+	return REQ_OP_WRITE;
+}
 
-	*rule_nr = 80;
-	peer = device->p_uuid[UI_CURRENT] & ~((u64)1);
-	for (i = UI_HISTORY_START; i <= UI_HISTORY_END; i++) {
-		self = device->ldev->md.uuid[i] & ~((u64)1);
-		if (self == peer)
-			return 2;
-	}
-
-	*rule_nr = 90;
-	self = device->ldev->md.uuid[UI_BITMAP] & ~((u64)1);
-	peer = device->p_uuid[UI_BITMAP] & ~((u64)1);
-	if (self == peer && self != ((u64)0))
-		return 100;
+/* see also bio_flags_to_wire() */
+static blk_opf_t wire_flags_to_bio(struct drbd_connection *connection, u32 dpf)
+{
+	blk_opf_t opf = wire_flags_to_bio_op(dpf) |
+		(dpf & DP_RW_SYNC ? REQ_SYNC : 0);
 
-	*rule_nr = 100;
-	for (i = UI_HISTORY_START; i <= UI_HISTORY_END; i++) {
-		self = device->ldev->md.uuid[i] & ~((u64)1);
-		for (j = UI_HISTORY_START; j <= UI_HISTORY_END; j++) {
-			peer = device->p_uuid[j] & ~((u64)1);
-			if (self == peer)
-				return -100;
-		}
-	}
+	/* we used to communicate one bit only in older DRBD */
+	if (connection->agreed_pro_version >= 95)
+		opf |= (dpf & DP_FUA ? REQ_FUA : 0) |
+			    (dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
 
-	return -1000;
+	return opf;
 }
 
-/* drbd_sync_handshake() returns the new conn state on success, or
-   CONN_MASK (-1) on failure.
- */
-static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
-					   enum drbd_role peer_role,
-					   enum drbd_disk_state peer_disk) __must_hold(local)
+static void drbd_wait_for_activity_log_extents(struct drbd_peer_request *peer_req)
 {
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
 	struct drbd_device *device = peer_device->device;
-	enum drbd_conns rv = C_MASK;
-	enum drbd_disk_state mydisk;
-	struct net_conf *nc;
-	int hg, rule_nr, rr_conflict, tentative, always_asbp;
+	struct lru_cache *al;
+	int nr_al_extents;
+	int nr, used, ecnt;
 
-	mydisk = device->state.disk;
-	if (mydisk == D_NEGOTIATING)
-		mydisk = device->new_state_tmp.disk;
+	/* Let the activity log know we are about to use it.
+	 * See also drbd_request_prepare() for the "request" entry point. */
+	nr_al_extents = interval_to_al_extents(&peer_req->i);
+	ecnt = atomic_add_return(nr_al_extents, &device->wait_for_actlog_ecnt);
 
-	drbd_info(device, "drbd_sync_handshake:\n");
+	spin_lock_irq(&device->al_lock);
+	al = device->act_log;
+	nr = al->nr_elements;
+	used = al->used;
+	spin_unlock_irq(&device->al_lock);
 
-	spin_lock_irq(&device->ldev->md.uuid_lock);
-	drbd_uuid_dump(device, "self", device->ldev->md.uuid, device->comm_bm_set, 0);
-	drbd_uuid_dump(device, "peer", device->p_uuid,
-		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
+	/* note: due to the slight delay between being accounted in "used" after
+	 * being committed to the activity log with drbd_al_begin_io_commit(),
+	 * and being subtracted from "wait_for_actlog_ecnt" in __drbd_submit_peer_request(),
+	 * this can err, but only on the conservative side (overestimating ecnt).
+	 * ecnt also includes any requests which are held due to conflicts,
+	 * conservatively overestimating the number of activity log extents
+	 * required. */
+	if (ecnt > nr - used) {
+		conn_wait_active_ee_empty_or_disconnect(connection);
+		drbd_flush_after_epoch(connection, NULL);
+		conn_wait_done_ee_empty_or_disconnect(connection);
 
-	hg = drbd_uuid_compare(peer_device, peer_role, &rule_nr);
-	spin_unlock_irq(&device->ldev->md.uuid_lock);
+		/* would this peer even understand me? */
+		if (connection->agreed_pro_version >= 114)
+			drbd_send_confirm_stable(peer_req);
+	}
+}
 
-	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
+static int drbd_peer_write_conflicts(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	sector_t sector = peer_req->i.sector;
+	const unsigned int size = peer_req->i.size;
+	struct drbd_interval *i;
 
-	if (hg == -1000) {
-		drbd_alert(device, "Unrelated data, aborting!\n");
-		return C_MASK;
-	}
-	if (hg < -0x10000) {
-		int proto, fflags;
-		hg = -hg;
-		proto = hg & 0xff;
-		fflags = (hg >> 8) & 0xff;
-		drbd_alert(device, "To resolve this both sides have to support at least protocol %d and feature flags 0x%x\n",
-					proto, fflags);
-		return C_MASK;
-	}
-	if (hg < -1000) {
-		drbd_alert(device, "To resolve this both sides have to support at least protocol %d\n", -hg - 1000);
-		return C_MASK;
-	}
+	i = drbd_find_conflict(device, &peer_req->i, CONFLICT_FLAG_APPLICATION_ONLY);
 
-	if    ((mydisk == D_INCONSISTENT && peer_disk > D_INCONSISTENT) ||
-	    (peer_disk == D_INCONSISTENT && mydisk    > D_INCONSISTENT)) {
-		int f = (hg == -100) || abs(hg) == 2;
-		hg = mydisk > D_INCONSISTENT ? 1 : -1;
-		if (f)
-			hg = hg*2;
-		drbd_info(device, "Becoming sync %s due to disk states.\n",
-		     hg > 0 ? "source" : "target");
+	if (i) {
+		drbd_alert(device, "Concurrent writes detected: "
+				"local=%llus +%u, remote=%llus +%u\n",
+				(unsigned long long) i->sector, i->size,
+				(unsigned long long) sector, size);
+		return -EBUSY;
 	}
 
-	if (abs(hg) == 100)
-		drbd_khelper(device, "initial-split-brain");
+	return 0;
+}
 
-	rcu_read_lock();
-	nc = rcu_dereference(peer_device->connection->net_conf);
-	always_asbp = nc->always_asbp;
-	rr_conflict = nc->rr_conflict;
-	tentative = nc->tentative;
-	rcu_read_unlock();
+static void drbd_queue_peer_request(struct drbd_device *device, struct drbd_peer_request *peer_req)
+{
+	atomic_inc(&device->wait_for_actlog);
+	spin_lock(&device->submit.lock);
+	list_add_tail(&peer_req->w.list, &device->submit.peer_writes);
+	spin_unlock(&device->submit.lock);
+	queue_work(device->submit.wq, &device->submit.worker);
+	/* do_submit() may sleep internally on al_wait, too */
+	wake_up(&device->al_wait);
+}
 
-	if (hg == 100 || (hg == -100 && always_asbp)) {
-		int pcount = (device->state.role == R_PRIMARY)
-			   + (peer_role == R_PRIMARY);
-		int forced = (hg == -100);
+static struct drbd_peer_request *find_released_peer_request(struct drbd_resource *resource, unsigned int node_id, u64 dagtag)
+{
+	struct drbd_connection *connection;
+	struct drbd_peer_request *released_peer_req = NULL;
 
-		switch (pcount) {
-		case 0:
-			hg = drbd_asb_recover_0p(peer_device);
-			break;
-		case 1:
-			hg = drbd_asb_recover_1p(peer_device);
-			break;
-		case 2:
-			hg = drbd_asb_recover_2p(peer_device);
+	read_lock_irq(&resource->state_rwlock);
+	for_each_connection(connection, resource) {
+		struct drbd_peer_request *peer_req;
+
+		/* Skip if we are not connected. If we are in the process of
+		 * disconnecting, the requests on dagtag_wait_ee will be
+		 * cleared up. Do not interfere with that process. */
+		if (connection->cstate[NOW] < C_CONNECTED)
+			continue;
+
+		spin_lock(&connection->peer_reqs_lock);
+		list_for_each_entry(peer_req, &connection->dagtag_wait_ee, w.list) {
+			if (!peer_req->depend_dagtag ||
+					peer_req->depend_dagtag_node_id != node_id ||
+					peer_req->depend_dagtag > dagtag)
+				continue;
+
+			dynamic_drbd_dbg(peer_req->peer_device, "%s at %llus+%u: Wait for dagtag %llus from peer %u complete\n",
+					drbd_interval_type_str(&peer_req->i),
+					(unsigned long long) peer_req->i.sector, peer_req->i.size,
+					(unsigned long long) peer_req->depend_dagtag,
+					peer_req->depend_dagtag_node_id);
+
+			list_del(&peer_req->w.list);
+			released_peer_req = peer_req;
 			break;
 		}
-		if (abs(hg) < 100) {
-			drbd_warn(device, "Split-Brain detected, %d primaries, "
-			     "automatically solved. Sync from %s node\n",
-			     pcount, (hg < 0) ? "peer" : "this");
-			if (forced) {
-				drbd_warn(device, "Doing a full sync, since"
-				     " UUIDs where ambiguous.\n");
-				hg = hg*2;
-			}
-		}
+		spin_unlock(&connection->peer_reqs_lock);
+
+		if (released_peer_req)
+			break;
 	}
+	read_unlock_irq(&resource->state_rwlock);
 
-	if (hg == -100) {
-		if (test_bit(DISCARD_MY_DATA, &device->flags) && !(device->p_uuid[UI_FLAGS]&1))
-			hg = -1;
-		if (!test_bit(DISCARD_MY_DATA, &device->flags) && (device->p_uuid[UI_FLAGS]&1))
-			hg = 1;
+	return released_peer_req;
+}
 
-		if (abs(hg) < 100)
-			drbd_warn(device, "Split-Brain detected, manually solved. "
-			     "Sync from %s node\n",
-			     (hg < 0) ? "peer" : "this");
-	}
+static void release_dagtag_wait(struct drbd_resource *resource, unsigned int node_id, u64 dagtag)
+{
+	struct drbd_peer_request *peer_req;
 
-	if (hg == -100) {
-		/* FIXME this log message is not correct if we end up here
-		 * after an attempted attach on a diskless node.
-		 * We just refuse to attach -- well, we drop the "connection"
-		 * to that disk, in a way... */
-		drbd_alert(device, "Split-Brain detected but unresolved, dropping connection!\n");
-		drbd_khelper(device, "split-brain");
-		return C_MASK;
+	while ((peer_req = find_released_peer_request(resource, node_id, dagtag))) {
+		atomic_inc(&peer_req->peer_device->connection->backing_ee_cnt);
+		drbd_conflict_submit_peer_read(peer_req);
 	}
+}
 
-	if (hg > 0 && mydisk <= D_INCONSISTENT) {
-		drbd_err(device, "I shall become SyncSource, but I am inconsistent!\n");
-		return C_MASK;
-	}
+/* A dagtag wait request of a sync target, parked until this connection's
+ * write stream reaches the position the request names. Waits live on the
+ * connection that feeds the stream: its dagtag advance and its teardown answer
+ * them; the requester's own teardown discards its waits unanswered.
+ */
+struct drbd_dagtag_wait_req {
+	struct list_head list;
+	struct drbd_peer_device *peer_device;
+	sector_t sector;
+	unsigned int size;
+	u64 block_id;
+	u64 dagtag;
+};
 
-	if (hg < 0 && /* by intention we do not use mydisk here. */
-	    device->state.role == R_PRIMARY && device->state.disk >= D_CONSISTENT) {
-		switch (rr_conflict) {
-		case ASB_CALL_HELPER:
-			drbd_khelper(device, "pri-lost");
-			fallthrough;
-		case ASB_DISCONNECT:
-			drbd_err(device, "I shall become SyncTarget, but I am primary!\n");
-			return C_MASK;
-		case ASB_VIOLENTLY:
-			drbd_warn(device, "Becoming SyncTarget, violating the stable-data"
-			     "assumption\n");
-		}
-	}
+static int queue_dagtag_wait_req(struct drbd_peer_device *peer_device, sector_t sector,
+				 unsigned int size, u64 block_id, unsigned int node_id,
+				 u64 dagtag)
+{
+	struct drbd_resource *resource = peer_device->device->resource;
+	struct drbd_connection *connection;
+	struct drbd_dagtag_wait_req *wait;
+	bool queued = false;
 
-	if (tentative || test_bit(CONN_DRY_RUN, &peer_device->connection->flags)) {
-		if (hg == 0)
-			drbd_info(device, "dry-run connect: No resync, would become Connected immediately.\n");
-		else
-			drbd_info(device, "dry-run connect: Would become %s, doing a %s resync.",
-				 drbd_conn_str(hg > 0 ? C_SYNC_SOURCE : C_SYNC_TARGET),
-				 abs(hg) >= 2 ? "full" : "bit-map based");
-		return C_MASK;
+	wait = kmalloc_obj(*wait, GFP_NOIO);
+	if (!wait)
+		return -ENOMEM;
+
+	wait->peer_device = peer_device;
+	wait->sector = sector;
+	wait->size = size;
+	wait->block_id = block_id;
+	wait->dagtag = dagtag;
+
+	rcu_read_lock();
+	connection = drbd_connection_by_node_id(resource, node_id);
+	if (connection) {
+		/* answer_dagtag_wait_reqs() empties this list under this lock
+		 * once the stream is gone, and the teardown marks the stream
+		 * before it does. Take the decision again here, so a wait
+		 * either lands before that walk or is never queued at all.
+		 */
+		spin_lock_irq(&connection->peer_reqs_lock);
+		queued = !test_bit(DAGTAG_STREAM_GONE, &connection->flags);
+		if (queued)
+			list_add_tail(&wait->list, &connection->dagtag_wait_reqs);
+		spin_unlock_irq(&connection->peer_reqs_lock);
 	}
+	rcu_read_unlock();
 
-	if (abs(hg) >= 2) {
-		drbd_info(device, "Writing the whole bitmap, full sync required after drbd_sync_handshake.\n");
-		if (drbd_bitmap_io(device, &drbd_bmio_set_n_write, "set_n_write from sync_handshake",
-					BM_LOCKED_SET_ALLOWED, NULL))
-			return C_MASK;
+	if (!queued) {
+		/* The stream went away between the reach test and here. */
+		kfree(wait);
+		return drbd_send_ack_be(peer_device, P_RS_DAGTAG_UNREACHABLE,
+					sector, size, block_id);
 	}
 
-	if (hg > 0) { /* become sync source. */
-		rv = C_WF_BITMAP_S;
-	} else if (hg < 0) { /* become sync target */
-		rv = C_WF_BITMAP_T;
-	} else {
-		rv = C_CONNECTED;
-		if (drbd_bm_total_weight(device)) {
-			drbd_info(device, "No resync, but %lu bits in bitmap!\n",
-			     drbd_bm_total_weight(device));
+	return 0;
+}
+
+/* Answer every dagtag wait request this connection's stream has now reached,
+ * and, when the stream itself is gone, every request that is left.
+ */
+static void answer_dagtag_wait_reqs(struct drbd_connection *connection, u64 dagtag, bool gone)
+{
+	struct drbd_dagtag_wait_req *wait, *t;
+	LIST_HEAD(work_list);
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_for_each_entry_safe(wait, t, &connection->dagtag_wait_reqs, list) {
+		if (gone || wait->dagtag <= dagtag) {
+			/* Pin the requester across the send below; only list
+			 * membership keeps it referenced otherwise.
+			 */
+			kref_get(&wait->peer_device->connection->kref);
+			list_move_tail(&wait->list, &work_list);
 		}
 	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	return rv;
+	list_for_each_entry_safe(wait, t, &work_list, list) {
+		struct drbd_connection *requester = wait->peer_device->connection;
+
+		drbd_send_ack_be(wait->peer_device,
+				 gone ? P_RS_DAGTAG_UNREACHABLE : P_RS_DAGTAG_REACHED,
+				 wait->sector, wait->size, wait->block_id);
+		kfree(wait);
+		kref_put(&requester->kref, drbd_destroy_connection);
+	}
 }
 
-static enum drbd_after_sb_p convert_after_sb(enum drbd_after_sb_p peer)
+/* The requester of these waits is going away; discard them from every
+ * stream's list before a del-peer could free the peer_device they name.
+ */
+static void drop_dagtag_wait_reqs_of(struct drbd_connection *requester)
 {
-	/* ASB_DISCARD_REMOTE - ASB_DISCARD_LOCAL is valid */
-	if (peer == ASB_DISCARD_REMOTE)
-		return ASB_DISCARD_LOCAL;
+	struct drbd_resource *resource = requester->resource;
+	struct drbd_connection *connection;
+	struct drbd_dagtag_wait_req *wait, *t;
+	LIST_HEAD(work_list);
 
-	/* any other things with ASB_DISCARD_REMOTE or ASB_DISCARD_LOCAL are invalid */
-	if (peer == ASB_DISCARD_LOCAL)
-		return ASB_DISCARD_REMOTE;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		list_for_each_entry_safe(wait, t, &connection->dagtag_wait_reqs, list) {
+			if (wait->peer_device->connection == requester)
+				list_move_tail(&wait->list, &work_list);
+		}
+		spin_unlock_irq(&connection->peer_reqs_lock);
+	}
+	rcu_read_unlock();
 
-	/* everything else is valid if they are equal on both sides. */
-	return peer;
+	list_for_each_entry_safe(wait, t, &work_list, list)
+		kfree(wait);
 }
 
-static int receive_protocol(struct drbd_connection *connection, struct packet_info *pi)
+/* This node stopped being the sync source of this peer, so no stream
+ * position it still reaches means anything to the writes that peer withholds.
+ * Answer every wait request of that peer unreachable: a peer still waiting
+ * refuses the writes, a peer that left sync target ignores the answer.
+ */
+void drbd_dagtag_wait_reqs_source_gone(struct drbd_peer_device *requester)
 {
-	struct p_protocol *p = pi->data;
-	enum drbd_after_sb_p p_after_sb_0p, p_after_sb_1p, p_after_sb_2p;
-	int p_proto, p_discard_my_data, p_two_primaries, cf;
-	struct net_conf *nc, *old_net_conf, *new_net_conf = NULL;
-	char integrity_alg[SHARED_SECRET_MAX] = "";
-	struct crypto_shash *peer_integrity_tfm = NULL;
-	void *int_dig_in = NULL, *int_dig_vv = NULL;
-
-	p_proto		= be32_to_cpu(p->protocol);
-	p_after_sb_0p	= be32_to_cpu(p->after_sb_0p);
-	p_after_sb_1p	= be32_to_cpu(p->after_sb_1p);
-	p_after_sb_2p	= be32_to_cpu(p->after_sb_2p);
-	p_two_primaries = be32_to_cpu(p->two_primaries);
-	cf		= be32_to_cpu(p->conn_flags);
-	p_discard_my_data = cf & CF_DISCARD_MY_DATA;
-
-	if (connection->agreed_pro_version >= 87) {
-		int err;
-
-		if (pi->size > sizeof(integrity_alg))
-			return -EIO;
-		err = drbd_recv_all(connection, integrity_alg, pi->size);
-		if (err)
-			return err;
-		integrity_alg[SHARED_SECRET_MAX - 1] = 0;
-	}
-
-	if (pi->cmd != P_PROTOCOL_UPDATE) {
-		clear_bit(CONN_DRY_RUN, &connection->flags);
-
-		if (cf & CF_DRY_RUN)
-			set_bit(CONN_DRY_RUN, &connection->flags);
-
-		rcu_read_lock();
-		nc = rcu_dereference(connection->net_conf);
-
-		if (p_proto != nc->wire_protocol) {
-			drbd_err(connection, "incompatible %s settings\n", "protocol");
-			goto disconnect_rcu_unlock;
-		}
-
-		if (convert_after_sb(p_after_sb_0p) != nc->after_sb_0p) {
-			drbd_err(connection, "incompatible %s settings\n", "after-sb-0pri");
-			goto disconnect_rcu_unlock;
-		}
-
-		if (convert_after_sb(p_after_sb_1p) != nc->after_sb_1p) {
-			drbd_err(connection, "incompatible %s settings\n", "after-sb-1pri");
-			goto disconnect_rcu_unlock;
-		}
+	struct drbd_resource *resource = requester->device->resource;
+	struct drbd_connection *connection;
+	struct drbd_dagtag_wait_req *wait, *t;
+	LIST_HEAD(work_list);
 
-		if (convert_after_sb(p_after_sb_2p) != nc->after_sb_2p) {
-			drbd_err(connection, "incompatible %s settings\n", "after-sb-2pri");
-			goto disconnect_rcu_unlock;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		list_for_each_entry_safe(wait, t, &connection->dagtag_wait_reqs, list) {
+			if (wait->peer_device == requester)
+				list_move_tail(&wait->list, &work_list);
 		}
+		spin_unlock_irq(&connection->peer_reqs_lock);
+	}
+	rcu_read_unlock();
 
-		if (p_discard_my_data && nc->discard_my_data) {
-			drbd_err(connection, "incompatible %s settings\n", "discard-my-data");
-			goto disconnect_rcu_unlock;
-		}
+	list_for_each_entry_safe(wait, t, &work_list, list) {
+		drbd_send_ack_be(requester, P_RS_DAGTAG_UNREACHABLE,
+				 wait->sector, wait->size, wait->block_id);
+		kfree(wait);
+	}
+}
 
-		if (p_two_primaries != nc->two_primaries) {
-			drbd_err(connection, "incompatible %s settings\n", "allow-two-primaries");
-			goto disconnect_rcu_unlock;
-		}
+/* The exchange toward this sync source can no longer complete: the resync
+ * ended or was aborted, the source detached, or the connection to it is
+ * gone. Resolve every write of this device still withheld from
+ * acknowledgment as "unreachable": mark and refuse. A refusal is always
+ * safe; the cost is a retry. Runs from the after-state-change work when the
+ * replication state leaves sync target.
+ */
+void drbd_refuse_unsecured_writes(struct drbd_peer_device *source)
+{
+	struct drbd_device *device = source->device;
+	struct drbd_resource *resource = device->resource;
+	struct drbd_connection *connection;
+	struct drbd_peer_request *peer_req, *t;
+	LIST_HEAD(work_list);
 
-		if (strcmp(integrity_alg, nc->integrity_alg)) {
-			drbd_err(connection, "incompatible %s settings\n", "data-integrity-alg");
-			goto disconnect_rcu_unlock;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		list_for_each_entry_safe(peer_req, t, &connection->source_wait_ee, w.list) {
+			if (peer_req->peer_device->device == device)
+				list_move_tail(&peer_req->w.list, &work_list);
 		}
+		spin_unlock_irq(&connection->peer_reqs_lock);
+	}
+	rcu_read_unlock();
 
-		rcu_read_unlock();
+	list_for_each_entry_safe(peer_req, t, &work_list, w.list) {
+		list_del_init(&peer_req->w.list);
+		drbd_refuse_unsecured_write(peer_req);
 	}
+}
 
-	if (integrity_alg[0]) {
-		int hash_size;
+static void set_connection_dagtag(struct drbd_connection *connection, u64 dagtag)
+{
+	atomic64_set(&connection->last_dagtag_sector, dagtag);
+	set_bit(RECEIVED_DAGTAG, &connection->flags);
 
-		/*
-		 * We can only change the peer data integrity algorithm
-		 * here.  Changing our own data integrity algorithm
-		 * requires that we send a P_PROTOCOL_UPDATE packet at
-		 * the same time; otherwise, the peer has no way to
-		 * tell between which packets the algorithm should
-		 * change.
-		 */
+	release_dagtag_wait(connection->resource, connection->peer_node_id, dagtag);
+	answer_dagtag_wait_reqs(connection, dagtag, false);
+}
 
-		peer_integrity_tfm = crypto_alloc_shash(integrity_alg, 0, 0);
-		if (IS_ERR(peer_integrity_tfm)) {
-			peer_integrity_tfm = NULL;
-			drbd_err(connection, "peer data-integrity-alg %s not supported\n",
-				 integrity_alg);
-			goto disconnect;
-		}
+static void submit_peer_request_activity_log(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	int err;
+	int nr_al_extents = interval_to_al_extents(&peer_req->i);
 
-		hash_size = crypto_shash_digestsize(peer_integrity_tfm);
-		int_dig_in = kmalloc(hash_size, GFP_KERNEL);
-		int_dig_vv = kmalloc(hash_size, GFP_KERNEL);
-		if (!(int_dig_in && int_dig_vv)) {
-			drbd_err(connection, "Allocation of buffers for data integrity checking failed\n");
-			goto disconnect;
-		}
+	if (nr_al_extents != 1 || !drbd_al_begin_io_fastpath(device, &peer_req->i)) {
+		drbd_queue_peer_request(device, peer_req);
+		return;
 	}
 
-	new_net_conf = kmalloc_obj(struct net_conf);
-	if (!new_net_conf)
-		goto disconnect;
+	peer_req->flags |= EE_IN_ACTLOG;
+	atomic_sub(nr_al_extents, &device->wait_for_actlog_ecnt);
 
-	mutex_lock(&connection->data.mutex);
-	mutex_lock(&connection->resource->conf_update);
-	old_net_conf = connection->net_conf;
-	*new_net_conf = *old_net_conf;
+	err = drbd_submit_peer_request(peer_req);
+	if (err)
+		drbd_cleanup_after_failed_submit_peer_write(peer_req);
+}
 
-	new_net_conf->wire_protocol = p_proto;
-	new_net_conf->after_sb_0p = convert_after_sb(p_after_sb_0p);
-	new_net_conf->after_sb_1p = convert_after_sb(p_after_sb_1p);
-	new_net_conf->after_sb_2p = convert_after_sb(p_after_sb_2p);
-	new_net_conf->two_primaries = p_two_primaries;
+/* Give up on a peer write that was held waiting for conflicts to resolve.
+ * Mirrors the cleanup done in receive_Data()'s out_del_list path, but also
+ * removes the interval (which was already inserted into the tree) and wakes
+ * conn_disconnect(), which may be waiting for active_ee_cnt to reach zero.
+ */
+static void cleanup_canceled_peer_write(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
 
-	rcu_assign_pointer(connection->net_conf, new_net_conf);
-	mutex_unlock(&connection->resource->conf_update);
-	mutex_unlock(&connection->data.mutex);
+	drbd_remove_peer_req_interval(peer_req);
 
-	crypto_free_shash(connection->peer_integrity_tfm);
-	kfree(connection->int_dig_in);
-	kfree(connection->int_dig_vv);
-	connection->peer_integrity_tfm = peer_integrity_tfm;
-	connection->int_dig_in = int_dig_in;
-	connection->int_dig_vv = int_dig_vv;
+	spin_lock_irq(&connection->peer_reqs_lock);
+	peer_req->flags &= ~EE_ON_RECV_ORDER;
+	list_del(&peer_req->recv_order);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	if (strcmp(old_net_conf->integrity_alg, integrity_alg))
-		drbd_info(connection, "peer data-integrity-alg: %s\n",
-			  integrity_alg[0] ? integrity_alg : "(none)");
+	if (peer_req->flags & EE_IN_ACTLOG)
+		drbd_al_complete_io(device, &peer_req->i);
+	else
+		atomic_sub(interval_to_al_extents(&peer_req->i), &device->wait_for_actlog_ecnt);
 
-	kvfree_rcu_mightsleep(old_net_conf);
-	return 0;
+	if (peer_req->flags & EE_SEND_WRITE_ACK)
+		dec_unacked(peer_device);
+	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + EV_CLEANUP);
+	put_ldev(device);
+	drbd_free_peer_req(peer_req);
 
-disconnect_rcu_unlock:
-	rcu_read_unlock();
-disconnect:
-	crypto_free_shash(peer_integrity_tfm);
-	kfree(int_dig_in);
-	kfree(int_dig_vv);
-	conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-	return -EIO;
+	if (atomic_dec_and_test(&connection->active_ee_cnt))
+		wake_up(&connection->ee_wait);
 }
 
-/* helper function
- * input: alg name, feature name
- * return: NULL (alg name was "")
- *         ERR_PTR(error) if something goes wrong
- *         or the crypto hash ptr, if it worked out ok. */
-static struct crypto_shash *drbd_crypto_alloc_digest_safe(
-		const struct drbd_device *device,
-		const char *alg, const char *name)
+void drbd_conflict_submit_peer_write(struct drbd_peer_request *peer_req)
 {
-	struct crypto_shash *tfm;
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	bool conflict = false;
+	bool canceled;
+
+	spin_lock_irq(&device->interval_lock);
+	clear_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags);
+	canceled = test_bit(INTERVAL_CANCELED, &peer_req->i.flags);
+	conflict = drbd_find_conflict(device, &peer_req->i, 0);
+	if (conflict)
+		drbd_rs_depth_exempt(device, &peer_req->i);
+	else if (!canceled)
+		set_bit(INTERVAL_SUBMITTED, &peer_req->i.flags);
+	spin_unlock_irq(&device->interval_lock);
+
+	if (canceled)
+		cleanup_canceled_peer_write(peer_req);
+	else if (!conflict)
+		submit_peer_request_activity_log(peer_req);
+}
+
+/* mirrored write
+ *
+ * Request handling flow:
+ *
+ *                      conflict
+ * receive_Data -----------------------+
+ *       |                             |
+ *       |                            ...
+ *       |                             |
+ *       |                             v
+ *       |                   drbd_do_submit_conflict
+ *       |                             |
+ *       |                             v
+ *       +------------------ drbd_conflict_submit_peer_write
+ *       |
+ *       v                         wait for AL
+ * submit_peer_request_activity_log --------> drbd_queue_peer_request
+ *       |                                         |
+ *       |                                        ...
+ *       |                                         |
+ *       |                                         v    AL extent active
+ *       |                                    do_submit ----------------+
+ *       |                                         |                    |
+ *       |                                         v                    v
+ *       |                              send_and_submit_pending   submit_fast_path
+ *       |                                         |                    |
+ *       v                                         v                    |
+ * drbd_submit_peer_request <-------- __drbd_submit_peer_request <------+
+ *       |
+ *      ... backing device
+ *       |
+ *       v
+ * drbd_peer_request_endio
+ *       |
+ *       v
+ * drbd_endio_write_sec_final
+ *       |
+ *      ... done_ee
+ *       |
+ *       v
+ * drbd_finish_peer_reqs
+ *       |
+ *       v
+ * e_end_block
+ *       |
+ *      ... via peer
+ *       |
+ *       v
+ * got_peer_ack
+ */
 
-	if (!alg[0])
-		return NULL;
+/* The state handling permits one incoming resync at a time. Return the peer
+ * device that runs it, with a reference on its connection, or NULL.
+ */
+static struct drbd_peer_device *get_sync_source_ref(struct drbd_device *device)
+{
+	struct drbd_resource *resource = device->resource;
+	struct drbd_peer_device *peer_device;
 
-	tfm = crypto_alloc_shash(alg, 0, 0);
-	if (IS_ERR(tfm)) {
-		drbd_err(device, "Can not allocate \"%s\" as %s (reason: %ld)\n",
-			alg, name, PTR_ERR(tfm));
-		return tfm;
+	read_lock_irq(&resource->state_rwlock);
+	for_each_peer_device(peer_device, device) {
+		if (!repl_is_sync_target(peer_device->repl_state[NOW]))
+			continue;
+		kref_get(&peer_device->connection->kref);
+		read_unlock_irq(&resource->state_rwlock);
+		return peer_device;
 	}
-	return tfm;
+	read_unlock_irq(&resource->state_rwlock);
+
+	return NULL;
 }
 
-static int ignore_remaining_packet(struct drbd_connection *connection, struct packet_info *pi)
+/* The wait request travels on the sync source's data stream. Sent from the
+ * writer's receiver, a full send buffer toward the source would stall that
+ * receiver; the source connection's sender sends it instead.
+ */
+struct dagtag_wait_send {
+	struct drbd_work w;
+	struct drbd_peer_device *sync_source;
+	sector_t sector;
+	unsigned int size;
+	u64 block_id;
+	unsigned int node_id;
+	u64 dagtag;
+};
+
+static int w_send_dagtag_wait_req(struct drbd_work *w, int cancel)
 {
-	void *buffer = connection->data.rbuf;
-	int size = pi->size;
+	struct dagtag_wait_send *send = container_of(w, struct dagtag_wait_send, w);
+	struct drbd_connection *connection = send->sync_source->connection;
 
-	while (size) {
-		int s = min_t(int, size, DRBD_SOCKET_BUFFER_SIZE);
-		s = drbd_recv(connection, buffer, s);
-		if (s <= 0) {
-			if (s < 0)
-				return s;
-			break;
-		}
-		size -= s;
-	}
-	if (size)
-		return -EIO;
+	if (!cancel)
+		drbd_send_rs_request(send->sync_source, P_RS_DAGTAG_WAIT_REQ,
+				     send->sector, send->size, send->block_id,
+				     send->node_id, send->dagtag);
+	kref_put(&connection->kref, drbd_destroy_connection);
+	kfree(send);
 	return 0;
 }
 
-/*
- * config_unknown_volume  -  device configuration command for unknown volume
- *
- * When a device is added to an existing connection, the node on which the
- * device is added first will send configuration commands to its peer but the
- * peer will not know about the device yet.  It will warn and ignore these
- * commands.  Once the device is added on the second node, the second node will
- * send the same device configuration commands, but in the other direction.
+/* A write that lands on a sync target in a range the sync source is about to
+ * overwrite must not be acknowledged before the sync source has it too.
+ * Otherwise the resync reply rolls it back, and the repair resync in the other
+ * direction carries the rolled back block to the source as well: the
+ * acknowledged write is gone everywhere and no bitmap records it.
  *
- * (We can also end up here if drbd is misconfigured.)
+ * Ask the sync source to report when its own copy of the writer's stream
+ * reaches the position this write has in it: P_RS_DAGTAG_REACHED once it does,
+ * P_RS_DAGTAG_UNREACHABLE when it can not get there by itself. This only arms
+ * the write and sends the request. The write is submitted as usual; it is
+ * e_end_block() that withholds the acknowledgment until the answer arrives.
  */
-static int config_unknown_volume(struct drbd_connection *connection, struct packet_info *pi)
+static void drbd_withhold_ack_until_source_has_write(struct drbd_peer_request *peer_req)
 {
-	drbd_warn(connection, "%s packet received for volume %u, which is not configured locally\n",
-		  drbd_packet_name(pi->cmd), pi->vnr);
-	return ignore_remaining_packet(connection, pi);
+	struct drbd_peer_device *writer = peer_req->peer_device;
+	struct drbd_device *device = writer->device;
+	struct drbd_peer_device *sync_source;
+	unsigned long first_bit, last_bit;
+	sector_t block_sector;
+	unsigned int block_size;
+
+	if (peer_req->i.size == 0)
+		return;
+
+	sync_source = get_sync_source_ref(device);
+	if (!sync_source)
+		return;
+
+	/* The sync source has its own writes. */
+	if (sync_source == writer)
+		goto out;
+
+	if (!(sync_source->connection->agreed_features & DRBD_FF_WRITE_POSTPONE))
+		goto out;
+
+	if (!get_ldev(device))
+		goto out;
+
+	unsecured_write_range(peer_req, &block_sector, &block_size);
+	first_bit = bm_sect_to_bit(device->bitmap, block_sector);
+	last_bit = first_bit + block_size / bm_block_size(device->bitmap) - 1;
+
+	if (drbd_bm_count_bits(device, sync_source->bitmap_index, first_bit, last_bit)) {
+		struct dagtag_wait_send *send;
+
+		peer_req->flags |= EE_WAIT_FOR_SOURCE;
+		peer_req->wait_source_node_id = sync_source->node_id;
+
+		send = kzalloc_obj(*send, GFP_NOIO);
+		if (!send) {
+			/* No request goes out; have e_end_block() refuse the write. */
+			peer_req->flags |= EE_SOURCE_UNREACHABLE;
+			goto out_ldev;
+		}
+		send->w.cb = w_send_dagtag_wait_req;
+		send->sync_source = sync_source;
+		send->sector = block_sector;
+		send->size = block_size;
+		send->block_id = (unsigned long)peer_req;
+		send->node_id = writer->connection->peer_node_id;
+		send->dagtag = peer_req->dagtag_sector;
+		put_ldev(device);
+		/* The connection reference travels with the work item. */
+		drbd_queue_work(&sync_source->connection->sender_work, &send->w);
+		return;
+	}
+
+out_ldev:
+	put_ldev(device);
+out:
+	kref_put(&sync_source->connection->kref, drbd_destroy_connection);
 }
 
-static int receive_SyncParam(struct drbd_connection *connection, struct packet_info *pi)
+static int receive_Data(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
-	struct p_rs_param_95 *p;
-	unsigned int header_size, data_size, exp_max_sz;
-	struct crypto_shash *verify_tfm = NULL;
-	struct crypto_shash *csums_tfm = NULL;
-	struct net_conf *old_net_conf, *new_net_conf = NULL;
-	struct disk_conf *old_disk_conf = NULL, *new_disk_conf = NULL;
-	const int apv = connection->agreed_pro_version;
-	struct fifo_buffer *old_plan = NULL, *new_plan = NULL;
-	unsigned int fifo_size = 0;
-	int err;
+	struct drbd_net_conf *nc;
+	struct drbd_peer_request *peer_req;
+	struct drbd_peer_request_details d;
+	int err, tp;
+	bool conflict = false;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
-		return config_unknown_volume(connection, pi);
+		return -EIO;
 	device = peer_device->device;
 
-	exp_max_sz  = apv <= 87 ? sizeof(struct p_rs_param)
-		    : apv == 88 ? sizeof(struct p_rs_param)
-					+ SHARED_SECRET_MAX
-		    : apv <= 94 ? sizeof(struct p_rs_param_89)
-		    : /* apv >= 95 */ sizeof(struct p_rs_param_95);
-
-	if (pi->size > exp_max_sz) {
-		drbd_err(device, "SyncParam packet too long: received %u, expected <= %u bytes\n",
-		    pi->size, exp_max_sz);
-		return -EIO;
-	}
+	if (pi->cmd == P_TRIM)
+		D_ASSERT(peer_device, pi->size == 0);
 
-	if (apv <= 88) {
-		header_size = sizeof(struct p_rs_param);
-		data_size = pi->size - header_size;
-	} else if (apv <= 94) {
-		header_size = sizeof(struct p_rs_param_89);
-		data_size = pi->size - header_size;
-		D_ASSERT(device, data_size == 0);
-	} else {
-		header_size = sizeof(struct p_rs_param_95);
-		data_size = pi->size - header_size;
-		D_ASSERT(device, data_size == 0);
-	}
+	p_req_detail_from_pi(connection, &d, pi);
+	pi->data = NULL;
 
-	/* initialize verify_alg and csums_alg */
-	p = pi->data;
-	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
-	memset(&p->algs, 0, sizeof(p->algs));
+	if (!get_ldev(device)) {
+		int err2;
 
-	err = drbd_recv_all(peer_device->connection, p, header_size);
-	if (err)
+		err = wait_for_and_update_peer_seq(peer_device, d.peer_seq);
+		drbd_send_ack_dp(peer_device, P_NEG_ACK, &d);
+		atomic_inc(&connection->current_epoch->epoch_size);
+		err2 = ignore_remaining_packet(connection, pi->size);
+		if (!err)
+			err = err2;
 		return err;
+	}
 
-	mutex_lock(&connection->resource->conf_update);
-	old_net_conf = peer_device->connection->net_conf;
-	if (get_ldev(device)) {
-		new_disk_conf = kzalloc_obj(struct disk_conf);
-		if (!new_disk_conf) {
-			put_ldev(device);
-			mutex_unlock(&connection->resource->conf_update);
-			drbd_err(device, "Allocation of new disk_conf failed\n");
-			return -ENOMEM;
-		}
+	/*
+	 * Corresponding put_ldev done either below (on various errors), or in
+	 * drbd_peer_request_endio, if we successfully submit the data at the
+	 * end of this function.
+	 */
 
-		old_disk_conf = device->ldev->disk_conf;
-		*new_disk_conf = *old_disk_conf;
+	peer_req = drbd_alloc_peer_req(peer_device, GFP_TRY, d.bi_size,
+				       wire_flags_to_bio(connection, d.dp_flags));
+	if (!peer_req) {
+		put_ldev(device);
+		return -EIO;
+	}
+	peer_req->i.size = d.bi_size; /* storage size */
+	peer_req->i.sector = d.sector;
+	peer_req->i.type = INTERVAL_PEER_WRITE;
 
-		new_disk_conf->resync_rate = be32_to_cpu(p->resync_rate);
+	err = read_in_block(peer_req, &d);
+	if (err) {
+		drbd_free_peer_req(peer_req);
+		put_ldev(device);
+		return err;
 	}
 
-	if (apv >= 88) {
-		if (apv == 88) {
-			if (data_size > SHARED_SECRET_MAX || data_size == 0) {
-				drbd_err(device, "verify-alg of wrong size, "
-					"peer wants %u, accepting only up to %u byte\n",
-					data_size, SHARED_SECRET_MAX);
-				goto reconnect;
-			}
+	if (pi->cmd == P_TRIM)
+		peer_req->flags |= EE_TRIM;
+	else if (pi->cmd == P_ZEROES)
+		peer_req->flags |= EE_ZEROOUT;
 
-			err = drbd_recv_all(peer_device->connection, p->verify_alg, data_size);
-			if (err)
-				goto reconnect;
-			/* we expect NUL terminated string */
-			/* but just in case someone tries to be evil */
-			D_ASSERT(device, p->verify_alg[data_size-1] == 0);
-			p->verify_alg[data_size-1] = 0;
+	peer_req->w.cb = e_end_block;
+	peer_req->submit_jif = jiffies;
 
-		} else /* apv >= 89 */ {
-			/* we still expect NUL terminated strings */
-			/* but just in case someone tries to be evil */
-			D_ASSERT(device, p->verify_alg[SHARED_SECRET_MAX-1] == 0);
-			D_ASSERT(device, p->csums_alg[SHARED_SECRET_MAX-1] == 0);
-			p->verify_alg[SHARED_SECRET_MAX-1] = 0;
-			p->csums_alg[SHARED_SECRET_MAX-1] = 0;
-		}
+	if (pi->cmd == P_TRIM) {
+		D_ASSERT(peer_device, peer_req->i.size > 0);
+		D_ASSERT(peer_device, d.dp_flags & DP_DISCARD);
+		D_ASSERT(peer_device, bio_op(peer_req->bios.head) == REQ_OP_DISCARD);
+		/* need to play safe: an older DRBD sender
+		 * may mean zero-out while sending P_TRIM. */
+		if (0 == (connection->agreed_features & DRBD_FF_WZEROES))
+			peer_req->flags |= EE_ZEROOUT;
+	} else if (pi->cmd == P_ZEROES) {
+		D_ASSERT(peer_device, peer_req->i.size > 0);
+		D_ASSERT(peer_device, d.dp_flags & DP_ZEROES);
+		D_ASSERT(peer_device, bio_op(peer_req->bios.head) == REQ_OP_WRITE_ZEROES);
+		/* Do (not) pass down BLKDEV_ZERO_NOUNMAP? */
+		if (d.dp_flags & DP_DISCARD)
+			peer_req->flags |= EE_TRIM;
+	} else {
+		D_ASSERT(peer_device, peer_req->i.size > 0);
+		D_ASSERT(peer_device, bio_op(peer_req->bios.head) == REQ_OP_WRITE);
+	}
 
-		if (strcmp(old_net_conf->verify_alg, p->verify_alg)) {
-			if (device->state.conn == C_WF_REPORT_PARAMS) {
-				drbd_err(device, "Different verify-alg settings. me=\"%s\" peer=\"%s\"\n",
-				    old_net_conf->verify_alg, p->verify_alg);
-				goto disconnect;
-			}
-			verify_tfm = drbd_crypto_alloc_digest_safe(device,
-					p->verify_alg, "verify-alg");
-			if (IS_ERR(verify_tfm)) {
-				verify_tfm = NULL;
-				goto disconnect;
-			}
-		}
+	if (d.dp_flags & DP_MAY_SET_IN_SYNC)
+		peer_req->flags |= EE_MAY_SET_IN_SYNC;
 
-		if (apv >= 89 && strcmp(old_net_conf->csums_alg, p->csums_alg)) {
-			if (device->state.conn == C_WF_REPORT_PARAMS) {
-				drbd_err(device, "Different csums-alg settings. me=\"%s\" peer=\"%s\"\n",
-				    old_net_conf->csums_alg, p->csums_alg);
-				goto disconnect;
-			}
-			csums_tfm = drbd_crypto_alloc_digest_safe(device,
-					p->csums_alg, "csums-alg");
-			if (IS_ERR(csums_tfm)) {
-				csums_tfm = NULL;
-				goto disconnect;
+	spin_lock(&connection->epoch_lock);
+	peer_req->epoch = connection->current_epoch;
+	atomic_inc(&peer_req->epoch->epoch_size);
+	atomic_inc(&peer_req->epoch->active);
+	if (peer_req->epoch->oldest_unconfirmed_peer_req == NULL)
+		peer_req->epoch->oldest_unconfirmed_peer_req = peer_req;
+
+	if (connection->resource->write_ordering == WO_BIO_BARRIER &&
+	    atomic_read(&peer_req->epoch->epoch_size) == 1) {
+		struct drbd_epoch *epoch;
+		/* Issue a barrier if we start a new epoch, and the previous epoch
+		   was not a epoch containing a single request which already was
+		   a Barrier. */
+		epoch = list_entry(peer_req->epoch->list.prev, struct drbd_epoch, list);
+		if (epoch == peer_req->epoch) {
+			set_bit(DE_CONTAINS_A_BARRIER, &peer_req->epoch->flags);
+			peer_req->bios.head->bi_opf |= REQ_PREFLUSH | REQ_FUA;
+			peer_req->flags |= EE_IS_BARRIER;
+		} else {
+			if (atomic_read(&epoch->epoch_size) > 1 ||
+			    !test_bit(DE_CONTAINS_A_BARRIER, &epoch->flags)) {
+				set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags);
+				set_bit(DE_CONTAINS_A_BARRIER, &peer_req->epoch->flags);
+				peer_req->bios.head->bi_opf |= REQ_PREFLUSH | REQ_FUA;
+				peer_req->flags |= EE_IS_BARRIER;
 			}
 		}
+	}
+	spin_unlock(&connection->epoch_lock);
 
-		if (apv > 94 && new_disk_conf) {
-			new_disk_conf->c_plan_ahead = be32_to_cpu(p->c_plan_ahead);
-			new_disk_conf->c_delay_target = be32_to_cpu(p->c_delay_target);
-			new_disk_conf->c_fill_target = be32_to_cpu(p->c_fill_target);
-			new_disk_conf->c_max_rate = be32_to_cpu(p->c_max_rate);
-
-			fifo_size = (new_disk_conf->c_plan_ahead * 10 * SLEEP_TIME) / HZ;
-			if (fifo_size != device->rs_plan_s->size) {
-				new_plan = fifo_alloc(fifo_size);
-				if (!new_plan) {
-					drbd_err(device, "kmalloc of fifo_buffer failed");
-					put_ldev(device);
-					goto disconnect;
-				}
-			}
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	tp = nc->two_primaries;
+	if (connection->agreed_pro_version < 100) {
+		switch (nc->wire_protocol) {
+		case DRBD_PROT_C:
+			d.dp_flags |= DP_SEND_WRITE_ACK;
+			break;
+		case DRBD_PROT_B:
+			d.dp_flags |= DP_SEND_RECEIVE_ACK;
+			break;
 		}
+	}
+	rcu_read_unlock();
 
-		if (verify_tfm || csums_tfm) {
-			new_net_conf = kzalloc_obj(struct net_conf);
-			if (!new_net_conf)
-				goto disconnect;
+	if (d.dp_flags & DP_SEND_WRITE_ACK) {
+		peer_req->flags |= EE_SEND_WRITE_ACK;
+		inc_unacked(peer_device);
+		/* corresponding dec_unacked() in e_end_block()
+		 * respective _drbd_clear_done_ee */
+	}
 
-			*new_net_conf = *old_net_conf;
+	if (d.dp_flags & DP_SEND_RECEIVE_ACK) {
+		/* I really don't like it that the receiver thread
+		 * sends on the msock, but anyways */
+		drbd_send_ack(peer_device, P_RECV_ACK, peer_req);
+	}
 
-			if (verify_tfm) {
-				strscpy(new_net_conf->verify_alg, p->verify_alg);
-				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
-				crypto_free_shash(peer_device->connection->verify_tfm);
-				peer_device->connection->verify_tfm = verify_tfm;
-				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
-			}
-			if (csums_tfm) {
-				strscpy(new_net_conf->csums_alg, p->csums_alg);
-				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
-				crypto_free_shash(peer_device->connection->csums_tfm);
-				peer_device->connection->csums_tfm = csums_tfm;
-				drbd_info(device, "using csums-alg: \"%s\"\n", p->csums_alg);
-			}
-			rcu_assign_pointer(connection->net_conf, new_net_conf);
-		}
+	if (tp) {
+		/* two primaries implies protocol C */
+		D_ASSERT(device, d.dp_flags & DP_SEND_WRITE_ACK);
+		err = wait_for_and_update_peer_seq(peer_device, d.peer_seq);
+		if (err)
+			goto out;
+	} else {
+		update_peer_seq(peer_device, d.peer_seq);
 	}
 
-	if (new_disk_conf) {
-		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
-		put_ldev(device);
+	peer_req->dagtag_sector = atomic64_read(&connection->last_dagtag_sector) + (peer_req->i.size >> 9);
+
+	drbd_wait_for_activity_log_extents(peer_req);
+
+	atomic_inc(&connection->active_ee_cnt);
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_add_tail(&peer_req->recv_order, &connection->peer_requests);
+	peer_req->flags |= EE_ON_RECV_ORDER;
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	/* The answer is matched against peer_requests, so ask only once this
+	 * request is on that list. Still before the interval goes into the
+	 * tree: from there on the write may be submitted and completed.
+	 */
+	drbd_withhold_ack_until_source_has_write(peer_req);
+
+	/* Note: this now may or may not be "hot" in the activity log.
+	 * Still, it is the best time to record that we need to set the
+	 * out-of-sync bit, if we delay that until drbd_submit_peer_request(),
+	 * we may introduce a race with some re-attach on the peer.
+	 * Unless we want to guarantee that we drain all in-flight IO
+	 * whenever we receive a state change. Which I'm not sure about.
+	 * Use the EE_SET_OUT_OF_SYNC flag, to be acted on just before
+	 * the actual submit, when we can be sure it is "hot".
+	 */
+	if (peer_device->disk_state[NOW] < D_INCONSISTENT) {
+		peer_req->flags &= ~EE_MAY_SET_IN_SYNC;
+		peer_req->flags |= EE_SET_OUT_OF_SYNC;
 	}
 
-	if (new_plan) {
-		old_plan = device->rs_plan_s;
-		rcu_assign_pointer(device->rs_plan_s, new_plan);
+	spin_lock_irq(&device->interval_lock);
+	if (tp) {
+		err = drbd_peer_write_conflicts(peer_req);
+		if (err) {
+			spin_unlock_irq(&device->interval_lock);
+			goto out_del_list;
+		}
 	}
+	conflict = drbd_find_conflict(device, &peer_req->i, 0);
+	drbd_insert_interval(&device->requests, &peer_req->i);
+	if (conflict)
+		drbd_rs_depth_exempt(device, &peer_req->i);
+	else
+		set_bit(INTERVAL_SUBMITTED, &peer_req->i.flags);
+	spin_unlock_irq(&device->interval_lock);
 
-	mutex_unlock(&connection->resource->conf_update);
-	synchronize_rcu();
-	if (new_net_conf)
-		kfree(old_net_conf);
-	kfree(old_disk_conf);
-	kfree(old_plan);
+	/* The connection dagtag may only be set after inserting the interval
+	 * into the tree, so that requests that were waiting for the dagtag
+	 * enter the interval tree after the request with the dagtag itself. */
+	set_connection_dagtag(connection, peer_req->dagtag_sector);
 
+	if (!conflict)
+		submit_peer_request_activity_log(peer_req);
+	/* ldev_ref_transfer: put_ldev in peer_req endio */
 	return 0;
 
-reconnect:
-	if (new_disk_conf) {
-		put_ldev(device);
-		kfree(new_disk_conf);
-	}
-	mutex_unlock(&connection->resource->conf_update);
-	return -EIO;
+out_del_list:
+	spin_lock_irq(&connection->peer_reqs_lock);
+	peer_req->flags &= ~EE_ON_RECV_ORDER;
+	list_del(&peer_req->recv_order);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-disconnect:
-	kfree(new_plan);
-	if (new_disk_conf) {
-		put_ldev(device);
-		kfree(new_disk_conf);
-	}
-	mutex_unlock(&connection->resource->conf_update);
-	/* just for completeness: actually not needed,
-	 * as this is not reached if csums_tfm was ok. */
-	crypto_free_shash(csums_tfm);
-	/* but free the verify_tfm again, if csums_tfm did not work out */
-	crypto_free_shash(verify_tfm);
-	conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-	return -EIO;
-}
+	if (atomic_dec_and_test(&connection->active_ee_cnt))
+		wake_up(&connection->ee_wait);
+	atomic_sub(interval_to_al_extents(&peer_req->i), &device->wait_for_actlog_ecnt);
 
-/* warn if the arguments differ by more than 12.5% */
-static void warn_if_differ_considerably(struct drbd_device *device,
-	const char *s, sector_t a, sector_t b)
-{
-	sector_t d;
-	if (a == 0 || b == 0)
-		return;
-	d = (a > b) ? (a - b) : (b - a);
-	if (d > (a>>3) || d > (b>>3))
-		drbd_warn(device, "Considerable difference in %s: %llus vs. %llus\n", s,
-		     (unsigned long long)a, (unsigned long long)b);
+out:
+	if (peer_req->flags & EE_SEND_WRITE_ACK)
+		dec_unacked(peer_device);
+	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + EV_CLEANUP);
+	put_ldev(device);
+	drbd_free_peer_req(peer_req);
+	return err;
 }
 
-static int receive_sizes(struct drbd_connection *connection, struct packet_info *pi)
+/*
+ * To be called when drbd_submit_peer_request() fails for a peer write request.
+ */
+void drbd_cleanup_after_failed_submit_peer_write(struct drbd_peer_request *peer_req)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_sizes *p = pi->data;
-	struct o_qlim *o = (connection->agreed_features & DRBD_FF_WSAME) ? p->qlim : NULL;
-	enum determine_dev_size dd = DS_UNCHANGED;
-	sector_t p_size, p_usize, p_csize, my_usize;
-	sector_t new_size, cur_size;
-	int ldsc = 0; /* local disk size changed */
-	enum dds_flags ddsf;
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return config_unknown_volume(connection, pi);
-	device = peer_device->device;
-	cur_size = get_capacity(device->vdisk);
+	drbd_err_ratelimit(peer_device, "submit failed, triggering re-connect\n");
 
-	p_size = be64_to_cpu(p->d_size);
-	p_usize = be64_to_cpu(p->u_size);
-	p_csize = be64_to_cpu(p->c_size);
+	if (peer_req->flags & EE_IN_ACTLOG)
+		drbd_al_complete_io(device, &peer_req->i);
 
-	/* just store the peer's disk size for now.
-	 * we still need to figure out whether we accept that. */
-	device->p_size = p_size;
+	drbd_remove_peer_req_interval(peer_req);
 
-	if (get_ldev(device)) {
-		rcu_read_lock();
-		my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
-		rcu_read_unlock();
+	drbd_may_finish_epoch(connection, peer_req->epoch, EV_PUT + EV_CLEANUP);
+	put_ldev(device);
+	drbd_free_peer_req(peer_req);
+	change_cstate(connection, C_PROTOCOL_ERROR, CS_HARD);
+}
 
-		warn_if_differ_considerably(device, "lower level device sizes",
-			   p_size, drbd_get_max_capacity(device->ldev));
-		warn_if_differ_considerably(device, "user requested size",
-					    p_usize, my_usize);
+/* Possibly "cancel" and forget about all peer_requests that had still been
+ * waiting for the activity log (wfa) when the connection to their peer failed,
+ * and pretend we never received them.
+ */
+void drbd_cleanup_peer_requests_wfa(struct drbd_device *device, struct list_head *cleanup)
+{
+	struct drbd_connection *connection;
+	struct drbd_peer_request *peer_req, *pr_tmp;
+
+	write_lock_irq(&device->resource->state_rwlock);
+	list_for_each_entry(peer_req, cleanup, w.list) {
+		atomic_dec(&peer_req->peer_device->connection->active_ee_cnt);
+		drbd_remove_peer_req_interval(peer_req);
+	}
+	write_unlock_irq(&device->resource->state_rwlock);
+
+	list_for_each_entry_safe(peer_req, pr_tmp, cleanup, w.list) {
+		atomic_sub(interval_to_al_extents(&peer_req->i), &device->wait_for_actlog_ecnt);
+		atomic_dec(&device->wait_for_actlog);
+		if (peer_req->flags & EE_SEND_WRITE_ACK)
+			dec_unacked(peer_req->peer_device);
+		list_del_init(&peer_req->w.list);
+		drbd_may_finish_epoch(peer_req->peer_device->connection, peer_req->epoch, EV_PUT | EV_CLEANUP);
+		drbd_free_peer_req(peer_req);
+		put_ldev(device);
+	}
+	/*
+	 * We changed (likely: cleared) active_ee_cnt for "at least one" connection.
+	 * We should wake potential waiters, just in case.
+	 */
+	for_each_connection(connection, device->resource)
+		wake_up(&connection->ee_wait);
+}
 
-		/* if this is the first connect, or an otherwise expected
-		 * param exchange, choose the minimum */
-		if (device->state.conn == C_WF_REPORT_PARAMS)
-			p_usize = min_not_zero(my_usize, p_usize);
+/* We may throttle resync, if the lower device seems to be busy,
+ * and current sync rate is above c_min_rate.
+ *
+ * To decide whether or not the lower device is busy, we use a scheme similar
+ * to MD RAID is_mddev_idle(): if the partition stats reveal "significant"
+ * (more than 64 sectors) of activity we cannot account for with our own resync
+ * activity, it obviously is "busy". Both terms count what the backing device
+ * has completed, so resync IO in flight does not hide application IO.
+ *
+ * The current sync rate used here uses only the most recent two step marks,
+ * to have a short time average so we can react faster.
+ */
+bool drbd_rs_c_min_rate_throttle(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
+	unsigned long dt, dbdt;
+	long db;
+	unsigned int c_min_rate;
+	int curr_events;
 
-		/* Never shrink a device with usable data during connect,
-		 * or "attach" on the peer.
-		 * But allow online shrinking if we are connected. */
-		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
-		if (new_size < cur_size &&
-		    device->state.disk >= D_OUTDATED &&
-		    (device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS)) {
-			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
-					(unsigned long long)new_size, (unsigned long long)cur_size);
-			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-			put_ldev(device);
-			return -EIO;
-		}
+	rcu_read_lock();
+	c_min_rate = rcu_dereference(peer_device->conf)->c_min_rate;
+	rcu_read_unlock();
 
-		if (my_usize != p_usize) {
-			struct disk_conf *old_disk_conf, *new_disk_conf = NULL;
+	/* feature disabled? */
+	if (c_min_rate == 0)
+		return false;
 
-			new_disk_conf = kzalloc_obj(struct disk_conf);
-			if (!new_disk_conf) {
-				put_ldev(device);
-				return -ENOMEM;
-			}
+	curr_events = (int)part_stat_read_accum(disk->part0, sectors)
+		- atomic_read(&device->rs_sect_done);
 
-			mutex_lock(&connection->resource->conf_update);
-			old_disk_conf = device->ldev->disk_conf;
-			*new_disk_conf = *old_disk_conf;
-			new_disk_conf->disk_size = p_usize;
+	if (atomic_read(&device->ap_actlog_cnt) || curr_events - peer_device->rs_last_events > 64) {
+		unsigned long rs_left;
+		int i;
 
-			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
-			mutex_unlock(&connection->resource->conf_update);
-			kvfree_rcu_mightsleep(old_disk_conf);
+		peer_device->rs_last_events = curr_events;
 
-			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
-				 (unsigned long)p_usize, (unsigned long)my_usize);
-		}
+		/* sync speed average over the last 2*DRBD_SYNC_MARK_STEP,
+		 * approx. */
+		i = (peer_device->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
 
-		put_ldev(device);
-	}
+		if (peer_device->repl_state[NOW] == L_VERIFY_S || peer_device->repl_state[NOW] == L_VERIFY_T)
+			rs_left = atomic64_read(&peer_device->ov_left);
+		else
+			rs_left = drbd_bm_total_weight(peer_device) - peer_device->rs_failed;
 
-	device->peer_max_bio_size = be32_to_cpu(p->max_bio_size);
-	/* Leave drbd_reconsider_queue_parameters() before drbd_determine_dev_size().
-	   In case we cleared the QUEUE_FLAG_DISCARD from our queue in
-	   drbd_reconsider_queue_parameters(), we can be sure that after
-	   drbd_determine_dev_size() no REQ_DISCARDs are in the queue. */
+		dt = ((long)jiffies - (long)peer_device->rs_mark_time[i]) / HZ;
+		if (!dt)
+			dt++;
 
-	ddsf = be16_to_cpu(p->dds_flags);
-	if (get_ldev(device)) {
-		drbd_reconsider_queue_parameters(device, device->ldev, o);
-		dd = drbd_determine_dev_size(device, ddsf, NULL);
-		put_ldev(device);
-		if (dd == DS_ERROR)
-			return -EIO;
-		drbd_md_sync(device);
-	} else {
-		/*
-		 * I am diskless, need to accept the peer's *current* size.
-		 * I must NOT accept the peers backing disk size,
-		 * it may have been larger than mine all along...
-		 *
-		 * At this point, the peer knows more about my disk, or at
-		 * least about what we last agreed upon, than myself.
-		 * So if his c_size is less than his d_size, the most likely
-		 * reason is that *my* d_size was smaller last time we checked.
-		 *
-		 * However, if he sends a zero current size,
-		 * take his (user-capped or) backing disk size anyways.
-		 *
-		 * Unless of course he does not have a disk himself.
-		 * In which case we ignore this completely.
+		/* db is signed: the out-of-sync count grows (db < 0) when the
+		 * resync is losing ground to incoming application writes. Doing
+		 * this subtraction unsigned would wrap to a huge value, making
+		 * dbdt exceed c_min_rate and wrongly throttle the resync exactly
+		 * when it is starved. If oos is not shrinking, the resync makes
+		 * no forward progress, i.e. it is below any minimum rate, so we
+		 * must not slow it down here.
 		 */
-		sector_t new_size = p_csize ?: p_usize ?: p_size;
-		drbd_reconsider_queue_parameters(device, NULL, o);
-		if (new_size == 0) {
-			/* Ignore, peer does not know nothing. */
-		} else if (new_size == cur_size) {
-			/* nothing to do */
-		} else if (cur_size != 0 && p_size == 0) {
-			drbd_warn(device, "Ignored diskless peer device size (peer:%llu != me:%llu sectors)!\n",
-					(unsigned long long)new_size, (unsigned long long)cur_size);
-		} else if (new_size < cur_size && device->state.role == R_PRIMARY) {
-			drbd_err(device, "The peer's device size is too small! (%llu < %llu sectors); demote me first!\n",
-					(unsigned long long)new_size, (unsigned long long)cur_size);
-			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-			return -EIO;
+		db = (long)peer_device->rs_mark_left[i] - (long)rs_left;
+		if (db <= 0)
+			return false;
+		dbdt = device_bit_to_kb(device, db / dt);
+
+		if (dbdt > c_min_rate)
+			return true;
+	}
+	return false;
+}
+
+void drbd_verify_skipped_block(struct drbd_peer_device *peer_device,
+		const sector_t sector, const unsigned int size)
+{
+	++peer_device->ov_skipped;
+	if (peer_device->ov_last_skipped_start + peer_device->ov_last_skipped_size == sector) {
+		peer_device->ov_last_skipped_size += size>>9;
+	} else {
+		ov_skipped_print(peer_device);
+		peer_device->ov_last_skipped_start = sector;
+		peer_device->ov_last_skipped_size = size>>9;
+	}
+}
+
+static void drbd_cleanup_peer_read(
+		struct drbd_peer_request *peer_req, bool in_interval_tree)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+
+	if (in_interval_tree)
+		drbd_remove_peer_req_interval(peer_req);
+
+	dec_unacked(peer_device);
+
+	drbd_free_peer_req(peer_req);
+	put_ldev(device);
+
+	if (atomic_dec_and_test(&connection->backing_ee_cnt))
+		wake_up(&connection->ee_wait);
+}
+
+void drbd_conflict_submit_peer_read(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
+	bool submit = true;
+	bool interval_tree = false;
+	bool canceled = false;
+	bool too_deep = false;
+
+	/* Hold resync reads until conflicts have cleared so that we know which
+	 * bitmap bits we can safely clear. Also add verify requests on the
+	 * target to the interval tree so that conflicts can be detected.
+	 * Verify requests on the source have already been added. */
+	if (drbd_interval_is_resync(&peer_req->i) || peer_req->i.type == INTERVAL_OV_READ_TARGET) {
+		bool conflict = false;
+
+		interval_tree = true;
+		spin_lock_irq(&device->interval_lock);
+		clear_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags);
+		canceled = test_bit(INTERVAL_CANCELED, &peer_req->i.flags);
+		conflict = drbd_find_conflict(device, &peer_req->i, 0);
+		if (drbd_interval_empty(&peer_req->i)) {
+			if (conflict)
+				set_bit(INTERVAL_CONFLICT, &peer_req->i.flags);
+			drbd_insert_interval(&device->requests, &peer_req->i);
+		}
+		too_deep = !conflict && !canceled &&
+			drbd_interval_is_resync(&peer_req->i) &&
+			!test_bit(INTERVAL_APP_WAITS, &peer_req->i.flags) &&
+			drbd_rs_depth_exceeded(peer_device);
+		if (canceled) {
+			submit = false;
+		} else if (too_deep) {
+			set_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags);
+			submit = false;
+		} else if (!conflict || drbd_interval_is_verify(&peer_req->i)) {
+			set_bit(INTERVAL_SUBMITTED, &peer_req->i.flags);
 		} else {
-			/* I believe the peer, if
-			 *  - I don't have a current size myself
-			 *  - we agree on the size anyways
-			 *  - I do have a current size, am Secondary,
-			 *    and he has the only disk
-			 *  - I do have a current size, am Primary,
-			 *    and he has the only disk,
-			 *    which is larger than my current size
-			 */
-			drbd_set_my_capacity(device, new_size);
+			submit = false;
 		}
+		spin_unlock_irq(&device->interval_lock);
 	}
 
-	if (get_ldev(device)) {
-		if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev)) {
-			device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
-			ldsc = 1;
-		}
+	if (too_deep) {
+		/* The read this node serves queues at its own backing device,
+		 * where its application's IO queues behind it. Wait for that
+		 * queue on the conflict submitter's list, not in the receiver:
+		 * when the sync target is Primary, its replicated writes arrive
+		 * on the same stream as these requests.
+		 */
+		spin_lock_irq(&submit_conflict->lock);
+		list_add_tail(&peer_req->w.list, &submit_conflict->resync_reads);
+		spin_unlock_irq(&submit_conflict->lock);
 
-		put_ldev(device);
+		smp_mb(); /* list_add vs. re-check; see drbd_rs_depth_completed() */
+		if (!drbd_rs_depth_exceeded(peer_device))
+			queue_work(submit_conflict->wq, &submit_conflict->worker);
+		return;
 	}
 
-	if (device->state.conn > C_WF_REPORT_PARAMS) {
-		if (be64_to_cpu(p->c_size) != get_capacity(device->vdisk) ||
-		    ldsc) {
-			/* we have different sizes, probably peer
-			 * needs to know my new size... */
-			drbd_send_sizes(peer_device, 0, ddsf);
-		}
-		if (test_and_clear_bit(RESIZE_PENDING, &device->flags) ||
-		    (dd == DS_GREW && device->state.conn == C_CONNECTED)) {
-			if (device->state.pdsk >= D_INCONSISTENT &&
-			    device->state.disk >= D_INCONSISTENT) {
-				if (ddsf & DDSF_NO_RESYNC)
-					drbd_info(device, "Resync of new storage suppressed with --assume-clean\n");
-				else
-					resync_after_online_grow(device);
-			} else
-				set_bit(RESYNC_AFTER_NEG, &device->flags);
+	/* Wait if there are conflicts unless this is a verify request, in
+	 * which case we submit it anyway but skip the block if it conflicted. */
+	if (submit) {
+		unsigned int size = drbd_interval_is_resync(&peer_req->i) ? peer_req->i.size : 0;
+		int err;
+
+		drbd_rs_depth_queued(device, size >> 9);
+		err = drbd_submit_peer_request(peer_req);
+		if (err) {
+			atomic_sub(size >> 9, &device->rs_sect_queued);
+			if (drbd_ratelimit())
+				drbd_err(peer_device, "submit failed, triggering re-connect\n");
+
+			drbd_cleanup_peer_read(peer_req, interval_tree);
+			change_cstate(peer_device->connection, C_PROTOCOL_ERROR, CS_HARD);
 		}
+	} else if (canceled) {
+		drbd_cleanup_peer_read(peer_req, interval_tree);
 	}
-
-	return 0;
 }
 
-static int receive_uuids(struct drbd_connection *connection, struct packet_info *pi)
+enum dagtag_reach {
+	DAGTAG_REACHED,		/* the depended-on write stream got here */
+	DAGTAG_WAITING,		/* not yet, but the peer that feeds it is connected */
+	DAGTAG_UNREACHABLE,	/* that peer is gone; the position can not be reached */
+};
+
+static enum dagtag_reach dagtag_reach(struct drbd_resource *resource,
+				      unsigned int node_id, u64 dagtag)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_uuids *p = pi->data;
-	u64 *p_uuid;
-	int i, updated_uuids = 0;
+	struct drbd_connection *connection;
+	enum dagtag_reach reach = DAGTAG_UNREACHABLE;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return config_unknown_volume(connection, pi);
-	device = peer_device->device;
+	rcu_read_lock();
+	connection = drbd_connection_by_node_id(resource, node_id);
+	if (connection && connection->cstate[NOW] == C_CONNECTED &&
+	    !test_bit(DAGTAG_STREAM_GONE, &connection->flags))
+		reach = atomic64_read(&connection->last_dagtag_sector) < dagtag ?
+			DAGTAG_WAITING : DAGTAG_REACHED;
+	rcu_read_unlock();
 
-	p_uuid = kmalloc_objs(*p_uuid, UI_EXTENDED_SIZE, GFP_NOIO);
-	if (!p_uuid)
-		return false;
+	return reach;
+}
 
-	for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
-		p_uuid[i] = be64_to_cpu(p->uuid[i]);
+static enum dagtag_reach dagtag_dependency_reach(struct drbd_peer_request *peer_req)
+{
+	struct drbd_device *device = peer_req->peer_device->device;
 
-	kfree(device->p_uuid);
-	device->p_uuid = p_uuid;
+	return dagtag_reach(device->resource, peer_req->depend_dagtag_node_id,
+			    peer_req->depend_dagtag);
+}
 
-	if ((device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS) &&
-	    device->state.disk < D_INCONSISTENT &&
-	    device->state.role == R_PRIMARY &&
-	    (device->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {
-		drbd_err(device, "Can only connect to data with current UUID=%016llX\n",
-		    (unsigned long long)device->ed_uuid);
-		conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-		return -EIO;
+static void drbd_peer_resync_read_cancel(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	sector_t sector = peer_req->i.sector;
+	int size = peer_req->i.size;
+	u64 block_id = peer_req->block_id;
+
+	if (peer_req->i.type == INTERVAL_OV_READ_SOURCE) {
+		/* P_OV_REPLY.
+		 * rs_pending was already decremented in
+		 * receive_common_ov_reply() before the peer_req reached
+		 * either of the two paths that call us; do not decrement
+		 * again.
+		 */
+		drbd_send_ov_result(peer_device, sector, size, block_id, OV_RESULT_SKIP);
+	} else if (peer_req->i.type == INTERVAL_OV_READ_TARGET) {
+		/* P_OV_REQUEST */
+		drbd_verify_skipped_block(peer_device, sector, size);
+		verify_progress(peer_device, sector, size);
+		drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, block_id);
+	} else {
+		/* P_RS_DATA_REQUEST etc */
+		drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, block_id);
 	}
-
-	if (get_ldev(device)) {
-		int skip_initial_sync =
-			device->state.conn == C_CONNECTED &&
-			peer_device->connection->agreed_pro_version >= 90 &&
-			device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED &&
-			(p_uuid[UI_FLAGS] & 8);
-		if (skip_initial_sync) {
-			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
-			drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
-					"clear_n_write from receive_uuids",
-					BM_LOCKED_TEST_ALLOWED, NULL);
-			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
-			_drbd_uuid_set(device, UI_BITMAP, 0);
-			spin_lock_irq(&device->resource->req_lock);
-			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
-					CS_VERBOSE, NULL);
-			spin_unlock_irq(&device->resource->req_lock);
-			drbd_md_sync(device);
-			updated_uuids = 1;
-		}
-		put_ldev(device);
-	} else if (device->state.disk < D_INCONSISTENT &&
-		   device->state.role == R_PRIMARY) {
-		/* I am a diskless primary, the peer just created a new current UUID
-		   for me. */
-		updated_uuids = drbd_set_ed_uuid(device, p_uuid[UI_CURRENT]);
-	}
-
-	/* Before we test for the disk state, we should wait until an eventually
-	   ongoing cluster wide state change is finished. That is important if
-	   we are primary and are detaching from our disk. We need to see the
-	   new disk state... */
-	mutex_lock(device->state_mutex);
-	mutex_unlock(device->state_mutex);
-	if (device->state.conn >= C_CONNECTED && device->state.disk < D_INCONSISTENT)
-		updated_uuids |= drbd_set_ed_uuid(device, p_uuid[UI_CURRENT]);
-
-	if (updated_uuids)
-		drbd_print_uuids(device, "receiver updated UUIDs to");
-
-	return 0;
 }
 
-/**
- * convert_state() - Converts the peer's view of the cluster state to our point of view
- * @ps:		The state as seen by the peer.
+/* The peer that feeds the depended-on write stream is gone, so the requested
+ * position can never be reached. Reading the local disk would answer with data
+ * that is older than what the requester holds itself.
+ *
+ * A verify request is cancelled the same way a request already parked for
+ * that dagtag is cancelled when the connection to that peer goes down: the
+ * requester skips the block and the verify goes on.
+ *
+ * A resync request from a target that agreed DRBD_FF_WRITE_POSTPONE is
+ * answered P_RS_DAGTAG_UNREACHABLE without data: the target knows which of
+ * its writes the requested range still has to secure, refuses them towards
+ * their writer, and asks again without the dependency, or ends the resync
+ * when it can not secure the range. Any other target gets the request
+ * answered as failed (P_NEG_RS_DREPLY): it records the block as failed and
+ * moves on, so it does not ask for the same bitmap bit again, and its
+ * resync ends with the disk left Inconsistent instead of a copy that lost an
+ * acknowledged write. This node's own state is not touched; the requester
+ * ends the exchange, as it does for a block this node could not read.
  */
-static union drbd_state convert_state(union drbd_state ps)
+static void drbd_cancel_unreachable_dagtag_request(struct drbd_peer_request *peer_req)
 {
-	union drbd_state ms;
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	unsigned int node_id = peer_req->depend_dagtag_node_id;
+
+	if (drbd_interval_is_verify(&peer_req->i)) {
+		drbd_peer_resync_read_cancel(peer_req);
+	} else if (peer_device->connection->agreed_features & DRBD_FF_WRITE_POSTPONE) {
+		dynamic_drbd_dbg(peer_device,
+				 "Not connected to node %u, resync request at %llus+%u depends on it\n",
+				 node_id, (unsigned long long)peer_req->i.sector,
+				 peer_req->i.size);
+		drbd_send_ack_be(peer_device, P_RS_DAGTAG_UNREACHABLE, peer_req->i.sector,
+				 peer_req->i.size, peer_req->block_id);
+	} else {
+		drbd_info_ratelimit(peer_device,
+				    "Not connected to node %u, can not serve resync request at %llus+%u\n",
+				    node_id, (unsigned long long)peer_req->i.sector,
+				    peer_req->i.size);
+		drbd_send_ack_be(peer_device, P_NEG_RS_DREPLY, peer_req->i.sector,
+				 peer_req->i.size, peer_req->block_id);
+	}
+	if (peer_req->i.type == INTERVAL_OV_READ_SOURCE)
+		drbd_remove_peer_req_interval(peer_req);
+	drbd_free_peer_req(peer_req);
+	dec_unacked(peer_device);
+	put_ldev(device);
+}
 
-	static enum drbd_conns c_tab[] = {
-		[C_WF_REPORT_PARAMS] = C_WF_REPORT_PARAMS,
-		[C_CONNECTED] = C_CONNECTED,
+static void drbd_peer_resync_read(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	unsigned int size = peer_req->i.size;
 
-		[C_STARTING_SYNC_S] = C_STARTING_SYNC_T,
-		[C_STARTING_SYNC_T] = C_STARTING_SYNC_S,
-		[C_DISCONNECTING] = C_TEAR_DOWN, /* C_NETWORK_FAILURE, */
-		[C_VERIFY_S]       = C_VERIFY_T,
-		[C_MASK]   = C_MASK,
-	};
+	if (connection->peer_role[NOW] != R_PRIMARY &&
+			drbd_rs_c_min_rate_throttle(peer_device))
+		schedule_timeout_uninterruptible(HZ/10);
 
-	ms.i = ps.i;
+	/* dagtag 0 means that there is no dependency to be fulfilled,
+	 * so we can ignore it.
+	 * If we are the dependent node, we can also ignore the dagtag
+	 * dependency, because the request with this dagtag must already be in
+	 * the interval tree, so the read will wait until the interval tree
+	 * conflict is resolved before being submitted. */
+	if (peer_req->depend_dagtag &&
+	    peer_req->depend_dagtag_node_id != device->resource->res_opts.node_id) {
+		enum dagtag_reach reach = dagtag_dependency_reach(peer_req);
+
+		if (reach == DAGTAG_WAITING) {
+			dynamic_drbd_dbg(peer_device,
+					 "%s at %llus+%u: Waiting for dagtag %llus from peer %u\n",
+					 drbd_interval_type_str(&peer_req->i),
+					 (unsigned long long)peer_req->i.sector, size,
+					 (unsigned long long)peer_req->depend_dagtag,
+					 peer_req->depend_dagtag_node_id);
+			/* cancel_dagtag_dependent_requests() empties this list
+			 * under this lock once the depended-on stream is torn
+			 * down, and it marks that stream before it walks. Take
+			 * the decision again here, so a request either lands
+			 * before the walk or is never parked at all.
+			 */
+			spin_lock_irq(&connection->peer_reqs_lock);
+			reach = dagtag_dependency_reach(peer_req);
+			if (reach == DAGTAG_WAITING)
+				list_add_tail(&peer_req->w.list, &connection->dagtag_wait_ee);
+			spin_unlock_irq(&connection->peer_reqs_lock);
+			if (reach == DAGTAG_WAITING)
+				return;
+		}
 
-	ms.conn = c_tab[ps.conn];
-	ms.peer = ps.role;
-	ms.role = ps.peer;
-	ms.pdsk = ps.disk;
-	ms.disk = ps.pdsk;
-	ms.peer_isp = (ps.aftr_isp | ps.user_isp);
+		if (reach == DAGTAG_UNREACHABLE) {
+			drbd_cancel_unreachable_dagtag_request(peer_req);
+			return;
+		}
+	}
 
-	return ms;
+	atomic_inc(&connection->backing_ee_cnt);
+	drbd_conflict_submit_peer_read(peer_req);
 }
 
-static int receive_req_state(struct drbd_connection *connection, struct packet_info *pi)
+/* A sync target has a write that this node, the sync source, may be about to
+ * overwrite from its own disk. Answer once this node has that write too,
+ * which it does as soon as the stream it belongs to has reached the position
+ * the requester names.
+ */
+static int receive_rs_dagtag_wait_req(struct drbd_connection *connection, struct packet_info *pi)
 {
+	struct p_rs_req *p = pi->data;
 	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_req_state *p = pi->data;
-	union drbd_state mask, val;
-	enum drbd_state_rv rv;
+	sector_t sector = be64_to_cpu(p->req_common.sector);
+	unsigned int size = be32_to_cpu(p->req_common.blksize);
+	unsigned int node_id = be32_to_cpu(p->dagtag_node_id);
+	u64 dagtag = be64_to_cpu(p->dagtag);
+	enum dagtag_reach reach;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
-	device = peer_device->device;
 
-	mask.i = be32_to_cpu(p->mask);
-	val.i = be32_to_cpu(p->val);
+	reach = dagtag_reach(connection->resource, node_id, dagtag);
+	if (reach == DAGTAG_WAITING)
+		return queue_dagtag_wait_req(peer_device, sector, size,
+					     p->req_common.block_id, node_id, dagtag);
 
-	if (test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags) &&
-	    mutex_is_locked(device->state_mutex)) {
-		drbd_send_sr_reply(peer_device, SS_CONCURRENT_ST_CHG);
-		return 0;
+	if (reach == DAGTAG_UNREACHABLE) {
+		dynamic_drbd_dbg(peer_device,
+				 "Dagtag wait request at %llus+%u: can not reach dagtag %llus of node %u\n",
+				 (unsigned long long)sector, size,
+				 (unsigned long long)dagtag, node_id);
+		return drbd_send_ack_be(peer_device, P_RS_DAGTAG_UNREACHABLE,
+					sector, size, p->req_common.block_id);
 	}
 
-	mask = convert_state(mask);
-	val = convert_state(val);
-
-	rv = drbd_change_state(device, CS_VERBOSE, mask, val);
-	drbd_send_sr_reply(peer_device, rv);
-
-	drbd_md_sync(device);
-
-	return 0;
+	return drbd_send_ack_be(peer_device, P_RS_DAGTAG_REACHED, sector, size,
+				p->req_common.block_id);
 }
 
-static int receive_req_conn_state(struct drbd_connection *connection, struct packet_info *pi)
+static int receive_digest(struct drbd_peer_request *peer_req, int digest_size)
 {
-	struct p_req_state *p = pi->data;
-	union drbd_state mask, val;
-	enum drbd_state_rv rv;
-
-	mask.i = be32_to_cpu(p->mask);
-	val.i = be32_to_cpu(p->val);
+	struct digest_info *di = NULL;
 
-	if (test_bit(RESOLVE_CONFLICTS, &connection->flags) &&
-	    mutex_is_locked(&connection->cstate_mutex)) {
-		conn_send_sr_reply(connection, SS_CONCURRENT_ST_CHG);
-		return 0;
+	if (digest_size < 0) {
+		drbd_err(peer_req->peer_device, "Invalid digest size\n");
+		return -EIO;
 	}
 
-	mask = convert_state(mask);
-	val = convert_state(val);
+	di = kmalloc(sizeof(*di) + digest_size, GFP_NOIO);
+	if (!di)
+		return -ENOMEM;
 
-	rv = conn_request_state(connection, mask, val, CS_VERBOSE | CS_LOCAL_ONLY | CS_IGN_OUTD_FAIL);
-	conn_send_sr_reply(connection, rv);
+	di->digest_size = digest_size;
+	di->digest = (((char *)di)+sizeof(struct digest_info));
 
-	return 0;
+	peer_req->digest = di;
+	peer_req->flags |= EE_HAS_DIGEST;
+
+	return drbd_recv_into(peer_req->peer_device->connection, di->digest, digest_size);
 }
 
-static int receive_state(struct drbd_connection *connection, struct packet_info *pi)
+static int receive_common_data_request(struct drbd_connection *connection, struct packet_info *pi,
+		struct p_block_req_common *p,
+		unsigned int depend_dagtag_node_id, u64 depend_dagtag)
 {
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
-	struct p_state *p = pi->data;
-	union drbd_state os, ns, peer_state;
-	enum drbd_disk_state real_peer_disk;
-	enum chg_state_flags cs_flags;
-	int rv;
+	sector_t sector = be64_to_cpu(p->sector);
+	sector_t capacity;
+	struct drbd_peer_request *peer_req;
+	int size = be32_to_cpu(p->blksize);
+	enum drbd_disk_state min_d_state;
+	int err;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
-		return config_unknown_volume(connection, pi);
+		return -EIO;
 	device = peer_device->device;
+	capacity = get_capacity(device->vdisk);
 
-	peer_state.i = be32_to_cpu(p->state);
-
-	real_peer_disk = peer_state.disk;
-	if (peer_state.disk == D_NEGOTIATING) {
-		real_peer_disk = device->p_uuid[UI_FLAGS] & 4 ? D_INCONSISTENT : D_CONSISTENT;
-		drbd_info(device, "real peer disk state = %s\n", drbd_disk_str(real_peer_disk));
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
+		drbd_err(peer_device, "%s:%d: sector: %llus, size: %u\n", __FILE__, __LINE__,
+				(unsigned long long)sector, size);
+		return -EINVAL;
+	}
+	if (sector + (size>>9) > capacity &&
+	    !in_range_after_size_change(device, sector, size)) {
+		drbd_err(peer_device, "%s:%d: sector: %llus, size: %u\n", __FILE__, __LINE__,
+				(unsigned long long)sector, size);
+		return -EINVAL;
 	}
 
-	spin_lock_irq(&device->resource->req_lock);
- retry:
-	os = ns = drbd_read_state(device);
-	spin_unlock_irq(&device->resource->req_lock);
-
-	/* If some other part of the code (ack_receiver thread, timeout)
-	 * already decided to close the connection again,
-	 * we must not "re-establish" it here. */
-	if (os.conn <= C_TEAR_DOWN)
-		return -ECONNRESET;
-
-	/* If this is the "end of sync" confirmation, usually the peer disk
-	 * transitions from D_INCONSISTENT to D_UP_TO_DATE. For empty (0 bits
-	 * set) resync started in PausedSyncT, or if the timing of pause-/
-	 * unpause-sync events has been "just right", the peer disk may
-	 * transition from D_CONSISTENT to D_UP_TO_DATE as well.
+	/* Tell target to have a retry, waiting for the rescheduled
+	 * drbd_start_resync to complete. Otherwise the concurrency
+	 * of send oos and resync may lead to data loss.
 	 */
-	if ((os.pdsk == D_INCONSISTENT || os.pdsk == D_CONSISTENT) &&
-	    real_peer_disk == D_UP_TO_DATE &&
-	    os.conn > C_CONNECTED && os.disk == D_UP_TO_DATE) {
-		/* If we are (becoming) SyncSource, but peer is still in sync
-		 * preparation, ignore its uptodate-ness to avoid flapping, it
-		 * will change to inconsistent once the peer reaches active
-		 * syncing states.
-		 * It may have changed syncer-paused flags, however, so we
-		 * cannot ignore this completely. */
-		if (peer_state.conn > C_CONNECTED &&
-		    peer_state.conn < C_SYNC_SOURCE)
-			real_peer_disk = D_INCONSISTENT;
-
-		/* if peer_state changes to connected at the same time,
-		 * it explicitly notifies us that it finished resync.
-		 * Maybe we should finish it up, too? */
-		else if (os.conn >= C_SYNC_SOURCE &&
-			 peer_state.conn == C_CONNECTED) {
-			if (drbd_bm_total_weight(device) <= device->rs_failed)
-				drbd_resync_finished(peer_device);
-			return 0;
+	if (peer_device->repl_state[NOW] == L_WF_BITMAP_S ||
+			peer_device->repl_state[NOW] == L_STARTING_SYNC_S) {
+		switch (pi->cmd) {
+		case P_RS_DATA_REQUEST:
+		case P_RS_DAGTAG_REQ:
+		case P_CSUM_RS_REQUEST:
+		case P_RS_CSUM_DAGTAG_REQ:
+		case P_RS_THIN_REQ:
+		case P_RS_THIN_DAGTAG_REQ:
+			drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, p->block_id);
+			return ignore_remaining_packet(connection, pi->size);
+		default:
+			break;
 		}
 	}
 
-	/* explicit verify finished notification, stop sector reached. */
-	if (os.conn == C_VERIFY_T && os.disk == D_UP_TO_DATE &&
-	    peer_state.conn == C_CONNECTED && real_peer_disk == D_UP_TO_DATE) {
-		ov_out_of_sync_print(peer_device);
-		drbd_resync_finished(peer_device);
-		return 0;
-	}
+	min_d_state = pi->cmd == P_DATA_REQUEST ? D_UP_TO_DATE : D_OUTDATED;
+	if (!get_ldev_if_state(device, min_d_state)) {
+		switch (pi->cmd) {
+		case P_DATA_REQUEST:
+			drbd_send_ack_be(peer_device, P_NEG_DREPLY, sector, size, p->block_id);
+			break;
+		case P_OV_REQUEST:
+		case P_OV_DAGTAG_REQ:
+			drbd_verify_skipped_block(peer_device, sector, size);
+			verify_progress(peer_device, sector, size);
+			drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, p->block_id);
+			break;
+		case P_RS_DATA_REQUEST:
+		case P_RS_DAGTAG_REQ:
+		case P_CSUM_RS_REQUEST:
+		case P_RS_CSUM_DAGTAG_REQ:
+		case P_RS_THIN_REQ:
+		case P_RS_THIN_DAGTAG_REQ:
+			if (peer_device->repl_state[NOW] == L_PAUSED_SYNC_S)
+				drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, p->block_id);
+			else
+				drbd_send_ack_be(peer_device, P_NEG_RS_DREPLY, sector, size, p->block_id);
+			break;
+		default:
+			BUG();
+		}
 
-	/* peer says his disk is inconsistent, while we think it is uptodate,
-	 * and this happens while the peer still thinks we have a sync going on,
-	 * but we think we are already done with the sync.
-	 * We ignore this to avoid flapping pdsk.
-	 * This should not happen, if the peer is a recent version of drbd. */
-	if (os.pdsk == D_UP_TO_DATE && real_peer_disk == D_INCONSISTENT &&
-	    os.conn == C_CONNECTED && peer_state.conn > C_SYNC_SOURCE)
-		real_peer_disk = D_UP_TO_DATE;
+		if (peer_device->repl_state[NOW] != L_PAUSED_SYNC_S)
+			drbd_err_ratelimit(device,
+				"Can not satisfy peer's read request, no local data.\n");
 
-	if (ns.conn == C_WF_REPORT_PARAMS)
-		ns.conn = C_CONNECTED;
+		/* drain possible payload */
+		return ignore_remaining_packet(connection, pi->size);
+	}
 
-	if (peer_state.conn == C_AHEAD)
-		ns.conn = C_BEHIND;
+	if (pi->cmd != P_DATA_REQUEST
+	&& !IS_ALIGNED(size, bm_block_size(device->bitmap))
+	&& (sector + (size >> 9) != device->bitmap->bm_dev_capacity)) {
+		drbd_warn_ratelimit(peer_device,
+			"Unaligned %s request (%u vs %u) at %llu; may lead to hung or repeating resync.\n",
+			drbd_packet_name(pi->cmd), size, bm_block_size(device->bitmap), sector);
+		/* For now, try to continue anyways */
+	}
 
-	/* TODO:
-	 * if (primary and diskless and peer uuid != effective uuid)
-	 *     abort attach on peer;
-	 *
-	 * If this node does not have good data, was already connected, but
-	 * the peer did a late attach only now, trying to "negotiate" with me,
-	 * AND I am currently Primary, possibly frozen, with some specific
-	 * "effective" uuid, this should never be reached, really, because
-	 * we first send the uuids, then the current state.
+	/* A sync source whose slot toward this peer still has
+	 * MDF_PEER_DIVERGENCE_BITMAP set:  Defer (retry) the resync request
+	 * until the flag has been cleared.
 	 *
-	 * In this scenario, we already dropped the connection hard
-	 * when we received the unsuitable uuids (receive_uuids().
-	 *
-	 * Should we want to change this, that is: not drop the connection in
-	 * receive_uuids() already, then we would need to add a branch here
-	 * that aborts the attach of "unsuitable uuids" on the peer in case
-	 * this node is currently Diskless Primary.
+	 * Only toward a drbd-9 peer.  A drbd-8.4 sync target treats P_RS_CANCEL
+	 * as "this block is done" instead of rewinding to it, so the block would
+	 * never be resynced.
 	 */
-
-	if (device->p_uuid && peer_state.disk >= D_NEGOTIATING &&
-	    get_ldev_if_state(device, D_NEGOTIATING)) {
-		int cr; /* consider resync */
-
-		/* if we established a new connection */
-		cr  = (os.conn < C_CONNECTED);
-		/* if we had an established connection
-		 * and one of the nodes newly attaches a disk */
-		cr |= (os.conn == C_CONNECTED &&
-		       (peer_state.disk == D_NEGOTIATING ||
-			os.disk == D_NEGOTIATING));
-		/* if we have both been inconsistent, and the peer has been
-		 * forced to be UpToDate with --force */
-		cr |= test_bit(CONSIDER_RESYNC, &device->flags);
-		/* if we had been plain connected, and the admin requested to
-		 * start a sync by "invalidate" or "invalidate-remote" */
-		cr |= (os.conn == C_CONNECTED &&
-				(peer_state.conn >= C_STARTING_SYNC_S &&
-				 peer_state.conn <= C_WF_BITMAP_T));
-
-		if (cr)
-			ns.conn = drbd_sync_handshake(peer_device, peer_state.role, real_peer_disk);
-
-		put_ldev(device);
-		if (ns.conn == C_MASK) {
-			ns.conn = C_CONNECTED;
-			if (device->state.disk == D_NEGOTIATING) {
-				drbd_force_state(device, NS(disk, D_FAILED));
-			} else if (peer_state.disk == D_NEGOTIATING) {
-				drbd_err(device, "Disk attach process on the peer node was aborted.\n");
-				peer_state.disk = D_DISKLESS;
-				real_peer_disk = D_DISKLESS;
-			} else {
-				if (test_and_clear_bit(CONN_DRY_RUN, &peer_device->connection->flags))
-					return -EIO;
-				D_ASSERT(device, os.conn == C_WF_REPORT_PARAMS);
-				conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-				return -EIO;
-			}
+	if (repl_is_sync_source(peer_device->repl_state[NOW]) &&
+	    connection->agreed_pro_version >= 110 &&
+	    test_bit(__MDF_PEER_DIVERGENCE_BITMAP,
+		     &device->ldev->md.peers[peer_device->node_id].flags)) {
+		switch (pi->cmd) {
+		case P_RS_DATA_REQUEST:
+		case P_RS_DAGTAG_REQ:
+		case P_CSUM_RS_REQUEST:
+		case P_RS_CSUM_DAGTAG_REQ:
+		case P_RS_THIN_REQ:
+		case P_RS_THIN_DAGTAG_REQ:
+			drbd_notice_ratelimit(peer_device,
+				"Deferring resync request %llus +%u, divergence bitmap not cleared yet\n",
+				(unsigned long long)sector, size);
+			drbd_send_ack_be(peer_device, P_RS_CANCEL, sector, size, p->block_id);
+			put_ldev(device);
+			return ignore_remaining_packet(connection, pi->size);
+		default:
+			break;
 		}
 	}
 
-	spin_lock_irq(&device->resource->req_lock);
-	if (os.i != drbd_read_state(device).i)
-		goto retry;
-	clear_bit(CONSIDER_RESYNC, &device->flags);
-	ns.peer = peer_state.role;
-	ns.pdsk = real_peer_disk;
-	ns.peer_isp = (peer_state.aftr_isp | peer_state.user_isp);
-	if ((ns.conn == C_CONNECTED || ns.conn == C_WF_BITMAP_S) && ns.disk == D_NEGOTIATING)
-		ns.disk = device->new_state_tmp.disk;
-	cs_flags = CS_VERBOSE + (os.conn < C_CONNECTED && ns.conn >= C_CONNECTED ? 0 : CS_HARD);
-	if (ns.pdsk == D_CONSISTENT && drbd_suspended(device) && ns.conn == C_CONNECTED && os.conn < C_CONNECTED &&
-	    test_bit(NEW_CUR_UUID, &device->flags)) {
-		/* Do not allow tl_restart(RESEND) for a rebooted peer. We can only allow this
-		   for temporal network outages! */
-		spin_unlock_irq(&device->resource->req_lock);
-		drbd_err(device, "Aborting Connect, can not thaw IO with an only Consistent peer\n");
-		tl_clear(peer_device->connection);
-		drbd_uuid_new_current(device);
-		clear_bit(NEW_CUR_UUID, &device->flags);
-		conn_request_state(peer_device->connection, NS2(conn, C_PROTOCOL_ERROR, susp, 0), CS_HARD);
-		return -EIO;
-	}
-	rv = _drbd_set_state(device, ns, cs_flags, NULL);
-	ns = drbd_read_state(device);
-	spin_unlock_irq(&device->resource->req_lock);
+	inc_unacked(peer_device);
 
-	if (rv < SS_SUCCESS) {
-		conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
-		return -EIO;
+	peer_req = drbd_alloc_peer_req(peer_device, GFP_TRY, size, REQ_OP_READ);
+	err = -ENOMEM;
+	if (!peer_req)
+		goto fail;
+	peer_req->i.size = size;
+	peer_req->i.sector = sector;
+	peer_req->block_id = p->block_id;
+	peer_req->depend_dagtag_node_id = depend_dagtag_node_id;
+	peer_req->depend_dagtag = depend_dagtag;
+	/* no longer valid, about to call drbd_recv again for the digest... */
+	p = NULL;
+	pi->data = NULL;
+
+	if (peer_device->repl_state[NOW] == L_AHEAD) {
+		if (pi->cmd == P_DATA_REQUEST) {
+			/* P_DATA_REQUEST originates from a Primary,
+			 * so if I am "Ahead", the Primary would be "Behind":
+			 * Can not happen. */
+			drbd_err_ratelimit(peer_device, "received P_DATA_REQUEST while L_AHEAD\n");
+			err = -EINVAL;
+			goto fail2;
+		}
+		if (connection->agreed_pro_version >= 115) {
+			switch (pi->cmd) {
+			/* case P_DATA_REQUEST: see above, not based on protocol version */
+			case P_OV_REQUEST:
+			case P_OV_DAGTAG_REQ:
+				drbd_verify_skipped_block(peer_device, sector, size);
+				verify_progress(peer_device, sector, size);
+				fallthrough;
+			case P_RS_DATA_REQUEST:
+			case P_RS_DAGTAG_REQ:
+			case P_CSUM_RS_REQUEST:
+			case P_RS_CSUM_DAGTAG_REQ:
+			case P_RS_THIN_REQ:
+			case P_RS_THIN_DAGTAG_REQ:
+				err = drbd_send_ack(peer_device, P_RS_CANCEL_AHEAD, peer_req);
+				goto fail2;
+			default:
+				BUG();
+			}
+		}
 	}
 
-	if (os.conn > C_WF_REPORT_PARAMS) {
-		if (ns.conn > C_CONNECTED && peer_state.conn <= C_CONNECTED &&
-		    peer_state.disk != D_NEGOTIATING ) {
-			/* we want resync, peer has not yet decided to sync... */
-			/* Nowadays only used when forcing a node into primary role and
-			   setting its disk to UpToDate with that */
-			drbd_send_uuids(peer_device);
-			drbd_send_current_state(peer_device);
+	switch (pi->cmd) {
+	case P_DATA_REQUEST:
+		peer_req->w.cb = w_e_end_data_req;
+		peer_req->i.type = INTERVAL_PEER_READ;
+		goto submit;
+
+	case P_RS_THIN_REQ:
+	case P_RS_THIN_DAGTAG_REQ:
+		/* If at some point in the future we have a smart way to
+		   find out if this data block is completely deallocated,
+		   then we would do something smarter here than reading
+		   the block... */
+		peer_req->flags |= EE_RS_THIN_REQ;
+		fallthrough;
+	case P_RS_DATA_REQUEST:
+	case P_RS_DAGTAG_REQ:
+		peer_req->i.type = INTERVAL_RESYNC_READ;
+		peer_req->w.cb = w_e_end_rsdata_req;
+		break;
+
+	case P_CSUM_RS_REQUEST:
+	case P_RS_CSUM_DAGTAG_REQ:
+		D_ASSERT(device, connection->agreed_pro_version >= 89);
+		peer_req->i.type = INTERVAL_RESYNC_READ;
+
+		err = receive_digest(peer_req, pi->size);
+		if (err)
+			goto fail2;
+
+		peer_req->w.cb = w_e_end_rsdata_req;
+		/* remember to report stats in drbd_resync_finished */
+		peer_device->use_csums = true;
+		break;
+
+	case P_OV_REQUEST:
+	case P_OV_DAGTAG_REQ:
+		peer_req->i.type = INTERVAL_OV_READ_TARGET;
+		peer_device->ov_position = sector;
+		if (peer_device->ov_start_sector == ~(sector_t)0 &&
+		    connection->agreed_pro_version >= 90) {
+			unsigned long now = jiffies;
+			int i;
+			unsigned long ov_left = drbd_bm_bits(device)
+					- bm_sect_to_bit(device->bitmap, sector);
+			atomic64_set(&peer_device->ov_left, ov_left);
+			peer_device->ov_start_sector = sector;
+			peer_device->ov_skipped = 0;
+			peer_device->rs_total = ov_left;
+			peer_device->rs_last_writeout = now;
+			peer_device->rs_last_progress_report_ts = now;
+			for (i = 0; i < DRBD_SYNC_MARKS; i++) {
+				peer_device->rs_mark_left[i] = ov_left;
+				peer_device->rs_mark_time[i] = now;
+			}
+			drbd_info(device, "Online Verify start sector: %llu\n",
+					(unsigned long long)sector);
 		}
+		peer_req->w.cb = w_e_end_ov_req;
+		break;
+
+	default:
+		BUG();
 	}
 
-	clear_bit(DISCARD_MY_DATA, &device->flags);
+submit:
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_add_tail(&peer_req->recv_order, &connection->peer_reads);
+	peer_req->flags |= EE_ON_RECV_ORDER;
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	if (pi->cmd == P_DATA_REQUEST) {
+		atomic_inc(&connection->backing_ee_cnt);
+		drbd_conflict_submit_peer_read(peer_req);
+	} else {
+		drbd_peer_resync_read(peer_req);
+	}
+	/* ldev_ref_transfer: put_ldev in peer_req endio */
+	return 0;
+fail2:
+	drbd_free_peer_req(peer_req);
+fail:
+	dec_unacked(peer_device);
+	put_ldev(device);
+	return err;
+}
 
-	drbd_md_sync(device); /* update connected indicator, la_size_sect, ... */
+static int receive_data_request(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_block_req *p_block_req = pi->data;
 
-	return 0;
+	return receive_common_data_request(connection, pi,
+			&p_block_req->req_common,
+			0, 0);
 }
 
-static int receive_sync_uuid(struct drbd_connection *connection, struct packet_info *pi)
+/* receive_dagtag_data_request() - handle a request for data with dagtag
+ * dependency initiated by the peer
+ *
+ * Request handling flow:
+ *
+ * receive_dagtag_data_request
+ *        |
+ *        V
+ * receive_common_data_request
+ *        |
+ *        v              dagtag waiting
+ * drbd_peer_resync_read --------------+
+ *        |                            |
+ *        |                           ... dagtag_wait_ee
+ *        |                            |
+ *        |                            v
+ *        +--------------- release_dagtag_wait
+ *        |
+ *        v                       conflict (resync only)
+ * drbd_conflict_submit_peer_read -----+
+ *        |          ^                 |
+ *        |          |                ...
+ *        |          |                 |
+ *        |          |                 v
+ *        |          +---- drbd_do_submit_conflict
+ *        v
+ * drbd_submit_peer_request
+ *        |
+ *       ... backing device
+ *        |
+ *        v
+ * drbd_peer_request_endio
+ *        |
+ *        v                  online verify request
+ * drbd_endio_read_sec_final ------------------+
+ *        |                                    |
+ *       ... sender_work                      ... sender_work
+ *        |                                    |
+ *        v                                    v
+ * w_e_end_rsdata_req                    w_e_end_ov_req
+ *        |                                    |
+ *       ... via peer                         ... via peer
+ *        |                                    |
+ *        v                                    v
+ * got_RSWriteAck                         got_OVResult
+ */
+static int receive_dagtag_data_request(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_rs_req *p_rs_req = pi->data;
+
+	return receive_common_data_request(connection, pi,
+			&p_rs_req->req_common,
+			be32_to_cpu(p_rs_req->dagtag_node_id), be64_to_cpu(p_rs_req->dagtag));
+}
+
+static int receive_common_ov_reply(struct drbd_connection *connection, struct packet_info *pi,
+		struct p_block_req_common *p,
+		unsigned int depend_dagtag_node_id, u64 depend_dagtag)
 {
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
-	struct p_rs_uuid *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
+	struct drbd_peer_request *peer_req;
+	int size = be32_to_cpu(p->blksize);
+	int err;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
 	device = peer_device->device;
 
-	wait_event(device->misc_wait,
-		   device->state.conn == C_WF_SYNC_UUID ||
-		   device->state.conn == C_BEHIND ||
-		   device->state.conn < C_CONNECTED ||
-		   device->state.disk < D_NEGOTIATING);
-
-	/* D_ASSERT(device,  device->state.conn == C_WF_SYNC_UUID ); */
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_OV_READ_SOURCE),
+			sector, size, p->block_id);
+	if (!peer_req)
+		return -EIO;
 
-	/* Here the _drbd_uuid_ functions are right, current should
-	   _not_ be rotated into the history */
-	if (get_ldev_if_state(device, D_NEGOTIATING)) {
-		_drbd_uuid_set(device, UI_CURRENT, be64_to_cpu(p->uuid));
-		_drbd_uuid_set(device, UI_BITMAP, 0UL);
+	dec_rs_pending(peer_device);
 
-		drbd_print_uuids(device, "updated sync uuid");
-		drbd_start_resync(device, C_SYNC_TARGET);
+	if (!get_ldev_if_state(device, D_OUTDATED)) {
+		drbd_peer_resync_read_cancel(peer_req);
+		drbd_remove_peer_req_interval(peer_req);
+		drbd_free_peer_req(peer_req);
 
-		put_ldev(device);
-	} else
-		drbd_err(device, "Ignoring SyncUUID packet!\n");
+		/* drain payload */
+		return ignore_remaining_packet(connection, pi->size);
+	}
 
-	return 0;
-}
+	err = receive_digest(peer_req, pi->size);
+	if (err)
+		goto fail;
 
-/*
- * receive_bitmap_plain
- *
- * Return 0 when done, 1 when another iteration is needed, and a negative error
- * code upon failure.
- */
-static int
-receive_bitmap_plain(struct drbd_peer_device *peer_device, unsigned int size,
-		     unsigned long *p, struct bm_xfer_ctx *c)
-{
-	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE -
-				 drbd_header_size(peer_device->connection);
-	unsigned int num_words = min_t(size_t, data_size / sizeof(*p),
-				       c->bm_words - c->word_offset);
-	unsigned int want = num_words * sizeof(*p);
-	int err;
+	set_bit(INTERVAL_RECEIVED, &peer_req->i.flags);
 
-	if (want != size) {
-		drbd_err(peer_device, "%s:want (%u) != size (%u)\n", __func__, want, size);
-		return -EIO;
-	}
-	if (want == 0)
-		return 0;
-	err = drbd_recv_all(peer_device->connection, p, want);
+	err = peer_req_alloc_bio(peer_req, size, GFP_NOIO, REQ_OP_READ);
 	if (err)
-		return err;
+		goto fail;
 
-	drbd_bm_merge_lel(peer_device->device, c->word_offset, num_words, p);
+	inc_unacked(peer_device);
 
-	c->word_offset += num_words;
-	c->bit_offset = c->word_offset * BITS_PER_LONG;
-	if (c->bit_offset > c->bm_bits)
-		c->bit_offset = c->bm_bits;
+	peer_req->depend_dagtag_node_id = depend_dagtag_node_id;
+	peer_req->depend_dagtag = depend_dagtag;
+	peer_req->w.cb = w_e_end_ov_reply;
 
-	return 1;
+	/* track progress, we may need to throttle */
+	rs_sectors_came_in(peer_device, size);
+
+	drbd_peer_resync_read(peer_req);
+	/* ldev_ref_transfer: put_ldev in peer_req endio */
+	return 0;
+fail:
+	drbd_remove_peer_req_interval(peer_req);
+	drbd_free_peer_req(peer_req);
+	put_ldev(device);
+	return err;
 }
 
-static enum drbd_bitmap_code dcbp_get_code(struct p_compressed_bm *p)
+static int receive_ov_reply(struct drbd_connection *connection, struct packet_info *pi)
 {
-	return (enum drbd_bitmap_code)(p->encoding & 0x0f);
+	struct p_block_req *p_block_req = pi->data;
+
+	return receive_common_ov_reply(connection, pi,
+			&p_block_req->req_common,
+			0, 0);
 }
 
-static int dcbp_get_start(struct p_compressed_bm *p)
+static int receive_dagtag_ov_reply(struct drbd_connection *connection, struct packet_info *pi)
 {
-	return (p->encoding & 0x80) != 0;
+	struct p_rs_req *p_rs_req = pi->data;
+
+	return receive_common_ov_reply(connection, pi,
+			&p_rs_req->req_common,
+			be32_to_cpu(p_rs_req->dagtag_node_id), be64_to_cpu(p_rs_req->dagtag));
 }
 
-static int dcbp_get_pad_bits(struct p_compressed_bm *p)
+/* Answer a flush round of @initiator_connection on behalf of @primary_node_id */
+static void queue_flush_ack(struct drbd_connection *initiator_connection,
+		int primary_node_id, u64 flush_sequence)
 {
-	return (p->encoding >> 4) & 0x7;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&initiator_connection->flush_ack_lock, irq_flags);
+	initiator_connection->flush_ack_sequence[primary_node_id] = flush_sequence;
+	drbd_queue_work_if_unqueued(&initiator_connection->sender_work,
+			&initiator_connection->flush_ack_work);
+	spin_unlock_irqrestore(&initiator_connection->flush_ack_lock, irq_flags);
 }
 
 /*
- * recv_bm_rle_bits
- *
- * Return 0 when done, 1 when another iteration is needed, and a negative error
- * code upon failure.
+ * No peer acks come from this peer any more, and the out-of-sync bits from
+ * its unacked writes are queued: a flush answer on its behalf may go out.
+ * Not while a connect to it is prepared: that connection may carry writes
+ * from before the Primary's flush point. Caller holds state_rwlock.
  */
-static int
-recv_bm_rle_bits(struct drbd_peer_device *peer_device,
-		struct p_compressed_bm *p,
-		 struct bm_xfer_ctx *c,
-		 unsigned int len)
+static bool flush_ack_on_behalf_allowed(struct drbd_connection *connection)
 {
-	struct bitstream bs;
-	u64 look_ahead;
-	u64 rl;
-	u64 tmp;
-	unsigned long s = c->bit_offset;
-	unsigned long e;
-	int toggle = dcbp_get_start(p);
-	int have;
-	int bits;
+	struct drbd_resource *resource = connection->resource;
+	enum drbd_conn_state cstate = connection->cstate[NOW];
 
-	bitstream_init(&bs, p->code, len, dcbp_get_pad_bits(p));
+	if (cstate != C_STANDALONE && cstate != C_UNCONNECTED && cstate != C_CONNECTING)
+		return false;
 
-	bits = bitstream_get_bits(&bs, &look_ahead, 64);
-	if (bits < 0)
-		return -EIO;
+	return !(resource->remote_state_change && resource->twopc_reply.is_connect &&
+		 drbd_twopc_between_peer_and_me(connection));
+}
 
-	for (have = bits; have > 0; s += rl, toggle = !toggle) {
-		bits = vli_decode_bits(&rl, look_ahead);
-		if (bits <= 0)
-			return -EIO;
+static int receive_flush_requests(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_connection *other_connection;
+	struct p_flush_requests *p_flush_requests = pi->data;
+	u64 flush_requests_dagtag;
+	u64 flush_sequence = be64_to_cpu(p_flush_requests->flush_sequence);
 
-		if (toggle) {
-			e = s + rl -1;
-			if (e >= c->bm_bits) {
-				drbd_err(peer_device, "bitmap overflow (e:%lu) while decoding bm RLE packet\n", e);
-				return -EIO;
-			}
-			_drbd_bm_set_bits(peer_device->device, s, e);
-		}
+	spin_lock_irq(&resource->tl_update_lock);
+	/*
+	 * If the current dagtag was read from the metadata then there is no
+	 * associated request. Hence there is nothing to flush. Flush up to the
+	 * preceding dagtag instead.
+	 */
+	if (resource->dagtag_sector == resource->dagtag_from_backing_dev)
+		flush_requests_dagtag = resource->dagtag_before_attach;
+	else
+		flush_requests_dagtag = resource->dagtag_sector;
+	spin_unlock_irq(&resource->tl_update_lock);
 
-		if (have < bits) {
-			drbd_err(peer_device, "bitmap decoding error: h:%d b:%d la:0x%08llx l:%u/%u\n",
-				have, bits, look_ahead,
-				(unsigned int)(bs.cur.b - p->code),
-				(unsigned int)bs.buf_len);
-			return -EIO;
-		}
-		/* if we consumed all 64 bits, assign 0; >> 64 is "undefined"; */
-		if (likely(bits < 64))
-			look_ahead >>= bits;
-		else
-			look_ahead = 0;
-		have -= bits;
+	spin_lock_irq(&connection->primary_flush_lock);
+	connection->flush_requests_dagtag = flush_requests_dagtag;
+	connection->flush_sequence = flush_sequence;
+	connection->flush_forward_sent_mask = 0;
+	spin_unlock_irq(&connection->primary_flush_lock);
 
-		bits = bitstream_get_bits(&bs, &tmp, 64 - have);
-		if (bits < 0)
-			return -EIO;
-		look_ahead |= tmp << have;
-		have += bits;
+	/* Queue any request waiting for peer ack to be sent */
+	drbd_flush_peer_acks(resource);
+
+	/* For each peer, check if peer ack for this dagtag has already been sent */
+	read_lock_irq(&resource->state_rwlock);
+	rcu_read_lock();
+	for_each_connection_rcu(other_connection, resource) {
+		if (other_connection->cstate[NOW] == C_CONNECTED)
+			queue_work(other_connection->ack_sender, &other_connection->peer_ack_work);
+		else if (flush_ack_on_behalf_allowed(other_connection))
+			queue_flush_ack(connection, other_connection->peer_node_id, flush_sequence);
 	}
+	rcu_read_unlock();
+	read_unlock_irq(&resource->state_rwlock);
 
-	c->bit_offset = s;
-	bm_xfer_ctx_bit_to_word_offset(c);
+	return 0;
+}
+
+static int receive_flush_requests_ack(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_connection *primary_connection;
+	struct p_flush_ack *p_flush_ack = pi->data;
+	u64 flush_sequence = be64_to_cpu(p_flush_ack->flush_sequence);
+	int primary_node_id = be32_to_cpu(p_flush_ack->primary_node_id);
+
+	spin_lock_irq(&resource->initiator_flush_lock);
+	if (flush_sequence < resource->current_flush_sequence) {
+		spin_unlock_irq(&resource->initiator_flush_lock);
+		return 0;
+	}
 
-	return (s != c->bm_bits);
+	rcu_read_lock();
+	primary_connection = drbd_connection_by_node_id(resource, primary_node_id);
+	if (primary_connection)
+		primary_connection->pending_flush_mask &= ~NODE_MASK(connection->peer_node_id);
+	rcu_read_unlock();
+	spin_unlock_irq(&resource->initiator_flush_lock);
+	return 0;
 }
 
 /*
- * decode_bitmap_c
+ * config_unknown_volume  -  device configuration command for unknown volume
  *
- * Return 0 when done, 1 when another iteration is needed, and a negative error
- * code upon failure.
+ * When a device is added to an existing connection, the node on which the
+ * device is added first will send configuration commands to its peer but the
+ * peer will not know about the device yet.  It will warn and ignore these
+ * commands.  Once the device is added on the second node, the second node will
+ * send the same device configuration commands, but in the other direction.
+ *
+ * (We can also end up here if drbd is misconfigured.)
  */
-static int
-decode_bitmap_c(struct drbd_peer_device *peer_device,
-		struct p_compressed_bm *p,
-		struct bm_xfer_ctx *c,
-		unsigned int len)
+static int config_unknown_volume(struct drbd_connection *connection, struct packet_info *pi)
 {
-	if (dcbp_get_code(p) == RLE_VLI_Bits)
-		return recv_bm_rle_bits(peer_device, p, c, len - sizeof(*p));
+	drbd_warn(connection, "%s packet received for volume %d, which is not configured locally\n",
+		  drbd_packet_name(pi->cmd), pi->vnr);
+	return ignore_remaining_packet(connection, pi->size);
+}
 
-	/* other variants had been implemented for evaluation,
-	 * but have been dropped as this one turned out to be "best"
-	 * during all our tests. */
+static int receive_enable_replication_next(struct drbd_connection *connection,
+		struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_enable_replication *p_enable_replication = pi->data;
 
-	drbd_err(peer_device, "receive_bitmap_c: unknown encoding %u\n", p->encoding);
-	conn_request_state(peer_device->connection, NS(conn, C_PROTOCOL_ERROR), CS_HARD);
-	return -EIO;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+
+	assign_bit(REPLICATION_NEXT, peer_device->flags,
+		   p_enable_replication->enable);
+
+	return 0;
 }
 
-void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
-		const char *direction, struct bm_xfer_ctx *c)
+static int receive_enable_replication(struct drbd_connection *connection, struct packet_info *pi)
 {
-	/* what would it take to transfer it "plaintext" */
-	unsigned int header_size = drbd_header_size(peer_device->connection);
-	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE - header_size;
-	unsigned int plain =
-		header_size * (DIV_ROUND_UP(c->bm_words, data_size) + 1) +
-		c->bm_words * sizeof(unsigned long);
-	unsigned int total = c->bytes[0] + c->bytes[1];
-	unsigned int r;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	struct p_enable_replication *p_enable_replication = pi->data;
+	unsigned long irq_flags;
 
-	/* total can not be zero. but just in case: */
-	if (total == 0)
-		return;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	/* don't report if not compressed */
-	if (total >= plain)
-		return;
+	begin_state_change(resource, &irq_flags, CS_VERBOSE);
+	peer_device->replication[NEW] = p_enable_replication->enable;
+	end_state_change(resource, &irq_flags, "enable-replication");
+	return 0;
+}
 
-	/* total < plain. check for overflow, still */
-	r = (total > UINT_MAX/1000) ? (total / (plain/1000))
-		                    : (1000 * total / plain);
+/*
+ * drbd_asb_recover_0p  -  Recover after split-brain with no remaining primaries
+ */
+static enum sync_strategy drbd_asb_recover_0p(struct drbd_peer_device *peer_device)
+{
+	const int node_id = peer_device->device->resource->res_opts.node_id;
+	int self, peer;
+	enum sync_strategy rv = SPLIT_BRAIN_DISCONNECT;
+	unsigned long ch_self, ch_peer;
+	enum drbd_after_sb_p after_sb_0p;
 
-	if (r > 1000)
-		r = 1000;
+	self = drbd_bitmap_uuid(peer_device) & UUID_PRIMARY;
+	peer = peer_device->bitmap_uuids[node_id] & UUID_PRIMARY;
 
-	r = 1000 - r;
-	drbd_info(peer_device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
-	     "total %u; compression: %u.%u%%\n",
-			direction,
-			c->bytes[1], c->packets[1],
-			c->bytes[0], c->packets[0],
-			total, r/10, r % 10);
+	ch_peer = peer_device->dirty_bits;
+	ch_self = peer_device->comm_bm_set;
+
+	rcu_read_lock();
+	after_sb_0p = rcu_dereference(peer_device->connection->transport.net_conf)->after_sb_0p;
+	rcu_read_unlock();
+	switch (after_sb_0p) {
+	case ASB_CONSENSUS:
+	case ASB_DISCARD_SECONDARY:
+	case ASB_CALL_HELPER:
+	case ASB_VIOLENTLY:
+	case ASB_RETRY_CONNECT:
+	case ASB_AUTO_DISCARD:
+		drbd_err(peer_device, "Configuration error.\n");
+		break;
+	case ASB_DISCONNECT:
+		break;
+	case ASB_DISCARD_YOUNGER_PRI:
+		if (self == 0 && peer == 1) {
+			rv = SYNC_TARGET_USE_BITMAP;
+			break;
+		}
+		if (self == 1 && peer == 0) {
+			rv = SYNC_SOURCE_USE_BITMAP;
+			break;
+		}
+		fallthrough;	/* to one of the other strategies */
+	case ASB_DISCARD_OLDER_PRI:
+		if (self == 0 && peer == 1) {
+			rv = SYNC_SOURCE_USE_BITMAP;
+			break;
+		}
+		if (self == 1 && peer == 0) {
+			rv = SYNC_TARGET_USE_BITMAP;
+			break;
+		}
+		drbd_warn(peer_device, "Discard younger/older primary did not find a decision\n"
+			  "Using discard-least-changes instead\n");
+		fallthrough;
+	case ASB_DISCARD_ZERO_CHG:
+		if (ch_peer == 0 && ch_self == 0) {
+			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->transport.flags)
+				? SYNC_TARGET_USE_BITMAP : SYNC_SOURCE_USE_BITMAP;
+			break;
+		} else {
+			if (ch_peer == 0) {
+				rv = SYNC_SOURCE_USE_BITMAP;
+				break;
+			}
+			if (ch_self == 0) {
+				rv = SYNC_TARGET_USE_BITMAP;
+				break;
+			}
+		}
+		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
+			break;
+		fallthrough;
+	case ASB_DISCARD_LEAST_CHG:
+		if	(ch_self < ch_peer)
+			rv = SYNC_TARGET_USE_BITMAP;
+		else if (ch_self > ch_peer)
+			rv = SYNC_SOURCE_USE_BITMAP;
+		else /* ( ch_self == ch_peer ) */
+		     /* Well, then use something else. */
+			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->transport.flags)
+				? SYNC_TARGET_USE_BITMAP : SYNC_SOURCE_USE_BITMAP;
+		break;
+	case ASB_DISCARD_LOCAL:
+		rv = SYNC_TARGET_USE_BITMAP;
+		break;
+	case ASB_DISCARD_REMOTE:
+		rv = SYNC_SOURCE_USE_BITMAP;
+	}
+
+	return rv;
 }
 
-/* Since we are processing the bitfield from lower addresses to higher,
-   it does not matter if the process it in 32 bit chunks or 64 bit
-   chunks as long as it is little endian. (Understand it as byte stream,
-   beginning with the lowest byte...) If we would use big endian
-   we would need to process it from the highest address to the lowest,
-   in order to be agnostic to the 32 vs 64 bits issue.
+/*
+ * drbd_asb_recover_1p  -  Recover after split-brain with one remaining primary
+ */
+static enum sync_strategy drbd_asb_recover_1p(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_resource *resource = device->resource;
+	enum sync_strategy strategy, rv = SPLIT_BRAIN_DISCONNECT;
+	enum drbd_after_sb_p after_sb_1p;
 
-   returns 0 on failure, 1 if we successfully received it. */
-static int receive_bitmap(struct drbd_connection *connection, struct packet_info *pi)
+	rcu_read_lock();
+	after_sb_1p = rcu_dereference(connection->transport.net_conf)->after_sb_1p;
+	rcu_read_unlock();
+	switch (after_sb_1p) {
+	case ASB_DISCARD_YOUNGER_PRI:
+	case ASB_DISCARD_OLDER_PRI:
+	case ASB_DISCARD_LEAST_CHG:
+	case ASB_DISCARD_LOCAL:
+	case ASB_DISCARD_REMOTE:
+	case ASB_DISCARD_ZERO_CHG:
+	case ASB_RETRY_CONNECT:
+	case ASB_AUTO_DISCARD:
+		drbd_err(device, "Configuration error.\n");
+		break;
+	case ASB_DISCONNECT:
+		break;
+	case ASB_CONSENSUS:
+		strategy = drbd_asb_recover_0p(peer_device);
+		if (strategy == SYNC_TARGET_USE_BITMAP && resource->role[NOW] == R_SECONDARY)
+			rv = strategy;
+		if (strategy == SYNC_SOURCE_USE_BITMAP && resource->role[NOW] == R_PRIMARY)
+			rv = strategy;
+		break;
+	case ASB_VIOLENTLY:
+		rv = drbd_asb_recover_0p(peer_device);
+		break;
+	case ASB_DISCARD_SECONDARY:
+		return resource->role[NOW] == R_PRIMARY ? SYNC_SOURCE_USE_BITMAP : SYNC_TARGET_USE_BITMAP;
+	case ASB_CALL_HELPER:
+		strategy = drbd_asb_recover_0p(peer_device);
+		if (strategy == SYNC_TARGET_USE_BITMAP && resource->role[NOW] == R_PRIMARY) {
+			/* Force-demote on the retry-connect path: a role change
+			 * is a cluster-wide two-phase commit, barred here.
+			 */
+			set_bit(CONN_HANDSHAKE_DEMOTE, &connection->flags);
+			rv = RETRY_CONNECT;
+		} else
+			rv = strategy;
+	}
+
+	return rv;
+}
+
+/*
+ * drbd_asb_recover_2p  -  Recover after split-brain with two remaining primaries
+ */
+static enum sync_strategy drbd_asb_recover_2p(struct drbd_peer_device *peer_device)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct bm_xfer_ctx c;
-	int err;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	enum sync_strategy strategy, rv = SPLIT_BRAIN_DISCONNECT;
+	enum drbd_after_sb_p after_sb_2p;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	rcu_read_lock();
+	after_sb_2p = rcu_dereference(connection->transport.net_conf)->after_sb_2p;
+	rcu_read_unlock();
+	switch (after_sb_2p) {
+	case ASB_DISCARD_YOUNGER_PRI:
+	case ASB_DISCARD_OLDER_PRI:
+	case ASB_DISCARD_LEAST_CHG:
+	case ASB_DISCARD_LOCAL:
+	case ASB_DISCARD_REMOTE:
+	case ASB_CONSENSUS:
+	case ASB_DISCARD_SECONDARY:
+	case ASB_DISCARD_ZERO_CHG:
+	case ASB_RETRY_CONNECT:
+	case ASB_AUTO_DISCARD:
+		drbd_err(device, "Configuration error.\n");
+		break;
+	case ASB_VIOLENTLY:
+		rv = drbd_asb_recover_0p(peer_device);
+		break;
+	case ASB_DISCONNECT:
+		break;
+	case ASB_CALL_HELPER:
+		strategy = drbd_asb_recover_0p(peer_device);
+		if (strategy == SYNC_TARGET_USE_BITMAP) {
+			/* Force-demote on the retry-connect path: a role change
+			 * is a cluster-wide two-phase commit, barred here.
+			 */
+			set_bit(CONN_HANDSHAKE_DEMOTE, &connection->flags);
+			rv = RETRY_CONNECT;
+		} else
+			rv = strategy;
+	}
 
-	drbd_bm_lock(device, "receive bitmap", BM_LOCKED_SET_ALLOWED);
-	/* you are supposed to send additional out-of-sync information
-	 * if you actually set bits during this phase */
+	return rv;
+}
 
-	c = (struct bm_xfer_ctx) {
-		.bm_bits = drbd_bm_bits(device),
-		.bm_words = drbd_bm_words(device),
-	};
+static void drbd_uuid_dump_self(struct drbd_peer_device *peer_device, u64 bits, u64 flags)
+{
+	struct drbd_device *device = peer_device->device;
 
-	for(;;) {
-		if (pi->cmd == P_BITMAP)
-			err = receive_bitmap_plain(peer_device, pi->size, pi->data, &c);
-		else if (pi->cmd == P_COMPRESSED_BITMAP) {
-			/* MAYBE: sanity check that we speak proto >= 90,
-			 * and the feature is enabled! */
-			struct p_compressed_bm *p = pi->data;
+	drbd_info(peer_device, "self %016llX:%016llX:%016llX:%016llX bits:%llu flags:%llX\n",
+		  (unsigned long long)drbd_resolved_uuid(peer_device, NULL),
+		  (unsigned long long)drbd_bitmap_uuid(peer_device),
+		  (unsigned long long)drbd_history_uuid(device, 0),
+		  (unsigned long long)drbd_history_uuid(device, 1),
+		  (unsigned long long)bits,
+		  (unsigned long long)flags);
+}
 
-			if (pi->size > DRBD_SOCKET_BUFFER_SIZE - drbd_header_size(connection)) {
-				drbd_err(device, "ReportCBitmap packet too large\n");
-				err = -EIO;
-				goto out;
-			}
-			if (pi->size <= sizeof(*p)) {
-				drbd_err(device, "ReportCBitmap packet too small (l:%u)\n", pi->size);
-				err = -EIO;
-				goto out;
-			}
-			err = drbd_recv_all(peer_device->connection, p, pi->size);
-			if (err)
-			       goto out;
-			err = decode_bitmap_c(peer_device, p, &c, pi->size);
+
+static void drbd_uuid_dump_peer(struct drbd_peer_device *peer_device, u64 bits, u64 flags)
+{
+	const int node_id = peer_device->device->resource->res_opts.node_id;
+
+	drbd_info(peer_device, "peer %016llX:%016llX:%016llX:%016llX bits:%llu flags:%llX\n",
+	     (unsigned long long)peer_device->current_uuid,
+	     (unsigned long long)peer_device->bitmap_uuids[node_id],
+	     (unsigned long long)peer_device->history_uuids[0],
+	     (unsigned long long)peer_device->history_uuids[1],
+	     (unsigned long long)bits,
+	     (unsigned long long)flags);
+}
+
+/* find the peer's bitmap slot for the given UUID, if they have one */
+static int drbd_find_peer_bitmap_by_uuid(struct drbd_peer_device *peer_device, u64 uuid)
+{
+	u64 peer;
+	int i;
+
+	for (i = 0; i < DRBD_PEERS_MAX; i++) {
+		peer = peer_device->bitmap_uuids[i] & ~UUID_PRIMARY;
+		if (uuid == peer)
+			return i;
+	}
+
+	return -1;
+}
+
+/* Find our bitmap slot for the given UUID, if we have one. Prefer a slot whose
+ * bitmap is safe to copy from -- a divergence bitmap -- over a convergence
+ * bitmap being cleared by an ongoing resync. Fall back to a convergence slot so
+ * that callers can still tell "UUID unknown" (-1) from "UUID known but only as
+ * a convergence bitmap"; callers that must copy re-check is_divergence_bitmap()
+ * on the result.
+ *
+ * Of the slots without a bitmap and without a known node, consider only the
+ * day0 slot _drbd_send_uuids110() last sent to this peer, if any. The peer
+ * sees only that one, so a match on another one would be a decision it does
+ * not share. Which slot that is, and whether one is sent at all, can change
+ * between sending and the handshake, so take what was sent.
+ */
+static int drbd_find_bitmap_by_uuid(struct drbd_peer_device *peer_device, u64 uuid)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_peer_md *peer_md = device->ldev->md.peers;
+	int day0 = READ_ONCE(peer_device->comm_day0_node_id);
+	int i, any = -1;
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		if (i == device->ldev->md.node_id)
+			continue;
+		if (connection->agreed_pro_version < 116 &&
+		    peer_md[i].bitmap_index == -1)
+			continue;
+		if (i != day0 && i != peer_device->node_id &&
+		    !test_bit(__MDF_HAVE_BITMAP, &peer_md[i].flags) &&
+		    !test_bit(__MDF_NODE_EXISTS, &peer_md[i].flags))
+			continue;
+		if ((peer_md[i].bitmap_uuid & ~UUID_PRIMARY) != uuid)
+			continue;
+		if (is_divergence_bitmap(&peer_md[i]))
+			return i;
+		if (any == -1)
+			any = i;
+	}
+
+	return any;
+}
+
+static enum sync_strategy
+uuid_fixup_resync_end(struct drbd_peer_device *peer_device, enum sync_rule *rule)
+{
+	struct drbd_device *device = peer_device->device;
+	const int node_id = device->resource->res_opts.node_id;
+
+	if (peer_device->bitmap_uuids[node_id] == (u64)0 && drbd_bitmap_uuid(peer_device) != (u64)0) {
+
+		if (peer_device->connection->agreed_pro_version < 91)
+			return REQUIRES_PROTO_91;
+
+		if ((drbd_bitmap_uuid(peer_device) & ~UUID_PRIMARY) ==
+		    (peer_device->history_uuids[0] & ~UUID_PRIMARY) &&
+		    (drbd_history_uuid(device, 0) & ~UUID_PRIMARY) ==
+		    (peer_device->history_uuids[0] & ~UUID_PRIMARY)) {
+			struct drbd_peer_md *peer_md = &device->ldev->md.peers[peer_device->node_id];
+			u64 previous_bitmap_uuid = peer_md->bitmap_uuid;
+
+			drbd_info(device, "was SyncSource, missed the resync finished event, corrected myself:\n");
+			drbd_set_peer_bitmap_uuid(peer_md, 0, 0);
+			_drbd_uuid_push_history(device, previous_bitmap_uuid);
+
+			drbd_uuid_dump_self(peer_device,
+					    device->disk_state[NOW] >= D_NEGOTIATING ? drbd_bm_total_weight(peer_device) : 0, 0);
+			*rule = RULE_SYNC_SOURCE_MISSED_FINISH;
 		} else {
-			drbd_warn(device, "receive_bitmap: cmd neither ReportBitMap nor ReportCBitMap (is 0x%x)", pi->cmd);
-			err = -EIO;
-			goto out;
+			drbd_info(device, "was SyncSource (peer failed to write sync_uuid)\n");
+			*rule = RULE_SYNC_SOURCE_PEER_MISSED_FINISH;
 		}
 
-		c.packets[pi->cmd == P_BITMAP]++;
-		c.bytes[pi->cmd == P_BITMAP] += drbd_header_size(connection) + pi->size;
+		return SYNC_SOURCE_USE_BITMAP;
+	}
 
-		if (err <= 0) {
-			if (err < 0)
-				goto out;
-			break;
+	if (drbd_bitmap_uuid(peer_device) == (u64)0 && peer_device->bitmap_uuids[node_id] != (u64)0) {
+
+		if (peer_device->connection->agreed_pro_version < 91)
+			return REQUIRES_PROTO_91;
+
+		if ((drbd_history_uuid(device, 0) & ~UUID_PRIMARY) ==
+		    (peer_device->bitmap_uuids[node_id] & ~UUID_PRIMARY) &&
+		    (drbd_history_uuid(device, 1) & ~UUID_PRIMARY) ==
+		    (peer_device->history_uuids[0] & ~UUID_PRIMARY)) {
+			int i;
+
+			drbd_info(device, "was SyncTarget, peer missed the resync finished event, corrected peer:\n");
+
+			for (i = ARRAY_SIZE(peer_device->history_uuids) - 1; i > 0; i--)
+				peer_device->history_uuids[i] = peer_device->history_uuids[i - 1];
+			peer_device->history_uuids[i] = peer_device->bitmap_uuids[node_id];
+			peer_device->bitmap_uuids[node_id] = 0;
+
+			drbd_uuid_dump_peer(peer_device, peer_device->dirty_bits, peer_device->uuid_flags);
+			*rule = RULE_SYNC_TARGET_PEER_MISSED_FINISH;
+		} else {
+			drbd_info(device, "was SyncTarget (failed to write sync_uuid)\n");
+			*rule = RULE_SYNC_TARGET_MISSED_FINISH;
 		}
-		err = drbd_recv_header(peer_device->connection, pi);
-		if (err)
-			goto out;
+
+		return SYNC_TARGET_USE_BITMAP;
+	}
+
+	return UNDETERMINED;
+}
+
+static enum sync_strategy
+uuid_fixup_resync_start1(struct drbd_peer_device *peer_device, enum sync_rule *rule)
+{
+	struct drbd_device *device = peer_device->device;
+	const int node_id = peer_device->device->resource->res_opts.node_id;
+	u64 self, peer;
+
+	self = drbd_current_uuid(device) & ~UUID_PRIMARY;
+	peer = peer_device->history_uuids[0] & ~UUID_PRIMARY;
+
+	if (self == peer) {
+		if (peer_device->connection->agreed_pro_version < 96 ?
+		    (drbd_history_uuid(device, 0) & ~UUID_PRIMARY) ==
+		    (peer_device->history_uuids[1] & ~UUID_PRIMARY) :
+		    peer + UUID_NEW_BM_OFFSET == (peer_device->bitmap_uuids[node_id] & ~UUID_PRIMARY)) {
+			int i;
+
+			/* The last P_SYNC_UUID did not get though. Undo the last start of
+			   resync as sync source modifications of the peer's UUIDs. */
+			*rule = RULE_SYNC_TARGET_MISSED_START;
+
+			if (peer_device->connection->agreed_pro_version < 91)
+				return REQUIRES_PROTO_91;
+
+			peer_device->bitmap_uuids[node_id] = peer_device->history_uuids[0];
+			for (i = 0; i < ARRAY_SIZE(peer_device->history_uuids) - 1; i++)
+				peer_device->history_uuids[i] = peer_device->history_uuids[i + 1];
+			peer_device->history_uuids[i] = 0;
+
+			drbd_info(device, "Lost last syncUUID packet, corrected:\n");
+			drbd_uuid_dump_peer(peer_device, peer_device->dirty_bits, peer_device->uuid_flags);
+
+			return SYNC_TARGET_USE_BITMAP;
+		}
+	}
+
+	return UNDETERMINED;
+}
+
+static enum sync_strategy
+uuid_fixup_resync_start2(struct drbd_peer_device *peer_device, enum sync_rule *rule)
+{
+	struct drbd_device *device = peer_device->device;
+	u64 self, peer;
+
+	self = drbd_history_uuid(device, 0) & ~UUID_PRIMARY;
+	peer = peer_device->current_uuid & ~UUID_PRIMARY;
+
+	if (self == peer) {
+		if (peer_device->connection->agreed_pro_version < 96 ?
+		    (drbd_history_uuid(device, 1) & ~UUID_PRIMARY) ==
+		    (peer_device->history_uuids[0] & ~UUID_PRIMARY) :
+		    self + UUID_NEW_BM_OFFSET == (drbd_bitmap_uuid(peer_device) & ~UUID_PRIMARY)) {
+			u64 bitmap_uuid;
+
+			/* The last P_SYNC_UUID did not get though. Undo the last start of
+			   resync as sync source modifications of our UUIDs. */
+			*rule = RULE_SYNC_SOURCE_MISSED_START;
+
+			if (peer_device->connection->agreed_pro_version < 91)
+				return REQUIRES_PROTO_91;
+
+			bitmap_uuid = _drbd_uuid_pull_history(peer_device);
+			__drbd_uuid_set_bitmap(peer_device, bitmap_uuid);
+
+			drbd_info(device, "Last syncUUID did not get through, corrected:\n");
+			drbd_uuid_dump_self(peer_device,
+					    device->disk_state[NOW] >= D_NEGOTIATING ? drbd_bm_total_weight(peer_device) : 0, 0);
+
+			return SYNC_SOURCE_USE_BITMAP;
+		}
+	}
+
+	return UNDETERMINED;
+}
+
+/*
+ * Two diskful peers can carry the same current UUID yet sit at different
+ * positions in a (now absent) common primary's change stream. When both still
+ * hold out-of-sync bits toward each other, the bit counts do not order them;
+ * only the dagtag toward that common primary tells roll-forward from roll-back.
+ *
+ * Each of us kept its last_dagtag_sector toward the lost primary across the
+ * disconnect (see conn_disconnect()). Identify exactly one such common,
+ * currently-absent peer, so we can hand the other side our dagtag toward it
+ * during the handshake and let the node further along the stream become the
+ * resync source.
+ *
+ * Return -1 if there is no candidate, or more than one (ambiguous): we then
+ * fall back to a deterministic node-id choice, which still converges.
+ */
+static int find_common_lost_primary_node_id(struct drbd_connection *self)
+{
+	struct drbd_resource *resource = self->resource;
+	struct drbd_connection *connection;
+	int found = -1;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection == self)
+			continue;
+		if (connection->cstate[NOW] == C_CONNECTED)
+			continue;
+		/*
+		 * Non-zero means we received writes (dagtags) from it: it was a
+		 * source of data we may sit behind. Zero cannot order us.
+		 */
+		if (atomic64_read(&connection->last_dagtag_sector) == 0)
+			continue;
+		if (found != -1) {
+			found = -1; /* ambiguous; caller uses the node-id fallback */
+			break;
+		}
+		found = connection->peer_node_id;
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
+static enum sync_strategy drbd_uuid_compare(struct drbd_peer_device *peer_device,
+			     enum sync_rule *rule, int *peer_node_id)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	const int node_id = device->resource->res_opts.node_id;
+	bool my_current_in_peers_history, peers_current_in_my_history;
+	bool bitmap_matches, flags_matches, uuid_matches;
+	u64 resolved_uuid, bitmap_uuid;
+	u64 local_uuid_flags = 0;
+	u64 self, peer;
+	int i, j;
+
+	lockdep_assert_held(&device->ldev->md.uuid_lock);
+
+	resolved_uuid = drbd_resolved_uuid(peer_device, &local_uuid_flags) & ~UUID_PRIMARY;
+	bitmap_uuid = drbd_bitmap_uuid(peer_device);
+	local_uuid_flags |= drbd_collect_local_uuid_flags(peer_device, NULL);
+
+	uuid_matches = resolved_uuid == (peer_device->comm_current_uuid & ~UUID_PRIMARY);
+	bitmap_matches = bitmap_uuid == peer_device->comm_bitmap_uuid;
+	/* UUID_FLAG_INCONSISTENT is not relevant for the handshake, allow it to change.
+	 * UUID_FLAG_BITMAP_AUTHORITATIVE moves with the first bit set or last bit
+	 * cleared toward the peer; the handshake reads the value that was sent.
+	 */
+	flags_matches = !((local_uuid_flags ^ peer_device->comm_uuid_flags) &
+			  ~(UUID_FLAG_INCONSISTENT | UUID_FLAG_BITMAP_AUTHORITATIVE));
+	if (!test_bit(INITIAL_STATE_SENT, peer_device->flags)) {
+		drbd_warn(peer_device, "Initial UUIDs and state not sent yet. Not verifying\n");
+	} else if (!uuid_matches || !flags_matches || !bitmap_matches) {
+		if (!uuid_matches)
+			drbd_warn(peer_device, "My current UUID changed during handshake.\n");
+		if (!bitmap_matches)
+			drbd_warn(peer_device, "My bitmap UUID changed during "
+				  "handshake. 0x%llX to 0x%llX\n",
+				  (unsigned long long)peer_device->comm_bitmap_uuid,
+				  (unsigned long long)bitmap_uuid);
+		if (!flags_matches)
+			drbd_warn(peer_device,
+				  "My uuid_flags changed from 0x%llX to 0x%llX during handshake.\n",
+				  (unsigned long long)peer_device->comm_uuid_flags,
+				  (unsigned long long)local_uuid_flags);
+		if (connection->cstate[NOW] == C_CONNECTING) {
+			*rule = RULE_INITIAL_HANDSHAKE_CHANGED;
+			return RETRY_CONNECT;
+		}
+	}
+
+	self = resolved_uuid;
+	peer = peer_device->current_uuid & ~UUID_PRIMARY;
+
+	/* Before DRBD 8.0.2 (from 2007), the uuid on sync targets was set to
+	 * zero during resyncs for no good reason. */
+	if (self == 0)
+		self = UUID_JUST_CREATED;
+	if (peer == 0)
+		peer = UUID_JUST_CREATED;
+
+	*rule = RULE_JUST_CREATED_BOTH;
+	if (self == UUID_JUST_CREATED && peer == UUID_JUST_CREATED)
+		return NO_SYNC;
+
+	*rule = RULE_JUST_CREATED_SELF;
+	if (self == UUID_JUST_CREATED)
+		return SYNC_TARGET_SET_BITMAP;
+
+	*rule = RULE_JUST_CREATED_PEER;
+	if (peer == UUID_JUST_CREATED)
+		return SYNC_SOURCE_SET_BITMAP;
+
+	if (self == peer) {
+		struct drbd_net_conf *nc;
+		int wire_protocol;
+
+		rcu_read_lock();
+		nc = rcu_dereference(connection->transport.net_conf);
+		wire_protocol = nc->wire_protocol;
+		rcu_read_unlock();
+
+		if (connection->agreed_pro_version < 110) {
+			enum sync_strategy rv = uuid_fixup_resync_end(peer_device, rule);
+
+			if (rv != UNDETERMINED)
+				return rv;
+		}
+
+		if (test_bit(RS_SOURCE_MISSED_END, peer_device->flags)) {
+			*rule = RULE_SYNC_SOURCE_MISSED_FINISH;
+			return SYNC_SOURCE_USE_BITMAP;
+		}
+		if (test_bit(RS_PEER_MISSED_END, peer_device->flags)) {
+			*rule = RULE_SYNC_TARGET_PEER_MISSED_FINISH;
+			return SYNC_TARGET_USE_BITMAP;
+		}
+
+		/*
+		 * Equal current UUIDs do not imply identical data: two peers can
+		 * still hold out-of-sync bits toward each other. The rules below
+		 * resolve the direction; where they would otherwise declare NO_SYNC
+		 * and drop those bits, disk_states_to_strategy() reconciles via the
+		 * bitmap afterwards (maybe_reconcile_equal_uuid_bitmap), so it never
+		 * preempts a disk-state-based direction.
+		 */
+
+		if (connection->agreed_pro_version >= 120) {
+			*rule = RULE_RECONNECTED;
+			if (peer_device->uuid_flags & UUID_FLAG_RECONNECT &&
+			    local_uuid_flags & UUID_FLAG_RECONNECT)
+				return NO_SYNC;
+		}
+
+		if (connection->agreed_pro_version >= 121 &&
+		    (wire_protocol == DRBD_PROT_A || wire_protocol == DRBD_PROT_B)) {
+			*rule = RULE_CRASHED_PRIMARY;
+			if (local_uuid_flags & UUID_FLAG_CRASHED_PRIMARY &&
+			    !(peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY))
+				return SYNC_SOURCE_USE_BITMAP;
+
+			if (peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY &&
+			    !(local_uuid_flags & UUID_FLAG_CRASHED_PRIMARY))
+				return SYNC_TARGET_USE_BITMAP;
+		}
+
+		*rule = RULE_LOST_QUORUM;
+		if (peer_device->uuid_flags & UUID_FLAG_PRIMARY_LOST_QUORUM &&
+		    !test_bit(PRIMARY_LOST_QUORUM, &device->flags))
+			return SYNC_TARGET_IF_BOTH_FAILED;
+
+		if (!(peer_device->uuid_flags & UUID_FLAG_PRIMARY_LOST_QUORUM) &&
+		    test_bit(PRIMARY_LOST_QUORUM, &device->flags))
+			return SYNC_SOURCE_IF_BOTH_FAILED;
+
+		if (peer_device->uuid_flags & UUID_FLAG_PRIMARY_LOST_QUORUM &&
+		    test_bit(PRIMARY_LOST_QUORUM, &device->flags))
+			return test_bit(RESOLVE_CONFLICTS, &connection->transport.flags) ?
+				SYNC_SOURCE_IF_BOTH_FAILED :
+				SYNC_TARGET_IF_BOTH_FAILED;
+
+		*rule = RULE_RECONNECTED;
+		if (connection->agreed_pro_version < 120 &&
+		    peer_device->uuid_flags & UUID_FLAG_RECONNECT &&
+		    local_uuid_flags & UUID_FLAG_RECONNECT)
+			return NO_SYNC;
+
+		/* Peer crashed as primary, I survived, resync from me */
+		if (peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY &&
+		    local_uuid_flags & UUID_FLAG_RECONNECT)
+			return SYNC_SOURCE_IF_BOTH_FAILED;
+
+		/* I am a crashed primary, peer survived, resync to me */
+		if (local_uuid_flags & UUID_FLAG_CRASHED_PRIMARY &&
+		    peer_device->uuid_flags & UUID_FLAG_RECONNECT)
+			return SYNC_TARGET_IF_BOTH_FAILED;
+
+		/* One of us had a connection to the other node before.
+		   i.e. this is not a common power failure. */
+		if (peer_device->uuid_flags & UUID_FLAG_RECONNECT ||
+		    local_uuid_flags & UUID_FLAG_RECONNECT)
+			return NO_SYNC;
+
+		/* Common power [off|failure]? */
+		*rule = RULE_BOTH_OFF;
+		if (local_uuid_flags & UUID_FLAG_CRASHED_PRIMARY) {
+			if ((peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY) &&
+			    test_bit(RESOLVE_CONFLICTS, &connection->transport.flags))
+				return SYNC_TARGET_IF_BOTH_FAILED;
+			return SYNC_SOURCE_IF_BOTH_FAILED;
+		} else if (peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY)
+			return SYNC_TARGET_IF_BOTH_FAILED;
+		else
+			return NO_SYNC;
+	}
+
+	*rule = RULE_BITMAP_PEER;
+	peer = peer_device->bitmap_uuids[node_id] & ~UUID_PRIMARY;
+	if (self == peer)
+		return SYNC_TARGET_USE_BITMAP;
+
+	*rule = RULE_BITMAP_PEER_OTHER;
+	i = drbd_find_peer_bitmap_by_uuid(peer_device, self);
+	if (i != -1) {
+		*peer_node_id = i;
+		return SYNC_TARGET_CLEAR_BITMAP;
+	}
+
+	if (connection->agreed_pro_version < 110) {
+		enum sync_strategy rv = uuid_fixup_resync_start1(peer_device, rule);
+
+		if (rv != UNDETERMINED)
+			return rv;
+	}
+
+	*rule = RULE_BITMAP_SELF;
+	self = bitmap_uuid & ~UUID_PRIMARY;
+	peer = peer_device->current_uuid & ~UUID_PRIMARY;
+	if (self == peer)
+		return SYNC_SOURCE_USE_BITMAP;
+
+	*rule = RULE_BITMAP_SELF_OTHER;
+	i = drbd_find_bitmap_by_uuid(peer_device, peer);
+	if (i != -1) {
+		if (is_divergence_bitmap(&device->ldev->md.peers[i])) {
+			*peer_node_id = i;
+			return SYNC_SOURCE_COPY_BITMAP;
+		}
+		/* A slot records the divergence from the peer's data, but its
+		 * bitmap is being cleared by an ongoing resync and cannot be
+		 * copied.  The data is related, so resync the whole slot.
+		 */
+		return SYNC_SOURCE_SET_BITMAP;
+	}
+
+	self = resolved_uuid;
+	my_current_in_peers_history = uuid_in_peer_history(peer_device, self);
+
+	if (connection->agreed_pro_version < 110) {
+		enum sync_strategy rv = uuid_fixup_resync_start2(peer_device, rule);
+
+		if (rv != UNDETERMINED)
+			return rv;
+	}
+
+	peer = peer_device->current_uuid & ~UUID_PRIMARY;
+	peers_current_in_my_history = uuid_in_my_history(device, peer);
+
+	if (my_current_in_peers_history && !peers_current_in_my_history) {
+		*rule = RULE_HISTORY_PEER;
+		return SYNC_TARGET_SET_BITMAP;
+	}
+	if (!my_current_in_peers_history && peers_current_in_my_history) {
+		*rule = RULE_HISTORY_SELF;
+		return SYNC_SOURCE_SET_BITMAP;
+	}
+
+	*rule = RULE_BITMAP_BOTH;
+	self = bitmap_uuid & ~UUID_PRIMARY;
+	peer = peer_device->bitmap_uuids[node_id] & ~UUID_PRIMARY;
+	if (self == peer && self != ((u64)0))
+		return SPLIT_BRAIN_AUTO_RECOVER;
+
+	*rule = RULE_HISTORY_BOTH;
+	for (i = 0; i < HISTORY_UUIDS; i++) {
+		self = drbd_history_uuid(device, i) & ~UUID_PRIMARY;
+		/* Don't conclude to have "data divergence" from a "common ancestor"
+		 * if that common ancestor is just a not used yet slot in the history,
+		 * which is still initialized to zero on both peers. */
+		if (self == 0)
+			break;
+		for (j = 0; j < ARRAY_SIZE(peer_device->history_uuids); j++) {
+			peer = peer_device->history_uuids[j] & ~UUID_PRIMARY;
+			if (peer == 0)
+				break;
+			if (self == peer)
+				return SPLIT_BRAIN_DISCONNECT;
+		}
+	}
+
+	return UNRELATED_DATA;
+}
+
+static void log_handshake(struct drbd_peer_device *peer_device)
+{
+	u64 uuid_flags = drbd_collect_local_uuid_flags(peer_device, NULL);
+
+	drbd_info(peer_device, "drbd_sync_handshake:\n");
+	drbd_uuid_dump_self(peer_device, peer_device->comm_bm_set, uuid_flags);
+	drbd_uuid_dump_peer(peer_device, peer_device->dirty_bits, peer_device->uuid_flags);
+}
+
+static enum sync_strategy drbd_handshake(struct drbd_peer_device *peer_device,
+			  enum sync_rule *rule,
+			  int *peer_node_id,
+			  bool always_verbose)
+{
+	struct drbd_device *device = peer_device->device;
+	enum sync_strategy strategy;
+
+	spin_lock_irq(&device->ldev->md.uuid_lock);
+	if (always_verbose)
+		log_handshake(peer_device);
+
+	strategy = drbd_uuid_compare(peer_device, rule, peer_node_id);
+	if (strategy != NO_SYNC && !always_verbose)
+		log_handshake(peer_device);
+	spin_unlock_irq(&device->ldev->md.uuid_lock);
+
+	if (strategy != NO_SYNC || always_verbose)
+		drbd_info(peer_device, "uuid_compare()=%s by rule=%s\n",
+				strategy_descriptor(strategy).name,
+				drbd_sync_rule_str(*rule));
+
+	return strategy;
+}
+
+static bool is_resync_running(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+	bool rv = false;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		enum drbd_repl_state repl_state = peer_device->repl_state[NOW];
+
+		if (repl_state == L_SYNC_TARGET || repl_state == L_PAUSED_SYNC_T) {
+			rv = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+static int bitmap_mod_after_handshake(struct drbd_peer_device *peer_device, enum sync_strategy strategy, int peer_node_id)
+{
+	struct drbd_device *device = peer_device->device;
+
+	if (strategy == SYNC_SOURCE_COPY_BITMAP) {
+		int from;
+
+		if (peer_device->bitmap_index == -1)
+			return 0;
+
+		drbd_suspend_io(device, WRITE_ONLY);
+		drbd_bm_slot_lock(peer_device, "copy_slot/set_many sync_handshake", BM_LOCK_BULK);
+		/* Pick the day-0 slot under the bitmap lock: cbt-start claims and
+		 * clears a vacant slot under the same lock, so a slot found here
+		 * keeps its day-0 bits until the copy is done.
+		 */
+		from = device->ldev->md.peers[peer_node_id].bitmap_index;
+		if (from == -1)
+			from = drbd_unallocated_index(device->ldev);
+
+		if (from == -1) {
+			drbd_info(peer_device,
+				  "Setting all bitmap bits, day0 bm not available node_id=%d\n",
+				  peer_node_id);
+			drbd_bm_set_many_bits(peer_device, 0, -1UL);
+		} else {
+			drbd_info(peer_device,
+				  "Copying bitmap of peer node_id=%d (bitmap_index=%d)\n",
+				  peer_node_id, from);
+			drbd_bm_copy_slot(device, from, peer_device->bitmap_index);
+		}
+		drbd_bm_write(device, NULL);
+		drbd_bm_slot_unlock(peer_device);
+		drbd_resume_io(device);
+	} else if (strategy == SYNC_TARGET_CLEAR_BITMAP) {
+		drbd_info(peer_device, "Resync source provides bitmap (node_id=%d)\n", peer_node_id);
+		drbd_suspend_io(device, WRITE_ONLY);
+		drbd_bm_slot_lock(peer_device, "bm_clear_many_bits sync_handshake", BM_LOCK_BULK);
+		drbd_bm_clear_many_bits(peer_device, 0, -1UL);
+		drbd_bm_write(device, NULL);
+		drbd_bm_slot_unlock(peer_device);
+		drbd_resume_io(device);
+	} else if (strategy == SYNC_SOURCE_SET_BITMAP || strategy == SYNC_TARGET_SET_BITMAP) {
+		int err;
+
+		if (strategy == SYNC_TARGET_SET_BITMAP &&
+		    drbd_current_uuid(device) == UUID_JUST_CREATED &&
+		    is_resync_running(device))
+			return 0;
+
+		if (drbd_current_uuid(device) == UUID_JUST_CREATED) {
+			drbd_info(peer_device, "Setting and writing the whole bitmap, fresh node\n");
+			err = drbd_bitmap_io(device, &drbd_bmio_set_allocated_n_write,
+					     "set_allocated_n_write sync_handshake",
+					     BM_LOCK_CLEAR | BM_LOCK_BULK, NULL);
+		} else {
+			drbd_info(peer_device, "Setting and writing one bitmap slot, after drbd_sync_handshake\n");
+			err = drbd_bitmap_io(device, &drbd_bmio_set_n_write,
+					     "set_n_write sync_handshake",
+					     BM_LOCK_CLEAR | BM_LOCK_BULK | BM_LOCK_SINGLE_SLOT,
+					     peer_device);
+		}
+		if (err)
+			return err;
+
+		if (drbd_current_uuid(device) != UUID_JUST_CREATED &&
+		    peer_device->current_uuid != UUID_JUST_CREATED &&
+		    strategy == SYNC_SOURCE_SET_BITMAP) {
+			/*
+			 * We have just written the bitmap slot. Update the
+			 * bitmap UUID so that the resync does not start from
+			 * the beginning again if we disconnect and reconnect.
+			 *
+			 * Initial resync continuation is handled in
+			 * drbd_start_resync() at comment:
+			 * prepare to continue an interrupted initial resync later
+			 */
+			drbd_uuid_set_bitmap(peer_device, peer_device->current_uuid);
+			drbd_print_uuids(peer_device, "updated bitmap UUID");
+			drbd_md_sync(device);
+		}
+	}
+	return 0;
+}
+
+static enum drbd_repl_state strategy_to_repl_state(struct drbd_peer_device *peer_device,
+						   enum drbd_role peer_role,
+						   enum sync_strategy strategy)
+{
+	enum drbd_role role = peer_device->device->resource->role[NOW];
+	enum drbd_repl_state rv;
+
+	if (strategy == SYNC_SOURCE_IF_BOTH_FAILED || strategy == SYNC_TARGET_IF_BOTH_FAILED) {
+		if (role == R_PRIMARY || peer_role == R_PRIMARY) {
+			/* We have at least one primary, follow that with the resync decision */
+			rv = peer_role == R_SECONDARY ? L_WF_BITMAP_S :
+				role == R_SECONDARY ? L_WF_BITMAP_T :
+				L_ESTABLISHED;
+			return rv;
+		}
+		/* No current primary. Handle it as a common power failure, consider the
+		   roles at crash time */
+	}
+
+	if (strategy_descriptor(strategy).is_sync_source) {
+		rv = L_WF_BITMAP_S;
+	} else if (strategy_descriptor(strategy).is_sync_target) {
+		rv = L_WF_BITMAP_T;
+	} else {
+		rv = L_ESTABLISHED;
+	}
+
+	return rv;
+}
+
+static enum sync_strategy drbd_disk_states_source_strategy(
+		struct drbd_peer_device *peer_device,
+		int *peer_node_id)
+{
+	const int node_id = peer_device->device->resource->res_opts.node_id;
+	u64 bitmap_uuid;
+	int i = -1;
+
+	if (!(peer_device->uuid_flags & UUID_FLAG_SYNC_TARGET))
+		return SYNC_SOURCE_USE_BITMAP;
+
+	/* A resync with identical current-UUIDs -> USE_BITMAP */
+	bitmap_uuid = peer_device->bitmap_uuids[node_id];
+	if (bitmap_uuid == peer_device->current_uuid &&
+	    bitmap_uuid == drbd_current_uuid(peer_device->device))
+		return SYNC_SOURCE_USE_BITMAP;
+
+	/* When the peer is already a sync target, we actually see its
+	 * current UUID in the bitmap UUID slot towards us. We may need
+	 * to pick a different bitmap as a result. */
+	if (bitmap_uuid)
+		i = drbd_find_bitmap_by_uuid(peer_device, bitmap_uuid);
+
+	if (i == peer_device->node_id)
+		return SYNC_SOURCE_USE_BITMAP;
+
+	if (i == -1 || !is_divergence_bitmap(&peer_device->device->ldev->md.peers[i]))
+		return SYNC_SOURCE_SET_BITMAP;
+
+	*peer_node_id = i;
+	return SYNC_SOURCE_COPY_BITMAP;
+}
+
+static enum sync_strategy drbd_disk_states_target_strategy(
+		struct drbd_peer_device *peer_device,
+		int *peer_node_id)
+{
+	const int node_id = peer_device->device->resource->res_opts.node_id;
+	u64 bitmap_uuid;
+	int i;
+
+	if (!(peer_device->comm_uuid_flags & UUID_FLAG_SYNC_TARGET))
+		return SYNC_TARGET_USE_BITMAP;
+
+	bitmap_uuid = drbd_bitmap_uuid(peer_device);
+	if (bitmap_uuid == peer_device->current_uuid &&
+	    bitmap_uuid == drbd_current_uuid(peer_device->device))
+		return SYNC_TARGET_USE_BITMAP;
+
+	/* When we are already a sync target, we need to choose our
+	 * strategy to mirror the peer's choice (see
+	 * drbd_disk_states_source_strategy). */
+	i = drbd_find_peer_bitmap_by_uuid(peer_device, bitmap_uuid);
+
+	if (i == node_id)
+		return SYNC_TARGET_USE_BITMAP;
+
+	if (i == -1)
+		return SYNC_TARGET_SET_BITMAP;
+
+	*peer_node_id = i;
+	return SYNC_TARGET_CLEAR_BITMAP;
+}
+
+/*
+ * A node that has a primary at its side does not take an equal-UUID reconcile:
+ * the primary keeps its copy current and holds the record of what it is
+ * missing, while the node without one is about to outdate itself at the commit
+ * of this very connect (do_change_cstate(), PH_COMMIT). A resync in that
+ * direction hands that fencing verdict to a node it is not about, because
+ * drbd_resync_finished() gives the target the source's disk state.
+ *
+ * UUID_FLAG_STABLE is "no primary neighbor", and both sides read the same two
+ * values: the flag each of them sent with its UUIDs. At connect the connection
+ * being handshaked is not yet L_ESTABLISHED, so neither side counts the other
+ * as its neighbor -- which is why this is limited to the connect handshake.
+ *
+ * Returns false where both sides are placed alike, leaving the direction to the
+ * caller.
+ */
+static bool primary_neighbor_decides(struct drbd_peer_device *peer_device,
+				     bool connecting, enum sync_strategy *strategy)
+{
+	bool we_stable = peer_device->comm_uuid_flags & UUID_FLAG_STABLE;
+	bool peer_stable = peer_device->uuid_flags & UUID_FLAG_STABLE;
+
+	/*
+	 * Both sides must apply the same rule: a peer that does not know it
+	 * orders by bit count, so fall back to that ordering toward it.
+	 */
+	if (peer_device->connection->agreed_pro_version < 125)
+		return false;
+	if (!connecting || we_stable == peer_stable)
+		return false;
+
+	*strategy = we_stable ? SYNC_TARGET_USE_BITMAP : SYNC_SOURCE_USE_BITMAP;
+	return true;
+}
+
+/*
+ * Two equal-current-UUID peers can still hold out-of-sync bits toward each
+ * other: a write reached one of them and never the other, and no data
+ * generation recorded that -- the writer could not mint (a diskless Primary,
+ * a Primary that lost quorum under on-no-quorum=io-error, a crash before the
+ * bitmap was written out), or a common primary vanished while they sat at
+ * different positions in its change stream and the P_PEER_DAGTAG
+ * reconciliation never reached them. The equal-UUID rules would then declare
+ * NO_SYNC, which clears the bitmaps and silently drops the divergence.
+ * Reconcile via the bitmap instead.
+ *
+ *     precondition (else leave the decision untouched):
+ *         strategy == NO_SYNC            (rules found no resync; bits would drop)
+ *         both peers D_UP_TO_DATE        (differing disk states are the
+ *                                         disk-state decision's job, made above)
+ *         out-of-sync bits remain        (comm_bm_set || dirty_bits)
+ *         peer supports the feature      (DRBD_FF_RECONCILE_RECONNECT)
+ *         the connect handshake          (C_CONNECTING)
+ *     from protocol version 125 on:
+ *         a slot holding bits is authoritative on at least one side: its bits
+ *         were set for blocks the other lacks (MDF_PEER_BITMAP_AUTHORITATIVE,
+ *         exchanged as UUID_FLAG_BITMAP_AUTHORITATIVE); bits a sync target set
+ *         toward an absent peer, or an invalidate left behind, do not count
+ *       and two of the preconditions widen:
+ *         the after-unstable re-handshake on an established connection
+ *         qualifies as well (drbd_resync()), and
+ *         with one side authoritative only that side must be D_UP_TO_DATE;
+ *         the other may be D_OUTDATED or D_CONSISTENT (it lacks the blocks,
+ *         and lifting its mark on NO_SYNC is what would lose the record)
+ *     below protocol version 125:
+ *         a common lost primary is named (see below)
+ *         no stronger signal owns it     (crashed primary / lost quorum)
+ *
+ *     direction:
+ *         one of the two has a primary neighbor -> it is the source
+ *                                   (primary_neighbor_decides(), connect only,
+ *                                   both sides D_UP_TO_DATE)
+ *         one side authoritative -> it holds what the other lacks -> it is the
+ *                                   source (below 125: the side holding bits)
+ *         both sides             -> dagtag toward the common lost primary,
+ *                                   else the primary neighbor, else a
+ *                                   deterministic node-id tie-break
+ *
+ * Placed here, after the disk-state resolution, so it never preempts a real
+ * resync direction; it only rescues the would-be NO_SYNC-drops-bits case.
+ */
+static bool reconcile_equal_uuid_bitmap_strategy(struct drbd_peer_device *peer_device,
+						enum drbd_disk_state disk_state,
+						enum drbd_disk_state peer_disk_state,
+						enum sync_strategy *strategy,
+						enum sync_rule *rule)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	const int node_id = device->resource->res_opts.node_id;
+	bool by_provenance = connection->agreed_pro_version >= 125;
+	bool connecting = connection->cstate[NOW] == C_CONNECTING;
+	bool we_hold, peer_holds;
+	u64 local_uuid_flags;
+
+	if (*strategy != NO_SYNC)
+		return false;
+	if (!(peer_device->comm_bm_set || peer_device->dirty_bits))
+		return false;
+	if (!(connection->agreed_features & DRBD_FF_RECONCILE_RECONNECT))
+		return false;
+	if (!connecting && !(by_provenance && peer_device->repl_state[NOW] == L_ESTABLISHED))
+		return false;
+
+	if (by_provenance) {
+		/*
+		 * Both sides see the same two flags: the one this node sent with
+		 * its bit count, and the one the peer sent with its own. Bits
+		 * that are authoritative on neither side are resync artifacts,
+		 * and NO_SYNC (drop the bits) stays right for them; forcing a
+		 * resync would pull a healthy UpToDate peer through Inconsistent
+		 * for nothing.
+		 */
+		we_hold = peer_device->comm_bm_set &&
+			(peer_device->comm_uuid_flags & UUID_FLAG_BITMAP_AUTHORITATIVE);
+		peer_holds = peer_device->dirty_bits &&
+			(peer_device->uuid_flags & UUID_FLAG_BITMAP_AUTHORITATIVE);
+		if (!we_hold && !peer_holds)
+			return false;
+
+		if (we_hold != peer_holds) {
+			enum drbd_disk_state holder = we_hold ? disk_state : peer_disk_state;
+			enum drbd_disk_state other = we_hold ? peer_disk_state : disk_state;
+
+			if (holder != D_UP_TO_DATE || other < D_OUTDATED)
+				return false;
+		} else if (disk_state != D_UP_TO_DATE || peer_disk_state != D_UP_TO_DATE) {
+			return false;
+		}
+	} else {
+		bool one_sided = !peer_device->comm_bm_set != !peer_device->dirty_bits;
+
+		if (disk_state != D_UP_TO_DATE || peer_disk_state != D_UP_TO_DATE)
+			return false;
+
+		/*
+		 * Without the provenance record, equal current UUIDs with
+		 * leftover bits reconcile only between secondaries of a *common
+		 * lost primary*. Without one, the bits are taken for resync
+		 * artifacts and NO_SYNC is kept.
+		 *
+		 * "Named a common lost primary" must be evaluated identically on
+		 * both nodes, but each node only ever *hears* the other's naming
+		 * (find_common_lost_primary_node_id excludes the peer itself, so
+		 * a plain secondary of the bit-holder can never name one;
+		 * P_PEER_DAGTAG stashed the peer's naming in reconcile_handshake).
+		 * Gating on the stash alone therefore deadlocked one-sided
+		 * reconciles: the side the naming reached went WFBitMapS while
+		 * the namer stayed NO_SYNC/Established. Accept either direction
+		 * of the exchange -- the peer named one, or we named one to the
+		 * peer -- which is the same predicate on both nodes, so the
+		 * one-sided case (ordered by the bit counts) derives mirrored
+		 * decisions.
+		 *
+		 * The both-sided case cannot be ordered by bit counts; it
+		 * additionally needs the peer's dagtag position toward the named
+		 * lost primary, so it still requires the peer's naming.
+		 */
+		if (connection->reconcile_handshake.lost_node_id == -1 &&
+		    !(one_sided && connection->reconcile_handshake.sent_lost_node))
+			return false;
+
+		local_uuid_flags = drbd_collect_local_uuid_flags(peer_device, NULL);
+		if ((local_uuid_flags & UUID_FLAG_CRASHED_PRIMARY) ||
+		    (peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY) ||
+		    test_bit(PRIMARY_LOST_QUORUM, &device->flags) ||
+		    (peer_device->uuid_flags & UUID_FLAG_PRIMARY_LOST_QUORUM))
+			return false;
+
+		we_hold = peer_device->comm_bm_set != 0;
+		peer_holds = peer_device->dirty_bits != 0;
+	}
+
+	*rule = RULE_RECONCILE_BITMAP;
+	if (we_hold != peer_holds) {
+		/*
+		 * The primary neighbor overrides the holder only between two
+		 * UpToDate copies. From protocol 125 on, the non-holder may be
+		 * Outdated or Consistent here: it lacks the blocks the bits are
+		 * about, and a primary neighbor that could not keep it current
+		 * is no reason to make it the source.
+		 */
+		bool both_up_to_date = disk_state == D_UP_TO_DATE &&
+				       peer_disk_state == D_UP_TO_DATE;
+
+		if (!both_up_to_date ||
+		    !primary_neighbor_decides(peer_device, connecting, strategy))
+			*strategy = we_hold ?
+				SYNC_SOURCE_USE_BITMAP : SYNC_TARGET_USE_BITMAP;
+	} else {
+		/*
+		 * Both sides hold bits. Either direction restores identity, but the
+		 * bit counts do not order us; the node further along the common lost
+		 * primary's change stream (by dagtag) is the source. No usable dagtag
+		 * offset (we are at the same position) -> deterministic node-id
+		 * tie-break; either direction converges.
+		 *
+		 * The dagtag arm needs the naming in both directions: each node only
+		 * holds the position the peer sent it. A node that named without
+		 * hearing a name, or the reverse, would order by dagtag while its
+		 * peer tie-breaks, and the two could pick the same role. The naming
+		 * belongs to the connect handshake; on an established connection it
+		 * is stale, so only the tie-break is used there.
+		 */
+		int lost_id = connection->reconcile_handshake.lost_node_id;
+		struct drbd_connection *lost = NULL;
+		s64 offset = 0;
+
+		rcu_read_lock();
+		if (connecting && connection->reconcile_handshake.sent_lost_node)
+			lost = drbd_connection_by_node_id(device->resource, lost_id);
+		if (lost)
+			offset = atomic64_read(&lost->last_dagtag_sector) -
+				(s64)connection->reconcile_handshake.dagtag_sector;
+		rcu_read_unlock();
+
+		if (offset) {
+			*rule = RULE_RECONCILE_DAGTAG;
+			*strategy = offset > 0 ? SYNC_SOURCE_USE_BITMAP : SYNC_TARGET_USE_BITMAP;
+		} else if (!primary_neighbor_decides(peer_device, connecting, strategy)) {
+			*strategy = node_id < peer_device->node_id ?
+				SYNC_SOURCE_USE_BITMAP : SYNC_TARGET_USE_BITMAP;
+		}
+	}
+
+	return true;
+}
+
+static void maybe_reconcile_equal_uuid_bitmap(struct drbd_peer_device *peer_device,
+					      enum drbd_disk_state disk_state,
+					      enum drbd_disk_state peer_disk_state,
+					      enum sync_strategy *strategy,
+					      enum sync_rule *rule)
+{
+	if (!reconcile_equal_uuid_bitmap_strategy(peer_device, disk_state, peer_disk_state,
+						  strategy, rule))
+		return;
+
+	/* Mark this as a reconciliation resync, like the connected dagtag reconcile
+	 * (receive_peer_dagtag).  Its bitmap is pessimistic (set for tails that may
+	 * have been delivered) between two full copies; the SyncTarget then forces
+	 * checksum-based resync, clearing the matching majority without transfer and
+	 * keeping its Inconsistent window short.  Cleared when the resync finishes
+	 * (sanitize_state) or on disconnect.
+	 */
+	set_bit(RECONCILIATION_RESYNC, peer_device->flags);
+
+	drbd_info(peer_device,
+		  "strategy = %s to reconcile equal-UUID peers holding out-of-sync bits\n",
+		  strategy_descriptor(*strategy).name);
+}
+
+static void disk_states_to_strategy(struct drbd_peer_device *peer_device,
+				    enum drbd_disk_state peer_disk_state,
+				    enum sync_strategy *strategy, enum sync_rule *rule,
+				    int *peer_node_id)
+{
+	enum drbd_disk_state disk_state = peer_device->comm_state.disk;
+	struct drbd_device *device = peer_device->device;
+	bool decide_based_on_dstates = false;
+	bool prefer_local, either_inconsistent;
+
+	if (disk_state == D_NEGOTIATING)
+		disk_state = disk_state_from_md(device);
+
+	either_inconsistent =
+		(disk_state == D_INCONSISTENT && peer_disk_state > D_INCONSISTENT) ||
+		(peer_disk_state == D_INCONSISTENT && disk_state > D_INCONSISTENT);
+
+	if (peer_device->connection->agreed_pro_version >= 119) {
+		bool dstates_want_resync =
+			disk_state != peer_disk_state && disk_state >= D_INCONSISTENT &&
+			peer_disk_state >= D_INCONSISTENT && peer_disk_state != D_UNKNOWN;
+		bool resync_direction_arbitrary =
+			*strategy == SYNC_TARGET_IF_BOTH_FAILED ||
+			*strategy == SYNC_SOURCE_IF_BOTH_FAILED;
+
+		decide_based_on_dstates =
+			dstates_want_resync &&
+			(((*rule == RULE_RECONNECTED || *rule == RULE_LOST_QUORUM ||
+			   *rule == RULE_BOTH_OFF) && resync_direction_arbitrary) ||
+			 (*strategy == NO_SYNC && either_inconsistent));
+
+		prefer_local = disk_state > peer_disk_state;
+		/* RULE_BOTH_OFF means that the current UUIDs are equal. The decision
+		   was found by looking at the crashed_primary bits.
+		   The current disk states might give a better basis for decision-making! */
+
+		/* RULE_LOST_QUORUM means that the current UUIDs are equal. The resync direction
+		   was found by looking if a node lost quorum while being primary */
+	} else {
+		decide_based_on_dstates =
+			(*rule == RULE_BOTH_OFF || *strategy == NO_SYNC) && either_inconsistent;
+
+		prefer_local = disk_state > D_INCONSISTENT;
+	}
+
+	if (decide_based_on_dstates) {
+		*strategy = prefer_local ?
+			drbd_disk_states_source_strategy(peer_device, peer_node_id) :
+			drbd_disk_states_target_strategy(peer_device, peer_node_id);
+		drbd_info(peer_device, "strategy = %s due to disk states. (%s/%s)\n",
+			  strategy_descriptor(*strategy).name,
+			  drbd_disk_str(disk_state), drbd_disk_str(peer_disk_state));
+	}
+
+	maybe_reconcile_equal_uuid_bitmap(peer_device, disk_state, peer_disk_state,
+					  strategy, rule);
+}
+
+static enum sync_strategy drbd_attach_handshake(struct drbd_peer_device *peer_device,
+						  enum drbd_disk_state peer_disk_state)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	enum drbd_role peer_role = connection->peer_role[NOW];
+	enum sync_strategy strategy;
+	enum sync_rule rule;
+	int peer_node_id, err;
+	struct drbd_net_conf *nc;
+	int rr_conflict, always_asbp;
+	bool need_full_sync_after_split_brain;
+
+	strategy = drbd_handshake(peer_device, &rule, &peer_node_id, true);
+
+	if (!is_strategy_determined(strategy))
+		return strategy;
+
+	disk_states_to_strategy(peer_device, peer_disk_state, &strategy, &rule, &peer_node_id);
+
+	if (strategy == SPLIT_BRAIN_AUTO_RECOVER &&
+	    (!drbd_device_stable(device, NULL) ||
+	     !(peer_device->uuid_flags & UUID_FLAG_STABLE))) {
+		drbd_warn(peer_device,
+			  "Ignoring split-brain during attach: at least one side unstable\n");
+		strategy = NO_SYNC;
+	}
+
+	if (strategy_descriptor(strategy).is_split_brain)
+		drbd_maybe_khelper(device, connection, "initial-split-brain");
+
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	always_asbp = nc->always_asbp;
+	rr_conflict = nc->rr_conflict;
+	rcu_read_unlock();
+
+	need_full_sync_after_split_brain = (strategy == SPLIT_BRAIN_DISCONNECT);
+
+	if (strategy == SPLIT_BRAIN_AUTO_RECOVER ||
+	    (strategy == SPLIT_BRAIN_DISCONNECT && always_asbp)) {
+		int pcount = (device->resource->role[NOW] == R_PRIMARY)
+			   + (peer_role == R_PRIMARY);
+
+		if (strategy_descriptor(strategy).is_split_brain) {
+			switch (pcount) {
+			case 0:
+				strategy = drbd_asb_recover_0p(peer_device);
+				break;
+			case 1:
+				strategy = drbd_asb_recover_1p(peer_device);
+				break;
+			case 2:
+				strategy = drbd_asb_recover_2p(peer_device);
+				break;
+			}
+		}
+		if (strategy == RETRY_CONNECT)
+			return strategy;
+		if (!strategy_descriptor(strategy).is_split_brain) {
+			drbd_warn(peer_device,
+				  "Split-Brain detected during attach, %d primary(ies), automatically resolved. Sync from %s node\n",
+				  pcount,
+				  strategy_descriptor(strategy).is_sync_target ? "peer" : "this");
+			if (need_full_sync_after_split_brain) {
+				if (!strategy_descriptor(strategy).full_sync_equivalent) {
+					drbd_alert(peer_device,
+						   "Want full sync but cannot decide direction, dropping connection!\n");
+					return SPLIT_BRAIN_DISCONNECT;
+				}
+				drbd_warn(peer_device,
+					  "Doing a full sync since UUIDs were ambiguous.\n");
+				strategy = strategy_descriptor(strategy).full_sync_equivalent;
+			}
+		}
+	}
+
+	if (strategy_descriptor(strategy).is_split_brain) {
+		drbd_alert(peer_device,
+			   "Split-Brain detected during attach but unresolved, dropping connection!\n");
+		drbd_maybe_khelper(device, connection, "split-brain");
+		return strategy;
+	}
+
+	if (!is_strategy_determined(strategy)) {
+		drbd_alert(peer_device,
+			   "Failed to determine sync strategy during attach, dropping connection!\n");
+		return strategy;
+	}
+
+	if (strategy_descriptor(strategy).is_sync_target &&
+	    strategy != SYNC_TARGET_IF_BOTH_FAILED &&
+	    device->resource->role[NOW] == R_PRIMARY &&
+	    device->disk_state[NOW] >= D_CONSISTENT &&
+	    (peer_device->comm_bm_set > 0 || peer_device->dirty_bits > 0)) {
+		switch (rr_conflict) {
+		case ASB_CALL_HELPER:
+			drbd_maybe_khelper(device, connection, "pri-lost");
+			fallthrough;
+		case ASB_DISCONNECT:
+		case ASB_RETRY_CONNECT:
+			drbd_err(peer_device,
+				 "I shall become SyncTarget during attach, but I am primary!\n");
+			strategy = rr_conflict == ASB_RETRY_CONNECT ?
+				SYNC_TARGET_PRIMARY_RECONNECT :
+				SYNC_TARGET_PRIMARY_DISCONNECT;
+			break;
+		case ASB_VIOLENTLY:
+			drbd_warn(peer_device,
+				  "Becoming SyncTarget during attach, violating stable-data assumption\n");
+			break;
+		default:
+			break;
+		}
+	}
+
+	err = bitmap_mod_after_handshake(peer_device, strategy, peer_node_id);
+	if (err)
+		return RETRY_CONNECT;
+
+	return strategy;
+}
+
+static enum sync_strategy discard_my_data_to_strategy(struct drbd_peer_device *peer_device)
+{
+	enum sync_strategy strategy = UNDETERMINED;
+
+	if (test_bit(DISCARD_MY_DATA, peer_device->flags) &&
+	    !(peer_device->uuid_flags & UUID_FLAG_DISCARD_MY_DATA))
+		strategy = SYNC_TARGET_USE_BITMAP;
+
+	if (!test_bit(DISCARD_MY_DATA, peer_device->flags) &&
+	    (peer_device->uuid_flags & UUID_FLAG_DISCARD_MY_DATA))
+		strategy = SYNC_SOURCE_USE_BITMAP;
+
+	return strategy;
+}
+
+/* drbd_sync_handshake() returns the strategy for this connection; one with
+ * .reconnect or .disconnect set ends the connect attempt.
+ */
+static enum sync_strategy drbd_sync_handshake(struct drbd_peer_device *peer_device,
+					      union drbd_state peer_state)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_net_conf *nc;
+	enum sync_strategy strategy;
+	enum sync_rule rule;
+	int rr_conflict, always_asbp, peer_node_id = 0, err;
+	enum drbd_role peer_role = peer_state.role;
+	enum drbd_disk_state peer_disk_state = peer_state.disk;
+	int required_protocol;
+	enum sync_strategy strategy_from_user = discard_my_data_to_strategy(peer_device);
+	bool need_full_sync_after_split_brain;
+
+	strategy = drbd_handshake(peer_device, &rule, &peer_node_id, true);
+
+	if (strategy == RETRY_CONNECT)
+		return strategy;
+
+	if (strategy == UNRELATED_DATA) {
+		drbd_alert(peer_device, "Unrelated data, aborting!\n");
+		return strategy;
+	}
+	required_protocol = strategy_descriptor(strategy).required_protocol;
+	if (required_protocol) {
+		drbd_alert(peer_device, "To resolve this both sides have to support at least protocol %d\n", required_protocol);
+		return strategy;
+	}
+
+	/* Protocol < 124 peers don't handle 0-bit missed-end-of-resync correctly.
+	 * Retry the connection to let UUID cleanup resolve it, or keep retrying
+	 * if the peer needs to be upgraded.
+	 */
+	if (connection->agreed_pro_version < 124 &&
+	    peer_device->comm_bm_set == 0 && peer_device->dirty_bits == 0) {
+		if (strategy == SYNC_SOURCE_USE_BITMAP &&
+		    rule == RULE_SYNC_SOURCE_MISSED_FINISH) {
+			drbd_info(peer_device, "Missed end of resync as sync-source with 0 bits;"
+				  " retrying to let UUID cleanup resolve it\n");
+			return RETRY_CONNECT;
+		}
+		if (strategy == SYNC_TARGET_USE_BITMAP &&
+		    rule == RULE_SYNC_TARGET_PEER_MISSED_FINISH &&
+		    device->resource->role[NOW] == R_PRIMARY) {
+			drbd_info(peer_device, "Missed end of resync as sync-target with 0 bits on Primary;"
+				  " peer needs protocol 124+ to resolve, retrying\n");
+			return REQUIRES_PROTO_124;
+		}
+	}
+
+	disk_states_to_strategy(peer_device, peer_disk_state, &strategy, &rule, &peer_node_id);
+
+	if (strategy == SPLIT_BRAIN_AUTO_RECOVER && (!drbd_device_stable(device, NULL) || !(peer_device->uuid_flags & UUID_FLAG_STABLE))) {
+		drbd_warn(peer_device, "Ignore Split-Brain, for now, at least one side unstable\n");
+		strategy = NO_SYNC;
+	}
+
+	if (strategy_descriptor(strategy).is_split_brain)
+		drbd_maybe_khelper(device, connection, "initial-split-brain");
+
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	always_asbp = nc->always_asbp;
+	rr_conflict = nc->rr_conflict;
+	rcu_read_unlock();
+
+	/* Evaluate the original strategy,
+	 * before it is re-mapped by additional configuration below.
+	 */
+	need_full_sync_after_split_brain = (strategy == SPLIT_BRAIN_DISCONNECT);
+
+	if (strategy == SPLIT_BRAIN_AUTO_RECOVER || (strategy == SPLIT_BRAIN_DISCONNECT && always_asbp)) {
+		int pcount = (device->resource->role[NOW] == R_PRIMARY)
+			   + (peer_role == R_PRIMARY);
+
+		if (device->resource->res_opts.quorum != QOU_OFF &&
+		    connection->agreed_pro_version >= 113) {
+			if (device->have_quorum[NOW] && !peer_state.quorum)
+				strategy = SYNC_SOURCE_USE_BITMAP;
+			else if (!device->have_quorum[NOW] && peer_state.quorum)
+				strategy = SYNC_TARGET_USE_BITMAP;
+		}
+		if (strategy_descriptor(strategy).is_split_brain) {
+			switch (pcount) {
+			case 0:
+				strategy = drbd_asb_recover_0p(peer_device);
+				break;
+			case 1:
+				strategy = drbd_asb_recover_1p(peer_device);
+				break;
+			case 2:
+				strategy = drbd_asb_recover_2p(peer_device);
+				break;
+			}
+		}
+		if (strategy == RETRY_CONNECT) {
+			/* A dry run must not give up the Primary role. */
+			if (test_bit(CONN_DRY_RUN, &connection->flags)) {
+				clear_bit(CONN_HANDSHAKE_DEMOTE, &connection->flags);
+				drbd_info(peer_device,
+					  "dry-run connect: Split-Brain, would give up Primary role.\n");
+				return SPLIT_BRAIN_DISCONNECT;
+			}
+			return strategy;
+		}
+		if (!strategy_descriptor(strategy).is_split_brain) {
+			drbd_warn(peer_device, "Split-Brain detected, %d primaries, "
+			     "automatically solved. Sync from %s node\n",
+			     pcount, strategy_descriptor(strategy).is_sync_target ? "peer" : "this");
+			if (need_full_sync_after_split_brain) {
+				if (!strategy_descriptor(strategy).full_sync_equivalent) {
+					drbd_alert(peer_device, "Want full sync but cannot decide direction, dropping connection!\n");
+					return SPLIT_BRAIN_DISCONNECT;
+				}
+				drbd_warn(peer_device, "Doing a full sync, since"
+				     " UUIDs where ambiguous.\n");
+				strategy = strategy_descriptor(strategy).full_sync_equivalent;
+			}
+		}
+	}
+
+	if (strategy == SPLIT_BRAIN_DISCONNECT && strategy_from_user != UNDETERMINED) {
+		/* strategy_from_user via "--discard-my-data" is either
+		 * SYNC_TARGET_USE_BITMAP or SYNC_SOURCE_USE_BITMAP.
+		 * But here we do no longer have a relevant bitmap anymore.
+		 * Map to their "full sync equivalent".
+		 */
+		if (need_full_sync_after_split_brain)
+			strategy = strategy_descriptor(strategy_from_user).full_sync_equivalent;
+		else
+			strategy = strategy_from_user;
+		drbd_warn(peer_device, "Split-Brain detected, manually solved. %s from %s node\n",
+			  need_full_sync_after_split_brain ? "Full sync" : "Sync",
+			  strategy_descriptor(strategy).is_sync_target ? "peer" : "this");
+	}
+
+	if (strategy_descriptor(strategy).is_split_brain) {
+		drbd_alert(peer_device, "Split-Brain detected but unresolved, dropping connection!\n");
+		drbd_maybe_khelper(device, connection, "split-brain");
+		return strategy;
+	}
+
+	if (!is_strategy_determined(strategy)) {
+		drbd_alert(peer_device, "Failed to fully determine sync strategy, dropping connection!\n");
+		return strategy;
+	}
+
+	if (connection->agreed_pro_version >= 121 && strategy != NO_SYNC &&
+	    strategy_from_user != UNDETERMINED &&
+	    strategy_descriptor(strategy).is_sync_source != strategy_descriptor(strategy_from_user).is_sync_source) {
+		if (strategy_descriptor(strategy).reverse != UNDETERMINED) {
+			enum sync_strategy reversed = strategy_descriptor(strategy).reverse;
+			enum drbd_disk_state resync_source_disk_state =
+				strategy_descriptor(reversed).is_sync_source ? device->disk_state[NOW] : peer_disk_state;
+			if (resync_source_disk_state > D_INCONSISTENT) {
+				strategy = reversed;
+				drbd_warn(peer_device, "Resync direction reversed by --discard-my-data. Reverting to older data!\n");
+			} else {
+				drbd_warn(peer_device, "Ignoring --discard-my-data\n");
+			}
+		} else {
+			drbd_warn(peer_device, "Can not reverse resync direction (requested via --discard-my-data)\n");
+		}
+	}
+
+	if (strategy_descriptor(strategy).is_sync_target &&
+	    strategy != SYNC_TARGET_IF_BOTH_FAILED &&
+	    device->resource->role[NOW] == R_PRIMARY && device->disk_state[NOW] >= D_CONSISTENT &&
+	    (peer_device->comm_bm_set > 0 || peer_device->dirty_bits > 0)) {
+		switch (rr_conflict) {
+		case ASB_CALL_HELPER:
+			drbd_maybe_khelper(device, connection, "pri-lost");
+			fallthrough;
+		case ASB_DISCONNECT:
+		case ASB_RETRY_CONNECT:
+			drbd_err(peer_device, "I shall become SyncTarget, but I am primary!\n");
+			strategy = rr_conflict == ASB_RETRY_CONNECT ?
+				SYNC_TARGET_PRIMARY_RECONNECT : SYNC_TARGET_PRIMARY_DISCONNECT;
+			break;
+		case ASB_VIOLENTLY:
+			drbd_warn(peer_device, "Becoming SyncTarget, violating the stable-data"
+			     "assumption\n");
+			break;
+		case ASB_AUTO_DISCARD:
+			if (strategy == SYNC_TARGET_USE_BITMAP && rule == RULE_CRASHED_PRIMARY) {
+				drbd_warn(peer_device, "reversing resync by auto-discard\n");
+				strategy = SYNC_SOURCE_USE_BITMAP;
+			}
+		}
+	}
+	if (strategy == SYNC_SOURCE_USE_BITMAP && rule == RULE_CRASHED_PRIMARY &&
+	    peer_role == R_PRIMARY && peer_disk_state >= D_CONSISTENT &&
+	    rr_conflict == ASB_AUTO_DISCARD) {
+		drbd_warn(peer_device, "reversing resync by auto-discard\n");
+		strategy = SYNC_TARGET_USE_BITMAP;
+	}
+
+	if (rule == RULE_SYNC_SOURCE_MISSED_FINISH || rule == RULE_SYNC_SOURCE_PEER_MISSED_FINISH ||
+	    rule == RULE_SYNC_TARGET_MISSED_FINISH || rule == RULE_SYNC_TARGET_PEER_MISSED_FINISH) {
+		if (strategy == SYNC_SOURCE_USE_BITMAP) {
+			enum drbd_disk_state disk_state = peer_device->comm_state.disk;
+
+			if (disk_state == D_NEGOTIATING)
+				disk_state = disk_state_from_md(device);
+			if (disk_state != D_UP_TO_DATE) {
+				drbd_info(peer_device,
+					  "Resync (rule=%s) skipped: sync-source (%s)\n",
+					  drbd_sync_rule_str(rule), drbd_disk_str(disk_state));
+				strategy = NO_SYNC;
+			}
+		} else if (strategy == SYNC_TARGET_USE_BITMAP) {
+			if (peer_disk_state != D_UP_TO_DATE) {
+				struct drbd_peer_md *peer_md =
+					&device->ldev->md.peers[peer_device->node_id];
+				u64 previous = peer_md->bitmap_uuid;
+
+				if (previous) {
+					drbd_set_peer_bitmap_uuid(peer_md, 0, 0);
+					_drbd_uuid_push_history(device, previous);
+					drbd_md_mark_dirty(device);
+				}
+				drbd_info(peer_device,
+					  "Resync (rule=%s) skipped: peer sync-source (%s)\n",
+					  drbd_sync_rule_str(rule), drbd_disk_str(peer_disk_state));
+				strategy = NO_SYNC;
+			}
+		}
+	}
+
+	if (test_bit(CONN_DRY_RUN, &connection->flags)) {
+		if (strategy == NO_SYNC)
+			drbd_info(peer_device, "dry-run connect: No resync, would become Connected immediately.\n");
+		else
+			drbd_info(peer_device, "dry-run connect: Would become %s, doing a %s resync.",
+				 drbd_repl_str(strategy_descriptor(strategy).is_sync_target ? L_SYNC_TARGET : L_SYNC_SOURCE),
+				 strategy_descriptor(strategy).name);
+		return DRY_RUN;
+	}
+
+	err = bitmap_mod_after_handshake(peer_device, strategy, peer_node_id);
+	if (err)
+		return RETRY_CONNECT;
+
+	return strategy;
+}
+
+static enum drbd_after_sb_p convert_after_sb(enum drbd_after_sb_p peer)
+{
+	/* ASB_DISCARD_REMOTE - ASB_DISCARD_LOCAL is valid */
+	if (peer == ASB_DISCARD_REMOTE)
+		return ASB_DISCARD_LOCAL;
+
+	/* any other things with ASB_DISCARD_REMOTE or ASB_DISCARD_LOCAL are invalid */
+	if (peer == ASB_DISCARD_LOCAL)
+		return ASB_DISCARD_REMOTE;
+
+	/* everything else is valid if they are equal on both sides. */
+	return peer;
+}
+
+static int receive_protocol(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_protocol *p = pi->data;
+	enum drbd_after_sb_p p_after_sb_0p, p_after_sb_1p, p_after_sb_2p;
+	int p_proto, p_discard_my_data, p_two_primaries, cf;
+	struct drbd_net_conf *nc, *old_net_conf, *new_net_conf = NULL;
+	char integrity_alg[SHARED_SECRET_MAX] = "";
+	struct crypto_shash *peer_integrity_tfm = NULL;
+	void *int_dig_in = NULL, *int_dig_vv = NULL;
+
+	p_proto		= be32_to_cpu(p->protocol);
+	p_after_sb_0p	= be32_to_cpu(p->after_sb_0p);
+	p_after_sb_1p	= be32_to_cpu(p->after_sb_1p);
+	p_after_sb_2p	= be32_to_cpu(p->after_sb_2p);
+	p_two_primaries = be32_to_cpu(p->two_primaries);
+	cf		= be32_to_cpu(p->conn_flags);
+	p_discard_my_data = cf & CF_DISCARD_MY_DATA;
+
+	if (connection->agreed_pro_version >= 87) {
+		int err;
+
+		if (pi->size > sizeof(integrity_alg))
+			return -EIO;
+		err = drbd_recv_into(connection, integrity_alg, pi->size);
+		if (err)
+			return err;
+		integrity_alg[SHARED_SECRET_MAX - 1] = 0;
+	}
+
+	if (pi->cmd != P_PROTOCOL_UPDATE) {
+		if (cf & CF_DRY_RUN)
+			set_bit(CONN_DRY_RUN, &connection->flags);
+
+		rcu_read_lock();
+		nc = rcu_dereference(connection->transport.net_conf);
+
+		if (p_proto != nc->wire_protocol) {
+			drbd_err(connection, "incompatible %s settings\n", "protocol");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (convert_after_sb(p_after_sb_0p) != nc->after_sb_0p) {
+			drbd_err(connection, "incompatible %s settings\n", "after-sb-0pri");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (convert_after_sb(p_after_sb_1p) != nc->after_sb_1p) {
+			drbd_err(connection, "incompatible %s settings\n", "after-sb-1pri");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (convert_after_sb(p_after_sb_2p) != nc->after_sb_2p) {
+			drbd_err(connection, "incompatible %s settings\n", "after-sb-2pri");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (p_discard_my_data && test_bit(CONN_DISCARD_MY_DATA, &connection->flags)) {
+			drbd_err(connection, "incompatible %s settings\n", "discard-my-data");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (p_two_primaries != nc->two_primaries) {
+			drbd_err(connection, "incompatible %s settings\n", "allow-two-primaries");
+			goto disconnect_rcu_unlock;
+		}
+
+		if (strcmp(integrity_alg, nc->integrity_alg)) {
+			drbd_err(connection, "incompatible %s settings\n", "data-integrity-alg");
+			goto disconnect_rcu_unlock;
+		}
+
+		rcu_read_unlock();
+	}
+
+	if (integrity_alg[0]) {
+		int hash_size;
+
+		/*
+		 * We can only change the peer data integrity algorithm
+		 * here.  Changing our own data integrity algorithm
+		 * requires that we send a P_PROTOCOL_UPDATE packet at
+		 * the same time; otherwise, the peer has no way to
+		 * tell between which packets the algorithm should
+		 * change.
+		 */
+
+		peer_integrity_tfm = crypto_alloc_shash(integrity_alg, 0, 0);
+		if (IS_ERR(peer_integrity_tfm)) {
+			peer_integrity_tfm = NULL;
+			drbd_err(connection, "peer data-integrity-alg %s not supported\n",
+				 integrity_alg);
+			goto disconnect;
+		}
+
+		hash_size = crypto_shash_digestsize(peer_integrity_tfm);
+		int_dig_in = kmalloc(hash_size, GFP_KERNEL);
+		int_dig_vv = kmalloc(hash_size, GFP_KERNEL);
+		if (!(int_dig_in && int_dig_vv)) {
+			drbd_err(connection, "Allocation of buffers for data integrity checking failed\n");
+			goto disconnect;
+		}
+	}
+
+	new_net_conf = kmalloc_obj(struct drbd_net_conf);
+	if (!new_net_conf)
+		goto disconnect;
+
+	if (mutex_lock_interruptible(&connection->resource->conf_update)) {
+		drbd_err(connection, "Interrupted while waiting for conf_update\n");
+		goto disconnect;
+	}
+
+	mutex_lock(&connection->mutex[DATA_STREAM]);
+	old_net_conf = connection->transport.net_conf;
+	*new_net_conf = *old_net_conf;
+
+	new_net_conf->wire_protocol = p_proto;
+	new_net_conf->after_sb_0p = convert_after_sb(p_after_sb_0p);
+	new_net_conf->after_sb_1p = convert_after_sb(p_after_sb_1p);
+	new_net_conf->after_sb_2p = convert_after_sb(p_after_sb_2p);
+	new_net_conf->two_primaries = p_two_primaries;
+
+	rcu_assign_pointer(connection->transport.net_conf, new_net_conf);
+	mutex_unlock(&connection->mutex[DATA_STREAM]);
+	mutex_unlock(&connection->resource->conf_update);
+
+	crypto_free_shash(connection->peer_integrity_tfm);
+	kfree(connection->int_dig_in);
+	kfree(connection->int_dig_vv);
+	connection->peer_integrity_tfm = peer_integrity_tfm;
+	connection->int_dig_in = int_dig_in;
+	connection->int_dig_vv = int_dig_vv;
+
+	if (strcmp(old_net_conf->integrity_alg, integrity_alg))
+		drbd_info(connection, "peer data-integrity-alg: %s\n",
+			  integrity_alg[0] ? integrity_alg : "(none)");
+
+	kvfree_rcu_mightsleep(old_net_conf);
+	return 0;
+
+disconnect_rcu_unlock:
+	rcu_read_unlock();
+disconnect:
+	kfree(new_net_conf);
+	crypto_free_shash(peer_integrity_tfm);
+	kfree(int_dig_in);
+	kfree(int_dig_vv);
+	change_cstate(connection, C_DISCONNECTING, CS_HARD);
+	return -EIO;
+}
+
+/* helper function
+ * input: alg name, feature name
+ * return: NULL (alg name was "")
+ *         ERR_PTR(error) if something goes wrong
+ *         or the crypto hash ptr, if it worked out ok. */
+static struct crypto_shash *drbd_crypto_alloc_digest_safe(const struct drbd_device *device,
+		const char *alg, const char *name)
+{
+	struct crypto_shash *tfm;
+
+	if (!alg[0])
+		return NULL;
+
+	tfm = crypto_alloc_shash(alg, 0, 0);
+	if (IS_ERR(tfm)) {
+		drbd_err(device, "Can not allocate \"%s\" as %s (reason: %ld)\n",
+			alg, name, PTR_ERR(tfm));
+		return tfm;
+	}
+	return tfm;
+}
+
+/* Receive P_SYNC_PARAM89 and the older P_SYNC_PARAM. The peer_device fields
+ * related to resync configuration are ignored. These include resync_rate,
+ * c_max_rate and the like. We ignore them because applying them to our own
+ * configuration would be confusing. It would cause us to swap configuration
+ * with our peer each time we connected. */
+static int receive_SyncParam(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct p_rs_param_95 *p;
+	unsigned int header_size, data_size, exp_max_sz;
+	struct crypto_shash *verify_tfm = NULL;
+	struct crypto_shash *csums_tfm = NULL;
+	struct drbd_net_conf *old_net_conf, *new_net_conf = NULL;
+	struct drbd_peer_device_conf *old_peer_device_conf = NULL;
+	const int apv = connection->agreed_pro_version;
+	struct fifo_buffer *old_plan = NULL, *new_plan = NULL;
+	struct drbd_resource *resource = connection->resource;
+	int err;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+	device = peer_device->device;
+
+	exp_max_sz  = apv <= 87 ? sizeof(struct p_rs_param)
+		    : apv == 88 ? sizeof(struct p_rs_param)
+					+ SHARED_SECRET_MAX
+		    : apv <= 94 ? sizeof(struct p_rs_param_89)
+		    : /* apv >= 95 */ sizeof(struct p_rs_param_95);
+
+	if (pi->size > exp_max_sz) {
+		drbd_err(device, "SyncParam packet too long: received %u, expected <= %u bytes\n",
+		    pi->size, exp_max_sz);
+		return -EIO;
+	}
+
+	if (apv <= 88) {
+		header_size = sizeof(struct p_rs_param);
+		data_size = pi->size - header_size;
+	} else if (apv <= 94) {
+		header_size = sizeof(struct p_rs_param_89);
+		data_size = pi->size - header_size;
+		D_ASSERT(device, data_size == 0);
+	} else {
+		header_size = sizeof(struct p_rs_param_95);
+		data_size = pi->size - header_size;
+		D_ASSERT(device, data_size == 0);
+	}
+
+	err = drbd_recv_all(connection, (void **)&p, header_size + data_size);
+	if (err)
+		return err;
+
+	err = mutex_lock_interruptible(&resource->conf_update);
+	if (err) {
+		drbd_err(connection, "Interrupted while waiting for conf_update\n");
+		return err;
+	}
+	old_net_conf = connection->transport.net_conf;
+
+	if (apv >= 88) {
+		if (apv == 88) {
+			if (data_size > SHARED_SECRET_MAX || data_size == 0) {
+				drbd_err(device, "verify-alg too long, "
+					 "peer wants %u, accepting only %u byte\n",
+					 data_size, SHARED_SECRET_MAX);
+				goto reconnect;
+			}
+			p->verify_alg[data_size] = 0;
+
+		} else /* apv >= 89 */ {
+			/* we still expect NUL terminated strings */
+			/* but just in case someone tries to be evil */
+			D_ASSERT(device, p->verify_alg[SHARED_SECRET_MAX-1] == 0);
+			D_ASSERT(device, p->csums_alg[SHARED_SECRET_MAX-1] == 0);
+			p->verify_alg[SHARED_SECRET_MAX-1] = 0;
+			p->csums_alg[SHARED_SECRET_MAX-1] = 0;
+		}
+
+		strscpy(connection->peer_verify_alg, p->verify_alg,
+			sizeof(connection->peer_verify_alg));
+
+		if (strcmp(old_net_conf->verify_alg, p->verify_alg)) {
+			if (peer_device->repl_state[NOW] == L_OFF) {
+				drbd_warn(device, "Different verify-alg settings. me=\"%s\" peer=\"%s\", online verify will be refused\n",
+				    old_net_conf->verify_alg, p->verify_alg);
+			} else {
+				verify_tfm = drbd_crypto_alloc_digest_safe(device,
+						p->verify_alg, "verify-alg");
+				if (IS_ERR(verify_tfm)) {
+					verify_tfm = NULL;
+					goto disconnect;
+				}
+			}
+		}
+
+		if (apv >= 89 && strcmp(old_net_conf->csums_alg, p->csums_alg)) {
+			if (peer_device->repl_state[NOW] == L_OFF) {
+				drbd_err(device, "Different csums-alg settings. me=\"%s\" peer=\"%s\"\n",
+				    old_net_conf->csums_alg, p->csums_alg);
+				goto disconnect;
+			}
+			csums_tfm = drbd_crypto_alloc_digest_safe(device,
+					p->csums_alg, "csums-alg");
+			if (IS_ERR(csums_tfm)) {
+				csums_tfm = NULL;
+				goto disconnect;
+			}
+		}
+
+		if (verify_tfm || csums_tfm) {
+			new_net_conf = kzalloc_obj(struct drbd_net_conf);
+			if (!new_net_conf)
+				goto disconnect;
+
+			*new_net_conf = *old_net_conf;
+
+			if (verify_tfm) {
+				strscpy(new_net_conf->verify_alg, p->verify_alg);
+				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
+				crypto_free_shash(connection->verify_tfm);
+				connection->verify_tfm = verify_tfm;
+				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
+			}
+			if (csums_tfm) {
+				strscpy(new_net_conf->csums_alg, p->csums_alg);
+				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
+				crypto_free_shash(connection->csums_tfm);
+				connection->csums_tfm = csums_tfm;
+				drbd_info(device, "using csums-alg: \"%s\"\n", p->csums_alg);
+			}
+			rcu_assign_pointer(connection->transport.net_conf, new_net_conf);
+		}
+	}
+
+	if (new_plan)
+		rcu_assign_pointer(peer_device->rs_plan_s, new_plan);
+
+	mutex_unlock(&resource->conf_update);
+	synchronize_rcu();
+	if (new_net_conf)
+		kfree(old_net_conf);
+	kfree(old_peer_device_conf);
+	if (new_plan)
+		kfree(old_plan);
+
+	return 0;
+
+reconnect:
+	mutex_unlock(&resource->conf_update);
+	return -EIO;
+
+disconnect:
+	kfree(new_plan);
+	mutex_unlock(&resource->conf_update);
+	/* just for completeness: actually not needed,
+	 * as this is not reached if csums_tfm was ok. */
+	crypto_free_shash(csums_tfm);
+	/* but free the verify_tfm again, if csums_tfm did not work out */
+	crypto_free_shash(verify_tfm);
+	change_cstate(connection, C_DISCONNECTING, CS_HARD);
+	return -EIO;
+}
+
+static void drbd_setup_order_type(struct drbd_device *device, int peer)
+{
+	/* sorry, we currently have no working implementation
+	 * of distributed TCQ */
+}
+
+/* warn if the arguments differ by more than 12.5% */
+static void warn_if_differ_considerably(struct drbd_peer_device *peer_device,
+	const char *s, sector_t a, sector_t b)
+{
+	sector_t d;
+
+	if (a == 0 || b == 0)
+		return;
+	d = (a > b) ? (a - b) : (b - a);
+	if (d > (a>>3) || d > (b>>3))
+		drbd_warn(peer_device, "Considerable difference in %s: %llus vs. %llus\n", s,
+		     (unsigned long long)a, (unsigned long long)b);
+}
+
+static bool drbd_other_peer_smaller(struct drbd_peer_device *reference_peer_device, uint64_t new_size)
+{
+	struct drbd_device *device = reference_peer_device->device;
+	struct drbd_peer_device *peer_device;
+	bool smaller = false;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (peer_device == reference_peer_device)
+			continue;
+
+		/* Ignore peers without an attached disk. */
+		if (peer_device->disk_state[NOW] < D_INCONSISTENT)
+			continue;
+
+		if (peer_device->d_size != 0 && peer_device->d_size < new_size)
+			smaller = true;
+	}
+	rcu_read_unlock();
+
+	return smaller;
+}
+
+static bool other_peer_has_usable_data(struct drbd_peer_device *reference_peer_device)
+{
+	struct drbd_device *device = reference_peer_device->device;
+	struct drbd_peer_device *peer_device;
+	bool usable = false;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (peer_device == reference_peer_device)
+			continue;
+
+		if (peer_device->repl_state[NOW] >= L_ESTABLISHED &&
+		    peer_device->disk_state[NOW] >= D_OUTDATED)
+			usable = true;
+	}
+	rcu_read_unlock();
+
+	return usable;
+}
+
+/* Maximum bio size that a protocol version supports. */
+static unsigned int conn_max_bio_size(struct drbd_connection *connection)
+{
+	if (connection->agreed_pro_version >= 100)
+		return DRBD_MAX_BIO_SIZE;
+	else if (connection->agreed_pro_version >= 95)
+		return DRBD_MAX_BIO_SIZE_P95;
+	else
+		return DRBD_MAX_SIZE_H80_PACKET;
+}
+
+static bool is_valid_block_size(unsigned int size)
+{
+	return size >= SECTOR_SIZE && size <= DRBD_MAX_BIO_SIZE && is_power_of_2(size);
+}
+
+static bool peer_block_sizes_are_sane(struct drbd_peer_device *peer_device, struct p_sizes *p)
+{
+	unsigned int logical_block_size, physical_block_size;
+
+	/* Older peers do not send queue limits at all. */
+	if (!(peer_device->connection->agreed_features & DRBD_FF_WSAME))
+		return true;
+
+	logical_block_size = be32_to_cpu(p->qlim->logical_block_size);
+	physical_block_size = be32_to_cpu(p->qlim->physical_block_size);
+
+	if (!is_valid_block_size(logical_block_size) ||
+	    !is_valid_block_size(physical_block_size)) {
+		drbd_err(peer_device,
+			 "Peer sent bogus block sizes (logical:%u physical:%u), disconnecting\n",
+			 logical_block_size, physical_block_size);
+		return false;
+	}
+
+	return true;
+}
+
+static struct drbd_peer_device *get_neighbor_device(struct drbd_device *device,
+		enum drbd_neighbor neighbor)
+{
+	s32 self_id, peer_id, pivot;
+	struct drbd_peer_device *peer_device, *peer_device_ret = NULL;
+
+	if (!get_ldev(device))
+		return NULL;
+	self_id = device->ldev->md.node_id;
+	put_ldev(device);
+
+	pivot = neighbor == NEXT_LOWER ? 0 : neighbor == NEXT_HIGHER ? S32_MAX : -1;
+	if (pivot == -1)
+		return NULL;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		bool found_new = false;
+
+		peer_id = peer_device->node_id;
+
+		if (neighbor == NEXT_LOWER && peer_id < self_id && peer_id >= pivot)
+			found_new = true;
+		else if (neighbor == NEXT_HIGHER && peer_id > self_id && peer_id <= pivot)
+			found_new = true;
+
+		if (found_new && peer_device->disk_state[NOW] >= D_INCONSISTENT) {
+			pivot = peer_id;
+			peer_device_ret = peer_device;
+		}
+	}
+	rcu_read_unlock();
+
+	return peer_device_ret;
+}
+
+static void maybe_trigger_resync(struct drbd_device *device, struct drbd_peer_device *peer_device, bool grew, bool skip)
+{
+	if (!peer_device)
+		return;
+	if (peer_device->repl_state[NOW] <= L_OFF)
+		return;
+	if (test_and_clear_bit(RESIZE_PENDING, peer_device->flags) ||
+	    (grew && peer_device->repl_state[NOW] == L_ESTABLISHED)) {
+		if (peer_device->disk_state[NOW] >= D_INCONSISTENT &&
+		    device->disk_state[NOW] >= D_INCONSISTENT) {
+			if (skip)
+				drbd_info(peer_device, "Resync of new storage suppressed with --assume-clean\n");
+			else
+				resync_after_online_grow(peer_device);
+		} else
+			set_bit(RESYNC_AFTER_NEG, peer_device->flags);
+	}
+}
+
+static int receive_sizes(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device, *peer_device_it = NULL;
+	struct drbd_device *device;
+	struct p_sizes *p = pi->data;
+	uint64_t p_size, p_usize, p_csize;
+	uint64_t my_usize, my_max_size, cur_size;
+	enum determine_dev_size dd = DS_UNCHANGED;
+	bool should_send_sizes = false;
+	enum dds_flags ddsf;
+	unsigned int protocol_max_bio_size;
+	bool have_ldev = false;
+	bool have_mutex = false;
+	bool is_handshake;
+	int err;
+	u64 im;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+	device = peer_device->device;
+
+	err = mutex_lock_interruptible(&connection->resource->conf_update);
+	if (err) {
+		drbd_err(connection, "Interrupted while waiting for conf_update\n");
+		goto out;
+	}
+	have_mutex = true;
+
+	if (!peer_block_sizes_are_sane(peer_device, p))
+		goto disconnect;
+
+	/* just store the peer's disk size for now.
+	 * we still need to figure out whether we accept that. */
+	p_size = be64_to_cpu(p->d_size);
+	p_usize = be64_to_cpu(p->u_size);
+	p_csize = be64_to_cpu(p->c_size);
+
+	peer_device->d_size = p_size;
+	peer_device->u_size = p_usize;
+	peer_device->c_size = p_csize;
+
+	/* Ignore "current" size for calculating "max" size. */
+	/* If it used to have a disk, but now is detached, don't revert back to zero. */
+	if (p_size)
+		peer_device->max_size = p_size;
+
+	cur_size = get_capacity(device->vdisk);
+	dynamic_drbd_dbg(device, "current_size: %llu\n", (unsigned long long)cur_size);
+	dynamic_drbd_dbg(peer_device, "c_size: %llu u_size: %llu d_size: %llu max_size: %llu\n",
+			(unsigned long long)p_csize,
+			(unsigned long long)p_usize,
+			(unsigned long long)p_size,
+			(unsigned long long)peer_device->max_size);
+
+	if ((p_size && p_csize > p_size) || (p_usize && p_csize > p_usize)) {
+		drbd_warn(peer_device, "Peer sent bogus sizes, disconnecting\n");
+		goto disconnect;
+	}
+
+	/* The protocol version limits how big requests can be.  In addition,
+	 * peers before protocol version 94 cannot split large requests into
+	 * multiple bios; their reported max_bio_size is a hard limit.
+	 */
+	protocol_max_bio_size = conn_max_bio_size(connection);
+	peer_device->q_limits.max_bio_size = min(be32_to_cpu(p->max_bio_size),
+						 protocol_max_bio_size);
+	ddsf = be16_to_cpu(p->dds_flags);
+	is_handshake = (peer_device->repl_state[NOW] == L_OFF);
+	set_bit(HAVE_SIZES, peer_device->flags);
+
+	if (get_ldev(device)) {
+		sector_t new_size;
+
+		have_ldev = true;
+
+		rcu_read_lock();
+		my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
+		rcu_read_unlock();
+
+		my_max_size = drbd_get_max_capacity(device, device->ldev, false);
+		dynamic_drbd_dbg(peer_device, "la_size: %llu my_usize: %llu my_max_size: %llu\n",
+			(unsigned long long)device->ldev->md.effective_size,
+			(unsigned long long)my_usize,
+			(unsigned long long)my_max_size);
+
+		if (peer_device->disk_state[NOW] > D_DISKLESS)
+			warn_if_differ_considerably(peer_device, "lower level device sizes",
+				   p_size, my_max_size);
+		warn_if_differ_considerably(peer_device, "user requested size",
+					    p_usize, my_usize);
+
+		if (is_handshake)
+			p_usize = min_not_zero(my_usize, p_usize);
+
+		if (p_usize == 0) {
+			/* Peer may reset usize to zero only if it has a backend.
+			 * Because a diskless node has no disk config,
+			 * and always sends zero. */
+			if (p_size == 0)
+				p_usize = my_usize;
+		}
+
+		new_size = drbd_new_dev_size(device, 0, p_usize, ddsf);
+
+		/* Never shrink a device with usable data during connect,
+		 * or "attach" on the peer. That includes usable data on
+		 * another connected peer, our current size comes from it.
+		 * But allow online shrinking if we are connected. */
+		if (new_size < cur_size &&
+		    (device->disk_state[NOW] >= D_OUTDATED ||
+		     other_peer_has_usable_data(peer_device)) &&
+		    (peer_device->repl_state[NOW] < L_ESTABLISHED || peer_device->disk_state[NOW] == D_DISKLESS)) {
+			drbd_err(peer_device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
+					(unsigned long long)new_size, (unsigned long long)cur_size);
+			goto disconnect;
+		}
+
+		/* Disconnect, if we cannot grow to the peer's current size */
+		if (my_max_size < p_csize && !is_handshake) {
+			drbd_err(peer_device, "Peer's size larger than my maximum capacity (%llu < %llu sectors)\n",
+					(unsigned long long)my_max_size, (unsigned long long)p_csize);
+			goto disconnect;
+		}
+
+		if (my_usize != p_usize) {
+			struct drbd_disk_conf *old_disk_conf, *new_disk_conf;
+
+			new_disk_conf = kzalloc_obj(struct drbd_disk_conf);
+			if (!new_disk_conf) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			old_disk_conf = device->ldev->disk_conf;
+			*new_disk_conf = *old_disk_conf;
+			new_disk_conf->disk_size = p_usize;
+
+			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
+			kvfree_rcu_mightsleep(old_disk_conf);
+
+			drbd_info(peer_device, "Peer sets u_size to %llu sectors (old: %llu)\n",
+				 (unsigned long long)p_usize, (unsigned long long)my_usize);
+			/* Do not set should_send_sizes here. That might cause packet storms */
+		}
+	}
+
+	if (connection->agreed_features & DRBD_FF_WSAME) {
+		struct o_qlim *qlim = p->qlim;
+
+		peer_device->q_limits.physical_block_size = be32_to_cpu(qlim->physical_block_size);
+		peer_device->q_limits.logical_block_size = be32_to_cpu(qlim->logical_block_size);
+		peer_device->q_limits.alignment_offset = be32_to_cpu(qlim->alignment_offset);
+		peer_device->q_limits.io_min = be32_to_cpu(qlim->io_min);
+		peer_device->q_limits.io_opt = be32_to_cpu(qlim->io_opt);
+	}
+
+	if (connection->agreed_features & DRBD_FF_BM_BLOCK_SHIFT) {
+		peer_device->bm_block_shift =
+			p->qlim->bm_block_shift_minus_12 + BM_BLOCK_SHIFT_4k;
+	} else {
+		int bbs = have_ldev ? bm_block_size(device->bitmap) : BM_BLOCK_SIZE_4k;
+		/* May work as long as this one is SyncTarget. May result in
+		 * funny never ending / repeating resyncs if the other guy is
+		 * SyncTarget, but unaware of bitmap granularity issues.
+		 */
+		if (bbs != BM_BLOCK_SIZE_4k)
+			drbd_warn(peer_device,
+				"My bitmap granularity is %u. Upgrade this peer to make it aware.\n",
+				bbs);
+		peer_device->bm_block_shift = BM_BLOCK_SHIFT_4k;
+	}
+
+	/* Leave drbd_reconsider_queue_parameters() before drbd_determine_dev_size().
+	   In case we cleared the QUEUE_FLAG_DISCARD from our queue in
+	   drbd_reconsider_queue_parameters(), we can be sure that after
+	   drbd_determine_dev_size() no REQ_OP_DISCARDs are in the queue. */
+	if (have_ldev) {
+		enum dds_flags local_ddsf = ddsf;
+
+		drbd_reconsider_queue_parameters(device, device->ldev);
+
+		/* To support thinly provisioned nodes (partial resync) joining later,
+		   clear all bitmap slots, including the unused ones. */
+		if (device->ldev->md.effective_size == 0)
+			local_ddsf |= DDSF_NO_RESYNC;
+
+		dd = drbd_determine_dev_size(device, p_csize, local_ddsf, NULL);
+
+		if (dd == DS_GREW || dd == DS_SHRUNK)
+			should_send_sizes = true;
+
+		if (dd == DS_ERROR) {
+			err = -EIO;
+			goto out;
+		}
+		drbd_md_sync_if_dirty(device);
+	} else {
+		uint64_t new_size = 0;
+
+		drbd_reconsider_queue_parameters(device, NULL);
+		/* In case I am diskless, need to accept the peer's *current* size.
+		 *
+		 * At this point, the peer knows more about my disk, or at
+		 * least about what we last agreed upon, than myself.
+		 * So if his c_size is less than his d_size, the most likely
+		 * reason is that *my* d_size was smaller last time we checked,
+		 * or some other peer does not (yet) have enough room.
+		 *
+		 * Unless of course he does not have a disk himself.
+		 * In which case we ignore this completely.
+		 */
+		new_size = p_csize;
+		new_size = min_not_zero(new_size, p_usize);
+		new_size = min_not_zero(new_size, p_size);
+
+		if (new_size == 0) {
+			/* Ignore, peer does not know nothing. */
+		} else if (new_size == cur_size) {
+			/* nothing to do */
+		} else if (cur_size != 0 && p_size == 0) {
+			dynamic_drbd_dbg(peer_device,
+					"Ignored diskless peer device size (peer:%llu != me:%llu sectors)!\n",
+					(unsigned long long)new_size, (unsigned long long)cur_size);
+		} else if (new_size < cur_size && device->resource->role[NOW] == R_PRIMARY) {
+			drbd_err(peer_device,
+				"The peer's device size is too small! (%llu < %llu sectors); demote me first!\n",
+				(unsigned long long)new_size, (unsigned long long)cur_size);
+			goto disconnect;
+		} else if (drbd_other_peer_smaller(peer_device, new_size)) {
+			dynamic_drbd_dbg(peer_device,
+					"Ignored peer device size (peer:%llu sectors); other peer smaller!\n",
+					(unsigned long long)new_size);
+		} else {
+			/* I believe the peer, if
+			 *  - I don't have a current size myself
+			 *  - we agree on the size anyways
+			 *  - I do have a current size, am Secondary,
+			 *    and he has the only disk
+			 *  - I do have a current size, am Primary,
+			 *    and he has the only disk,
+			 *    which is larger than my current size
+			 */
+			should_send_sizes = true;
+			drbd_set_my_capacity(device, new_size);
+		}
+	}
+
+	if (device->device_conf.max_bio_size > protocol_max_bio_size ||
+	    (connection->agreed_pro_version < 94 &&
+	     device->device_conf.max_bio_size > peer_device->q_limits.max_bio_size)) {
+		drbd_err(device, "Peer cannot deal with requests bigger than %u. "
+			 "Please reduce max_bio_size in the configuration.\n",
+			 peer_device->q_limits.max_bio_size);
+		goto disconnect;
+	}
+
+	if (have_ldev) {
+		if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev)) {
+			device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
+			should_send_sizes = true;
+		}
+
+		drbd_setup_order_type(device, be16_to_cpu(p->queue_order_type));
+	}
+
+	cur_size = get_capacity(device->vdisk);
+
+	for_each_peer_device_ref(peer_device_it, im, device) {
+		struct drbd_connection *con_it = peer_device_it->connection;
+
+		/* drop cached max_size, if we already grew beyond it */
+		if (peer_device_it->max_size < cur_size)
+			peer_device_it->max_size = 0;
+
+		if (con_it->cstate[NOW] < C_CONNECTED)
+			continue;
+
+		/* Send size updates only if something relevant has changed.
+		 * TODO: only tell the sender thread to do so,
+		 * or we may end up in a distributed deadlock on congestion. */
+
+		if (should_send_sizes)
+			drbd_send_sizes(peer_device_it, p_usize, ddsf);
+	}
+
+	maybe_trigger_resync(device, get_neighbor_device(device, NEXT_HIGHER),
+					dd == DS_GREW, ddsf & DDSF_NO_RESYNC);
+	maybe_trigger_resync(device, get_neighbor_device(device, NEXT_LOWER),
+					dd == DS_GREW, ddsf & DDSF_NO_RESYNC);
+	err = 0;
+
+out:
+	if (have_ldev)
+		put_ldev(device);
+	if (have_mutex)
+		mutex_unlock(&connection->resource->conf_update);
+	return err;
+
+disconnect:
+	/* don't let a rejected peer confuse future handshakes with different peers. */
+	peer_device->max_size = 0;
+
+	if (connection->resource->remote_state_change)
+		set_bit(TWOPC_RECV_SIZES_ERR, &connection->resource->flags);
+	else
+		err = -EIO;
+	goto out;
+}
+
+static enum sync_strategy resolve_splitbrain_from_disk_states(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	enum drbd_disk_state peer_disk_state = peer_device->disk_state[NOW];
+	enum drbd_disk_state disk_state = device->disk_state[NOW];
+
+	return  disk_state <= D_UP_TO_DATE && peer_disk_state == D_UP_TO_DATE ? SYNC_TARGET_USE_BITMAP :
+		disk_state == D_UP_TO_DATE && peer_disk_state <= D_UP_TO_DATE ? SYNC_SOURCE_USE_BITMAP :
+		SPLIT_BRAIN_AUTO_RECOVER;
+}
+
+static void drbd_resync(struct drbd_peer_device *peer_device,
+			enum resync_reason reason)
+{
+	enum drbd_role peer_role = peer_device->connection->peer_role[NOW];
+	enum drbd_repl_state new_repl_state;
+	enum drbd_disk_state peer_disk_state, announced_pdsk;
+	enum sync_strategy strategy;
+	enum sync_rule rule;
+	int peer_node_id;
+	enum drbd_state_rv rv;
+	const char *tag = reason == AFTER_UNSTABLE ? "after-unstable" : "diskless-primary";
+
+	strategy = drbd_handshake(peer_device, &rule, &peer_node_id, reason == DISKLESS_PRIMARY);
+	if (strategy == SPLIT_BRAIN_AUTO_RECOVER && reason == AFTER_UNSTABLE)
+		strategy = resolve_splitbrain_from_disk_states(peer_device);
+
+	if (!is_strategy_determined(strategy)) {
+		drbd_info(peer_device, "Unexpected result of handshake() %s!\n", strategy_descriptor(strategy).name);
+		return;
+	}
+
+	peer_disk_state = peer_device->disk_state[NOW];
+	/* the peer decides on the disk state it announced */
+	announced_pdsk = test_bit(PEER_UPGRADE_PREDICTED, peer_device->flags) ?
+		D_OUTDATED : peer_disk_state;
+	if (reason == DISKLESS_PRIMARY)
+		disk_states_to_strategy(peer_device, peer_disk_state, &strategy,
+					&rule, &peer_node_id);
+	else
+		maybe_reconcile_equal_uuid_bitmap(peer_device, peer_device->comm_state.disk,
+						  announced_pdsk, &strategy, &rule);
+
+	new_repl_state = strategy_to_repl_state(peer_device, peer_role, strategy);
+	if (new_repl_state != L_ESTABLISHED) {
+		bitmap_mod_after_handshake(peer_device, strategy, peer_node_id);
+		drbd_info(peer_device, "Becoming %s %s\n", drbd_repl_str(new_repl_state),
+			  reason == AFTER_UNSTABLE ? "after unstable" : "because primary is diskless");
+	}
+
+	/* No reconciliation resync with an UpToDate peer: we hold the current
+	 * generation, so we owe no post-loss reconcile to anyone.
+	 * Clear RECONCILE_PENDING and return to UpToDate (do not stay Consistent)
+	 */
+	if (new_repl_state == L_ESTABLISHED && peer_disk_state == D_UP_TO_DATE &&
+	    peer_device->device->disk_state[NOW] == D_CONSISTENT) {
+		struct drbd_device *device = peer_device->device;
+		struct drbd_peer_device *pd;
+		bool cleared = false;
+
+		rcu_read_lock();
+		for_each_peer_device_rcu(pd, device)
+			if (test_and_clear_bit(RECONCILE_PENDING, pd->flags))
+				cleared = true;
+		rcu_read_unlock();
+		if (cleared)
+			drbd_reconcile_settled_try_up_to_date(device->resource);
+	}
+
+	if (new_repl_state == L_ESTABLISHED && peer_disk_state >= D_CONSISTENT &&
+	    peer_device->device->disk_state[NOW] == D_OUTDATED) {
+		/* No resync with up-to-date peer -> I should be consistent or up-to-date as well.
+		   Note: Former unstable (but up-to-date) nodes become consistent for a short
+		   time after loosing their primary peer. Therefore consider consistent here
+		   as well. */
+		drbd_info(peer_device, "Upgrading local disk to %s after unstable/weak (and no resync).\n",
+			  drbd_disk_str(peer_disk_state));
+		change_disk_state(peer_device->device, peer_disk_state, CS_VERBOSE, tag, NULL);
+		return;
+	}
+
+	rv = change_repl_state(peer_device, new_repl_state, CS_VERBOSE, tag);
+	if ((rv == SS_NOTHING_TO_DO || rv == SS_RESYNC_RUNNING) &&
+	    (new_repl_state == L_WF_BITMAP_S || new_repl_state == L_WF_BITMAP_T)) {
+		/* Those events might happen very quickly. In case we are still processing
+		   the previous resync we need to re-enter that state. Schedule sending of
+		   the bitmap here explicitly */
+		peer_device->resync_again++;
+		drbd_info(peer_device, "...postponing this until current resync finished\n");
+	}
+}
+
+/* An Outdated peer upgrades itself when we trigger it (sanitize_state()); record
+ * that before its P_STATE, or a write in between is not replicated to it.
+ */
+void drbd_predict_peer_upgrade(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	enum drbd_disk_state disk_state = device->disk_state[NOW];
+	enum sync_strategy strategy;
+	unsigned long irq_flags;
+	enum sync_rule rule;
+	int peer_node_id;
+
+	/* An 8.4 peer does not upgrade itself on an established connection. */
+	if (peer_device->connection->agreed_pro_version < 110 ||
+	    disk_state < D_CONSISTENT || !get_ldev(device))
+		return;
+	strategy = drbd_handshake(peer_device, &rule, &peer_node_id, false);
+	reconcile_equal_uuid_bitmap_strategy(peer_device, disk_state, D_OUTDATED,
+					     &strategy, &rule);
+	put_ldev(device);
+	if (strategy != NO_SYNC)
+		return;
+
+	begin_state_change(device->resource, &irq_flags, CS_VERBOSE);
+	if (peer_device->repl_state[NOW] != L_ESTABLISHED ||
+	    peer_device->disk_state[NOW] != D_OUTDATED ||
+	    device->disk_state[NOW] != disk_state) {
+		abort_state_change(device->resource, &irq_flags);
+		return;
+	}
+	__change_peer_disk_state(peer_device, disk_state);
+	set_bit(PEER_UPGRADE_PREDICTED, peer_device->flags);
+	end_state_change(device->resource, &irq_flags, "peer-upgrade");
+}
+
+static void update_bitmap_slot_of_peer(struct drbd_peer_device *peer_device, int node_id, u64 bitmap_uuid)
+{
+	if (peer_device->bitmap_uuids[node_id] && bitmap_uuid == 0) {
+		/* If we learn from a neighbor that it no longer has a bitmap
+		   against a third node, we need to deduce from that knowledge
+		   that in the other direction the bitmap was cleared as well.
+		 */
+		struct drbd_peer_device *peer_device2;
+
+		rcu_read_lock();
+		peer_device2 = peer_device_by_node_id(peer_device->device, node_id);
+		if (peer_device2) {
+			int node_id2 = peer_device->connection->peer_node_id;
+
+			peer_device2->bitmap_uuids[node_id2] = 0;
+		}
+		rcu_read_unlock();
+	}
+
+	peer_device->bitmap_uuids[node_id] = bitmap_uuid;
+}
+
+static void propagate_skip_initial_to_diskless(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+	u64 im;
+
+	for_each_peer_device_ref(peer_device, im, device) {
+		if (peer_device->disk_state[NOW] == D_DISKLESS) {
+			drbd_send_uuids(peer_device, UUID_FLAG_SKIP_INITIAL_SYNC, 0);
+			peer_device->current_uuid = drbd_current_uuid(device);
+		}
+	}
+}
+
+static int __receive_uuids(struct drbd_peer_device *peer_device, u64 node_mask)
+{
+	enum drbd_repl_state repl_state = peer_device->repl_state[NOW];
+	struct drbd_device *device = peer_device->device;
+	struct drbd_resource *resource = device->resource;
+	int updated_uuids = 0, err = 0;
+	bool bad_server, uuid_match;
+	struct drbd_net_conf *nc;
+	bool two_primaries_allowed;
+
+	uuid_match =
+		(device->exposed_data_uuid & ~UUID_PRIMARY) ==
+		(peer_device->current_uuid & ~UUID_PRIMARY);
+	bad_server =
+		repl_state < L_ESTABLISHED &&
+		device->disk_state[NOW] < D_INCONSISTENT &&
+		device->resource->role[NOW] == R_PRIMARY && !uuid_match;
+
+	if (peer_device->connection->agreed_pro_version < 110 && bad_server) {
+		drbd_err(device, "Can only connect to data with current UUID=%016llX\n",
+		    (unsigned long long)device->exposed_data_uuid);
+		change_cstate(peer_device->connection, C_DISCONNECTING, CS_HARD);
+		return -EIO;
+	}
+
+	rcu_read_lock();
+	nc = rcu_dereference(peer_device->connection->transport.net_conf);
+	two_primaries_allowed = nc && nc->two_primaries;
+	rcu_read_unlock();
+
+	if (get_ldev(device)) {
+		bool skip_initial_sync =
+			repl_state == L_ESTABLISHED &&
+			peer_device->connection->agreed_pro_version >= 90 &&
+			drbd_current_uuid(device) == UUID_JUST_CREATED &&
+			(peer_device->uuid_flags & UUID_FLAG_SKIP_INITIAL_SYNC);
+		if (skip_initial_sync) {
+			unsigned long irq_flags;
+
+			drbd_info(device, "Accepted new current UUID, preparing to skip initial sync\n");
+			drbd_bitmap_io(device, &drbd_bmio_clear_all_n_write,
+					"clear_n_write from receive_uuids",
+					BM_LOCK_SET | BM_LOCK_CLEAR | BM_LOCK_BULK, NULL);
+			_drbd_uuid_set_current(device, peer_device->current_uuid);
+			peer_device->comm_current_uuid = peer_device->current_uuid;
+			peer_device->comm_uuid_flags = peer_device->uuid_flags;
+			peer_device->comm_bitmap_uuid = 0;
+			_drbd_uuid_set_bitmap(peer_device, 0);
+			begin_state_change(device->resource, &irq_flags, CS_VERBOSE);
+			__change_disk_state(device, D_UP_TO_DATE);
+			__change_peer_disk_state(peer_device, D_UP_TO_DATE);
+			end_state_change(device->resource, &irq_flags, "skip-initial-sync");
+			updated_uuids = 1;
+			propagate_skip_initial_to_diskless(device);
+		}
+
+		if (peer_device->uuid_flags & UUID_FLAG_NEW_DATAGEN)
+			drbd_uuid_received_new_current(peer_device, peer_device->current_uuid, node_mask);
+
+		drbd_uuid_detect_finished_resyncs(peer_device);
+
+		drbd_md_sync_if_dirty(device);
+		put_ldev(device);
+	} else if (device->disk_state[NOW] < D_INCONSISTENT && repl_state >= L_ESTABLISHED &&
+		   peer_device->disk_state[NOW] == D_UP_TO_DATE && !uuid_match &&
+		   (resource->role[NOW] == R_SECONDARY ||
+		    (two_primaries_allowed &&
+		     drbd_gen_obligation_discharge_by_adoption(device)))) {
+
+		write_lock_irq(&resource->state_rwlock);
+		if (resource->remote_state_change) {
+			drbd_info(peer_device, "Delaying update of exposed data uuid\n");
+			device->next_exposed_data_uuid = peer_device->current_uuid;
+		} else {
+			updated_uuids =
+				drbd_uuid_set_exposed(device, peer_device->current_uuid, false);
+		}
+		write_unlock_irq(&resource->state_rwlock);
+
+	}
+
+	if (device->disk_state[NOW] == D_DISKLESS && uuid_match &&
+	    peer_device->disk_state[NOW] == D_CONSISTENT) {
+		drbd_info(peer_device, "Peer is on same UUID now\n");
+		change_peer_disk_state(peer_device, D_UP_TO_DATE, CS_VERBOSE, "receive-uuids");
+	}
+
+	if (updated_uuids)
+		drbd_print_uuids(peer_device, "receiver updated UUIDs to");
+
+	peer_device->uuid_node_mask = node_mask;
+
+	if ((repl_state == L_SYNC_TARGET || repl_state == L_PAUSED_SYNC_T) &&
+	    !(peer_device->uuid_flags & UUID_FLAG_STABLE) &&
+	    !drbd_stable_sync_source_present(peer_device, NOW))
+		set_bit(UNSTABLE_RESYNC, peer_device->flags);
+
+	/* send notification in case UUID flags have changed */
+	drbd_broadcast_peer_device_state(peer_device);
+
+	return err;
+}
+
+/* drbd 8.4 compat */
+static int receive_uuids(struct drbd_connection *connection, struct packet_info *pi)
+{
+	const int node_id = connection->resource->res_opts.node_id;
+	struct drbd_peer_device *peer_device;
+	struct p_uuids *p = pi->data;
+	int history_uuids, i;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+
+	history_uuids = min_t(int, HISTORY_UUIDS_V08,
+			      ARRAY_SIZE(peer_device->history_uuids));
+
+	peer_device->current_uuid = be64_to_cpu(p->current_uuid);
+	peer_device->bitmap_uuids[node_id] = be64_to_cpu(p->bitmap_uuid);
+	for (i = 0; i < history_uuids; i++)
+		peer_device->history_uuids[i] = be64_to_cpu(p->history_uuids[i]);
+	for (; i < ARRAY_SIZE(peer_device->history_uuids); i++)
+		peer_device->history_uuids[i] = 0;
+	peer_device->dirty_bits = be64_to_cpu(p->dirty_bits);
+	peer_device->uuid_flags = be64_to_cpu(p->uuid_flags) | UUID_FLAG_STABLE;
+	set_bit(UUIDS_RECEIVED, peer_device->flags);
+
+	return __receive_uuids(peer_device, 0);
+}
+
+static int receive_uuids110(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_uuids110 *p = pi->data;
+	int bitmap_uuids, history_uuids, rest, i, pos, err;
+	u64 bitmap_uuids_mask, node_mask;
+	struct drbd_peer_md *peer_md = NULL;
+	struct drbd_device *device;
+	int not_allocated = -1;
+
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+
+	device = peer_device->device;
+	bitmap_uuids_mask = be64_to_cpu(p->bitmap_uuids_mask);
+	if (bitmap_uuids_mask & ~(NODE_MASK(DRBD_PEERS_MAX) - 1))
+		return -EIO;
+	bitmap_uuids = hweight64(bitmap_uuids_mask);
+
+	if (pi->size / sizeof(p->other_uuids[0]) < bitmap_uuids)
+		return -EIO;
+	history_uuids = pi->size / sizeof(p->other_uuids[0]) - bitmap_uuids;
+	if (history_uuids > ARRAY_SIZE(peer_device->history_uuids))
+		history_uuids = ARRAY_SIZE(peer_device->history_uuids);
+
+	err = drbd_recv_into(connection, p->other_uuids,
+			     (bitmap_uuids + history_uuids) *
+			     sizeof(p->other_uuids[0]));
+	if (err)
+		return err;
+
+	rest = pi->size - (bitmap_uuids + history_uuids) * sizeof(p->other_uuids[0]);
+	if (rest) {
+		err = ignore_remaining_packet(connection, rest);
+		if (err)
+			return err;
+	}
+
+	if (get_ldev(device)) {
+		peer_md = device->ldev->md.peers;
+		spin_lock_irq(&device->ldev->md.uuid_lock);
+	}
+
+	/* The condition below keeps a diskless primary's exposed current UUID
+	 * from going backward when a stale/older value is reported (see commit
+	 * 2f464b8e8 "drbd: fix exposed_uuid going backward").  But that
+	 * protection must only apply to a CONFIRMED generation.  If our view of
+	 * this peer's current UUID was advanced only optimistically by our own
+	 * UUID bump (CURRENT_UUID_UNCONFIRMED) and the peer never actually got
+	 * it, the peer's handshake report is the truth -- take it, so we do not
+	 * treat the peer as UpToDate at a generation it never persisted.
+	 */
+	if (test_bit(CURRENT_UUID_UNCONFIRMED, peer_device->flags) ||
+	    device->resource->role[NOW] != R_PRIMARY ||
+	    device->disk_state[NOW] != D_DISKLESS ||
+	    (peer_device->current_uuid & ~UUID_PRIMARY) !=
+						(device->exposed_data_uuid & ~UUID_PRIMARY) ||
+	    (peer_device->comm_current_uuid & ~UUID_PRIMARY) !=
+						(device->exposed_data_uuid & ~UUID_PRIMARY))
+		peer_device->current_uuid = be64_to_cpu(p->current_uuid);
+
+	peer_device->dirty_bits = be64_to_cpu(p->dirty_bits);
+	peer_device->uuid_flags = be64_to_cpu(p->uuid_flags);
+	if (peer_device->uuid_flags & UUID_FLAG_HAS_UNALLOC) {
+		not_allocated = peer_device->uuid_flags >> UUID_FLAG_UNALLOC_SHIFT;
+		peer_device->uuid_flags &= ~UUID_FLAG_UNALLOC_MASK;
+	}
+
+	pos = 0;
+	for (i = 0; i < ARRAY_SIZE(peer_device->bitmap_uuids); i++) {
+		u64 bitmap_uuid;
+
+		if (bitmap_uuids_mask & NODE_MASK(i)) {
+			bitmap_uuid = be64_to_cpu(p->other_uuids[pos++]);
+
+			if (peer_md && !test_bit(__MDF_HAVE_BITMAP, &peer_md[i].flags) &&
+			    i != not_allocated)
+				set_bit(__MDF_NODE_EXISTS, &peer_md[i].flags);
+		} else {
+			bitmap_uuid = -1;
+		}
+
+		update_bitmap_slot_of_peer(peer_device, i, bitmap_uuid);
+	}
+
+	for (i = 0; i < history_uuids; i++)
+		peer_device->history_uuids[i] = be64_to_cpu(p->other_uuids[pos++]);
+	while (i < ARRAY_SIZE(peer_device->history_uuids))
+		peer_device->history_uuids[i++] = 0;
+	set_bit(UUIDS_RECEIVED, peer_device->flags);
+	if (peer_md) {
+		spin_unlock_irq(&device->ldev->md.uuid_lock);
+		put_ldev(device);
+	}
+
+	node_mask = be64_to_cpu(p->node_mask);
+
+	if (peer_device->connection->peer_role[NOW] == R_PRIMARY &&
+	    peer_device->uuid_flags & UUID_FLAG_STABLE)
+		check_resync_source(peer_device, node_mask);
+
+	err = __receive_uuids(peer_device, node_mask);
+
+	if (!test_bit(RECONCILIATION_RESYNC, peer_device->flags)) {
+		if (peer_device->uuid_flags & UUID_FLAG_GOT_STABLE) {
+			struct drbd_device *device = peer_device->device;
+
+			if (peer_device->repl_state[NOW] == L_ESTABLISHED &&
+			    drbd_device_stable(device, NULL) && get_ldev(device)) {
+				drbd_send_uuids(peer_device, UUID_FLAG_RESYNC, 0);
+				drbd_resync(peer_device, AFTER_UNSTABLE);
+				put_ldev(device);
+			}
+		}
+
+		if (peer_device->uuid_flags & UUID_FLAG_RESYNC) {
+			if (get_ldev(device)) {
+				bool dp = peer_device->uuid_flags & UUID_FLAG_DISKLESS_PRIMARY;
+
+				drbd_resync(peer_device, dp ? DISKLESS_PRIMARY : AFTER_UNSTABLE);
+				put_ldev(device);
+			}
+		}
+	}
+
+	return err;
+}
+
+/*
+ * Nothing else restarts a resync that check_resync_source() aborted: with no
+ * other resync queued the target would stay Inconsistent next to an UpToDate
+ * Primary until a reconnect. Carry the blocks the weak source still owed over
+ * to the Primary's bitmap slot and resync from the Primary instead.
+ */
+static void resync_from_primary_after_abort(struct drbd_peer_device *primary_pd,
+					    struct drbd_peer_device *weak_pd)
+{
+	struct drbd_device *device = primary_pd->device;
+	enum drbd_repl_state weak_rs = weak_pd->repl_state[NOW];
+
+	/* The weak peer started resyncing again while we drained. */
+	if (weak_rs == L_SYNC_TARGET || weak_rs == L_PAUSED_SYNC_T)
+		return;
+
+	if (primary_pd->repl_state[NOW] != L_ESTABLISHED ||
+	    primary_pd->disk_state[NOW] != D_UP_TO_DATE ||
+	    device->disk_state[NOW] >= D_UP_TO_DATE)
+		return;
+
+	if (!get_ldev(device))
+		return;
+
+	/* Without both slots the owed blocks cannot be carried over. */
+	if (weak_pd->bitmap_index == -1 || primary_pd->bitmap_index == -1) {
+		put_ldev(device);
+		return;
+	}
+
+	drbd_suspend_io(device, WRITE_ONLY);
+	drbd_bm_slot_lock(primary_pd, "or_slot after resync abort", BM_LOCK_BULK);
+	drbd_bm_or_slot(device, weak_pd->bitmap_index, primary_pd->bitmap_index);
+	drbd_bm_write(device, NULL);
+	drbd_bm_slot_unlock(primary_pd);
+	drbd_resume_io(device);
+
+	drbd_info(primary_pd, "Resyncing from the primary instead of the weak sync source\n");
+	drbd_send_uuids(primary_pd, UUID_FLAG_RESYNC, 0);
+	drbd_resync(primary_pd, AFTER_UNSTABLE);
+	put_ldev(device);
+}
+
+/**
+ * check_resync_source() - Abort resync if the source is weak
+ * @primary_pd: The peer device of the primary that reported @weak_nodes
+ * @weak_nodes: Mask of currently weak nodes in the cluster
+ *
+ * If a primary loses connection to a SYNC_SOURCE node from us, then we
+ * need to abort that resync. Why?
+ *
+ * When the primary sends a write, we get that and write that as well. With
+ * the peer_ack packet, we will set that as out-of-sync towards the sync
+ * source node.
+ * When the resync process finds such bits, we request outdated
+ * data from the sync source!
+ * We are stopping the resync from such an outdated source here and waiting
+ * until all the resync activity has drained (P_RS_DATA_REPLY packets).
+ */
+static void check_resync_source(struct drbd_peer_device *primary_pd, u64 weak_nodes)
+{
+	struct drbd_device *device = primary_pd->device;
+	struct drbd_peer_device *peer_device;
+	struct drbd_connection *connection;
+	int err;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		enum drbd_repl_state repl_state = peer_device->repl_state[NOW];
+
+		if ((repl_state == L_SYNC_TARGET || repl_state == L_PAUSED_SYNC_T) &&
+		    NODE_MASK(peer_device->node_id) & weak_nodes) {
+			rcu_read_unlock();
+			goto abort;
+		}
+	}
+	rcu_read_unlock();
+	return;
+abort:
+	connection = peer_device->connection;
+	drbd_info(peer_device, "My sync source became a weak node, aborting resync!\n");
+	if (change_repl_state(peer_device, L_ESTABLISHED, CS_VERBOSE, "abort-resync") < SS_SUCCESS)
+		return;
+	drbd_flush_workqueue(&connection->sender_work);
+	drbd_cancel_conflicting_resync_requests(peer_device);
+
+	/* Wait for the replies still in flight, then for their writes. */
+	err = wait_event_interruptible(device->misc_wait,
+				       peer_device->repl_state[NOW] < L_ESTABLISHED ||
+				       atomic_read(&peer_device->rs_pending_cnt) == 0);
+	if (!err)
+		err = wait_event_interruptible(connection->ee_wait,
+					       peer_device->repl_state[NOW] < L_ESTABLISHED ||
+					       atomic_read(&connection->backing_ee_cnt) == 0);
+
+	peer_device->rs_total  = 0;
+	peer_device->rs_failed = 0;
+	peer_device->rs_paused = 0;
+
+	/* Interrupted, resync replies from the weak source may still arrive. */
+	if (err)
+		return;
+
+	resync_from_primary_after_abort(primary_pd, peer_device);
+}
+
+/**
+ * convert_state() - Converts the peer's view of the cluster state to our point of view
+ * @peer_state:	The state as seen by the peer.
+ */
+static union drbd_state convert_state(union drbd_state peer_state)
+{
+	union drbd_state state;
+
+	static unsigned int c_tab[] = {
+		[L_OFF] = L_OFF,
+		[L_ESTABLISHED] = L_ESTABLISHED,
+
+		[L_STARTING_SYNC_S] = L_STARTING_SYNC_T,
+		[L_STARTING_SYNC_T] = L_STARTING_SYNC_S,
+		[L_WF_BITMAP_S] = L_WF_BITMAP_T,
+		[L_WF_BITMAP_T] = L_WF_BITMAP_S,
+		[C_DISCONNECTING] = C_TEAR_DOWN, /* C_NETWORK_FAILURE, */
+		[C_CONNECTING] = C_CONNECTING,
+		[L_VERIFY_S] = L_VERIFY_T,
+		[C_MASK] = C_MASK,
+	};
+
+	state.i = peer_state.i;
+
+	state.conn = c_tab[peer_state.conn];
+	state.peer = peer_state.role;
+	state.role = peer_state.peer;
+	state.pdsk = peer_state.disk;
+	state.disk = peer_state.pdsk;
+	state.peer_isp = (peer_state.aftr_isp | peer_state.user_isp);
+
+	return state;
+}
+
+static enum drbd_state_rv
+__change_connection_state(struct drbd_connection *connection,
+			  union drbd_state mask, union drbd_state val,
+			  enum chg_state_flags flags)
+{
+	struct drbd_resource *resource = connection->resource;
+
+	if (mask.role) {
+		/* not allowed */
+	}
+	if (mask.susp) {
+		mask.susp ^= -1;
+		/* Only resume-io lifts a suspend-io. */
+		if (val.susp)
+			__change_io_susp_user(resource, true);
+	}
+	if (mask.susp_nod) {
+		mask.susp_nod ^= -1;
+		__change_io_susp_no_data(resource, val.susp_nod);
+	}
+	if (mask.susp_fen) {
+		mask.susp_fen ^= -1;
+		__change_io_susp_fencing(connection, val.susp_fen);
+	}
+	if (mask.disk) {
+		/* Handled in __change_peer_device_state(). */
+		mask.disk ^= -1;
+	}
+	if (mask.conn) {
+		mask.conn ^= -1;
+		__change_cstate(connection,
+				min_t(enum drbd_conn_state, val.conn, C_CONNECTED));
+	}
+	if (mask.pdsk) {
+		/* Handled in __change_peer_device_state(). */
+		mask.pdsk ^= -1;
+	}
+	if (mask.peer) {
+		mask.peer ^= -1;
+		__change_peer_role(connection, val.peer);
+	}
+	if (mask.i) {
+		drbd_info(connection, "Remote state change: request %u/%u not "
+		"understood\n", mask.i, val.i & mask.i);
+		return SS_NOT_SUPPORTED;
+	}
+	return SS_SUCCESS;
+}
+
+static enum drbd_state_rv
+__change_peer_device_state(struct drbd_peer_device *peer_device,
+			   union drbd_state mask, union drbd_state val)
+{
+	struct drbd_device *device = peer_device->device;
+
+	if (mask.peer) {
+		/* Handled in __change_connection_state(). */
+		mask.peer ^= -1;
+	}
+	if (mask.disk) {
+		mask.disk ^= -1;
+		__change_disk_state(device, val.disk);
+	}
+
+	if (mask.conn) {
+		mask.conn ^= -1;
+		__change_repl_state(peer_device,
+				max_t(enum drbd_repl_state, val.conn, L_OFF));
+	}
+	if (mask.pdsk) {
+		mask.pdsk ^= -1;
+		__change_peer_disk_state(peer_device, val.pdsk);
+	}
+	if (mask.user_isp) {
+		mask.user_isp ^= -1;
+		__change_resync_susp_user(peer_device, val.user_isp);
+	}
+	if (mask.peer_isp) {
+		mask.peer_isp ^= -1;
+		__change_resync_susp_peer(peer_device, val.peer_isp);
+	}
+	if (mask.aftr_isp) {
+		mask.aftr_isp ^= -1;
+		__change_resync_susp_dependency(peer_device, val.aftr_isp);
+	}
+	if (mask.i) {
+		drbd_info(peer_device, "Remote state change: request %u/%u not "
+		"understood\n", mask.i, val.i & mask.i);
+		return SS_NOT_SUPPORTED;
+	}
+	return SS_SUCCESS;
+}
+
+static union drbd_state
+sanitize_outdate(struct drbd_peer_device *peer_device,
+		 union drbd_state mask,
+		 union drbd_state val)
+{
+	struct drbd_device *device = peer_device->device;
+	union drbd_state result_mask = mask;
+
+	if (val.pdsk == D_OUTDATED && peer_device->disk_state[NEW] < D_OUTDATED)
+		result_mask.pdsk = 0;
+	if (val.disk == D_OUTDATED && device->disk_state[NEW] < D_OUTDATED)
+		result_mask.disk = 0;
+
+	return result_mask;
+}
+
+static void log_openers(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		struct opener *opener;
+
+		spin_lock(&device->openers_lock);
+		opener = list_first_entry_or_null(&device->openers, struct opener, list);
+		if (opener)
+			drbd_warn(device, "Held open by %s(%d)\n", opener->comm, opener->pid);
+		spin_unlock(&device->openers_lock);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * change_connection_state()  -  change state of a connection and all its peer devices
+ * @connection: DRBD connection to operate on
+ * @state_change: Prepared state change
+ * @reply: Two phase commit reply
+ * @flags: State change flags
+ *
+ * Also changes the state of the peer devices' devices and of the resource.
+ * Cluster-wide state changes are not supported.
+ */
+static enum drbd_state_rv
+change_connection_state(struct drbd_connection *connection,
+			struct twopc_state_change *state_change,
+			struct twopc_reply *reply,
+			enum chg_state_flags flags)
+{
+	struct drbd_resource *resource = connection->resource;
+	long t = resource->res_opts.auto_promote_timeout * HZ / 10;
+	union drbd_state mask = state_change->mask;
+	union drbd_state val = state_change->val;
+	bool is_disconnect = false;
+	bool is_connect = false;
+	bool abort = flags & CS_ABORT;
+	struct drbd_peer_device *peer_device;
+	unsigned long irq_flags;
+	enum drbd_state_rv rv;
+	int vnr;
+
+	if (reply) {
+		is_disconnect = reply->is_disconnect;
+		is_connect = reply->is_connect;
+	} else if (mask.conn == conn_MASK) {
+		is_connect = val.conn == C_CONNECTED;
+		is_disconnect = val.conn == C_DISCONNECTING;
+	}
+
+	mask = convert_state(mask);
+	val = convert_state(val);
+
+	if (is_connect && connection->agreed_pro_version >= 118) {
+		if (flags & CS_PREPARE)
+			conn_connect2(connection);
+		if (abort)
+			abort_connect(connection);
+	}
+retry:
+	begin_state_change(resource, &irq_flags, flags & ~CS_VERBOSE);
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		union drbd_state l_mask;
+
+		l_mask = is_disconnect ? sanitize_outdate(peer_device, mask, val) : mask;
+		rv = __change_peer_device_state(peer_device, l_mask, val);
+		if (rv < SS_SUCCESS)
+			goto fail;
+	}
+	rv = __change_connection_state(connection, mask, val, flags);
+	if (rv < SS_SUCCESS)
+		goto fail;
+
+	if (reply && !abort) {
+		u64 directly_reachable = directly_connected_nodes(resource, NEW) |
+			NODE_MASK(resource->res_opts.node_id);
+
+		if (reply->primary_nodes & ~directly_reachable)
+			__outdate_myself(resource);
+	}
+
+	if (is_connect && connection->agreed_pro_version >= 117)
+		apply_connect(connection, (flags & CS_PREPARED) && !abort);
+	rv = end_state_change(resource, &irq_flags, "remote");
+out:
+
+	if (((rv == SS_NO_UP_TO_DATE_DISK && resource->role[NOW] != R_PRIMARY) ||
+	     rv == SS_PRIMARY_READER) && drbd_open_ro_count(resource)) {
+		/* Most probably udev opened it read-only. That might happen
+		   if it was demoted very recently. Wait up to one second. */
+		t = wait_event_interruptible_timeout(resource->state_wait,
+						     drbd_open_ro_count(resource) == 0,
+						     t);
+		if (t > 0)
+			goto retry;
+	}
+
+	if (rv < SS_SUCCESS) {
+		drbd_err(resource, "State change failed: %s (%d)\n", drbd_set_st_err_str(rv), rv);
+		if (rv == SS_PRIMARY_READER)
+			log_openers(resource);
+	}
+
+	return rv;
+fail:
+	abort_state_change(resource, &irq_flags);
+	goto out;
+}
+
+/**
+ * change_peer_device_state()  -  change state of a peer and its connection
+ * @peer_device: DRBD peer device
+ * @state_change: Prepared state change
+ * @flags: State change flags
+ *
+ * Also changes the state of the peer device's device and of the resource.
+ * Cluster-wide state changes are not supported.
+ */
+static enum drbd_state_rv
+change_peer_device_state(struct drbd_peer_device *peer_device,
+			 struct twopc_state_change *state_change,
+			 enum chg_state_flags flags)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	union drbd_state mask = state_change->mask;
+	union drbd_state val = state_change->val;
+	unsigned long irq_flags;
+	enum drbd_state_rv rv;
+
+	mask = convert_state(mask);
+	val = convert_state(val);
+
+	begin_state_change(connection->resource, &irq_flags, flags);
+	rv = __change_peer_device_state(peer_device, mask, val);
+	if (rv < SS_SUCCESS)
+		goto fail;
+	rv = __change_connection_state(connection, mask, val, flags);
+	if (rv < SS_SUCCESS)
+		goto fail;
+	rv = end_state_change(connection->resource, &irq_flags, "remote");
+out:
+	return rv;
+fail:
+	abort_state_change(connection->resource, &irq_flags);
+	goto out;
+}
+
+static int receive_req_state(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct twopc_state_change *state_change = &resource->twopc.state_change;
+	struct drbd_peer_device *peer_device = NULL;
+	struct p_req_state *p = pi->data;
+	enum chg_state_flags flags = CS_VERBOSE | CS_LOCAL_ONLY | CS_TWOPC;
+	enum drbd_state_rv rv;
+	int vnr = -1;
+
+	if (!expect(connection, connection->agreed_pro_version < 110)) {
+		drbd_err(connection, "Packet %s not allowed in protocol version %d\n",
+			 drbd_packet_name(pi->cmd),
+			 connection->agreed_pro_version);
+		return -EIO;
+	}
+
+	state_change->mask.i = be32_to_cpu(p->mask);
+	state_change->val.i = be32_to_cpu(p->val);
+
+	/* Only val holds disk states; mask.disk and mask.pdsk are bit masks. */
+	drbd_disk_states_from_84(&state_change->val);
+
+	/* P_STATE_CHG_REQ packets must have a valid vnr.  P_CONN_ST_CHG_REQ
+	 * packets have an undefined vnr. */
+	if (pi->cmd == P_STATE_CHG_REQ) {
+		peer_device = conn_peer_device(connection, pi->vnr);
+		if (!peer_device) {
+			const union drbd_state conn_mask = { .conn = conn_MASK };
+			const union drbd_state val_off = { .conn = L_OFF };
+
+			if (state_change->mask.i == conn_mask.i &&
+			    state_change->val.i == val_off.i) {
+				/* The peer removed this volume, we do not have it... */
+				drbd_send_sr_reply(connection, vnr, SS_NOTHING_TO_DO);
+				return 0;
+			}
+
+			return -EIO;
+		}
+		vnr = peer_device->device->vnr;
+	}
+
+	rv = SS_SUCCESS;
+	write_lock_irq(&resource->state_rwlock);
+	if (resource->remote_state_change)
+		rv = SS_CONCURRENT_ST_CHG;
+	else
+		resource->remote_state_change = true;
+	write_unlock_irq(&resource->state_rwlock);
+
+	if (rv != SS_SUCCESS) {
+		drbd_info(connection, "Rejecting concurrent remote state change\n");
+		drbd_send_sr_reply(connection, vnr, rv);
+		return 0;
+	}
+
+	/* Send the reply before carrying out the state change: this is needed
+	 * for connection state changes which close the network connection.  */
+	if (peer_device) {
+		rv = change_peer_device_state(peer_device, state_change, flags | CS_PREPARE);
+		drbd_send_sr_reply(connection, vnr, rv);
+		rv = change_peer_device_state(peer_device, state_change, flags | CS_PREPARED);
+		if (rv >= SS_SUCCESS)
+			drbd_md_sync_if_dirty(peer_device->device);
+	} else {
+		flags |= CS_IGN_OUTD_FAIL;
+		rv = change_connection_state(connection, state_change, NULL, flags | CS_PREPARE);
+		drbd_send_sr_reply(connection, vnr, rv);
+		change_connection_state(connection, state_change, NULL, flags | CS_PREPARED);
+	}
+
+	write_lock_irq(&resource->state_rwlock);
+	resource->remote_state_change = false;
+	write_unlock_irq(&resource->state_rwlock);
+	wake_up_all(&resource->twopc_wait);
+
+	return 0;
+}
+
+static void drbd_abort_twopc(struct drbd_resource *resource)
+{
+	int initiator_node_id = resource->twopc_reply.initiator_node_id;
+	bool is_connect = resource->twopc_reply.is_connect;
+	struct drbd_connection *connection;
+
+	if (initiator_node_id == -1)
+		return;
+
+	connection = drbd_get_connection_by_node_id(resource, initiator_node_id);
+	resource->twopc_parent_nodes = 0;
+	__clear_remote_state_change(resource);
+
+	/* No commit or abort follows to end the connect. */
+	if (connection) {
+		if (is_connect)
+			abort_connect(connection);
+		kref_put(&connection->kref, drbd_destroy_connection);
+	}
+}
+
+void twopc_timer_fn(struct timer_list *t)
+{
+	struct drbd_resource *resource = timer_container_of(resource, t, twopc_timer);
+	unsigned long irq_flags;
+
+	write_lock_irqsave(&resource->state_rwlock, irq_flags);
+	if (!test_bit(TWOPC_WORK_PENDING, &resource->flags)) {
+		drbd_err(resource, "Two-phase commit %u timeout\n",
+			   resource->twopc_reply.tid);
+		drbd_abort_twopc(resource);
+	} else {
+		mod_timer(&resource->twopc_timer, jiffies + HZ/10);
+	}
+	write_unlock_irqrestore(&resource->state_rwlock, irq_flags);
+}
+
+bool drbd_have_local_disk(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (device->disk_state[NOW] > D_DISKLESS) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
+static enum drbd_state_rv
+far_away_change(struct drbd_connection *connection,
+		struct twopc_request *request,
+		struct twopc_reply *reply,
+		enum chg_state_flags flags)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct twopc_state_change *state_change = &resource->twopc.state_change;
+	u64 directly_reachable = directly_connected_nodes(resource, NOW) |
+		NODE_MASK(resource->res_opts.node_id);
+	union drbd_state mask = state_change->mask;
+	union drbd_state val = state_change->val;
+	int vnr = resource->twopc_reply.vnr;
+	struct drbd_device *device;
+	unsigned long irq_flags;
+	int iterate_vnr;
+
+
+	if (flags & CS_PREPARE && mask.role == role_MASK && val.role == R_PRIMARY &&
+	    resource->role[NOW] == R_PRIMARY) {
+		struct drbd_net_conf *nc;
+		bool two_primaries_allowed = false;
+
+		rcu_read_lock();
+		nc = rcu_dereference(connection->transport.net_conf);
+		if (nc)
+			two_primaries_allowed = nc->two_primaries;
+		rcu_read_unlock();
+		if (!two_primaries_allowed)
+			return SS_TWO_PRIMARIES;
+
+		/* A node further away wants to become primary. In case I am primary allow it only
+		 * when I am diskless. See also check_primaries_distances() in drbd_state.c
+		 */
+		if (drbd_have_local_disk(resource))
+			return SS_WEAKLY_CONNECTED;
+	}
+
+	begin_state_change(resource, &irq_flags, flags);
+	if (mask.i == 0 && val.i == 0 &&
+	    resource->role[NOW] == R_PRIMARY && vnr == -1) {
+		/* A node far away test if there are primaries. I am the guy he is concerned
+		 * about... He learned about me in the CS_PREPARE phase. Since he is committing it
+		 * I know that he is outdated now...
+		 */
+		struct drbd_connection *affected_connection;
+		int initiator_node_id = resource->twopc_reply.initiator_node_id;
+
+		affected_connection = drbd_get_connection_by_node_id(resource, initiator_node_id);
+		if (affected_connection) {
+			__downgrade_peer_disk_states(affected_connection, D_OUTDATED);
+			kref_put(&affected_connection->kref, drbd_destroy_connection);
+		} else if (flags & CS_PREPARED) {
+			idr_for_each_entry(&resource->devices, device, iterate_vnr) {
+				struct drbd_peer_md *peer_md;
+
+				if (!get_ldev(device))
+					continue;
+
+				peer_md = &device->ldev->md.peers[initiator_node_id];
+				set_bit(__MDF_PEER_OUTDATED, &peer_md->flags);
+				put_ldev(device);
+				drbd_md_mark_dirty(device);
+			}
+		}
+	}
+
+	if (state_change->primary_nodes & ~directly_reachable &&
+	    !(request->flags & TWOPC_PRI_INCAPABLE))
+		__outdate_myself(resource);
+
+	idr_for_each_entry(&resource->devices, device, iterate_vnr) {
+		if (test_bit(OUTDATE_ON_2PC_COMMIT, &device->flags) &&
+		    device->disk_state[NEW] > D_OUTDATED)
+			__change_disk_state(device, D_OUTDATED);
+	}
+
+	/* even if no outdate happens, CS_FORCE_RECALC might be set here */
+	return end_state_change(resource, &irq_flags, "far-away");
+}
+
+static void handle_neighbor_demotion(struct drbd_connection *connection,
+				     struct twopc_state_change *state_change,
+				     struct twopc_reply *reply)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_device *device;
+	int vnr;
+
+	if (reply->initiator_node_id != connection->peer_node_id ||
+	    connection->peer_role[NOW] != R_PRIMARY ||
+	    state_change->mask.role != role_MASK || state_change->val.role != R_SECONDARY)
+		return;
+
+	/* A directly connected neighbor that was primary demotes to secondary */
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		kref_get(&device->kref);
+		rcu_read_unlock();
+		if (get_ldev(device)) {
+			drbd_bitmap_io(device, &drbd_bm_write, "peer demote",
+				       BM_LOCK_SET | BM_LOCK_CLEAR | BM_LOCK_BULK, NULL);
+			put_ldev(device);
+		}
+		rcu_read_lock();
+		kref_put(&device->kref, drbd_destroy_device);
+	}
+	rcu_read_unlock();
+}
+
+static void peer_device_init_connect_state(struct drbd_peer_device *peer_device)
+{
+	clear_bit(INITIAL_STATE_SENT, peer_device->flags);
+	clear_bit(INITIAL_STATE_RECEIVED, peer_device->flags);
+	clear_bit(HAVE_SIZES, peer_device->flags);
+	clear_bit(UUIDS_RECEIVED, peer_device->flags);
+	clear_bit(CURRENT_UUID_RECEIVED, peer_device->flags);
+	clear_bit(PEER_QUORATE, peer_device->flags);
+	clear_bit(PEER_UPGRADE_PREDICTED, peer_device->flags);
+	peer_device->connect_state = (union drbd_state) {{ .disk = D_MASK }};
+}
+
+
+/**
+ * drbd_init_connect_state() - Prepare twopc that establishes the connection
+ * @connection:	The connection this is about
+ *
+ * After a transport implementation has established the lower-level aspects
+ * of a connection, DRBD executes a two-phase commit so that the membership
+ * information changes in a cluster-wide, consistent way. During that
+ * two-phase commit, DRBD exchanges the UUIDs, size information, and the
+ * initial state. A two-phase commit might be aborted, which needs to be
+ * retried. This function re-initializes the struct members for this. The
+ * callsites are at the beginning of a two-phase connect commit, active and
+ * passive side.
+ */
+void drbd_init_connect_state(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		peer_device_init_connect_state(peer_device);
+	rcu_read_unlock();
+	clear_bit(CONN_HANDSHAKE_DISCONNECT, &connection->flags);
+	clear_bit(CONN_HANDSHAKE_RETRY, &connection->flags);
+	clear_bit(CONN_HANDSHAKE_READY, &connection->flags);
+	clear_bit(CONN_HANDSHAKE_DEMOTE, &connection->flags);
+}
+
+enum csc_rv {
+	CSC_CLEAR,
+	CSC_REJECT,
+	CSC_ABORT_LOCAL,
+	CSC_TID_MISS,
+	CSC_MATCH,
+};
+
+static enum csc_rv
+check_concurrent_transactions(struct drbd_resource *resource, struct twopc_reply *new_r)
+{
+	struct twopc_reply *ongoing = &resource->twopc_reply;
+
+	if (!resource->remote_state_change)
+		return CSC_CLEAR;
+
+	if (new_r->initiator_node_id < ongoing->initiator_node_id) {
+		if (ongoing->initiator_node_id == resource->res_opts.node_id)
+			return CSC_ABORT_LOCAL;
+		else
+			return CSC_REJECT;
+	} else if (new_r->initiator_node_id > ongoing->initiator_node_id) {
+		return CSC_REJECT;
+	}
+	if (new_r->tid != ongoing->tid)
+		return CSC_TID_MISS;
+
+	return CSC_MATCH;
+}
+
+
+enum alt_rv {
+	ALT_LOCKED,
+	ALT_MATCH,
+	ALT_TIMEOUT,
+};
+
+static enum alt_rv when_done_lock(struct drbd_resource *resource, unsigned int for_tid)
+{
+	write_lock_irq(&resource->state_rwlock);
+	if (!resource->remote_state_change)
+		return ALT_LOCKED;
+	write_unlock_irq(&resource->state_rwlock);
+	if (resource->twopc_reply.tid == for_tid)
+		return ALT_MATCH;
+
+	return ALT_TIMEOUT;
+}
+static enum alt_rv abort_local_transaction(struct drbd_connection *connection, unsigned int for_tid)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_net_conf *nc;
+	enum alt_rv rv;
+	long t;
+
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	t = nc->ping_timeo * HZ/10 * 3 / 2;
+	rcu_read_unlock();
+
+	set_bit(TWOPC_ABORT_LOCAL, &resource->flags);
+	write_unlock_irq(&resource->state_rwlock);
+	wake_up_all(&resource->state_wait);
+	wait_event_timeout(resource->twopc_wait,
+			   (rv = when_done_lock(resource, for_tid)) != ALT_TIMEOUT, t);
+	clear_bit(TWOPC_ABORT_LOCAL, &resource->flags);
+	return rv;
+}
+
+static int receive_twopc(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct p_twopc_request *p = pi->data;
+	struct twopc_reply reply = {0};
+
+	reply.vnr = pi->vnr;
+	reply.tid = be32_to_cpu(p->tid);
+	if (connection->agreed_features & DRBD_FF_2PC_V2) {
+		reply.initiator_node_id = p->s8_initiator_node_id;
+		reply.target_node_id = p->s8_target_node_id;
+	} else {
+		reply.initiator_node_id = be32_to_cpu(p->u32_initiator_node_id);
+		reply.target_node_id = be32_to_cpu(p->u32_target_node_id);
+	}
+	reply.reachable_nodes = directly_connected_nodes(resource, NOW) |
+				NODE_MASK(resource->res_opts.node_id);
+
+	if (pi->cmd == P_TWOPC_PREPARE)
+		clear_bit(TWOPC_RECV_SIZES_ERR, &resource->flags);
+
+	process_twopc(connection, &reply, pi, jiffies);
+
+	return 0;
+}
+
+static void nested_twopc_abort(struct drbd_resource *resource, struct twopc_request *request)
+{
+	struct drbd_connection *connection;
+	u64 nodes_to_reach, reach_immediately, im;
+
+	read_lock_irq(&resource->state_rwlock);
+	nodes_to_reach = request->nodes_to_reach;
+	reach_immediately = directly_connected_nodes(resource, NOW) & nodes_to_reach;
+	nodes_to_reach &= ~(reach_immediately | NODE_MASK(resource->res_opts.node_id));
+	request->nodes_to_reach = nodes_to_reach;
+	read_unlock_irq(&resource->state_rwlock);
+
+	for_each_connection_ref(connection, im, resource) {
+		u64 mask = NODE_MASK(connection->peer_node_id);
+
+		if (reach_immediately & mask)
+			conn_send_twopc_request(connection, request);
+	}
+}
+
+static bool is_prepare(enum drbd_packet cmd)
+{
+	return cmd == P_TWOPC_PREP_RSZ || cmd == P_TWOPC_PREPARE;
+}
+
+
+enum determine_dev_size
+drbd_commit_size_change(struct drbd_device *device, struct drbd_resize_parms *rs,
+			u64 nodes_to_reach)
+{
+	struct twopc_resize *tr = &device->resource->twopc.resize;
+	struct drbd_peer_device *peer_device;
+	enum determine_dev_size dd;
+	uint64_t my_usize;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		/* update cached sizes, relevant for the next handshake */
+		peer_device->c_size = tr->new_size;
+		peer_device->u_size = tr->user_size;
+
+		if (peer_device->d_size)
+			peer_device->d_size = tr->new_size;
+		peer_device->max_size = tr->new_size;
+	}
+	rcu_read_unlock();
+
+	if (!get_ldev(device)) {
+		drbd_set_my_capacity(device, tr->new_size);
+		return DS_UNCHANGED; /* Not entirely true, but we are diskless... */
+	}
+
+	rcu_read_lock();
+	my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
+	rcu_read_unlock();
+
+	if (my_usize != tr->user_size) {
+		struct drbd_disk_conf *old_disk_conf, *new_disk_conf;
+
+		drbd_info(device, "New u_size %llu sectors\n",
+			  (unsigned long long)tr->user_size);
+
+		new_disk_conf = kzalloc_obj(struct drbd_disk_conf);
+		if (!new_disk_conf) {
+			device->ldev->disk_conf->disk_size = tr->user_size;
+			goto cont;
+		}
+
+		old_disk_conf = device->ldev->disk_conf;
+		*new_disk_conf = *old_disk_conf;
+		new_disk_conf->disk_size = tr->user_size;
+
+		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
+		kvfree_rcu_mightsleep(old_disk_conf);
+	}
+cont:
+	dd = drbd_determine_dev_size(device, tr->new_size, tr->dds_flags | DDSF_2PC, rs);
+
+	if (dd == DS_GREW && !(tr->dds_flags & DDSF_NO_RESYNC)) {
+		struct drbd_resource *resource = device->resource;
+		const int my_node_id = resource->res_opts.node_id;
+		struct drbd_peer_device *peer_device;
+		u64 im;
+
+		for_each_peer_device_ref(peer_device, im, device) {
+			if (peer_device->repl_state[NOW] != L_ESTABLISHED ||
+			    peer_device->disk_state[NOW] < D_INCONSISTENT)
+				continue;
+
+			if (tr->diskful_primary_nodes) {
+				if (tr->diskful_primary_nodes & NODE_MASK(my_node_id)) {
+					enum drbd_repl_state resync;
+
+					if (tr->diskful_primary_nodes & NODE_MASK(peer_device->node_id)) {
+						/* peer is also primary */
+						resync = peer_device->node_id < my_node_id ?
+							L_SYNC_TARGET : L_SYNC_SOURCE;
+					} else {
+						/* peer is secondary */
+						resync = L_SYNC_SOURCE;
+					}
+					drbd_start_resync(peer_device, resync, "resize");
+				} else {
+					if (tr->diskful_primary_nodes & NODE_MASK(peer_device->node_id))
+						drbd_start_resync(peer_device, L_SYNC_TARGET,
+								"resize");
+					/* else  no resync */
+				}
+			} else {
+				if (resource->twopc_parent_nodes & NODE_MASK(peer_device->node_id))
+					drbd_start_resync(peer_device, L_SYNC_TARGET, "resize");
+				else if (nodes_to_reach & NODE_MASK(peer_device->node_id))
+					drbd_start_resync(peer_device, L_SYNC_SOURCE, "resize");
+				/* else  no resync */
+			}
+		}
+	}
+
+	put_ldev(device);
+	return dd;
+}
+
+enum drbd_state_rv drbd_support_2pc_resize(struct drbd_resource *resource)
+{
+	struct drbd_connection *connection;
+	enum drbd_state_rv rv = SS_SUCCESS;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection->cstate[NOW] == C_CONNECTED &&
+		    connection->agreed_pro_version < 112) {
+			rv = SS_NOT_SUPPORTED;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+static bool any_neighbor_quorate(struct drbd_resource *resource)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_connection *connection;
+	bool peer_with_quorum = false;
+	int vnr;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		peer_with_quorum = true;
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			if (test_bit(PEER_QUORATE, peer_device->flags))
+				continue;
+			peer_with_quorum = false;
+			break;
+		}
+
+		if (peer_with_quorum)
+			break;
+	}
+	rcu_read_unlock();
+
+	return peer_with_quorum;
+}
+
+static void process_twopc(struct drbd_connection *connection,
+			 struct twopc_reply *reply,
+			 struct packet_info *pi,
+			 unsigned long receive_jif)
+{
+	struct drbd_connection *affected_connection = connection;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device = NULL;
+	struct p_twopc_request *p = pi->data;
+	struct twopc_state_change *state_change = &resource->twopc.state_change;
+	enum chg_state_flags flags = CS_VERBOSE | CS_LOCAL_ONLY;
+	enum drbd_state_rv rv = SS_SUCCESS;
+	struct twopc_request request;
+	bool waiting_allowed = true;
+	enum csc_rv csc_rv;
+
+	request.tid = be32_to_cpu(p->tid);
+	if (connection->agreed_features & DRBD_FF_2PC_V2) {
+		request.flags = be32_to_cpu(p->flags);
+		request.initiator_node_id = p->s8_initiator_node_id;
+		request.target_node_id = p->s8_target_node_id;
+	} else {
+		request.flags = 0;
+		request.initiator_node_id = be32_to_cpu(p->u32_initiator_node_id);
+		request.target_node_id = be32_to_cpu(p->u32_target_node_id);
+	}
+	request.nodes_to_reach = be64_to_cpu(p->nodes_to_reach);
+	request.cmd = pi->cmd;
+	request.vnr = pi->vnr;
+
+	/* Check for concurrent transactions and duplicate packets. */
+retry:
+	write_lock_irq(&resource->state_rwlock);
+
+	csc_rv = check_concurrent_transactions(resource, reply);
+
+	if (csc_rv == CSC_CLEAR && pi->cmd != P_TWOPC_ABORT) {
+		struct drbd_device *device;
+		int iterate_vnr;
+
+		if (!is_prepare(pi->cmd)) {
+			/* We have committed or aborted this transaction already. */
+			write_unlock_irq(&resource->state_rwlock);
+			dynamic_drbd_dbg(connection, "Ignoring %s packet %u\n",
+				   drbd_packet_name(pi->cmd),
+				   reply->tid);
+			return;
+		}
+		if (reply->is_aborted) {
+			write_unlock_irq(&resource->state_rwlock);
+			return;
+		}
+		resource->remote_state_change = true;
+		resource->twopc.type =
+			pi->cmd == P_TWOPC_PREPARE ? TWOPC_STATE_CHANGE : TWOPC_RESIZE;
+		resource->twopc_prepare_reply_cmd = 0;
+		resource->twopc_parent_nodes = NODE_MASK(connection->peer_node_id);
+		clear_bit(TWOPC_EXECUTED, &resource->flags);
+		set_bit(TWOPC_PREPARING, &resource->flags);
+		idr_for_each_entry(&resource->devices, device, iterate_vnr)
+			clear_bit(OUTDATE_ON_2PC_COMMIT, &device->flags);
+	} else if (csc_rv == CSC_MATCH && !is_prepare(pi->cmd)) {
+		flags |= CS_PREPARED;
+
+		if (test_and_set_bit(TWOPC_EXECUTED, &resource->flags)) {
+			write_unlock_irq(&resource->state_rwlock);
+			drbd_info(connection, "Ignoring redundant %s packet %u.\n",
+				  drbd_packet_name(pi->cmd),
+				  reply->tid);
+			return;
+		}
+	} else if (csc_rv == CSC_ABORT_LOCAL && is_prepare(pi->cmd)) {
+		enum alt_rv alt_rv;
+
+		drbd_info(connection, "Aborting local state change %u to yield to remote "
+			  "state change %u.\n",
+			  resource->twopc_reply.tid,
+			  reply->tid);
+		alt_rv = abort_local_transaction(connection, reply->tid);
+		if (alt_rv == ALT_MATCH) {
+			/* abort_local_transaction() comes back unlocked in this case... */
+			goto match;
+		} else if (alt_rv == ALT_TIMEOUT) {
+			/* abort_local_transaction() comes back unlocked in this case... */
+			drbd_info(connection, "Aborting local state change %u "
+				  "failed. Rejecting remote state change %u.\n",
+				  resource->twopc_reply.tid,
+				  reply->tid);
+			drbd_send_twopc_reply(connection, P_TWOPC_RETRY, reply);
+			return;
+		}
+		/* abort_local_transaction() returned with the state_rwlock write lock */
+		if (reply->is_aborted) {
+			write_unlock_irq(&resource->state_rwlock);
+			return;
+		}
+		resource->remote_state_change = true;
+		resource->twopc.type =
+			pi->cmd == P_TWOPC_PREPARE ? TWOPC_STATE_CHANGE : TWOPC_RESIZE;
+		resource->twopc_parent_nodes = NODE_MASK(connection->peer_node_id);
+		resource->twopc_prepare_reply_cmd = 0;
+		clear_bit(TWOPC_EXECUTED, &resource->flags);
+		set_bit(TWOPC_PREPARING, &resource->flags);
+	} else if (pi->cmd == P_TWOPC_ABORT) {
+		/* crc_rc != CRC_MATCH */
+		write_unlock_irq(&resource->state_rwlock);
+		nested_twopc_abort(resource, &request);
+		return;
+	} else {
+		write_unlock_irq(&resource->state_rwlock);
+
+		if (csc_rv == CSC_TID_MISS && is_prepare(pi->cmd) && waiting_allowed) {
+			/* CSC_TID_MISS implies the two transactions are from the same initiator */
+			if (!(resource->twopc_parent_nodes & NODE_MASK(connection->peer_node_id))) {
+				long timeout = twopc_timeout(resource) / 20; /* usually 1.5 sec */
+				/*
+				 * We are expecting the P_TWOPC_COMMIT or P_TWOPC_ABORT through
+				 * another connection. So we can wait without deadlocking.
+				 */
+				wait_event_interruptible_timeout(resource->twopc_wait,
+						!resource->remote_state_change, timeout);
+				waiting_allowed = false; /* retry only once */
+				goto retry;
+			}
+		}
+
+		if (csc_rv == CSC_REJECT ||
+		    (csc_rv == CSC_TID_MISS && is_prepare(pi->cmd))) {
+			drbd_info(connection, "Rejecting concurrent "
+				  "remote state change %u because of "
+				  "state change %u\n",
+				  reply->tid,
+				  resource->twopc_reply.tid);
+			drbd_send_twopc_reply(connection, P_TWOPC_RETRY, reply);
+			return;
+		}
+
+		if (is_prepare(pi->cmd)) {
+			if (csc_rv == CSC_MATCH) {
+				/* We have prepared this transaction already. */
+				enum drbd_packet reply_cmd;
+
+match:
+				drbd_info(connection,
+						"Duplicate prepare for remote state change %u\n",
+						reply->tid);
+				write_lock_irq(&resource->state_rwlock);
+				resource->twopc_parent_nodes |= NODE_MASK(connection->peer_node_id);
+				reply_cmd = resource->twopc_prepare_reply_cmd;
+				write_unlock_irq(&resource->state_rwlock);
+
+				if (reply_cmd) {
+					drbd_send_twopc_reply(connection, reply_cmd,
+							      &resource->twopc_reply);
+				} else {
+					/* if a node sends us a prepare, that means he has
+					   prepared this himsilf successfully. */
+					write_lock_irq(&resource->state_rwlock);
+					set_bit(TWOPC_YES, &connection->flags);
+					drbd_maybe_cluster_wide_reply(resource);
+					write_unlock_irq(&resource->state_rwlock);
+				}
+			}
+		} else {
+			drbd_info(connection, "Ignoring %s packet %u "
+				  "current processing state change %u\n",
+				  drbd_packet_name(pi->cmd),
+				  reply->tid,
+				  resource->twopc_reply.tid);
+		}
+		return;
+	}
+
+	if (reply->initiator_node_id != connection->peer_node_id) {
+		/*
+		 * This is an indirect request.  Unless we are directly
+		 * connected to the initiator as well as indirectly, we don't
+		 * have connection or peer device objects for this peer.
+		 */
+		affected_connection = drbd_connection_by_node_id(resource, reply->initiator_node_id);
+	}
+
+	if (reply->target_node_id != -1 &&
+	    reply->target_node_id != resource->res_opts.node_id) {
+		affected_connection = NULL;
+	}
+
+	switch (resource->twopc.type) {
+	case TWOPC_STATE_CHANGE:
+		if (pi->cmd == P_TWOPC_PREPARE) {
+			state_change->mask.i = be32_to_cpu(p->mask);
+			state_change->val.i = be32_to_cpu(p->val);
+		} else { /* P_TWOPC_COMMIT */
+			state_change->primary_nodes = be64_to_cpu(p->primary_nodes);
+			state_change->reachable_nodes = be64_to_cpu(p->reachable_nodes);
+		}
+		break;
+	case TWOPC_RESIZE:
+		if (request.cmd == P_TWOPC_PREP_RSZ) {
+			resource->twopc.resize.user_size = be64_to_cpu(p->user_size);
+			resource->twopc.resize.dds_flags = be16_to_cpu(p->dds_flags);
+		} else { /* P_TWOPC_COMMIT */
+			resource->twopc.resize.diskful_primary_nodes =
+				be64_to_cpu(p->diskful_primary_nodes);
+			resource->twopc.resize.new_size = be64_to_cpu(p->exposed_size);
+		}
+	}
+
+	if (affected_connection && affected_connection->cstate[NOW] < C_CONNECTED &&
+	    state_change->mask.conn == 0)
+		affected_connection = NULL;
+
+	if (pi->vnr != -1 && affected_connection) {
+		peer_device = conn_peer_device(affected_connection, pi->vnr);
+		/* If we do not know the peer_device, then we are fine with
+		   whatever is going on in the cluster. E.g. detach and del-minor
+		   one each node, one after the other */
+
+		affected_connection = NULL; /* It is intended for a peer_device! */
+	}
+
+	if (state_change->mask.conn == conn_MASK) {
+		u64 m = NODE_MASK(reply->initiator_node_id);
+
+		if (state_change->val.conn == C_CONNECTED) {
+			reply->reachable_nodes |= m;
+			if (affected_connection) {
+				reply->is_connect = 1;
+
+				if (pi->cmd == P_TWOPC_PREPARE)
+					drbd_init_connect_state(connection);
+			}
+		}
+		if (state_change->val.conn == C_DISCONNECTING) {
+			reply->reachable_nodes &= ~m;
+			reply->is_disconnect = 1;
+		}
+	}
+
+	if (pi->cmd == P_TWOPC_PREPARE) {
+		reply->primary_nodes = be64_to_cpu(p->primary_nodes);
+		if (resource->role[NOW] == R_PRIMARY) {
+			reply->primary_nodes |= NODE_MASK(resource->res_opts.node_id);
+
+			if (drbd_res_data_accessible(resource))
+				reply->weak_nodes = ~reply->reachable_nodes;
+		}
+	}
+	if (pi->cmd == P_TWOPC_PREP_RSZ) {
+		struct drbd_device *device;
+
+		device = (peer_device ?: conn_peer_device(connection, pi->vnr))->device;
+		twopc_suspend_io(device);
+		if (get_ldev(device)) {
+			if (resource->role[NOW] == R_PRIMARY)
+				reply->diskful_primary_nodes = NODE_MASK(resource->res_opts.node_id);
+			reply->max_possible_size = drbd_local_max_size(device);
+			put_ldev(device);
+		} else {
+			reply->max_possible_size = DRBD_MAX_SECTORS;
+			reply->diskful_primary_nodes = 0;
+		}
+	}
+
+	resource->twopc_reply = *reply;
+	write_unlock_irq(&resource->state_rwlock);
+
+	if (affected_connection && affected_connection != connection &&
+	    affected_connection->cstate[NOW] == C_CONNECTED) {
+		drbd_ping_peer(affected_connection);
+		if (affected_connection->cstate[NOW] < C_CONNECTED)
+			affected_connection = NULL;
+	}
+
+	switch (pi->cmd) {
+	case P_TWOPC_PREPARE:
+		drbd_print_cluster_wide_state_change(resource, "Preparing remote state change",
+				reply->tid, reply->initiator_node_id, reply->target_node_id,
+				state_change->mask, state_change->val);
+		flags |= CS_PREPARE;
+		break;
+	case P_TWOPC_PREP_RSZ:
+		dynamic_drbd_dbg(connection, "Preparing remote state change %u "
+			  "(local_max_size = %llu KiB)\n",
+			  reply->tid, (unsigned long long)reply->max_possible_size >> 1);
+		flags |= CS_PREPARE;
+		break;
+	case P_TWOPC_ABORT:
+		drbd_info(connection, "Aborting remote state change %u\n",
+			  reply->tid);
+		flags |= CS_ABORT;
+		break;
+	case P_TWOPC_COMMIT:
+		drbd_info(connection, "Committing remote state change %u (primary_nodes=%llX)\n",
+			  reply->tid, be64_to_cpu(p->primary_nodes));
+		break;
+	default:
+		BUG();
+	}
+
+	switch (resource->twopc.type) {
+	case TWOPC_STATE_CHANGE:
+		if (flags & CS_PREPARED && !(flags & CS_ABORT)) {
+			reply->primary_nodes = state_change->primary_nodes;
+			handle_neighbor_demotion(connection, state_change, reply);
+
+			if ((resource->cached_all_devices_have_quorum ||
+			     any_neighbor_quorate(resource)) &&
+			    request.flags & TWOPC_HAS_REACHABLE) {
+				resource->members = state_change->reachable_nodes;
+				if (!resource->cached_all_devices_have_quorum)
+					flags |= CS_FORCE_RECALC;
+			}
+			if (state_change->mask.conn == conn_MASK &&
+			    state_change->val.conn == C_CONNECTED) {
+				/* Add nodes connecting "far away" to members */
+				u64 add_mask = NODE_MASK(reply->initiator_node_id) |
+					NODE_MASK(reply->target_node_id);
+
+				resource->members |= add_mask;
+			}
+		}
+
+		if (peer_device)
+			rv = change_peer_device_state(peer_device, state_change, flags);
+		else if (affected_connection)
+			rv = change_connection_state(affected_connection, state_change, reply,
+						     flags | CS_IGN_OUTD_FAIL);
+		else
+			rv = far_away_change(connection, &request, reply, flags);
+
+		/* An abort is handled by clear_remote_state_change() */
+		if (!peer_device && !affected_connection && !(flags & CS_ABORT) &&
+		    state_change->mask.conn == conn_MASK &&
+		    state_change->val.conn == C_CONNECTED) {
+			if (flags & CS_PREPARE && rv >= SS_SUCCESS)
+				drbd_flush_connect_prepared(resource, reply->initiator_node_id,
+							    reply->target_node_id);
+			else if (flags & CS_PREPARED)
+				drbd_flush_connect_committed(resource);
+		}
+		break;
+	case TWOPC_RESIZE:
+		if (flags & CS_PREPARE) {
+			rv = drbd_support_2pc_resize(resource);
+			/* The YES must mean "nothing in flight from here", see
+			 * twopc_suspend_io(). Writes only: a read this node has
+			 * outstanding on this connection completes through this
+			 * receiver thread, while write acks arrive on the
+			 * ack receiver.
+			 */
+			if (rv >= SS_SUCCESS) {
+				struct drbd_peer_device *pd;
+
+				pd = peer_device ?: conn_peer_device(connection, pi->vnr);
+				twopc_drain_io(pd->device, WRITE_ONLY);
+			}
+		}
+		break;
+	}
+
+	if (flags & CS_PREPARE) {
+		mod_timer(&resource->twopc_timer, receive_jif + twopc_timeout(resource));
+
+		/* Retry replies can be sent immediately. Otherwise use the
+		 * nested twopc path. This waits for the state handshake to
+		 * complete in the case of a twopc for transitioning to
+		 * C_CONNECTED. */
+		if (rv == SS_IN_TRANSIENT_STATE) {
+			write_lock_irq(&resource->state_rwlock);
+			clear_bit(TWOPC_PREPARING, &resource->flags);
+			resource->twopc_prepare_reply_cmd = P_TWOPC_RETRY;
+			write_unlock_irq(&resource->state_rwlock);
+			drbd_send_twopc_reply(connection, P_TWOPC_RETRY, reply);
+		} else {
+			resource->twopc_reply.state_change_failed = rv < SS_SUCCESS;
+			nested_twopc_request(resource, &request);
+		}
+	} else {
+		if (flags & CS_PREPARED) {
+			if (rv < SS_SUCCESS)
+				drbd_err(resource, "FATAL: Local commit of prepared %u failed!\n",
+					 reply->tid);
+
+			timer_delete(&resource->twopc_timer);
+		}
+
+		nested_twopc_request(resource, &request);
+
+		if (resource->twopc.type == TWOPC_RESIZE && flags & CS_PREPARED &&
+		    !(flags & CS_ABORT)) {
+			struct drbd_device *device;
+
+			device = (peer_device ?: conn_peer_device(connection, pi->vnr))->device;
+
+			drbd_commit_size_change(device, NULL, request.nodes_to_reach);
+			rv = SS_SUCCESS;
+		}
+
+		clear_remote_state_change(resource);
+
+		if (peer_device && rv >= SS_SUCCESS && !(flags & CS_ABORT))
+			drbd_md_sync_if_dirty(peer_device->device);
+
+		if (connection->agreed_pro_version < 117 &&
+		    rv >= SS_SUCCESS && !(flags & CS_ABORT) &&
+		    affected_connection &&
+		    state_change->mask.conn == conn_MASK && state_change->val.conn == C_CONNECTED)
+			conn_connect2(connection);
+	}
+}
+
+static void drbd_try_to_get_resynced(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device, *best_peer_device = NULL;
+	enum sync_strategy best_strategy = UNDETERMINED;
+	int best_preference = 0;
+
+	if (!get_ldev(device))
+		return;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		enum sync_strategy strategy;
+		enum sync_rule rule;
+		int peer_node_id;
+
+		if (peer_device->disk_state[NOW] != D_UP_TO_DATE)
+			continue;
+
+		spin_lock_irq(&device->ldev->md.uuid_lock);
+		strategy = drbd_uuid_compare(peer_device, &rule, &peer_node_id);
+		spin_unlock_irq(&device->ldev->md.uuid_lock);
+		disk_states_to_strategy(peer_device, peer_device->disk_state[NOW], &strategy, &rule,
+					&peer_node_id);
+		drbd_info(peer_device, "strategy = %s\n", strategy_descriptor(strategy).name);
+		if (strategy_descriptor(strategy).resync_peer_preference > best_preference) {
+			best_preference = strategy_descriptor(strategy).resync_peer_preference;
+			best_peer_device = peer_device;
+			best_strategy = strategy;
+		}
+	}
+	rcu_read_unlock();
+	peer_device = best_peer_device;
+
+	if (best_strategy == NO_SYNC) {
+		change_disk_state(device, D_UP_TO_DATE, CS_VERBOSE, "get-resync", NULL);
+	} else if (peer_device &&
+		   (!repl_is_sync_target(peer_device->repl_state[NOW]) ||
+		    test_bit(UNSTABLE_RESYNC, peer_device->flags))) {
+		drbd_resync(peer_device, DISKLESS_PRIMARY);
+		drbd_send_uuids(peer_device, UUID_FLAG_RESYNC | UUID_FLAG_DISKLESS_PRIMARY, 0);
+	}
+	put_ldev(device);
+}
+
+/*
+ * drbd_try_to_get_resynced() must not run on the worker thread: the bitmap
+ * modification after the handshake performs blocking whole-bitmap IO, which
+ * the worker itself may need to make progress on (drbd_bitmap_io() asserts
+ * that it is not called from the worker). Triggered from
+ * w_after_state_change() via this work function instead.
+ */
+void drbd_try_get_resynced_work_fn(struct work_struct *ws)
+{
+	struct drbd_device *device =
+		container_of(ws, struct drbd_device, try_get_resynced_work);
+
+	drbd_try_to_get_resynced(device);
+	kref_put(&device->kref, drbd_destroy_device);
+}
+
+static void finish_nested_twopc(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	int vnr = 0;
+
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags))
+			return;
+	}
+
+	set_bit(CONN_HANDSHAKE_READY, &connection->flags);
+
+	wake_up_all(&resource->state_wait);
+
+	write_lock_irq(&resource->state_rwlock);
+	drbd_maybe_cluster_wide_reply(resource);
+	write_unlock_irq(&resource->state_rwlock);
+}
+
+static bool uuid_in_peer_history(struct drbd_peer_device *peer_device, u64 uuid)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(peer_device->history_uuids); i++)
+		if ((peer_device->history_uuids[i] & ~UUID_PRIMARY) == uuid)
+			return true;
+
+	return false;
+}
+
+static bool uuid_in_my_history(struct drbd_device *device, u64 uuid)
+{
+	int i;
+
+	for (i = 0; i < HISTORY_UUIDS; i++) {
+		if ((drbd_history_uuid(device, i) & ~UUID_PRIMARY) == uuid)
+			return true;
+	}
+
+	return false;
+}
+
+static bool peer_data_is_successor_of_mine(struct drbd_peer_device *peer_device)
+{
+	u64 exposed = peer_device->device->exposed_data_uuid & ~UUID_PRIMARY;
+	int i;
+
+	i = drbd_find_peer_bitmap_by_uuid(peer_device, exposed);
+	if (i != -1)
+		return true;
+
+	return uuid_in_peer_history(peer_device, exposed);
+}
+
+bool peer_data_is_ancestor_of_mine(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	u64 peer_uuid = peer_device->current_uuid & ~UUID_PRIMARY;
+	struct drbd_peer_device *p2;
+	bool rv = false;
+	int i;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(p2, device) {
+		if (peer_device == p2)
+			continue;
+		i = drbd_find_peer_bitmap_by_uuid(p2, peer_uuid);
+		if (i != -1 || uuid_in_peer_history(p2, peer_uuid)) {
+			rv = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+static void propagate_exposed_uuid(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+	u64 im;
+
+	for_each_peer_device_ref(peer_device, im, device) {
+		if (!test_bit(INITIAL_STATE_SENT, peer_device->flags))
+			continue;
+		drbd_send_current_uuid(peer_device,
+				       diskless_primary_present_current_uuid(peer_device), 0);
+	}
+}
+
+static void maybe_force_secondary(struct drbd_peer_device *peer_device)
+{
+	struct drbd_resource *resource = peer_device->device->resource;
+	struct drbd_connection *connection = peer_device->connection;
+	unsigned long irq_flags;
+	bool force;
+
+	force = !resource->fail_io[NOW] && resource->cached_susp &&
+		resource->res_opts.on_susp_primary_outdated == SPO_FORCE_SECONDARY;
+	force |= test_and_clear_bit(CONN_HANDSHAKE_DEMOTE, &connection->flags);
+
+	if (force) {
+		drbd_warn(peer_device, "force secondary!\n");
+		begin_state_change(resource, &irq_flags,
+				   CS_VERBOSE | CS_HARD | CS_FS_IGN_OPENERS);
+		resource->role[NEW] = R_SECONDARY;
+		/* resource->fail_io[NEW] gets set via CS_FS_IGN_OPENERS */
+		end_state_change(resource, &irq_flags, "peer-state");
+	}
+}
+
+/* A diskless primary that bumped its current UUID keeps the generation it
+ * bumped away from (exposed_data_uuid_predecessor) while the new one is still
+ * unconfirmed.  A peer returning on that predecessor generation can be brought
+ * forward by resending the transfer log -- but only if the bridging writes are
+ * still there.  They are kept exactly when the peer was lost while we were
+ * suspended (CONNECTION_LOST_WHILE_SUSPENDED keeps protocol B/C requests as
+ * RQ_COMPLETION_SUSP) and we have stayed suspended since, so the transfer log
+ * has not advanced.  If we would instead have to resend a write we no longer
+ * hold (completed to the upper layers and freed), we cannot recover this peer
+ * here; it has to resync from a peer that holds good data.
+ *
+ * The resend cursor is conservative: writes this peer acked (RQ_NET_OK) are not
+ * resent, writes still pending to it are.  A pending write may in fact have been
+ * processed by the peer already (its ack lost in the break); resending it is
+ * harmless.  The only fatal case is a needed write that was given up on
+ * (RQ_NET_DONE without RQ_NET_OK), whose data may be gone.
+ */
+bool diskless_primary_can_replay_to(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_resource *resource = device->resource;
+	int idx = peer_device->node_id;
+	struct drbd_request *req;
+	bool have_resendable = false;
+
+	/* The transfer log must still be frozen; if it moved on, the bridging
+	 * writes may have been completed and freed.
+	 */
+	if (!resource->cached_susp)
+		return false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(req, &resource->transfer_log, tl_requests) {
+		unsigned int local, net;
+
+		if (req->device != device)
+			continue;
+		local = READ_ONCE(req->local_rq_state);
+		if (!(local & RQ_WRITE))
+			continue;
+		net = READ_ONCE(req->net_rq_state[idx]);
+
+		/* A write we would need to resend but already gave up on towards
+		 * this peer: its data may be gone -> cannot recover here.
+		 */
+		if ((net & RQ_NET_DONE) && !(net & RQ_NET_OK)) {
+			rcu_read_unlock();
+			return false;
+		}
+		/* A write still pending to this peer, kept across the loss
+		 * because completion was suspended: this is resendable.
+		 */
+		if ((net & RQ_NET_PENDING) && (local & RQ_COMPLETION_SUSP))
+			have_resendable = true;
+	}
+	rcu_read_unlock();
+
+	return have_resendable;
+}
+
+/* Present our actual exposed current generation to a returning peer.
+ * Reverts 308cf12f2's present-predecessor (see commit message).
+ */
+u64 diskless_primary_present_current_uuid(struct drbd_peer_device *peer_device)
+{
+	return peer_device->device->exposed_data_uuid;
+}
+
+static void diskless_with_peers_different_current_uuids(struct drbd_peer_device *peer_device,
+							enum drbd_disk_state *peer_disk_state)
+{
+	bool data_successor = peer_data_is_successor_of_mine(peer_device);
+	bool data_ancestor = peer_data_is_ancestor_of_mine(peer_device);
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_device *device = peer_device->device;
+
+	if (data_successor && resource->role[NOW] == R_PRIMARY) {
+		drbd_warn(peer_device, "Remote node has more recent data\n");
+		maybe_force_secondary(peer_device);
+		set_bit(CONN_HANDSHAKE_RETRY, &connection->flags);
+	} else if (data_successor && resource->role[NOW] == R_SECONDARY) {
+		drbd_uuid_set_exposed(device, peer_device->current_uuid, true);
+		propagate_exposed_uuid(device);
+	} else if (data_ancestor) {
+		drbd_warn(peer_device, "Downgrading joining peer's disk as its data is older\n");
+		if (*peer_disk_state > D_OUTDATED)
+			*peer_disk_state = D_OUTDATED;
+			/* See "Do not trust this guy!" in sanitize_state() */
+	} else if (drbd_gen_obligation_state(device) == GEN_OBL_UNCONFIRMED &&
+		   device->exposed_data_uuid_predecessor &&
+		   (peer_device->current_uuid & ~UUID_PRIMARY) ==
+		   (device->exposed_data_uuid_predecessor & ~UUID_PRIMARY) &&
+		   diskless_primary_can_replay_to(peer_device)) {
+		/* The peer returned on the generation we bumped away from, and the
+		 * writes bridging it to our (still unconfirmed) current generation are
+		 * still replayable from our suspended transfer log.  Its predecessor
+		 * data is a complete, valid generation -- equivalent to our current
+		 * minus the unacknowledged in-flight writes -- so assert it UpToDate
+		 * now (a sole diskful peer cannot promote itself against a diskless
+		 * primary; the "Do not trust this guy" exception in sanitize_state
+		 * honors RECONCILE_INJECT_CUR_UUID and keeps it UpToDate despite the
+		 * UUID mismatch).  The post-handshake relabel
+		 * (RECONCILE_INJECT_CUR_UUID -> SEND_RECONCILE_UUID) then advances it
+		 * to our current generation, the replayed writes filling the gap.
+		 */
+		drbd_info(peer_device,
+			  "Peer is one generation behind; asserting UpToDate, will resend transfer log and relabel.\n");
+		set_bit(RECONCILE_INJECT_CUR_UUID, peer_device->flags);
+		*peer_disk_state = D_UP_TO_DATE;
+	} else if (drbd_gen_obligation_state(device) == GEN_OBL_UNCONFIRMED &&
+		   resource->res_opts.on_no_quorum == ONQ_SUSPEND_IO) {
+		/* Park-until-resync.  We are a diskless primary in an unconfirmed
+		 * rotated generation, and this peer is on an older generation we can
+		 * neither place as a recognised ancestor nor replay to (e.g. the
+		 * first-lost peer, whose transfer log we discarded -- see
+		 * diskless_primary_can_replay_to).  Being diskless we are no resync
+		 * source for it.  Refusing it would strand the cluster; relabelling it
+		 * forward would be silent divergence (it lacks the bridging writes).
+		 * Instead accept the connection but keep it Outdated: it contributes no
+		 * quorum and serves no data until it resyncs from a diskful peer that
+		 * holds the current generation (the last-lost peer, once reconciled).
+		 * We stay suspended (no quorum) until then -- correct, and loss-free
+		 * because the rotated writes were never completed/acknowledged.
+		 */
+		drbd_warn(peer_device,
+			  "Peer is on an older generation we cannot source; keeping it Outdated until it resyncs from a peer that holds the current generation.\n");
+		if (*peer_disk_state > D_OUTDATED)
+			*peer_disk_state = D_OUTDATED;
+	} else {
+		drbd_warn(peer_device, "Current UUID of peer does not match my exposed UUID.");
+		set_bit(CONN_HANDSHAKE_DISCONNECT, &connection->flags);
+	}
+}
+
+static int receive_state(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device = NULL;
+	enum drbd_repl_state *repl_state;
+	struct drbd_device *device = NULL;
+	struct p_state *p = pi->data;
+	union drbd_state old_peer_state, peer_state;
+	enum drbd_disk_state peer_disk_state;
+	enum drbd_repl_state new_repl_state;
+	bool peer_was_resync_target, do_handshake = false;
+	bool consumed_resync;
+	enum chg_state_flags begin_state_chg_flags = CS_VERBOSE | CS_WAIT_COMPLETE;
+	unsigned long irq_flags;
+	int rv;
+
+	if (pi->vnr != -1) {
+		peer_device = conn_peer_device(connection, pi->vnr);
+		if (!peer_device)
+			return config_unknown_volume(connection, pi);
+		device = peer_device->device;
+	}
+
+	peer_state.i = be32_to_cpu(p->state);
+
+	if (connection->agreed_pro_version < 110)
+		drbd_disk_states_from_84(&peer_state);
+
+	if (peer_device)
+		clear_bit(PEER_UPGRADE_PREDICTED, peer_device->flags);
+
+	if (pi->vnr == -1) {
+		if (peer_state.role == R_SECONDARY) {
+			begin_state_change(resource, &irq_flags, CS_HARD | CS_VERBOSE);
+			__change_peer_role(connection, R_SECONDARY);
+			rv = end_state_change(resource, &irq_flags, "peer-state");
+			if (rv < SS_SUCCESS)
+				goto fail;
+		}
+		return 0;
+	}
+
+	peer_disk_state = peer_state.disk;
+
+	if (peer_disk_state > D_DISKLESS && !want_bitmap(peer_device)) {
+		drbd_warn(peer_device, "The peer is configured to be diskless but presents %s\n",
+			  drbd_disk_str(peer_disk_state));
+		goto fail;
+	}
+
+	if (peer_state.disk == D_NEGOTIATING) {
+		peer_disk_state = peer_device->uuid_flags & UUID_FLAG_INCONSISTENT ?
+			D_INCONSISTENT : D_CONSISTENT;
+		drbd_info(peer_device, "real peer disk state = %s\n", drbd_disk_str(peer_disk_state));
+	}
+
+	read_lock_irq(&resource->state_rwlock);
+	old_peer_state = drbd_get_peer_device_state(peer_device, NOW);
+	read_unlock_irq(&resource->state_rwlock);
+ retry:
+	new_repl_state = max_t(enum drbd_repl_state, old_peer_state.conn, L_OFF);
+	consumed_resync = false;
+
+	/* If some other part of the code (ack_receiver thread, timeout)
+	 * already decided to close the connection again,
+	 * we must not "re-establish" it here. */
+	if (old_peer_state.conn <= C_TEAR_DOWN)
+		return -ECONNRESET;
+
+	if (!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags) &&
+	    peer_state.role == R_PRIMARY && peer_device->uuid_flags & UUID_FLAG_STABLE)
+		check_resync_source(peer_device, peer_device->uuid_node_mask);
+
+	peer_was_resync_target =
+		connection->agreed_pro_version >= 110 ?
+		peer_device->last_repl_state == L_SYNC_TARGET ||
+		peer_device->last_repl_state == L_PAUSED_SYNC_T
+		:
+		true;
+	/* If this is the "end of sync" confirmation, usually the peer disk
+	 * was D_INCONSISTENT or D_CONSISTENT. (Since the peer might be
+	 * weak we do not know anything about its new disk state)
+	 */
+	if (peer_was_resync_target &&
+	    (old_peer_state.pdsk == D_INCONSISTENT || old_peer_state.pdsk == D_CONSISTENT) &&
+	    old_peer_state.conn > L_ESTABLISHED && old_peer_state.disk >= D_INCONSISTENT) {
+		/* If we are (becoming) SyncSource, but peer is still in sync
+		 * preparation, ignore its uptodate-ness to avoid flapping, it
+		 * will change to inconsistent once the peer reaches active
+		 * syncing states.
+		 * It may have changed syncer-paused flags, however, so we
+		 * cannot ignore this completely. */
+		if (peer_state.conn > L_ESTABLISHED &&
+		    peer_state.conn < L_SYNC_SOURCE)
+			peer_disk_state = D_INCONSISTENT;
+
+		/* if peer_state changes to connected at the same time,
+		 * it explicitly notifies us that it finished resync.
+		 * Maybe we should finish it up, too? */
+		else if (peer_state.conn == L_ESTABLISHED) {
+			bool finish_now = false;
+
+			if (old_peer_state.conn == L_WF_BITMAP_S) {
+				read_lock_irq(&resource->state_rwlock);
+				if (peer_device->repl_state[NOW] == L_WF_BITMAP_S)
+					peer_device->resync_finished_pdsk = peer_state.disk;
+				else if (peer_device->repl_state[NOW] == L_SYNC_SOURCE)
+					finish_now = true;
+				read_unlock_irq(&resource->state_rwlock);
+			}
+
+			if (finish_now || old_peer_state.conn == L_SYNC_SOURCE ||
+			    old_peer_state.conn == L_PAUSED_SYNC_S) {
+				drbd_resync_finished(peer_device, peer_state.disk);
+				peer_device->last_repl_state = peer_state.conn;
+			}
+			return 0;
+		}
+	}
+
+	/* explicit verify finished notification, stop sector reached. */
+	if (old_peer_state.conn == L_VERIFY_T && old_peer_state.disk == D_UP_TO_DATE &&
+	    peer_state.conn == L_ESTABLISHED && peer_disk_state == D_UP_TO_DATE) {
+		ov_out_of_sync_print(peer_device);
+		drbd_resync_finished(peer_device, D_MASK);
+		peer_device->last_repl_state = peer_state.conn;
+		return 0;
+	}
+
+	/* The peer pulled ahead and came back while we stayed SyncTarget
+	 * (its P_RS_CANCEL_AHEAD outran the Ahead state change), so the
+	 * SyncTarget -> Behind -> SyncTarget path that would clear the flag
+	 * is never taken. Clear it here and resume issuing requests.
+	 */
+	if (peer_state.conn == L_SYNC_SOURCE &&
+	    peer_device->repl_state[NOW] == L_SYNC_TARGET &&
+	    test_and_clear_bit(SYNC_TARGET_TO_BEHIND, peer_device->flags)) {
+		drbd_info(peer_device, "peer back from ahead, resuming resync requests\n");
+		mod_timer(&peer_device->resync_timer, jiffies + RS_MAKE_REQS_INTV);
+	}
+
+	/* Start resync after AHEAD/BEHIND */
+	if (connection->agreed_pro_version >= 110 &&
+	    peer_state.conn == L_SYNC_SOURCE && old_peer_state.conn == L_BEHIND) {
+		/*
+		 * Become Inconsistent immediately because we may now receive
+		 * data. Delay the start of the resync itself until any
+		 * previous resync is no longer active.
+		 */
+		rv = change_disk_state(device, D_INCONSISTENT, CS_VERBOSE,
+				"resync-after-behind", NULL);
+		if (rv < SS_SUCCESS)
+			goto fail;
+
+		peer_device->start_resync_side = L_SYNC_TARGET;
+		drbd_peer_device_post_work(peer_device, RS_START);
+		return 0;
+	}
+
+	/* peer says his disk is inconsistent, while we think it is uptodate,
+	 * and this happens while the peer still thinks we have a sync going on,
+	 * but we think we are already done with the sync.
+	 * We ignore this to avoid flapping pdsk.
+	 * This should not happen, if the peer is a recent version of drbd. */
+	if (old_peer_state.pdsk == D_UP_TO_DATE && peer_disk_state == D_INCONSISTENT &&
+	    old_peer_state.conn == L_ESTABLISHED && peer_state.conn > L_SYNC_SOURCE)
+		peer_disk_state = D_UP_TO_DATE;
+
+	if (new_repl_state == L_OFF)
+		new_repl_state = L_ESTABLISHED;
+
+	if (peer_state.conn == L_AHEAD)
+		new_repl_state = L_BEHIND;
+
+	/* with protocol >= 118 uuid & state packets come after the 2PC prepare packet */
+	do_handshake =
+		(test_bit(UUIDS_RECEIVED, peer_device->flags) ||
+			test_bit(CURRENT_UUID_RECEIVED, peer_device->flags)) &&
+		(connection->agreed_pro_version < 118 ||
+			drbd_twopc_between_peer_and_me(connection)) &&
+		old_peer_state.conn < L_ESTABLISHED;
+
+	if (test_bit(UUIDS_RECEIVED, peer_device->flags) &&
+	    peer_state.disk >= D_NEGOTIATING &&
+	    get_ldev_if_state(device, D_NEGOTIATING)) {
+		enum sync_strategy strategy = UNDETERMINED;
+		bool consider_resync;
+
+		/* clear CONN_DISCARD_MY_DATA so late, to not lose it if peer
+		   gets aborted before we are able to do the resync handshake. */
+		clear_bit(CONN_DISCARD_MY_DATA, &connection->flags);
+
+		/* if we established a new connection */
+		consider_resync = do_handshake &&
+					!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags);
+		/* if we have both been inconsistent, and the peer has been
+		 * forced to be UpToDate with --force */
+		consumed_resync = test_and_clear_bit(CONSIDER_RESYNC, peer_device->flags);
+		consider_resync |= consumed_resync;
+		/* if we had been plain connected, and the admin requested to
+		 * start a sync by "invalidate" or "invalidate-remote" */
+		consider_resync |= (old_peer_state.conn == L_ESTABLISHED &&
+				    (peer_state.conn == L_STARTING_SYNC_S ||
+				     peer_state.conn == L_STARTING_SYNC_T));
+
+		/* A crashed primary announces WFBitMapT when the connection is
+		 * established; that P_STATE races with the bitmap we already send.
+		 * Only run a handshake for it while no resync is under way.
+		 */
+		consider_resync |= old_peer_state.conn == L_ESTABLISHED &&
+				   peer_state.conn == L_WF_BITMAP_T &&
+				   peer_device->uuid_flags & UUID_FLAG_CRASHED_PRIMARY;
+
+		/* The peer decides on the UUIDs we send after its attach; so do we,
+		 * whichever handshake runs below. Once the peer has decided, it
+		 * no longer reports D_NEGOTIATING; sending now would make us
+		 * decide on UUIDs it never saw.
+		 */
+		if (old_peer_state.conn == L_ESTABLISHED && peer_state.disk == D_NEGOTIATING)
+			drbd_send_uuids_peer_attach(peer_device);
+
+		if (consider_resync) {
+			strategy = drbd_sync_handshake(peer_device, peer_state);
+			new_repl_state = strategy_to_repl_state(peer_device, peer_state.role, strategy);
+			/* An Outdated peer upgrades itself in this commit when it
+			 * connects to us as a stable UpToDate neighbor without a
+			 * resync (see sanitize_state()).  Record the same here, or
+			 * a write before its next P_STATE is not replicated to it.
+			 */
+			if (old_peer_state.conn < L_ESTABLISHED &&
+			    new_repl_state == L_ESTABLISHED &&
+			    peer_disk_state == D_OUTDATED &&
+			    device->disk_state[NOW] >= D_CONSISTENT &&
+			    peer_device->comm_uuid_flags & UUID_FLAG_STABLE)
+				peer_disk_state = device->disk_state[NOW];
+		} else if (old_peer_state.conn == L_ESTABLISHED &&
+			   (peer_state.disk == D_NEGOTIATING ||
+			    old_peer_state.disk == D_NEGOTIATING)) {
+			strategy = drbd_attach_handshake(peer_device, peer_disk_state);
+			new_repl_state = strategy_to_repl_state(peer_device, peer_state.role, strategy);
+			if (new_repl_state == L_ESTABLISHED && device->disk_state[NOW] == D_UP_TO_DATE)
+				peer_disk_state = D_UP_TO_DATE;
+		}
+
+		put_ldev(device);
+		if (strategy_descriptor(strategy).reconnect) { /* retry connect */
+			maybe_force_secondary(peer_device);
+			if (connection->agreed_pro_version >= 118)
+				set_bit(CONN_HANDSHAKE_RETRY, &connection->flags);
+			else
+				return -EIO; /* retry connect */
+		} else if (strategy_descriptor(strategy).disconnect) {
+			if (device->disk_state[NOW] == D_NEGOTIATING) {
+				new_repl_state = L_NEG_NO_RESULT;
+			} else if (peer_state.disk == D_NEGOTIATING) {
+				if (connection->agreed_pro_version < 110) {
+					drbd_err(device, "Disk attach process on the peer node was aborted.\n");
+					peer_state.disk = D_DISKLESS;
+					peer_disk_state = D_DISKLESS;
+				} else {
+					/* The peer will decide later and let us know... */
+					peer_disk_state = D_NEGOTIATING;
+				}
+			} else {
+				if (test_and_clear_bit(CONN_DRY_RUN, &connection->flags))
+					return -EIO;
+				if (connection->agreed_pro_version >= 118)
+					set_bit(CONN_HANDSHAKE_DISCONNECT, &connection->flags);
+				else
+					goto fail;
+			}
+		}
+
+		if (device->disk_state[NOW] == D_NEGOTIATING) {
+			begin_state_chg_flags |= CS_FORCE_RECALC;
+			peer_device->negotiation_result = new_repl_state;
+		}
+	}
+
+	if (test_bit(UUIDS_RECEIVED, peer_device->flags) &&
+	    peer_device->repl_state[NOW] == L_OFF && device->disk_state[NOW] == D_DISKLESS) {
+		u64 exposed_data_uuid = device->exposed_data_uuid;
+		u64 peer_current_uuid = peer_device->current_uuid;
+
+		drbd_info(peer_device, "my exposed UUID: %016llX\n", exposed_data_uuid);
+		drbd_uuid_dump_peer(peer_device, peer_device->dirty_bits, peer_device->uuid_flags);
+
+		/* I am diskless connecting to a peer with disk, check that UUID match
+		   We only check if the peer claims to have D_UP_TO_DATE data. Only then is the
+		   peer a source for my data anyways. */
+		if (exposed_data_uuid && peer_state.disk == D_UP_TO_DATE &&
+		    (exposed_data_uuid & ~UUID_PRIMARY) == (peer_current_uuid & ~UUID_PRIMARY)) {
+			/* The peer is already on our current generation's label, so
+			 * the pending predecessor->current reconcile relabel is moot.
+			 */
+			clear_bit(RECONCILE_INJECT_CUR_UUID, peer_device->flags);
+		} else if (exposed_data_uuid && peer_state.disk == D_UP_TO_DATE &&
+			   (exposed_data_uuid & ~UUID_PRIMARY) !=
+				(peer_current_uuid & ~UUID_PRIMARY)) {
+			diskless_with_peers_different_current_uuids(peer_device, &peer_disk_state);
+		}
+		if (!exposed_data_uuid && peer_state.disk == D_UP_TO_DATE) {
+			drbd_uuid_set_exposed(device, peer_current_uuid, true);
+			propagate_exposed_uuid(device);
+		}
+	}
+
+	/*
+	 * A peer that finished a resync sends its UUIDs ahead of its state, so
+	 * receive_uuids() saw them while the peer was still Inconsistent and
+	 * did not follow it. Follow it now that it is UpToDate. A peer that
+	 * attaches with UpToDate data of another generation is not followed.
+	 */
+	if (test_bit(UUIDS_RECEIVED, peer_device->flags) &&
+	    peer_device->repl_state[NOW] >= L_ESTABLISHED &&
+	    device->disk_state[NOW] == D_DISKLESS &&
+	    resource->role[NOW] == R_SECONDARY &&
+	    peer_device->disk_state[NOW] == D_INCONSISTENT &&
+	    peer_state.disk == D_UP_TO_DATE)
+		drbd_uuid_set_exposed(device, peer_device->current_uuid, true);
+
+	if (peer_device->repl_state[NOW] == L_OFF && peer_state.disk == D_DISKLESS && get_ldev(device)) {
+		u64 uuid_flags = 0;
+
+		drbd_collect_local_uuid_flags(peer_device, NULL);
+		drbd_uuid_dump_self(peer_device, peer_device->comm_bm_set, uuid_flags);
+		drbd_info(peer_device, "peer's exposed UUID: %016llX\n", peer_device->current_uuid);
+
+		if (peer_state.role == R_PRIMARY &&
+		    (peer_device->current_uuid & ~UUID_PRIMARY) ==
+		    (drbd_current_uuid(device) & ~UUID_PRIMARY)) {
+			/* Connecting to diskless primary peer. When the state change is committed,
+			 * sanitize_state might set me D_UP_TO_DATE. Make sure the
+			 * effective_size is set. */
+			peer_device->max_size = peer_device->c_size;
+			drbd_determine_dev_size(device, peer_device->max_size, 0, NULL);
+		}
+
+		put_ldev(device);
+	}
+
+	if (test_bit(HOLDING_UUID_READ_LOCK, peer_device->flags) ||
+	    connection->agreed_pro_version < 110) {
+		struct drbd_transport *transport = &connection->transport;
+		/* Last packet of handshake received, disarm receive timeout */
+		transport->class->ops.set_rcvtimeo(transport, DATA_STREAM, MAX_SCHEDULE_TIMEOUT);
+	}
+
+	if (new_repl_state == L_ESTABLISHED && peer_disk_state == D_CONSISTENT &&
+	    drbd_suspended(device) && peer_device->repl_state[NOW] < L_ESTABLISHED &&
+	    drbd_gen_obligation_state(device) == GEN_OBL_ARMED) {
+		/* Do not allow RESEND for a rebooted peer. We can only allow this
+		 * for temporary network outages!
+		 */
+		drbd_err(peer_device, "Aborting Connect, can not thaw IO with an only Consistent peer\n");
+		/* gen-rotate reason: DEGRADE (abort connect; only-Consistent peer,
+		 * cannot thaw).  The connection is torn down below; the writes
+		 * held towards this peer are stranded either way, so mint before
+		 * any resume.  A suspend-io stays in place until resume-io lifts
+		 * it.
+		 */
+		drbd_gen_obligation_mint_before_resume(device, NODE_MASK(peer_device->node_id));
+		begin_state_change(resource, &irq_flags, CS_HARD);
+		__change_cstate(connection, C_PROTOCOL_ERROR);
+		end_state_change(resource, &irq_flags, "abort-connect");
+		return -EIO;
+	}
+
+	clear_bit(RS_SOURCE_MISSED_END, peer_device->flags);
+	clear_bit(RS_PEER_MISSED_END, peer_device->flags);
+
+	assign_bit(PEER_QUORATE, peer_device->flags, peer_state.quorum);
+
+	if (do_handshake) {
+		/* Ignoring state packets before the 2PC; they are from aborted 2PCs */
+		bool done = test_bit(INITIAL_STATE_RECEIVED, peer_device->flags);
+
+		set_bit(INITIAL_STATE_RECEIVED, peer_device->flags);
+		if (connection->cstate[NOW] == C_CONNECTING) {
+			peer_device->connect_state.peer_isp =
+				peer_state.aftr_isp | peer_state.user_isp;
+
+			if (!done) {
+				peer_device->connect_state.conn = new_repl_state;
+				peer_device->connect_state.peer = peer_state.role;
+				peer_device->connect_state.pdsk = peer_disk_state;
+			}
+			wake_up(&connection->ee_wait);
+			finish_nested_twopc(connection);
+		}
+	}
+
+	/* State change will be performed when the two-phase commit is committed. */
+	if (connection->cstate[NOW] == C_CONNECTING)
+		return 0;
+
+	if (peer_state.conn == L_OFF) {
+		/* device/minor hot add on the peer of a minor already locally known */
+		if (peer_device->repl_state[NOW] == L_NEGOTIATING) {
+			drbd_send_enable_replication_next(peer_device);
+			drbd_send_sizes(peer_device, 0, 0);
+			drbd_send_uuids(peer_device, 0, 0);
+		}
+		drbd_send_current_state(peer_device);
+	}
+
+	begin_state_change(resource, &irq_flags, begin_state_chg_flags);
+	if (old_peer_state.i != drbd_get_peer_device_state(peer_device, NOW).i) {
+		if (consumed_resync)
+			set_bit(CONSIDER_RESYNC, peer_device->flags);
+		old_peer_state = drbd_get_peer_device_state(peer_device, NOW);
+		abort_state_change_locked(resource);
+		write_unlock_irq(&resource->state_rwlock);
+		goto retry;
+	}
+	if ((repl_is_sync_source(old_peer_state.conn) && new_repl_state == L_WF_BITMAP_S) ||
+	    (repl_is_sync_target(old_peer_state.conn) && new_repl_state == L_WF_BITMAP_T)) {
+		/* Re-entering the bitmap exchange is refused while that resync
+		 * runs, and a refused state change costs the connection here.
+		 * Postpone it as drbd_resync() does.
+		 */
+		peer_device->resync_again++;
+		new_repl_state = old_peer_state.conn;
+		drbd_info(peer_device, "Postponing bitmap exchange until the running resync has finished\n");
+	}
+	if (device->disk_state[NOW] != D_NEGOTIATING)
+		__change_repl_state(peer_device, new_repl_state);
+	__change_peer_role(connection, peer_state.role);
+	if (peer_state.disk != D_NEGOTIATING)
+		__change_peer_disk_state(peer_device, peer_disk_state);
+	__change_resync_susp_peer(peer_device, peer_state.aftr_isp | peer_state.user_isp);
+	repl_state = peer_device->repl_state;
+	if (repl_state[OLD] < L_ESTABLISHED && repl_state[NEW] >= L_ESTABLISHED)
+		resource->state_change_flags |= CS_HARD;
+
+	rv = end_state_change(resource, &irq_flags, "peer-state");
+	new_repl_state = peer_device->repl_state[NOW];
+
+	if (rv < SS_SUCCESS)
+		goto fail;
+
+	if (old_peer_state.conn > L_OFF) {
+		if (new_repl_state > L_ESTABLISHED && peer_state.conn <= L_ESTABLISHED &&
+		    peer_state.disk != D_NEGOTIATING) {
+			/* we want resync, peer has not yet decided to sync... */
+			/* Nowadays only used when forcing a node into primary role and
+			   setting its disk to UpToDate with that */
+			drbd_send_uuids(peer_device, 0, 0);
+			drbd_send_current_state(peer_device);
+		}
+	}
+
+	clear_bit(DISCARD_MY_DATA, peer_device->flags); /* for agreed_pro_version < 117 */
+
+	drbd_md_sync(device); /* update connected indicator, effective_size, ... */
+
+	peer_device->last_repl_state = peer_state.conn;
+	return 0;
+fail:
+	change_cstate(connection, C_DISCONNECTING, CS_HARD);
+	return -EIO;
+}
+
+static int receive_sync_uuid(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct p_uuid *p = pi->data;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
+
+	wait_event(device->misc_wait,
+		   peer_device->repl_state[NOW] == L_WF_SYNC_UUID ||
+		   peer_device->repl_state[NOW] == L_BEHIND ||
+		   peer_device->repl_state[NOW] < L_ESTABLISHED ||
+		   device->disk_state[NOW] < D_NEGOTIATING);
+
+	/* D_ASSERT(device,  peer_device->repl_state[NOW] == L_WF_SYNC_UUID ); */
+
+	/* Here the _drbd_uuid_ functions are right, current should
+	   _not_ be rotated into the history */
+	if (get_ldev_if_state(device, D_NEGOTIATING)) {
+		_drbd_uuid_set_current(device, be64_to_cpu(p->uuid));
+		_drbd_uuid_set_bitmap(peer_device, 0UL);
+
+		drbd_print_uuids(peer_device, "updated sync uuid");
+		drbd_start_resync(peer_device, L_SYNC_TARGET, "peer-sync-uuid");
+
+		put_ldev(device);
+	} else
+		drbd_err(device, "Ignoring SyncUUID packet!\n");
+
+	return 0;
+}
+
+static void scale_bits(unsigned long *base, unsigned int num_4k, unsigned int scale)
+{
+	unsigned int bits = num_4k * BITS_PER_LONG;
+	unsigned int sbit;
+
+	if (scale == 0)
+		return;
+
+	for (sbit = 0; sbit < bits; sbit++)
+		if (test_bit(sbit, base))
+			__set_bit(sbit >> scale, base);
+}
+
+/*
+ * receive_bitmap_plain
+ *
+ * Return 0 when done, 1 when another iteration is needed, and a negative error
+ * code upon failure.
+ *
+ * Received bitmap is 4k per bit, need to aggregate by c->scale.
+ */
+static int
+receive_bitmap_plain(struct drbd_peer_device *peer_device, unsigned int size,
+		     struct bm_xfer_ctx *c)
+{
+	unsigned long *p;
+	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE -
+				 drbd_header_size(peer_device->connection);
+	unsigned int num_words_4k = min_t(size_t, data_size / sizeof(*p),
+				       (c->bm_words - c->word_offset) << c->scale);
+	unsigned int want = num_words_4k * sizeof(*p);
+	int err;
+
+	if (want != size) {
+		drbd_err(peer_device, "%s:want (%u) != size (%u)\n", __func__, want, size);
+		return -EIO;
+	}
+	if (want == 0)
+		return 0;
+	err = drbd_recv_all(peer_device->connection, (void **)&p, want);
+	if (err)
+		return err;
+
+	if ((num_words_4k & ((1 << c->scale)-1)) != 0) {
+		drbd_err(peer_device,
+			"number of words %u not aligned to scale %u while receiving bitmap\n",
+			num_words_4k, c->scale);
+		return -ERANGE;
+	}
+
+	if (get_ldev(peer_device->device)) {
+		scale_bits(p, num_words_4k, c->scale);
+		drbd_bm_merge_lel(peer_device, c->word_offset, num_words_4k >> c->scale, p);
+		put_ldev(peer_device->device);
+	} else {
+		drbd_err(peer_device, "lost backend device while receiving bitmap\n");
+		return -EIO;
+	}
+
+	c->word_offset += num_words_4k >> c->scale;
+	c->bit_offset = c->word_offset * BITS_PER_LONG;
+	c->bit_offset_4k = (c->word_offset << c->scale) * BITS_PER_LONG;
+	if (c->bit_offset > c->bm_bits)
+		c->bit_offset = c->bm_bits;
+
+	return 1;
+}
+
+static enum drbd_bitmap_code dcbp_get_code(struct p_compressed_bm *p)
+{
+	return (enum drbd_bitmap_code)(p->encoding & 0x0f);
+}
+
+static int dcbp_get_start(struct p_compressed_bm *p)
+{
+	return (p->encoding & 0x80) != 0;
+}
+
+static int dcbp_get_pad_bits(struct p_compressed_bm *p)
+{
+	return (p->encoding >> 4) & 0x7;
+}
+
+/*
+ * recv_bm_rle_bits
+ *
+ * Return 0 when done, 1 when another iteration is needed, and a negative error
+ * code upon failure.
+ */
+static int
+recv_bm_rle_bits(struct drbd_peer_device *peer_device,
+		struct p_compressed_bm *p,
+		 struct bm_xfer_ctx *c,
+		 unsigned int len)
+{
+	struct bitstream bs;
+	u64 look_ahead;
+	u64 rl_4k;
+	u64 tmp;
+	unsigned long s_4k = c->bit_offset_4k;
+	int toggle = dcbp_get_start(p);
+	int have;
+	int bits;
+
+	bitstream_init(&bs, p->code, len, dcbp_get_pad_bits(p));
+
+	bits = bitstream_get_bits(&bs, &look_ahead, 64);
+	if (bits < 0)
+		return -EIO;
+
+	for (have = bits; have > 0; s_4k += rl_4k, toggle = !toggle) {
+		bits = vli_decode_bits(&rl_4k, look_ahead);
+		if (bits <= 0)
+			return -EIO;
+
+		if (toggle) {
+			/* If peers bm_block_size is smaller than ours,
+			 * this may be a "partially" set bit ;-)
+			 * there is no such thing. Round down s, round up e.
+			 */
+			unsigned long s = s_4k >> c->scale;
+			unsigned long e = ((s_4k + rl_4k + (1UL << c->scale)-1) >> c->scale) - 1;
+
+			if (e >= c->bm_bits) {
+				drbd_err(peer_device, "bitmap overflow (e:%lu) while decoding bm RLE packet\n", e);
+				return -EIO;
+			}
+			drbd_bm_set_many_bits(peer_device, s, e);
+		}
+
+		if (have < bits) {
+			drbd_err(peer_device, "bitmap decoding error: h:%d b:%d la:0x%08llx l:%u/%u\n",
+				have, bits, look_ahead,
+				(unsigned int)(bs.cur.b - p->code),
+				(unsigned int)bs.buf_len);
+			return -EIO;
+		}
+		/* if we consumed all 64 bits, assign 0; >> 64 is "undefined"; */
+		if (likely(bits < 64))
+			look_ahead >>= bits;
+		else
+			look_ahead = 0;
+		have -= bits;
+
+		bits = bitstream_get_bits(&bs, &tmp, 64 - have);
+		if (bits < 0)
+			return -EIO;
+		look_ahead |= tmp << have;
+		have += bits;
+	}
+
+	c->bit_offset_4k = s_4k;
+	c->bit_offset = s_4k >> c->scale;
+	bm_xfer_ctx_bit_to_word_offset(c);
+
+	return (c->bit_offset_4k != c->bm_bits_4k);
+}
+
+/*
+ * decode_bitmap_c
+ *
+ * Return 0 when done, 1 when another iteration is needed, and a negative error
+ * code upon failure.
+ */
+static int
+decode_bitmap_c(struct drbd_peer_device *peer_device,
+		struct p_compressed_bm *p,
+		struct bm_xfer_ctx *c,
+		unsigned int len)
+{
+	if (dcbp_get_code(p) == RLE_VLI_Bits) {
+		struct drbd_device *device = peer_device->device;
+		int res;
+
+		if (!get_ldev(device)) {
+			drbd_err(peer_device, "lost backend device while receiving bitmap\n");
+			return -EIO;
+		}
+
+		res = recv_bm_rle_bits(peer_device, p, c, len - sizeof(*p));
+		put_ldev(device);
+		return res;
+	}
+
+	/* other variants had been implemented for evaluation,
+	 * but have been dropped as this one turned out to be "best"
+	 * during all our tests.
+	 */
+
+	drbd_err(peer_device, "receive_bitmap_c: unknown encoding %u\n", p->encoding);
+	change_cstate(peer_device->connection, C_PROTOCOL_ERROR, CS_HARD);
+	return -EIO;
+}
+
+void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
+		const char *direction, struct bm_xfer_ctx *c)
+{
+	/* what would it take to transfer it "plaintext" */
+	unsigned int header_size = drbd_header_size(peer_device->connection);
+	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE - header_size;
+	unsigned int plain =
+		header_size * (DIV_ROUND_UP(c->bm_words, data_size) + 1) +
+		c->bm_words * sizeof(unsigned long);
+	unsigned int total = c->bytes[0] + c->bytes[1];
+	unsigned int r;
+
+	/* total can not be zero. but just in case: */
+	if (total == 0)
+		return;
+
+	/* don't report if not compressed */
+	if (total >= plain)
+		return;
+
+	/* total < plain. check for overflow, still */
+	r = (total > UINT_MAX/1000) ? (total / (plain/1000))
+					    : (1000 * total / plain);
+
+	if (r > 1000)
+		r = 1000;
+
+	r = 1000 - r;
+	drbd_info(peer_device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
+	     "total %u; compression: %u.%u%%\n",
+			direction,
+			c->bytes[1], c->packets[1],
+			c->bytes[0], c->packets[0],
+			total, r/10, r % 10);
+}
+
+static bool ready_for_bitmap(struct drbd_device *device)
+{
+	struct drbd_resource *resource = device->resource;
+	bool ready = true;
+
+	read_lock_irq(&resource->state_rwlock);
+	if (device->disk_state[NOW] == D_NEGOTIATING)
+		ready = false;
+	if (test_bit(TWOPC_STATE_CHANGE_PENDING, &resource->flags))
+		ready = false;
+	read_unlock_irq(&resource->state_rwlock);
+
+	return ready;
+}
+
+/* Since we are processing the bitfield from lower addresses to higher,
+   it does not matter if the process it in 32 bit chunks or 64 bit
+   chunks as long as it is little endian. (Understand it as byte stream,
+   beginning with the lowest byte...) If we would use big endian
+   we would need to process it from the highest address to the lowest,
+   in order to be agnostic to the 32 vs 64 bits issue.
+
+   returns 0 on failure, 1 if we successfully received it. */
+static int receive_bitmap(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	enum drbd_repl_state repl_state;
+	struct drbd_device *device;
+	struct bm_xfer_ctx c;
+	int err = -EIO;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	if (peer_device->bitmap_index == -1) {
+		drbd_err(peer_device, "No bitmap allocated in receive_bitmap()!\n");
+		return -EIO;
+	}
+	device = peer_device->device;
+
+	/* Final repl_states become visible when the disk leaves NEGOTIATING state */
+	wait_event_interruptible(device->resource->state_wait,
+				 ready_for_bitmap(device));
+
+	if (!get_ldev(device)) {
+		drbd_err(device, "Cannot receive bitmap, local disk gone\n");
+		return -EIO;
+	}
+
+	drbd_bm_slot_lock(peer_device, "receive bitmap", BM_LOCK_CLEAR | BM_LOCK_BULK);
+	/* you are supposed to send additional out-of-sync information
+	 * if you actually set bits during this phase */
+
+	if (!get_ldev(device))
+		goto out;
+
+	c = (struct bm_xfer_ctx) {
+		.bm_bits_4k = drbd_bm_bits_4k(device),
+		.bm_bits = drbd_bm_bits(device),
+		.bm_words = drbd_bm_words(device),
+		.scale = device->bitmap->bm_block_shift - BM_BLOCK_SHIFT_4k,
+	};
+	put_ldev(device);
+
+	for (;;) {
+		if (pi->cmd == P_BITMAP)
+			err = receive_bitmap_plain(peer_device, pi->size, &c);
+		else if (pi->cmd == P_COMPRESSED_BITMAP) {
+			/* MAYBE: sanity check that we speak proto >= 90,
+			 * and the feature is enabled! */
+			struct p_compressed_bm *p;
+
+			if (pi->size > DRBD_SOCKET_BUFFER_SIZE - drbd_header_size(connection)) {
+				drbd_err(device, "ReportCBitmap packet too large\n");
+				err = -EIO;
+				goto out;
+			}
+			if (pi->size <= sizeof(*p)) {
+				drbd_err(device, "ReportCBitmap packet too small (l:%u)\n", pi->size);
+				err = -EIO;
+				goto out;
+			}
+			err = drbd_recv_all(connection, (void **)&p, pi->size);
+			if (err)
+				goto out;
+			err = decode_bitmap_c(peer_device, p, &c, pi->size);
+		} else {
+			drbd_warn(device, "receive_bitmap: cmd neither ReportBitMap nor ReportCBitMap (is 0x%x)", pi->cmd);
+			err = -EIO;
+			goto out;
+		}
+
+		c.packets[pi->cmd == P_BITMAP]++;
+		c.bytes[pi->cmd == P_BITMAP] += drbd_header_size(connection) + pi->size;
+
+		if (err <= 0) {
+			if (err < 0)
+				goto out;
+			break;
+		}
+		err = drbd_recv_header(connection, pi);
+		if (err)
+			goto out;
+	}
+
+	INFO_bm_xfer_stats(peer_device, "receive", &c);
+
+	repl_state = peer_device->repl_state[NOW];
+	if (repl_state == L_WF_BITMAP_T) {
+		err = drbd_send_bitmap(device, peer_device);
+		if (err)
+			goto out;
+	}
+
+	drbd_bm_slot_unlock(peer_device);
+	put_ldev(device);
+
+	if (test_bit(B_RS_H_DONE, peer_device->flags)) {
+		/* We have entered drbd_start_resync() since starting the bitmap exchange. */
+		drbd_warn(peer_device, "Received bitmap more than once; ignoring\n");
+	} else if (repl_state == L_WF_BITMAP_S) {
+		drbd_start_resync(peer_device, L_SYNC_SOURCE, "receive-bitmap");
+	} else if (repl_state == L_WF_BITMAP_T) {
+		if (connection->agreed_pro_version < 110) {
+			enum drbd_state_rv rv;
+
+			/* Omit CS_WAIT_COMPLETE and CS_SERIALIZE with this state
+			 * transition to avoid deadlocks. */
+			rv = stable_change_repl_state(peer_device, L_WF_SYNC_UUID, CS_VERBOSE,
+					"receive-bitmap");
+			D_ASSERT(device, rv == SS_SUCCESS);
+		} else {
+			drbd_start_resync(peer_device, L_SYNC_TARGET, "receive-bitmap");
+		}
+	} else {
+		/* admin may have requested C_DISCONNECTING,
+		 * other threads may have noticed network errors */
+		drbd_info(peer_device, "unexpected repl_state (%s) in receive_bitmap\n",
+			  drbd_repl_str(repl_state));
+	}
+
+	return 0;
+ out:
+	drbd_bm_slot_unlock(peer_device);
+	put_ldev(device);
+	return err;
+}
+
+static int receive_skip(struct drbd_connection *connection, struct packet_info *pi)
+{
+	drbd_warn(connection, "skipping unknown optional packet type %d, l: %d!\n",
+		 pi->cmd, pi->size);
+
+	return ignore_remaining_packet(connection, pi->size);
+}
+
+static int receive_UnplugRemote(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_transport *transport = &connection->transport;
+
+	/* Make sure we've acked all the data associated
+	 * with the data requests being unplugged */
+	transport->class->ops.hint(transport, DATA_STREAM, QUICKACK);
+
+	/* just unplug all devices always, regardless which volume number */
+	drbd_unplug_all_devices(connection);
+
+	return 0;
+}
+
+static int receive_out_of_sync(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_block_desc *p = pi->data;
+	sector_t sector;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+
+	sector = be64_to_cpu(p->sector);
+
+	/* see also process_one_request(), before drbd_send_out_of_sync().
+	 * Make sure any pending write requests that potentially may
+	 * set in-sync have drained, before setting it out-of-sync.
+	 * That should be implicit, because of the "epoch" and P_BARRIER logic,
+	 * But let's just double-check.
+	 */
+	conn_wait_active_ee_empty_or_disconnect(connection);
+	conn_wait_done_ee_empty_or_disconnect(connection);
+
+	drbd_set_out_of_sync(peer_device, sector, be32_to_cpu(p->blksize));
+
+	return 0;
+}
+
+static int receive_dagtag(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_dagtag *p = pi->data;
+
+	set_connection_dagtag(connection, be64_to_cpu(p->dagtag));
+	return 0;
+}
+
+struct drbd_connection *drbd_connection_by_node_id(struct drbd_resource *resource, int node_id)
+{
+	/* Caller needs to hold rcu_read_lock(), conf_update */
+	struct drbd_connection *connection;
+
+	for_each_connection_rcu(connection, resource) {
+		if (connection->peer_node_id == node_id)
+			return connection;
+	}
+
+	return NULL;
+}
+
+struct drbd_connection *drbd_get_connection_by_node_id(struct drbd_resource *resource, int node_id)
+{
+	struct drbd_connection *connection;
+
+	rcu_read_lock();
+	connection = drbd_connection_by_node_id(resource, node_id);
+	if (connection)
+		kref_get(&connection->kref);
+	rcu_read_unlock();
+
+	return connection;
+}
+
+static int receive_peer_dagtag(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	enum drbd_repl_state new_repl_state;
+	struct p_peer_dagtag *p = pi->data;
+	struct drbd_connection *lost_peer;
+	enum sync_strategy strategy = NO_SYNC;
+	s64 dagtag_offset;
+	int vnr = 0;
+
+	/*
+	 * During the connect handshake (DRBD_FF_RECONCILE_RECONNECT) the peer
+	 * sends its position in a common lost primary's change stream before its
+	 * state packet. Stash it for drbd_uuid_compare(), which uses it to roll
+	 * an equal-UUID both-dirty reconcile forward, and do not run the
+	 * established-connection reconciliation below: the connection is not up
+	 * yet, and the resync direction is decided synchronously in the handshake.
+	 */
+	if (connection->cstate[NOW] < C_CONNECTED) {
+		connection->reconcile_handshake.lost_node_id = be32_to_cpu(p->node_id);
+		connection->reconcile_handshake.dagtag_sector = be64_to_cpu(p->dagtag);
+		return 0;
+	}
+
+	lost_peer = drbd_get_connection_by_node_id(resource, be32_to_cpu(p->node_id));
+	if (!lost_peer)
+		return 0;
+
+	if (lost_peer->cstate[NOW] == C_CONNECTED) {
+		drbd_ping_peer(lost_peer);
+		if (lost_peer->cstate[NOW] == C_CONNECTED)
+			goto out;
+	}
+
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		enum sync_strategy ps;
+		enum sync_rule rule;
+		int unused;
+
+		if (peer_device->repl_state[NOW] > L_ESTABLISHED)
+			goto out;
+		if (peer_device->device->disk_state[NOW] != D_CONSISTENT &&
+		    peer_device->device->disk_state[NOW] != D_UP_TO_DATE)
+			goto out;
+		if (!get_ldev(peer_device->device))
+			continue;
+		ps = drbd_uuid_compare(peer_device, &rule, &unused);
+		put_ldev(peer_device->device);
+
+		if (strategy == NO_SYNC) {
+			strategy = ps;
+			if (strategy != NO_SYNC &&
+			    strategy != SYNC_SOURCE_USE_BITMAP &&
+			    strategy != SYNC_TARGET_USE_BITMAP) {
+				drbd_info(peer_device,
+					  "%s(): %s by rule=%s\n",
+					  __func__,
+					  strategy_descriptor(strategy).name,
+					  drbd_sync_rule_str(rule));
+				goto out;
+			}
+		} else if (ps != strategy) {
+			drbd_err(peer_device,
+				 "%s(): Inconsistent resync directions %s %s\n",
+				 __func__,
+				 strategy_descriptor(strategy).name, strategy_descriptor(ps).name);
+			goto out;
+		}
+	}
+
+	/* We must wait until the other receiver thread has called the
+	 * cleanup_unacked_peer_requests() and drbd_notify_peers_lost_primary() functions. If we
+	 * become a resync target, the peer would complain about being in the wrong state when he
+	 * gets the bitmap before the P_PEER_DAGTAG packet.
+	 */
+	wait_event(resource->state_wait,
+		   !test_bit(NOTIFY_PEERS_LOST_PRIMARY, &lost_peer->flags));
+
+	dagtag_offset = atomic64_read(&lost_peer->last_dagtag_sector) - (s64)be64_to_cpu(p->dagtag);
+	if (strategy == SYNC_SOURCE_USE_BITMAP)  {
+		new_repl_state = L_WF_BITMAP_S;
+	} else if (strategy == SYNC_TARGET_USE_BITMAP)  {
+		new_repl_state = L_WF_BITMAP_T;
+	} else {
+		if (dagtag_offset > 0)
+			new_repl_state = L_WF_BITMAP_S;
+		else if (dagtag_offset < 0)
+			new_repl_state = L_WF_BITMAP_T;
+		else
+			new_repl_state = L_ESTABLISHED;
+	}
+
+	if (new_repl_state != L_ESTABLISHED) {
+		unsigned long irq_flags;
+		enum drbd_state_rv rv;
+
+		if (new_repl_state == L_WF_BITMAP_T) {
+			connection->after_reconciliation.dagtag_sector = be64_to_cpu(p->dagtag);
+			connection->after_reconciliation.lost_node_id = be32_to_cpu(p->node_id);
+		}
+
+		/* The peer drops our P_PEER_DAGTAG while it still has the lost node
+		 * connected. Send ours again, ahead of the bitmap, so it decides too.
+		 */
+		if (new_repl_state == L_WF_BITMAP_S)
+			drbd_send_peer_dagtag(connection, lost_peer);
+
+		begin_state_change(resource, &irq_flags, CS_VERBOSE);
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			__change_repl_state(peer_device, new_repl_state);
+			set_bit(RECONCILIATION_RESYNC, peer_device->flags);
+		}
+		rv = end_state_change(resource, &irq_flags, "receive-peer-dagtag");
+		if (rv == SS_SUCCESS) {
+			drbd_info(connection, "Reconciliation resync because \'%s\' disappeared. (o=%d)\n",
+				  lost_peer->transport.net_conf->name, (int)dagtag_offset);
+			if (new_repl_state == L_WF_BITMAP_T)
+				drbd_send_peer_dagtag(connection, lost_peer);
+		} else if (rv == SS_NOTHING_TO_DO) {
+			drbd_info(connection, "\'%s\' disappeared (o=%d), no reconciliation since one diskless\n",
+				  lost_peer->transport.net_conf->name, (int)dagtag_offset);
+			/* sanitize_state() silently removes the resync and the RECONCILIATION_RESYNC bit */
+		} else {
+			drbd_info(connection, "rv = %d", rv);
+		}
+	} else {
+		drbd_info(connection, "No reconciliation resync even though \'%s\' disappeared. (o=%d)\n",
+			  lost_peer->transport.net_conf->name, (int)dagtag_offset);
+
+		/* Only bits this loss set are covered by the equal dagtags.
+		 * Do not consume the flag: a second primary lost at the same
+		 * time shares it, and the next loss rewrites it anyway.
+		 */
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			if (test_bit(BITMAP_HELD_AT_PRIMARY_LOSS, peer_device->flags)) {
+				drbd_info(peer_device, "Keeping out-of-sync bits from before\n");
+				continue;
+			}
+			if (get_ldev(peer_device->device)) {
+				drbd_bm_clear_many_bits(peer_device, 0, -1UL);
+				put_ldev(peer_device->device);
+			}
+		}
+	}
+
+	/* hand the bridge over to RECONCILIATION_RESYNC, or discharge if none owed */
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		clear_bit(RECONCILE_PENDING, peer_device->flags);
+	drbd_reconcile_settled_try_up_to_date(resource);
+
+out:
+	kref_put(&lost_peer->kref, drbd_destroy_connection);
+	return 0;
+}
+
+/* Whether any of our peer slots holds the UUID. Unlike
+ * drbd_find_bitmap_by_uuid() this is a local question, so it looks at every
+ * slot, not only at those the peer knows about.
+ */
+static bool uuid_in_my_bitmap_slots(struct drbd_peer_device *peer_device, u64 uuid)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_peer_md *peer_md = device->ldev->md.peers;
+	int i;
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		if (i == device->ldev->md.node_id)
+			continue;
+		if (peer_device->connection->agreed_pro_version < 116 &&
+		    peer_md[i].bitmap_index == -1)
+			continue;
+		if ((peer_md[i].bitmap_uuid & ~UUID_PRIMARY) == uuid)
+			return true;
+	}
+
+	return false;
+}
+
+static bool drbd_diskless_moved_on(struct drbd_peer_device *peer_device, u64 current_uuid)
+{
+	struct drbd_device *device = peer_device->device;
+	u64 previous = peer_device->current_uuid;
+	bool from_the_past = false;
+
+	/* No exposed UUID => did not move on. */
+	if (!current_uuid)
+		return false;
+
+	/* Same as last time => did not move on. */
+	if ((previous & ~UUID_PRIMARY) == (current_uuid & ~UUID_PRIMARY))
+		return false;
+
+	/* Only consider the peer to have moved on if we were on the same UUID. */
+	if ((previous & ~UUID_PRIMARY) != (drbd_current_uuid(device) & ~UUID_PRIMARY))
+		return false;
+
+	if (get_ldev(device)) {
+		from_the_past =
+			uuid_in_my_bitmap_slots(peer_device, current_uuid & ~UUID_PRIMARY);
+		if (!from_the_past)
+			from_the_past = uuid_in_my_history(device, current_uuid & ~UUID_PRIMARY);
+		put_ldev(device);
+	}
+
+	/* It is an old UUID => did not move on. */
+	if (from_the_past)
+		return false;
+
+	return true;
+}
+
+/* Accept a new current UUID generated on a diskless node, that just became primary
+   (or during handshake) */
+static int receive_current_uuid(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct p_current_uuid *p = pi->data;
+	u64 current_uuid, weak_nodes;
+	bool moved_on;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return config_unknown_volume(connection, pi);
+	device = peer_device->device;
+
+	current_uuid = be64_to_cpu(p->uuid);
+	weak_nodes = be64_to_cpu(p->weak_nodes);
+	weak_nodes |= NODE_MASK(peer_device->node_id);
+	moved_on = drbd_diskless_moved_on(peer_device, current_uuid);
+
+	peer_device->current_uuid = current_uuid;
+
+	if (get_ldev(device)) {
+		struct drbd_peer_md *peer_md = &device->ldev->md.peers[peer_device->node_id];
+
+		set_bit(__MDF_NODE_EXISTS, &peer_md->flags);
+		put_ldev(device);
+	}
+	if (connection->peer_role[NOW] == R_PRIMARY)
+		check_resync_source(peer_device, weak_nodes);
+
+	if (connection->peer_role[NOW] == R_UNKNOWN) {
+		set_bit(CURRENT_UUID_RECEIVED, peer_device->flags);
+		if (moved_on && device->disk_state[NOW] > D_OUTDATED)
+			peer_device->connect_state.disk = D_OUTDATED;
+		return 0;
+	}
+
+	if (current_uuid == drbd_current_uuid(device))
+		return 0;
+
+	/* None of this is serialized against concurrent state changes: moved_on
+	 * may be stale by now, and disk_state[NOW] can change between the branch
+	 * conditions.  Deciding it reliably would mean making it part of a state
+	 * change transaction.
+	 */
+	if (peer_device->repl_state[NOW] >= L_ESTABLISHED &&
+	    connection->peer_role[NOW] == R_PRIMARY &&
+	    get_ldev(device)) {
+		/* drbd_uuid_received_new_current() dispatches on our disk state:
+		 * adopt if D_UP_TO_DATE, defer into the sync source's record if
+		 * resync target (so resync-end adoption brings us to the
+		 * primary's generation), drop otherwise.
+		 */
+		drbd_uuid_received_new_current(peer_device, current_uuid, weak_nodes);
+		drbd_md_sync_if_dirty(device);
+		put_ldev(device);
+	} else if (peer_device->repl_state[NOW] >= L_ESTABLISHED &&
+		   connection->peer_role[NOW] != R_PRIMARY && moved_on &&
+		   get_ldev_if_state(device, D_UP_TO_DATE)) {
+		/* The peer is not primary but moved on to a new generation. */
+		if (resource->remote_state_change)
+			set_bit(OUTDATE_ON_2PC_COMMIT, &device->flags);
+		else
+			change_disk_state(device, D_OUTDATED, CS_VERBOSE,
+					"receive-current-uuid", NULL);
+		put_ldev(device);
+	} else if (device->disk_state[NOW] == D_DISKLESS && resource->role[NOW] == R_PRIMARY) {
+		drbd_uuid_set_exposed(device, peer_device->current_uuid, true);
+	} else if (connection->peer_role[NOW] == R_PRIMARY) {
+		/* A primary's generation we can not use: no local disk to
+		 * label it on, or this volume is not established with it.
+		 */
+		drbd_info(peer_device, "ignoring new current UUID %016llX (disk %s)\n",
+			  current_uuid, drbd_disk_str(device->disk_state[NOW]));
+	}
+
+	return 0;
+}
+
+static bool interval_is_adjacent(const struct drbd_interval *i1, const struct drbd_interval *i2)
+{
+	return i1->sector + (i1->size >> SECTOR_SHIFT) == i2->sector;
+}
+
+/* Advance caching pointers received_last and discard_last. Return next discard to be submitted. */
+static struct drbd_peer_request *drbd_advance_to_next_rs_discard(
+		struct drbd_peer_device *peer_device, unsigned int align, bool submit_all)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_peer_request *peer_req;
+	struct drbd_peer_request *discard_last = peer_device->discard_last;
+	bool discard_range_end = false;
+
+	/* Advance received_last. */
+	peer_req = list_prepare_entry(peer_device->received_last,
+			&peer_device->resync_requests, recv_order);
+	list_for_each_entry_continue(peer_req, &peer_device->resync_requests, recv_order) {
+		if (!test_bit(INTERVAL_RECEIVED, &peer_req->i.flags) && !submit_all)
+			break;
+
+		if (peer_req->flags & EE_TRIM)
+			break;
+
+		peer_device->received_last = peer_req;
+	}
+
+	/* Advance discard_last. */
+	peer_req = discard_last ? discard_last :
+		list_prepare_entry(peer_device->received_last,
+				&peer_device->resync_requests, recv_order);
+	list_for_each_entry_continue(peer_req, &peer_device->resync_requests, recv_order) {
+		/* Consider submitting previous discards. */
+		if (discard_last && !interval_is_adjacent(&discard_last->i, &peer_req->i)) {
+			discard_range_end = true;
+			break;
+		}
+
+		if (!(peer_req->flags & EE_TRIM)) {
+			discard_range_end =
+				test_bit(INTERVAL_RECEIVED, &peer_req->i.flags) || submit_all;
+			break;
+		}
+
+		discard_last = peer_req;
+
+		if (IS_ALIGNED(peer_req->i.sector + (peer_req->i.size >> SECTOR_SHIFT), align)) {
+			discard_range_end = true;
+			break;
+		}
+	}
+
+	/*
+	 * If we haven't found a discard range, or that range is not
+	 * finished, then there is nothing to submit.
+	 */
+	if (!discard_last || !(discard_range_end || discard_last->flags & EE_LAST_RESYNC_REQUEST)) {
+		peer_device->discard_last = discard_last;
+		return NULL;
+	}
+
+	/* Find start of discard range. */
+	peer_req = list_next_entry(list_prepare_entry(peer_device->received_last,
+				&peer_device->resync_requests, recv_order), recv_order);
+
+	spin_lock(&device->interval_lock); /* irqs already disabled */
+	if (peer_req != discard_last) {
+		struct drbd_peer_request *peer_req_merged = peer_req;
+
+		list_for_each_entry_continue(peer_req_merged,
+				&peer_device->resync_requests, recv_order) {
+			drbd_remove_interval(&device->requests, &peer_req_merged->i);
+			drbd_clear_interval(&peer_req_merged->i);
+			peer_req_merged->w.cb = e_end_resync_block;
+			if (peer_req_merged == discard_last)
+				break;
+		}
+	}
+	drbd_update_interval_size(&peer_req->i,
+			discard_last->i.size +
+			((discard_last->i.sector - peer_req->i.sector) << SECTOR_SHIFT));
+	spin_unlock(&device->interval_lock);
+
+	peer_device->received_last = discard_last;
+	peer_device->discard_last = NULL;
+
+	return peer_req;
+}
+
+static void drbd_submit_rs_discard(struct drbd_peer_request *peer_req)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+
+	if (get_ldev(device)) {
+		list_del(&peer_req->w.list);
+
+		peer_req->w.cb = e_end_resync_block;
+		peer_req->bios.head->bi_opf = REQ_OP_DISCARD;
+
+		atomic_inc(&connection->backing_ee_cnt);
+		drbd_conflict_submit_resync_request(peer_req);
+
+		/* No put_ldev() here. Gets called in drbd_endio_write_sec_final(). */
+	} else {
+		LIST_HEAD(free_list);
+		struct drbd_peer_request *t;
+
+		if (drbd_ratelimit())
+			drbd_err(device, "Cannot discard on local disk.\n");
+
+		drbd_send_ack(peer_device, P_RS_NEG_ACK, peer_req);
+
+		drbd_remove_peer_req_interval(peer_req);
+		list_move_tail(&peer_req->w.list, &free_list);
+
+		spin_lock_irq(&connection->peer_reqs_lock);
+		drbd_unmerge_discard(peer_req, &free_list);
+		spin_unlock_irq(&connection->peer_reqs_lock);
+
+		list_for_each_entry_safe(peer_req, t, &free_list, w.list)
+			drbd_free_peer_req(peer_req);
+	}
+}
+
+/* Find and submit discards in resync_requests which are ready. */
+void drbd_process_rs_discards(struct drbd_peer_device *peer_device, bool submit_all)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	struct drbd_peer_request *peer_req;
+	struct drbd_peer_request *pr_tmp;
+	unsigned int align = DRBD_MAX_RS_DISCARD_SIZE;
+	LIST_HEAD(work_list);
+
+	if (get_ldev(device)) {
+		/*
+		 * Limit the size of the merged requests. We want to allow the size to
+		 * increase up to the backing discard granularity.  If that is smaller
+		 * than DRBD_MAX_RS_DISCARD_SIZE, then allow merging up to a size of
+		 * DRBD_MAX_RS_DISCARD_SIZE.
+		 */
+		align = max(DRBD_MAX_RS_DISCARD_SIZE, bdev_discard_granularity(
+					device->ldev->backing_bdev)) >> SECTOR_SHIFT;
+		put_ldev(device);
+	}
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	while (true) {
+		peer_req = drbd_advance_to_next_rs_discard(peer_device, align, submit_all);
+		if (!peer_req)
+			break;
+
+		list_add_tail(&peer_req->w.list, &work_list);
+	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	list_for_each_entry_safe(peer_req, pr_tmp, &work_list, w.list)
+		drbd_submit_rs_discard(peer_req); /* removes it from the work_list */
+}
+
+static int receive_rs_deallocated(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct drbd_peer_request *peer_req;
+	sector_t sector;
+	int size, err = 0;
+	u64 block_id;
+	u64 im;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
+
+	if (pi->cmd == P_RS_DEALLOCATED) {
+		struct p_block_desc *p = pi->data;
+
+		sector = be64_to_cpu(p->sector);
+		size = be32_to_cpu(p->blksize);
+		block_id = ID_SYNCER;
+	} else { /* P_RS_DEALLOCATED_ID */
+		struct p_block_ack *p = pi->data;
+
+		sector = be64_to_cpu(p->sector);
+		size = be32_to_cpu(p->blksize);
+		block_id = p->block_id;
+	}
+
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_WRITE),
+			sector, size, block_id);
+	if (!peer_req)
+		return -EIO;
+
+	dec_rs_pending(peer_device);
+	inc_unacked(peer_device);
+	peer_req->flags |= EE_TRIM;
+
+	/* Setting all peers out of sync here. The sync source peer will be
+	 * set in sync when the discard completes. The sync source will soon
+	 * set other peers in sync with a P_PEERS_IN_SYNC packet.
+	 */
+	drbd_set_all_out_of_sync(device, peer_device->node_id, sector, size);
+	drbd_process_rs_discards(peer_device, false);
+	rs_sectors_came_in(peer_device, size);
+
+	for_each_peer_device_ref(peer_device, im, device) {
+		enum drbd_repl_state repl_state = peer_device->repl_state[NOW];
+
+		if (repl_is_sync_source(repl_state) || repl_state == L_WF_BITMAP_S)
+			drbd_send_out_of_sync(peer_device, sector, size);
+	}
+
+	return err;
+}
+
+void drbd_last_resync_request(struct drbd_peer_device *peer_device, bool submit_all)
+{
+	struct drbd_connection *connection = peer_device->connection;
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	if (!list_empty(&peer_device->resync_requests)) {
+		struct drbd_peer_request *peer_req = list_last_entry(&peer_device->resync_requests,
+				struct drbd_peer_request, recv_order);
+		peer_req->flags |= EE_LAST_RESYNC_REQUEST;
+	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	drbd_process_rs_discards(peer_device, submit_all);
+}
+
+static int receive_disconnect(struct drbd_connection *connection, struct packet_info *pi)
+{
+	change_cstate_tag(connection, C_DISCONNECTING, CS_HARD, "receive-disconnect", NULL);
+	return 0;
+}
+
+struct data_cmd {
+	int expect_payload;
+	unsigned int pkt_size;
+	int (*fn)(struct drbd_connection *, struct packet_info *);
+};
+
+static struct data_cmd drbd_cmd_handler[] = {
+	[P_DATA]	    = { 1, sizeof(struct p_data), receive_Data },
+	[P_DATA_REPLY]	    = { 1, sizeof(struct p_data), receive_DataReply },
+	[P_RS_DATA_REPLY]   = { 1, sizeof(struct p_data), receive_RSDataReply },
+	[P_BARRIER]	    = { 0, sizeof(struct p_barrier), receive_Barrier },
+	[P_BITMAP]	    = { 1, 0, receive_bitmap },
+	[P_COMPRESSED_BITMAP] = { 1, 0, receive_bitmap },
+	[P_UNPLUG_REMOTE]   = { 0, 0, receive_UnplugRemote },
+	[P_DATA_REQUEST]    = { 0, sizeof(struct p_block_req), receive_data_request },
+	[P_RS_DATA_REQUEST] = { 0, sizeof(struct p_block_req), receive_data_request },
+	[P_SYNC_PARAM]	    = { 1, 0, receive_SyncParam },
+	[P_SYNC_PARAM89]    = { 1, 0, receive_SyncParam },
+	[P_PROTOCOL]        = { 1, sizeof(struct p_protocol), receive_protocol },
+	[P_UUIDS]	    = { 0, sizeof(struct p_uuids), receive_uuids },
+	[P_SIZES]	    = { 0, sizeof(struct p_sizes), receive_sizes },
+	[P_STATE]	    = { 0, sizeof(struct p_state), receive_state },
+	[P_STATE_CHG_REQ]   = { 0, sizeof(struct p_req_state), receive_req_state },
+	[P_SYNC_UUID]       = { 0, sizeof(struct p_uuid), receive_sync_uuid },
+	[P_OV_REQUEST]      = { 0, sizeof(struct p_block_req), receive_data_request },
+	[P_OV_REPLY]        = { 1, sizeof(struct p_block_req), receive_ov_reply },
+	[P_CSUM_RS_REQUEST] = { 1, sizeof(struct p_block_req), receive_data_request },
+	[P_RS_THIN_REQ]     = { 0, sizeof(struct p_block_req), receive_data_request },
+	[P_DELAY_PROBE]     = { 0, sizeof(struct p_delay_probe93), receive_skip },
+	[P_OUT_OF_SYNC]     = { 0, sizeof(struct p_block_desc), receive_out_of_sync },
+	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_state },
+	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
+	[P_TWOPC_PREPARE] = { 0, sizeof(struct p_twopc_request), receive_twopc },
+	[P_TWOPC_PREP_RSZ]  = { 0, sizeof(struct p_twopc_request), receive_twopc },
+	[P_TWOPC_ABORT] = { 0, sizeof(struct p_twopc_request), receive_twopc },
+	[P_DAGTAG]	    = { 0, sizeof(struct p_dagtag), receive_dagtag },
+	[P_UUIDS110]	    = { 1, sizeof(struct p_uuids110), receive_uuids110 },
+	[P_PEER_DAGTAG]     = { 0, sizeof(struct p_peer_dagtag), receive_peer_dagtag },
+	[P_CURRENT_UUID]    = { 0, sizeof(struct p_current_uuid), receive_current_uuid },
+	[P_TWOPC_COMMIT]    = { 0, sizeof(struct p_twopc_request), receive_twopc },
+	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_ZEROES]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_RS_DEALLOCATED]  = { 0, sizeof(struct p_block_desc), receive_rs_deallocated },
+	[P_RS_DEALLOCATED_ID] = { 0, sizeof(struct p_block_ack), receive_rs_deallocated },
+	[P_DISCONNECT]      = { 0, 0, receive_disconnect },
+	[P_RS_DAGTAG_REQ]   = { 0, sizeof(struct p_rs_req), receive_dagtag_data_request },
+	[P_RS_CSUM_DAGTAG_REQ]   = { 1, sizeof(struct p_rs_req), receive_dagtag_data_request },
+	[P_RS_THIN_DAGTAG_REQ]   = { 0, sizeof(struct p_rs_req), receive_dagtag_data_request },
+	[P_OV_DAGTAG_REQ]   = { 0, sizeof(struct p_rs_req), receive_dagtag_data_request },
+	[P_OV_DAGTAG_REPLY]   = { 1, sizeof(struct p_rs_req), receive_dagtag_ov_reply },
+	[P_FLUSH_REQUESTS]  = { 0, sizeof(struct p_flush_requests), receive_flush_requests },
+	[P_FLUSH_REQUESTS_ACK] = { 0, sizeof(struct p_flush_ack), receive_flush_requests_ack },
+	[P_ENABLE_REPLICATION_NEXT] = { 0, sizeof(struct p_enable_replication),
+		receive_enable_replication_next },
+	[P_ENABLE_REPLICATION] = { 0, sizeof(struct p_enable_replication),
+		receive_enable_replication },
+	[P_RS_DAGTAG_WAIT_REQ] = { 0, sizeof(struct p_rs_req), receive_rs_dagtag_wait_req },
+};
+
+static void drbdd(struct drbd_connection *connection)
+{
+	struct packet_info pi;
+	size_t shs; /* sub header size */
+	int err;
+
+	while (get_t_state(&connection->receiver) == RUNNING) {
+		struct data_cmd const *cmd;
+
+		drbd_thread_current_set_cpu(&connection->receiver);
+		update_receiver_timing_details(connection, drbd_recv_header_maybe_unplug);
+		if (drbd_recv_header_maybe_unplug(connection, &pi))
+			goto err_out;
+
+		cmd = &drbd_cmd_handler[pi.cmd];
+		if (unlikely(pi.cmd >= ARRAY_SIZE(drbd_cmd_handler) || !cmd->fn)) {
+			drbd_err(connection, "Unexpected data packet %s (0x%04x)",
+				 drbd_packet_name(pi.cmd), pi.cmd);
+			goto err_out;
+		}
+
+		shs = cmd->pkt_size;
+		if (pi.cmd == P_SIZES && connection->agreed_features & DRBD_FF_WSAME)
+			shs += sizeof(struct o_qlim);
+		if (pi.size > shs && !cmd->expect_payload) {
+			drbd_err(connection, "No payload expected %s l:%d\n",
+				 drbd_packet_name(pi.cmd), pi.size);
+			goto err_out;
+		}
+		if (pi.size < shs) {
+			drbd_err(connection, "%s: unexpected packet size, expected:%d received:%d\n",
+				 drbd_packet_name(pi.cmd), (int)shs, pi.size);
+			goto err_out;
+		}
+
+		if (shs) {
+			update_receiver_timing_details(connection, drbd_recv_all_warn);
+			err = drbd_recv_all_warn(connection, &pi.data, shs);
+			if (err)
+				goto err_out;
+			pi.size -= shs;
+		}
+
+		update_receiver_timing_details(connection, cmd->fn);
+		err = cmd->fn(connection, &pi);
+		if (err) {
+			drbd_err(connection, "error receiving %s, e: %d l: %d!\n",
+				 drbd_packet_name(pi.cmd), err, pi.size);
+			goto err_out;
+		}
+	}
+	return;
+
+err_out:
+	change_cstate(connection, C_PROTOCOL_ERROR, CS_HARD);
+}
+
+static void drbd_cancel_conflicting_resync_requests(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
+	struct rb_node *node;
+	bool any_queued = false;
+
+	spin_lock_irq(&device->interval_lock);
+	for (node = rb_first(&device->requests); node; node = rb_next(node)) {
+		struct drbd_interval *i = rb_entry(node, struct drbd_interval, rb);
+		struct drbd_peer_request *peer_req;
+
+		if (!drbd_interval_is_resync(i))
+			continue;
+
+		peer_req = container_of(i, struct drbd_peer_request, i);
+
+		if (peer_req->peer_device != peer_device)
+			continue;
+
+		/* Only cancel requests which are waiting for conflicts to resolve. */
+		if (test_bit(INTERVAL_SUBMITTED, &i->flags) ||
+				(test_bit(INTERVAL_READY_TO_SEND, &i->flags) &&
+				 !test_bit(INTERVAL_RECEIVED, &i->flags)) ||
+				test_bit(INTERVAL_CANCELED, &i->flags))
+			continue;
+
+		set_bit(INTERVAL_CANCELED, &i->flags);
+
+		dynamic_drbd_dbg(device,
+				"Cancel %s %s request at %llus+%u (sent=%d)\n",
+				test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags) ?
+					"already queued" : "unqueued",
+				drbd_interval_type_str(i),
+				(unsigned long long) i->sector, i->size,
+				test_bit(INTERVAL_READY_TO_SEND, &i->flags));
+
+		/* Parked at the depth bound, it would wait for a completion. */
+		if (test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags)) {
+			/* No longer outstanding, before a new resync resets the count. */
+			if (peer_req->flags & EE_RS_DEPTH_PARKED) {
+				peer_req->flags &= ~EE_RS_DEPTH_PARKED;
+				atomic_sub(i->size >> 9, &peer_device->rs_sect_parked);
+			}
+			any_queued = true;
+			continue;
+		}
+
+		set_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags);
+
+		spin_lock(&submit_conflict->lock);
+		switch (i->type) {
+		case INTERVAL_RESYNC_WRITE:
+			list_add_tail(&peer_req->w.list, &submit_conflict->resync_writes);
+			break;
+		case INTERVAL_RESYNC_READ:
+			list_add_tail(&peer_req->w.list, &submit_conflict->resync_reads);
+			break;
+		default:
+			drbd_err(peer_device, "Unexpected interval type in %s\n", __func__);
+		}
+		spin_unlock(&submit_conflict->lock);
+
+		any_queued = true;
+	}
+	spin_unlock_irq(&device->interval_lock);
+
+	if (any_queued)
+		queue_work(submit_conflict->wq, &submit_conflict->worker);
+}
+
+/* Peer writes that are held waiting for a conflicting interval to resolve keep
+ * active_ee_cnt above zero. If the conflict cannot resolve, conn_disconnect()
+ * would wait for active_ee_cnt forever. Cancelling such writes is okay, since
+ * they could have been lost in flight as well.
+ */
+static void cancel_conflicting_peer_writes(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct conflict_worker *submit_conflict = &device->submit_conflict;
+	struct rb_node *node;
+	bool any_queued = false;
+
+	spin_lock_irq(&device->interval_lock);
+	for (node = rb_first(&device->requests); node; node = rb_next(node)) {
+		struct drbd_interval *i = rb_entry(node, struct drbd_interval, rb);
+		struct drbd_peer_request *peer_req;
+
+		if (i->type != INTERVAL_PEER_WRITE)
+			continue;
+
+		peer_req = container_of(i, struct drbd_peer_request, i);
+
+		if (peer_req->peer_device != peer_device)
+			continue;
+
+		if (test_bit(INTERVAL_SUBMITTED, &i->flags) ||
+				test_bit(INTERVAL_CANCELED, &i->flags))
+			continue;
+
+		set_bit(INTERVAL_CANCELED, &i->flags);
+
+		if (test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags))
+			continue;
+
+		set_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags);
+
+		spin_lock(&submit_conflict->lock);
+		list_add_tail(&peer_req->w.list, &submit_conflict->peer_writes);
+		spin_unlock(&submit_conflict->lock);
+
+		any_queued = true;
+	}
+	spin_unlock_irq(&device->interval_lock);
+
+	if (any_queued)
+		queue_work(submit_conflict->wq, &submit_conflict->worker);
+}
+
+static void cancel_dagtag_dependent_requests(struct drbd_resource *resource, unsigned int node_id)
+{
+	struct drbd_connection *connection;
+	LIST_HEAD(work_list);
+	struct drbd_peer_request *peer_req, *t;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		list_for_each_entry_safe(peer_req, t, &connection->dagtag_wait_ee, w.list) {
+			if (peer_req->depend_dagtag_node_id != node_id)
+				continue;
+
+			dynamic_drbd_dbg(peer_req->peer_device, "%s at %llus+%u: Wait for dagtag %llus from peer %u cancelled\n",
+					drbd_interval_type_str(&peer_req->i),
+					(unsigned long long) peer_req->i.sector, peer_req->i.size,
+					(unsigned long long) peer_req->depend_dagtag,
+					node_id);
+
+			list_move_tail(&peer_req->w.list, &work_list);
+		}
+		spin_unlock_irq(&connection->peer_reqs_lock);
+	}
+	rcu_read_unlock();
+
+	list_for_each_entry_safe(peer_req, t, &work_list, w.list) {
+		struct drbd_peer_device *peer_device = peer_req->peer_device;
+
+		drbd_peer_resync_read_cancel(peer_req);
+		/* Verify requests on the source side are placed in the
+		 * interval tree when the request is made; they need to be
+		 * removed if the reply was parked waiting for a dagtag.
+		 * Mirrors free_dagtag_wait_requests().
+		 */
+		if (peer_req->i.type == INTERVAL_OV_READ_SOURCE)
+			drbd_remove_peer_req_interval(peer_req);
+		drbd_free_peer_req(peer_req);
+		dec_unacked(peer_device);
+		put_ldev(peer_device->device);
+	}
+}
+
+static void cleanup_resync_leftovers(struct drbd_peer_device *peer_device)
+{
+	peer_device->rs_total = 0;
+	peer_device->rs_failed = 0;
+	D_ASSERT(peer_device, atomic_read(&peer_device->rs_pending_cnt) == 0);
+
+	timer_delete_sync(&peer_device->resync_timer);
+	resync_timer_fn(&peer_device->resync_timer);
+	timer_delete_sync(&peer_device->start_resync_timer);
+}
+
+static void free_waiting_resync_requests(struct drbd_connection *connection)
+{
+	LIST_HEAD(free_list);
+	struct drbd_peer_device *peer_device;
+	struct drbd_peer_request *peer_req, *t;
+	int vnr;
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		list_for_each_entry_safe(peer_req, t, &peer_device->resync_requests, recv_order) {
+			drbd_list_del_resync_request(peer_req);
+			list_add_tail(&peer_req->w.list, &free_list);
+		}
+	}
+	rcu_read_unlock();
+
+	list_for_each_entry_safe(peer_req, t, &connection->peer_reads, recv_order) {
+		if (peer_req->i.type == INTERVAL_PEER_READ)
+			continue;
+
+		peer_req->flags &= ~EE_ON_RECV_ORDER;
+		list_del(&peer_req->recv_order);
+
+		list_add_tail(&peer_req->w.list, &free_list);
+	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	list_for_each_entry_safe(peer_req, t, &free_list, w.list) {
+		/*
+		 * Resync write requests waiting for peers-in-sync to be sent
+		 * just need to be freed.
+		 */
+		if (test_bit(INTERVAL_COMPLETED, &peer_req->i.flags)) {
+			drbd_free_peer_req(peer_req);
+			continue;
+		}
+
+		D_ASSERT(connection, test_bit(INTERVAL_READY_TO_SEND, &peer_req->i.flags));
+		D_ASSERT(connection, !test_bit(INTERVAL_RECEIVED, &peer_req->i.flags));
+		D_ASSERT(connection, !(peer_req->flags & EE_TRIM));
+
+		if (peer_req->i.type == INTERVAL_RESYNC_READ)
+			atomic_sub(peer_req->i.size >> 9, &connection->rs_in_flight);
+
+		dec_rs_pending(peer_req->peer_device);
+		drbd_remove_peer_req_interval(peer_req);
+		drbd_free_peer_req(peer_req);
+	}
+}
+
+static void free_dagtag_wait_requests(struct drbd_connection *connection)
+{
+	LIST_HEAD(dagtag_wait_work_list);
+	struct drbd_peer_request *peer_req, *t;
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_splice_init(&connection->dagtag_wait_ee, &dagtag_wait_work_list);
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	list_for_each_entry_safe(peer_req, t, &dagtag_wait_work_list, w.list) {
+		struct drbd_peer_device *peer_device = peer_req->peer_device;
+
+		/* Verify requests are placed in the interval tree when
+		 * the request is made, so they need to be removed if
+		 * the reply was waiting for a dagtag to be reached. */
+		if (peer_req->i.type == INTERVAL_OV_READ_SOURCE)
+			drbd_remove_peer_req_interval(peer_req);
+
+		drbd_free_peer_req(peer_req);
+		dec_unacked(peer_device);
+		put_ldev(peer_device->device);
+	}
+}
+
+/* Writes waiting for a sync source to have them as well. The connection to
+ * the writer is going down, so the acknowledgment they wait for has no
+ * receiver any more; end them as the cancelled writes they now are.
+ */
+static void free_source_wait_requests(struct drbd_connection *connection)
+{
+	LIST_HEAD(work_list);
+	struct drbd_peer_request *peer_req, *t;
+
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_splice_init(&connection->source_wait_ee, &work_list);
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	list_for_each_entry_safe(peer_req, t, &work_list, w.list) {
+		/* Even a cancelled write differs from the source's content;
+		 * record that, so a later resync reconciles it.
+		 */
+		drbd_mark_unsecured_write_out_of_sync(peer_req);
+		peer_req->flags &= ~(EE_WAIT_FOR_SOURCE | EE_SOURCE_REACHED |
+				     EE_SOURCE_UNREACHABLE);
+		e_end_block_tail(peer_req, 1);
+	}
+}
+
+static void drain_resync_activity(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
+
+	/*
+	 * In order to understand this function, refer to the flow diagrams in
+	 * the comments for make_resync_request(), make_ov_request() and
+	 * receive_dagtag_data_request().
+	 */
+
+	/* Refuse further dagtag waits on this stream before the walks below
+	 * empty the wait lists: from here on a waiter takes the not-reachable
+	 * branch instead of queueing behind a walk that already passed.
+	 */
+	set_bit(DAGTAG_STREAM_GONE, &connection->flags);
+
+	/*
+	 * We could receive data from a peer at any point. This might release a
+	 * request that is waiting for a dagtag. That would cause it to
+	 * progress to waiting for conflicts or the backing disk. So we need to
+	 * remove these requests before flushing the other stages.
+	 */
+	free_dagtag_wait_requests(connection);
+
+	/* Writes withheld from acknowledgment have lost their receiver. */
+	free_source_wait_requests(connection);
+
+	/* Wait for w_resync_timer/w_e_send_csum to finish, if running. */
+	drbd_flush_workqueue(&connection->sender_work);
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
+
+		kref_get(&device->kref);
+		rcu_read_unlock();
+
+		/* Cause remaining discards to be submitted. */
+		drbd_last_resync_request(peer_device, true);
+		/* Cause requests waiting due to conflicts to be canceled. */
+		drbd_cancel_conflicting_resync_requests(peer_device);
+
+		kref_put(&device->kref, drbd_destroy_device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	/* Drain conflicting and backing requests. */
+	wait_event(connection->ee_wait, atomic_read(&connection->backing_ee_cnt) == 0);
+
+	/* Wait for work queued when backing requests finished. */
+	drbd_flush_workqueue(&connection->sender_work);
+
+	/* Clear up and remove requests that have progressed to done_ee. */
+	drbd_finish_peer_reqs(connection);
+
+	/*
+	 * Requests that are waiting for a resync reply must be removed from
+	 * the interval tree and then freed.
+	 */
+	free_waiting_resync_requests(connection);
+
+	/* Requests that are waiting for a dagtag on this connection must be
+	 * cancelled, because the dependency will never be fulfilled. */
+	cancel_dagtag_dependent_requests(connection->resource, connection->peer_node_id);
+
+	/* The same for dagtag wait requests parked on this connection's stream. */
+	answer_dagtag_wait_reqs(connection, 0, true);
+
+	/* And drop the dagtag wait requests this connection's peer asked
+	 * elsewhere: their answers just lost their receiver.
+	 */
+	drop_dagtag_wait_reqs_of(connection);
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
+
+		kref_get(&device->kref);
+		rcu_read_unlock();
+
+		cleanup_resync_leftovers(peer_device);
+
+		kref_put(&device->kref, drbd_destroy_device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+}
+
+/* True if the transfer log holds a write that completed to the application
+ * with success, or is about to, and that the lost peer may lack.
+ *
+ * The loss gives up every request of this peer that is not RQ_NET_DONE, and
+ * drbd_req_destroy() then marks the block out of sync towards it.  Whether
+ * that records a divergence worth a generation depends on the completion:
+ *
+ * Completed with success.  Under protocol C, RQ_NET_OK is the peer's write
+ * ack, so the peer holds the data; without it the peer refused the write
+ * (P_NEG_ACK) and lacks it.  Under protocol A and B the ack preceded the
+ * peer's write, so the peer may lack it either way.
+ *
+ * Not completed yet.  Under protocol A the write counts as successful
+ * towards the peer since it was handed to the network, so it completes with
+ * success once the local write ends -- unless the io-error policy is in
+ * effect, which errors every completion.  Under protocol B and C the request
+ * still waits for the peer, and the loss itself decides its completion; that
+ * decision is the settle-round mint of peer_device_disconnected().
+ *
+ * Completed with an error.  Nothing is owed, whatever the local disk holds:
+ * the application was told the write failed, so either resync direction is a
+ * correct recovery, and a generation here would turn a takeover by the peers
+ * into a split brain.
+ */
+static bool peer_may_lack_completed_write(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_request *req;
+	bool found = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(req, &device->resource->transfer_log, tl_requests) {
+		unsigned long s = req->net_rq_state[peer_device->node_id];
+		unsigned long l = req->local_rq_state;
+
+		if (req->device != device)
+			continue;
+		if (!(l & RQ_WRITE))
+			continue;
+		if (!(s & RQ_NET_MASK) || s & RQ_NET_DONE)
+			continue;
+		if (req->master_bio) {
+			if (s & (RQ_EXP_RECEIVE_ACK | RQ_EXP_WRITE_ACK))
+				continue;
+			if (!(s & RQ_NET_OK) || device->cached_err_io)
+				continue;
+		} else {
+			if (!(l & RQ_COMPLETED_OK))
+				continue;
+			if ((s & (RQ_EXP_WRITE_ACK | RQ_NET_OK)) == (RQ_EXP_WRITE_ACK | RQ_NET_OK))
+				continue;
+		}
+		found = true;
+		break;
+	}
+	rcu_read_unlock();
+	return found;
+}
+
+static void peer_device_disconnected(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+
+	if (test_and_clear_bit(HOLDING_UUID_READ_LOCK, peer_device->flags))
+		up_read_non_owner(&device->uuid_sem);
+
+	/* A pending reconcile relabel is only valid for the connection it was
+	 * armed for; drop it so it cannot fire on a later connection.
+	 */
+	clear_bit(RECONCILE_INJECT_CUR_UUID, peer_device->flags);
+	clear_bit(SEND_RECONCILE_UUID, peer_device->flags);
+	/* If a handshake reconcile armed RECONCILIATION_RESYNC but no resync
+	 * followed, drop it so it cannot mislabel a later resync.
+	 */
+	clear_bit(RECONCILIATION_RESYNC, peer_device->flags);
+
+	peer_device_init_connect_state(peer_device);
+
+	/* No need to start additional resyncs after reconnection. */
+	peer_device->resync_again = 0;
+
+	if (!drbd_suspended(device)) {
+		struct drbd_resource *resource = device->resource;
+
+		/* Create the new UUID when finishing requests that did not
+		 * reach the lost peer -- but not while quorum is lost, where
+		 * those requests are about to be errored instead.
+		 * Entering MINTING is the consumption lock: it keeps
+		 * inc_ap_bio_cond() blocking new writes until the rotate ran,
+		 * without posting the work a second time.  Refused, a write
+		 * already claimed the obligation and the sender runs the same
+		 * evaluation.
+		 */
+		if (!list_empty(&resource->transfer_log) &&
+		    drbd_data_accessible(device, NOW) &&
+		    !test_bit(PRIMARY_LOST_QUORUM, &device->flags) &&
+		    drbd_gen_obligation_mint_start(device)) {
+			drbd_gen_obligation_mint_done(device,
+						      drbd_check_peers_new_current_uuid(device));
+			wake_up(&device->misc_wait);
+		}
+	}
+
+	/* A successful completion cannot be taken back, and a write this peer
+	 * never wrote is not resent to it, so the divergence is a fact as soon
+	 * as the loss is noticed.  The obligation materializes and its mint runs
+	 * here, with no quorum, data or suspension gate and no settle round:
+	 * the completion decision was taken by the protocol, at ack time.
+	 * While a mint of an earlier obligation runs, it only takes the
+	 * attribute; that executor's exit then keeps it armed and mandatory.
+	 * Test the state before walking the transfer log: without an obligation
+	 * to materialize there is nothing to find.
+	 */
+	if ((GEN_OBL_IN(drbd_gen_obligation_state(device)) &
+	     (GEN_OBL_MATERIALIZE_FROM | GEN_OBL_IN(GEN_OBL_MINTING))) &&
+	    peer_may_lack_completed_write(peer_device)) {
+		drbd_gen_obligation_materialize(device);
+		if (drbd_gen_obligation_mint_start(device)) {
+			drbd_gen_obligation_mint_done(device,
+						      drbd_uuid_new_current(device, false));
+			wake_up(&device->misc_wait);
+		}
+	}
+
+	drbd_md_sync(device);
+
+	if (get_ldev(device)) {
+		drbd_bitmap_io(device, &drbd_bm_write_copy_pages, "write from disconnected",
+				BM_LOCK_BULK | BM_LOCK_SINGLE_SLOT, peer_device);
+		put_ldev(device);
+	}
+}
+
+static bool initiator_can_commit_or_abort(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	bool remote = resource->twopc_reply.initiator_node_id != resource->res_opts.node_id;
+
+	if (remote) {
+		u64 parents = resource->twopc_parent_nodes & ~NODE_MASK(connection->peer_node_id);
+
+		if (!parents)
+			return false;
+		resource->twopc_parent_nodes = parents;
+		/* A lost prepared peer becomes a RETRY reply, and the initiator aborts. */
+		return true;
+	}
+
+	if (test_bit(TWOPC_PREPARED, &connection->flags) &&
+	    !(test_bit(TWOPC_YES, &connection->flags) ||
+	      test_bit(TWOPC_NO, &connection->flags) ||
+	      test_bit(TWOPC_RETRY, &connection->flags)))
+		return false;
+
+	return true;
+}
+
+static void cleanup_remote_state_change(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct twopc_reply *reply = &resource->twopc_reply;
+	struct twopc_request request;
+	bool remote = false;
+
+	write_lock_irq(&resource->state_rwlock);
+	if (resource->remote_state_change && !initiator_can_commit_or_abort(connection)) {
+		remote = reply->initiator_node_id != resource->res_opts.node_id;
+
+		if (remote)
+			request = (struct twopc_request) {
+				.nodes_to_reach = ~0,
+				.cmd = P_TWOPC_ABORT,
+				.tid = reply->tid,
+				.initiator_node_id = reply->initiator_node_id,
+				.target_node_id = reply->target_node_id,
+				.vnr = reply->vnr,
+			};
+
+		drbd_info(connection, "Aborting %s state change %u commit not possible\n",
+			  remote ? "remote" : "local", reply->tid);
+		if (remote) {
+			timer_delete(&resource->twopc_timer);
+			__clear_remote_state_change(resource);
+		} else {
+			enum alt_rv alt_rv = abort_local_transaction(connection, 0);
+
+			if (alt_rv != ALT_LOCKED)
+				return;
+		}
+	}
+	write_unlock_irq(&resource->state_rwlock);
+
+	/* for a local transaction, change_cluster_wide_state() sends the P_TWOPC_ABORTs */
+	if (remote)
+		nested_twopc_abort(resource, &request);
+}
+
+/* Before cleanup_unacked_peer_requests() marks the lost primary's writes */
+static void note_bitmaps_held_at_primary_loss(struct drbd_connection *lost_peer)
+{
+	struct drbd_resource *resource = lost_peer->resource;
+	struct drbd_connection *connection;
+	struct drbd_peer_device *peer_device;
+	int vnr;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection == lost_peer)
+			continue;
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			if (drbd_bm_total_weight(peer_device))
+				set_bit(BITMAP_HELD_AT_PRIMARY_LOSS, peer_device->flags);
+			else
+				clear_bit(BITMAP_HELD_AT_PRIMARY_LOSS, peer_device->flags);
+		}
+	}
+	rcu_read_unlock();
+}
+
+static void drbd_notify_peers_lost_primary(struct drbd_connection *lost_peer)
+{
+	struct drbd_resource *resource = lost_peer->resource;
+	struct drbd_connection *connection;
+	u64 im;
+
+	for_each_connection_ref(connection, im, resource) {
+		struct drbd_peer_device *peer_device;
+		bool send_dagtag = false;
+		int vnr;
+
+		if (connection == lost_peer)
+			continue;
+		if (connection->cstate[NOW] != C_CONNECTED)
+			continue;
+
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			struct drbd_device *device = peer_device->device;
+			u64 current_uuid = drbd_current_uuid(device);
+			u64 weak_nodes = drbd_weak_nodes_device(device);
+
+			if (device->disk_state[NOW] < D_INCONSISTENT ||
+			    peer_device->disk_state[NOW] < D_INCONSISTENT)
+				continue; /* Ignore if one side is diskless */
+
+			/* owe a reconcile to this peer; set before NOTIFY clears,
+			 * which receive_peer_dagtag waits for (gap-free handover)
+			 */
+			set_bit(RECONCILE_PENDING, peer_device->flags);
+
+			drbd_send_current_uuid(peer_device, current_uuid, weak_nodes);
+			send_dagtag = true;
+		}
+
+		if (send_dagtag)
+			drbd_send_peer_dagtag(connection, lost_peer);
+	}
+}
+
+/* Informed confirmation of an optimistically rotated data generation.
+ *
+ * Confirmed -- safe to complete the held writes (confirm-before-complete) --
+ * the first instant ALL of:
+ *
+ *     quorate                device->quorum[NOW] (only where completions
+ *                            are actually held: on-no-quorum=suspend-io)
+ *     AND every still-connected protocol-C D_UP_TO_DATE peer:
+ *         acked it           (CURRENT_UUID_UNCONFIRMED clear), OR
+ *         has been lost      (requirement discharged: we are "informed")
+ *
+ * ALL surviving sync-UpToDate peers, not a quorum-sized count: a count could
+ * release while a future-quorum member still lacks the generation.  Protocol
+ * A/B peers are excluded (that connection accepted losing in-flight writes).
+ * With io-error / quorum-off nothing is held, but we still clear once informed,
+ * to lift the bump deferral and the reconnect-handshake special-casing.
+ *
+ * Returns true (discharging the obligation) exactly when the generation just
+ * became confirmed; the caller then releases the held completions with a
+ * NEW_UUID_CONFIRMED transfer-log walk.  Re-evaluated on:
+ *
+ *     barrier ack     got_BarrierAck
+ *     state change    central hook in ___end_state_change, post-commit
+ *                     (gained quorum / sync peer UpToDate / lost a copy)
+ */
+bool drbd_maybe_release_rotated_gen(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+
+	if (drbd_gen_obligation_state(device) != GEN_OBL_UNCONFIRMED)
+		return false;
+	/* Pair with the smp_wmb() in drbd_uuid_new_current(): having observed the
+	 * gate, see the per-peer CURRENT_UUID_UNCONFIRMED marks the bump set before it.
+	 * Otherwise a racing ack could read a survivor's mark as still clear and
+	 * wrongly confirm a generation that peer never received.
+	 */
+	smp_rmb();
+	if (device->resource->res_opts.on_no_quorum == ONQ_SUSPEND_IO &&
+	    !device->quorum[NOW])
+		return false;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		struct drbd_connection *connection = peer_device->connection;
+		struct drbd_net_conf *nc;
+
+		if (peer_device->repl_state[NOW] < L_ESTABLISHED)
+			continue;	/* lost -> requirement discharged */
+		if (peer_device->disk_state[NOW] != D_UP_TO_DATE)
+			continue;	/* not a full copy of a generation */
+		nc = rcu_dereference(connection->transport.net_conf);
+		if (!nc || nc->wire_protocol != DRBD_PROT_C)
+			continue;	/* A/B: in-flight loss was accepted */
+		if (test_bit(CURRENT_UUID_UNCONFIRMED, peer_device->flags)) {
+			rcu_read_unlock();
+			return false;	/* a survivor still lacks it durably */
+		}
+	}
+	rcu_read_unlock();
+
+	/* The from-state check picks the single winner among concurrent
+	 * evaluations, the way the test_and_clear_bit of the gate did.
+	 */
+	if (!drbd_gen_obligation_transition(device, GEN_OBL_IN(GEN_OBL_UNCONFIRMED),
+					    GEN_OBL_DISCHARGED, 0, 0))
+		return false;
+	drbd_info(device, "rotated data generation confirmed durable in a quorate partition (gen %016llX)\n",
+		  device->exposed_data_uuid);
+	/* Both callers reach here outside the state change's own wake-ups. */
+	wake_up(&device->misc_wait);
+	return true;
+}
+
+/*
+ * A sync target waits for our answer to its flush round on behalf of each
+ * Primary, which that Primary can no longer send us. Give it now.
+ * Caller holds state_rwlock.
+ */
+void drbd_flush_ack_for_lost_peer(struct drbd_connection *lost_connection)
+{
+	struct drbd_resource *resource = lost_connection->resource;
+	struct drbd_connection *initiator_connection;
+	unsigned long irq_flags;
+
+	if (!flush_ack_on_behalf_allowed(lost_connection))
+		return;
+
+	rcu_read_lock();
+	for_each_connection_rcu(initiator_connection, resource) {
+		u64 flush_sequence;
+
+		if (initiator_connection == lost_connection)
+			continue;
+
+		spin_lock_irqsave(&initiator_connection->primary_flush_lock, irq_flags);
+		flush_sequence = initiator_connection->flush_sequence;
+		spin_unlock_irqrestore(&initiator_connection->primary_flush_lock, irq_flags);
+
+		if (flush_sequence) /* Active flushes use non-zero sequence numbers */
+			queue_flush_ack(initiator_connection, lost_connection->peer_node_id,
+					flush_sequence);
+	}
+	rcu_read_unlock();
+}
+
+static void conn_disconnect(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	enum drbd_conn_state oc;
+	unsigned long irq_flags;
+	bool reconsider = false;
+	bool kept_for_resend;
+	bool dry_run;
+	int vnr, i;
+
+	clear_bit(CONN_DRY_RUN, &connection->flags);
+	dry_run = test_and_clear_bit(CONN_DRY_RUN_LOCAL, &connection->flags);
+	clear_bit(CONN_CONGESTED, &connection->flags);
+	clear_bit(CONN_PRE_110, &connection->flags);
+
+	if (connection->cstate[NOW] == C_STANDALONE)
+		return;
+
+	/* We are about to start the cleanup after connection loss.
+	 * Make sure drbd_submit_bio knows about that.
+	 * Usually we should be in some network failure state already,
+	 * but just in case we are not, we fix it up here.
+	 */
+	change_cstate_tag(connection, C_NETWORK_FAILURE, CS_HARD, "disconnected", NULL);
+
+	del_connect_timer(connection);
+
+	/* ack_receiver does not clean up anything. it must not interfere, either */
+	if (connection->ack_sender) {
+		destroy_workqueue(connection->ack_sender);
+		connection->ack_sender = NULL;
+	}
+
+	/* restart sender thread,
+	 * potentially get it out of blocking network operations */
+	drbd_thread_stop(&connection->sender);
+	drbd_thread_start(&connection->sender);
+
+	mutex_lock(&resource->conf_update);
+	drbd_transport_shutdown(connection, CLOSE_CONNECTION);
+	connection->peer_verify_alg[0] = 0;
+	mutex_unlock(&resource->conf_update);
+
+	cleanup_remote_state_change(connection);
+
+	drain_resync_activity(connection);
+
+	connection->after_reconciliation.lost_node_id = -1;
+	connection->reconcile_handshake.lost_node_id = -1;
+	connection->reconcile_handshake.sent_lost_node = false;
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		cancel_conflicting_peer_writes(peer_device);
+	rcu_read_unlock();
+
+	/* Wait for current activity to cease.  This includes waiting for
+	 * peer_request queued to the submitter workqueue. */
+	wait_event(connection->ee_wait,
+		atomic_read(&connection->active_ee_cnt) == 0);
+
+	/* wait for all w_e_end_data_req, w_e_end_rsdata_req, w_send_barrier,
+	 * etc. which may still be on the worker queue to be "canceled" */
+	drbd_flush_workqueue(&connection->sender_work);
+
+	drbd_finish_peer_reqs(connection);
+
+	/* This second workqueue flush is necessary, since drbd_finish_peer_reqs()
+	   might have issued a work again. The one before drbd_finish_peer_reqs() is
+	   necessary to reclaim net_ee in drbd_finish_peer_reqs(). */
+	drbd_flush_workqueue(&connection->sender_work);
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
+
+		kref_get(&device->kref);
+		rcu_read_unlock();
+
+		peer_device_disconnected(peer_device);
+		if (get_ldev(device)) {
+			drbd_reconsider_queue_parameters(device, device->ldev);
+			put_ldev(device);
+		} else {
+			drbd_reconsider_queue_parameters(device, NULL);
+		}
+
+		kref_put(&device->kref, drbd_destroy_device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	/* Apply these changes after peer_device_disconnected() because that
+	 * may cause the loss of other connections to be detected, which can
+	 * change the suspended state. */
+	kept_for_resend = resource->cached_susp;
+	tl_walk(connection, &connection->req_not_net_done,
+			kept_for_resend ? CONNECTION_LOST_WHILE_SUSPENDED : CONNECTION_LOST);
+
+	/* Every request towards this peer is done now and has given its sectors
+	 * back, except those the walk kept for a resend: those stay counted.
+	 */
+	i = atomic_read(&connection->ap_in_flight);
+	if (kept_for_resend ? i < 0 : i != 0)
+		drbd_warn(connection, "ap_in_flight = %d, expected %s\n",
+			  i, kept_for_resend ? "the sectors kept for resend" : "0");
+
+	/* Losing this peer may complete the informed-confirmation picture for a
+	 * still-unconfirmed rotated generation (its durable-ack requirement is
+	 * discharged), or drop us below quorum.  That is handled centrally by the
+	 * release hook in ___end_state_change, post-commit of the disconnect state
+	 * change -- nothing to do here.
+	 */
+
+	i = drbd_free_peer_reqs(connection, &connection->done_ee);
+	if (i)
+		drbd_info(connection, "done_ee not empty, killed %u entries\n", i);
+	i = drbd_free_peer_reqs(connection, &connection->dagtag_wait_ee);
+	if (i)
+		drbd_info(connection, "dagtag_wait_ee not empty, killed %u entries\n", i);
+
+	if (test_bit(NOTIFY_PEERS_LOST_PRIMARY, &connection->flags))
+		note_bitmaps_held_at_primary_loss(connection);
+	cleanup_unacked_peer_requests(connection);
+	cleanup_peer_ack_list(connection);
+
+	i = atomic_read(&connection->pp_in_use);
+	if (i)
+		drbd_info(connection, "pp_in_use = %d, expected 0\n", i);
+	i = atomic_read(&connection->pp_in_use_by_net);
+	if (i)
+		drbd_info(connection, "pp_in_use_by_net = %d, expected 0\n", i);
+
+	if (!list_empty(&connection->current_epoch->list))
+		drbd_err(connection, "ASSERTION FAILED: connection->current_epoch->list not empty\n");
+	/* ok, no more ee's on the fly, it is safe to reset the epoch_size */
+	atomic_set(&connection->current_epoch->epoch_size, 0);
+	atomic_set(&connection->current_epoch->confirmed, 0);
+	connection->send.seen_any_write_yet = false;
+	connection->send.current_dagtag_sector =
+		resource->dagtag_sector - ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT) - 1;
+	connection->current_epoch->oldest_unconfirmed_peer_req = NULL;
+
+	/* Indicate that last_dagtag_sector may no longer be up-to-date. We
+	 * need to keep last_dagtag_sector because we may still need it to
+	 * resolve a reconciliation resync. However, we need to avoid issuing a
+	 * resync request dependent on that dagtag because the resync source
+	 * may not be aware of the dagtag, even though it has newer data. This
+	 * can occur if the peer has been re-started since the request with the
+	 * dagtag.
+	 * */
+	clear_bit(RECEIVED_DAGTAG, &connection->flags);
+
+	/* Release any threads waiting for a barrier to be acked. */
+	WRITE_ONCE(connection->last_acked_epoch_nr,
+		   READ_ONCE(connection->send.last_sent_epoch_nr));
+	wake_up(&resource->barrier_wait);
+
+	drbd_info(connection, "Connection closed\n");
+
+	if (resource->role[NOW] == R_PRIMARY &&
+	    connection->fencing_policy != FP_DONT_CARE &&
+	    conn_highest_pdsk(connection) >= D_UNKNOWN)
+		conn_try_outdate_peer_async(connection);
+
+	drbd_maybe_khelper(NULL, connection, "disconnected");
+
+	begin_state_change(resource, &irq_flags, CS_VERBOSE | CS_LOCAL_ONLY);
+	oc = connection->cstate[NOW];
+	if (oc >= C_UNCONNECTED && dry_run) {
+		/* The node that asked for the dry run stays down; its peer reconnects */
+		__change_cstate(connection, C_DISCONNECTING);
+		oc = C_DISCONNECTING;
+	} else if (oc >= C_UNCONNECTED) {
+		__change_cstate(connection, C_UNCONNECTED);
+		/* drbd_receiver() has to be restarted after it returns */
+		drbd_thread_restart_nowait(&connection->receiver);
+	}
+	end_state_change(resource, &irq_flags, "disconnected");
+
+	if (test_bit(NOTIFY_PEERS_LOST_PRIMARY, &connection->flags)) {
+		drbd_notify_peers_lost_primary(connection);
+		clear_bit(NOTIFY_PEERS_LOST_PRIMARY, &connection->flags);
+		reconsider = true;
+	}
+
+	/* a surviving peer we owe a reconcile to is itself leaving:
+	 * discharge it, else we stay pinned at Consistent forever
+	 */
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		if (test_and_clear_bit(RECONCILE_PENDING, peer_device->flags))
+			reconsider = true;
+
+	/* re-arm once nothing is owed (2-node case arms no RECONCILE_PENDING) */
+	if (reconsider)
+		drbd_reconcile_settled_try_up_to_date(resource);
+
+	if (oc == C_DISCONNECTING)
+		change_cstate_tag(connection, C_STANDALONE, CS_VERBOSE | CS_HARD | CS_LOCAL_ONLY,
+				"disconnected", NULL);
+
+	read_lock_irq(&resource->state_rwlock);
+	drbd_flush_ack_for_lost_peer(connection);
+	read_unlock_irq(&resource->state_rwlock);
+}
+
+/*
+ * We support PRO_VERSION_MIN to PRO_VERSION_MAX.
+ * But see also drbd_protocol_version_acceptable() and module parameter
+ * drbd_protocol_version_min.
+ * The protocol version we can agree on is stored in agreed_pro_version.
+ *
+ * feature flags and the reserved array should be enough room for future
+ * enhancements of the handshake protocol, and possible plugins...
+ * See also PRO_FEATURES.
+ *
+ */
+static int drbd_send_features(struct drbd_connection *connection)
+{
+	struct p_connection_features *p;
+
+	p = __conn_prepare_command(connection, sizeof(*p), DATA_STREAM);
+	if (!p)
+		return -EIO;
+	memset(p, 0, sizeof(*p));
+	p->protocol_min = cpu_to_be32(drbd_protocol_version_min);
+	p->protocol_max = cpu_to_be32(PRO_VERSION_MAX);
+	p->sender_node_id = cpu_to_be32(connection->resource->res_opts.node_id);
+	p->receiver_node_id = cpu_to_be32(connection->peer_node_id);
+	p->feature_flags = cpu_to_be32(PRO_FEATURES);
+	return __send_command(connection, -1, P_CONNECTION_FEATURES, DATA_STREAM);
+}
+
+/*
+ * return values:
+ *   1 yes, we have a valid connection
+ *   0 oops, did not work out, please try again
+ *  -1 peer talks different language,
+ *     no point in trying again, please go standalone.
+ */
+int drbd_do_features(struct drbd_connection *connection)
+{
+	/* ASSERT current == connection->receiver ... */
+	struct drbd_resource *resource = connection->resource;
+	struct p_connection_features *p;
+	const int expect = sizeof(struct p_connection_features);
+	struct packet_info pi;
+	int err;
+
+	err = drbd_send_features(connection);
+	if (err)
+		return 0;
+
+	err = drbd_recv_header(connection, &pi);
+	if (err) {
+		if (err == -EAGAIN)
+			drbd_err(connection, "timeout while waiting for feature packet\n");
+		return 0;
+	}
+
+	if (pi.cmd != P_CONNECTION_FEATURES) {
+		drbd_err(connection, "expected ConnectionFeatures packet, received: %s (0x%04x)\n",
+			 drbd_packet_name(pi.cmd), pi.cmd);
+		return -1;
+	}
+
+	if (pi.size != expect) {
+		drbd_err(connection, "expected ConnectionFeatures length: %u, received: %u\n",
+		     expect, pi.size);
+		return -1;
+	}
+
+	err = drbd_recv_all_warn(connection, (void **)&p, expect);
+	if (err)
+		return 0;
+
+	p->protocol_min = be32_to_cpu(p->protocol_min);
+	p->protocol_max = be32_to_cpu(p->protocol_max);
+	if (p->protocol_max == 0)
+		p->protocol_max = p->protocol_min;
+
+	if (PRO_VERSION_MAX < p->protocol_min ||
+	    drbd_protocol_version_min > p->protocol_max) {
+		drbd_err(connection, "incompatible DRBD dialects: "
+		    "I support %d-%d, peer supports %d-%d\n",
+		    drbd_protocol_version_min, PRO_VERSION_MAX,
+		    p->protocol_min, p->protocol_max);
+		return -1;
+	}
+	/* Older DRBD will always expect us to agree to their max,
+	 * if it falls within our [min, max] range.
+	 * But we have a gap in there that we do not support.
+	 */
+	if (p->protocol_max > PRO_VERSION_8_MAX &&
+	    p->protocol_max < PRO_VERSION_MIN) {
+		drbd_err(connection, "incompatible DRBD 9 dialects: I support %u-%u, peer supports %u-%u\n",
+		    PRO_VERSION_MIN, PRO_VERSION_MAX,
+		    p->protocol_min, p->protocol_max);
+		return -1;
+	}
+
+	connection->agreed_pro_version = min_t(int, PRO_VERSION_MAX, p->protocol_max);
+	connection->agreed_features = PRO_FEATURES & be32_to_cpu(p->feature_flags);
+
+	if (connection->agreed_pro_version == 121 &&
+			(connection->agreed_features & DRBD_FF_RESYNC_DAGTAG)) {
+		/*
+		 * Releases drbd-9.2.0, drbd-9.2.1 and drbd-9.2.2 used an
+		 * implementation of discard merging which caused one
+		 * P_RS_WRITE_ACK to be sent for the whole merged interval.
+		 * These are precisely the releases with PRO_VERSION_MAX == 121
+		 * and feature DRBD_FF_RESYNC_DAGTAG.
+		 *
+		 * We do no support this case, so reject the connection.
+		 */
+		drbd_err(connection, "incompatible DRBD 9 dialects: protocol 121 with feature RESYNC_DAGTAG; upgrade via DRBD 9.2.16\n");
+		return -1;
+	}
+
+	if (connection->agreed_pro_version < 110) {
+		struct drbd_connection *connection2;
+		bool multiple = false;
+
+		/* new-peer adds a connection under the write lock, and none beside CONN_PRE_110 */
+		read_lock_irq(&resource->state_rwlock);
+		for_each_connection(connection2, resource) {
+			if (connection == connection2)
+				continue;
+			multiple = true;
+		}
+		if (!multiple)
+			set_bit(CONN_PRE_110, &connection->flags);
+		read_unlock_irq(&resource->state_rwlock);
+
+		if (multiple) {
+			drbd_err(connection, "Peer supports protocols %d-%d, but "
+				 "multiple connections are only supported in protocol "
+				 "110 and above\n", p->protocol_min, p->protocol_max);
+			return -1;
+		}
+	}
+
+	if (connection->agreed_pro_version >= 110) {
+		if (be32_to_cpu(p->sender_node_id) != connection->peer_node_id) {
+			drbd_err(connection, "Peer presented a node_id of %d instead of %d\n",
+				 be32_to_cpu(p->sender_node_id), connection->peer_node_id);
+			return 0;
+		}
+		if (be32_to_cpu(p->receiver_node_id) != resource->res_opts.node_id) {
+			drbd_err(connection, "Peer expects me to have a node_id of %d instead of %d\n",
+				 be32_to_cpu(p->receiver_node_id), resource->res_opts.node_id);
+			return 0;
+		}
+	}
+
+	drbd_info(connection, "Handshake to peer %d successful: "
+			"Agreed network protocol version %d\n",
+			connection->peer_node_id,
+			connection->agreed_pro_version);
+
+	drbd_info(connection, "Feature flags enabled on protocol level: 0x%x%s%s%s%s%s%s\n",
+		  connection->agreed_features,
+		  connection->agreed_features & DRBD_FF_TRIM ? " TRIM" : "",
+		  connection->agreed_features & DRBD_FF_THIN_RESYNC ? " THIN_RESYNC" : "",
+		  connection->agreed_features & DRBD_FF_WSAME ? " WRITE_SAME" : "",
+		  connection->agreed_features & DRBD_FF_WZEROES ? " WRITE_ZEROES" : "",
+		  connection->agreed_features & DRBD_FF_RESYNC_DAGTAG ? " RESYNC_DAGTAG" : "",
+		  connection->agreed_features & DRBD_FF_WRITE_POSTPONE ? " WRITE_POSTPONE" :
+		  connection->agreed_features ? "" : " none");
+
+	return 1;
+}
+
+#if !defined(CONFIG_CRYPTO_HMAC) && !defined(CONFIG_CRYPTO_HMAC_MODULE)
+int drbd_do_auth(struct drbd_connection *connection)
+{
+	drbd_err(connection, "This kernel was build without CONFIG_CRYPTO_HMAC.\n");
+	drbd_err(connection, "You need to disable 'cram-hmac-alg' in drbd.conf.\n");
+	return -1;
+}
+#else
+#define CHALLENGE_LEN 64 /* must be multiple of 4 */
+
+/* Return value:
+	1 - auth succeeded,
+	0 - failed, try again (network error),
+	-1 - auth failed, don't try again.
+*/
+
+struct auth_challenge {
+	char d[CHALLENGE_LEN];
+	u32 i;
+} __packed;
+
+int drbd_do_auth(struct drbd_connection *connection)
+{
+	struct auth_challenge my_challenge, *peers_ch = NULL;
+	void *response;
+	char *right_response = NULL;
+	unsigned int key_len;
+	char secret[SHARED_SECRET_MAX]; /* 64 byte */
+	unsigned int resp_size;
+	struct shash_desc *desc;
+	struct packet_info pi;
+	struct drbd_net_conf *nc;
+	int err, rv, dig_size;
+	bool peer_is_drbd_9 = connection->agreed_pro_version >= 110;
+	void *packet_body;
+
+	rcu_read_lock();
+	nc = rcu_dereference(connection->transport.net_conf);
+	key_len = strlen(nc->shared_secret);
+	memcpy(secret, nc->shared_secret, key_len);
+	rcu_read_unlock();
+
+	desc = kmalloc(sizeof(struct shash_desc) +
+		       crypto_shash_descsize(connection->cram_hmac_tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		rv = -1;
+		goto fail;
+	}
+	desc->tfm = connection->cram_hmac_tfm;
+
+	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
+	if (rv) {
+		drbd_err(connection, "crypto_shash_setkey() failed with %d\n", rv);
+		rv = -1;
+		goto fail;
+	}
+
+	get_random_bytes(my_challenge.d, sizeof(my_challenge.d));
+
+	packet_body = __conn_prepare_command(connection, sizeof(my_challenge.d), DATA_STREAM);
+	if (!packet_body) {
+		rv = 0;
+		goto fail;
+	}
+	memcpy(packet_body, my_challenge.d, sizeof(my_challenge.d));
+
+	rv = !__send_command(connection, -1, P_AUTH_CHALLENGE, DATA_STREAM);
+	if (!rv)
+		goto fail;
+
+	err = drbd_recv_header(connection, &pi);
+	if (err) {
+		rv = 0;
+		goto fail;
+	}
+
+	if (pi.cmd != P_AUTH_CHALLENGE) {
+		drbd_err(connection, "expected AuthChallenge packet, received: %s (0x%04x)\n",
+			 drbd_packet_name(pi.cmd), pi.cmd);
+		rv = -1;
+		goto fail;
+	}
+
+	if (pi.size != sizeof(peers_ch->d)) {
+		drbd_err(connection, "unexpected AuthChallenge payload.\n");
+		rv = -1;
+		goto fail;
+	}
+
+	peers_ch = kmalloc_obj(*peers_ch, GFP_NOIO);
+	if (!peers_ch) {
+		rv = -1;
+		goto fail;
+	}
+
+	err = drbd_recv_into(connection, peers_ch->d, sizeof(peers_ch->d));
+	if (err) {
+		rv = 0;
+		goto fail;
+	}
+
+	if (!memcmp(my_challenge.d, peers_ch->d, sizeof(my_challenge.d))) {
+		drbd_err(connection, "Peer presented the same challenge!\n");
+		rv = -1;
+		goto fail;
+	}
+
+	resp_size = crypto_shash_digestsize(connection->cram_hmac_tfm);
+	response = __conn_prepare_command(connection, resp_size, DATA_STREAM);
+	if (!response) {
+		rv = 0;
+		goto fail;
+	}
+
+	dig_size = pi.size;
+	if (peer_is_drbd_9) {
+		peers_ch->i = cpu_to_be32(connection->resource->res_opts.node_id);
+		dig_size += sizeof(peers_ch->i);
+	}
+
+	rv = crypto_shash_digest(desc, peers_ch->d, dig_size, response);
+	if (rv) {
+		drbd_err(connection, "crypto_shash_digest() failed with %d\n", rv);
+		rv = -1;
+		goto fail;
+	}
+
+	rv = !__send_command(connection, -1, P_AUTH_RESPONSE, DATA_STREAM);
+	if (!rv)
+		goto fail;
+
+	err = drbd_recv_header(connection, &pi);
+	if (err) {
+		rv = 0;
+		goto fail;
+	}
+
+	if (pi.cmd != P_AUTH_RESPONSE) {
+		drbd_err(connection, "expected AuthResponse packet, received: %s (0x%04x)\n",
+			 drbd_packet_name(pi.cmd), pi.cmd);
+		rv = 0;
+		goto fail;
+	}
+
+	if (pi.size != resp_size) {
+		drbd_err(connection, "expected AuthResponse payload of %u bytes, received %u\n",
+				resp_size, pi.size);
+		rv = 0;
+		goto fail;
+	}
+
+	err = drbd_recv_all(connection, &response, resp_size);
+	if (err) {
+		rv = 0;
+		goto fail;
+	}
+
+	right_response = kmalloc(resp_size, GFP_NOIO);
+	if (!right_response) {
+		rv = -1;
+		goto fail;
+	}
+
+	dig_size = sizeof(my_challenge.d);
+	if (peer_is_drbd_9) {
+		my_challenge.i = cpu_to_be32(connection->peer_node_id);
+		dig_size += sizeof(my_challenge.i);
+	}
+
+	rv = crypto_shash_digest(desc, my_challenge.d, dig_size, right_response);
+	if (rv) {
+		drbd_err(connection, "crypto_shash_digest() failed with %d\n", rv);
+		rv = -1;
+		goto fail;
 	}
 
-	INFO_bm_xfer_stats(peer_device, "receive", &c);
+	rv = !memcmp(response, right_response, resp_size);
 
-	if (device->state.conn == C_WF_BITMAP_T) {
-		enum drbd_state_rv rv;
+	if (rv)
+		drbd_info(connection, "Peer authenticated using %d bytes HMAC\n",
+		     resp_size);
+	else
+		rv = -1;
 
-		err = drbd_send_bitmap(device, peer_device);
-		if (err)
-			goto out;
-		/* Omit CS_ORDERED with this state transition to avoid deadlocks. */
-		rv = _drbd_request_state(device, NS(conn, C_WF_SYNC_UUID), CS_VERBOSE);
-		D_ASSERT(device, rv == SS_SUCCESS);
-	} else if (device->state.conn != C_WF_BITMAP_S) {
-		/* admin may have requested C_DISCONNECTING,
-		 * other threads may have noticed network errors */
-		drbd_info(device, "unexpected cstate (%s) in receive_bitmap\n",
-		    drbd_conn_str(device->state.conn));
+ fail:
+	kfree(peers_ch);
+	kfree(right_response);
+	if (desc) {
+		shash_desc_zero(desc);
+		kfree(desc);
 	}
-	err = 0;
 
- out:
-	drbd_bm_unlock(device);
-	if (!err && device->state.conn == C_WF_BITMAP_S)
-		drbd_start_resync(device, C_SYNC_SOURCE);
-	return err;
+	return rv;
 }
+#endif
 
-static int receive_skip(struct drbd_connection *connection, struct packet_info *pi)
+int drbd_receiver(struct drbd_thread *thi)
 {
-	drbd_warn(connection, "skipping unknown optional packet type %d, l: %d!\n",
-		 pi->cmd, pi->size);
+	struct drbd_connection *connection = thi->connection;
+
+	if (conn_connect(connection)) {
+		blk_start_plug(&connection->receiver_plug);
+		drbdd(connection);
+		blk_finish_plug(&connection->receiver_plug);
+	}
 
-	return ignore_remaining_packet(connection, pi);
+	conn_disconnect(connection);
+	return 0;
 }
 
-static int receive_UnplugRemote(struct drbd_connection *connection, struct packet_info *pi)
+/* ********* acknowledge sender ******** */
+
+static void drbd_check_flush_dagtag_reached(struct drbd_connection *peer_ack_connection)
 {
-	/* Make sure we've acked all the TCP data associated
-	 * with the data requests being unplugged */
-	tcp_sock_set_quickack(connection->data.socket->sk, 2);
-	return 0;
+	struct drbd_resource *resource = peer_ack_connection->resource;
+	struct drbd_connection *flush_requests_connection;
+	u64 peer_ack_node_mask = NODE_MASK(peer_ack_connection->peer_node_id);
+	u64 last_peer_ack_dagtag_seen = peer_ack_connection->last_peer_ack_dagtag_seen;
+	u64 im;
+
+	for_each_connection_ref(flush_requests_connection, im, resource) {
+		u64 flush_sequence;
+		u64 *sent_mask;
+		u64 flush_requests_dagtag;
+
+		spin_lock_irq(&flush_requests_connection->primary_flush_lock);
+		flush_requests_dagtag = flush_requests_connection->flush_requests_dagtag;
+		flush_sequence = flush_requests_connection->flush_sequence;
+		sent_mask = &flush_requests_connection->flush_forward_sent_mask;
+
+		if (!flush_sequence || /* Active flushes use non-zero sequence numbers */
+				*sent_mask & peer_ack_node_mask ||
+				last_peer_ack_dagtag_seen < flush_requests_dagtag) {
+			spin_unlock_irq(&flush_requests_connection->primary_flush_lock);
+			continue;
+		}
+
+		*sent_mask |= peer_ack_node_mask;
+		spin_unlock_irq(&flush_requests_connection->primary_flush_lock);
+
+		if (peer_ack_connection == flush_requests_connection)
+			drbd_send_flush_requests_ack(peer_ack_connection,
+					flush_sequence,
+					resource->res_opts.node_id);
+		else
+			drbd_send_flush_forward(peer_ack_connection,
+					flush_sequence,
+					flush_requests_connection->peer_node_id);
+	}
 }
 
-static int receive_out_of_sync(struct drbd_connection *connection, struct packet_info *pi)
+static int process_peer_ack_list(struct drbd_connection *connection)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_block_desc *p = pi->data;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_ack *peer_ack, *tmp;
+	u64 node_id_mask;
+	int err = 0;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	node_id_mask = NODE_MASK(connection->peer_node_id);
+
+	spin_lock_irq(&resource->peer_ack_lock);
+	peer_ack = list_first_entry(&resource->peer_ack_list, struct drbd_peer_ack, list);
+	while (&peer_ack->list != &resource->peer_ack_list) {
+		u64 pending_mask = peer_ack->pending_mask;
+		u64 mask = peer_ack->mask;
+		u64 dagtag_sector = peer_ack->dagtag_sector;
+
+		tmp = list_next_entry(peer_ack, list);
+
+		if (!(peer_ack->queued_mask & node_id_mask)) {
+			peer_ack = tmp;
+			continue;
+		}
+
+		/*
+		 * After disconnecting, queue_peer_ack_send() sets
+		 * last_peer_ack_dagtag_seen directly. Do not jump back if we
+		 * process a peer ack with a lower dagtag here shortly after.
+		 */
+		connection->last_peer_ack_dagtag_seen =
+			max(connection->last_peer_ack_dagtag_seen, dagtag_sector);
+
+		peer_ack->queued_mask &= ~node_id_mask;
+		drbd_destroy_peer_ack_if_done(peer_ack);
+		peer_ack = tmp;
+
+		if (!(pending_mask & node_id_mask))
+			continue;
+		spin_unlock_irq(&resource->peer_ack_lock);
 
-	switch (device->state.conn) {
-	case C_WF_SYNC_UUID:
-	case C_WF_BITMAP_T:
-	case C_BEHIND:
+		err = drbd_send_peer_ack(connection, mask, dagtag_sector);
+
+		spin_lock_irq(&resource->peer_ack_lock);
+		if (err)
 			break;
-	default:
-		drbd_err(device, "ASSERT FAILED cstate = %s, expected: WFSyncUUID|WFBitMapT|Behind\n",
-				drbd_conn_str(device->state.conn));
 	}
+	spin_unlock_irq(&resource->peer_ack_lock);
 
-	drbd_set_out_of_sync(peer_device, be64_to_cpu(p->sector), be32_to_cpu(p->blksize));
+	if (!err && connection->agreed_pro_version >= 123)
+		drbd_check_flush_dagtag_reached(connection);
 
-	return 0;
+	return err;
 }
 
-static int receive_rs_deallocated(struct drbd_connection *connection, struct packet_info *pi)
+static int got_peers_in_sync(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
-	struct p_block_desc *p = pi->data;
 	struct drbd_device *device;
+	struct p_peer_block_desc *p = pi->data;
 	sector_t sector;
-	int size, err = 0;
+	u64 in_sync_b;
+	int size;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
-	device = peer_device->device;
-
-	sector = be64_to_cpu(p->sector);
-	size = be32_to_cpu(p->blksize);
 
-	dec_rs_pending(peer_device);
+	device = peer_device->device;
 
 	if (get_ldev(device)) {
-		struct drbd_peer_request *peer_req;
+		unsigned long modified;
 
-		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
-					       size, 0, GFP_NOIO);
-		if (!peer_req) {
-			put_ldev(device);
-			return -ENOMEM;
-		}
-
-		peer_req->i.type = INTERVAL_RESYNC_WRITE;
-		peer_req->w.cb = e_end_resync_block;
-		peer_req->opf = REQ_OP_DISCARD;
-		peer_req->submit_jif = jiffies;
-		peer_req->flags |= EE_TRIM;
+		sector = be64_to_cpu(p->sector);
+		size = be32_to_cpu(p->size);
+		in_sync_b = node_ids_to_bitmap(device, be64_to_cpu(p->mask));
 
-		spin_lock_irq(&device->resource->req_lock);
-		list_add_tail(&peer_req->w.list, &device->sync_ee);
-		spin_unlock_irq(&device->resource->req_lock);
+		modified = drbd_set_sync(device, sector, size, 0, in_sync_b);
 
-		atomic_add(pi->size >> 9, &device->rs_sect_ev);
-		err = drbd_submit_peer_request(peer_req);
+		/* If we are SyncSource then we rely on P_PEERS_IN_SYNC from
+		 * the peer to inform us of sync progress. Otherwise only send
+		 * peers-in-sync when we have actually cleared some bits.
+		 * This prevents an infinite loop with the peer. */
+		if (modified || peer_device->repl_state[NOW] == L_SYNC_SOURCE)
+			drbd_queue_update_peers(peer_device, sector, sector + (size >> SECTOR_SHIFT));
 
-		if (err) {
-			spin_lock_irq(&device->resource->req_lock);
-			list_del(&peer_req->w.list);
-			spin_unlock_irq(&device->resource->req_lock);
+		put_ldev(device);
+	}
 
-			drbd_free_peer_req(device, peer_req);
-			put_ldev(device);
-			err = 0;
-			goto fail;
-		}
+	return 0;
+}
 
-		inc_unacked(device);
+static int got_RqSReply(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_req_state_reply *p = pi->data;
+	int retcode = be32_to_cpu(p->retcode);
 
-		/* No put_ldev() here. Gets called in drbd_endio_write_sec_final(),
-		   as well as drbd_rs_complete_io() */
-	} else {
-	fail:
-		drbd_rs_complete_io(device, sector);
-		drbd_send_ack_ex(peer_device, P_NEG_ACK, sector, size, ID_SYNCER);
+	if (retcode >= SS_SUCCESS)
+		set_bit(TWOPC_YES, &connection->flags);
+	else {
+		set_bit(TWOPC_NO, &connection->flags);
+		dynamic_drbd_dbg(connection, "Requested state change failed by peer: %s (%d)\n",
+			   drbd_set_st_err_str(retcode), retcode);
 	}
 
-	atomic_add(size >> 9, &device->rs_sect_in);
+	wake_up_all(&connection->resource->state_wait);
 
-	return err;
+	return 0;
 }
 
-struct data_cmd {
-	int expect_payload;
-	unsigned int pkt_size;
-	int (*fn)(struct drbd_connection *, struct packet_info *);
-};
-
-static struct data_cmd drbd_cmd_handler[] = {
-	[P_DATA]	    = { 1, sizeof(struct p_data), receive_Data },
-	[P_DATA_REPLY]	    = { 1, sizeof(struct p_data), receive_DataReply },
-	[P_RS_DATA_REPLY]   = { 1, sizeof(struct p_data), receive_RSDataReply } ,
-	[P_BARRIER]	    = { 0, sizeof(struct p_barrier), receive_Barrier } ,
-	[P_BITMAP]	    = { 1, 0, receive_bitmap } ,
-	[P_COMPRESSED_BITMAP] = { 1, 0, receive_bitmap } ,
-	[P_UNPLUG_REMOTE]   = { 0, 0, receive_UnplugRemote },
-	[P_DATA_REQUEST]    = { 0, sizeof(struct p_block_req), receive_DataRequest },
-	[P_RS_DATA_REQUEST] = { 0, sizeof(struct p_block_req), receive_DataRequest },
-	[P_SYNC_PARAM]	    = { 1, 0, receive_SyncParam },
-	[P_SYNC_PARAM89]    = { 1, 0, receive_SyncParam },
-	[P_PROTOCOL]        = { 1, sizeof(struct p_protocol), receive_protocol },
-	[P_UUIDS]	    = { 0, sizeof(struct p_uuids), receive_uuids },
-	[P_SIZES]	    = { 0, sizeof(struct p_sizes), receive_sizes },
-	[P_STATE]	    = { 0, sizeof(struct p_state), receive_state },
-	[P_STATE_CHG_REQ]   = { 0, sizeof(struct p_req_state), receive_req_state },
-	[P_SYNC_UUID]       = { 0, sizeof(struct p_rs_uuid), receive_sync_uuid },
-	[P_OV_REQUEST]      = { 0, sizeof(struct p_block_req), receive_DataRequest },
-	[P_OV_REPLY]        = { 1, sizeof(struct p_block_req), receive_DataRequest },
-	[P_CSUM_RS_REQUEST] = { 1, sizeof(struct p_block_req), receive_DataRequest },
-	[P_RS_THIN_REQ]     = { 0, sizeof(struct p_block_req), receive_DataRequest },
-	[P_DELAY_PROBE]     = { 0, sizeof(struct p_delay_probe93), receive_skip },
-	[P_OUT_OF_SYNC]     = { 0, sizeof(struct p_block_desc), receive_out_of_sync },
-	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
-	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
-	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
-	[P_ZEROES]	    = { 0, sizeof(struct p_trim), receive_Data },
-	[P_RS_DEALLOCATED]  = { 0, sizeof(struct p_block_desc), receive_rs_deallocated },
-};
-
-static void drbdd(struct drbd_connection *connection)
-{
-	struct packet_info pi;
-	size_t shs; /* sub header size */
-	int err;
-
-	while (get_t_state(&connection->receiver) == RUNNING) {
-		struct data_cmd const *cmd;
+static int got_twopc_reply(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct p_twopc_reply *p = pi->data;
+
+	write_lock_irq(&resource->state_rwlock);
+	if (resource->twopc_reply.initiator_node_id == be32_to_cpu(p->initiator_node_id) &&
+	    resource->twopc_reply.tid == be32_to_cpu(p->tid)) {
+		dynamic_drbd_dbg(connection, "Got a %s reply for state change %u\n",
+			   drbd_packet_name(pi->cmd),
+			   resource->twopc_reply.tid);
+
+		if (pi->cmd == P_TWOPC_YES) {
+			struct drbd_peer_device *peer_device;
+			u64 reachable_nodes;
+			u64 max_size;
+
+			reachable_nodes = be64_to_cpu(p->reachable_nodes);
+
+			switch (resource->twopc.type) {
+			case TWOPC_STATE_CHANGE:
+				if (resource->res_opts.node_id ==
+				    resource->twopc_reply.initiator_node_id &&
+				    connection->peer_node_id ==
+				    resource->twopc_reply.target_node_id) {
+					resource->twopc_reply.target_reachable_nodes |=
+						reachable_nodes;
+				} else {
+					resource->twopc_reply.reachable_nodes |=
+						reachable_nodes;
+				}
+				resource->twopc_reply.primary_nodes |=
+					be64_to_cpu(p->primary_nodes);
+				resource->twopc_reply.weak_nodes |=
+					be64_to_cpu(p->weak_nodes);
+				break;
+			case TWOPC_RESIZE:
+				resource->twopc_reply.reachable_nodes |= reachable_nodes;
+				resource->twopc_reply.common_reachable_nodes &=
+					reachable_nodes;
+				resource->twopc_reply.diskful_primary_nodes |=
+					be64_to_cpu(p->diskful_primary_nodes);
+				max_size = be64_to_cpu(p->max_possible_size);
+				resource->twopc_reply.max_possible_size =
+					min_t(sector_t, resource->twopc_reply.max_possible_size,
+					      max_size);
+				peer_device = conn_peer_device(connection, resource->twopc_reply.vnr);
+				if (peer_device)
+					peer_device->max_size = max_size;
+				break;
+			}
+		}
 
-		drbd_thread_current_set_cpu(&connection->receiver);
-		update_receiver_timing_details(connection, drbd_recv_header_maybe_unplug);
-		if (drbd_recv_header_maybe_unplug(connection, &pi))
-			goto err_out;
+		if (pi->cmd == P_TWOPC_YES)
+			set_bit(TWOPC_YES, &connection->flags);
+		else if (pi->cmd == P_TWOPC_NO)
+			set_bit(TWOPC_NO, &connection->flags);
+		else if (pi->cmd == P_TWOPC_RETRY)
+			set_bit(TWOPC_RETRY, &connection->flags);
+		drbd_maybe_cluster_wide_reply(resource);
+	} else {
+		dynamic_drbd_dbg(connection, "Ignoring %s reply for state change %u\n",
+			   drbd_packet_name(pi->cmd),
+			   be32_to_cpu(p->tid));
+	}
+	write_unlock_irq(&resource->state_rwlock);
 
-		cmd = &drbd_cmd_handler[pi.cmd];
-		if (unlikely(pi.cmd >= ARRAY_SIZE(drbd_cmd_handler) || !cmd->fn)) {
-			drbd_err(connection, "Unexpected data packet %s (0x%04x)",
-				 drbd_packet_name(pi.cmd), pi.cmd);
-			goto err_out;
-		}
+	return 0;
+}
 
-		shs = cmd->pkt_size;
-		if (pi.cmd == P_SIZES && connection->agreed_features & DRBD_FF_WSAME)
-			shs += sizeof(struct o_qlim);
-		if (pi.size > shs && !cmd->expect_payload) {
-			drbd_err(connection, "No payload expected %s l:%d\n",
-				 drbd_packet_name(pi.cmd), pi.size);
-			goto err_out;
-		}
-		if (pi.size < shs) {
-			drbd_err(connection, "%s: unexpected packet size, expected:%d received:%d\n",
-				 drbd_packet_name(pi.cmd), (int)shs, pi.size);
-			goto err_out;
-		}
+static int got_Ping(struct drbd_connection *connection, struct packet_info *pi)
+{
+	drbd_queue_ping_ack(connection);
+	return 0;
+}
 
-		if (shs) {
-			update_receiver_timing_details(connection, drbd_recv_all_warn);
-			err = drbd_recv_all_warn(connection, pi.data, shs);
-			if (err)
-				goto err_out;
-			pi.size -= shs;
-		}
+static int got_PingAck(struct drbd_connection *connection, struct packet_info *pi)
+{
+	clear_bit(PING_TIMEOUT_ACTIVE, &connection->flags);
+	set_rcvtimeo(connection, REGULAR_TIMEOUT);
 
-		update_receiver_timing_details(connection, cmd->fn);
-		err = cmd->fn(connection, &pi);
-		if (err) {
-			drbd_err(connection, "error receiving %s, e: %d l: %d!\n",
-				 drbd_packet_name(pi.cmd), err, pi.size);
-			goto err_out;
-		}
+	if (test_bit(PING_PENDING, &connection->flags)) {
+		clear_bit(PING_PENDING, &connection->flags);
+		wake_up_all(&connection->resource->state_wait);
 	}
-	return;
 
-    err_out:
-	conn_request_state(connection, NS(conn, C_PROTOCOL_ERROR), CS_HARD);
+	return 0;
 }
 
-static void conn_disconnect(struct drbd_connection *connection)
+static int got_IsInSync(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
-	enum drbd_conns oc;
-	int vnr;
+	struct drbd_device *device;
+	struct drbd_peer_request *peer_req;
+	struct p_block_ack *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
+	int blksize = be32_to_cpu(p->blksize);
 
-	if (connection->cstate == C_STANDALONE)
-		return;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
 
-	/* We are about to start the cleanup after connection loss.
-	 * Make sure drbd_make_request knows about that.
-	 * Usually we should be in some network failure state already,
-	 * but just in case we are not, we fix it up here.
-	 */
-	conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
+	D_ASSERT(device, connection->agreed_pro_version >= 89);
 
-	/* ack_receiver does not clean up anything. it must not interfere, either */
-	drbd_thread_stop(&connection->ack_receiver);
-	if (connection->ack_sender) {
-		destroy_workqueue(connection->ack_sender);
-		connection->ack_sender = NULL;
-	}
-	drbd_free_sock(connection);
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		kref_get(&device->kref);
-		rcu_read_unlock();
-		drbd_disconnected(peer_device);
-		kref_put(&device->kref, drbd_destroy_device);
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
+	/* Do not rely on the block_id from older peers. */
+	if (connection->agreed_pro_version < 122)
+		p->block_id = ID_SYNCER;
 
-	if (!list_empty(&connection->current_epoch->list))
-		drbd_err(connection, "ASSERTION FAILED: connection->current_epoch->list not empty\n");
-	/* ok, no more ee's on the fly, it is safe to reset the epoch_size */
-	atomic_set(&connection->current_epoch->epoch_size, 0);
-	connection->send.seen_any_write_yet = false;
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_WRITE),
+			sector, blksize, p->block_id);
+	if (!peer_req)
+		return -EIO;
 
-	drbd_info(connection, "Connection closed\n");
+	dec_rs_pending(peer_device);
 
-	if (conn_highest_role(connection) == R_PRIMARY && conn_highest_pdsk(connection) >= D_UNKNOWN)
-		conn_try_outdate_peer_async(connection);
+	set_bit(INTERVAL_RECEIVED, &peer_req->i.flags);
 
-	spin_lock_irq(&connection->resource->req_lock);
-	oc = connection->cstate;
-	if (oc >= C_UNCONNECTED)
-		_conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_del(&peer_req->w.list);
+	spin_unlock_irq(&connection->peer_reqs_lock);
+
+	if (get_ldev(device)) {
+		drbd_set_in_sync(peer_device, sector, blksize);
+		/* rs_same_csums is supposed to count in units of BM_BLOCK_SIZE */
+		peer_device->rs_same_csum += (blksize >> device->ldev->md.bm_block_shift);
+		put_ldev(device);
+	}
+	rs_sectors_came_in(peer_device, blksize);
+
+	drbd_remove_peer_req_interval(peer_req);
+	drbd_resync_request_complete(peer_req);
+	return 0;
+}
+
+static int
+validate_req_change_req_state(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
+			      enum drbd_interval_type type, const char *func,
+			      enum drbd_req_event what, bool missing_ok)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_request *req;
 
-	spin_unlock_irq(&connection->resource->req_lock);
+	spin_lock_irq(&device->interval_lock);
+	req = find_request(device, type, id, sector, missing_ok, func);
+	spin_unlock_irq(&device->interval_lock);
+	if (unlikely(!req))
+		return -EIO;
+	req_mod(req, what, peer_device);
 
-	if (oc == C_DISCONNECTING)
-		conn_request_state(connection, NS(conn, C_STANDALONE), CS_VERBOSE | CS_HARD);
+	return 0;
 }
 
-static int drbd_disconnected(struct drbd_peer_device *peer_device)
+static int got_BlockAck(struct drbd_connection *connection, struct packet_info *pi)
 {
-	struct drbd_device *device = peer_device->device;
-	unsigned int i;
-
-	/* wait for current activity to cease. */
-	spin_lock_irq(&device->resource->req_lock);
-	_drbd_wait_ee_list_empty(device, &device->active_ee);
-	_drbd_wait_ee_list_empty(device, &device->sync_ee);
-	_drbd_wait_ee_list_empty(device, &device->read_ee);
-	spin_unlock_irq(&device->resource->req_lock);
-
-	/* We do not have data structures that would allow us to
-	 * get the rs_pending_cnt down to 0 again.
-	 *  * On C_SYNC_TARGET we do not have any data structures describing
-	 *    the pending RSDataRequest's we have sent.
-	 *  * On C_SYNC_SOURCE there is no data structure that tracks
-	 *    the P_RS_DATA_REPLY blocks that we sent to the SyncTarget.
-	 *  And no, it is not the sum of the reference counts in the
-	 *  resync_LRU. The resync_LRU tracks the whole operation including
-	 *  the disk-IO, while the rs_pending_cnt only tracks the blocks
-	 *  on the fly. */
-	drbd_rs_cancel_all(device);
-	device->rs_total = 0;
-	device->rs_failed = 0;
-	atomic_set(&device->rs_pending_cnt, 0);
-	wake_up(&device->misc_wait);
+	struct drbd_peer_device *peer_device;
+	struct p_block_ack *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
+	enum drbd_req_event what;
 
-	timer_delete_sync(&device->resync_timer);
-	resync_timer_fn(&device->resync_timer);
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	/* wait for all w_e_end_data_req, w_e_end_rsdata_req, w_send_barrier,
-	 * w_make_resync_request etc. which may still be on the worker queue
-	 * to be "canceled" */
-	drbd_flush_workqueue(&peer_device->connection->sender_work);
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	drbd_finish_peer_reqs(device);
+	switch (pi->cmd) {
+	case P_RS_WRITE_ACK: /* agreed_pro_version < 122 */
+	case P_WRITE_ACK_IN_SYNC:
+		what = WRITE_ACKED_BY_PEER_AND_SIS;
+		break;
+	case P_WRITE_ACK:
+		what = WRITE_ACKED_BY_PEER;
+		break;
+	case P_RECV_ACK:
+		what = RECV_ACKED_BY_PEER;
+		break;
+	default:
+		BUG();
+	}
 
-	/* This second workqueue flush is necessary, since drbd_finish_peer_reqs()
-	   might have issued a work again. The one before drbd_finish_peer_reqs() is
-	   necessary to reclain net_ee in drbd_finish_peer_reqs(). */
-	drbd_flush_workqueue(&peer_device->connection->sender_work);
+	return validate_req_change_req_state(peer_device, p->block_id, sector,
+					     INTERVAL_LOCAL_WRITE, __func__,
+					     what, false);
+}
 
-	/* need to do it again, drbd_finish_peer_reqs() may have populated it
-	 * again via drbd_try_clear_on_disk_bm(). */
-	drbd_rs_cancel_all(device);
+/* Process acks for resync writes. */
+static int got_RSWriteAck(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_block_ack *p = pi->data;
+	bool is_neg_ack = pi->cmd == P_NEG_ACK || pi->cmd == P_RS_NEG_ACK;
+	sector_t sector = be64_to_cpu(p->sector);
+	int size = be32_to_cpu(p->blksize);
+	struct drbd_peer_request *peer_req;
 
-	kfree(device->p_uuid);
-	device->p_uuid = NULL;
+	/* P_RS_WRITE_ACK used to be used instead of P_WRITE_ACK_IN_SYNC. */
+	if (connection->agreed_pro_version < 122 && p->block_id != ID_SYNCER)
+		return got_BlockAck(connection, pi);
 
-	if (!drbd_suspended(device))
-		tl_clear(peer_device->connection);
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	drbd_md_sync(device);
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	if (get_ldev(device)) {
-		drbd_bitmap_io(device, &drbd_bm_write_copy_pages,
-				"write from disconnected", BM_LOCKED_CHANGE_ALLOWED, NULL);
-		put_ldev(device);
-	}
+	if (is_neg_ack && peer_device->disk_state[NOW] == D_UP_TO_DATE)
+		set_bit(GOT_NEG_ACK, peer_device->flags);
 
-	i = atomic_read(&device->pp_in_use_by_net);
-	if (i)
-		drbd_info(device, "pp_in_use_by_net = %d, expected 0\n", i);
-	i = atomic_read(&device->pp_in_use);
-	if (i)
-		drbd_info(device, "pp_in_use = %d, expected 0\n", i);
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_READ),
+			sector, size, p->block_id);
+	if (!peer_req)
+		return -EIO;
 
-	D_ASSERT(device, list_empty(&device->read_ee));
-	D_ASSERT(device, list_empty(&device->active_ee));
-	D_ASSERT(device, list_empty(&device->sync_ee));
-	D_ASSERT(device, list_empty(&device->done_ee));
+	if (is_neg_ack)
+		drbd_rs_failed_io(peer_device, sector, size);
+	else
+		drbd_set_in_sync(peer_device, sector, size);
 
-	return 0;
-}
+	atomic_sub(size >> 9, &connection->rs_in_flight);
 
-/*
- * We support PRO_VERSION_MIN to PRO_VERSION_MAX. The protocol version
- * we can agree on is stored in agreed_pro_version.
- *
- * feature flags and the reserved array should be enough room for future
- * enhancements of the handshake protocol, and possible plugins...
- *
- * for now, they are expected to be zero, but ignored.
- */
-static int drbd_send_features(struct drbd_connection *connection)
-{
-	struct drbd_socket *sock;
-	struct p_connection_features *p;
+	dec_rs_pending(peer_device);
 
-	sock = &connection->data;
-	p = conn_prepare_command(connection, sock);
-	if (!p)
-		return -EIO;
-	memset(p, 0, sizeof(*p));
-	p->protocol_min = cpu_to_be32(PRO_VERSION_MIN);
-	p->protocol_max = cpu_to_be32(PRO_VERSION_MAX);
-	p->feature_flags = cpu_to_be32(PRO_FEATURES);
-	return conn_send_command(connection, sock, P_CONNECTION_FEATURES, sizeof(*p), NULL, 0);
+	/*
+	 * Remove from the interval tree now so that
+	 * find_resync_request() cannot find this request again
+	 * if we get another ack for this interval.
+	 */
+	drbd_remove_peer_req_interval(peer_req);
+
+	drbd_resync_read_req_mod(peer_req, INTERVAL_RECEIVED);
+	return 0;
 }
 
-/*
- * return values:
- *   1 yes, we have a valid connection
- *   0 oops, did not work out, please try again
- *  -1 peer talks different language,
- *     no point in trying again, please go standalone.
- */
-static int drbd_do_features(struct drbd_connection *connection)
+static int got_NegAck(struct drbd_connection *connection, struct packet_info *pi)
 {
-	/* ASSERT current == connection->receiver ... */
-	struct p_connection_features *p;
-	const int expect = sizeof(struct p_connection_features);
-	struct packet_info pi;
+	struct drbd_peer_device *peer_device;
+	struct p_block_ack *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
+	int size = be32_to_cpu(p->blksize);
 	int err;
 
-	err = drbd_send_features(connection);
-	if (err)
-		return 0;
-
-	err = drbd_recv_header(connection, &pi);
-	if (err)
-		return 0;
-
-	if (pi.cmd != P_CONNECTION_FEATURES) {
-		drbd_err(connection, "expected ConnectionFeatures packet, received: %s (0x%04x)\n",
-			 drbd_packet_name(pi.cmd), pi.cmd);
-		return -1;
-	}
-
-	if (pi.size != expect) {
-		drbd_err(connection, "expected ConnectionFeatures length: %u, received: %u\n",
-		     expect, pi.size);
-		return -1;
-	}
+	/* P_NEG_ACK used to be used instead of P_RS_NEG_ACK. */
+	if (p->block_id == ID_SYNCER)
+		return got_RSWriteAck(connection, pi);
 
-	p = pi.data;
-	err = drbd_recv_all_warn(connection, p, expect);
-	if (err)
-		return 0;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	p->protocol_min = be32_to_cpu(p->protocol_min);
-	p->protocol_max = be32_to_cpu(p->protocol_max);
-	if (p->protocol_max == 0)
-		p->protocol_max = p->protocol_min;
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	if (PRO_VERSION_MAX < p->protocol_min ||
-	    PRO_VERSION_MIN > p->protocol_max)
-		goto incompat;
+	if (peer_device->disk_state[NOW] == D_UP_TO_DATE)
+		set_bit(GOT_NEG_ACK, peer_device->flags);
 
-	connection->agreed_pro_version = min_t(int, PRO_VERSION_MAX, p->protocol_max);
-	connection->agreed_features = PRO_FEATURES & be32_to_cpu(p->feature_flags);
+	err = validate_req_change_req_state(peer_device, p->block_id, sector,
+			INTERVAL_LOCAL_WRITE, __func__, NEG_ACKED, true);
+	if (err) {
+		/* Protocol A has no P_WRITE_ACKs, but has P_NEG_ACKs.
+		   The master bio might already be completed, therefore the
+		   request is no longer in the collision hash. */
+		/* In Protocol B we might already have got a P_RECV_ACK
+		   but then get a P_NEG_ACK afterwards. */
+		drbd_set_out_of_sync(peer_device, sector, size);
+	}
+	return 0;
+}
 
-	drbd_info(connection, "Handshake successful: "
-	     "Agreed network protocol version %d\n", connection->agreed_pro_version);
+/* The peer, a sync target, can not secure this write toward its sync source
+ * and counts it as not processed. Mark the request to be retried: once its
+ * references drain, drbd_restart_request() re-submits the original bio as a
+ * brand-new request; under IO suspension only after the resume.
+ */
+static int got_RetryWrite(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct p_block_ack *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
 
-	drbd_info(connection, "Feature flags enabled on protocol level: 0x%x%s%s%s%s.\n",
-		  connection->agreed_features,
-		  connection->agreed_features & DRBD_FF_TRIM ? " TRIM" : "",
-		  connection->agreed_features & DRBD_FF_THIN_RESYNC ? " THIN_RESYNC" : "",
-		  connection->agreed_features & DRBD_FF_WSAME ? " WRITE_SAME" : "",
-		  connection->agreed_features & DRBD_FF_WZEROES ? " WRITE_ZEROES" :
-		  connection->agreed_features ? "" : " none");
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	return 1;
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
- incompat:
-	drbd_err(connection, "incompatible DRBD dialects: "
-	    "I support %d-%d, peer supports %d-%d\n",
-	    PRO_VERSION_MIN, PRO_VERSION_MAX,
-	    p->protocol_min, p->protocol_max);
-	return -1;
+	/* A request that is gone was already resolved by connection loss. */
+	validate_req_change_req_state(peer_device, p->block_id, sector,
+				      INTERVAL_LOCAL_WRITE, __func__,
+				      POSTPONED_BY_PEER, true);
+	return 0;
 }
 
-#if !defined(CONFIG_CRYPTO_HMAC) && !defined(CONFIG_CRYPTO_HMAC_MODULE)
-static int drbd_do_auth(struct drbd_connection *connection)
+static int got_NegDReply(struct drbd_connection *connection, struct packet_info *pi)
 {
-	drbd_err(connection, "This kernel was build without CONFIG_CRYPTO_HMAC.\n");
-	drbd_err(connection, "You need to disable 'cram-hmac-alg' in drbd.conf.\n");
-	return -1;
-}
-#else
-#define CHALLENGE_LEN 64
-
-/* Return value:
-	1 - auth succeeded,
-	0 - failed, try again (network error),
-	-1 - auth failed, don't try again.
-*/
+	struct drbd_peer_device *peer_device;
+	struct p_block_ack *p = pi->data;
+	sector_t sector = be64_to_cpu(p->sector);
 
-static int drbd_do_auth(struct drbd_connection *connection)
-{
-	struct drbd_socket *sock;
-	char my_challenge[CHALLENGE_LEN];  /* 64 Bytes... */
-	char *response = NULL;
-	char *right_response = NULL;
-	char *peers_ch = NULL;
-	unsigned int key_len;
-	char secret[SHARED_SECRET_MAX]; /* 64 byte */
-	unsigned int resp_size;
-	struct shash_desc *desc;
-	struct packet_info pi;
-	struct net_conf *nc;
-	int err, rv;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	/* FIXME: Put the challenge/response into the preallocated socket buffer.  */
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	key_len = strlen(nc->shared_secret);
-	memcpy(secret, nc->shared_secret, key_len);
-	rcu_read_unlock();
+	drbd_warn_ratelimit(peer_device, "Got NegDReply; Sector %llus, len %u.\n",
+			(unsigned long long)sector, be32_to_cpu(p->blksize));
 
-	desc = kmalloc(sizeof(struct shash_desc) +
-		       crypto_shash_descsize(connection->cram_hmac_tfm),
-		       GFP_KERNEL);
-	if (!desc) {
-		rv = -1;
-		goto fail;
-	}
-	desc->tfm = connection->cram_hmac_tfm;
+	return validate_req_change_req_state(peer_device, p->block_id, sector,
+					     INTERVAL_LOCAL_READ, __func__,
+					     NEG_ACKED, false);
+}
 
-	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
-	if (rv) {
-		drbd_err(connection, "crypto_shash_setkey() failed with %d\n", rv);
-		rv = -1;
-		goto fail;
-	}
+void drbd_unsuccessful_resync_request(struct drbd_peer_request *peer_req, bool failed)
+{
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device->device;
 
-	get_random_bytes(my_challenge, CHALLENGE_LEN);
+	if (get_ldev_if_state(device, D_DETACHING)) {
+		if (failed) {
+			drbd_rs_failed_io(peer_device, peer_req->i.sector, peer_req->i.size);
+		} else {
+			if (drbd_interval_is_verify(&peer_req->i)) {
+				drbd_verify_skipped_block(peer_device, peer_req->i.sector, peer_req->i.size);
+				verify_progress(peer_device, peer_req->i.sector, peer_req->i.size);
+			} else {
+				set_bit(RS_REQUEST_UNSUCCESSFUL, peer_device->flags);
+			}
+		}
 
-	sock = &connection->data;
-	if (!conn_prepare_command(connection, sock)) {
-		rv = 0;
-		goto fail;
+		rs_sectors_came_in(peer_device, peer_req->i.size);
+		mod_timer(&peer_device->resync_timer, jiffies + RS_MAKE_REQS_INTV);
+		put_ldev(device);
 	}
-	rv = !conn_send_command(connection, sock, P_AUTH_CHALLENGE, 0,
-				my_challenge, CHALLENGE_LEN);
-	if (!rv)
-		goto fail;
 
-	err = drbd_recv_header(connection, &pi);
-	if (err) {
-		rv = 0;
-		goto fail;
-	}
+	drbd_remove_peer_req_interval(peer_req);
+	drbd_free_peer_req(peer_req);
+}
 
-	if (pi.cmd != P_AUTH_CHALLENGE) {
-		drbd_err(connection, "expected AuthChallenge packet, received: %s (0x%04x)\n",
-			 drbd_packet_name(pi.cmd), pi.cmd);
-		rv = -1;
-		goto fail;
-	}
+static int got_NegRSDReply(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_peer_request *peer_req;
+	sector_t sector;
+	int size;
+	u64 block_id;
+	struct p_block_ack *p = pi->data;
 
-	if (pi.size > CHALLENGE_LEN * 2) {
-		drbd_err(connection, "expected AuthChallenge payload too big.\n");
-		rv = -1;
-		goto fail;
-	}
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
 
-	if (pi.size < CHALLENGE_LEN) {
-		drbd_err(connection, "AuthChallenge payload too small.\n");
-		rv = -1;
-		goto fail;
-	}
+	sector = be64_to_cpu(p->sector);
+	size = be32_to_cpu(p->blksize);
 
-	peers_ch = kmalloc(pi.size, GFP_NOIO);
-	if (!peers_ch) {
-		rv = -1;
-		goto fail;
-	}
+	/* Prior to protocol version 122, block_id may be meaningless. */
+	block_id = peer_device->connection->agreed_pro_version >= 122 ? p->block_id : ID_SYNCER;
 
-	err = drbd_recv_all_warn(connection, peers_ch, pi.size);
-	if (err) {
-		rv = 0;
-		goto fail;
-	}
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	if (!memcmp(my_challenge, peers_ch, CHALLENGE_LEN)) {
-		drbd_err(connection, "Peer presented the same challenge!\n");
-		rv = -1;
-		goto fail;
-	}
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_WRITE) |
+			INTERVAL_TYPE_MASK(INTERVAL_OV_READ_SOURCE),
+			sector, size, block_id);
+	if (!peer_req)
+		return -EIO;
 
-	resp_size = crypto_shash_digestsize(connection->cram_hmac_tfm);
-	response = kmalloc(resp_size, GFP_NOIO);
-	if (!response) {
-		rv = -1;
-		goto fail;
-	}
+	dec_rs_pending(peer_device);
 
-	rv = crypto_shash_digest(desc, peers_ch, pi.size, response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
-		rv = -1;
-		goto fail;
-	}
+	if (pi->cmd == P_RS_CANCEL_AHEAD &&
+	    !test_and_set_bit(SYNC_TARGET_TO_BEHIND, peer_device->flags) &&
+	    peer_device->repl_state[NOW] == L_SYNC_TARGET)
+		drbd_info(peer_device, "peer pulled ahead during resync\n");
 
-	if (!conn_prepare_command(connection, sock)) {
-		rv = 0;
-		goto fail;
-	}
-	rv = !conn_send_command(connection, sock, P_AUTH_RESPONSE, 0,
-				response, resp_size);
-	if (!rv)
-		goto fail;
+	drbd_unsuccessful_resync_request(peer_req, pi->cmd == P_NEG_RS_DREPLY);
+	return 0;
+}
 
-	err = drbd_recv_header(connection, &pi);
-	if (err) {
-		rv = 0;
-		goto fail;
-	}
+/* Find the write a dagtag wait answer is for. The answer arrives on the connection
+ * to the sync source, the write itself belongs to the connection to its
+ * writer: either parked on that connection's source_wait_ee (taken off and
+ * returned), or still on its peer_requests because the answer overtook the
+ * local completion -- then the answer is recorded on the request, and
+ * e_end_block() acts on it.
+ */
+static bool dagtag_wait_answer_matches(struct drbd_peer_request *peer_req,
+				       unsigned int source_node_id, sector_t sector,
+				       u64 block_id)
+{
+	sector_t range_sector;
+	unsigned int range_size;
 
-	if (pi.cmd != P_AUTH_RESPONSE) {
-		drbd_err(connection, "expected AuthResponse packet, received: %s (0x%04x)\n",
-			 drbd_packet_name(pi.cmd), pi.cmd);
-		rv = 0;
-		goto fail;
-	}
+	if ((u64)(unsigned long)peer_req != block_id ||
+	    !(peer_req->flags & EE_WAIT_FOR_SOURCE) ||
+	    peer_req->wait_source_node_id != source_node_id)
+		return false;
 
-	if (pi.size != resp_size) {
-		drbd_err(connection, "expected AuthResponse payload of wrong size\n");
-		rv = 0;
-		goto fail;
-	}
+	/* The answer echoes the range the request named. A request that
+	 * is gone may have left its address to a new one; do not let a
+	 * late answer settle that one.
+	 */
+	unsecured_write_range(peer_req, &range_sector, &range_size);
+	return range_sector == sector;
+}
 
-	err = drbd_recv_all_warn(connection, response , resp_size);
-	if (err) {
-		rv = 0;
-		goto fail;
-	}
+static struct drbd_peer_request *dagtag_wait_answer_request(struct drbd_resource *resource,
+							    unsigned int source_node_id,
+							    sector_t sector, u64 block_id,
+							    unsigned long answer_flag)
+{
+	struct drbd_peer_request *peer_req, *found = NULL;
+	struct drbd_connection *connection;
+	bool recorded = false;
 
-	right_response = kmalloc(resp_size, GFP_NOIO);
-	if (!right_response) {
-		rv = -1;
-		goto fail;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		spin_lock_irq(&connection->peer_reqs_lock);
+		list_for_each_entry(peer_req, &connection->source_wait_ee, w.list) {
+			if (!dagtag_wait_answer_matches(peer_req, source_node_id, sector, block_id))
+				continue;
+			list_del(&peer_req->w.list);
+			/* Reached: acknowledged from here on, nothing can
+			 * refuse it any more. Unreachable: refused next.
+			 */
+			if (answer_flag == EE_SOURCE_REACHED)
+				peer_req->flags |= EE_ACK_DECIDED;
+			found = peer_req;
+			break;
+		}
+		if (!found) {
+			list_for_each_entry(peer_req, &connection->peer_requests, recv_order) {
+				if (!dagtag_wait_answer_matches(peer_req, source_node_id,
+								sector, block_id))
+					continue;
+				peer_req->flags |= answer_flag;
+				recorded = true;
+				break;
+			}
+		}
+		spin_unlock_irq(&connection->peer_reqs_lock);
+		if (found || recorded)
+			break;
 	}
+	rcu_read_unlock();
 
-	rv = crypto_shash_digest(desc, my_challenge, CHALLENGE_LEN,
-				 right_response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
-		rv = -1;
-		goto fail;
-	}
+	return found;
+}
 
-	rv = !memcmp(response, right_response, resp_size);
+static int got_RSDagtagReached(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct p_block_ack *p = pi->data;
+	struct drbd_peer_device *peer_device;
+	struct drbd_peer_request *peer_req;
 
-	if (rv)
-		drbd_info(connection, "Peer authenticated using %d bytes HMAC\n",
-		     resp_size);
-	else
-		rv = -1;
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
- fail:
-	kfree(peers_ch);
-	kfree(response);
-	kfree(right_response);
-	if (desc) {
-		shash_desc_zero(desc);
-		kfree(desc);
-	}
+	peer_req = dagtag_wait_answer_request(connection->resource, connection->peer_node_id,
+					      be64_to_cpu(p->sector), p->block_id,
+					      EE_SOURCE_REACHED);
+	if (!peer_req)
+		return 0;
 
-	return rv;
+	peer_req->flags &= ~(EE_WAIT_FOR_SOURCE | EE_SOURCE_REACHED);
+	drbd_queue_work(&peer_req->peer_device->connection->sender_work, &peer_req->w);
+
+	return 0;
 }
-#endif
 
-int drbd_receiver(struct drbd_thread *thi)
+static bool peer_req_overlaps(struct drbd_peer_request *peer_req, sector_t sector,
+			      unsigned int size)
 {
-	struct drbd_connection *connection = thi->connection;
-	int h;
+	return peer_req->i.size &&
+		peer_req->i.sector < sector + (size >> SECTOR_SHIFT) &&
+		sector < peer_req->i.sector + (peer_req->i.size >> SECTOR_SHIFT);
+}
+
+/* The sync source can not serve a resync request of ours with its dependency
+ * met: it has lost the node whose write stream the request depends on, so its
+ * copy of the range is older than every write of that stream this node
+ * received since. It may still overwrite the range once no such write can be
+ * lost: every protocol C write in the range whose writer may still hold it
+ * pending is taken back from the writer the way drbd_refuse_unsecured_write()
+ * does it, retried or held across a severed connection, and reaches this node
+ * again once the resync brought it up to date. A write whose acknowledgment
+ * is already decided, or a protocol A or B write, can not be secured.
+ *
+ * Runs on the ack receiver of the connection to the sync source. Returns
+ * true when the range is secured.
+ */
+static bool drbd_secure_resync_range(struct drbd_peer_device *source,
+				     sector_t sector, unsigned int size)
+{
+	struct drbd_device *device = source->device;
+	struct drbd_resource *resource = device->resource;
+	struct drbd_connection *connection;
+	struct drbd_peer_request *peer_req, *t;
+	LIST_HEAD(refuse_list);
+	bool secured = true;
 
-	drbd_info(connection, "receiver (re)started\n");
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection == source->connection)
+			continue;
 
-	do {
-		h = conn_connect(connection);
-		if (h == 0) {
-			conn_disconnect(connection);
-			schedule_timeout_interruptible(HZ);
+		spin_lock_irq(&connection->peer_reqs_lock);
+		/* Withheld, waiting for the source's answer: this is it. */
+		list_for_each_entry_safe(peer_req, t, &connection->source_wait_ee, w.list) {
+			if (peer_req->peer_device->device != device ||
+			    !peer_req_overlaps(peer_req, sector, size))
+				continue;
+			if (!unsecured_write_refusable(peer_req)) {
+				secured = false;
+				break;
+			}
+			list_move_tail(&peer_req->w.list, &refuse_list);
 		}
-		if (h == -1) {
-			drbd_warn(connection, "Discarding network configuration.\n");
-			conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
+		/* Not completed yet, or completed and not peer-acked yet. */
+		list_for_each_entry(peer_req, &connection->peer_requests, recv_order) {
+			if (!secured)
+				break;
+			if (peer_req->peer_device->device != device ||
+			    !peer_req_overlaps(peer_req, sector, size))
+				continue;
+			if (peer_req->flags & EE_POSTPONE)
+				continue; /* refused already */
+			if (peer_req->flags & EE_ACK_DECIDED ||
+			    !unsecured_write_refusable(peer_req)) {
+				secured = false;
+				break;
+			}
+			/* Still to complete: have e_end_block() refuse it. */
+			peer_req->wait_source_node_id = source->node_id;
+			peer_req->flags |= EE_WAIT_FOR_SOURCE | EE_SOURCE_UNREACHABLE;
 		}
-	} while (h == 0);
+		spin_unlock_irq(&connection->peer_reqs_lock);
+		if (!secured)
+			break;
+	}
+	rcu_read_unlock();
 
-	if (h > 0) {
-		blk_start_plug(&connection->receiver_plug);
-		drbdd(connection);
-		blk_finish_plug(&connection->receiver_plug);
+	list_for_each_entry_safe(peer_req, t, &refuse_list, w.list) {
+		list_del_init(&peer_req->w.list);
+		drbd_refuse_unsecured_write(peer_req);
 	}
 
-	conn_disconnect(connection);
+	return secured;
+}
+
+/* Ask the sync source again for a range drbd_secure_resync_range() secured,
+ * this time without the dependency the source can not meet. On cancel the
+ * teardown frees the request.
+ */
+static int w_send_unsecured_resync_request(struct drbd_work *w, int cancel)
+{
+	struct drbd_peer_request *peer_req =
+		container_of(w, struct drbd_peer_request, w);
+
+	if (cancel)
+		return 0;
 
-	drbd_info(connection, "receiver terminated\n");
+	drbd_send_rs_request(peer_req->peer_device, P_RS_DATA_REQUEST,
+			     peer_req->i.sector, peer_req->i.size,
+			     peer_req->block_id, 0, 0);
 	return 0;
 }
 
-/* ********* acknowledge sender ******** */
-
-static int got_conn_RqSReply(struct drbd_connection *connection, struct packet_info *pi)
+static void drbd_resync_request_unreachable(struct drbd_peer_request *peer_req)
 {
-	struct p_req_state_reply *p = pi->data;
-	int retcode = be32_to_cpu(p->retcode);
+	struct drbd_peer_device *source = peer_req->peer_device;
 
-	if (retcode >= SS_SUCCESS) {
-		set_bit(CONN_WD_ST_CHG_OKAY, &connection->flags);
-	} else {
-		set_bit(CONN_WD_ST_CHG_FAIL, &connection->flags);
-		drbd_err(connection, "Requested state change failed by peer: %s (%d)\n",
-			 drbd_set_st_err_str(retcode), retcode);
+	if (repl_is_sync_target(source->repl_state[NOW]) &&
+	    drbd_secure_resync_range(source, peer_req->i.sector, peer_req->i.size)) {
+		dynamic_drbd_dbg(source,
+				 "Resync request at %llus+%u: source lost the stream it depends on, asking without\n",
+				 (unsigned long long)peer_req->i.sector, peer_req->i.size);
+		peer_req->w.cb = w_send_unsecured_resync_request;
+		drbd_queue_work(&source->connection->sender_work, &peer_req->w);
+		return;
 	}
-	wake_up(&connection->ping_wait);
 
-	return 0;
+	drbd_info_ratelimit(source,
+			    "Can not secure resync request at %llus+%u against a source that lost the writer, ending the resync\n",
+			    (unsigned long long)peer_req->i.sector, peer_req->i.size);
+	if (repl_is_sync_target(source->repl_state[NOW]))
+		change_repl_state(source, L_ESTABLISHED, CS_VERBOSE, "unsecured-resync");
+	dec_rs_pending(source);
+	drbd_unsuccessful_resync_request(peer_req, false);
 }
 
-static int got_RqSReply(struct drbd_connection *connection, struct packet_info *pi)
+/* The sync source can not reach the position in the writer's stream by
+ * itself: for a resync request of ours, secure the range and ask again
+ * without the dependency; for a write withheld from acknowledgment, refuse
+ * it.
+ */
+static int got_RSDagtagUnreachable(struct drbd_connection *connection, struct packet_info *pi)
 {
+	struct p_block_ack *p = pi->data;
 	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_req_state_reply *p = pi->data;
-	int retcode = be32_to_cpu(p->retcode);
+	struct drbd_peer_request *peer_req;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
-	device = peer_device->device;
+	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
 
-	if (test_bit(CONN_WD_ST_CHG_REQ, &connection->flags)) {
-		D_ASSERT(device, connection->agreed_pro_version < 100);
-		return got_conn_RqSReply(connection, pi);
+	peer_req = __find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_RESYNC_WRITE),
+					 be64_to_cpu(p->sector), be32_to_cpu(p->blksize),
+					 p->block_id, false);
+	if (peer_req) {
+		drbd_resync_request_unreachable(peer_req);
+		return 0;
 	}
 
-	if (retcode >= SS_SUCCESS) {
-		set_bit(CL_ST_CHG_SUCCESS, &device->flags);
-	} else {
-		set_bit(CL_ST_CHG_FAIL, &device->flags);
-		drbd_err(device, "Requested state change failed by peer: %s (%d)\n",
-			drbd_set_st_err_str(retcode), retcode);
-	}
-	wake_up(&device->state_wait);
+	peer_req = dagtag_wait_answer_request(connection->resource, connection->peer_node_id,
+					      be64_to_cpu(p->sector), p->block_id,
+					      EE_SOURCE_UNREACHABLE);
+	if (!peer_req)
+		return 0;
+
+	drbd_refuse_unsecured_write(peer_req);
 
 	return 0;
 }
 
-static int got_Ping(struct drbd_connection *connection, struct packet_info *pi)
+static int got_BarrierAck(struct drbd_connection *connection, struct packet_info *pi)
 {
-	return drbd_send_ping_ack(connection);
+	struct p_barrier_ack *p = pi->data;
+	struct drbd_peer_device *peer_device;
+	bool release_gen = false;
+	int vnr, err;
+
+	/* tl_release flushes this epoch (RQ_NET_DONE) first, so the confirm below
+	 * sees the just-flushed held writes.
+	 */
+	err = tl_release(connection, 0, 0, p->barrier, be32_to_cpu(p->set_size));
 
+	/* confirm any peer that has now durably persisted all the generation's
+	 * held writes, then re-evaluate the release gate.
+	 */
+	if (!err) {
+		rcu_read_lock();
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			drbd_peer_maybe_confirm_rotated_gen(peer_device, p->barrier);
+			if (drbd_maybe_release_rotated_gen(peer_device->device))
+				release_gen = true;
+		}
+		rcu_read_unlock();
+		if (release_gen)
+			tl_walk(connection, NULL, NEW_UUID_CONFIRMED);
+	}
+
+	return err;
 }
 
-static int got_PingAck(struct drbd_connection *connection, struct packet_info *pi)
+static int got_confirm_stable(struct drbd_connection *connection, struct packet_info *pi)
 {
-	/* restore idle timeout */
-	connection->meta.socket->sk->sk_rcvtimeo = connection->net_conf->ping_int*HZ;
-	if (!test_and_set_bit(GOT_PING_ACK, &connection->flags))
-		wake_up(&connection->ping_wait);
+	struct p_confirm_stable *p = pi->data;
 
-	return 0;
+	return tl_release(connection, p->oldest_block_id, p->youngest_block_id, 0,
+			  be32_to_cpu(p->set_size));
 }
 
-static int got_IsInSync(struct drbd_connection *connection, struct packet_info *pi)
+static int got_OVResult(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
-	struct p_block_ack *p = pi->data;
-	sector_t sector = be64_to_cpu(p->sector);
-	int blksize = be32_to_cpu(p->blksize);
+	struct drbd_peer_request *peer_req;
+	sector_t sector;
+	int size;
+	u64 block_id;
+	u32 seq_num;
+	enum ov_result result;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
 		return -EIO;
 	device = peer_device->device;
 
-	D_ASSERT(device, peer_device->connection->agreed_pro_version >= 89);
+	if (pi->cmd == P_OV_RESULT) {
+		struct p_block_ack *p = pi->data;
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+		sector = be64_to_cpu(p->sector);
+		size = be32_to_cpu(p->blksize);
+		block_id = ID_SYNCER;
+		seq_num = be32_to_cpu(p->seq_num);
+		result = drbd_block_id_to_ov_result(be64_to_cpu(p->block_id));
+	} else { /* P_OV_RESULT_ID */
+		struct p_ov_result *p = pi->data;
 
-	if (get_ldev(device)) {
-		drbd_rs_complete_io(device, sector);
-		drbd_set_in_sync(peer_device, sector, blksize);
-		/* rs_same_csums is supposed to count in units of BM_BLOCK_SIZE */
-		device->rs_same_csum += (blksize >> BM_BLOCK_SHIFT);
-		put_ldev(device);
+		sector = be64_to_cpu(p->sector);
+		size = be32_to_cpu(p->blksize);
+		block_id = p->block_id;
+		seq_num = be32_to_cpu(p->seq_num);
+		result = be32_to_cpu(p->result);
 	}
+
+	update_peer_seq(peer_device, seq_num);
+
+	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_OV_READ_TARGET),
+			sector, size, block_id);
+	if (!peer_req)
+		return -EIO;
+
+	drbd_remove_peer_req_interval(peer_req);
+
+	/* This may be a request that we could not cancel because the peer does
+	 * not understand P_RS_CANCEL. Treat it as a skipped block. */
+	if (connection->agreed_pro_version < 110 && test_bit(INTERVAL_CONFLICT, &peer_req->i.flags))
+		result = OV_RESULT_SKIP;
+
+	drbd_free_peer_req(peer_req);
+	peer_req = NULL;
+
+	if (result == OV_RESULT_SKIP)
+		drbd_verify_skipped_block(peer_device, sector, size);
+	if (result == OV_RESULT_OUT_OF_SYNC)
+		drbd_ov_out_of_sync_found(peer_device, sector, size);
+	else
+		ov_out_of_sync_print(peer_device);
+
 	dec_rs_pending(peer_device);
-	atomic_add(blksize >> 9, &device->rs_sect_in);
 
+	if (!get_ldev(device))
+		return 0;
+
+	verify_progress(peer_device, sector, size);
+
+	put_ldev(device);
+	return 0;
+}
+
+static int got_skip(struct drbd_connection *connection, struct packet_info *pi)
+{
 	return 0;
 }
 
-static int
-validate_req_change_req_state(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-			      struct rb_root *root, const char *func,
-			      enum drbd_req_event what, bool missing_ok)
+static u64 node_id_to_mask(struct drbd_peer_md *peer_md, int node_id)
 {
-	struct drbd_device *device = peer_device->device;
-	struct drbd_request *req;
-	struct bio_and_error m;
+	int bitmap_bit = peer_md[node_id].bitmap_index;
 
-	spin_lock_irq(&device->resource->req_lock);
-	req = find_request(device, root, id, sector, missing_ok, func);
-	if (unlikely(!req)) {
-		spin_unlock_irq(&device->resource->req_lock);
-		return -EIO;
+	return (bitmap_bit >= 0) ? NODE_MASK(bitmap_bit) : 0;
+}
+
+static u64 node_ids_to_bitmap(struct drbd_device *device, u64 node_ids)
+{
+	struct drbd_peer_md *peer_md = device->ldev->md.peers;
+	u64 bitmap_bits = 0;
+	int node_id;
+
+	for_each_set_bit(node_id, (unsigned long *)&node_ids, DRBD_NODE_ID_MAX)
+		bitmap_bits |= node_id_to_mask(peer_md, node_id);
+	return bitmap_bits;
+}
+
+static struct drbd_peer_request *drbd_send_oos_next_req(struct drbd_resource *resource,
+		int oos_node_id, struct drbd_peer_request *peer_req)
+{
+	lockdep_assert_held(&resource->send_oos_lock);
+
+	if (peer_req == NULL)
+		peer_req = list_entry(&resource->send_oos,
+				struct drbd_peer_request, recv_order);
+
+	list_for_each_entry_continue(peer_req, &resource->send_oos, recv_order) {
+		if (NODE_MASK(oos_node_id) & peer_req->send_oos_pending)
+			return peer_req;
 	}
-	__req_mod(req, what, peer_device, &m);
-	spin_unlock_irq(&device->resource->req_lock);
 
-	if (m.bio)
-		complete_master_bio(device, &m);
-	return 0;
+	return NULL;
 }
 
-static int got_BlockAck(struct drbd_connection *connection, struct packet_info *pi)
+static void free_send_oos_peer_req(struct drbd_peer_request *peer_req)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_block_ack *p = pi->data;
-	sector_t sector = be64_to_cpu(p->sector);
-	int blksize = be32_to_cpu(p->blksize);
-	enum drbd_req_event what;
+	struct drbd_connection *peer_ack_connection = peer_req->peer_device->connection;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	peer_req->flags &= ~EE_ON_SEND_OOS;
+	drbd_free_peer_req(peer_req);
+	kref_put(&peer_ack_connection->kref, drbd_destroy_connection);
+}
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+/*
+ * Only this work clears the bit of its peer in send_oos_pending, so the
+ * next entry stays on the list while send_oos_lock is dropped.
+ *
+ * @cancel: the stream to the peer is dead. The work was queued while the
+ * peer was connected and still owns its bits on the send_oos list. Clear
+ * them without sending: our bitmap covers the writes.
+ */
+int drbd_send_out_of_sync_wf(struct drbd_work *w, int cancel)
+{
+	struct drbd_connection *oos_connection =
+		container_of(w, struct drbd_connection, send_oos_work);
+	struct drbd_resource *resource = oos_connection->resource;
+	int oos_node_id = oos_connection->peer_node_id;
+	struct drbd_peer_request *peer_req;
 
-	if (p->block_id == ID_SYNCER) {
-		drbd_set_in_sync(peer_device, sector, blksize);
-		dec_rs_pending(peer_device);
-		return 0;
-	}
-	switch (pi->cmd) {
-	case P_RS_WRITE_ACK:
-		what = WRITE_ACKED_BY_PEER_AND_SIS;
-		break;
-	case P_WRITE_ACK:
-		what = WRITE_ACKED_BY_PEER;
-		break;
-	case P_RECV_ACK:
-		what = RECV_ACKED_BY_PEER;
-		break;
-	case P_SUPERSEDED:
-		what = CONFLICT_RESOLVED;
-		break;
-	case P_RETRY_WRITE:
-		what = POSTPONE_WRITE;
-		break;
-	default:
-		BUG();
+	spin_lock_irq(&resource->send_oos_lock);
+	peer_req = drbd_send_oos_next_req(resource, oos_node_id, NULL);
+	spin_unlock_irq(&resource->send_oos_lock);
+
+	while (peer_req) {
+		struct drbd_peer_device *peer_device =
+			conn_peer_device(oos_connection, peer_req->peer_device->device->vnr);
+		struct drbd_peer_request *next_peer_req;
+		bool free_it;
+
+		/* Ignore errors and keep iterating to clear up list */
+		if (!cancel)
+			drbd_send_out_of_sync(peer_device, peer_req->i.sector, peer_req->i.size);
+
+		spin_lock_irq(&resource->send_oos_lock);
+		peer_req->send_oos_pending &= ~NODE_MASK(oos_node_id);
+		next_peer_req = drbd_send_oos_next_req(resource, oos_node_id, peer_req);
+		free_it = !peer_req->send_oos_pending;
+		if (free_it)
+			list_del(&peer_req->recv_order);
+		spin_unlock_irq(&resource->send_oos_lock);
+
+		if (free_it)
+			free_send_oos_peer_req(peer_req);
+
+		peer_req = next_peer_req;
 	}
 
-	return validate_req_change_req_state(peer_device, p->block_id, sector,
-					     &device->write_requests, __func__,
-					     what, false);
+	return 0;
+}
+
+static bool is_sync_source(struct drbd_peer_device *peer_device)
+{
+	return is_sync_source_state(peer_device, NOW) ||
+		peer_device->repl_state[NOW] == L_WF_BITMAP_S;
 }
 
-static int got_NegAck(struct drbd_connection *connection, struct packet_info *pi)
+static u64 drbd_calculate_send_oos_pending(struct drbd_device *device, u64 in_sync)
 {
 	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_block_ack *p = pi->data;
-	sector_t sector = be64_to_cpu(p->sector);
-	int size = be32_to_cpu(p->blksize);
-	int err;
+	u64 send_oos_pending = 0;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (!(NODE_MASK(peer_device->node_id) & in_sync) &&
+				is_sync_source(peer_device))
+			send_oos_pending |= NODE_MASK(peer_device->node_id);
+	}
+	rcu_read_unlock();
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+	return send_oos_pending;
+}
 
-	if (p->block_id == ID_SYNCER) {
-		dec_rs_pending(peer_device);
-		drbd_rs_failed_io(peer_device, sector, size);
-		return 0;
+static void drbd_queue_send_out_of_sync(struct drbd_connection *peer_ack_connection,
+		struct list_head *send_oos_peer_req_list, u64 any_send_oos_pending)
+{
+	struct drbd_resource *resource = peer_ack_connection->resource;
+	struct drbd_connection *oos_connection;
+	struct drbd_peer_request *peer_req, *tmp;
+	u64 queue_mask = 0;
+	LIST_HEAD(free_list);
+
+	if (!any_send_oos_pending)
+		return;
+
+	list_for_each_entry(peer_req, send_oos_peer_req_list, recv_order) {
+		kref_get(&peer_ack_connection->kref);
 	}
 
-	err = validate_req_change_req_state(peer_device, p->block_id, sector,
-					    &device->write_requests, __func__,
-					    NEG_ACKED, true);
-	if (err) {
-		/* Protocol A has no P_WRITE_ACKs, but has P_NEG_ACKs.
-		   The master bio might already be completed, therefore the
-		   request is no longer in the collision hash. */
-		/* In Protocol B we might already have got a P_RECV_ACK
-		   but then get a P_NEG_ACK afterwards. */
-		drbd_set_out_of_sync(peer_device, sector, size);
+	/*
+	 * Hold state_rwlock from choosing the peers until their work is queued,
+	 * so that each of them is still connected and its sender still runs.
+	 */
+	read_lock_irq(&resource->state_rwlock);
+	for_each_connection(oos_connection, resource) {
+		u64 m = NODE_MASK(oos_connection->peer_node_id);
+
+		if (m & any_send_oos_pending && oos_connection->cstate[NOW] >= C_CONNECTED)
+			queue_mask |= m;
+	}
+
+	/*
+	 * A peer that lost its connection since drbd_calculate_send_oos_pending()
+	 * gets no P_OUT_OF_SYNC. Our bitmap bits for it cover these writes.
+	 */
+	if (any_send_oos_pending & ~queue_mask) {
+		list_for_each_entry_safe(peer_req, tmp, send_oos_peer_req_list, recv_order) {
+			peer_req->send_oos_pending &= queue_mask;
+			if (!peer_req->send_oos_pending)
+				list_move_tail(&peer_req->recv_order, &free_list);
+		}
+	}
+
+	spin_lock(&resource->send_oos_lock);
+	list_splice_tail(send_oos_peer_req_list, &resource->send_oos);
+	spin_unlock(&resource->send_oos_lock);
+
+	for_each_connection(oos_connection, resource) {
+		if (NODE_MASK(oos_connection->peer_node_id) & queue_mask)
+			drbd_queue_work_if_unqueued(&oos_connection->sender_work,
+					&oos_connection->send_oos_work);
+	}
+	read_unlock_irq(&resource->state_rwlock);
+
+	/* Not the last krefs: the caller runs on peer_ack_connection */
+	list_for_each_entry_safe(peer_req, tmp, &free_list, recv_order) {
+		list_del(&peer_req->recv_order);
+		free_send_oos_peer_req(peer_req);
 	}
-	return 0;
 }
 
-static int got_NegDReply(struct drbd_connection *connection, struct packet_info *pi)
+/*
+ * All senders have stopped, and each ran its work. Anything left on the
+ * send_oos list has bits that no work clears.
+ */
+void drbd_free_send_oos_leftovers(struct drbd_resource *resource)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_block_ack *p = pi->data;
-	sector_t sector = be64_to_cpu(p->sector);
-
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	struct drbd_peer_request *peer_req, *tmp;
+	LIST_HEAD(free_list);
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+	spin_lock_irq(&resource->send_oos_lock);
+	list_splice_init(&resource->send_oos, &free_list);
+	spin_unlock_irq(&resource->send_oos_lock);
 
-	drbd_err(device, "Got NegDReply; Sector %llus, len %u.\n",
-	    (unsigned long long)sector, be32_to_cpu(p->blksize));
+	if (list_empty(&free_list))
+		return;
 
-	return validate_req_change_req_state(peer_device, p->block_id, sector,
-					     &device->read_requests, __func__,
-					     NEG_ACKED, false);
+	drbd_err(resource, "peer requests left on send_oos list\n");
+	list_for_each_entry_safe(peer_req, tmp, &free_list, recv_order) {
+		list_del(&peer_req->recv_order);
+		free_send_oos_peer_req(peer_req);
+	}
 }
 
-static int got_NegRSDReply(struct drbd_connection *connection, struct packet_info *pi)
+static int got_peer_ack(struct drbd_connection *connection, struct packet_info *pi)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	sector_t sector;
-	int size;
-	struct p_block_ack *p = pi->data;
+	struct p_peer_ack *p = pi->data;
+	u64 dagtag, in_sync;
+	struct drbd_peer_request *peer_req, *tmp;
+	struct list_head work_list;
+	u64 any_send_oos_pending = 0;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	dagtag = be64_to_cpu(p->dagtag);
+	in_sync = be64_to_cpu(p->mask);
 
-	sector = be64_to_cpu(p->sector);
-	size = be32_to_cpu(p->blksize);
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_for_each_entry(peer_req, &connection->peer_requests, recv_order) {
+		if (dagtag == peer_req->dagtag_sector)
+			goto found;
+	}
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+	drbd_err(connection, "peer request with dagtag %llu not found\n", dagtag);
+	return -EIO;
 
-	dec_rs_pending(peer_device);
+found:
+	list_cut_position(&work_list, &connection->peer_requests, &peer_req->recv_order);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	if (get_ldev_if_state(device, D_FAILED)) {
-		drbd_rs_complete_io(device, sector);
-		switch (pi->cmd) {
-		case P_NEG_RS_DREPLY:
-			drbd_rs_failed_io(peer_device, sector, size);
-			break;
-		case P_RS_CANCEL:
-			break;
-		default:
-			BUG();
+	list_for_each_entry_safe(peer_req, tmp, &work_list, recv_order) {
+		struct drbd_peer_device *peer_device = peer_req->peer_device;
+		struct drbd_device *device = peer_device->device;
+		u64 in_sync_b, mask;
+
+		D_ASSERT(peer_device, peer_req->flags & EE_IN_ACTLOG);
+
+		if (get_ldev(device)) {
+			if ((peer_req->flags & EE_WAS_ERROR) == 0)
+				in_sync_b = node_ids_to_bitmap(device, in_sync);
+			else
+				in_sync_b = 0;
+			mask = ~node_id_to_mask(device->ldev->md.peers,
+						connection->peer_node_id);
+
+			drbd_set_sync(device, peer_req->i.sector,
+				      peer_req->i.size, ~in_sync_b, mask);
+			drbd_al_complete_io(device, &peer_req->i);
+			put_ldev(device);
+		}
+
+		peer_req->send_oos_pending = drbd_calculate_send_oos_pending(device, in_sync);
+		any_send_oos_pending |= peer_req->send_oos_pending;
+		if (peer_req->send_oos_pending) {
+			peer_req->flags &= ~EE_ON_RECV_ORDER;
+			peer_req->flags |= EE_ON_SEND_OOS;
+		} else {
+			drbd_free_peer_req(peer_req); /* list_del() because EE_ON_RECV_ORDER */
 		}
-		put_ldev(device);
 	}
 
+	drbd_queue_send_out_of_sync(connection, &work_list, any_send_oos_pending);
 	return 0;
 }
 
-static int got_BarrierAck(struct drbd_connection *connection, struct packet_info *pi)
+void apply_unacked_peer_requests(struct drbd_connection *connection)
 {
-	struct p_barrier_ack *p = pi->data;
-	struct drbd_peer_device *peer_device;
-	int vnr;
-
-	tl_release(connection, p->barrier, be32_to_cpu(p->set_size));
+	struct drbd_peer_request *peer_req;
+	unsigned long flags;
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	spin_lock_irqsave(&connection->peer_reqs_lock, flags);
+	list_for_each_entry(peer_req, &connection->peer_requests, recv_order) {
+		struct drbd_peer_device *peer_device = peer_req->peer_device;
 		struct drbd_device *device = peer_device->device;
+		int bitmap_index = peer_device->bitmap_index;
+		u64 mask = ~(bitmap_index != -1 ? 1UL << bitmap_index : 0UL);
 
-		if (device->state.conn == C_AHEAD &&
-		    atomic_read(&device->ap_in_flight) == 0 &&
-		    !test_and_set_bit(AHEAD_TO_SYNC_SOURCE, &device->flags)) {
-			device->start_resync_timer.expires = jiffies + HZ;
-			add_timer(&device->start_resync_timer);
-		}
+		drbd_set_sync(device, peer_req->i.sector, peer_req->i.size,
+			      mask, mask);
 	}
-	rcu_read_unlock();
-
-	return 0;
+	spin_unlock_irqrestore(&connection->peer_reqs_lock, flags);
 }
 
-static int got_OVResult(struct drbd_connection *connection, struct packet_info *pi)
+static void cleanup_unacked_peer_requests(struct drbd_connection *connection)
 {
-	struct drbd_peer_device *peer_device;
-	struct drbd_device *device;
-	struct p_block_ack *p = pi->data;
-	struct drbd_device_work *dw;
-	sector_t sector;
-	int size;
+	struct drbd_peer_request *peer_req, *tmp;
+	LIST_HEAD(work_list);
+	u64 any_send_oos_pending = 0;
 
-	peer_device = conn_peer_device(connection, pi->vnr);
-	if (!peer_device)
-		return -EIO;
-	device = peer_device->device;
+	spin_lock_irq(&connection->peer_reqs_lock);
+	list_splice_init(&connection->peer_requests, &work_list);
+	spin_unlock_irq(&connection->peer_reqs_lock);
 
-	sector = be64_to_cpu(p->sector);
-	size = be32_to_cpu(p->blksize);
+	list_for_each_entry_safe(peer_req, tmp, &work_list, recv_order) {
+		struct drbd_peer_device *peer_device = peer_req->peer_device;
+		struct drbd_device *device = peer_device->device;
+		int bitmap_index = peer_device->bitmap_index;
+		u64 mask = ~(bitmap_index != -1 ? 1UL << bitmap_index : 0UL);
 
-	update_peer_seq(peer_device, be32_to_cpu(p->seq_num));
+		if (get_ldev(device)) {
+			drbd_set_sync(device, peer_req->i.sector, peer_req->i.size,
+				      mask, mask);
+			drbd_al_complete_io(device, &peer_req->i);
+			put_ldev(device);
+		}
 
-	if (be64_to_cpu(p->block_id) == ID_OUT_OF_SYNC)
-		drbd_ov_out_of_sync_found(peer_device, sector, size);
-	else
-		ov_out_of_sync_print(peer_device);
+		peer_req->send_oos_pending = drbd_calculate_send_oos_pending(device, 0);
+		any_send_oos_pending |= peer_req->send_oos_pending;
+		if (peer_req->send_oos_pending) {
+			peer_req->flags &= ~EE_ON_RECV_ORDER;
+			peer_req->flags |= EE_ON_SEND_OOS;
+		} else {
+			drbd_free_peer_req(peer_req); /* list_del() because EE_ON_RECV_ORDER */
+		}
+	}
 
-	if (!get_ldev(device))
-		return 0;
+	drbd_queue_send_out_of_sync(connection, &work_list, any_send_oos_pending);
+}
 
-	drbd_rs_complete_io(device, sector);
-	dec_rs_pending(peer_device);
+static void cleanup_peer_ack_list(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_ack *peer_ack, *tmp;
+	struct drbd_request *req;
+	int idx = connection->peer_node_id;
+	u64 node_id_mask = NODE_MASK(idx);
+
+	spin_lock_irq(&resource->peer_ack_lock);
+	list_for_each_entry_safe(peer_ack, tmp, &resource->peer_ack_list, list) {
+		if (!(peer_ack->queued_mask & node_id_mask))
+			continue;
+		peer_ack->queued_mask &= ~node_id_mask;
+		drbd_destroy_peer_ack_if_done(peer_ack);
+	}
+	req = resource->peer_ack_req;
+	if (req)
+		req->net_rq_state[idx] &= ~RQ_NET_SENT;
+	spin_unlock_irq(&resource->peer_ack_lock);
+}
 
-	--device->ov_left;
+int drbd_flush_ack_wf(struct drbd_work *w, int unused)
+{
+	struct drbd_connection *connection =
+		container_of(w, struct drbd_connection, flush_ack_work);
+	int primary_node_id;
 
-	/* let's advance progress step marks only for every other megabyte */
-	if ((device->ov_left & 0x200) == 0x200)
-		drbd_advance_rs_marks(peer_device, device->ov_left);
+	for (primary_node_id = 0; primary_node_id < DRBD_PEERS_MAX; primary_node_id++) {
+		u64 flush_sequence;
 
-	if (device->ov_left == 0) {
-		dw = kmalloc_obj(*dw, GFP_NOIO);
-		if (dw) {
-			dw->w.cb = w_ov_finished;
-			dw->device = device;
-			drbd_queue_work(&peer_device->connection->sender_work, &dw->w);
-		} else {
-			drbd_err(device, "kmalloc(dw) failed.");
-			ov_out_of_sync_print(peer_device);
-			drbd_resync_finished(peer_device);
-		}
+		spin_lock_irq(&connection->flush_ack_lock);
+		flush_sequence = connection->flush_ack_sequence[primary_node_id];
+		connection->flush_ack_sequence[primary_node_id] = 0;
+		spin_unlock_irq(&connection->flush_ack_lock);
+
+		if (flush_sequence) /* Active flushes use non-zero sequence numbers */
+			drbd_send_flush_requests_ack(connection, flush_sequence, primary_node_id);
 	}
-	put_ldev(device);
+
 	return 0;
 }
 
-static int got_skip(struct drbd_connection *connection, struct packet_info *pi)
+static int got_flush_forward(struct drbd_connection *connection, struct packet_info *pi)
 {
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_connection *initiator_connection;
+	struct p_flush_forward *p = pi->data;
+	u64 flush_sequence = be64_to_cpu(p->flush_sequence);
+	int initiator_node_id = be32_to_cpu(p->initiator_node_id);
+
+	rcu_read_lock();
+	initiator_connection = drbd_connection_by_node_id(resource, initiator_node_id);
+	if (!initiator_connection) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	queue_flush_ack(initiator_connection, connection->peer_node_id, flush_sequence);
+	rcu_read_unlock();
 	return 0;
 }
 
-struct meta_sock_cmd {
-	size_t pkt_size;
-	int (*fn)(struct drbd_connection *connection, struct packet_info *);
-};
-
-static void set_rcvtimeo(struct drbd_connection *connection, bool ping_timeout)
+static void set_rcvtimeo(struct drbd_connection *connection, enum rcv_timeou_kind kind)
 {
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_transport_ops *tr_ops = &transport->class->ops;
+	bool ping_timeout = kind == PING_TIMEOUT;
+	struct drbd_net_conf *nc;
 	long t;
-	struct net_conf *nc;
 
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
+	nc = rcu_dereference(transport->net_conf);
 	t = ping_timeout ? nc->ping_timeo : nc->ping_int;
 	rcu_read_unlock();
 
@@ -5741,202 +14628,267 @@ static void set_rcvtimeo(struct drbd_connection *connection, bool ping_timeout)
 	if (ping_timeout)
 		t /= 10;
 
-	connection->meta.socket->sk->sk_rcvtimeo = t;
+	tr_ops->set_rcvtimeo(transport, CONTROL_STREAM, t);
 }
 
-static void set_ping_timeout(struct drbd_connection *connection)
+void drbd_send_ping_wf(struct work_struct *ws)
 {
-	set_rcvtimeo(connection, 1);
-}
+	struct drbd_connection *connection =
+		container_of(ws, struct drbd_connection, send_ping_work);
+	int err;
 
-static void set_idle_timeout(struct drbd_connection *connection)
-{
-	set_rcvtimeo(connection, 0);
+	set_rcvtimeo(connection, PING_TIMEOUT);
+	set_bit(PING_TIMEOUT_ACTIVE, &connection->flags);
+	err = drbd_send_ping(connection);
+	if (err)
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+	kref_put(&connection->kref, drbd_destroy_connection);
 }
 
+struct meta_sock_cmd {
+	size_t pkt_size;
+	int (*fn)(struct drbd_connection *connection, struct packet_info *);
+};
+
 static struct meta_sock_cmd ack_receiver_tbl[] = {
-	[P_PING]	    = { 0, got_Ping },
-	[P_PING_ACK]	    = { 0, got_PingAck },
-	[P_RECV_ACK]	    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_WRITE_ACK]	    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_RS_WRITE_ACK]    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_SUPERSEDED]   = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_NEG_ACK]	    = { sizeof(struct p_block_ack), got_NegAck },
-	[P_NEG_DREPLY]	    = { sizeof(struct p_block_ack), got_NegDReply },
-	[P_NEG_RS_DREPLY]   = { sizeof(struct p_block_ack), got_NegRSDReply },
-	[P_OV_RESULT]	    = { sizeof(struct p_block_ack), got_OVResult },
-	[P_BARRIER_ACK]	    = { sizeof(struct p_barrier_ack), got_BarrierAck },
-	[P_STATE_CHG_REPLY] = { sizeof(struct p_req_state_reply), got_RqSReply },
-	[P_RS_IS_IN_SYNC]   = { sizeof(struct p_block_ack), got_IsInSync },
-	[P_DELAY_PROBE]     = { sizeof(struct p_delay_probe93), got_skip },
-	[P_RS_CANCEL]       = { sizeof(struct p_block_ack), got_NegRSDReply },
-	[P_CONN_ST_CHG_REPLY]={ sizeof(struct p_req_state_reply), got_conn_RqSReply },
-	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), got_BlockAck },
+	[P_PING]	      = { 0, got_Ping },
+	[P_PING_ACK]	      = { 0, got_PingAck },
+	[P_RECV_ACK]	      = { sizeof(struct p_block_ack), got_BlockAck },
+	[P_WRITE_ACK]	      = { sizeof(struct p_block_ack), got_BlockAck },
+	[P_WRITE_ACK_IN_SYNC] = { sizeof(struct p_block_ack), got_BlockAck },
+	[P_NEG_ACK]	      = { sizeof(struct p_block_ack), got_NegAck },
+	[P_NEG_DREPLY]	      = { sizeof(struct p_block_ack), got_NegDReply },
+	[P_NEG_RS_DREPLY]     = { sizeof(struct p_block_ack), got_NegRSDReply },
+	[P_RS_WRITE_ACK]      = { sizeof(struct p_block_ack), got_RSWriteAck },
+	[P_RS_NEG_ACK]	      = { sizeof(struct p_block_ack), got_RSWriteAck },
+	[P_OV_RESULT]	      = { sizeof(struct p_block_ack), got_OVResult },
+	[P_OV_RESULT_ID]      = { sizeof(struct p_ov_result), got_OVResult },
+	[P_BARRIER_ACK]	      = { sizeof(struct p_barrier_ack), got_BarrierAck },
+	[P_CONFIRM_STABLE]    = { sizeof(struct p_confirm_stable), got_confirm_stable },
+	[P_STATE_CHG_REPLY]   = { sizeof(struct p_req_state_reply), got_RqSReply },
+	[P_RS_IS_IN_SYNC]     = { sizeof(struct p_block_ack), got_IsInSync },
+	[P_DELAY_PROBE]	      = { sizeof(struct p_delay_probe93), got_skip },
+	[P_RS_CANCEL]	      = { sizeof(struct p_block_ack), got_NegRSDReply },
+	[P_RS_CANCEL_AHEAD]   = { sizeof(struct p_block_ack), got_NegRSDReply },
+	[P_CONN_ST_CHG_REPLY] = { sizeof(struct p_req_state_reply), got_RqSReply },
+	[P_PEER_ACK]	      = { sizeof(struct p_peer_ack), got_peer_ack },
+	[P_PEERS_IN_SYNC]     = { sizeof(struct p_peer_block_desc), got_peers_in_sync },
+	[P_TWOPC_YES]	      = { sizeof(struct p_twopc_reply), got_twopc_reply },
+	[P_TWOPC_NO]	      = { sizeof(struct p_twopc_reply), got_twopc_reply },
+	[P_TWOPC_RETRY]	      = { sizeof(struct p_twopc_reply), got_twopc_reply },
+	[P_FLUSH_FORWARD]     = { sizeof(struct p_flush_forward), got_flush_forward },
+	[P_RS_DAGTAG_REACHED]     = { sizeof(struct p_block_ack), got_RSDagtagReached },
+	[P_RS_DAGTAG_UNREACHABLE] = { sizeof(struct p_block_ack), got_RSDagtagUnreachable },
+	[P_RETRY_WRITE]	      = { sizeof(struct p_block_ack), got_RetryWrite },
 };
 
-int drbd_ack_receiver(struct drbd_thread *thi)
+static void fillup_buffer_from(struct drbd_mutable_buffer *to_fill, unsigned int need, struct drbd_const_buffer *pool)
 {
-	struct drbd_connection *connection = thi->connection;
-	struct meta_sock_cmd *cmd = NULL;
+	if (to_fill->avail < need) {
+		unsigned int missing = min(need - to_fill->avail, pool->avail);
+
+		memcpy(to_fill->buffer + to_fill->avail, pool->buffer, missing);
+		pool->buffer += missing;
+		pool->avail -= missing;
+		to_fill->avail += missing;
+	}
+}
+
+static int decode_meta_cmd(struct drbd_connection *connection, const u8 *pos, struct packet_info *pi)
+{
+	int header_version, payload_size;
+	struct meta_sock_cmd *cmd;
+
+	/*
+	 * A ping packet (via the control stream) can overtake the
+	 * feature packet. We might get it with a different header version
+	 * than expected since we will agree on the protocol version
+	 * by receiving the feature packet.
+	 */
+	header_version = __decode_header(pos, pi);
+	if (header_version < 0) {
+		drbd_err(connection, "Wrong magic value 0x%08x in protocol version %d [control]\n",
+			 be32_to_cpu(*(__be32 *)pos), header_version);
+		return -EINVAL;
+	}
+
+	if (pi->cmd >= ARRAY_SIZE(ack_receiver_tbl)) {
+		drbd_err(connection, "Unexpected meta packet %s (0x%04x)\n",
+			 drbd_packet_name(pi->cmd), pi->cmd);
+		return -ENOENT;
+	}
+
+	cmd = &ack_receiver_tbl[pi->cmd];
+	payload_size = cmd->pkt_size;
+	if (pi->size != payload_size) {
+		drbd_err(connection, "Wrong packet size on meta (c: %d, l: %d)\n",
+			 pi->cmd, pi->size);
+		return -EINVAL;
+	}
+
+	return payload_size;
+}
+
+static int process_previous_part(struct drbd_connection *connection, struct drbd_const_buffer *pool)
+{
+	struct drbd_mutable_buffer *buffer = &connection->reassemble_buffer;
+	int payload_size, packet_size;
+	unsigned int header_size;
 	struct packet_info pi;
-	unsigned long pre_recv_jif;
-	int rv;
-	void *buf    = connection->meta.rbuf;
-	int received = 0;
-	unsigned int header_size = drbd_header_size(connection);
-	int expect   = header_size;
-	bool ping_timeout_active = false;
+	int err;
+
+	fillup_buffer_from(buffer, sizeof(u32), pool);
+	if (buffer->avail < sizeof(u32))
+		return 0;
 
-	sched_set_fifo_low(current);
+	header_size = decode_header_size(buffer->buffer);
+	fillup_buffer_from(buffer, header_size, pool);
+	if (buffer->avail < header_size)
+		return 0;
 
-	while (get_t_state(thi) == RUNNING) {
-		drbd_thread_current_set_cpu(thi);
+	payload_size = decode_meta_cmd(connection, buffer->buffer, &pi);
+	if (payload_size < 0)
+		return payload_size;
 
-		if (test_and_clear_bit(SEND_PING, &connection->flags)) {
-			if (drbd_send_ping(connection)) {
-				drbd_err(connection, "drbd_send_ping has failed\n");
-				goto reconnect;
-			}
-			set_ping_timeout(connection);
-			ping_timeout_active = true;
-		}
-
-		pre_recv_jif = jiffies;
-		rv = drbd_recv_short(connection->meta.socket, buf, expect-received, 0);
-
-		/* Note:
-		 * -EINTR	 (on meta) we got a signal
-		 * -EAGAIN	 (on meta) rcvtimeo expired
-		 * -ECONNRESET	 other side closed the connection
-		 * -ERESTARTSYS  (on data) we got a signal
-		 * rv <  0	 other than above: unexpected error!
-		 * rv == expected: full header or command
-		 * rv <  expected: "woken" by signal during receive
-		 * rv == 0	 : "connection shut down by peer"
-		 */
-		if (likely(rv > 0)) {
-			received += rv;
-			buf	 += rv;
-		} else if (rv == 0) {
-			if (test_bit(DISCONNECT_SENT, &connection->flags)) {
-				long t;
-				rcu_read_lock();
-				t = rcu_dereference(connection->net_conf)->ping_timeo * HZ/10;
-				rcu_read_unlock();
-
-				t = wait_event_timeout(connection->ping_wait,
-						       connection->cstate < C_WF_REPORT_PARAMS,
-						       t);
-				if (t)
-					break;
-			}
-			drbd_err(connection, "meta connection shut down by peer.\n");
+	packet_size = header_size + payload_size;
+	fillup_buffer_from(buffer, packet_size, pool);
+	if (buffer->avail < packet_size)
+		return 0;
+
+	err = ack_receiver_tbl[pi.cmd].fn(connection, &pi);
+	connection->reassemble_buffer.avail = 0;
+	return err;
+}
+
+void drbd_control_data_ready(struct drbd_transport *transport, struct drbd_const_buffer *pool)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	unsigned int header_size;
+	int err;
+
+	if (connection->cstate[NOW] < C_TEAR_DOWN)
+		return;
+
+	if (connection->reassemble_buffer.avail) {
+		err = process_previous_part(connection, pool);
+		if (err < 0)
 			goto reconnect;
-		} else if (rv == -EAGAIN) {
-			/* If the data socket received something meanwhile,
-			 * that is good enough: peer is still alive. */
-			if (time_after(connection->last_received, pre_recv_jif))
-				continue;
-			if (ping_timeout_active) {
-				drbd_err(connection, "PingAck did not arrive in time.\n");
-				goto reconnect;
-			}
-			set_bit(SEND_PING, &connection->flags);
-			continue;
-		} else if (rv == -EINTR) {
-			/* maybe drbd_thread_stop(): the while condition will notice.
-			 * maybe woken for send_ping: we'll send a ping above,
-			 * and change the rcvtimeo */
-			flush_signals(current);
-			continue;
-		} else {
-			drbd_err(connection, "sock_recvmsg returned %d\n", rv);
+	}
+
+	while (pool->avail >= sizeof(u32)) {
+		int payload_size, packet_size;
+		struct packet_info pi;
+
+		header_size = decode_header_size(pool->buffer);
+		if (header_size > pool->avail)
+			goto keep_part;
+
+		payload_size = decode_meta_cmd(connection, pool->buffer, &pi);
+		if (payload_size < 0) {
+			err = payload_size;
 			goto reconnect;
 		}
 
-		if (received == expect && cmd == NULL) {
-			if (decode_header(connection, connection->meta.rbuf, &pi))
-				goto reconnect;
-			cmd = &ack_receiver_tbl[pi.cmd];
-			if (pi.cmd >= ARRAY_SIZE(ack_receiver_tbl) || !cmd->fn) {
-				drbd_err(connection, "Unexpected meta packet %s (0x%04x)\n",
-					 drbd_packet_name(pi.cmd), pi.cmd);
-				goto disconnect;
-			}
-			expect = header_size + cmd->pkt_size;
-			if (pi.size != expect - header_size) {
-				drbd_err(connection, "Wrong packet size on meta (c: %d, l: %d)\n",
-					pi.cmd, pi.size);
-				goto reconnect;
-			}
-		}
-		if (received == expect) {
-			bool err;
+		packet_size = header_size + payload_size;
+		if (packet_size > pool->avail)
+			goto keep_part;
 
-			err = cmd->fn(connection, &pi);
-			if (err) {
-				drbd_err(connection, "%ps failed\n", cmd->fn);
-				goto reconnect;
-			}
+		err = ack_receiver_tbl[pi.cmd].fn(connection, &pi);
+		if (err)
+			goto reconnect;
 
-			connection->last_received = jiffies;
+		pool->buffer += packet_size;
+		pool->avail -= packet_size;
+	}
+	if (pool->avail > 0) {
+keep_part:
+		memcpy(connection->reassemble_buffer.buffer, pool->buffer, pool->avail);
+		connection->reassemble_buffer.avail = pool->avail;
+		pool->avail = 0;
+	}
+	return;
 
-			if (cmd == &ack_receiver_tbl[P_PING_ACK]) {
-				set_idle_timeout(connection);
-				ping_timeout_active = false;
-			}
+reconnect:
+	change_cstate(connection, err == -EPROTO ? C_PROTOCOL_ERROR : C_NETWORK_FAILURE, CS_HARD);
+}
+EXPORT_SYMBOL(drbd_control_data_ready);
+
+void drbd_control_event(struct drbd_transport *transport, enum drbd_tr_event event)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
 
-			buf	 = connection->meta.rbuf;
-			received = 0;
-			expect	 = header_size;
-			cmd	 = NULL;
+	if (event == TIMEOUT) {
+		if (!test_bit(PING_TIMEOUT_ACTIVE, &connection->flags)) {
+			drbd_queue_ping(connection);
+			return;
+		} else {
+			if (connection->cstate[NOW] == C_CONNECTED)
+				drbd_warn(connection, "PingAck did not arrive in time.\n");
 		}
+	} else /* event == CLOSED_BY_PEER */ {
+		if (connection->cstate[NOW] == C_CONNECTED && disconnect_expected(connection))
+			return;
+		drbd_warn(connection, "meta connection shut down by peer.\n");
 	}
 
-	if (0) {
-reconnect:
-		conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
-		conn_md_sync(connection);
-	}
-	if (0) {
-disconnect:
-		conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-	}
+	change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+}
+EXPORT_SYMBOL(drbd_control_event);
 
-	drbd_info(connection, "ack_receiver terminated\n");
+static bool disconnect_expected(struct drbd_connection *connection)
+{
+	struct drbd_resource *resource = connection->resource;
+	bool expect_disconnect;
 
-	return 0;
+	/* We are reacting to a not-committed state change! The disconnect might
+	   get aborted. This is not a problem worth much more complex code.
+	   In the unlikely case, it happens that a two-phase-commit of a graceful
+	   disconnect gets aborted and the control connection breaks in exactly
+	   this time window, we will notice it as soon as sending something on the
+	   control stream. */
+	read_lock_irq(&resource->state_rwlock);
+	expect_disconnect = resource->remote_state_change &&
+		drbd_twopc_between_peer_and_me(connection) &&
+		resource->twopc_reply.is_disconnect;
+	read_unlock_irq(&resource->state_rwlock);
+	return expect_disconnect;
 }
 
 void drbd_send_acks_wf(struct work_struct *ws)
 {
-	struct drbd_peer_device *peer_device =
-		container_of(ws, struct drbd_peer_device, send_acks_work);
-	struct drbd_connection *connection = peer_device->connection;
-	struct drbd_device *device = peer_device->device;
-	struct net_conf *nc;
+	struct drbd_connection *connection =
+		container_of(ws, struct drbd_connection, send_acks_work);
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_net_conf *nc;
 	int tcp_cork, err;
 
 	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
+	nc = rcu_dereference(transport->net_conf);
 	tcp_cork = nc->tcp_cork;
 	rcu_read_unlock();
 
+	/* TODO: conditionally cork; it may hurt latency if we cork without
+	   much to send */
 	if (tcp_cork)
-		tcp_sock_set_cork(connection->meta.socket->sk, true);
+		drbd_cork(connection, CONTROL_STREAM);
+	err = drbd_finish_peer_reqs(connection);
 
-	err = drbd_finish_peer_reqs(device);
-	kref_put(&device->kref, drbd_destroy_device);
-	/* get is in drbd_endio_write_sec_final(). That is necessary to keep the
-	   struct work_struct send_acks_work alive, which is in the peer_device object */
+	/* but unconditionally uncork unless disabled */
+	if (err)
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
+	else if (tcp_cork)
+		drbd_uncork(connection, CONTROL_STREAM);
 
-	if (err) {
-		conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
-		return;
-	}
+}
 
-	if (tcp_cork)
-		tcp_sock_set_cork(connection->meta.socket->sk, false);
+void drbd_send_peer_ack_wf(struct work_struct *ws)
+{
+	struct drbd_connection *connection =
+		container_of(ws, struct drbd_connection, peer_ack_work);
 
-	return;
+	if (process_peer_ack_list(connection))
+		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);
 }
+
-- 
2.56.0

