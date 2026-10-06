Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCC30216D
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301698; cv=none; b=KF+/AT9pygiPeydbRxy0EWN/8dx6i2KQXf9NLR/j91gafKZ/twp0AWc8NmmOJ5SU39HZjqJNN7CYkc2o8maTBqbHgRg8fmBO4N8XSdKfDoGUfY+ns1Zmb0Bz2UGj1StIcBXzGeL5GPeNVPNccrGldp+Oqy3Pys8t5YfRQtq2SAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301698; c=relaxed/simple;
	bh=COkNWY0x8J2MAoXw6YS/uBu6QBvdaCbfAirLLbITB1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ+T6HPgPDlhbgMg1Q67MLwMHkaOrryCb96XozP2//B/sNJ1kA8u8VDxQ4qq7F/gyB4Xj6RMugu69QvNE2VZU3lzRI5Dm4iD/ZMshdx5kD4FOOjRhDWrar11ZMPLKq//amaGG79Fa143T7XR0uG+wpQHCpkGkZnHBJ5u7ZRRDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=ldP04fvi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="ldP04fvi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a168355946so8547325e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301625; x=1791906425; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2YY6ZNOkFfS9Ui+yu3MgYuwc3JBOmQhKwzmH/9beuIY=;
        b=ldP04fviiNIoTKKpNR7u41oajVe/Ki5c7T+rjJoKMqh+3hwWpEOO6GAg/Cr3XQ5AzZ
         jsBGOEn6iomopLrCy7zYuMuqzdC9y0V/O8fvZMySY4uEFVUkzcyvho/7DdxZBo4bgr/T
         ffYeJZuwQVVh1j9coq76iP51VM13CENgBysE2zL9jIWp+AXDYjialNqYroLVA89IrT3l
         F0BZqISLusmsNxl2L/x4JVgnCrgyr1CflHZPnLR7kaP0xDgBtl7PrcRyPyj4srYh0fKV
         cFLcmRPpWa2brJLmYjrmicLmPnU6WHyUp08HIHdPL61OLTSpf5I3oLNBwDBtQX4YM+7f
         /9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301625; x=1791906425;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YY6ZNOkFfS9Ui+yu3MgYuwc3JBOmQhKwzmH/9beuIY=;
        b=BgX7dUtEFONHFClkKNB3yDrgKvKAHIhnjP3z7DGFjI7yC9XOz4MQOSvVJ9n/QA5bhO
         a2iRUGBlGGlKHoU17i7WfUlp6zbcDyDu8BCJ27bBVZygvniOxGseoi4lee2o7wCXOwQO
         oiLVEh6FHqdqVi2HlHGmkUh0MJHiIlimJmos4VySBdAwtBm7VE/BP93XXKxAD6P9lZpd
         qqXugq6a2zxD4TbBu6LJmP7wntYhftplI63EsbJMiwEW8gNLM+YXiS6ZTgysQl7XDbBJ
         ME+Aizz6bzrOhUBhad9206Oejkurlb5lhP+MT9Fzmuaj9CaZXgfPOdF7Gddj5dXu/wBN
         xrSg==
X-Forwarded-Encrypted: i=1; AKwUvBwJMLoUEoUF2lmbmvi0A8Fdj+Y9usDLBXwr0TNSOX95a5xhH28/Uekqatn/3GS6Qs14TKIOFXW/Yw==@lists.linux.dev
X-Gm-Message-State: AFuF++kPpedlWytjk82XLMJyGWcc32v+vIhDpZIUnk0YU6FUmDllXF7r
	NKkEXZMhXRMMRiyadOQe46s5ZAh++hDyvLX9ikH4Mo9bR6E4a6B5MYaxP8pVXQh2TEs=
X-Gm-Gg: AYBFou0ynC9QvP7dzWujXvh+XK4fSFiMpPBr3Pm8rZlfs9+u6AR/MAE+HFtsLeLnjMB
	FhGULj2wiNDfbMuhm+14hmXWW1ndR8xEXzQ40U2hJvu3U30P2c+xNE9FaFY82VJCswuAb44k3Mj
	OPadkm82bIk8nfh4K212kowWRoG6DoleLWZtNQxaDckzq1U1Ej4c73nBkxPfYCulEVxM3mXV7ew
	NBDpnGixABPYtvTjLx+Zh0Le5gDnlj93JruFUcsPyZ4Hb9kbjYhuoV9EKi14lS/MSCXOPABGsmh
	OaQBE73lR4dOY0eJ7G8LbGkS9lPh2XTouMv68b8jrCMVCl+FaHiuRW84KE/gUUq44XinLC25HNI
	VivH85DJfAw13n+COhVuHULnxYenws3sxtrRmEYGA17eKLsVvcywBhm7ok2nSMuQUy2QWy5Gr+D
	3wnvIu50zW4zarYLG2fejN4TrVehDskTsz2boVX4Zyhx6YCRr05hrgN+7TkjVeYRxpRBfQpFLub
	FHUxYnVqg2w+ORO2Uor2AOxg/0cTSO1oA==
X-Received: by 2002:a05:600c:34d5:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a17b55b28bmr31995615e9.26.1791301622443;
        Tue, 06 Oct 2026 08:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:47:01 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>,
	=?UTF-8?q?Moritz=20Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [PATCH v2 16/20] drbd: rework the netlink core for DRBD 9
Date: Tue,  6 Oct 2026 17:46:03 +0200
Message-ID: <20261006154607.3936501-17-christoph.boehmwalder@linbit.com>
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

Rework the generic netlink administration core to DRBD 9's multi-peer
topology model, and detach it from any one wire format: drbd_nl.c
works on the neutral config, info and statistics structs declared in
drbd_nl_types.h and asks a struct drbd_nl_dialect for everything that
touches the wire (parsing attributes into those structs, emitting
dump entries and notifications, reporting outcomes). The dialects
follow in the next two commits; this one is the core they plug into.

Connections are identified by peer node ID rather than address pairs,
and the admin API gains operations for creating and removing peer
connections and managing network paths within each connection. Add
per-peer-device configuration, metadata slot reclamation and resource
renaming as new administrative commands.

Lift role promotion to resource scope and use quorum-aware logic with
auto-promote timeout, replacing the per-device state machine. Disk
attach and detach gain support for per-peer bitmap slot allocation,
DAX/PMEM-backed metadata and variable bitmap block sizes. Resize and
other multi-peer operations use the new transactional state change
API to coordinate across all peers atomically.

Administrative commands now additionally require CAP_SYS_ADMIN on top
of the CAP_NET_ADMIN that generic netlink already enforces for
GENL_ADMIN_PERM commands, and the global genl_lock() serialization is
replaced by parallel_ops with fine-grained locking. Notifications
cover path-level state and detailed per-peer resync progress.

The default-value setters for the neutral structs are generated into
drbd_nl_defaults.c so that every dialect links them. drbd.h and
drbd_limits.h in the UAPI gain the DRBD 9 constants and limits; the
existing "drbd" family header, drbd_genl.h, is left exactly as it is,
because that family keeps serving version 1.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
Co-developed-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile           |    1 +
 drivers/block/drbd/drbd_nl.c          | 9477 ++++++++++++++++---------
 drivers/block/drbd/drbd_nl.h          |  390 +
 drivers/block/drbd/drbd_nl_defaults.c |  167 +
 drivers/block/drbd/drbd_nl_types.h    |  388 +
 include/uapi/linux/drbd.h             |  299 +-
 include/uapi/linux/drbd_limits.h      |  135 +-
 7 files changed, 7519 insertions(+), 3338 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_nl.h
 create mode 100644 drivers/block/drbd/drbd_nl_defaults.c
 create mode 100644 drivers/block/drbd/drbd_nl_types.h

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index f184b99d6a93..f430536636c2 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -4,6 +4,7 @@ drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
+drbd-y += drbd_nl_defaults.o
 drbd-y += drbd_transport.o
 drbd-$(CONFIG_DEV_DAX_PMEM) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index aa7aae9003be..2d5058356c19 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -14,555 +14,634 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/slab.h>
-#include <linux/blkpg.h>
 #include <linux/cpumask.h>
+#include <linux/random.h>
 #include "drbd_int.h"
 #include "drbd_protocol.h"
-#include "drbd_req.h"
 #include "drbd_state_change.h"
-#include <linux/unaligned.h>
+#include "drbd_debugfs.h"
+#include "drbd_transport.h"
+#include "drbd_dax_pmem.h"
 #include <linux/drbd_limits.h>
 #include <linux/kthread.h>
+#include <linux/security.h>
+#include <linux/netlink.h>
+#include <net/net_namespace.h>
 
-#include <net/genetlink.h>
+#include "drbd_meta_data.h"
+#include "drbd_legacy_84.h"
 
-#include "drbd_nl_gen.h"
-
-static int drbd_genl_multicast_events(struct sk_buff *skb, gfp_t flags)
-{
-	return genlmsg_multicast(&drbd_nl_family, skb, 0,
-				 DRBD_NLGRP_EVENTS, flags);
-}
-
-static atomic_t drbd_genl_seq = ATOMIC_INIT(2); /* two. */
-static atomic_t notify_genl_seq = ATOMIC_INIT(2); /* two. */
+atomic_t drbd_genl_seq = ATOMIC_INIT(2); /* two. */
 
 DEFINE_MUTEX(notification_mutex);
 
 /* used bdev_open_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
-static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
-{
-	genlmsg_end(skb, genlmsg_data(nlmsg_data(nlmsg_hdr(skb))));
-	if (genlmsg_reply(skb, info))
-		pr_err("error sending genl reply\n");
-}
-
-/* Used on a fresh "drbd_adm_prepare"d reply_skb, this cannot fail: The only
- * reason it could fail was no space in skb, and there are 4k available. */
-static int drbd_msg_put_info(struct sk_buff *skb, const char *info)
-{
-	struct nlattr *nla;
-	int err = -EMSGSIZE;
-
-	if (!info || !info[0])
-		return 0;
-
-	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_REPLY);
-	if (!nla)
-		return err;
-
-	err = nla_put_string(skb, DRBD_A_DRBD_CFG_REPLY_INFO_TEXT, info);
-	if (err) {
-		nla_nest_cancel(skb, nla);
-		return err;
-	} else
-		nla_nest_end(skb, nla);
-	return 0;
-}
-
 __printf(2, 3)
-static int drbd_msg_sprintf_info(struct sk_buff *skb, const char *fmt, ...)
+void drbd_adm_msg(struct drbd_adm_ctx *ctx, const char *fmt, ...)
 {
+	unsigned int room = sizeof(ctx->msg) - ctx->msg_len;
 	va_list args;
-	struct nlattr *nla, *txt;
-	int err = -EMSGSIZE;
 	int len;
 
-	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_REPLY);
-	if (!nla)
-		return err;
-
-	txt = nla_reserve(skb, DRBD_A_DRBD_CFG_REPLY_INFO_TEXT, 256);
-	if (!txt) {
-		nla_nest_cancel(skb, nla);
-		return err;
-	}
+	/* not even room for an empty string plus its NUL */
+	if (room < 2)
+		return;
 	va_start(args, fmt);
-	len = vscnprintf(nla_data(txt), 256, fmt, args);
+	len = vsnprintf(ctx->msg + ctx->msg_len,
+			min_t(unsigned int, room, DRBD_ADM_MSG_MAX), fmt, args);
 	va_end(args);
+	/* empty text is ignored, as the legacy drbd_msg_put_info did */
+	if (len <= 0)
+		return;
+	/* per-message cap, as the legacy 256-byte reserve */
+	if (len >= DRBD_ADM_MSG_MAX)
+		len = DRBD_ADM_MSG_MAX - 1;
+	if (len + 1 > (int)room) {
+		/*
+		 * Does not fit into what is left of the buffer: drop the
+		 * whole message, just like the -EMSGSIZE of an over-full
+		 * reply skb dropped it before.
+		 */
+		ctx->msg[ctx->msg_len] = '\0';
+		return;
+	}
+	ctx->msg_len += len + 1;
+}
 
-	/* maybe: retry with larger reserve, if truncated */
-	txt->nla_len = nla_attr_size(len+1);
-	nlmsg_trim(skb, (char*)txt + NLA_ALIGN(txt->nla_len));
-	nla_nest_end(skb, nla);
+static struct drbd_path *first_path(struct drbd_connection *connection)
+{
+	/* Ideally this function is removed at a later point in time.
+	   It was introduced when replacing the single address pair
+	   with a list of address pairs (or paths). */
 
-	return 0;
+	return list_first_or_null_rcu(&connection->transport.paths, struct drbd_path, list);
 }
 
-/* Flags for drbd_adm_prepare() */
-#define DRBD_ADM_NEED_MINOR	 (1 << 0)
-#define DRBD_ADM_NEED_RESOURCE	 (1 << 1)
-#define DRBD_ADM_NEED_CONNECTION (1 << 2)
-
-/* Per-command flags for drbd_pre_doit() */
-static const unsigned int drbd_genl_cmd_flags[] = {
-	[DRBD_ADM_GET_STATUS]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_NEW_MINOR]      = DRBD_ADM_NEED_RESOURCE,
-	[DRBD_ADM_DEL_MINOR]      = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_NEW_RESOURCE]   = 0,
-	[DRBD_ADM_DEL_RESOURCE]   = DRBD_ADM_NEED_RESOURCE,
-	[DRBD_ADM_RESOURCE_OPTS]  = DRBD_ADM_NEED_RESOURCE,
-	[DRBD_ADM_CONNECT]        = DRBD_ADM_NEED_RESOURCE,
-	[DRBD_ADM_CHG_NET_OPTS]   = DRBD_ADM_NEED_CONNECTION,
-	[DRBD_ADM_DISCONNECT]     = DRBD_ADM_NEED_CONNECTION,
-	[DRBD_ADM_ATTACH]         = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_CHG_DISK_OPTS]  = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_RESIZE]         = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_PRIMARY]        = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_SECONDARY]      = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_NEW_C_UUID]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_START_OV]       = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_DETACH]         = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_INVALIDATE]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_INVAL_PEER]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_PAUSE_SYNC]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_RESUME_SYNC]    = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_SUSPEND_IO]     = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_RESUME_IO]      = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_OUTDATE]        = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_GET_TIMEOUT_TYPE] = DRBD_ADM_NEED_MINOR,
-	[DRBD_ADM_DOWN]           = DRBD_ADM_NEED_RESOURCE,
-};
+/*
+ * The netlink dialects this module serves. Registered at module init
+ * and never removed afterwards, so no locking is needed to walk them.
+ */
+static const struct drbd_nl_dialect *drbd_nl_dialects[4];
+static unsigned int drbd_nl_n_dialects;
 
-/* Detect attempts to change invariant attributes in a _change_ handler. */
-#define has_invariant(ntb, attr)						\
-({									\
-	bool __found = !!(ntb)[attr];					\
-	if (__found)							\
-		pr_info("must not change invariant attr: %s\n", #attr);	\
-	__found;							\
-})
+int drbd_nl_register_dialect(const struct drbd_nl_dialect *dialect)
+{
+	if (drbd_nl_n_dialects >= ARRAY_SIZE(drbd_nl_dialects))
+		return -ENOSPC;
+	drbd_nl_dialects[drbd_nl_n_dialects++] = dialect;
+	return 0;
+}
 
 /*
- * At this point, we still rely on the global genl_lock().
- * If we want to avoid that, and allow "genl_family.parallel_ops", we may need
- * to add additional synchronization against object destruction/modification.
+ * Resolve the objects the command refers to. On success the members of
+ * adm_ctx are valid and NO_ERROR is returned; otherwise the failure is
+ * also recorded in adm_ctx->result.
  */
-static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
-	struct sk_buff *skb, struct genl_info *info, unsigned flags)
+int drbd_adm_ctx_resolve(struct drbd_adm_ctx *adm_ctx, unsigned int flags)
 {
-	struct drbd_genlmsghdr *d_in = genl_info_userhdr(info);
-	const u8 cmd = info->genlhdr->cmd;
 	int err;
 
-	/* genl_rcv_msg only checks for CAP_NET_ADMIN on "GENL_ADMIN_PERM" :( */
-	if (cmd != DRBD_ADM_GET_STATUS && !capable(CAP_NET_ADMIN))
-	       return -EPERM;
-
-	adm_ctx->reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!adm_ctx->reply_skb) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	adm_ctx->reply_dh = genlmsg_put_reply(adm_ctx->reply_skb,
-					info, &drbd_nl_family, 0, cmd);
-	/* put of a few bytes into a fresh skb of >= 4k will always succeed.
-	 * but anyways */
-	if (!adm_ctx->reply_dh) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	adm_ctx->reply_dh->minor = d_in->minor;
-	adm_ctx->reply_dh->ret_code = NO_ERROR;
-
-	adm_ctx->volume = VOLUME_UNSPECIFIED;
-	if (info->attrs[DRBD_NLA_CFG_CONTEXT]) {
-		struct nlattr **ntb;
-		struct nlattr *nla;
-
-		/* parse and validate, get nested attribute table */
-		err = drbd_cfg_context_ntb_from_attrs(&ntb, info);
-		if (err)
-			goto fail;
-
-		/* It was present, and valid,
-		 * copy it over to the reply skb. */
-		err = nla_put_nohdr(adm_ctx->reply_skb,
-				info->attrs[DRBD_NLA_CFG_CONTEXT]->nla_len,
-				info->attrs[DRBD_NLA_CFG_CONTEXT]);
-		if (err) {
-			kfree(ntb);
-			goto fail;
-		}
+	if (flags & DRBD_ADM_NEED_PEER_DEVICE)
+		flags |= DRBD_ADM_NEED_CONNECTION;
+	if (flags & DRBD_ADM_NEED_CONNECTION)
+		flags |= DRBD_ADM_NEED_PEER_NODE;
+	if (flags & DRBD_ADM_NEED_PEER_NODE)
+		flags |= DRBD_ADM_NEED_RESOURCE;
 
-		/* and assign stuff to the adm_ctx */
-		nla = ntb[DRBD_A_DRBD_CFG_CONTEXT_CTX_VOLUME];
-		if (nla)
-			adm_ctx->volume = nla_get_u32(nla);
-		nla = ntb[DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME];
-		if (nla)
-			adm_ctx->resource_name = nla_data(nla);
-		adm_ctx->my_addr = ntb[DRBD_A_DRBD_CFG_CONTEXT_CTX_MY_ADDR];
-		adm_ctx->peer_addr = ntb[DRBD_A_DRBD_CFG_CONTEXT_CTX_PEER_ADDR];
-		kfree(ntb);
-		if ((adm_ctx->my_addr &&
-		     nla_len(adm_ctx->my_addr) > sizeof(adm_ctx->connection->my_addr)) ||
-		    (adm_ctx->peer_addr &&
-		     nla_len(adm_ctx->peer_addr) > sizeof(adm_ctx->connection->peer_addr))) {
-			err = -EINVAL;
-			goto fail;
-		}
+	if (adm_ctx->resource_name) {
+		adm_ctx->resource = drbd_find_resource(adm_ctx->resource_name);
 	}
 
-	adm_ctx->minor = d_in->minor;
-	adm_ctx->device = minor_to_device(d_in->minor);
-
-	/* We are protected by the global genl_lock().
-	 * But we may explicitly drop it/retake it in drbd_nl_set_role(),
-	 * so make sure this object stays around. */
-	if (adm_ctx->device)
+	rcu_read_lock();
+	adm_ctx->device = minor_to_device(adm_ctx->minor);
+	if (adm_ctx->device) {
 		kref_get(&adm_ctx->device->kref);
-
-	if (adm_ctx->resource_name) {
-		adm_ctx->resource = drbd_find_resource(adm_ctx->resource_name);
 	}
+	rcu_read_unlock();
 
 	if (!adm_ctx->device && (flags & DRBD_ADM_NEED_MINOR)) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "unknown minor");
-		return ERR_MINOR_INVALID;
+		drbd_adm_msg(adm_ctx, "%s", "unknown minor");
+		err = ERR_MINOR_INVALID;
+		goto finish;
 	}
 	if (!adm_ctx->resource && (flags & DRBD_ADM_NEED_RESOURCE)) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "unknown resource");
+		drbd_adm_msg(adm_ctx, "%s", "unknown resource");
+		err = ERR_INVALID_REQUEST;
 		if (adm_ctx->resource_name)
-			return ERR_RES_NOT_KNOWN;
-		return ERR_INVALID_REQUEST;
+			err = ERR_RES_NOT_KNOWN;
+		goto finish;
 	}
-
-	if (flags & DRBD_ADM_NEED_CONNECTION) {
-		if (adm_ctx->resource) {
-			drbd_msg_put_info(adm_ctx->reply_skb, "no resource name expected");
-			return ERR_INVALID_REQUEST;
+	if (adm_ctx->peer_node_id != PEER_NODE_ID_UNSPECIFIED) {
+		/* peer_node_id is unsigned int */
+		if (adm_ctx->peer_node_id >= DRBD_NODE_ID_MAX) {
+			drbd_adm_msg(adm_ctx, "%s", "peer node id out of range");
+			err = ERR_INVALID_REQUEST;
+			goto finish;
 		}
-		if (adm_ctx->device) {
-			drbd_msg_put_info(adm_ctx->reply_skb, "no minor number expected");
-			return ERR_INVALID_REQUEST;
+		if (!adm_ctx->resource) {
+			drbd_adm_msg(adm_ctx, "%s", "peer node id given without a resource");
+			err = ERR_INVALID_REQUEST;
+			goto finish;
 		}
-		if (adm_ctx->my_addr && adm_ctx->peer_addr)
-			adm_ctx->connection = conn_get_by_addrs(nla_data(adm_ctx->my_addr),
-							  nla_len(adm_ctx->my_addr),
-							  nla_data(adm_ctx->peer_addr),
-							  nla_len(adm_ctx->peer_addr));
+		if (adm_ctx->peer_node_id == adm_ctx->resource->res_opts.node_id) {
+			drbd_adm_msg(adm_ctx, "%s", "peer node id cannot be my own node id");
+			err = ERR_INVALID_REQUEST;
+			goto finish;
+		}
+		adm_ctx->connection = drbd_get_connection_by_node_id(adm_ctx->resource, adm_ctx->peer_node_id);
+	} else if (flags & DRBD_ADM_NEED_PEER_NODE) {
+		drbd_adm_msg(adm_ctx, "%s", "peer node id missing");
+		err = ERR_INVALID_REQUEST;
+		goto finish;
+	}
+	if (flags & DRBD_ADM_NEED_CONNECTION) {
 		if (!adm_ctx->connection) {
-			drbd_msg_put_info(adm_ctx->reply_skb, "unknown connection");
-			return ERR_INVALID_REQUEST;
+			drbd_adm_msg(adm_ctx, "%s", "unknown connection");
+			err = ERR_INVALID_REQUEST;
+			goto finish;
+		}
+	}
+	if (flags & DRBD_ADM_NEED_PEER_DEVICE) {
+		rcu_read_lock();
+		if (adm_ctx->volume != VOLUME_UNSPECIFIED)
+			adm_ctx->peer_device =
+				idr_find(&adm_ctx->connection->peer_devices,
+					 adm_ctx->volume);
+		if (!adm_ctx->peer_device) {
+			drbd_adm_msg(adm_ctx, "%s", "unknown volume");
+			err = ERR_INVALID_REQUEST;
+			rcu_read_unlock();
+			goto finish;
+		}
+		if (!adm_ctx->device) {
+			adm_ctx->device = adm_ctx->peer_device->device;
+			kref_get(&adm_ctx->device->kref);
 		}
+		rcu_read_unlock();
 	}
 
 	/* some more paranoia, if the request was over-determined */
 	if (adm_ctx->device && adm_ctx->resource &&
 	    adm_ctx->device->resource != adm_ctx->resource) {
 		pr_warn("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
-			adm_ctx->minor, adm_ctx->resource->name,
-			adm_ctx->device->resource->name);
-		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists in different resource");
-		return ERR_INVALID_REQUEST;
+				adm_ctx->minor, adm_ctx->resource->name,
+				adm_ctx->device->resource->name);
+		drbd_adm_msg(adm_ctx, "%s", "minor exists in different resource");
+		err = ERR_INVALID_REQUEST;
+		goto finish;
 	}
 	if (adm_ctx->device &&
 	    adm_ctx->volume != VOLUME_UNSPECIFIED &&
 	    adm_ctx->volume != adm_ctx->device->vnr) {
 		pr_warn("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
-			adm_ctx->minor, adm_ctx->volume,
-			adm_ctx->device->vnr, adm_ctx->device->resource->name);
-		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists as different volume");
-		return ERR_INVALID_REQUEST;
+				adm_ctx->minor, adm_ctx->volume,
+				adm_ctx->device->vnr,
+				adm_ctx->device->resource->name);
+		drbd_adm_msg(adm_ctx, "%s", "minor exists as different volume");
+		err = ERR_INVALID_REQUEST;
+		goto finish;
+	}
+	if (adm_ctx->device && adm_ctx->peer_device &&
+	    adm_ctx->resource && adm_ctx->resource->name &&
+	    adm_ctx->peer_device->device != adm_ctx->device) {
+		drbd_adm_msg(adm_ctx, "%s", "peer_device->device != device");
+		pr_warn("request: minor=%u, resource=%s, volume=%u, peer_node=%u; device != peer_device->device\n",
+				adm_ctx->minor, adm_ctx->resource->name,
+				adm_ctx->device->vnr, adm_ctx->peer_node_id);
+		err = ERR_INVALID_REQUEST;
+		goto finish;
 	}
 
 	/* still, provide adm_ctx->resource always, if possible. */
 	if (!adm_ctx->resource) {
 		adm_ctx->resource = adm_ctx->device ? adm_ctx->device->resource
 			: adm_ctx->connection ? adm_ctx->connection->resource : NULL;
-		if (adm_ctx->resource)
+		if (adm_ctx->resource) {
 			kref_get(&adm_ctx->resource->kref);
+		}
 	}
-
 	return NO_ERROR;
 
-fail:
-	nlmsg_free(adm_ctx->reply_skb);
-	adm_ctx->reply_skb = NULL;
+finish:
+	adm_ctx->result = err;
 	return err;
 }
 
-int drbd_pre_doit(const struct genl_split_ops *ops,
-		  struct sk_buff *skb, struct genl_info *info)
+/* Drop the references drbd_adm_ctx_resolve() acquired. */
+void drbd_adm_ctx_release(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx;
-	u8 cmd = info->genlhdr->cmd;
-	unsigned int flags;
-	int err;
+	if (adm_ctx->device) {
+		kref_put(&adm_ctx->device->kref, drbd_destroy_device);
+	}
+	if (adm_ctx->connection) {
+		kref_put(&adm_ctx->connection->kref, drbd_destroy_connection);
+	}
+	if (adm_ctx->resource) {
+		kref_put(&adm_ctx->resource->kref, drbd_destroy_resource);
+	}
+}
 
-	adm_ctx = kzalloc_obj(*adm_ctx);
-	if (!adm_ctx)
-		return -ENOMEM;
+static void conn_md_sync(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
 
-	flags = (cmd < ARRAY_SIZE(drbd_genl_cmd_flags))
-		? drbd_genl_cmd_flags[cmd] : 0;
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
 
-	err = drbd_adm_prepare(adm_ctx, skb, info, flags);
-	if (err && !adm_ctx->reply_skb) {
-		/* Fatal error before reply_skb was allocated. */
-		kfree(adm_ctx);
-		return err;
+		kref_get(&device->kref);
+		rcu_read_unlock();
+		drbd_md_sync_if_dirty(device);
+		kref_put(&device->kref, drbd_destroy_device);
+		rcu_read_lock();
 	}
-	if (err)
-		adm_ctx->reply_dh->ret_code = err;
-
-	info->user_ptr[0] = adm_ctx;
-	return 0;
+	rcu_read_unlock();
 }
 
-void drbd_post_doit(const struct genl_split_ops *ops,
-		    struct sk_buff *skb, struct genl_info *info)
+/* Try to figure out where we are happy to become primary.
+   This is unsed by the crm-fence-peer mechanism
+*/
+static u64 up_to_date_nodes(struct drbd_device *device, bool op_is_fence)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
+	struct drbd_resource *resource = device->resource;
+	const int my_node_id = resource->res_opts.node_id;
+	u64 mask = NODE_MASK(my_node_id);
 
-	if (!adm_ctx)
-		return;
+	if (resource->role[NOW] == R_PRIMARY || op_is_fence) {
+		struct drbd_peer_device *peer_device;
 
-	if (adm_ctx->reply_skb)
-		drbd_adm_send_reply(adm_ctx->reply_skb, info);
+		rcu_read_lock();
+		for_each_peer_device_rcu(peer_device, device) {
+			enum drbd_disk_state pdsk = peer_device->disk_state[NOW];
 
-	if (adm_ctx->device) {
-		kref_put(&adm_ctx->device->kref, drbd_destroy_device);
-		adm_ctx->device = NULL;
-	}
-	if (adm_ctx->connection) {
-		kref_put(&adm_ctx->connection->kref, &drbd_destroy_connection);
-		adm_ctx->connection = NULL;
-	}
-	if (adm_ctx->resource) {
-		kref_put(&adm_ctx->resource->kref, drbd_destroy_resource);
-		adm_ctx->resource = NULL;
+			if (pdsk == D_UP_TO_DATE)
+				mask |= NODE_MASK(peer_device->node_id);
+		}
+		rcu_read_unlock();
+	} else if (device->disk_state[NOW] == D_UP_TO_DATE) {
+		struct drbd_peer_md *peer_md = device->ldev->md.peers;
+		int node_id;
+
+		for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+			struct drbd_peer_device *peer_device;
+
+			if (node_id == my_node_id)
+				continue;
+
+			peer_device = peer_device_by_node_id(device, node_id);
+
+			if ((peer_device && peer_device->disk_state[NOW] == D_UP_TO_DATE) ||
+			    (test_bit(__MDF_NODE_EXISTS, &peer_md[node_id].flags) &&
+			     peer_md[node_id].bitmap_uuid == 0))
+				mask |= NODE_MASK(node_id);
+		}
+	} else {
+		mask = 0;
 	}
 
-	kfree(adm_ctx);
+	return mask;
 }
 
-static void setup_khelper_env(struct drbd_connection *connection, char **envp)
+/* Buffer to construct the environment of a user-space helper in. */
+struct env {
+	char *buffer;
+	int size, pos;
+};
+
+/* Print into an env buffer. */
+static __printf(2, 3) int env_print(struct env *env, const char *fmt, ...)
 {
-	char *afs;
+	va_list args;
+	int pos, ret;
 
-	/* FIXME: A future version will not allow this case. */
-	if (connection->my_addr_len == 0 || connection->peer_addr_len == 0)
-		return;
+	pos = env->pos;
+	if (pos < 0)
+		return pos;
+	va_start(args, fmt);
+	ret = vsnprintf(env->buffer + pos, env->size - pos, fmt, args);
+	va_end(args);
+	if (ret < 0) {
+		env->pos = ret;
+		goto out;
+	}
+	if (ret >= env->size - pos) {
+		ret = env->pos = -ENOMEM;
+		goto out;
+	}
+	env->pos += ret + 1;
+out:
+	return ret;
+}
+
+/* Put env variables for an address into an env buffer. */
+static void env_print_address(struct env *env, const char *prefix,
+			      struct sockaddr_storage *storage)
+{
+	const char *afs;
 
-	switch (((struct sockaddr *)&connection->peer_addr)->sa_family) {
+	switch (storage->ss_family) {
 	case AF_INET6:
 		afs = "ipv6";
-		snprintf(envp[4], 60, "DRBD_PEER_ADDRESS=%pI6",
-			 &((struct sockaddr_in6 *)&connection->peer_addr)->sin6_addr);
+		env_print(env, "%sADDRESS=%pI6", prefix,
+			  &((struct sockaddr_in6 *)storage)->sin6_addr);
 		break;
 	case AF_INET:
 		afs = "ipv4";
-		snprintf(envp[4], 60, "DRBD_PEER_ADDRESS=%pI4",
-			 &((struct sockaddr_in *)&connection->peer_addr)->sin_addr);
+		env_print(env, "%sADDRESS=%pI4", prefix,
+			  &((struct sockaddr_in *)storage)->sin_addr);
 		break;
 	default:
 		afs = "ssocks";
-		snprintf(envp[4], 60, "DRBD_PEER_ADDRESS=%pI4",
-			 &((struct sockaddr_in *)&connection->peer_addr)->sin_addr);
+		env_print(env, "%sADDRESS=%pI4", prefix,
+			  &((struct sockaddr_in *)storage)->sin_addr);
 	}
-	snprintf(envp[3], 20, "DRBD_PEER_AF=%s", afs);
+	env_print(env, "%sAF=%s", prefix, afs);
+}
+
+/* Construct char **envp inside an env buffer. */
+static char **make_envp(struct env *env)
+{
+	char **envp, *b;
+	unsigned int n;
+
+	if (env->pos < 0)
+		return NULL;
+	if (env->pos >= env->size)
+		goto out_nomem;
+	env->buffer[env->pos++] = 0;
+	for (b = env->buffer, n = 1; *b; n++)
+		b = strchr(b, 0) + 1;
+	if (env->size - env->pos < sizeof(envp) * n)
+		goto out_nomem;
+	envp = (char **)(env->buffer + env->size) - n;
+
+	for (b = env->buffer; *b; ) {
+		*envp++ = b;
+		b = strchr(b, 0) + 1;
+	}
+	*envp++ = NULL;
+	return envp - n;
+
+out_nomem:
+	env->pos = -ENOMEM;
+	return NULL;
 }
 
-int drbd_khelper(struct drbd_device *device, char *cmd)
+/* Macro refers to local variables peer_device, device and connection! */
+#define magic_printk(level, fmt, args...)				\
+	do {								\
+		if (peer_device)					\
+			drbd_printk(NOLIMIT, level, peer_device, fmt, args);	\
+		else if (device)					\
+			drbd_printk(NOLIMIT, level, device, fmt, args);	\
+		else							\
+			drbd_printk(NOLIMIT, level, connection, fmt, args);	\
+	} while (0)
+
+static int drbd_khelper(struct drbd_device *device, struct drbd_connection *connection, char *cmd)
 {
-	char *envp[] = { "HOME=/",
-			"TERM=linux",
-			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
-			 (char[20]) { }, /* address family */
-			 (char[60]) { }, /* address */
-			NULL };
-	char mb[14];
-	char *argv[] = {drbd_usermode_helper, cmd, mb, NULL };
-	struct drbd_connection *connection = first_peer_device(device)->connection;
-	struct sib_info sib;
+	struct drbd_resource *resource = device ? device->resource : connection->resource;
+	char *argv[] = { drbd_usermode_helper, cmd, resource->name, NULL };
+	struct drbd_peer_device *peer_device = NULL;
+	struct env env = { .size = PAGE_SIZE };
+	char **envp;
 	int ret;
 
-	if (current == connection->worker.task)
-		set_bit(CALLBACK_PENDING, &connection->flags);
+enlarge_buffer:
+	env.buffer = (char *)__get_free_pages(GFP_NOIO, get_order(env.size));
+	if (!env.buffer) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+	env.pos = 0;
+
+	rcu_read_lock();
+	env_print(&env, "HOME=/");
+	env_print(&env, "TERM=linux");
+	env_print(&env, "PATH=/sbin:/usr/sbin:/bin:/usr/bin");
+	if (device) {
+		env_print(&env, "DRBD_MINOR=%u", device->minor);
+		env_print(&env, "DRBD_VOLUME=%u", device->vnr);
+		if (get_ldev(device)) {
+			struct drbd_disk_conf *disk_conf =
+				rcu_dereference(device->ldev->disk_conf);
+			env_print(&env, "DRBD_BACKING_DEV=%s",
+				  disk_conf->backing_dev);
+			put_ldev(device);
+		}
+	}
+	if (connection) {
+		struct drbd_path *path;
+
+		rcu_read_lock();
+		path = first_path(connection);
+		if (path) {
+			/* TO BE DELETED */
+			env_print_address(&env, "DRBD_MY_", &path->my_addr);
+			env_print_address(&env, "DRBD_PEER_", &path->peer_addr);
+		}
+		rcu_read_unlock();
+
+		env_print(&env, "DRBD_PEER_NODE_ID=%u", connection->peer_node_id);
+		env_print(&env, "DRBD_CSTATE=%s", drbd_conn_str(connection->cstate[NOW]));
+	}
+	if (connection && !device) {
+		struct drbd_peer_device *peer_device;
+		int vnr;
+
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			struct drbd_device *device = peer_device->device;
+
+			env_print(&env, "DRBD_MINOR_%u=%u",
+				  vnr, peer_device->device->minor);
+			if (get_ldev(device)) {
+				struct drbd_disk_conf *disk_conf =
+					rcu_dereference(device->ldev->disk_conf);
+				env_print(&env, "DRBD_BACKING_DEV_%u=%s",
+					  vnr, disk_conf->backing_dev);
+				put_ldev(device);
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	if (strstr(cmd, "fence")) {
+		bool op_is_fence = strcmp(cmd, "fence-peer") == 0;
+		struct drbd_peer_device *peer_device;
+		u64 mask = -1ULL;
+		int vnr;
+
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			struct drbd_device *device = peer_device->device;
+
+			if (get_ldev(device)) {
+				u64 m = up_to_date_nodes(device, op_is_fence);
+
+				if (m)
+					mask &= m;
+				put_ldev(device);
+				/* Yes we outright ignore volumes that are not up-to-date
+				   on a single node. */
+			}
+		}
+		env_print(&env, "UP_TO_DATE_NODES=0x%08llX", mask);
+	}
+
+	envp = make_envp(&env);
+	if (!envp) {
+		if (env.pos == -ENOMEM) {
+			free_pages((unsigned long)env.buffer, get_order(env.size));
+			env.size += PAGE_SIZE;
+			goto enlarge_buffer;
+		}
+		ret = env.pos;
+		goto out_err;
+	}
 
-	snprintf(mb, 14, "minor-%d", device_to_minor(device));
-	setup_khelper_env(connection, envp);
+	if (current == resource->worker.task)
+		set_bit(CALLBACK_PENDING, &resource->flags);
 
 	/* The helper may take some time.
 	 * write out any unsynced meta data changes now */
-	drbd_md_sync(device);
+	if (device)
+		drbd_md_sync_if_dirty(device);
+	else if (connection)
+		conn_md_sync(connection);
 
-	drbd_info(device, "helper command: %s %s %s\n", drbd_usermode_helper, cmd, mb);
-	sib.sib_reason = SIB_HELPER_PRE;
-	sib.helper_name = cmd;
-	drbd_bcast_event(device, &sib);
+	if (connection && device)
+		peer_device = conn_peer_device(connection, device->vnr);
+
+	magic_printk(KERN_INFO, "helper command: %s %s\n", drbd_usermode_helper, cmd);
 	notify_helper(NOTIFY_CALL, device, connection, cmd, 0);
 	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
-		drbd_warn(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				drbd_usermode_helper, cmd, mb,
-				(ret >> 8) & 0xff, ret);
+		magic_printk(KERN_WARNING,
+			     "helper command: %s %s exit code %u (0x%x)\n",
+			     drbd_usermode_helper, cmd,
+			     (ret >> 8) & 0xff, ret);
 	else
-		drbd_info(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				drbd_usermode_helper, cmd, mb,
-				(ret >> 8) & 0xff, ret);
-	sib.sib_reason = SIB_HELPER_POST;
-	sib.helper_exit_code = ret;
-	drbd_bcast_event(device, &sib);
+		magic_printk(KERN_INFO,
+			     "helper command: %s %s exit code 0\n",
+			     drbd_usermode_helper, cmd);
 	notify_helper(NOTIFY_RESPONSE, device, connection, cmd, ret);
 
-	if (current == connection->worker.task)
-		clear_bit(CALLBACK_PENDING, &connection->flags);
+	if (current == resource->worker.task)
+		clear_bit(CALLBACK_PENDING, &resource->flags);
 
 	if (ret < 0) /* Ignore any ERRNOs we got. */
 		ret = 0;
 
+	free_pages((unsigned long)env.buffer, get_order(env.size));
 	return ret;
-}
 
-enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd)
-{
-	char *envp[] = { "HOME=/",
-			"TERM=linux",
-			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
-			 (char[20]) { }, /* address family */
-			 (char[60]) { }, /* address */
-			NULL };
-	char *resource_name = connection->resource->name;
-	char *argv[] = {drbd_usermode_helper, cmd, resource_name, NULL };
-	int ret;
-
-	setup_khelper_env(connection, envp);
-	conn_md_sync(connection);
-
-	drbd_info(connection, "helper command: %s %s %s\n", drbd_usermode_helper, cmd, resource_name);
-	/* TODO: conn_bcast_event() ?? */
-	notify_helper(NOTIFY_CALL, NULL, connection, cmd, 0);
+out_err:
+	drbd_err(resource, "Could not call %s user-space helper: error %d"
+		 "out of memory\n", cmd, ret);
+	return 0;
+}
 
-	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
-	if (ret)
-		drbd_warn(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  drbd_usermode_helper, cmd, resource_name,
-			  (ret >> 8) & 0xff, ret);
-	else
-		drbd_info(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  drbd_usermode_helper, cmd, resource_name,
-			  (ret >> 8) & 0xff, ret);
-	/* TODO: conn_bcast_event() ?? */
-	notify_helper(NOTIFY_RESPONSE, NULL, connection, cmd, ret);
+#undef magic_printk
 
-	if (ret < 0) /* Ignore any ERRNOs we got. */
-		ret = 0;
+int drbd_maybe_khelper(struct drbd_device *device, struct drbd_connection *connection, char *cmd)
+{
+	if (strcmp(drbd_usermode_helper, "disabled") == 0)
+		return DRBD_UMH_DISABLED;
 
-	return ret;
+	return drbd_khelper(device, connection, cmd);
 }
 
-static enum drbd_fencing_p highest_fencing_policy(struct drbd_connection *connection)
+static bool initial_states_pending(struct drbd_connection *connection)
 {
-	enum drbd_fencing_p fp = FP_NOT_AVAIL;
 	struct drbd_peer_device *peer_device;
 	int vnr;
+	bool pending = false;
 
 	rcu_read_lock();
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		if (get_ldev_if_state(device, D_CONSISTENT)) {
-			struct disk_conf *disk_conf =
-				rcu_dereference(peer_device->device->ldev->disk_conf);
-			fp = max_t(enum drbd_fencing_p, fp, disk_conf->fencing);
-			put_ldev(device);
+		if (test_bit(INITIAL_STATE_SENT, peer_device->flags) &&
+		    peer_device->repl_state[NOW] == L_OFF) {
+			pending = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
-
-	return fp;
+	return pending;
 }
 
-static bool resource_is_supended(struct drbd_resource *resource)
+static bool intentional_diskless(struct drbd_resource *resource)
 {
-	return resource->susp || resource->susp_fen || resource->susp_nod;
+	bool intentional_diskless = true;
+	struct drbd_device *device;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (!device->device_conf.intentional_diskless) {
+			intentional_diskless = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return intentional_diskless;
 }
 
-bool conn_try_outdate_peer(struct drbd_connection *connection)
+static bool conn_try_outdate_peer(struct drbd_connection *connection, const char *tag)
 {
-	struct drbd_resource * const resource = connection->resource;
-	unsigned int connect_cnt;
-	union drbd_state mask = { };
-	union drbd_state val = { };
-	enum drbd_fencing_p fp;
+	struct drbd_resource *resource = connection->resource;
+	unsigned long last_reconnect_jif;
+	enum drbd_fencing_policy fencing_policy;
+	enum drbd_disk_state disk_state;
 	char *ex_to_string;
 	int r;
+	unsigned long irq_flags;
 
-	spin_lock_irq(&resource->req_lock);
-	if (connection->cstate >= C_WF_REPORT_PARAMS) {
-		drbd_err(connection, "Expected cstate < C_WF_REPORT_PARAMS\n");
-		spin_unlock_irq(&resource->req_lock);
+	read_lock_irq(&resource->state_rwlock);
+	if (connection->cstate[NOW] >= C_CONNECTED) {
+		drbd_err(connection, "Expected cstate < C_CONNECTED\n");
+		read_unlock_irq(&resource->state_rwlock);
 		return false;
 	}
 
-	connect_cnt = connection->connect_cnt;
-	spin_unlock_irq(&resource->req_lock);
-
-	fp = highest_fencing_policy(connection);
-	switch (fp) {
-	case FP_NOT_AVAIL:
-		drbd_warn(connection, "Not fencing peer, I'm not even Consistent myself.\n");
-		spin_lock_irq(&resource->req_lock);
-		if (connection->cstate < C_WF_REPORT_PARAMS) {
-			_conn_request_state(connection,
-					    (union drbd_state) { { .susp_fen = 1 } },
-					    (union drbd_state) { { .susp_fen = 0 } },
-					    CS_VERBOSE | CS_HARD | CS_DC_SUSP);
-			/* We are no longer suspended due to the fencing policy.
-			 * We may still be suspended due to the on-no-data-accessible policy.
-			 * If that was OND_IO_ERROR, fail pending requests. */
-			if (!resource_is_supended(resource))
-				_tl_restart(connection, CONNECTION_LOST_WHILE_PENDING);
-		}
-		/* Else: in case we raced with a connection handshake,
-		 * let the handshake figure out if we maybe can RESEND,
-		 * and do not resume/fail pending requests here.
-		 * Worst case is we stay suspended for now, which may be
-		 * resolved by either re-establishing the replication link, or
-		 * the next link failure, or eventually the administrator.  */
-		spin_unlock_irq(&resource->req_lock);
+	last_reconnect_jif = connection->last_reconnect_jif;
+
+	disk_state = conn_highest_disk(connection);
+	if (disk_state < D_CONSISTENT &&
+	    !(disk_state == D_DISKLESS && intentional_diskless(resource))) {
+		begin_state_change_locked(resource, CS_VERBOSE | CS_HARD);
+		__change_io_susp_fencing(connection, false);
+		end_state_change_locked(resource, tag);
+		read_unlock_irq(&resource->state_rwlock);
 		return false;
+	}
+	read_unlock_irq(&resource->state_rwlock);
 
-	case FP_DONT_CARE:
+	fencing_policy = connection->fencing_policy;
+	if (fencing_policy == FP_DONT_CARE)
 		return true;
-	default: ;
-	}
 
-	r = conn_khelper(connection, "fence-peer");
+	r = drbd_maybe_khelper(NULL, connection, "fence-peer");
+	if (r == DRBD_UMH_DISABLED)
+		return true;
 
+	begin_state_change(resource, &irq_flags, CS_VERBOSE);
 	switch ((r>>8) & 0xff) {
 	case P_INCONSISTENT: /* peer is inconsistent */
 		ex_to_string = "peer is inconsistent or worse";
-		mask.pdsk = D_MASK;
-		val.pdsk = D_INCONSISTENT;
+		__downgrade_peer_disk_states(connection, D_INCONSISTENT);
 		break;
 	case P_OUTDATED: /* peer got outdated, or was already outdated */
 		ex_to_string = "peer was fenced";
-		mask.pdsk = D_MASK;
-		val.pdsk = D_OUTDATED;
+		__downgrade_peer_disk_states(connection, D_OUTDATED);
 		break;
 	case P_DOWN: /* peer was down */
 		if (conn_highest_disk(connection) == D_UP_TO_DATE) {
 			/* we will(have) create(d) a new UUID anyways... */
 			ex_to_string = "peer is unreachable, assumed to be dead";
-			mask.pdsk = D_MASK;
-			val.pdsk = D_OUTDATED;
+			__downgrade_peer_disk_states(connection, D_OUTDATED);
 		} else {
 			ex_to_string = "peer unreachable, doing nothing since disk != UpToDate";
 		}
@@ -572,42 +651,44 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 		 * become R_PRIMARY, but finds the other peer being active. */
 		ex_to_string = "peer is active";
 		drbd_warn(connection, "Peer is primary, outdating myself.\n");
-		mask.disk = D_MASK;
-		val.disk = D_OUTDATED;
+		__downgrade_disk_states(resource, D_OUTDATED);
 		break;
 	case P_FENCING:
 		/* THINK: do we need to handle this
-		 * like case 4, or more like case 5? */
-		if (fp != FP_STONITH)
+		 * like case 4 P_OUTDATED, or more like case 5 P_DOWN? */
+		if (fencing_policy != FP_STONITH)
 			drbd_err(connection, "fence-peer() = 7 && fencing != Stonith !!!\n");
 		ex_to_string = "peer was stonithed";
-		mask.pdsk = D_MASK;
-		val.pdsk = D_OUTDATED;
+		__downgrade_peer_disk_states(connection, D_OUTDATED);
 		break;
 	default:
 		/* The script is broken ... */
 		drbd_err(connection, "fence-peer helper broken, returned %d\n", (r>>8)&0xff);
+		abort_state_change(resource, &irq_flags);
 		return false; /* Eventually leave IO frozen */
 	}
 
 	drbd_info(connection, "fence-peer helper returned %d (%s)\n",
 		  (r>>8) & 0xff, ex_to_string);
 
-	/* Not using
-	   conn_request_state(connection, mask, val, CS_VERBOSE);
-	   here, because we might were able to re-establish the connection in the
-	   meantime. */
-	spin_lock_irq(&resource->req_lock);
-	if (connection->cstate < C_WF_REPORT_PARAMS && !test_bit(STATE_SENT, &connection->flags)) {
-		if (connection->connect_cnt != connect_cnt)
-			/* In case the connection was established and droped
-			   while the fence-peer handler was running, ignore it */
-			drbd_info(connection, "Ignoring fence-peer exit code\n");
-		else
-			_conn_request_state(connection, mask, val, CS_VERBOSE);
+	if (connection->cstate[NOW] >= C_CONNECTED ||
+	    initial_states_pending(connection)) {
+		/* connection re-established; do not fence */
+		goto abort;
+	}
+	if (connection->last_reconnect_jif != last_reconnect_jif) {
+		/* In case the connection was established and dropped
+		   while the fence-peer handler was running, ignore it */
+		drbd_info(connection, "Ignoring fence-peer exit code\n");
+		goto abort;
 	}
-	spin_unlock_irq(&resource->req_lock);
 
+	end_state_change(resource, &irq_flags, tag);
+
+	goto out;
+ abort:
+	abort_state_change(resource, &irq_flags);
+ out:
 	return conn_highest_pdsk(connection) <= D_OUTDATED;
 }
 
@@ -615,8 +696,7 @@ static int _try_outdate_peer_async(void *data)
 {
 	struct drbd_connection *connection = (struct drbd_connection *)data;
 
-	conn_try_outdate_peer(connection);
-
+	conn_try_outdate_peer(connection, "outdate-async");
 	kref_put(&connection->kref, drbd_destroy_connection);
 	return 0;
 }
@@ -639,206 +719,551 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
 	}
 }
 
-enum drbd_state_rv
-drbd_set_role(struct drbd_device *const device, enum drbd_role new_role, int force)
+bool barrier_pending(struct drbd_resource *resource)
 {
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
-	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
-	const int max_tries = 4;
-	enum drbd_state_rv rv = SS_UNKNOWN_ERROR;
-	struct net_conf *nc;
-	int try = 0;
-	int forced = 0;
-	union drbd_state mask, val;
-
-	if (new_role == R_PRIMARY) {
-		struct drbd_connection *connection;
-
-		/* Detect dead peers as soon as possible.  */
+	struct drbd_connection *connection;
+	bool rv = false;
 
-		rcu_read_lock();
-		for_each_connection(connection, device->resource)
-			request_ping(connection);
-		rcu_read_unlock();
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (test_bit(BARRIER_ACK_PENDING, &connection->flags)) {
+			rv = true;
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	mutex_lock(device->state_mutex);
+	return rv;
+}
 
-	mask.i = 0; mask.role = R_MASK;
-	val.i  = 0; val.role  = new_role;
+static int count_up_to_date(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	int vnr, nr_up_to_date = 0;
 
-	while (try++ < max_tries) {
-		rv = _drbd_request_state_holding_state_mutex(device, mask, val, CS_WAIT_COMPLETE);
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		enum drbd_disk_state disk_state = device->disk_state[NOW];
+
+		if (disk_state == D_UP_TO_DATE)
+			nr_up_to_date++;
+	}
+	rcu_read_unlock();
+	return nr_up_to_date;
+}
+
+static bool reconciliation_ongoing(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+
+	for_each_peer_device_rcu(peer_device, device) {
+		if (test_bit(RECONCILIATION_RESYNC, peer_device->flags))
+			return true;
+	}
+	return false;
+}
+
+static bool any_peer_is_consistent(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+
+	for_each_peer_device_rcu(peer_device, device) {
+		if (peer_device->disk_state[NOW] == D_CONSISTENT)
+			return true;
+	}
+	return false;
+}
+/* reconciliation resyncs finished and I know if I am D_UP_TO_DATE or D_OUTDATED */
+static bool after_primary_lost_events_settled(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	int vnr;
+
+	if (test_bit(TRY_BECOME_UP_TO_DATE_PENDING, &resource->flags))
+		return false;
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		enum drbd_disk_state disk_state = device->disk_state[NOW];
+
+		if (disk_state == D_CONSISTENT ||
+		    any_peer_is_consistent(device) ||
+		    (reconciliation_ongoing(device) &&
+		     (disk_state == D_OUTDATED || disk_state == D_INCONSISTENT))) {
+			rcu_read_unlock();
+			return false;
+		}
+	}
+	rcu_read_unlock();
+	return true;
+}
+
+static long drbd_max_ping_timeout(struct drbd_resource *resource)
+{
+	struct drbd_connection *connection;
+	long ping_timeout = 0;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource)
+		ping_timeout = max(ping_timeout, (long) connection->transport.net_conf->ping_timeo);
+	rcu_read_unlock();
+
+	return ping_timeout;
+}
+
+static bool wait_up_to_date(struct drbd_resource *resource)
+{
+	/*
+	 * Adding ping-timeout is necessary to ensure that we do not proceed
+	 * while the loss of some connection has not yet been detected. Ideally
+	 * we would use the maximum ping timeout from the entire cluster. Since
+	 * we do not have that, use the maximum from our connections on a
+	 * best-effort basis.
+	 */
+	long timeout = (resource->res_opts.auto_promote_timeout +
+			drbd_max_ping_timeout(resource)) * HZ / 10;
+	int initial_up_to_date, up_to_date;
+
+	initial_up_to_date = count_up_to_date(resource);
+	wait_event_interruptible_timeout(resource->state_wait,
+					 after_primary_lost_events_settled(resource),
+					 timeout);
+	up_to_date = count_up_to_date(resource);
+	return up_to_date > initial_up_to_date;
+}
+
+enum drbd_state_rv
+drbd_set_role(struct drbd_resource *resource, enum drbd_role role, bool force, const char *tag,
+		struct drbd_adm_ctx *ctx)
+{
+	struct drbd_device *device;
+	int vnr, try = 0;
+	const int max_tries = 4;
+	enum drbd_state_rv rv = SS_UNKNOWN_ERROR;
+	bool retried_ss_two_primaries = false, retried_ss_primary_nop = false;
+	const char *err_str = NULL;
+	enum chg_state_flags flags = CS_ALREADY_SERIALIZED | CS_DONT_RETRY | CS_WAIT_COMPLETE;
+	bool fenced_peers = false;
+
+retry:
+
+	if (role == R_PRIMARY) {
+		drbd_check_peers(resource);
+		wait_up_to_date(resource);
+	}
+	down(&resource->state_sem);
 
+	while (try++ < max_tries) {
+		if (try == max_tries - 1)
+			flags |= CS_VERBOSE;
+
+		kfree(err_str);
+		err_str = NULL;
+		rv = stable_state_change(resource,
+			change_role(resource, role, flags, tag, &err_str));
+
+		if (rv == SS_TIMEOUT || rv == SS_CONCURRENT_ST_CHG) {
+			long timeout = twopc_retry_timeout(resource, try);
+			/* It might be that the receiver tries to start resync, and
+			   sleeps on state_sem. Give it up, and retry in a short
+			   while */
+			up(&resource->state_sem);
+			schedule_timeout_interruptible(timeout);
+			goto retry;
+		}
 		/* in case we first succeeded to outdate,
 		 * but now suddenly could establish a connection */
-		if (rv == SS_CW_FAILED_BY_PEER && mask.pdsk != 0) {
-			val.pdsk = 0;
-			mask.pdsk = 0;
+		if (rv == SS_CW_FAILED_BY_PEER && fenced_peers) {
+			flags &= ~CS_FP_LOCAL_UP_TO_DATE;
+			continue;
+		}
+
+		if (rv == SS_NO_UP_TO_DATE_DISK && force && !(flags & CS_FP_LOCAL_UP_TO_DATE)) {
+			flags |= CS_FP_LOCAL_UP_TO_DATE;
 			continue;
 		}
 
-		if (rv == SS_NO_UP_TO_DATE_DISK && force &&
-		    (device->state.disk < D_UP_TO_DATE &&
-		     device->state.disk >= D_INCONSISTENT)) {
-			mask.disk = D_MASK;
-			val.disk  = D_UP_TO_DATE;
-			forced = 1;
+		if (rv == SS_DEVICE_IN_USE && force && !(flags & CS_FS_IGN_OPENERS)) {
+			drbd_warn(resource, "forced demotion\n");
+			flags |= CS_FS_IGN_OPENERS; /* this sets resource->fail_io[NOW] */
 			continue;
 		}
 
-		if (rv == SS_NO_UP_TO_DATE_DISK &&
-		    device->state.disk == D_CONSISTENT && mask.pdsk == 0) {
-			D_ASSERT(device, device->state.pdsk == D_UNKNOWN);
+		if (rv == SS_NO_UP_TO_DATE_DISK) {
+			bool a_disk_became_up_to_date;
+
+			/* need to give up state_sem, see try_become_up_to_date(); */
+			up(&resource->state_sem);
+			drbd_flush_workqueue(&resource->work);
+			a_disk_became_up_to_date = wait_up_to_date(resource);
+			down(&resource->state_sem);
+			if (a_disk_became_up_to_date)
+				continue;
+			/* fall through into possible fence-peer or even force cases */
+		}
+
+		if (rv == SS_NO_UP_TO_DATE_DISK && !(flags & CS_FP_LOCAL_UP_TO_DATE)) {
+			struct drbd_connection *connection;
+			bool any_fencing_failed = false;
+			u64 im;
+
+			fenced_peers = false;
+			up(&resource->state_sem); /* Allow connect while fencing */
+			for_each_connection_ref(connection, im, resource) {
+				struct drbd_peer_device *peer_device;
+				int vnr;
 
-			if (conn_try_outdate_peer(connection)) {
-				val.disk = D_UP_TO_DATE;
-				mask.disk = D_MASK;
+				if (conn_highest_pdsk(connection) != D_UNKNOWN)
+					continue;
+
+				idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+					struct drbd_device *device = peer_device->device;
+
+					if (device->disk_state[NOW] != D_CONSISTENT)
+						continue;
+
+					if (conn_try_outdate_peer(connection, tag))
+						fenced_peers = true;
+					else
+						any_fencing_failed = true;
+				}
+			}
+			down(&resource->state_sem);
+			if (fenced_peers && !any_fencing_failed) {
+				flags |= CS_FP_LOCAL_UP_TO_DATE;
+				continue;
 			}
+		}
+
+		/* In case the disk is Consistent and fencing is enabled, and fencing did not work
+		 * but the user forces promote..., try it pretending we fenced the peers */
+		if (rv == SS_PRIMARY_NOP && force &&
+		    (flags & CS_FP_LOCAL_UP_TO_DATE) && !(flags & CS_FP_OUTDATE_PEERS)) {
+			flags |= CS_FP_OUTDATE_PEERS;
+			continue;
+		}
+
+		if (rv == SS_NO_QUORUM && force && !(flags & CS_FP_OUTDATE_PEERS)) {
+			flags |= CS_FP_OUTDATE_PEERS;
 			continue;
 		}
 
 		if (rv == SS_NOTHING_TO_DO)
 			goto out;
-		if (rv == SS_PRIMARY_NOP && mask.pdsk == 0) {
-			if (!conn_try_outdate_peer(connection) && force) {
-				drbd_warn(device, "Forced into split brain situation!\n");
-				mask.pdsk = D_MASK;
-				val.pdsk  = D_OUTDATED;
+		if (rv == SS_PRIMARY_NOP && !retried_ss_primary_nop) {
+			struct drbd_connection *connection;
+			u64 im;
+
+			retried_ss_primary_nop = true;
 
+			up(&resource->state_sem); /* Allow connect while fencing */
+			for_each_connection_ref(connection, im, resource) {
+				bool outdated_peer = conn_try_outdate_peer(connection, tag);
+
+				if (!outdated_peer && force) {
+					drbd_warn(connection, "Forced into split brain situation!\n");
+					flags |= CS_FP_LOCAL_UP_TO_DATE;
+				}
 			}
+			down(&resource->state_sem);
 			continue;
 		}
-		if (rv == SS_TWO_PRIMARIES) {
-			/* Maybe the peer is detected as dead very soon...
-			   retry at most once more in this case. */
-			if (try < max_tries) {
-				int timeo;
-				try = max_tries - 1;
-				rcu_read_lock();
-				nc = rcu_dereference(connection->net_conf);
-				timeo = nc ? (nc->ping_timeo + 1) * HZ / 10 : 1;
-				rcu_read_unlock();
-				schedule_timeout_interruptible(timeo);
+
+		if (rv == SS_TWO_PRIMARIES && !retried_ss_two_primaries) {
+			struct drbd_connection *connection;
+			struct drbd_net_conf *nc;
+			int timeout = 0;
+
+			retried_ss_two_primaries = true;
+
+			/*
+			 * Catch the case where we discover that the other
+			 * primary has died soon after the state change
+			 * failure: retry once after a short timeout.
+			 */
+
+			rcu_read_lock();
+			for_each_connection_rcu(connection, resource) {
+				nc = rcu_dereference(connection->transport.net_conf);
+				if (nc && nc->ping_timeo > timeout)
+					timeout = nc->ping_timeo;
 			}
-			continue;
-		}
-		if (rv < SS_SUCCESS) {
-			rv = _drbd_request_state(device, mask, val,
-						CS_VERBOSE + CS_WAIT_COMPLETE);
-			if (rv < SS_SUCCESS)
-				goto out;
+			rcu_read_unlock();
+			timeout = timeout * HZ / 10;
+			if (timeout == 0)
+				timeout = 1;
+
+			up(&resource->state_sem);
+			schedule_timeout_interruptible(timeout);
+			goto retry;
 		}
+
 		break;
 	}
 
 	if (rv < SS_SUCCESS)
 		goto out;
 
-	if (forced)
-		drbd_warn(device, "Forced to consider local data as UpToDate!\n");
-
-	/* Wait until nothing is on the fly :) */
-	wait_event(device->misc_wait, atomic_read(&device->ap_pending_cnt) == 0);
-
-	/* FIXME also wait for all pending P_BARRIER_ACK? */
+	if (force) {
+		if (flags & CS_FP_LOCAL_UP_TO_DATE)
+			drbd_warn(resource, "Forced to consider local data as UpToDate!\n");
+		if (flags & CS_FP_OUTDATE_PEERS)
+			drbd_warn(resource, "Forced to consider peers as Outdated!\n");
+	}
 
-	if (new_role == R_SECONDARY) {
-		if (get_ldev(device)) {
-			device->ldev->md.uuid[UI_CURRENT] &= ~(u64)1;
-			put_ldev(device);
+	if (role == R_SECONDARY) {
+		idr_for_each_entry(&resource->devices, device, vnr) {
+			if (get_ldev(device)) {
+				device->ldev->md.current_uuid &= ~UUID_PRIMARY;
+				put_ldev(device);
+			}
 		}
 	} else {
-		mutex_lock(&device->resource->conf_update);
-		nc = connection->net_conf;
-		if (nc)
-			nc->discard_my_data = 0; /* without copy; single bit op is atomic */
-		mutex_unlock(&device->resource->conf_update);
+		struct drbd_connection *connection;
 
-		if (get_ldev(device)) {
-			if (((device->state.conn < C_CONNECTED ||
-			       device->state.pdsk <= D_FAILED)
-			      && device->ldev->md.uuid[UI_BITMAP] == 0) || forced)
-				drbd_uuid_new_current(device);
+		rcu_read_lock();
+		for_each_connection_rcu(connection, resource)
+			clear_bit(CONN_DISCARD_MY_DATA, &connection->flags);
+		rcu_read_unlock();
 
-			device->ldev->md.uuid[UI_CURRENT] |=  (u64)1;
-			put_ldev(device);
+		idr_for_each_entry(&resource->devices, device, vnr) {
+			if (flags & CS_FP_LOCAL_UP_TO_DATE) {
+				enum drbd_mint_outcome outcome;
+				bool through_executor;
+
+				/* gen-rotate reason: OTHER (admin force-primary).
+				 * This generation is the promotion's own and is
+				 * owed whether or not an obligation is armed;
+				 * where it is also the obligation's mint, its
+				 * outcome decides.
+				 */
+				through_executor = drbd_gen_obligation_mint_start(device);
+				outcome = drbd_uuid_new_current(device, true);
+				if (through_executor) {
+					drbd_gen_obligation_mint_done(device, outcome);
+					wake_up(&device->misc_wait);
+				}
+			}
 		}
 	}
 
-	/* writeout of activity log covered areas of the bitmap
-	 * to stable storage done in after state change already */
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		struct drbd_peer_device *peer_device;
+		u64 im;
+
+		for_each_peer_device_ref(peer_device, im, device) {
+			/* writeout of activity log covered areas of the bitmap
+			 * to stable storage done in after state change already */
+
+			if (peer_device->connection->cstate[NOW] == C_CONNECTED) {
+				/* if this was forced, we should consider sync */
+				if (flags & CS_FP_LOCAL_UP_TO_DATE) {
+					drbd_send_uuids(peer_device, 0, 0);
+					set_bit(CONSIDER_RESYNC, peer_device->flags);
+				}
+				drbd_send_current_state(peer_device);
+			}
+		}
+	}
 
-	if (device->state.conn >= C_WF_REPORT_PARAMS) {
-		/* if this was forced, we should consider sync */
-		if (forced)
-			drbd_send_uuids(peer_device);
-		drbd_send_current_state(peer_device);
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		drbd_md_sync_if_dirty(device);
+		if (!resource->res_opts.auto_promote && role == R_PRIMARY)
+			kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 	}
 
-	drbd_md_sync(device);
-	set_disk_ro(device->vdisk, new_role == R_SECONDARY);
-	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 out:
-	mutex_unlock(device->state_mutex);
+	up(&resource->state_sem);
+	if (err_str) {
+		drbd_err(resource, "%s", err_str);
+		if (ctx)
+			drbd_adm_msg(ctx, "%s", err_str);
+		kfree(err_str);
+	}
 	return rv;
 }
 
-static const char *from_attrs_err_to_txt(int err)
+/* suggested buffer size: 128 byte */
+void youngest_and_oldest_opener_to_str(struct drbd_device *device, char *buf, size_t len)
+{
+	struct timespec64 ts;
+	struct tm tm;
+	struct opener *first;
+	struct opener *last;
+	int cnt;
+
+	buf[0] = '\0';
+	/* Do we have opener information? */
+	if (!device->open_cnt)
+		return;
+	cnt = snprintf(buf, len, " open_cnt:%d", device->open_cnt);
+	if (cnt > 0 && cnt < len) {
+		buf += cnt;
+		len -= cnt;
+	} else
+		return;
+	spin_lock(&device->openers_lock);
+	if (!list_empty(&device->openers)) {
+		first = list_first_entry(&device->openers, struct opener, list);
+		ts = ktime_to_timespec64(first->opened);
+		time64_to_tm(ts.tv_sec, -sys_tz.tz_minuteswest * 60, &tm);
+		cnt = snprintf(buf, len, " [%s:%d:%04ld-%02d-%02d_%02d:%02d:%02d.%03ld]",
+			      first->comm, first->pid,
+			      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			      tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec / NSEC_PER_MSEC);
+		last = list_last_entry(&device->openers, struct opener, list);
+		if (cnt > 0 && cnt < len && last != first) {
+			/* append, overwriting the previously added ']' */
+			buf += cnt-1;
+			len -= cnt-1;
+			ts = ktime_to_timespec64(last->opened);
+			time64_to_tm(ts.tv_sec, -sys_tz.tz_minuteswest * 60, &tm);
+			snprintf(buf, len, "%s%s:%d:%04ld-%02d-%02d_%02d:%02d:%02d.%03ld]",
+			      device->open_cnt > 2 ? ", ..., " : ", ",
+			      last->comm, last->pid,
+			      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			      tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec / NSEC_PER_MSEC);
+		}
+	}
+	spin_unlock(&device->openers_lock);
+}
+
+static int put_device_opener_info(struct drbd_device *device, struct drbd_adm_ctx *ctx)
+{
+	struct timespec64 ts;
+	struct opener *o;
+	struct tm tm;
+	int cnt = 0;
+	char *dotdotdot = "";
+
+	spin_lock(&device->openers_lock);
+	if (!device->open_cnt) {
+		spin_unlock(&device->openers_lock);
+		return cnt;
+	}
+	drbd_adm_msg(ctx,
+		"/dev/drbd%d open_cnt:%d, writable:%d; list of openers follows",
+		device->minor, device->open_cnt, device->writable);
+	list_for_each_entry(o, &device->openers, list) {
+		ts = ktime_to_timespec64(o->opened);
+		time64_to_tm(ts.tv_sec, -sys_tz.tz_minuteswest * 60, &tm);
+
+		if (++cnt >= 10 && !list_is_last(&o->list, &device->openers)) {
+			o = list_last_entry(&device->openers, struct opener, list);
+			dotdotdot = "[...]\n";
+		}
+		drbd_adm_msg(ctx,
+			"%sdrbd%d opened by %s (pid %d) at %04ld-%02d-%02d %02d:%02d:%02d.%03ld",
+			dotdotdot,
+			device->minor, o->comm, o->pid,
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			tm.tm_hour, tm.tm_min, tm.tm_sec,
+			ts.tv_nsec / NSEC_PER_MSEC);
+	}
+	spin_unlock(&device->openers_lock);
+	return cnt;
+}
+
+static void opener_info(struct drbd_resource *resource,
+			struct drbd_adm_ctx *ctx,
+			enum drbd_state_rv rv)
+{
+	struct drbd_device *device;
+	int i;
+
+	if (rv != SS_DEVICE_IN_USE && rv != SS_NO_UP_TO_DATE_DISK)
+		return;
+
+	idr_for_each_entry(&resource->devices, device, i)
+		put_device_opener_info(device, ctx);
+}
+
+/* Report the failure of a dialect overlay callback. */
+static void drbd_adm_msg_overlay_error(struct drbd_adm_ctx *ctx, int err)
 {
-	return	err == -ENOMSG ? "required attribute missing" :
+	const char *txt =
+		err == -ENOMSG ? "required attribute missing" :
 		err == -EEXIST ? "can not change invariant setting" :
 		"invalid attribute value";
+
+	drbd_adm_msg(ctx, "%s", txt);
 }
 
-static int drbd_nl_set_role(struct sk_buff *skb, struct genl_info *info)
+static int drbd_adm_set_role(struct drbd_adm_ctx *adm_ctx, enum drbd_role new_role)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct set_role_parms parms;
-	int err;
-	enum drbd_ret_code retcode;
+	struct drbd_resource *resource;
+	struct drbd_set_role_parms parms;
 	enum drbd_state_rv rv;
+	enum drbd_ret_code retcode = NO_ERROR;
+	int err;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
-
+	resource = adm_ctx->resource;
 	memset(&parms, 0, sizeof(parms));
-	if (info->attrs[DRBD_NLA_SET_ROLE_PARMS]) {
-		err = set_role_parms_from_attrs(&parms, info);
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_SET_ROLE_PARMS)) {
+		err = drbd_adm_overlay_set_role_parms(adm_ctx, &parms);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+			drbd_adm_msg_overlay_error(adm_ctx, err);
 			goto out;
 		}
 	}
-	genl_unlock();
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out;
+	}
 
-	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		rv = drbd_set_role(adm_ctx->device, R_PRIMARY, parms.assume_uptodate);
-	else
-		rv = drbd_set_role(adm_ctx->device, R_SECONDARY, 0);
+	if (new_role == R_PRIMARY)
+		set_bit(EXPLICIT_PRIMARY, &resource->flags);
 
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-	genl_lock();
-	adm_ctx->reply_dh->ret_code = rv;
-	return 0;
+	rv = drbd_set_role(resource,
+				new_role,
+				parms.force,
+				new_role == R_PRIMARY ? "primary" : "secondary",
+				adm_ctx);
+
+	if (resource->role[NOW] != R_PRIMARY)
+		clear_bit(EXPLICIT_PRIMARY, &resource->flags);
+
+	if (rv == SS_DEVICE_IN_USE)
+		opener_info(resource, adm_ctx, rv);
+
+	mutex_unlock(&resource->adm_mutex);
+	retcode = (enum drbd_ret_code)rv;
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_primary_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_primary(struct drbd_adm_ctx *adm_ctx)
+{
+	return drbd_adm_set_role(adm_ctx, R_PRIMARY);
+}
+
+int drbd_adm_secondary(struct drbd_adm_ctx *adm_ctx)
 {
-	return drbd_nl_set_role(skb, info);
+	return drbd_adm_set_role(adm_ctx, R_SECONDARY);
 }
 
-int drbd_nl_secondary_doit(struct sk_buff *skb, struct genl_info *info)
+u64 drbd_capacity_to_on_disk_bm_sect(u64 capacity_sect, const struct drbd_md *md)
 {
-	return drbd_nl_set_role(skb, info);
+	u64 bits, bytes;
+
+	/* round up storage sectors to full "bitmap sectors per bit", then
+	 * convert to number of bits needed, and round that up to 64bit words
+	 * to ease interoperability between 32bit and 64bit architectures.
+	 */
+	bits = ALIGN(sect_to_bit(
+			ALIGN(capacity_sect, sect_per_bit(md->bm_block_shift)),
+			md->bm_block_shift), 64);
+
+	/* convert to bytes, multiply by number of peers,
+	 * and, because we do all our meta data IO in 4k blocks,
+	 * round up to full 4k
+	 */
+	bytes = ALIGN(bits / 8 * md->max_peers, 4096);
+
+	/* convert to number of sectors */
+	return bytes >> 9;
 }
 
 /* Initializes the md.*_offset members, so we are able to find
@@ -860,10 +1285,9 @@ int drbd_nl_secondary_doit(struct sk_buff *skb, struct genl_info *info)
  *  ==> bitmap sectors = Y = al_offset - bm_offset
  *
  *  Activity log size used to be fixed 32kB,
- *  but is about to become configurable.
+ *  but is actually al_stripes * al_stripe_size_4k.
  */
-static void drbd_md_set_sector_offsets(struct drbd_device *device,
-				       struct drbd_backing_dev *bdev)
+void drbd_md_set_sector_offsets(struct drbd_backing_dev *bdev)
 {
 	sector_t md_size_sect = 0;
 	unsigned int al_size_sect = bdev->md.al_size_4k * 8;
@@ -873,33 +1297,32 @@ static void drbd_md_set_sector_offsets(struct drbd_device *device,
 	switch (bdev->md.meta_dev_idx) {
 	default:
 		/* v07 style fixed size indexed meta data */
-		bdev->md.md_size_sect = MD_128MB_SECT;
-		bdev->md.al_offset = MD_4kB_SECT;
-		bdev->md.bm_offset = MD_4kB_SECT + al_size_sect;
+		/* FIXME we should drop support for this! */
+		bdev->md.md_size_sect = (128 << 20 >> 9);
+		bdev->md.al_offset = (4096 >> 9);
+		bdev->md.bm_offset = (4096 >> 9) + al_size_sect;
 		break;
 	case DRBD_MD_INDEX_FLEX_EXT:
 		/* just occupy the full device; unit: sectors */
 		bdev->md.md_size_sect = drbd_get_capacity(bdev->md_bdev);
-		bdev->md.al_offset = MD_4kB_SECT;
-		bdev->md.bm_offset = MD_4kB_SECT + al_size_sect;
+		bdev->md.al_offset = (4096 >> 9);
+		bdev->md.bm_offset = (4096 >> 9) + al_size_sect;
 		break;
 	case DRBD_MD_INDEX_INTERNAL:
 	case DRBD_MD_INDEX_FLEX_INT:
-		/* al size is still fixed */
 		bdev->md.al_offset = -al_size_sect;
-		/* we need (slightly less than) ~ this much bitmap sectors: */
-		md_size_sect = drbd_get_capacity(bdev->backing_bdev);
-		md_size_sect = ALIGN(md_size_sect, BM_SECT_PER_EXT);
-		md_size_sect = BM_SECT_TO_EXT(md_size_sect);
-		md_size_sect = ALIGN(md_size_sect, 8);
 
-		/* plus the "drbd meta data super block",
+		/* enough bitmap to cover the storage,
+		 * plus the "drbd meta data super block",
 		 * and the activity log; */
-		md_size_sect += MD_4kB_SECT + al_size_sect;
+		md_size_sect = drbd_capacity_to_on_disk_bm_sect(
+				drbd_get_capacity(bdev->backing_bdev),
+				&bdev->md)
+			+ (4096 >> 9) + al_size_sect;
 
 		bdev->md.md_size_sect = md_size_sect;
 		/* bitmap offset is adjusted by 'super' block size */
-		bdev->md.bm_offset   = -md_size_sect + MD_4kB_SECT;
+		bdev->md.bm_offset   = -md_size_sect + (4096 >> 9);
 		break;
 	}
 }
@@ -911,28 +1334,22 @@ char *ppsize(char *buf, unsigned long long size)
 	 * -1ULL ==> "16384 EB" */
 	static char units[] = { 'K', 'M', 'G', 'T', 'P', 'E' };
 	int base = 0;
+
 	while (size >= 10000 && base < sizeof(units)-1) {
 		/* shift + round */
 		size = (size >> 10) + !!(size & (1<<9));
 		base++;
 	}
-	sprintf(buf, "%u %cB", (unsigned)size, units[base]);
+	sprintf(buf, "%u %cB", (unsigned int)size, units[base]);
 
 	return buf;
 }
 
-/* there is still a theoretical deadlock when called from receiver
- * on an D_INCONSISTENT R_PRIMARY:
- *  remote READ does inc_ap_bio, receiver would need to receive answer
- *  packet from remote to dec_ap_bio again.
- *  receiver receive_sizes(), comes here,
- *  waits for ap_bio_cnt == 0. -> deadlock.
- * but this cannot happen, actually, because:
- *  R_PRIMARY D_INCONSISTENT, and peer's disk is unreachable
- *  (not connected, or bad/no disk on peer):
- *  see drbd_fail_request_early, ap_bio_cnt is zero.
- *  R_PRIMARY D_INCONSISTENT, and C_SYNC_TARGET:
- *  peer may not initiate a resize.
+/* The receiver may call drbd_suspend_io(device, WRITE_ONLY).
+ * It should not call drbd_suspend_io(device, READ_AND_WRITE) since
+ * if the node is an D_INCONSISTENT R_PRIMARY (L_SYNC_TARGET) it
+ * may need to issue remote READs. Those is turn need the receiver
+ * to complete. -> calling drbd_suspend_io(device, READ_AND_WRITE) deadlocks.
  */
 /* Note these are not to be confused with
  * drbd_nl_suspend_io_doit/drbd_nl_resume_io_doit,
@@ -942,12 +1359,24 @@ char *ppsize(char *buf, unsigned long long size)
  * and should be short-lived. */
 /* It needs to be a counter, since multiple threads might
    independently suspend and resume IO. */
-void drbd_suspend_io(struct drbd_device *device)
+static bool ap_bio_drained(struct drbd_device *device, enum suspend_scope ss)
+{
+	return drbd_suspended(device) ||
+	       atomic_read(&device->ap_bio_cnt[WRITE]) +
+	       (ss == READ_AND_WRITE ? atomic_read(&device->ap_bio_cnt[READ]) : 0) == 0;
+}
+
+void drbd_suspend_io(struct drbd_device *device, enum suspend_scope ss)
 {
 	atomic_inc(&device->suspend_cnt);
-	if (drbd_suspended(device))
-		return;
-	wait_event(device->misc_wait, !atomic_read(&device->ap_bio_cnt));
+	/* Order the suspend_cnt store before the ap_bio_cnt load in the wait
+	 * condition below. Pairs with the cmpxchg + suspend_cnt re-check in
+	 * inc_ap_bio_cond(): a submitter that increments ap_bio_cnt after we
+	 * raised suspend_cnt is guaranteed to observe suspend_cnt and roll
+	 * back, or we observe its increment and wait.
+	 */
+	smp_mb__after_atomic();
+	wait_event(device->misc_wait, ap_bio_drained(device, ss));
 }
 
 void drbd_resume_io(struct drbd_device *device)
@@ -956,18 +1385,76 @@ void drbd_resume_io(struct drbd_device *device)
 		wake_up(&device->misc_wait);
 }
 
+int drbd_suspend_io_interruptible(struct drbd_device *device, enum suspend_scope ss)
+{
+	int ret;
+
+	atomic_inc(&device->suspend_cnt);
+	smp_mb__after_atomic(); /* see drbd_suspend_io() */
+	ret = wait_event_interruptible(device->misc_wait, ap_bio_drained(device, ss));
+	if (ret)
+		drbd_resume_io(device);
+	return ret;
+}
+
+/**
+ * effective_disk_size_determined()  -  is the effective disk size "fixed" already?
+ * @device: DRBD device.
+ *
+ * When a device is configured in a cluster, the size of the replicated disk is
+ * determined by the minimum size of the disks on all nodes.  Additional nodes
+ * can be added, and this can still change the effective size of the replicated
+ * disk.
+ *
+ * When the disk on any node becomes D_UP_TO_DATE, the effective disk size
+ * becomes "fixed".  It is written to the metadata so that it will not be
+ * forgotten across node restarts.  Further nodes can only be added if their
+ * disks are big enough.
+ */
+static bool effective_disk_size_determined(struct drbd_device *device)
+{
+	struct drbd_peer_device *peer_device;
+	bool rv = false;
+
+	if (device->ldev->md.effective_size != 0)
+		return true;
+	if (device->disk_state[NOW] == D_UP_TO_DATE)
+		return true;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (peer_device->disk_state[NOW] == D_UP_TO_DATE) {
+			rv = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+void drbd_set_my_capacity(struct drbd_device *device, sector_t size)
+{
+	char ppb[10];
+
+	set_capacity_and_notify(device->vdisk, size);
+
+	drbd_info(device, "size = %s (%llu KB)\n",
+		ppsize(ppb, size>>1), (unsigned long long)size>>1);
+}
+
 /*
  * drbd_determine_dev_size() -  Sets the right device size obeying all constraints
  * @device:	DRBD device.
  *
- * Returns 0 on success, negative return values indicate errors.
  * You should call drbd_md_sync() after calling this function.
  */
 enum determine_dev_size
-drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct resize_parms *rs) __must_hold(local)
+drbd_determine_dev_size(struct drbd_device *device, sector_t peer_current_size,
+			enum dds_flags flags, struct drbd_resize_parms *rs)
 {
 	struct md_offsets_and_sizes {
-		u64 last_agreed_sect;
+		u64 effective_size;
 		u64 md_offset;
 		s32 al_offset;
 		s32 bm_offset;
@@ -976,7 +1463,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		u32 al_stripes;
 		u32 al_stripe_size_4k;
 	} prev;
-	sector_t u_size, size;
+	sector_t u_size, size, prev_size;
 	struct drbd_md *md = &device->ldev->md;
 	void *buffer;
 
@@ -991,21 +1478,45 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	 * Move is not exactly correct, btw, currently we have all our meta
 	 * data in core memory, to "move" it we just write it all out, there
 	 * are no reads. */
-	drbd_suspend_io(device);
+	drbd_suspend_io(device, READ_AND_WRITE);
+
+	/* Take the AL transaction lock before the md_buffer to avoid an
+	 * AB-BA deadlock against al_write_transaction().
+	 */
+	wait_event(device->al_wait, drbd_al_try_lock_for_transaction(device));
+
+	/* Take the bitmap lock before md_buffer. Whole-bitmap operations
+	 * (drbd_bitmap_io()/w_bitmap_io()) hold the bitmap lock while their
+	 * io_fn acquires md_buffer via drbd_md_sync().
+	 */
+	if (device->bitmap)
+		drbd_bm_lock(device, __func__, BM_LOCK_ALL);
+
 	buffer = drbd_md_get_buffer(device, __func__); /* Lock meta-data IO */
 	if (!buffer) {
+		if (device->bitmap)
+			drbd_bm_unlock(device);
+		lc_unlock(device->act_log);
+		wake_up(&device->al_wait);
 		drbd_resume_io(device);
 		return DS_ERROR;
 	}
 
 	/* remember current offset and sizes */
-	prev.last_agreed_sect = md->la_size_sect;
+	prev.effective_size = md->effective_size;
 	prev.md_offset = md->md_offset;
 	prev.al_offset = md->al_offset;
 	prev.bm_offset = md->bm_offset;
 	prev.md_size_sect = md->md_size_sect;
 	prev.al_stripes = md->al_stripes;
 	prev.al_stripe_size_4k = md->al_stripe_size_4k;
+	prev_size = get_capacity(device->vdisk);
+
+	/* We do some synchronous IO below, which may take some time.
+	 * Clear the timer, to avoid scary "timer expired!" messages,
+	 * "Superblock" is written out at least twice below, anyways.
+	 */
+	timer_delete(&device->md_sync_timer);
 
 	if (rs) {
 		/* rs is non NULL if we should change the AL layout only */
@@ -1014,14 +1525,23 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		md->al_size_4k = (u64)rs->al_stripes * rs->al_stripe_size / 4;
 	}
 
-	drbd_md_set_sector_offsets(device, device->ldev);
+	drbd_md_set_sector_offsets(device->ldev);
 
 	rcu_read_lock();
 	u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
 	rcu_read_unlock();
-	size = drbd_new_dev_size(device, device->ldev, u_size, flags & DDSF_FORCED);
+	if (flags & DDSF_2PC) {
+		/* Take the size the transaction agreed on.  Deriving it again
+		 * here would use this node's own view of who takes part, which
+		 * is short of the initiator's, so a node that can not see the
+		 * whole cluster would refuse a size everyone agreed to.
+		 */
+		size = peer_current_size;
+	} else {
+		size = drbd_new_dev_size(device, 0, u_size, flags);
+	}
 
-	if (size < prev.last_agreed_sect) {
+	if (size < prev.effective_size) {
 		if (rs && u_size == 0) {
 			/* Remove "rs &&" later. This check should always be active, but
 			   right now the receiver expects the permissive behavior */
@@ -1037,9 +1557,12 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	}
 
 	if (get_capacity(device->vdisk) != size ||
-	    drbd_bm_capacity(device) != size) {
-		int err;
-		err = drbd_bm_resize(device, size, !(flags & DDSF_NO_RESYNC));
+	    (device->bitmap && drbd_bm_capacity(device) != size)) {
+		int err = 0;
+
+		if (device->bitmap)
+			err = drbd_bm_resize(device, device->bitmap, size,
+					     !(flags & DDSF_NO_RESYNC));
 		if (unlikely(err)) {
 			/* currently there is only one error: ENOMEM! */
 			size = drbd_bm_capacity(device);
@@ -1051,36 +1574,47 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 				    "Leaving size unchanged\n");
 			}
 			rv = DS_ERROR;
+		} else {
+			/* racy, see comments above. */
+			drbd_set_my_capacity(device, size);
+			if (effective_disk_size_determined(device)
+			&& md->effective_size != size) {
+				char ppb[10];
+
+				drbd_info(device, "persisting effective size = %s (%llu KB)\n",
+					ppsize(ppb, size >> 1),
+					(unsigned long long)size >> 1);
+				md->effective_size = size;
+			}
 		}
-		/* racy, see comments above. */
-		drbd_set_my_capacity(device, size);
-		md->la_size_sect = size;
 	}
 	if (rv <= DS_ERROR)
 		goto err_out;
 
-	la_size_changed = (prev.last_agreed_sect != md->la_size_sect);
+	la_size_changed = (prev.effective_size != md->effective_size);
 
 	md_moved = prev.md_offset    != md->md_offset
 		|| prev.md_size_sect != md->md_size_sect;
 
 	if (la_size_changed || md_moved || rs) {
-		u32 prev_flags;
-
-		/* We do some synchronous IO below, which may take some time.
-		 * Clear the timer, to avoid scary "timer expired!" messages,
-		 * "Superblock" is written out at least twice below, anyways. */
-		timer_delete(&device->md_sync_timer);
-
-		/* We won't change the "al-extents" setting, we just may need
-		 * to move the on-disk location of the activity log ringbuffer.
-		 * Lock for transaction is good enough, it may well be "dirty"
-		 * or even "starving". */
-		wait_event(device->al_wait, lc_try_lock_for_transaction(device->act_log));
+		int i;
+		bool prev_al_disabled = 0;
+		u32 prev_peer_full_sync = 0;
+
+		if (drbd_md_dax_active(device->ldev)) {
+			if (drbd_dax_map(device->ldev)) {
+				drbd_err(device, "Could not remap DAX; aborting resize\n");
+				goto err_out;
+			}
+		}
 
 		/* mark current on-disk bitmap and activity log as unreliable */
-		prev_flags = md->flags;
-		md->flags |= MDF_FULL_SYNC | MDF_AL_DISABLED;
+		prev_al_disabled = !!(md->flags & MDF_AL_DISABLED);
+		md->flags |= MDF_AL_DISABLED;
+		for (i = 0; i < DRBD_PEERS_MAX; i++) {
+			if (test_and_set_bit(__MDF_PEER_FULL_SYNC, &md->peers[i].flags))
+				prev_peer_full_sync |= 1 << i;
+		}
 		drbd_md_write(device, buffer);
 
 		drbd_al_initialize(device, buffer);
@@ -1088,29 +1622,46 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		drbd_info(device, "Writing the whole bitmap, %s\n",
 			 la_size_changed && md_moved ? "size changed and md moved" :
 			 la_size_changed ? "size changed" : "md moved");
-		/* next line implicitly does drbd_suspend_io()+drbd_resume_io() */
-		drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
-			       "size changed", BM_LOCKED_MASK, NULL);
+		/* The in-memory bitmap is correct at this point: callers load it
+		 * from disk before invoking drbd_determine_dev_size(), and
+		 * drbd_bm_resize() above has marked the grown region dirty when
+		 * set_new_bits was true.  Write it to disk to update la_size and
+		 * persist any resync markers for the newly grown region.
+		 *
+		 * The bitmap lock is already held and IO is suspended, so call
+		 * the io_fn directly instead of going through drbd_bitmap_io().
+		 */
+		if (device->bitmap) {
+			if (md_moved)
+				drbd_bm_write_all(device, NULL);
+			else
+				drbd_bm_write(device, NULL);
+		}
 
 		/* on-disk bitmap and activity log is authoritative again
 		 * (unless there was an IO error meanwhile...) */
-		md->flags = prev_flags;
+		if (!prev_al_disabled)
+			md->flags &= ~MDF_AL_DISABLED;
+		for (i = 0; i < DRBD_PEERS_MAX; i++) {
+			if (0 == (prev_peer_full_sync & (1 << i)))
+				clear_bit(__MDF_PEER_FULL_SYNC, &md->peers[i].flags);
+		}
 		drbd_md_write(device, buffer);
 
 		if (rs)
 			drbd_info(device, "Changed AL layout to al-stripes = %d, al-stripe-size-kB = %d\n",
-				  md->al_stripes, md->al_stripe_size_4k * 4);
+				 md->al_stripes, md->al_stripe_size_4k * 4);
 	}
 
-	if (size > prev.last_agreed_sect)
-		rv = prev.last_agreed_sect ? DS_GREW : DS_GREW_FROM_ZERO;
-	if (size < prev.last_agreed_sect)
+	if (size > prev_size)
+		rv = prev_size ? DS_GREW : DS_GREW_FROM_ZERO;
+	if (size < prev_size)
 		rv = DS_SHRUNK;
 
 	if (0) {
-	err_out:
+err_out:
 		/* restore previous offset and sizes */
-		md->la_size_sect = prev.last_agreed_sect;
+		md->effective_size = prev.effective_size;
 		md->md_offset = prev.md_offset;
 		md->al_offset = prev.al_offset;
 		md->bm_offset = prev.bm_offset;
@@ -1119,57 +1670,195 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		md->al_stripe_size_4k = prev.al_stripe_size_4k;
 		md->al_size_4k = (u64)prev.al_stripes * prev.al_stripe_size_4k;
 	}
+	drbd_md_put_buffer(device);
+	if (device->bitmap)
+		drbd_bm_unlock(device);
 	lc_unlock(device->act_log);
 	wake_up(&device->al_wait);
-	drbd_md_put_buffer(device);
 	drbd_resume_io(device);
 
 	return rv;
 }
 
-sector_t
-drbd_new_dev_size(struct drbd_device *device, struct drbd_backing_dev *bdev,
-		  sector_t u_size, int assume_peer_has_space)
+/**
+ * get_max_agreeable_size()
+ * @device: DRBD device
+ * @max: Pointer to store the maximum agreeable size in
+ * @twopc_reachable_nodes: Bitmap of reachable nodes from two-phase-commit reply
+ *
+ * Check if all peer devices that have bitmap slots assigned in the metadata
+ * are connected.
+ */
+static bool get_max_agreeable_size(struct drbd_device *device, uint64_t *max,
+		uint64_t twopc_reachable_nodes)
 {
-	sector_t p_size = device->p_size;   /* partner's disk size. */
-	sector_t la_size_sect = bdev->md.la_size_sect; /* last agreed size. */
-	sector_t m_size; /* my size */
-	sector_t size = 0;
+	int node_id;
+	bool all_known;
 
-	m_size = drbd_get_max_capacity(bdev);
-
-	if (device->state.conn < C_CONNECTED && assume_peer_has_space) {
-		drbd_warn(device, "Resize while not connected was forced by the user!\n");
-		p_size = m_size;
-	}
+	all_known = true;
+	rcu_read_lock();
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		struct drbd_peer_md *peer_md = &device->ldev->md.peers[node_id];
+		struct drbd_peer_device *peer_device;
 
-	if (p_size && m_size) {
-		size = min_t(sector_t, p_size, m_size);
-	} else {
-		if (la_size_sect) {
-			size = la_size_sect;
-			if (m_size && m_size < size)
-				size = m_size;
-			if (p_size && p_size < size)
-				size = p_size;
+		if (device->ldev->md.node_id == node_id) {
+			dynamic_drbd_dbg(device, "my node_id: %u\n", node_id);
+			continue; /* skip myself... */
+		}
+		/* peer_device may be NULL if we don't have a connection to that node. */
+		peer_device = peer_device_by_node_id(device, node_id);
+		if (twopc_reachable_nodes & NODE_MASK(node_id)) {
+			uint64_t size = device->resource->twopc_reply.max_possible_size;
+
+			/* That is the minimum over all of them.  Prefer the
+			 * answer this peer gave us itself, where TWOPC_YES says
+			 * it belongs to this transaction; a relay answers with
+			 * the minimum over the nodes behind it, so neither is
+			 * above what the peer can do.  A cache pinned below a
+			 * peer's own maximum keeps the cluster from growing
+			 * into it: P_SIZES advertises the minimum over these.
+			 */
+			if (peer_device &&
+			    test_bit(TWOPC_YES, &peer_device->connection->flags) &&
+			    peer_device->max_size > size)
+				size = peer_device->max_size;
+
+			dynamic_drbd_dbg(device, "node_id: %u, twopc YES for max_size: %llu\n",
+					node_id, (unsigned long long)size);
+
+			/* Update our cached information, they said "yes".
+			 * Note:
+			 * d_size == 0 indicates diskless peer, or not directly
+			 * connected.  It will be ignored by the min_not_zero()
+			 * aggregation elsewhere.  Only reset if size > d_size
+			 * here.  Once we really commit the change, this will
+			 * also be assigned if it was a shrinkage.
+			 */
+			if (peer_device) {
+				if (peer_device->d_size && size > peer_device->d_size)
+					peer_device->d_size = size;
+				if (size > peer_device->max_size)
+					peer_device->max_size = size;
+			}
+			continue;
+		}
+		if (peer_device) {
+			enum drbd_disk_state pdsk = peer_device->disk_state[NOW];
+
+			dynamic_drbd_dbg(peer_device, "node_id: %u idx: %u bm-uuid: 0x%llx flags: 0x%lx max_size: %llu (%s)\n",
+					node_id,
+					peer_md->bitmap_index,
+					peer_md->bitmap_uuid,
+					peer_md->flags,
+					peer_device->max_size,
+					drbd_disk_str(pdsk));
+
+			if (test_bit(HAVE_SIZES, peer_device->flags)) {
+				/* If we still can see it, consider its last
+				 * known size, even if it may have meanwhile
+				 * detached from its disk.
+				 * If we no longer see it, we may want to
+				 * ignore the size we last knew, and
+				 * "assume_peer_has_space".  */
+				*max = min_not_zero(*max, peer_device->max_size);
+				continue;
+			}
 		} else {
-			if (m_size)
-				size = m_size;
-			if (p_size)
-				size = p_size;
+			dynamic_drbd_dbg(device, "node_id: %u idx: %u bm-uuid: 0x%llx flags: 0x%lx (not currently reachable)\n",
+					node_id,
+					peer_md->bitmap_index,
+					peer_md->bitmap_uuid,
+					peer_md->flags);
 		}
+		/* Even the currently diskless peer does not really know if it
+		 * is diskless on purpose (a "DRBD client") or if it just was
+		 * not possible to attach (backend device gone for some
+		 * reason).  But we remember in our meta data if we have ever
+		 * seen a peer disk for this peer.  If we did not ever see a
+		 * peer disk, and it is not configured with a bitmap either,
+		 * assume that's intentional.
+		 */
+		if (!test_bit(__MDF_PEER_DEVICE_SEEN, &peer_md->flags) &&
+		    !(peer_device && want_bitmap(peer_device)))
+			continue;
+
+		all_known = false;
+		/* don't break yet, min aggregation may still find a peer */
 	}
+	rcu_read_unlock();
+	return all_known;
+}
+
+#define DDUMP_LLU(d, x) do { dynamic_drbd_dbg(d, "%u: " #x ": %llu\n", __LINE__, (unsigned long long)x); } while (0)
+
+/* MUST hold a reference on ldev. */
+sector_t
+drbd_new_dev_size(struct drbd_device *device,
+		sector_t agreed_max_size, /* with DDSF_2PC: what the reachable nodes agreed to */
+		sector_t user_capped_size, /* want (at most) this much */
+		enum dds_flags flags)
+{
+	struct drbd_resource *resource = device->resource;
+	uint64_t p_size = 0;
+	uint64_t la_size = device->ldev->md.effective_size; /* last agreed size */
+	uint64_t m_size; /* my size */
+	uint64_t size = 0;
+	bool all_known_connected;
+
+	/* If there are reachable_nodes, get_max_agreeable_size() will
+	 * also aggregate the twopc.resize.new_size into their d_size
+	 * and max_size.  Do that first, so drbd_partition_data_capacity()
+	 * can use that new knowledge.
+	 */
 
+	all_known_connected = get_max_agreeable_size(device, &p_size,
+		flags & DDSF_2PC ? resource->twopc_reply.reachable_nodes : 0);
+	/* A node the transaction reached through a relay may have no peer
+	 * device here, or a diskless one, so its answer can be missing from
+	 * every cache above.  Take the aggregate as a term of its own, or the
+	 * result could exceed what that node can do.
+	 */
+	if (flags & DDSF_2PC)
+		p_size = min_not_zero(p_size, (uint64_t)agreed_max_size);
+	m_size = drbd_partition_data_capacity(device);
+
+	if (all_known_connected) {
+		/* If we currently can see all peer devices,
+		 * and p_size is still 0, apparently all our peers have been
+		 * diskless, always.  If we have the only persistent backend,
+		 * only our size counts. */
+		DDUMP_LLU(device, p_size);
+		DDUMP_LLU(device, m_size);
+		p_size = min_not_zero(p_size, m_size);
+	} else if (flags & DDSF_ASSUME_UNCONNECTED_PEER_HAS_SPACE) {
+		DDUMP_LLU(device, p_size);
+		DDUMP_LLU(device, m_size);
+		DDUMP_LLU(device, la_size);
+		p_size = min_not_zero(p_size, m_size);
+		if (p_size > la_size)
+			drbd_warn(device, "Resize forced while not fully connected!\n");
+	} else {
+		DDUMP_LLU(device, p_size);
+		DDUMP_LLU(device, m_size);
+		DDUMP_LLU(device, la_size);
+		/* We currently cannot see all peer devices,
+		 * fall back to what we last agreed upon. */
+		p_size = min_not_zero(p_size, la_size);
+	}
+
+	DDUMP_LLU(device, p_size);
+	DDUMP_LLU(device, m_size);
+	size = min_not_zero(p_size, m_size);
+	DDUMP_LLU(device, size);
 	if (size == 0)
-		drbd_err(device, "Both nodes diskless!\n");
+		drbd_err(device, "All nodes diskless!\n");
 
-	if (u_size) {
-		if (u_size > size)
-			drbd_err(device, "Requested disk size is too big (%lu > %lu)\n",
-			    (unsigned long)u_size>>1, (unsigned long)size>>1);
-		else
-			size = u_size;
-	}
+	if (user_capped_size > size)
+		drbd_err(device, "Requested disk size is too big (%llu > %llu)kiB\n",
+		    (unsigned long long)user_capped_size>>1,
+		    (unsigned long long)size>>1);
+	else if (user_capped_size)
+		size = user_capped_size;
 
 	return size;
 }
@@ -1182,7 +1871,7 @@ drbd_new_dev_size(struct drbd_device *device, struct drbd_backing_dev *bdev,
  * failed, and 0 on success. You should call drbd_md_sync() after you called
  * this function.
  */
-static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
+static int drbd_check_al_size(struct drbd_device *device, struct drbd_disk_conf *dc)
 {
 	struct lru_cache *n, *t;
 	struct lc_element *e;
@@ -1221,57 +1910,58 @@ static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
 		return -EBUSY;
 	} else {
 		lc_destroy(t);
+		device->al_writ_cnt = 0;
+		memset(device->al_histogram, 0, sizeof(device->al_histogram));
 	}
 	drbd_md_mark_dirty(device); /* we changed device->act_log->nr_elemens */
 	return 0;
 }
 
-static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
+static u32 common_connection_features(struct drbd_resource *resource)
 {
-	/*
-	 * We may ignore peer limits if the peer is modern enough.  From 8.3.8
-	 * onwards the peer can use multiple BIOs for a single peer_request.
-	 */
-	if (device->state.conn < C_WF_REPORT_PARAMS)
-		return device->peer_max_bio_size;
-
-	if (first_peer_device(device)->connection->agreed_pro_version < 94)
-		return min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
+	struct drbd_connection *connection;
+	u32 features = -1;
 
-	/*
-	 * Correct old drbd (up to 8.3.7) if it believes it can do more than
-	 * 32KiB.
-	 */
-	if (first_peer_device(device)->connection->agreed_pro_version == 94)
-		return DRBD_MAX_SIZE_H80_PACKET;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection->cstate[NOW] < C_CONNECTED)
+			continue;
+		features &= connection->agreed_features;
+	}
+	rcu_read_unlock();
 
-	/*
-	 * drbd 8.3.8 onwards, before 8.4.0
-	 */
-	if (first_peer_device(device)->connection->agreed_pro_version < 100)
-		return DRBD_MAX_BIO_SIZE_P95;
-	return DRBD_MAX_BIO_SIZE;
+	return features;
 }
 
-static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
+static unsigned int drbd_max_discard_sectors(struct drbd_resource *resource)
 {
-	/* when we introduced REQ_WRITE_SAME support, we also bumped
+	struct drbd_connection *connection;
+	unsigned int s = DRBD_MAX_BBIO_SECTORS;
+
+	/* when we introduced WRITE_SAME support, we also bumped
 	 * our maximum supported batch bio size used for discards. */
-	if (connection->agreed_features & DRBD_FF_WSAME)
-		return DRBD_MAX_BBIO_SECTORS;
-	/* before, with DRBD <= 8.4.6, we only allowed up to one AL_EXTENT_SIZE. */
-	return AL_EXTENT_SIZE >> 9;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (connection->cstate[NOW] == C_CONNECTED &&
+		    !(connection->agreed_features & DRBD_FF_WSAME)) {
+			/* before, with DRBD <= 8.4.6, we only allowed up to one AL_EXTENT_SIZE. */
+			s = AL_EXTENT_SIZE >> SECTOR_SHIFT;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return s;
 }
 
-static bool drbd_discard_supported(struct drbd_connection *connection,
+static bool drbd_discard_supported(struct drbd_device *device,
 		struct drbd_backing_dev *bdev)
 {
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
 		return false;
 
-	if (connection->cstate >= C_CONNECTED &&
-	    !(connection->agreed_features & DRBD_FF_TRIM)) {
-		drbd_info(connection,
+	if (!(common_connection_features(device->resource) & DRBD_FF_TRIM)) {
+		drbd_info(device,
 			"peer DRBD too old, does not support TRIM: disabling discards\n");
 		return false;
 	}
@@ -1279,85 +1969,75 @@ static bool drbd_discard_supported(struct drbd_connection *connection,
 	return true;
 }
 
-/* This is the workaround for "bio would need to, but cannot, be split" */
-static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
+static void get_common_queue_limits(struct queue_limits *common_limits,
+		struct drbd_device *device)
 {
-	unsigned int max_segments;
+	struct drbd_peer_device *peer_device;
+	struct queue_limits peer_limits = { 0 };
+
+	blk_set_stacking_limits(common_limits);
+	common_limits->max_hw_sectors = device->device_conf.max_bio_size >> SECTOR_SHIFT;
+	common_limits->max_sectors = device->device_conf.max_bio_size >> SECTOR_SHIFT;
+	common_limits->physical_block_size = device->device_conf.block_size;
+	common_limits->logical_block_size = device->device_conf.block_size;
+	common_limits->io_min = device->device_conf.block_size;
+	common_limits->max_hw_zone_append_sectors = 0;
 
 	rcu_read_lock();
-	max_segments = rcu_dereference(device->ldev->disk_conf)->max_bio_bvecs;
+	for_each_peer_device_rcu(peer_device, device) {
+		if (!test_bit(HAVE_SIZES, peer_device->flags) &&
+		    peer_device->repl_state[NOW] < L_ESTABLISHED)
+			continue;
+		blk_set_stacking_limits(&peer_limits);
+		peer_limits.logical_block_size = peer_device->q_limits.logical_block_size;
+		peer_limits.physical_block_size = peer_device->q_limits.physical_block_size;
+		peer_limits.alignment_offset = peer_device->q_limits.alignment_offset;
+		peer_limits.io_min = peer_device->q_limits.io_min;
+		peer_limits.io_opt = peer_device->q_limits.io_opt;
+		peer_limits.max_hw_sectors = peer_device->q_limits.max_bio_size >> SECTOR_SHIFT;
+		peer_limits.max_sectors = peer_device->q_limits.max_bio_size >> SECTOR_SHIFT;
+		blk_stack_limits(common_limits, &peer_limits, 0);
+	}
 	rcu_read_unlock();
-
-	if (!max_segments)
-		return BLK_MAX_SEGMENTS;
-	return max_segments;
 }
 
-void drbd_reconsider_queue_parameters(struct drbd_device *device,
-		struct drbd_backing_dev *bdev, struct o_qlim *o)
+void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev)
 {
-	struct drbd_connection *connection =
-		first_peer_device(device)->connection;
 	struct request_queue * const q = device->rq_queue;
-	unsigned int now = queue_max_hw_sectors(q) << 9;
 	struct queue_limits lim;
 	struct request_queue *b = NULL;
-	unsigned int new;
-
-	if (bdev) {
-		b = bdev->backing_bdev->bd_disk->queue;
-
-		device->local_max_bio_size =
-			queue_max_hw_sectors(b) << SECTOR_SHIFT;
-	}
-
-	/*
-	 * We may later detach and re-attach on a disconnected Primary.  Avoid
-	 * decreasing the value in this case.
-	 *
-	 * We want to store what we know the peer DRBD can handle, not what the
-	 * peer IO backend can handle.
-	 */
-	new = min3(DRBD_MAX_BIO_SIZE, device->local_max_bio_size,
-		max(drbd_max_peer_bio_size(device), device->peer_max_bio_size));
-	if (new != now) {
-		if (device->state.role == R_PRIMARY && new < now)
-			drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n",
-					new, now);
-		drbd_info(device, "max BIO size = %u\n", new);
-	}
 
 	lim = queue_limits_start_update(q);
-	if (bdev) {
-		blk_set_stacking_limits(&lim);
-		lim.max_segments = drbd_backing_dev_max_segments(device);
-	} else {
-		lim.max_segments = BLK_MAX_SEGMENTS;
-		lim.features = BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
-			       BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES;
-	}
-
-	lim.max_hw_sectors = new >> SECTOR_SHIFT;
-	lim.seg_boundary_mask = PAGE_SIZE - 1;
+	get_common_queue_limits(&lim, device);
 
 	/*
-	 * We don't care for the granularity, really.
-	 *
-	 * Stacking limits below should fix it for the local device.  Whether or
-	 * not it is a suitable granularity on the remote device is not our
-	 * problem, really. If you care, you need to use devices with similar
-	 * topology on all peers.
+	 * discard_granularity == DRBD_DISCARD_GRANULARITY_DEF (sentinel):
+	 *   not explicitly configured; use the legacy heuristic
+	 *   (drbd_discard_supported decides, granularity=512).
+	 * discard_granularity == 0: explicitly disable discards.
+	 * discard_granularity > 0: use the configured value and enable discards
+	 *   unconditionally (e.g. LINSTOR knows the real granularity from
+	 *   storage pool info and configures it for diskless primaries or to
+	 *   advertise a larger granularity than strictly required).
 	 */
-	if (drbd_discard_supported(connection, bdev)) {
-		lim.discard_granularity = 512;
-		lim.max_hw_discard_sectors =
-			drbd_max_discard_sectors(connection);
+	if (device->device_conf.discard_granularity == DRBD_DISCARD_GRANULARITY_DEF) {
+		if (drbd_discard_supported(device, bdev)) {
+			lim.discard_granularity = 512;
+			lim.max_hw_discard_sectors = drbd_max_discard_sectors(device->resource);
+		} else {
+			lim.discard_granularity = 0;
+			lim.max_hw_discard_sectors = 0;
+		}
+	} else if (device->device_conf.discard_granularity) {
+		lim.discard_granularity = device->device_conf.discard_granularity;
+		lim.max_hw_discard_sectors = drbd_max_discard_sectors(device->resource);
 	} else {
 		lim.discard_granularity = 0;
 		lim.max_hw_discard_sectors = 0;
 	}
 
 	if (bdev) {
+		b = bdev->backing_bdev->bd_disk->queue;
 		blk_stack_limits(&lim, &b->limits, 0);
 		/*
 		 * blk_set_stacking_limits() cleared the features, and
@@ -1374,14 +2054,28 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		 *    receiver will detect a checksum mismatch.
 		 */
 		lim.features |= BLK_FEAT_STABLE_WRITES;
+
+		/*
+		 * blk_stack_limits() uses max() for discard_granularity and
+		 * min_not_zero() for max_hw_discard_sectors, both of which can
+		 * re-enable discards from the backing device even when the user
+		 * explicitly disabled them (discard_granularity == 0).
+		 */
+		if (device->device_conf.discard_granularity == 0) {
+			lim.discard_granularity = 0;
+			lim.max_hw_discard_sectors = 0;
+		}
+	} else {
+		lim.features = BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+			       BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES;
 	}
 
 	/*
-	 * If we can handle "zeroes" efficiently on the protocol, we want to do
-	 * that, even if our backend does not announce max_write_zeroes_sectors
-	 * itself.
+	 * If we can handle "zeroes" efficiently on the protocol,
+	 * we want to do that, even if our backend does not announce
+	 * max_write_zeroes_sectors itself.
 	 */
-	if (connection->agreed_features & DRBD_FF_WZEROES)
+	if (common_connection_features(device->resource) & DRBD_FF_WZEROES)
 		lim.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
 	else
 		lim.max_write_zeroes_sectors = 0;
@@ -1389,6 +2083,11 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 
 	if ((lim.discard_granularity >> SECTOR_SHIFT) >
 	    lim.max_hw_discard_sectors) {
+		/*
+		 * discard_granularity is the smallest supported unit of a
+		 * discard. If that is larger than the maximum supported discard
+		 * size, we need to disable discards altogether.
+		 */
 		lim.discard_granularity = 0;
 		lim.max_hw_discard_sectors = 0;
 	}
@@ -1397,58 +2096,44 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		drbd_err(device, "setting new queue limits failed\n");
 }
 
-/* Starts the worker thread */
-static void conn_reconfig_start(struct drbd_connection *connection)
+/* Make sure IO is suspended before calling this function(). */
+static void drbd_try_suspend_al(struct drbd_device *device)
 {
-	drbd_thread_start(&connection->worker);
-	drbd_flush_workqueue(&connection->sender_work);
-}
+	struct drbd_peer_device *peer_device;
+	bool suspend = true;
+	int max_peers = device->ldev->md.max_peers, bitmap_index;
 
-/* if still unconfigured, stops worker again. */
-static void conn_reconfig_done(struct drbd_connection *connection)
-{
-	bool stop_threads;
-	spin_lock_irq(&connection->resource->req_lock);
-	stop_threads = conn_all_vols_unconf(connection) &&
-		connection->cstate == C_STANDALONE;
-	spin_unlock_irq(&connection->resource->req_lock);
-	if (stop_threads) {
-		/* ack_receiver thread and ack_sender workqueue are implicitly
-		 * stopped by receiver in conn_disconnect() */
-		drbd_thread_stop(&connection->receiver);
-		drbd_thread_stop(&connection->worker);
+	if (device->bitmap) {
+		for (bitmap_index = 0; bitmap_index < max_peers; bitmap_index++) {
+			if (_drbd_bm_total_weight(device, bitmap_index) != drbd_bm_bits(device))
+				return;
+		}
 	}
-}
 
-/* Make sure IO is suspended before calling this function(). */
-static void drbd_suspend_al(struct drbd_device *device)
-{
-	int s = 0;
-
-	if (!lc_try_lock(device->act_log)) {
-		drbd_warn(device, "Failed to lock al in drbd_suspend_al()\n");
+	if (!drbd_al_try_lock(device)) {
+		drbd_warn(device, "Failed to lock al in %s()", __func__);
 		return;
 	}
 
 	drbd_al_shrink(device);
-	spin_lock_irq(&device->resource->req_lock);
-	if (device->state.conn < C_CONNECTED)
-		s = !test_and_set_bit(AL_SUSPENDED, &device->flags);
-	spin_unlock_irq(&device->resource->req_lock);
+	read_lock_irq(&device->resource->state_rwlock);
+	for_each_peer_device(peer_device, device) {
+		if (peer_device->repl_state[NOW] >= L_ESTABLISHED) {
+			suspend = false;
+			break;
+		}
+	}
+	if (suspend)
+		suspend = !test_and_set_bit(AL_SUSPENDED, &device->flags);
+	read_unlock_irq(&device->resource->state_rwlock);
 	lc_unlock(device->act_log);
+	wake_up(&device->al_wait);
 
-	if (s)
+	if (suspend)
 		drbd_info(device, "Suspended AL updates\n");
 }
 
 
-static bool should_set_defaults(struct genl_info *info)
-{
-	struct drbd_genlmsghdr *dh = genl_info_userhdr(info);
-
-	return 0 != (dh->flags & DRBD_GENL_F_SET_DEFAULTS);
-}
-
 static unsigned int drbd_al_extents_max(struct drbd_backing_dev *bdev)
 {
 	/* This is limited by 16 bit "slot" numbers,
@@ -1466,7 +2151,7 @@ static unsigned int drbd_al_extents_max(struct drbd_backing_dev *bdev)
 	 */
 	const unsigned int max_al_nr = DRBD_AL_EXTENTS_MAX;
 	const unsigned int sufficient_on_disk =
-		(max_al_nr + AL_CONTEXT_PER_TRANSACTION -1)
+		(max_al_nr + AL_CONTEXT_PER_TRANSACTION - 1)
 		/AL_CONTEXT_PER_TRANSACTION;
 
 	unsigned int al_size_4k = bdev->md.al_size_4k;
@@ -1477,14 +2162,14 @@ static unsigned int drbd_al_extents_max(struct drbd_backing_dev *bdev)
 	return (al_size_4k - 1) * AL_CONTEXT_PER_TRANSACTION;
 }
 
-static bool write_ordering_changed(struct disk_conf *a, struct disk_conf *b)
+static bool write_ordering_changed(struct drbd_disk_conf *a, struct drbd_disk_conf *b)
 {
 	return	a->disk_barrier != b->disk_barrier ||
 		a->disk_flushes != b->disk_flushes ||
 		a->disk_drain != b->disk_drain;
 }
 
-static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *disk_conf,
+static void sanitize_disk_conf(struct drbd_device *device, struct drbd_disk_conf *disk_conf,
 			       struct drbd_backing_dev *nbc)
 {
 	struct block_device *bdev = nbc->backing_bdev;
@@ -1501,29 +2186,51 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
 		}
 	}
 
+	/* To be effective, rs_discard_granularity must not be larger than the
+	 * maximum resync request size, and multiple of 4k
+	 * (preferably a power-of-two multiple 4k).
+	 * See also make_resync_request().
+	 * That also means that if q->limits.discard_granularity or
+	 * q->limits.discard_alignment are "odd", rs_discard_granularity won't
+	 * be particularly effective, or not effective at all.
+	 */
 	if (disk_conf->rs_discard_granularity) {
-		int orig_value = disk_conf->rs_discard_granularity;
-		sector_t discard_size = bdev_max_discard_sectors(bdev) << 9;
+		unsigned int new_discard_granularity =
+			disk_conf->rs_discard_granularity;
+		unsigned int discard_sectors = bdev_max_discard_sectors(bdev);
 		unsigned int discard_granularity = bdev_discard_granularity(bdev);
-		int remainder;
 
-		if (discard_granularity > disk_conf->rs_discard_granularity)
-			disk_conf->rs_discard_granularity = discard_granularity;
-
-		remainder = disk_conf->rs_discard_granularity %
-				discard_granularity;
-		disk_conf->rs_discard_granularity += remainder;
-
-		if (disk_conf->rs_discard_granularity > discard_size)
-			disk_conf->rs_discard_granularity = discard_size;
-
-		if (disk_conf->rs_discard_granularity != orig_value)
+		/* should be at least the discard_granularity of the bdev,
+		 * and preferably a multiple (or the backend won't be able to
+		 * discard some of the "cuttings").
+		 * This also sanitizes nonsensical settings like "77 byte".
+		 */
+		new_discard_granularity = roundup(new_discard_granularity,
+				discard_granularity);
+
+		/* more than the max resync request size won't work anyways */
+		discard_sectors = min(discard_sectors,
+				DRBD_RS_DISCARD_GRANULARITY_MAX >> SECTOR_SHIFT);
+		/* Avoid compiler warning about truncated integer.
+		 * The min() above made sure the result fits even after left shift. */
+		new_discard_granularity = min(
+				new_discard_granularity >> SECTOR_SHIFT,
+				discard_sectors) << SECTOR_SHIFT;
+		/* less than the backend discard granularity is allowed if
+		   the backend granularity is a multiple of the configured value */
+		if (new_discard_granularity < discard_granularity &&
+		    discard_granularity % new_discard_granularity != 0)
+			new_discard_granularity = 0;
+
+		if (disk_conf->rs_discard_granularity != new_discard_granularity) {
 			drbd_info(device, "rs_discard_granularity changed to %d\n",
-				  disk_conf->rs_discard_granularity);
+					new_discard_granularity);
+			disk_conf->rs_discard_granularity = new_discard_granularity;
+		}
 	}
 }
 
-static int disk_opts_check_al_size(struct drbd_device *device, struct disk_conf *dc)
+static int disk_opts_check_al_size(struct drbd_device *device, struct drbd_disk_conf *dc)
 {
 	int err = -EBUSY;
 
@@ -1531,13 +2238,13 @@ static int disk_opts_check_al_size(struct drbd_device *device, struct disk_conf
 	    device->act_log->nr_elements == dc->al_extents)
 		return 0;
 
-	drbd_suspend_io(device);
+	drbd_suspend_io(device, READ_AND_WRITE);
 	/* If IO completion is currently blocked, we would likely wait
 	 * "forever" for the activity log to become unused. So we don't. */
-	if (atomic_read(&device->ap_bio_cnt))
+	if (atomic_read(&device->ap_bio_cnt[WRITE]) || atomic_read(&device->ap_bio_cnt[READ]))
 		goto out;
 
-	wait_event(device->al_wait, lc_try_lock(device->act_log));
+	wait_event(device->al_wait, drbd_al_try_lock(device));
 	drbd_al_shrink(device);
 	err = drbd_check_al_size(device, dc);
 	lc_unlock(device->act_log);
@@ -1547,25 +2254,108 @@ static int disk_opts_check_al_size(struct drbd_device *device, struct disk_conf
 	return err;
 }
 
-int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
+static struct drbd_connection *the_only_peer_with_disk(struct drbd_device *device,
+						       enum which_state which)
+{
+	const int my_node_id = device->resource->res_opts.node_id;
+	struct drbd_peer_md *peer_md = device->ldev->md.peers;
+	struct drbd_connection *connection = NULL;
+	struct drbd_peer_device *peer_device;
+	int node_id, peer_disks = 0;
+
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		if (node_id == my_node_id)
+			continue;
+
+		if (test_bit(__MDF_PEER_DEVICE_SEEN, &peer_md[node_id].flags))
+			peer_disks++;
+
+		if (peer_disks > 1)
+			return NULL;
+
+		peer_device = peer_device_by_node_id(device, node_id);
+		if (peer_device) {
+			enum drbd_disk_state pdsk = peer_device->disk_state[which];
+
+			if (pdsk >= D_INCONSISTENT && pdsk != D_UNKNOWN)
+				connection = peer_device->connection;
+		}
+	}
+	return connection;
+}
+
+static void __update_mdf_al_disabled(struct drbd_device *device, bool al_updates,
+				     enum which_state which)
+{
+	struct drbd_md *md = &device->ldev->md;
+	struct drbd_connection *peer = NULL;
+	bool al_updates_old = !(md->flags & MDF_AL_DISABLED);
+	bool optimized = false;
+
+	if (al_updates)
+		peer = the_only_peer_with_disk(device, which);
+
+	if (device->bitmap == NULL ||
+	    (al_updates && device->ldev->md.max_peers == 1 &&
+	    peer && peer->peer_role[which] == R_PRIMARY &&
+	    device->resource->role[which] == R_SECONDARY)) {
+		al_updates = false;
+		optimized = true;
+	}
+
+	if (al_updates_old == al_updates)
+		return;
+
+	if (al_updates) {
+		drbd_info(device, "Enabling local AL-updates\n");
+		md->flags &= ~MDF_AL_DISABLED;
+	} else {
+		drbd_info(device, "Disabling local AL-updates %s\n",
+			  optimized ? "(optimization)" : "(config)");
+		md->flags |= MDF_AL_DISABLED;
+	}
+	drbd_md_mark_dirty(device);
+}
+
+/**
+ * drbd_update_mdf_al_disabled() - update the MDF_AL_DISABLED bit in md.flags
+ * @device: DRBD device
+ * @which: OLD or NEW
+ *
+ * This function also optimizes performance by turning off al-updates when:
+ * - the cluster has only two nodes with backing disk
+ * - the other node with a backing disk is the primary
+ */
+void drbd_update_mdf_al_disabled(struct drbd_device *device, enum which_state which)
+{
+	bool al_updates;
+
+	if (!get_ldev(device))
+		return;
+
+	rcu_read_lock();
+	al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
+	rcu_read_unlock();
+	__update_mdf_al_disabled(device, al_updates, which);
+
+	put_ldev(device);
+}
+
+int drbd_adm_disk_opts(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
+	enum drbd_ret_code retcode = NO_ERROR;
 	struct drbd_device *device;
-	struct disk_conf *new_disk_conf, *old_disk_conf;
-	struct fifo_buffer *old_plan = NULL, *new_plan = NULL;
-	struct nlattr **ntb;
+	struct drbd_resource *resource;
+	struct drbd_disk_conf *new_disk_conf, *old_disk_conf;
+	struct drbd_peer_device *peer_device;
 	int err;
-	unsigned int fifo_size;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
 
 	device = adm_ctx->device;
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	resource = device->resource;
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
 
 	/* we also need a disk
 	 * to change the options on */
@@ -1574,69 +2364,83 @@ int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	new_disk_conf = kmalloc_obj(struct disk_conf);
+	new_disk_conf = kmalloc_obj(struct drbd_disk_conf);
 	if (!new_disk_conf) {
 		retcode = ERR_NOMEM;
 		goto fail;
 	}
 
-	mutex_lock(&device->resource->conf_update);
+	mutex_lock(&resource->conf_update);
 	old_disk_conf = device->ldev->disk_conf;
 	*new_disk_conf = *old_disk_conf;
-	if (should_set_defaults(info))
-		set_disk_conf_defaults(new_disk_conf);
+	if (adm_ctx->set_defaults)
+		drbd_set_disk_conf_defaults(new_disk_conf);
 
-	err = disk_conf_from_attrs(new_disk_conf, info);
+	err = drbd_adm_overlay_disk_conf(adm_ctx, new_disk_conf);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+		drbd_adm_msg_overlay_error(adm_ctx, err);
 		goto fail_unlock;
 	}
 
-	err = disk_conf_ntb_from_attrs(&ntb, info);
-	if (!err) {
-		if (has_invariant(ntb, DRBD_A_DISK_CONF_BACKING_DEV) ||
-		    has_invariant(ntb, DRBD_A_DISK_CONF_META_DEV) ||
-		    has_invariant(ntb, DRBD_A_DISK_CONF_META_DEV_IDX) ||
-		    has_invariant(ntb, DRBD_A_DISK_CONF_DISK_SIZE) ||
-		    has_invariant(ntb, DRBD_A_DISK_CONF_MAX_BIO_BVECS)) {
-			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb,
-				"cannot change invariant setting");
-			kfree(ntb);
-			goto fail_unlock;
-		}
-		kfree(ntb);
+	if (adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_DISK_BACKING_DEV) ||
+	    adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_DISK_META_DEV) ||
+	    adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_DISK_META_DEV_IDX) ||
+	    adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_DISK_SIZE)) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg(adm_ctx, "%s", "cannot change invariant setting");
+		goto fail_unlock;
 	}
 
-	if (!expect(device, new_disk_conf->resync_rate >= 1))
-		new_disk_conf->resync_rate = 1;
-
 	sanitize_disk_conf(device, new_disk_conf, device->ldev);
 
-	if (new_disk_conf->c_plan_ahead > DRBD_C_PLAN_AHEAD_MAX)
-		new_disk_conf->c_plan_ahead = DRBD_C_PLAN_AHEAD_MAX;
-
-	fifo_size = (new_disk_conf->c_plan_ahead * 10 * SLEEP_TIME) / HZ;
-	if (fifo_size != device->rs_plan_s->size) {
-		new_plan = fifo_alloc(fifo_size);
-		if (!new_plan) {
-			drbd_err(device, "kmalloc of fifo_buffer failed");
-			retcode = ERR_NOMEM;
-			goto fail_unlock;
-		}
-	}
-
 	err = disk_opts_check_al_size(device, new_disk_conf);
 	if (err) {
 		/* Could be just "busy". Ignore?
 		 * Introduce dedicated error code? */
-		drbd_msg_put_info(adm_ctx->reply_skb,
+		drbd_adm_msg(adm_ctx, "%s",
 			"Try again without changing current al-extents setting");
 		retcode = ERR_NOMEM;
 		goto fail_unlock;
 	}
 
+	if (!old_disk_conf->d_bitmap && new_disk_conf->d_bitmap) {
+		struct drbd_md *md = &device->ldev->md;
+		struct drbd_bitmap *bitmap;
+
+		bitmap = drbd_bm_alloc(md->max_peers, md->bm_block_shift);
+		if (!bitmap) {
+			drbd_adm_msg(adm_ctx, "%s", "Failed to allocate bitmap");
+			retcode = ERR_NOMEM;
+			goto fail_unlock;
+		}
+		_drbd_bm_lock(device, bitmap, NULL, __func__, BM_LOCK_ALL);
+		err = drbd_bm_resize(device, bitmap, get_capacity(device->vdisk), true);
+		_drbd_bm_unlock(device, bitmap);
+		if (err) {
+			kfree(bitmap);
+			drbd_adm_msg(adm_ctx, "%s", "Failed to allocate bitmap pages");
+			retcode = ERR_NOMEM;
+			goto fail_unlock;
+		}
+
+		/* Publish only after bm_pages is populated, otherwise readers
+		 * in __bm_op() can observe device->bitmap != NULL with
+		 * bm_pages == NULL and trip the assertion.  No
+		 * smp_load_acquire() needed: bm_pages is always read under
+		 * bitmap->bm_lock, and lockless NULL-checks are ordered by
+		 * address dependency.
+		 */
+		smp_store_release(&device->bitmap, bitmap);
+
+		drbd_bitmap_io(device, &drbd_bm_write, "write from disk_opts", BM_LOCK_ALL, NULL);
+	} else if (old_disk_conf->d_bitmap && !new_disk_conf->d_bitmap) {
+		/* That would be quite some effort, and there is no use case for this */
+		drbd_adm_msg(adm_ctx, "%s", "Online freeing of the bitmap not supported");
+		retcode = ERR_INVALID_REQUEST;
+		goto fail_unlock;
+	}
+
 	lock_all_resources();
 	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
 	if (retcode == NO_ERROR) {
@@ -1648,1266 +2452,3289 @@ int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto fail_unlock;
 
-	if (new_plan) {
-		old_plan = device->rs_plan_s;
-		rcu_assign_pointer(device->rs_plan_s, new_plan);
-	}
-
-	mutex_unlock(&device->resource->conf_update);
+	mutex_unlock(&resource->conf_update);
 
-	if (new_disk_conf->al_updates)
-		device->ldev->md.flags &= ~MDF_AL_DISABLED;
-	else
-		device->ldev->md.flags |= MDF_AL_DISABLED;
+	__update_mdf_al_disabled(device, new_disk_conf->al_updates, NOW);
 
-	if (new_disk_conf->md_flushes)
-		clear_bit(MD_NO_FUA, &device->flags);
-	else
-		set_bit(MD_NO_FUA, &device->flags);
+	assign_bit(MD_NO_FUA, &device->flags, !new_disk_conf->md_flushes);
 
 	if (write_ordering_changed(old_disk_conf, new_disk_conf))
-		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
+		drbd_bump_write_ordering(device->resource, NULL, WO_BIO_BARRIER);
 
 	if (old_disk_conf->discard_zeroes_if_aligned !=
 	    new_disk_conf->discard_zeroes_if_aligned)
-		drbd_reconsider_queue_parameters(device, device->ldev, NULL);
-
-	drbd_md_sync(device);
+		drbd_reconsider_queue_parameters(device, device->ldev);
 
-	if (device->state.conn >= C_CONNECTED) {
-		struct drbd_peer_device *peer_device;
+	drbd_md_sync_if_dirty(device);
 
-		for_each_peer_device(peer_device, device)
+	for_each_peer_device(peer_device, device) {
+		if (peer_device->repl_state[NOW] >= L_ESTABLISHED)
 			drbd_send_sync_param(peer_device);
 	}
 
 	kvfree_rcu_mightsleep(old_disk_conf);
-	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
 
 fail_unlock:
-	mutex_unlock(&device->resource->conf_update);
+	mutex_unlock(&resource->conf_update);
  fail:
 	kfree(new_disk_conf);
-	kfree(new_plan);
 success:
+	if (retcode != NO_ERROR)
+		synchronize_rcu();
 	put_ldev(device);
  out:
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
- finish:
-	adm_ctx->reply_dh->ret_code = retcode;
+out_no_adm_mutex:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-static struct file *open_backing_dev(struct drbd_device *device,
-		const char *bdev_path, void *claim_ptr, bool do_bd_link)
+static void mutex_unlock_cond(struct mutex *mutex, bool *have_mutex)
 {
-	struct file *file;
-	int err = 0;
-
-	file = bdev_file_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				      claim_ptr, NULL);
-	if (IS_ERR(file)) {
-		drbd_err(device, "open(\"%s\") failed with %ld\n",
-				bdev_path, PTR_ERR(file));
-		return file;
+	if (*have_mutex) {
+		mutex_unlock(mutex);
+		*have_mutex = false;
 	}
+}
 
-	if (!do_bd_link)
-		return file;
+static void update_resource_dagtag(struct drbd_resource *resource, struct drbd_backing_dev *bdev)
+{
+	u64 dagtag = 0;
+	int node_id;
 
-	err = bd_link_disk_holder(file_bdev(file), device->vdisk);
-	if (err) {
-		fput(file);
-		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
-				bdev_path, err);
-		file = ERR_PTR(err);
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		struct drbd_peer_md *peer_md;
+
+		if (bdev->md.node_id == node_id)
+			continue;
+
+		peer_md = &bdev->md.peers[node_id];
+
+		if (peer_md->bitmap_uuid)
+			dagtag = max(peer_md->bitmap_dagtag, dagtag);
 	}
-	return file;
+
+	spin_lock_irq(&resource->tl_update_lock);
+	if (dagtag > resource->dagtag_sector) {
+		resource->dagtag_before_attach = resource->dagtag_sector;
+		resource->dagtag_from_backing_dev = dagtag;
+		WRITE_ONCE(resource->dagtag_sector, dagtag);
+	}
+	spin_unlock_irq(&resource->tl_update_lock);
 }
 
-static int open_backing_devices(struct drbd_device *device,
-		struct disk_conf *new_disk_conf,
-		struct drbd_backing_dev *nbc)
+static int used_bitmap_slots(struct drbd_backing_dev *bdev)
 {
-	struct file *file;
+	int node_id;
+	int used = 0;
 
-	file = open_backing_dev(device, new_disk_conf->backing_dev, device,
-				  true);
-	if (IS_ERR(file))
-		return ERR_OPEN_DISK;
-	nbc->backing_bdev = file_bdev(file);
-	nbc->backing_bdev_file = file;
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		struct drbd_peer_md *peer_md = &bdev->md.peers[node_id];
 
-	/*
-	 * meta_dev_idx >= 0: external fixed size, possibly multiple
-	 * drbd sharing one meta device.  TODO in that case, paranoia
-	 * check that [md_bdev, meta_dev_idx] is not yet used by some
-	 * other drbd minor!  (if you use drbd.conf + drbdadm, that
-	 * should check it for you already; but if you don't, or
-	 * someone fooled it, we need to double check here)
-	 */
-	file = open_backing_dev(device, new_disk_conf->meta_dev,
-		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
-		 * if potentially shared with other drbd minors */
-			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
-		/* avoid double bd_claim_by_disk() for the same (source,target) tuple,
-		 * as would happen with internal metadata. */
-			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
-			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
-	if (IS_ERR(file))
-		return ERR_OPEN_MD_DISK;
-	nbc->md_bdev = file_bdev(file);
-	nbc->f_md_bdev = file;
-	return NO_ERROR;
+		if (test_bit(__MDF_HAVE_BITMAP, &peer_md->flags))
+			used++;
+	}
+
+	return used;
 }
 
-static void close_backing_dev(struct drbd_device *device,
-		struct file *bdev_file, bool do_bd_unlink)
+static bool bitmap_index_vacant(struct drbd_backing_dev *bdev, int bitmap_index)
 {
-	if (!bdev_file)
-		return;
-	if (do_bd_unlink)
-		bd_unlink_disk_holder(file_bdev(bdev_file), device->vdisk);
-	fput(bdev_file);
+	int node_id;
+
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		struct drbd_peer_md *peer_md = &bdev->md.peers[node_id];
+
+		if (peer_md->bitmap_index == bitmap_index)
+			return false;
+	}
+	return true;
 }
 
-void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
+int drbd_unallocated_index(struct drbd_backing_dev *bdev)
 {
-	if (ldev == NULL)
-		return;
+	int bitmap_index;
+	int bm_max_peers = bdev->md.max_peers;
 
-	close_backing_dev(device, ldev->f_md_bdev,
-			  ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev_file, true);
+	for (bitmap_index = 0; bitmap_index < bm_max_peers; bitmap_index++) {
+		if (bitmap_index_vacant(bdev, bitmap_index))
+			return bitmap_index;
+	}
 
-	kfree(ldev->disk_conf);
-	kfree(ldev);
+	return -1;
 }
 
-int drbd_nl_attach_doit(struct sk_buff *skb, struct genl_info *info)
+static int
+allocate_bitmap_index(struct drbd_peer_device *peer_device,
+		      struct drbd_backing_dev *nbc)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct drbd_device *device;
-	struct drbd_peer_device *peer_device;
-	struct drbd_connection *connection;
-	int err;
-	enum drbd_ret_code retcode;
-	enum determine_dev_size dd;
-	sector_t max_possible_sectors;
-	sector_t min_md_device_sectors;
-	struct drbd_backing_dev *nbc = NULL; /* new_backing_conf */
-	struct disk_conf *new_disk_conf = NULL;
-	struct lru_cache *resync_lru = NULL;
-	struct fifo_buffer *new_plan = NULL;
-	union drbd_state ns, os;
-	enum drbd_state_rv rv;
-	struct net_conf *nc;
+	const int peer_node_id = peer_device->connection->peer_node_id;
+	struct drbd_peer_md *peer_md = &nbc->md.peers[peer_node_id];
+	int bitmap_index;
+
+	bitmap_index = drbd_unallocated_index(nbc);
+	if (bitmap_index == -1) {
+		drbd_err(peer_device, "Not enough free bitmap slots\n");
+		return -ENOSPC;
+	}
+
+	peer_md->bitmap_index = bitmap_index;
+	peer_device->bitmap_index = bitmap_index;
+	set_bit(__MDF_HAVE_BITMAP, &peer_md->flags);
+	/* The slot comes with the day-0 tracking bits of an unallocated slot,
+	 * or with whatever is on disk; neither says who set them. A record
+	 * this node id kept from an earlier peer does not describe them.
+	 */
+	peer_md->placeholder_src = 0;
+	peer_md->placeholder_src_complete = false;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
+	return 0;
+}
 
-	device = adm_ctx->device;
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	peer_device = first_peer_device(device);
-	connection = peer_device->connection;
-	conn_reconfig_start(connection);
+static struct drbd_peer_md *day0_peer_md(struct drbd_device *device)
+{
+	const int my_node_id = device->resource->res_opts.node_id;
+	struct drbd_peer_md *peer_md = device->ldev->md.peers;
+	int node_id;
 
-	/* if you want to reconfigure, please tear down first */
-	if (device->state.disk > D_DISKLESS) {
-		retcode = ERR_DISK_CONFIGURED;
-		goto fail;
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		if (node_id == my_node_id)
+			continue;
+		/* Only totally unused slots definitely contain the day0 UUID. */
+		if (peer_md[node_id].bitmap_index == -1 && !peer_md[node_id].flags)
+			return &peer_md[node_id];
 	}
-	/* It may just now have detached because of IO error.  Make sure
-	 * drbd_ldev_destroy is done already, we may end up here very fast,
-	 * e.g. if someone calls attach from the on-io-error handler,
-	 * to realize a "hot spare" feature (not that I'd recommend that) */
-	wait_event(device->misc_wait, !test_bit(GOING_DISKLESS, &device->flags));
+	return NULL;
+}
 
-	/* make sure there is no leftover from previous force-detach attempts */
-	clear_bit(FORCE_DETACH, &device->flags);
-	clear_bit(WAS_IO_ERROR, &device->flags);
-	clear_bit(WAS_READ_ERROR, &device->flags);
+/* Clear the flags in "mask", one bit at a time, so that a concurrent set_bit()
+ * on a flag outside the mask is not lost.
+ */
+static void clear_peer_md_flags(struct drbd_peer_md *peer_md, u32 mask)
+{
+	unsigned long bits = mask;
+	int bit;
 
-	/* and no leftover from previously aborted resync or verify, either */
-	device->rs_total = 0;
-	device->rs_failed = 0;
-	atomic_set(&device->rs_pending_cnt, 0);
+	for_each_set_bit(bit, &bits, 32)
+		clear_bit(bit, &peer_md->flags);
+}
+
+/*
+ * Clear the slot for this peer in the metadata. If md_flags is empty, clear
+ * the slot completely. Otherwise make it a slot for a diskless peer. Also
+ * clear any bitmap associated with this peer.
+ */
+static int clear_peer_slot(struct drbd_device *device, int peer_node_id, u32 md_flags)
+{
+	struct drbd_peer_md *peer_md, *day0_md;
+	struct meta_data_on_disk_9 *buffer;
+	int from_index, freed_index;
+	bool free_bitmap_slot;
+
+	if (!get_ldev(device))
+		return -ENODEV;
+
+	peer_md = &device->ldev->md.peers[peer_node_id];
+	free_bitmap_slot = test_bit(__MDF_HAVE_BITMAP, &peer_md->flags);
+	if (free_bitmap_slot) {
+		drbd_suspend_io(device, WRITE_ONLY);
+
+		/*
+		 * Unallocated slots are considered to track writes to the
+		 * device since day 0. In order to keep that promise, copy the
+		 * bitmap from an unallocated slot to this one, or set it to
+		 * all out-of-sync.
+		 */
+
+		from_index = drbd_unallocated_index(device->ldev);
+		freed_index = peer_md->bitmap_index;
+
+		/* Take the bitmap lock before md_buffer. Correct order. */
+		drbd_bm_lock(device, __func__, BM_LOCK_BULK);
+	}
+	buffer = drbd_md_get_buffer(device, __func__); /* lock meta-data IO to superblock */
+	if (buffer == NULL)
+		goto out_no_buffer;
+
+	/* Look for day0 UUID before changing this peer slot to a day0 slot. */
+	day0_md = day0_peer_md(device);
+
+	clear_peer_md_flags(peer_md, ~md_flags | MDF_HAVE_BITMAP);
+	peer_md->bitmap_index = -1;
+
+	if (free_bitmap_slot) {
+		/*
+		 * Regular bitmap OPs (calling into bm_op()) can run in parallel to
+		 * drbd_bm_copy_slot() and interleave with it as drbd_bm_copy_slot()
+		 * gives up its locks when it moves on to the next source page.
+		 * The bitmap->bm_all_slots_lock ensures that drbd_set_sync()
+		 * (which iterates over multiple slots) does not interleave with
+		 * drbd_bm_copy_slot() while it copies data from one slot to another
+		 * one.
+		 */
+		if (from_index != -1)
+			drbd_bm_copy_slot(device, from_index, freed_index);
+		else
+			_drbd_bm_set_many_bits(device, freed_index, 0, -1UL);
+
+		drbd_bm_write(device, NULL);
+	}
+
+	/*
+	 * When we forget a peer, we clear the flags. In this case, reset the
+	 * bitmap UUID to the day0 UUID. Peer slots without any bitmap index or
+	 * any flags set should always contain the day0 UUID.
+	 */
+	if (!peer_md->flags && day0_md) {
+		/* Assign directly, not via drbd_set_peer_bitmap_uuid(): a day0 slot must
+		 * keep flags == 0, and is implicitly a divergence bitmap through the
+		 * !MDF_HAVE_BITMAP path, so it must not gain MDF_PEER_DIVERGENCE_BITMAP.
+		 */
+		peer_md->bitmap_uuid = day0_md->bitmap_uuid;
+		peer_md->bitmap_dagtag = day0_md->bitmap_dagtag;
+	} else {
+		drbd_set_peer_bitmap_uuid(peer_md, 0, 0);
+	}
+
+	clear_bit(MD_DIRTY, &device->flags);
+	drbd_md_write(device, buffer);
+	drbd_md_put_buffer(device);
+
+ out_no_buffer:
+	if (free_bitmap_slot) {
+		drbd_bm_unlock(device);
+		drbd_resume_io(device);
+	}
+
+	put_ldev(device);
+
+	return 0;
+}
+
+bool want_bitmap(struct drbd_peer_device *peer_device)
+{
+	struct drbd_peer_device_conf *pdc;
+	bool want_bitmap = false;
+
+	rcu_read_lock();
+	pdc = rcu_dereference(peer_device->conf);
+	if (pdc)
+		want_bitmap |= pdc->bitmap;
+	rcu_read_unlock();
+
+	return want_bitmap;
+}
+
+static void close_backing_dev(struct drbd_device *device,
+		struct file *bdev_file, bool do_bd_unlink)
+{
+	if (!bdev_file)
+		return;
+	if (do_bd_unlink)
+		bd_unlink_disk_holder(file_bdev(bdev_file), device->vdisk);
+	fput(bdev_file);
+}
+
+void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
+{
+	if (ldev == NULL)
+		return;
+
+	drbd_dax_close(ldev);
+
+	close_backing_dev(device,
+			  ldev->f_md_bdev,
+			  ldev->md_bdev != ldev->backing_bdev);
+	close_backing_dev(device, ldev->backing_bdev_file, true);
+
+	kfree(ldev->disk_conf);
+	kfree(ldev);
+}
+
+static struct file *open_backing_dev(struct drbd_device *device,
+		const char *bdev_path, void *claim_ptr)
+{
+	struct file *file = bdev_file_open_by_path(bdev_path,
+				  BLK_OPEN_READ | BLK_OPEN_WRITE,
+				  claim_ptr, NULL);
+	if (IS_ERR(file)) {
+		drbd_err(device, "open(\"%s\") failed with %ld\n",
+				bdev_path, PTR_ERR(file));
+	}
+	return file;
+}
+
+static int link_backing_dev(struct drbd_device *device,
+		const char *bdev_path, struct file *file)
+{
+	int err = bd_link_disk_holder(file_bdev(file), device->vdisk);
+
+	if (err) {
+		fput(file);
+		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
+				bdev_path, err);
+	}
+	return err;
+}
+
+static int open_backing_devices(struct drbd_device *device,
+		struct drbd_disk_conf *new_disk_conf,
+		struct drbd_backing_dev *nbc)
+{
+	struct file *file;
+	void *meta_claim_ptr;
+	int err;
+
+	file = open_backing_dev(device, new_disk_conf->backing_dev, device);
+	if (IS_ERR(file))
+		return ERR_OPEN_DISK;
+
+	err = link_backing_dev(device, new_disk_conf->backing_dev, file);
+	if (err) {
+		/* close without unlinking; otherwise error path will try to unlink */
+		close_backing_dev(device, file, false);
+		return ERR_OPEN_DISK;
+	}
+	nbc->backing_bdev = file_bdev(file);
+	nbc->backing_bdev_file = file;
+
+	/* meta_claim_ptr: device, if claimed exclusively; shared drbd_m_holder,
+	 * if potentially shared with other drbd minors
+	 */
+	meta_claim_ptr = (new_disk_conf->meta_dev_idx < 0) ?
+		(void *)device : (void *)drbd_m_holder;
+	/*
+	 * meta_dev_idx >= 0: external fixed size, possibly multiple
+	 * drbd sharing one meta device.  TODO in that case, paranoia
+	 * check that [md_bdev, meta_dev_idx] is not yet used by some
+	 * other drbd minor!  (if you use drbd.conf + drbdadm, that
+	 * should check it for you already; but if you don't, or
+	 * someone fooled it, we need to double check here)
+	 */
+	file = open_backing_dev(device, new_disk_conf->meta_dev, meta_claim_ptr);
+	if (IS_ERR(file))
+		return ERR_OPEN_MD_DISK;
+
+	/* avoid double bd_claim_by_disk() for the same (source,target) tuple,
+	 * as would happen with internal metadata. */
+	if (file_bdev(file) != nbc->backing_bdev) {
+		err = link_backing_dev(device, new_disk_conf->meta_dev, file);
+		if (err) {
+			/* close without unlinking; otherwise error path will try to unlink */
+			close_backing_dev(device, file, false);
+			return ERR_OPEN_MD_DISK;
+		}
+	}
+
+	nbc->md_bdev = file_bdev(file);
+	nbc->f_md_bdev = file;
+	return NO_ERROR;
+}
+
+static int check_activity_log_stripe_size(struct drbd_device *device, struct drbd_md *md)
+{
+	u32 al_stripes = md->al_stripes;
+	u32 al_stripe_size_4k = md->al_stripe_size_4k;
+	u64 al_size_4k;
+
+	/* both not set: default to old fixed size activity log */
+	if (al_stripes == 0 && al_stripe_size_4k == 0) {
+		al_stripes = 1;
+		al_stripe_size_4k = (32768 >> 9)/8;
+	}
+
+	/* some paranoia plausibility checks */
+
+	/* we need both values to be set */
+	if (al_stripes == 0 || al_stripe_size_4k == 0)
+		goto err;
+
+	al_size_4k = (u64)al_stripes * al_stripe_size_4k;
+
+	/* Upper limit of activity log area, to avoid potential overflow
+	 * problems in al_tr_number_to_on_disk_sector(). As right now, more
+	 * than 72 * 4k blocks total only increases the amount of history,
+	 * limiting this arbitrarily to 16 GB is not a real limitation ;-)  */
+	if (al_size_4k > (16 * 1024 * 1024/4))
+		goto err;
+
+	/* Lower limit: we need at least 8 transaction slots (32kB)
+	 * to not break existing setups */
+	if (al_size_4k < (32768 >> 9)/8)
+		goto err;
+
+	md->al_size_4k = al_size_4k;
+
+	return 0;
+err:
+	drbd_err(device, "invalid activity log striping: al_stripes=%u, al_stripe_size_4k=%u\n",
+			al_stripes, al_stripe_size_4k);
+	return -EINVAL;
+}
+
+static int check_offsets_and_sizes(struct drbd_device *device, struct drbd_backing_dev *bdev)
+{
+	sector_t capacity = drbd_get_capacity(bdev->md_bdev);
+	struct drbd_md *md = &bdev->md;
+	s32 on_disk_al_sect;
+	s32 on_disk_bm_sect;
+
+	if (md->max_peers > DRBD_PEERS_MAX) {
+		drbd_err(device, "bm_max_peers too high\n");
+		goto err;
+	}
+
+	/* The on-disk size of the activity log, calculated from offsets, and
+	 * the size of the activity log calculated from the stripe settings,
+	 * should match.
+	 * Though we could relax this a bit: it is ok, if the striped activity log
+	 * fits in the available on-disk activity log size.
+	 * Right now, that would break how resize is implemented.
+	 * TODO: make drbd_determine_dev_size() (and the drbdmeta tool) aware
+	 * of possible unused padding space in the on disk layout. */
+	if (md->al_offset < 0) {
+		if (md->bm_offset > md->al_offset)
+			goto err;
+		on_disk_al_sect = -md->al_offset;
+		on_disk_bm_sect = md->al_offset - md->bm_offset;
+	} else {
+		if (md->al_offset != (4096 >> 9))
+			goto err;
+		if (md->bm_offset < md->al_offset + md->al_size_4k * (4096 >> 9))
+			goto err;
+
+		on_disk_al_sect = md->bm_offset - (4096 >> 9);
+		on_disk_bm_sect = md->md_size_sect - md->bm_offset;
+	}
+
+	/* old fixed size meta data is exactly that: fixed. */
+	if (md->meta_dev_idx >= 0) {
+		if (md->bm_block_size != BM_BLOCK_SIZE_4k
+		||  md->md_size_sect != (128 << 20 >> 9)
+		||  md->al_offset != (4096 >> 9)
+		||  md->bm_offset != (4096 >> 9) + (32768 >> 9)
+		||  md->al_stripes != 1
+		||  md->al_stripe_size_4k != (32768 >> 12))
+			goto err;
+	}
+
+	if (capacity < md->md_size_sect)
+		goto err;
+	if (capacity - md->md_size_sect < drbd_md_first_sector(bdev))
+		goto err;
+
+	/* should be aligned, and at least 32k */
+	if ((on_disk_al_sect & 7) || (on_disk_al_sect < (32768 >> 9)))
+		goto err;
+
+	/* should fit (for now: exactly) into the available on-disk space;
+	 * overflow prevention is in check_activity_log_stripe_size() above. */
+	if (on_disk_al_sect != md->al_size_4k * (4096 >> 9))
+		goto err;
+
+	/* again, should be aligned */
+	if (md->bm_offset & 7)
+		goto err;
+
+	/* FIXME check for device grow with flex external meta data? */
+
+	/* can the available bitmap space cover the last agreed device size? */
+	if (on_disk_bm_sect < drbd_capacity_to_on_disk_bm_sect(
+				md->effective_size, md))
+		goto err;
+
+	return 0;
+
+err:
+	drbd_err(device, "meta data offsets don't make sense: idx=%d bm_block_size=%d al_s=%u, al_sz4k=%u, al_offset=%d, bm_offset=%d, md_size_sect=%u, la_size=%llu, md_capacity=%llu\n",
+			md->meta_dev_idx, md->bm_block_size,
+			md->al_stripes, md->al_stripe_size_4k,
+			md->al_offset, md->bm_offset, md->md_size_sect,
+			(unsigned long long)md->effective_size,
+			(unsigned long long)capacity);
+
+	return -EINVAL;
+}
+
+__printf(2, 3)
+static void drbd_err_and_skb_info(struct drbd_adm_ctx *adm_ctx, const char *format, ...)
+{
+	struct drbd_device *device = adm_ctx->device;
+	va_list args;
+	char *text;
+
+	va_start(args, format);
+	text = kvasprintf(GFP_ATOMIC, format, args);
+	va_end(args);
+
+	if (!text)
+		return;
+
+	drbd_err(device, "%s", text);
+	drbd_adm_msg(adm_ctx, "%s", text);
+
+	kfree(text);
+}
+
+static void decode_md_9(struct meta_data_on_disk_9 *on_disk, struct drbd_md *md)
+{
+	int i;
+
+	md->effective_size = be64_to_cpu(on_disk->effective_size);
+	md->current_uuid = be64_to_cpu(on_disk->current_uuid);
+	md->prev_members = be64_to_cpu(on_disk->members);
+	md->prev_features = be64_to_cpu(on_disk->features);
+	md->device_uuid = be64_to_cpu(on_disk->device_uuid);
+	md->md_size_sect = be32_to_cpu(on_disk->md_size_sect);
+	md->al_offset = be32_to_cpu(on_disk->al_offset);
+
+	md->bm_offset = be32_to_cpu(on_disk->bm_offset);
+
+	md->flags = be32_to_cpu(on_disk->flags);
+
+	md->max_peers = be32_to_cpu(on_disk->bm_max_peers);
+	md->bm_block_size = be32_to_cpu(on_disk->bm_bytes_per_bit);
+	md->node_id = be32_to_cpu(on_disk->node_id);
+	md->al_stripes = be32_to_cpu(on_disk->al_stripes);
+	md->al_stripe_size_4k = be32_to_cpu(on_disk->al_stripe_size_4k);
+
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		struct drbd_peer_md *peer_md = &md->peers[i];
+		unsigned long flags = be32_to_cpu(on_disk->peers[i].flags);
+		s32 bitmap_index = be32_to_cpu(on_disk->peers[i].bitmap_index);
+
+		if (bitmap_index != -1)
+			flags |= MDF_HAVE_BITMAP;
+
+		peer_md->bitmap_uuid = be64_to_cpu(on_disk->peers[i].bitmap_uuid);
+		peer_md->bitmap_dagtag = be64_to_cpu(on_disk->peers[i].bitmap_dagtag);
+		peer_md->flags = flags;
+		peer_md->bitmap_index = bitmap_index;
+		/* The origin of the bits on disk is not on disk. Reading the
+		 * bitmap calls drbd_md_slot_emptied() for every empty slot,
+		 * which is where this becomes true again.
+		 */
+		peer_md->placeholder_src = 0;
+		peer_md->placeholder_src_complete = false;
+	}
+	for (i = 0; i < ARRAY_SIZE(on_disk->history_uuids); i++)
+		md->history_uuids[i] = be64_to_cpu(on_disk->history_uuids[i]);
+
+	BUILD_BUG_ON(ARRAY_SIZE(md->history_uuids) != ARRAY_SIZE(on_disk->history_uuids));
+}
+
+/* Drop the peer flags which the DRBD that last wrote this meta data did not
+ * understand. Such a DRBD preserves a flag without updating its value, so the
+ * value we read is not necessarily current. This protects against downgrade -
+ * upgrade sequences.
+ *
+ * MDF_PEER_BITMAP_AUTHORITATIVE goes the other way: a writer that did not
+ * maintain it may have set bits for blocks the peer lacks without recording
+ * that, so every standing bit counts as such.
+ */
+static void distrust_unsupported_peer_flags(struct drbd_device *device, struct drbd_md *md)
+{
+	u64 nodes = 0;
+	int i;
+
+	if (!(md->prev_features & DRBD_MDFF_BITMAP_AUTHORITATIVE)) {
+		for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+			struct drbd_peer_md *peer_md = &md->peers[i];
+
+			if (!test_bit(__MDF_HAVE_BITMAP, &peer_md->flags))
+				continue;
+			if (!test_and_set_bit(__MDF_PEER_BITMAP_AUTHORITATIVE, &peer_md->flags))
+				nodes |= NODE_MASK(i);
+		}
+		if (nodes)
+			drbd_info(device, "Meta data written without the bitmap provenance feature; "
+				  "all out-of-sync bits toward node(s) 0x%llX count as set with reason\n",
+				  nodes);
+		nodes = 0;
+	}
+
+	if (md->prev_features & DRBD_MDFF_DIVERGENCE_BITMAP)
+		return;
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		struct drbd_peer_md *peer_md = &md->peers[i];
+
+		if (!test_and_clear_bit(__MDF_PEER_DIVERGENCE_BITMAP, &peer_md->flags))
+			continue;
+
+		/* A slot without a bitmap of its own is a divergence bitmap in
+		 * any case, so clearing the flag changes nothing there. Report
+		 * only the slots where it makes a difference.
+		 */
+		if (test_bit(__MDF_HAVE_BITMAP, &peer_md->flags))
+			nodes |= NODE_MASK(i);
+	}
+
+	if (nodes)
+		drbd_info(device, "Meta data written without the divergence bitmap feature; "
+			  "not trusting MDF_PEER_DIVERGENCE_BITMAP of node(s) 0x%llX\n", nodes);
+}
+
+static void decode_magic(struct meta_data_on_disk_9 *on_disk, u32 *magic, u32 *flags)
+{
+	/* magic and flags are in at the same offsets in 8.4 and 9 */
+	*magic = be32_to_cpu(on_disk->magic);
+	*flags = be32_to_cpu(on_disk->flags);
+}
+
+static
+int drbd_md_decode(struct drbd_adm_ctx *adm_ctx,
+		   struct drbd_backing_dev *bdev,
+		   void *buffer)
+{
+	struct drbd_device *device = adm_ctx->device;
+	u32 magic, flags;
+	int i, rv = NO_ERROR;
+	int my_node_id = device->resource->res_opts.node_id;
+
+	decode_magic(buffer, &magic, &flags);
+	if ((magic == DRBD_MD_MAGIC_09 && !(flags & MDF_AL_CLEAN)) ||
+	    magic == DRBD_MD_MAGIC_84_UNCLEAN ||
+	    (magic == DRBD_MD_MAGIC_08 && !(flags & MDF_AL_CLEAN))) {
+		/* btw: that's Activity Log clean, not "all" clean. */
+		drbd_err_and_skb_info(adm_ctx,
+				"Found unclean meta data. Did you \"drbdadm apply-al\"?\n");
+		rv = ERR_MD_UNCLEAN;
+		goto err;
+	}
+	rv = ERR_MD_INVALID;
+	if (magic != DRBD_MD_MAGIC_09 && magic !=
+	    DRBD_MD_MAGIC_84_UNCLEAN && magic !=  DRBD_MD_MAGIC_08) {
+		if (magic == DRBD_MD_MAGIC_07)
+			drbd_err_and_skb_info(adm_ctx,
+				"Found old meta data magic. Did you \"drbdadm create-md\"?\n");
+		else
+			drbd_err_and_skb_info(adm_ctx,
+				"Meta data magic not found. Did you \"drbdadm create-md\"?\n");
+		goto err;
+	}
+
+	if (magic == DRBD_MD_MAGIC_09) {
+		clear_bit(LEGACY_84_MD, &device->flags);
+		decode_md_9(buffer, &bdev->md);
+		distrust_unsupported_peer_flags(device, &bdev->md);
+	} else {
+		if (!device->resource->res_opts.drbd8_compat_mode) {
+			drbd_err_and_skb_info(adm_ctx,
+				"Found old meta data magic. Did you \"drbdadm create-md\"?\n");
+			goto err;
+		}
+		set_bit(LEGACY_84_MD, &device->flags);
+		drbd_md_decode_84(buffer, &bdev->md);
+		if (bdev->md.bm_block_size != BM_BLOCK_SIZE_4k) {
+			drbd_err_and_skb_info(adm_ctx,
+				"unexpected bm_bytes_per_bit: %u (expected %u)\n",
+				bdev->md.bm_block_size, BM_BLOCK_SIZE_4k);
+			goto err;
+		}
+	}
+
+	if (!is_power_of_2(bdev->md.bm_block_size)
+	|| bdev->md.bm_block_size < BM_BLOCK_SIZE_MIN
+	|| bdev->md.bm_block_size > BM_BLOCK_SIZE_MAX) {
+		drbd_err_and_skb_info(adm_ctx,
+			"unexpected bm_bytes_per_bit: %u (expected power of 2 in [%u..%u])\n",
+			bdev->md.bm_block_size, BM_BLOCK_SIZE_MIN, BM_BLOCK_SIZE_MAX);
+		goto err;
+	}
+	bdev->md.bm_block_shift = ilog2(bdev->md.bm_block_size);
+
+	if (check_activity_log_stripe_size(device, &bdev->md))
+		goto err;
+	if (check_offsets_and_sizes(device, bdev))
+		goto err;
+
+	if (bdev->md.node_id != -1 && bdev->md.node_id != my_node_id) {
+		drbd_err_and_skb_info(adm_ctx, "ambiguous node id: meta-data: %d, config: %d\n",
+			bdev->md.node_id, my_node_id);
+		goto err;
+	}
+
+	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
+		struct drbd_peer_md *peer_md = &bdev->md.peers[i];
+
+		if (peer_md->bitmap_index == -1)
+			continue;
+		if (i == my_node_id) {
+			drbd_err_and_skb_info(adm_ctx, "my own node id (%d) should not have a bitmap index (%d)\n",
+				my_node_id, peer_md->bitmap_index);
+			goto err;
+		}
+		if (peer_md->bitmap_index < -1 || peer_md->bitmap_index >= bdev->md.max_peers) {
+			drbd_err_and_skb_info(adm_ctx, "peer node id %d: bitmap index (%d) exceeds allocated bitmap slots (%d)\n",
+				i, peer_md->bitmap_index, bdev->md.max_peers);
+			goto err;
+		}
+		/* maybe: for each bitmap_index != -1, create a connection object
+		 * with peer_node_id = i, unless already present. */
+	}
+
+	rv = NO_ERROR;
+
+err:
+	return rv;
+}
+
+/**
+ * drbd_md_read() - Reads in the meta data super block
+ * @adm_ctx:	DRBD config context.
+ * @bdev:	Device from which the meta data should be read in.
+ *
+ * Return NO_ERROR on success, and an enum drbd_ret_code in case
+ * something goes wrong.
+ *
+ * Called exactly once during drbd_adm_attach(), while still being D_DISKLESS,
+ * even before @bdev is assigned to @device->ldev.
+ */
+static int drbd_md_read(struct drbd_adm_ctx *adm_ctx, struct drbd_backing_dev *bdev)
+{
+	struct drbd_device *device = adm_ctx->device;
+	void *buffer;
+	int rv;
+
+	if (device->disk_state[NOW] != D_DISKLESS)
+		return ERR_DISK_CONFIGURED;
+
+	/* First, figure out where our meta data superblock is located,
+	 * and read it. */
+	bdev->md.meta_dev_idx = bdev->disk_conf->meta_dev_idx;
+	bdev->md.md_offset = drbd_md_ss(bdev);
+	/* Even for (flexible or indexed) external meta data,
+	 * initially restrict us to the 4k superblock for now.
+	 * Affects the paranoia out-of-range access check in drbd_md_sync_page_io(). */
+	bdev->md.md_size_sect = 8;
+
+	drbd_dax_open(bdev);
+	if (drbd_md_dax_active(bdev)) {
+		drbd_info(device, "meta-data IO uses: dax-pmem\n");
+		rv = drbd_md_decode(adm_ctx, bdev, drbd_dax_md_addr(bdev));
+		if (rv != NO_ERROR)
+			return rv;
+		if (drbd_dax_map(bdev))
+			return ERR_IO_MD_DISK;
+		return NO_ERROR;
+	}
+	drbd_info(device, "meta-data IO uses: blk-bio\n");
+
+	buffer = drbd_md_get_buffer(device, __func__);
+	if (!buffer)
+		return ERR_NOMEM;
+
+	if (drbd_md_sync_page_io(device, bdev, bdev->md.md_offset,
+				 REQ_OP_READ)) {
+		/* NOTE: can't do normal error processing here as this is
+		   called BEFORE disk is attached */
+		drbd_err_and_skb_info(adm_ctx, "Error while reading metadata.\n");
+		rv = ERR_IO_MD_DISK;
+		goto err;
+	}
+
+	rv = drbd_md_decode(adm_ctx, bdev, buffer);
+ err:
+	drbd_md_put_buffer(device);
+
+	return rv;
+}
+
+/* May this node restore the quorum it had when it last wrote its meta data?
+ *
+ * Only if every other node of that membership is an intentionally diskless
+ * node. Those never vote in calc_quorum(), they only act as tie-breakers, and
+ * a tie-breaker can not create quorum, it can only preserve an existing one.
+ * So this node was quorate on its own, which is what RESTORE_QUORUM restores.
+ *
+ * A peer we hold a bitmap slot for, or that we have ever seen with a disk, is
+ * a voter. Unknown nodes count as voters as well.
+ */
+static bool may_restore_quorum(struct drbd_device *device)
+{
+	const u64 me = NODE_MASK(device->resource->res_opts.node_id);
+	u64 others = device->ldev->md.prev_members & ~me;
+	int node_id;
+
+	if (!(device->ldev->md.prev_members & me))
+		return false;
+
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		if (!(others & NODE_MASK(node_id)))
+			continue;
+		if (test_bit(__MDF_HAVE_BITMAP, &device->ldev->md.peers[node_id].flags) ||
+		    test_bit(__MDF_PEER_DEVICE_SEEN, &device->ldev->md.peers[node_id].flags))
+			return false;
+	}
+
+	return true;
+}
+
+int drbd_adm_attach(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_device *device;
+	struct drbd_resource *resource;
+	int err, retcode = NO_ERROR;
+	enum determine_dev_size dd;
+	enum drbd_disk_state ds;
+	sector_t min_md_device_sectors;
+	struct drbd_backing_dev *nbc; /* new_backing_conf */
+	struct drbd_bitmap *bitmap = NULL; /* unpublished until bm_pages is wired up */
+	bool published_bitmap = false;
+	sector_t backing_disk_max_sectors;
+	struct drbd_disk_conf *new_disk_conf = NULL;
+	enum drbd_state_rv rv;
+	struct drbd_peer_device *peer_device;
+	unsigned int slots_needed = 0;
+	bool have_conf_update = false;
+	bool al_updates;
+
+	device = adm_ctx->device;
+	resource = device->resource;
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+
+	/* allocation not in the IO path, drbdsetup context */
+	nbc = kzalloc_obj(struct drbd_backing_dev);
+	if (!nbc) {
+		retcode = ERR_NOMEM;
+		goto fail;
+	}
+	spin_lock_init(&nbc->md.uuid_lock);
+
+	new_disk_conf = kzalloc_obj(struct drbd_disk_conf);
+	if (!new_disk_conf) {
+		retcode = ERR_NOMEM;
+		goto fail;
+	}
+	nbc->disk_conf = new_disk_conf;
+
+	drbd_set_disk_conf_defaults(new_disk_conf);
+	err = drbd_adm_overlay_disk_conf(adm_ctx, new_disk_conf);
+	if (err) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto fail;
+	}
+
+	if (new_disk_conf->meta_dev_idx < DRBD_MD_INDEX_FLEX_INT) {
+		retcode = ERR_MD_IDX_INVALID;
+		goto fail;
+	}
+
+	lock_all_resources();
+	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
+	unlock_all_resources();
+	if (retcode != NO_ERROR)
+		goto fail;
+
+	retcode = open_backing_devices(device, new_disk_conf, nbc);
+	if (retcode != NO_ERROR)
+		goto fail;
+
+	if ((nbc->backing_bdev == nbc->md_bdev) !=
+	    (new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_INTERNAL ||
+	     new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_FLEX_INT)) {
+		retcode = ERR_MD_IDX_INVALID;
+		goto fail;
+	}
+
+	/* if you want to reconfigure, please tear down first */
+	if (device->disk_state[NOW] > D_DISKLESS) {
+		retcode = ERR_DISK_CONFIGURED;
+		goto fail;
+	}
+	/* It may just now have detached because of IO error.  Make sure
+	 * drbd_ldev_destroy is done already, we may end up here very fast,
+	 * e.g. if someone calls attach from the on-io-error handler,
+	 * to realize a "hot spare" feature (not that I'd recommend that) */
+	wait_event(device->misc_wait, !test_bit(GOING_DISKLESS, &device->flags));
+
+	/* make sure there is no leftover from previous force-detach attempts */
+	clear_bit(FORCE_DETACH, &device->flags);
+
+	/* and no leftover from previously aborted resync or verify, either */
+	for_each_peer_device(peer_device, device) {
+		while (atomic_read(&peer_device->rs_pending_cnt)) {
+			drbd_info_ratelimit(peer_device, "wait for rs_pending_cnt to clear\n");
+			if (schedule_timeout_interruptible(HZ / 10)) {
+				retcode = ERR_INTR;
+				goto fail;
+			}
+		}
+
+		peer_device->rs_total = 0;
+		peer_device->rs_failed = 0;
+	}
+
+	/* Read our meta data super block early.
+	 * This also sets other on-disk offsets.
+	 */
+	retcode = drbd_md_read(adm_ctx, nbc);
+	if (retcode != NO_ERROR)
+		goto fail;
+
+	if (device->bitmap) {
+		drbd_err_and_skb_info(adm_ctx, "already has a bitmap, this should not happen\n");
+		retcode = ERR_INVALID_REQUEST;
+		goto fail;
+	}
+
+	if (new_disk_conf->d_bitmap) {
+		/* ldev_safe: attach path, allocating bitmap. */
+		bitmap = drbd_bm_alloc(nbc->md.max_peers, nbc->md.bm_block_shift);
+		if (!bitmap) {
+			retcode = ERR_NOMEM;
+			goto fail;
+		}
+	} else {
+		if (!list_empty(&resource->connections)) {
+			drbd_err_and_skb_info(adm_ctx,
+				"Disabling bitmap allocation with peers defined is not allowed");
+			retcode = ERR_INVALID_REQUEST;
+			goto fail;
+		}
+	}
+	device->last_bm_block_shift = nbc->md.bm_block_shift;
+
+	sanitize_disk_conf(device, new_disk_conf, nbc);
+
+	backing_disk_max_sectors = drbd_get_max_capacity(device, nbc, true);
+	if (backing_disk_max_sectors < new_disk_conf->disk_size) {
+		drbd_err_and_skb_info(adm_ctx, "max capacity %llu smaller than disk size %llu\n",
+			(unsigned long long) backing_disk_max_sectors,
+			(unsigned long long) new_disk_conf->disk_size);
+		retcode = ERR_DISK_TOO_SMALL;
+		goto fail;
+	}
+
+	if (new_disk_conf->meta_dev_idx < 0) {
+		/* at least one MB, otherwise it does not make sense */
+		min_md_device_sectors = (2<<10);
+	} else {
+		min_md_device_sectors = (128 << 20 >> 9) * (new_disk_conf->meta_dev_idx + 1);
+	}
+
+	if (drbd_get_capacity(nbc->md_bdev) < min_md_device_sectors) {
+		retcode = ERR_MD_DISK_TOO_SMALL;
+		drbd_warn(device, "refusing attach: md-device too small, "
+		     "at least %llu sectors needed for this meta-disk type\n",
+		     (unsigned long long) min_md_device_sectors);
+		goto fail;
+	}
+
+	/* Make sure the new disk is big enough
+	 * (we may currently be R_PRIMARY with no local disk...) */
+	if (backing_disk_max_sectors <
+	    get_capacity(device->vdisk)) {
+		drbd_err_and_skb_info(adm_ctx,
+			"Current (diskless) capacity %llu, cannot attach smaller (%llu) disk\n",
+			(unsigned long long)get_capacity(device->vdisk),
+			(unsigned long long)backing_disk_max_sectors);
+		retcode = ERR_DISK_TOO_SMALL;
+		goto fail;
+	}
+
+	nbc->known_size = drbd_get_capacity(nbc->backing_bdev);
+
+	drbd_suspend_io(device, READ_AND_WRITE);
+	wait_event(resource->barrier_wait, !barrier_pending(resource));
+	for_each_peer_device(peer_device, device)
+		wait_event(device->misc_wait,
+			   (!atomic_read(&peer_device->ap_pending_cnt) ||
+			    drbd_suspended(device)));
+	/* and for other previously queued resource work */
+	drbd_flush_workqueue(&resource->work);
+
+	rv = stable_state_change(resource,
+		change_disk_state(device, D_ATTACHING, CS_VERBOSE | CS_SERIALIZE, "attach", NULL));
+	retcode = (enum drbd_ret_code)rv;
+	if (rv >= SS_SUCCESS)
+		update_resource_dagtag(resource, nbc);
+	drbd_resume_io(device);
+	if (rv < SS_SUCCESS)
+		goto fail;
+
+	if (!get_ldev_if_state(device, D_ATTACHING))
+		goto force_diskless;
+
+	drbd_info(device, "Maximum number of peer devices = %u\n", nbc->md.max_peers);
+
+	mutex_lock(&resource->conf_update);
+	have_conf_update = true;
+
+	/* Make sure the local node id matches or is unassigned */
+	if (nbc->md.node_id != -1 && nbc->md.node_id != resource->res_opts.node_id) {
+		drbd_err_and_skb_info(adm_ctx, "Local node id %d differs from local "
+			 "node id %d on device\n",
+			 resource->res_opts.node_id,
+			 nbc->md.node_id);
+		retcode = ERR_INVALID_REQUEST;
+		goto force_diskless_dec;
+	}
+
+	/* Make sure no bitmap slot has our own node id.
+	 * If we are operating in "drbd 8 compatibility mode", the node ID is
+	 * not yet initialized at this point, so just ignore this check.
+	 */
+	if (resource->res_opts.node_id != -1 &&
+	    nbc->md.peers[resource->res_opts.node_id].bitmap_index != -1) {
+		drbd_err_and_skb_info(adm_ctx, "There is a bitmap for my own node id (%d)\n",
+			 resource->res_opts.node_id);
+		retcode = ERR_INVALID_REQUEST;
+		goto force_diskless_dec;
+	}
+
+	/* Make sure we have a bitmap slot for each peer id */
+	for_each_peer_device(peer_device, device) {
+		struct drbd_connection *connection = peer_device->connection;
+		int bitmap_index;
+
+		if (peer_device->bitmap_index != -1) {
+			drbd_err_and_skb_info(adm_ctx,
+					"ASSERTION FAILED bitmap_index %d during attach, expected -1\n",
+					peer_device->bitmap_index);
+		}
+
+		bitmap_index = nbc->md.peers[connection->peer_node_id].bitmap_index;
+		if (want_bitmap(peer_device)) {
+			if (bitmap_index != -1)
+				peer_device->bitmap_index = bitmap_index;
+			else
+				slots_needed++;
+		} else if (bitmap_index != -1) {
+			/* Pretend in core that there is not bitmap for that peer,
+			   in the on disk meta-data we keep it until it is de-allocated
+			   with forget-peer */
+			clear_bit(__MDF_HAVE_BITMAP,
+				  &nbc->md.peers[connection->peer_node_id].flags);
+		}
+	}
+	if (slots_needed) {
+		int slots_available = nbc->md.max_peers - used_bitmap_slots(nbc);
+
+		if (slots_needed > slots_available) {
+			drbd_err_and_skb_info(adm_ctx, "Not enough free bitmap "
+				 "slots (available=%d, needed=%d)\n",
+				 slots_available,
+				 slots_needed);
+			retcode = ERR_INVALID_REQUEST;
+			goto force_diskless_dec;
+		}
+		for_each_peer_device(peer_device, device) {
+			if (peer_device->bitmap_index != -1 || !want_bitmap(peer_device))
+				continue;
+
+			err = allocate_bitmap_index(peer_device, nbc);
+			if (err) {
+				retcode = ERR_INVALID_REQUEST;
+				goto force_diskless_dec;
+			}
+		}
+	}
+
+	/* Assign the local node id (if not assigned already) */
+	nbc->md.node_id = resource->res_opts.node_id;
+
+	if (resource->role[NOW] == R_PRIMARY && device->exposed_data_uuid &&
+	    (device->exposed_data_uuid & ~UUID_PRIMARY) !=
+	    (nbc->md.current_uuid & ~UUID_PRIMARY)) {
+		int data_present = false;
+
+		for_each_peer_device(peer_device, device) {
+			if (peer_device->disk_state[NOW] == D_UP_TO_DATE)
+				data_present = true;
+		}
+		if (!data_present) {
+			drbd_err_and_skb_info(adm_ctx,
+				"Can only attach to data with current UUID=%016llX\n",
+				(unsigned long long)device->exposed_data_uuid);
+			retcode = ERR_DATA_NOT_CURRENT;
+			goto force_diskless_dec;
+		}
+	}
+
+	/* Since we are diskless, fix the activity log first... */
+	if (drbd_check_al_size(device, new_disk_conf)) {
+		retcode = ERR_NOMEM;
+		goto force_diskless_dec;
+	}
+
+	/* Point of no return reached.
+	 * Devices and memory are no longer released by error cleanup below.
+	 * now device takes over responsibility, and the state engine should
+	 * clean it up somewhere.  */
+	D_ASSERT(device, device->ldev == NULL);
+	device->ldev = nbc;
+	nbc = NULL;
+	new_disk_conf = NULL;
+	drbd_resource_update_rx_alignment(device->resource);
+
+	if (drbd_md_dax_active(device->ldev)) {
+		/* The on-disk activity log is always initialized with the
+		 * non-pmem format. We have now decided to access it using
+		 * dax, so re-initialize it appropriately. */
+		if (drbd_dax_al_initialize(device)) {
+			retcode = ERR_IO_MD_DISK;
+			goto force_diskless_dec;
+		}
+	}
+
+	mutex_unlock(&resource->conf_update);
+	have_conf_update = false;
+
+	lock_all_resources();
+	retcode = drbd_resync_after_valid(device, device->ldev->disk_conf->resync_after);
+	if (retcode != NO_ERROR) {
+		unlock_all_resources();
+		goto force_diskless_dec;
+	}
+
+	/* Reset the "barriers don't work" bits here, then force meta data to
+	 * be written, to ensure we determine if barriers are supported. */
+	assign_bit(MD_NO_FUA, &device->flags,
+		   !device->ldev->disk_conf->md_flushes);
+
+	drbd_resync_after_changed(device);
+	drbd_bump_write_ordering(resource, device->ldev, WO_BIO_BARRIER);
+	unlock_all_resources();
+
+	/* Prevent shrinking of consistent devices ! */
+	{
+	unsigned long long nsz = drbd_new_dev_size(device, 0, device->ldev->disk_conf->disk_size, 0);
+	unsigned long long eff = device->ldev->md.effective_size;
+
+	if (drbd_md_test_flag(device->ldev, MDF_CONSISTENT) && nsz < eff) {
+		if (nsz == device->ldev->disk_conf->disk_size) {
+			drbd_warn(device, "truncating a consistent device during attach (%llu < %llu)\n", nsz, eff);
+		} else {
+			drbd_warn(device, "refusing to truncate a consistent device (%llu < %llu)\n", nsz, eff);
+			drbd_adm_msg(adm_ctx,
+				"To-be-attached device has last effective > current size, and is consistent\n"
+				"(%llu > %llu sectors). Refusing to attach.", eff, nsz);
+			retcode = ERR_IMPLICIT_SHRINK;
+			goto force_diskless_dec;
+		}
+	}
+	}
+
+	if (drbd_md_test_flag(device->ldev, MDF_HAVE_QUORUM) &&
+	    drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE) &&
+	    may_restore_quorum(device))
+		set_bit(RESTORE_QUORUM, &device->flags);
+
+	assign_bit(CRASHED_PRIMARY, &device->flags,
+		   drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY) &&
+		   !(resource->role[NOW] == R_PRIMARY && resource->susp_nod[NOW]) &&
+		   !device->exposed_data_uuid && !drbd_gen_obligation_outstanding(device));
+
+	if (drbd_md_test_flag(device->ldev, MDF_PRIMARY_LOST_QUORUM) &&
+	    !device->have_quorum[NOW])
+		set_bit(PRIMARY_LOST_QUORUM, &device->flags);
+
+	device->read_cnt = 0;
+	device->writ_cnt = 0;
+
+	drbd_reconsider_queue_parameters(device, device->ldev);
+
+	/* If I am currently not R_PRIMARY,
+	 * but meta data primary indicator is set,
+	 * I just now recover from a hard crash,
+	 * and have been R_PRIMARY before that crash.
+	 *
+	 * Now, if I had no connection before that crash
+	 * (have been degraded R_PRIMARY), chances are that
+	 * I won't find my peer now either.
+	 *
+	 * In that case, and _only_ in that case,
+	 * we use the degr-wfc-timeout instead of the default,
+	 * so we can automatically recover from a crash of a
+	 * degraded but active "cluster" after a certain timeout.
+	 */
+	for_each_peer_device(peer_device, device) {
+		clear_bit(USE_DEGR_WFC_T, peer_device->flags);
+		if (resource->role[NOW] != R_PRIMARY &&
+		    drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND) &&
+		    !drbd_md_test_peer_flag(peer_device, __MDF_PEER_CONNECTED))
+			set_bit(USE_DEGR_WFC_T, peer_device->flags);
+	}
+
+	/* Load on-disk tracking bits before peers' advertised sizes can
+	 * influence the computed device size.
+	 *
+	 * old_size is the number of sectors for which the on-disk bitmap
+	 * carries meaningful content.  Use min_not_zero() so that:
+	 *   - day0 attach (md->effective_size == 0, device already live at
+	 *     dev_size via a diskless connection): old_size = dev_size, reading
+	 *     whatever bitmap the metadata preparer wrote (all-set for full
+	 *     sync, or a day0 tracking bitmap for inception-based resync).
+	 *   - normal re-attach: old_size = min(md_size, dev_size), so any
+	 *     gap between md_size and dev_size (e.g. a peer ran resize while
+	 *     this node was diskless) is covered by drbd_determine_dev_size()
+	 *     below with bits SET, rather than by whatever happens to be on
+	 *     disk at that offset.
+	 */
+	{
+		sector_t md_size = device->ldev->md.effective_size;
+		sector_t dev_size = get_capacity(device->vdisk);
+		sector_t old_size = min_not_zero(md_size, dev_size);
+
+		/* old_size == 0 means no prior history exists (first-ever attach
+		 * before any connection): skip the read and let
+		 * drbd_determine_dev_size() below allocate and initialise the
+		 * bitmap fresh.
+		 */
+		if (old_size > 0 && bitmap) {
+			_drbd_bm_lock(device, bitmap, NULL, __func__, BM_LOCK_ALL);
+			err = drbd_bm_resize(device, bitmap, old_size, false);
+			_drbd_bm_unlock(device, bitmap);
+			if (err) {
+				retcode = ERR_NOMEM_BITMAP;
+				goto force_diskless_dec;
+			}
+
+			/* Publish only after bm_pages is populated. */
+			smp_store_release(&device->bitmap, bitmap);
+			bitmap = NULL;
+			published_bitmap = true;
+
+			err = drbd_bitmap_io(device, &drbd_bm_read,
+					     "read from attaching", BM_LOCK_ALL,
+					     NULL);
+			if (err) {
+				retcode = ERR_IO_MD_DISK;
+				goto force_diskless_dec;
+			}
+		} else if (bitmap) {
+			/* old_size == 0: no prior bitmap to read.
+			 * drbd_determine_dev_size() below resizes via
+			 * device->bitmap, so we have to publish here.  The
+			 * window during which device->bitmap is non-NULL with
+			 * bm_pages == NULL is quiescent (D_ATTACHING, no peer
+			 * connected, no IO touching the bitmap).
+			 */
+			smp_store_release(&device->bitmap, bitmap);
+			bitmap = NULL;
+			published_bitmap = true;
+		}
+	}
+
+	/* Determine the final device size, growing [old_size, new_size].
+	 * Normally new-region bits are SET (new territory, needs resync).
+	 * Exception: if the backing device guarantees zeroes for all new
+	 * allocations (discard_zeroes_if_aligned) and the device has a real
+	 * UUID (not just-created), the new region may be known-clean:
+	 *
+	 *   Path A -- device was UpToDate before detach: no dirty data, new
+	 *             space on a zero-guarantee backend is safe to skip.
+	 *
+	 *   Path B -- device was NOT UpToDate, but all per-peer bitmap UUIDs
+	 *             and all history UUIDs are zero: this is a day0 volume
+	 *             that has never diverged from any peer; new space is
+	 *             guaranteed zeroed by the backend.  Requires
+	 *             rs_discard_granularity to be explicitly configured
+	 *             (non-zero), because discard_zeroes_if_aligned defaults
+	 *             to 1 on all devices -- without an explicit thin-
+	 *             provisioning opt-in the new-region content is not
+	 *             guaranteed clean.
+	 *
+	 * In both cases pass DDSF_NO_RESYNC to leave the new-region bits
+	 * clear rather than marking them dirty.
+	 *
+	 * The on-disk bitmap is written here if la_size_changed; the
+	 * in-memory bitmap is already correct:
+	 *   [0, old_size]        loaded from disk above
+	 *   [old_size, new_size] SET or clear depending on ddsf
+	 */
+	{
+		enum dds_flags ddsf = 0;
+		bool dzoia;
+		u32 rs_discard_granularity;
+
+		rcu_read_lock();
+		dzoia = rcu_dereference(device->ldev->disk_conf)->discard_zeroes_if_aligned;
+		rs_discard_granularity =
+			rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
+		rcu_read_unlock();
+
+		if (dzoia &&
+		    (device->ldev->md.current_uuid & ~UUID_PRIMARY) != UUID_JUST_CREATED) {
+			const char *reason = NULL;
+
+			if (drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE)) {
+				reason = "was UpToDate";
+			} else if (rs_discard_granularity) {
+				/* Path B: check that all bitmap and history UUIDs are zero */
+				bool all_zero = true;
+				int i;
+
+				for (i = 0; i < DRBD_NODE_ID_MAX && all_zero; i++)
+					if (device->ldev->md.peers[i].bitmap_uuid)
+						all_zero = false;
+				for (i = 0; i < HISTORY_UUIDS && all_zero; i++)
+					if (device->ldev->md.history_uuids[i])
+						all_zero = false;
+
+				if (all_zero)
+					reason = "day0 volume (all bitmap and history UUIDs zero)";
+			}
+
+			if (reason) {
+				drbd_info(device, "%s, new region assumed zeroed\n", reason);
+				ddsf = DDSF_NO_RESYNC;
+			}
+		}
+
+		dd = drbd_determine_dev_size(device, 0, ddsf, NULL);
+	}
+	if (dd == DS_ERROR) {
+		retcode = ERR_NOMEM_BITMAP;
+		goto force_diskless_dec;
+	} else if (dd == DS_GREW) {
+		for_each_peer_device(peer_device, device)
+			set_bit(RESYNC_AFTER_NEG, peer_device->flags);
+	}
+
+	/* No activity log record of the crash window: every region may differ
+	 * from any peer, in every slot -- an unallocated one tracks day 0.
+	 */
+	/* MDF_PRIMARY_IND: a clean shutdown clears it, MDF_CRASHED_PRIMARY may
+	 * stay set, so this runs on the first attach after the crash only.
+	 */
+	/* Without a bitmap there is nothing to set; skip rather than claim a
+	 * FullSync in the log that drbd_bitmap_io() then does not do.
+	 */
+	if (device->bitmap &&
+	    test_bit(CRASHED_PRIMARY, &device->flags) &&
+	    drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND) &&
+	    drbd_md_test_flag(device->ldev, MDF_AL_DISABLED)) {
+		drbd_info(device, "AL disabled at crash: all blocks out of sync (aka FullSync)\n");
+		if (drbd_bitmap_io(device, &drbd_bmio_set_all_n_write,
+			"set_all_n_write from attaching", BM_LOCK_ALL, NULL)) {
+			retcode = ERR_IO_MD_DISK;
+			goto force_diskless_dec;
+		}
+	}
+
+	for_each_peer_device(peer_device, device) {
+		if (drbd_md_test_peer_flag(peer_device, __MDF_PEER_FULL_SYNC)) {
+			drbd_info(peer_device, "Assuming that all blocks are out of sync "
+				  "(aka FullSync)\n");
+			if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
+				"set_n_write from attaching", BM_LOCK_ALL | BM_LOCK_SINGLE_SLOT,
+				peer_device)) {
+				retcode = ERR_IO_MD_DISK;
+				goto force_diskless_dec;
+			}
+		}
+	}
 
-	/* allocation not in the IO path, drbdsetup context */
-	nbc = kzalloc_obj(struct drbd_backing_dev);
-	if (!nbc) {
+	/* The activity log replay (drbdmeta apply-al) marked the crash window
+	 * out of sync toward every peer; any of them may lack any of it.
+	 */
+	if (test_bit(CRASHED_PRIMARY, &device->flags) &&
+	    drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND))
+		drbd_md_set_bitmaps_authoritative(device);
+
+	drbd_try_suspend_al(device); /* IO is still suspended here... */
+
+	/* Not drbd_update_mdf_al_disabled(): its get_ldev() fails at
+	 * D_ATTACHING, leaving the flag at the previous session's value.
+	 */
+	rcu_read_lock();
+	al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
+	rcu_read_unlock();
+	__update_mdf_al_disabled(device, al_updates, NOW);
+
+	/* change_disk_state uses disk_state_from_md(device); in case D_NEGOTIATING not
+	   necessary, and falls back to a local state change */
+	rv = stable_state_change(resource, change_disk_state(device,
+				D_NEGOTIATING, CS_VERBOSE | CS_SERIALIZE, "attach", NULL));
+
+	if (rv < SS_SUCCESS) {
+		if (rv == SS_CW_FAILED_BY_PEER)
+			drbd_adm_msg(adm_ctx, "%s",
+				"Probably this node is marked as intentional diskless on a peer");
+		retcode = rv;
+		goto force_diskless_dec;
+	}
+
+	device->device_conf.intentional_diskless = false; /* just in case... */
+
+	mod_timer(&device->request_timer, jiffies + HZ);
+
+	if (resource->role[NOW] == R_PRIMARY
+	&&  device->ldev->md.current_uuid != UUID_JUST_CREATED)
+		device->ldev->md.current_uuid |= UUID_PRIMARY;
+	else
+		device->ldev->md.current_uuid &= ~UUID_PRIMARY;
+
+	drbd_md_sync(device);
+
+	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
+	put_ldev(device);
+	mutex_unlock(&resource->adm_mutex);
+
+	/*
+	 * Wait for UUID negotiation with connected peers to settle before
+	 * reporting the outcome to the caller.  In the no-peers case
+	 * disk_state_from_md() resolves D_NEGOTIATING immediately inside the
+	 * state change, so wait_event returns without blocking.
+	 *
+	 * D_DETACHING is set by sanitize_state() when all connected peers
+	 * return L_NEG_NO_RESULT (stale re-attach with diverged data).  It
+	 * will transition to D_DISKLESS via go_diskless(), so wait for that
+	 * transition too before reporting the error.
+	 */
+	wait_event(device->misc_wait,
+		   (ds = device->disk_state[NOW]) != D_ATTACHING &&
+		    ds != D_NEGOTIATING &&
+		    ds != D_DETACHING);
+
+	if (ds == D_DISKLESS || ds == D_FAILED) {
+		drbd_adm_msg(adm_ctx,
+			"attach negotiation ended in unexpected state %s",
+			drbd_disk_str(ds));
+		retcode = ds == D_FAILED ? ERR_IO_MD_DISK : ERR_DATA_NOT_CURRENT;
+	}
+	goto out_no_adm_mutex;
+
+ force_diskless_dec:
+	put_ldev(device);
+ force_diskless:
+	change_disk_state(device, D_DISKLESS, CS_HARD, "attach", NULL);
+ fail:
+	kfree(bitmap); /* free unpublished local; NULL after publication */
+	/* A bitmap this attach did not publish belongs to a backing device
+	 * whose drbd_ldev_destroy() has not run yet.
+	 */
+	if (published_bitmap)
+		drbd_bm_free(device);
+	mutex_unlock_cond(&resource->conf_update, &have_conf_update);
+	drbd_backing_dev_free(device, nbc);
+	mutex_unlock(&resource->adm_mutex);
+ out_no_adm_mutex:
+	adm_ctx->result = retcode;
+	return 0;
+}
+
+static enum drbd_disk_state get_disk_state(struct drbd_device *device)
+{
+	struct drbd_resource *resource = device->resource;
+	enum drbd_disk_state disk_state;
+
+	read_lock_irq(&resource->state_rwlock);
+	disk_state = device->disk_state[NOW];
+	read_unlock_irq(&resource->state_rwlock);
+	return disk_state;
+}
+
+static int adm_detach(struct drbd_device *device, bool force, bool intentional_diskless,
+		      const char *tag, struct drbd_adm_ctx *ctx)
+{
+	const char *err_str = NULL;
+	int ret, retcode;
+
+	device->device_conf.intentional_diskless = intentional_diskless;
+	if (force) {
+		set_bit(FORCE_DETACH, &device->flags);
+		change_disk_state(device, D_DETACHING, CS_HARD, tag, NULL);
+		retcode = SS_SUCCESS;
+		goto out;
+	}
+
+	/* so no-one is stuck in drbd_al_begin_io */
+	ret = drbd_suspend_io_interruptible(device, READ_AND_WRITE);
+	if (ret) {
+		device->device_conf.intentional_diskless = false;
+		retcode = ERR_INTR;
+		goto out;
+	}
+	retcode = stable_state_change(device->resource,
+		change_disk_state(device, D_DETACHING,
+			CS_VERBOSE | CS_SERIALIZE, tag, &err_str));
+	/*
+	 * D_DETACHING will transition to DISKLESS.
+	 * I did not use CS_WAIT_COMPLETE above since that would deadlock on a backing device that
+	 * does not finish the I/O requests from writing to internal meta-data.  Instead, I
+	 * explicitly flush the worker queue here to ensure w_after_state_change() is completed.
+	 */
+	drbd_flush_workqueue_interruptible(device);
+
+	drbd_resume_io(device);
+	ret = wait_event_interruptible(device->misc_wait,
+			get_disk_state(device) != D_DETACHING);
+	if (retcode >= SS_SUCCESS) {
+		wait_event_interruptible(device->misc_wait, !test_bit(GOING_DISKLESS, &device->flags));
+
+		device->al_writ_cnt = 0;
+		device->bm_writ_cnt = 0;
+		device->read_cnt = 0;
+		device->writ_cnt = 0;
+		clear_bit(AL_SUSPENDED, &device->flags);
+	} else {
+		device->device_conf.intentional_diskless = false;
+	}
+	if (retcode == SS_IS_DISKLESS)
+		retcode = SS_NOTHING_TO_DO;
+	if (ret)
+		retcode = ERR_INTR;
+out:
+	if (err_str) {
+		drbd_adm_msg(ctx, "%s", err_str);
+		kfree(err_str);
+	} else if (retcode == SS_NO_UP_TO_DATE_DISK)
+		put_device_opener_info(device, ctx);
+	return retcode;
+}
+
+/* Detaching the disk is a process in multiple stages.  First we need to lock
+ * out application IO, in-flight IO, IO stuck in drbd_al_begin_io.
+ * Then we transition to D_DISKLESS, and wait for put_ldev() to return all
+ * internal references as well.
+ * Only then we have finally detached. */
+int drbd_adm_detach(struct drbd_adm_ctx *adm_ctx)
+{
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_detach_parms parms = { };
+	int err;
+
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_DETACH_PARMS)) {
+		err = drbd_adm_overlay_detach_parms(adm_ctx, &parms);
+		if (err) {
+			retcode = ERR_MANDATORY_TAG;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto out;
+		}
+	}
+
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out;
+	}
+	retcode = (enum drbd_ret_code)adm_detach(adm_ctx->device, parms.force_detach,
+			parms.intentional_diskless_detach, "detach", adm_ctx);
+	mutex_unlock(&adm_ctx->resource->adm_mutex);
+
+out:
+	adm_ctx->result = retcode;
+	return 0;
+}
+
+static bool conn_resync_running(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	bool rv = false;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (peer_device->repl_state[NOW] == L_SYNC_SOURCE ||
+		    peer_device->repl_state[NOW] == L_SYNC_TARGET ||
+		    peer_device->repl_state[NOW] == L_PAUSED_SYNC_S ||
+		    peer_device->repl_state[NOW] == L_PAUSED_SYNC_T) {
+			rv = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+static bool conn_ov_running(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	bool rv = false;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (peer_device->repl_state[NOW] == L_VERIFY_S ||
+		    peer_device->repl_state[NOW] == L_VERIFY_T) {
+			rv = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return rv;
+}
+
+static enum drbd_ret_code
+_check_net_options(struct drbd_connection *connection, struct drbd_net_conf *old_net_conf,
+		   struct drbd_net_conf *new_net_conf)
+{
+	if (old_net_conf && connection->cstate[NOW] == C_CONNECTED && connection->agreed_pro_version < 100) {
+		if (new_net_conf->wire_protocol != old_net_conf->wire_protocol)
+			return ERR_NEED_APV_100;
+
+		if (new_net_conf->two_primaries != old_net_conf->two_primaries)
+			return ERR_NEED_APV_100;
+
+		if (strcmp(new_net_conf->integrity_alg, old_net_conf->integrity_alg))
+			return ERR_NEED_APV_100;
+	}
+
+	if (!new_net_conf->two_primaries &&
+	    connection->resource->role[NOW] == R_PRIMARY &&
+	    connection->peer_role[NOW] == R_PRIMARY)
+		return ERR_NEED_ALLOW_TWO_PRI;
+
+	if (new_net_conf->two_primaries &&
+	    (new_net_conf->wire_protocol != DRBD_PROT_C))
+		return ERR_NOT_PROTO_C;
+
+	if (new_net_conf->wire_protocol == DRBD_PROT_A &&
+	    new_net_conf->fencing_policy == FP_STONITH)
+		return ERR_STONITH_AND_PROT_A;
+
+	if (new_net_conf->on_congestion != OC_BLOCK &&
+	    new_net_conf->wire_protocol != DRBD_PROT_A)
+		return ERR_CONG_NOT_PROTO_A;
+
+	return NO_ERROR;
+}
+
+static enum drbd_ret_code
+check_net_options(struct drbd_connection *connection, struct drbd_net_conf *new_net_conf)
+{
+	enum drbd_ret_code rv;
+
+	rcu_read_lock();
+	rv = _check_net_options(connection, rcu_dereference(connection->transport.net_conf), new_net_conf);
+	rcu_read_unlock();
+
+	return rv;
+}
+
+struct crypto {
+	struct crypto_shash *verify_tfm;
+	struct crypto_shash *csums_tfm;
+	struct crypto_shash *cram_hmac_tfm;
+	struct crypto_shash *integrity_tfm;
+};
+
+static bool needs_key(struct crypto_shash *h)
+{
+	return h && (crypto_shash_get_flags(h) & CRYPTO_TFM_NEED_KEY);
+}
+
+/**
+ * alloc_shash() - Allocate a keyed or unkeyed shash algorithm
+ * @tfm: Destination crypto_shash
+ * @tfm_name: Which algorithm to use
+ * @type: The functionality that the hash is used for
+ * @must_unkeyed: If set, a check is included which ensures that the algorithm
+ *           does not require a key
+ * @ctx: for sending detailed error description to user-space
+ */
+static int
+alloc_shash(struct crypto_shash **tfm, char *tfm_name, const char *type, bool must_unkeyed,
+	    struct drbd_adm_ctx *ctx)
+{
+	if (!tfm_name[0])
+		return 0;
+
+	*tfm = crypto_alloc_shash(tfm_name, 0, 0);
+	if (IS_ERR(*tfm)) {
+		drbd_adm_msg(ctx, "failed to allocate %s for %s\n", tfm_name, type);
+		*tfm = NULL;
+		return -EINVAL;
+	}
+
+	if (must_unkeyed && needs_key(*tfm)) {
+		drbd_adm_msg(ctx,
+			     "may not use %s for %s. It requires an unkeyed algorithm\n",
+			     tfm_name, type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum drbd_ret_code
+alloc_crypto(struct crypto *crypto, struct drbd_net_conf *new_net_conf, struct drbd_adm_ctx *ctx)
+{
+	char hmac_name[CRYPTO_MAX_ALG_NAME];
+	int digest_size = 0;
+	int err;
+
+	err = alloc_shash(&crypto->csums_tfm, new_net_conf->csums_alg,
+			  "csums", true, ctx);
+	if (err)
+		return ERR_CSUMS_ALG;
+
+	err = alloc_shash(&crypto->verify_tfm, new_net_conf->verify_alg,
+			  "verify", true, ctx);
+	if (err)
+		return ERR_VERIFY_ALG;
+
+	err = alloc_shash(&crypto->integrity_tfm, new_net_conf->integrity_alg,
+			  "integrity", true, ctx);
+	if (err)
+		return ERR_INTEGRITY_ALG;
+
+	if (crypto->integrity_tfm) {
+		const int max_digest_size = sizeof(((struct drbd_connection *)0)->scratch_buffer.d.before);
+
+		digest_size = crypto_shash_digestsize(crypto->integrity_tfm);
+		if (digest_size > max_digest_size) {
+			drbd_adm_msg(ctx,
+				"we currently support only digest sizes <= %d bits, but digest size of %s is %d bits\n",
+				max_digest_size * 8, new_net_conf->integrity_alg, digest_size * 8);
+			return ERR_INTEGRITY_ALG;
+		}
+	}
+
+	if (new_net_conf->cram_hmac_alg[0] != 0) {
+		snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
+			 new_net_conf->cram_hmac_alg);
+
+		err = alloc_shash(&crypto->cram_hmac_tfm, hmac_name,
+				  "hmac", false, ctx);
+		if (err)
+			return ERR_AUTH_ALG;
+	}
+
+	return NO_ERROR;
+}
+
+static void free_crypto(struct crypto *crypto)
+{
+	crypto_free_shash(crypto->cram_hmac_tfm);
+	crypto_free_shash(crypto->integrity_tfm);
+	crypto_free_shash(crypto->csums_tfm);
+	crypto_free_shash(crypto->verify_tfm);
+}
+
+int drbd_adm_net_opts(struct drbd_adm_ctx *adm_ctx)
+{
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_connection *connection;
+	struct drbd_transport *transport;
+	struct drbd_net_conf *old_net_conf, *new_net_conf = NULL;
+	int err;
+	int ovr; /* online verify running */
+	int rsr; /* re-sync running */
+	struct crypto crypto = { };
+
+	connection = adm_ctx->connection;
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+
+	new_net_conf = kzalloc_obj(struct drbd_net_conf);
+	if (!new_net_conf) {
 		retcode = ERR_NOMEM;
+		goto out;
+	}
+
+	drbd_flush_workqueue(&connection->sender_work);
+
+	mutex_lock(&connection->resource->conf_update);
+	mutex_lock(&connection->mutex[DATA_STREAM]);
+	transport = &connection->transport;
+	old_net_conf = transport->net_conf;
+
+	if (!old_net_conf) {
+		drbd_adm_msg(adm_ctx, "%s", "net conf missing, try connect");
+		retcode = ERR_INVALID_REQUEST;
+		goto fail;
+	}
+
+	*new_net_conf = *old_net_conf;
+	if (adm_ctx->set_defaults)
+		drbd_set_net_conf_defaults(new_net_conf);
+
+	/* The transport_name is immutable taking precedence over drbd_set_net_conf_defaults() */
+	memcpy(new_net_conf->transport_name, old_net_conf->transport_name,
+	       old_net_conf->transport_name_len);
+	new_net_conf->transport_name_len = old_net_conf->transport_name_len;
+	new_net_conf->load_balance_paths = old_net_conf->load_balance_paths;
+
+	err = drbd_adm_overlay_net_conf(adm_ctx, new_net_conf);
+	if (err && err != -ENOMSG) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto fail;
+	}
+
+	if (adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_NET_TRANSPORT_NAME) ||
+	    adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_NET_LOAD_BALANCE_PATHS)) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg(adm_ctx, "%s", "cannot change invariant setting");
+		goto fail;
+	}
+
+	retcode = check_net_options(connection, new_net_conf);
+	if (retcode != NO_ERROR)
+		goto fail;
+
+	/* re-sync running */
+	rsr = conn_resync_running(connection);
+	if (rsr && strcmp(new_net_conf->csums_alg, old_net_conf->csums_alg)) {
+		retcode = ERR_CSUMS_RESYNC_RUNNING;
 		goto fail;
 	}
-	spin_lock_init(&nbc->md.uuid_lock);
 
-	new_disk_conf = kzalloc_obj(struct disk_conf);
-	if (!new_disk_conf) {
-		retcode = ERR_NOMEM;
+	/* online verify running */
+	ovr = conn_ov_running(connection);
+	if (ovr && strcmp(new_net_conf->verify_alg, old_net_conf->verify_alg)) {
+		retcode = ERR_VERIFY_RUNNING;
 		goto fail;
 	}
-	nbc->disk_conf = new_disk_conf;
 
-	set_disk_conf_defaults(new_disk_conf);
-	err = disk_conf_from_attrs(new_disk_conf, info);
+	retcode = alloc_crypto(&crypto, new_net_conf, adm_ctx);
+	if (retcode != NO_ERROR)
+		goto fail;
+
+	/* Call before updating net_conf in case the transport needs to compare
+	 * old and new configurations. */
+	err = transport->class->ops.net_conf_change(transport, new_net_conf);
 	if (err) {
-		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+		drbd_adm_msg(adm_ctx, "transport net_conf_change failed: %d", err);
+		retcode = ERR_INVALID_REQUEST;
 		goto fail;
 	}
 
-	if (new_disk_conf->c_plan_ahead > DRBD_C_PLAN_AHEAD_MAX)
-		new_disk_conf->c_plan_ahead = DRBD_C_PLAN_AHEAD_MAX;
+	rcu_assign_pointer(transport->net_conf, new_net_conf);
+	connection->fencing_policy = new_net_conf->fencing_policy;
 
-	new_plan = fifo_alloc((new_disk_conf->c_plan_ahead * 10 * SLEEP_TIME) / HZ);
-	if (!new_plan) {
-		retcode = ERR_NOMEM;
-		goto fail;
+	if (!rsr) {
+		crypto_free_shash(connection->csums_tfm);
+		connection->csums_tfm = crypto.csums_tfm;
+		crypto.csums_tfm = NULL;
+	}
+	if (!ovr) {
+		crypto_free_shash(connection->verify_tfm);
+		connection->verify_tfm = crypto.verify_tfm;
+		crypto.verify_tfm = NULL;
 	}
 
-	if (new_disk_conf->meta_dev_idx < DRBD_MD_INDEX_FLEX_INT) {
-		retcode = ERR_MD_IDX_INVALID;
-		goto fail;
+	crypto_free_shash(connection->integrity_tfm);
+	connection->integrity_tfm = crypto.integrity_tfm;
+	if (connection->cstate[NOW] >= C_CONNECTED && connection->agreed_pro_version >= 100)
+		/* Do this without trying to take connection->data.mutex again.  */
+		__drbd_send_protocol(connection, P_PROTOCOL_UPDATE);
+
+	crypto_free_shash(connection->cram_hmac_tfm);
+	connection->cram_hmac_tfm = crypto.cram_hmac_tfm;
+
+	mutex_unlock(&connection->mutex[DATA_STREAM]);
+	mutex_unlock(&connection->resource->conf_update);
+	kvfree_rcu_mightsleep(old_net_conf);
+
+	if (connection->cstate[NOW] >= C_CONNECTED) {
+		struct drbd_peer_device *peer_device;
+		int vnr;
+
+		idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+			drbd_send_sync_param(peer_device);
 	}
 
-	rcu_read_lock();
-	nc = rcu_dereference(connection->net_conf);
-	if (nc) {
-		if (new_disk_conf->fencing == FP_STONITH && nc->wire_protocol == DRBD_PROT_A) {
-			rcu_read_unlock();
-			retcode = ERR_STONITH_AND_PROT_A;
-			goto fail;
+	goto out;
+
+ fail:
+	mutex_unlock(&connection->mutex[DATA_STREAM]);
+	mutex_unlock(&connection->resource->conf_update);
+	free_crypto(&crypto);
+	kfree(new_net_conf);
+ out:
+	mutex_unlock(&adm_ctx->resource->adm_mutex);
+ out_no_adm_mutex:
+	adm_ctx->result = retcode;
+	return 0;
+}
+
+static int adjust_resync_fifo(struct drbd_peer_device *peer_device,
+			      struct drbd_peer_device_conf *conf,
+			      struct fifo_buffer **pp_old_plan)
+{
+	struct fifo_buffer *old_plan, *new_plan = NULL;
+	unsigned int fifo_size;
+
+	fifo_size = (conf->c_plan_ahead * 10 * RS_MAKE_REQS_INTV) / HZ;
+
+	old_plan = rcu_dereference_protected(peer_device->rs_plan_s,
+			     lockdep_is_held(&peer_device->connection->resource->conf_update));
+	if (!old_plan || fifo_size != old_plan->size) {
+		new_plan = fifo_alloc(fifo_size);
+		if (!new_plan) {
+			drbd_err(peer_device, "kmalloc of fifo_buffer failed");
+			return -ENOMEM;
 		}
+		rcu_assign_pointer(peer_device->rs_plan_s, new_plan);
+		if (pp_old_plan)
+			*pp_old_plan = old_plan;
 	}
-	rcu_read_unlock();
 
-	retcode = open_backing_devices(device, new_disk_conf, nbc);
-	if (retcode != NO_ERROR)
-		goto fail;
+	return 0;
+}
 
-	if ((nbc->backing_bdev == nbc->md_bdev) !=
-	    (new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_INTERNAL ||
-	     new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_FLEX_INT)) {
-		retcode = ERR_MD_IDX_INVALID;
-		goto fail;
-	}
+int drbd_adm_peer_device_opts(struct drbd_adm_ctx *adm_ctx)
+{
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_peer_device *peer_device;
+	struct drbd_peer_device_conf *old_peer_device_conf, *new_peer_device_conf = NULL;
+	struct fifo_buffer *old_plan = NULL;
+	struct drbd_device *device;
+	bool notify = false;
+	int err;
 
-	resync_lru = lc_create("resync", drbd_bm_ext_cache,
-			1, 61, sizeof(struct bm_extent),
-			offsetof(struct bm_extent, lce));
-	if (!resync_lru) {
-		retcode = ERR_NOMEM;
-		goto fail;
+	peer_device = adm_ctx->peer_device;
+	device = peer_device->device;
+
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
 	}
+	mutex_lock(&adm_ctx->resource->conf_update);
 
-	/* Read our meta data super block early.
-	 * This also sets other on-disk offsets. */
-	retcode = drbd_md_read(device, nbc);
-	if (retcode != NO_ERROR)
+	new_peer_device_conf = kzalloc_obj(struct drbd_peer_device_conf);
+	if (!new_peer_device_conf)
 		goto fail;
 
-	sanitize_disk_conf(device, new_disk_conf, nbc);
+	old_peer_device_conf = peer_device->conf;
+	*new_peer_device_conf = *old_peer_device_conf;
+	if (adm_ctx->set_defaults)
+		drbd_set_peer_device_conf_defaults(new_peer_device_conf);
 
-	if (drbd_get_max_capacity(nbc) < new_disk_conf->disk_size) {
-		drbd_err(device, "max capacity %llu smaller than disk size %llu\n",
-			(unsigned long long) drbd_get_max_capacity(nbc),
-			(unsigned long long) new_disk_conf->disk_size);
-		retcode = ERR_DISK_TOO_SMALL;
-		goto fail;
+	err = drbd_adm_overlay_peer_device_conf(adm_ctx, new_peer_device_conf);
+	if (err && err != -ENOMSG) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto fail_ret_set;
 	}
 
-	if (new_disk_conf->meta_dev_idx < 0) {
-		max_possible_sectors = DRBD_MAX_SECTORS_FLEX;
-		/* at least one MB, otherwise it does not make sense */
-		min_md_device_sectors = (2<<10);
-	} else {
-		max_possible_sectors = DRBD_MAX_SECTORS;
-		min_md_device_sectors = MD_128MB_SECT * (new_disk_conf->meta_dev_idx + 1);
+	if (!old_peer_device_conf->bitmap && new_peer_device_conf->bitmap &&
+	    peer_device->bitmap_index == -1) {
+		if (get_ldev(device)) {
+			err = allocate_bitmap_index(peer_device, device->ldev);
+			put_ldev(device);
+			if (err) {
+				drbd_adm_msg(adm_ctx, "%s",
+					     "No bitmap slot available in meta-data");
+				retcode = ERR_INVALID_REQUEST;
+				goto fail_ret_set;
+			}
+			drbd_info(peer_device,
+				  "Former intentional diskless peer got bitmap slot %d\n",
+				  peer_device->bitmap_index);
+			drbd_md_sync(device);
+			notify = true;
+		}
 	}
 
-	if (drbd_get_capacity(nbc->md_bdev) < min_md_device_sectors) {
-		retcode = ERR_MD_DISK_TOO_SMALL;
-		drbd_warn(device, "refusing attach: md-device too small, "
-		     "at least %llu sectors needed for this meta-disk type\n",
-		     (unsigned long long) min_md_device_sectors);
-		goto fail;
+	if (old_peer_device_conf->bitmap && !new_peer_device_conf->bitmap) {
+		enum drbd_disk_state pdsk = peer_device->disk_state[NOW];
+		enum drbd_disk_state disk = device->disk_state[NOW];
+
+		if (!(disk == D_DISKLESS || pdsk == D_DISKLESS || pdsk == D_UNKNOWN)) {
+			drbd_adm_msg(adm_ctx, "%s",
+				     "Can not drop the bitmap when both sides have a disk");
+			retcode = ERR_INVALID_REQUEST;
+			goto fail_ret_set;
+		}
+		err = clear_peer_slot(device, peer_device->node_id, MDF_NODE_EXISTS);
+		if (!err) {
+			peer_device->bitmap_index = -1;
+			notify = true;
+		}
 	}
 
-	/* Make sure the new disk is big enough
-	 * (we may currently be R_PRIMARY with no local disk...) */
-	if (drbd_get_max_capacity(nbc) < get_capacity(device->vdisk)) {
-		retcode = ERR_DISK_TOO_SMALL;
+	if (!expect(peer_device, new_peer_device_conf->resync_rate >= 1))
+		new_peer_device_conf->resync_rate = 1;
+
+	if (new_peer_device_conf->c_plan_ahead > DRBD_C_PLAN_AHEAD_MAX)
+		new_peer_device_conf->c_plan_ahead = DRBD_C_PLAN_AHEAD_MAX;
+
+	err = adjust_resync_fifo(peer_device, new_peer_device_conf, &old_plan);
+	if (err)
 		goto fail;
+
+	rcu_assign_pointer(peer_device->conf, new_peer_device_conf);
+
+	kvfree_rcu_mightsleep(old_peer_device_conf);
+	kfree(old_plan);
+
+	/* No need to call drbd_send_sync_param() here. The values in
+	 * peer_device->conf that we send are ignored by recent peers anyway. */
+
+	if (0) {
+fail:
+		retcode = ERR_NOMEM;
+fail_ret_set:
+		kfree(new_peer_device_conf);
 	}
 
-	nbc->known_size = drbd_get_capacity(nbc->backing_bdev);
+	mutex_unlock(&adm_ctx->resource->conf_update);
+	mutex_unlock(&adm_ctx->resource->adm_mutex);
+out_no_adm_mutex:
+	if (notify)
+		drbd_broadcast_peer_device_state(peer_device);
+	adm_ctx->result = retcode;
+	return 0;
+
+}
+
+int drbd_create_peer_device_default_config(struct drbd_peer_device *peer_device)
+{
+	struct drbd_peer_device_conf *conf;
+	int err;
+
+	conf = kzalloc_obj(*conf);
+	if (!conf)
+		return -ENOMEM;
+
+	drbd_set_peer_device_conf_defaults(conf);
+	err = adjust_resync_fifo(peer_device, conf, NULL);
+	if (err)
+		return err;
+
+	peer_device->conf = conf;
+
+	return 0;
+}
+
+static void connection_to_info(struct drbd_connection_info *info,
+			       struct drbd_connection *connection)
+{
+	info->conn_connection_state = connection->cstate[NOW];
+	info->conn_role = connection->peer_role[NOW];
+#ifdef CONFIG_DRBD_COMPAT_84
+	/* No "before" state of its own; see resource_to_info() above. */
+	info->old_conn_connection_state = info->conn_connection_state;
+	info->old_conn_role = info->conn_role;
+#endif
+}
+
+#define str_to_info(info, field, str) ({ \
+	strscpy(info->field, str, sizeof(info->field)); \
+	info->field ## _len = min(strlen(str), sizeof(info->field)); \
+})
+
+/* shared logic between peer_device_to_info and peer_device_state_change_to_info */
+static void __peer_device_to_info(struct drbd_peer_device_info *info,
+				  struct drbd_peer_device *peer_device,
+				  enum which_state which)
+{
+	info->peer_resync_susp_dependency = resync_susp_comb_dep(peer_device, which);
+	info->peer_is_intentional_diskless = !want_bitmap(peer_device);
+}
 
-	if (nbc->known_size > max_possible_sectors) {
-		drbd_warn(device, "==> truncating very big lower level device "
-			"to currently maximum possible %llu sectors <==\n",
-			(unsigned long long) max_possible_sectors);
-		if (new_disk_conf->meta_dev_idx >= 0)
-			drbd_warn(device, "==>> using internal or flexible "
-				      "meta data may help <<==\n");
-	}
-
-	drbd_suspend_io(device);
-	/* also wait for the last barrier ack. */
-	/* FIXME see also https://daiquiri.linbit/cgi-bin/bugzilla/show_bug.cgi?id=171
-	 * We need a way to either ignore barrier acks for barriers sent before a device
-	 * was attached, or a way to wait for all pending barrier acks to come in.
-	 * As barriers are counted per resource,
-	 * we'd need to suspend io on all devices of a resource.
+static void peer_device_to_info(struct drbd_peer_device_info *info,
+				struct drbd_peer_device *peer_device)
+{
+	info->peer_repl_state = peer_device->repl_state[NOW];
+	info->peer_disk_state = peer_device->disk_state[NOW];
+	info->peer_resync_susp_user = peer_device->resync_susp_user[NOW];
+	info->peer_resync_susp_peer = peer_device->resync_susp_peer[NOW];
+	info->peer_resync_susp_max_parallel = peer_device->resync_susp_max_parallel[NOW];
+	__peer_device_to_info(info, peer_device, NOW);
+#ifdef CONFIG_DRBD_COMPAT_84
+	/*
+	 * No "before" state of its own; see resource_to_info() above. This
+	 * matters in particular for drbd_broadcast_peer_device_state()'s
+	 * RS_PROGRESS-driven NOTIFY_CHANGE call (drbd_nl.c): it fires far
+	 * more often than the resync bitmap-writeout path's own throttled
+	 * SIB_SYNC_PROGRESS emission, and without old == new here it would
+	 * feed compat84_notify_peer_device_state()'s fused-event code a
+	 * fabricated repl/disk-state transition from uninitialized stack
+	 * data instead of correctly reporting no change.
 	 */
-	wait_event(device->misc_wait, !atomic_read(&device->ap_pending_cnt) || drbd_suspended(device));
-	/* and for any other previously queued work */
-	drbd_flush_workqueue(&connection->sender_work);
+	info->old_peer_repl_state = info->peer_repl_state;
+	info->old_peer_disk_state = info->peer_disk_state;
+	info->old_peer_resync_susp_user = info->peer_resync_susp_user;
+	info->old_peer_resync_susp_peer = info->peer_resync_susp_peer;
+	info->old_peer_resync_susp_dependency = info->peer_resync_susp_dependency;
+#endif
+}
 
-	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
-	retcode = (enum drbd_ret_code)rv;
-	drbd_resume_io(device);
-	if (rv < SS_SUCCESS)
-		goto fail;
+void peer_device_state_change_to_info(struct drbd_peer_device_info *info,
+				      struct drbd_peer_device_state_change *state_change)
+{
+	info->peer_repl_state = state_change->repl_state[NEW];
+	info->peer_disk_state = state_change->disk_state[NEW];
+	info->peer_resync_susp_user = state_change->resync_susp_user[NEW];
+	info->peer_resync_susp_peer = state_change->resync_susp_peer[NEW];
+	info->peer_resync_susp_max_parallel = state_change->resync_susp_max_parallel[NEW];
+	__peer_device_to_info(info, state_change->peer_device, NEW);
+#ifdef CONFIG_DRBD_COMPAT_84
+	info->old_peer_repl_state = state_change->repl_state[OLD];
+	info->old_peer_disk_state = state_change->disk_state[OLD];
+	/*
+	 * Exact pre-transition values, straight from the frozen snapshot
+	 * (unlike the live peer_device object, where which_state's OLD
+	 * aliases NOW and would already read the post-transition value by
+	 * the time a notification runs). old_peer_resync_susp_dependency
+	 * covers resync_susp_dependency[OLD] and resync_susp_other_c[OLD],
+	 * the same two terms peer_resync_susp_dependency's own
+	 * resync_susp_comb_dep() combines for the live/NEW side, but not
+	 * its third term (sync-source with an inconsistent local disk):
+	 * that needs the sibling device_state_change's disk_state[OLD],
+	 * which this peer-device-only snapshot does not carry and
+	 * notify_peer_device_state_change()'s generic callback signature
+	 * (shared across all four notified object types) has no index to
+	 * reach. A transition whose only isp change is that third term
+	 * still reports a correct peer_isp/user_isp "before" here; only
+	 * aftr_isp could misrepresent that one specific case.
+	 */
+	info->old_peer_resync_susp_user = state_change->resync_susp_user[OLD];
+	info->old_peer_resync_susp_peer = state_change->resync_susp_peer[OLD];
+	info->old_peer_resync_susp_dependency =
+		state_change->resync_susp_dependency[OLD] || state_change->resync_susp_other_c[OLD];
+#endif
+}
 
-	if (!get_ldev_if_state(device, D_ATTACHING))
-		goto force_diskless;
+/* shared logic between device_to_info and device_state_change_to_info */
+static void __device_to_info(struct drbd_device_info *info,
+			     struct drbd_device *device)
+{
+	info->is_intentional_diskless = device->device_conf.intentional_diskless;
+	info->dev_is_open = device->open_cnt != 0;
 
-	if (!device->bitmap) {
-		if (drbd_bm_init(device)) {
-			retcode = ERR_NOMEM;
-			goto force_diskless_dec;
-		}
+	rcu_read_lock();
+	if (get_ldev_if_state(device, D_FAILED)) {
+		struct drbd_disk_conf *disk_conf =
+			rcu_dereference(device->ldev->disk_conf);
+		str_to_info(info, backing_dev_path, disk_conf->backing_dev);
+		put_ldev(device);
+	} else {
+		info->backing_dev_path[0] = '\0';
+		info->backing_dev_path_len = 0;
 	}
+	rcu_read_unlock();
+}
 
-	if (device->state.pdsk != D_UP_TO_DATE && device->ed_uuid &&
-	    (device->state.role == R_PRIMARY || device->state.peer == R_PRIMARY) &&
-            (device->ed_uuid & ~((u64)1)) != (nbc->md.uuid[UI_CURRENT] & ~((u64)1))) {
-		drbd_err(device, "Can only attach to data with current UUID=%016llX\n",
-		    (unsigned long long)device->ed_uuid);
-		retcode = ERR_DATA_NOT_CURRENT;
-		goto force_diskless_dec;
-	}
+void device_to_info(struct drbd_device_info *info,
+			   struct drbd_device *device)
+{
+	info->dev_disk_state = device->disk_state[NOW];
+	info->dev_has_quorum = device->have_quorum[NOW];
+	__device_to_info(info, device);
+#ifdef CONFIG_DRBD_COMPAT_84
+	/* No "before" state of its own; see resource_to_info() above. */
+	info->old_dev_disk_state = info->dev_disk_state;
+#endif
+}
 
-	/* Since we are diskless, fix the activity log first... */
-	if (drbd_check_al_size(device, new_disk_conf)) {
-		retcode = ERR_NOMEM;
-		goto force_diskless_dec;
+void device_state_change_to_info(struct drbd_device_info *info,
+				 struct drbd_device_state_change *state_change)
+{
+	info->dev_disk_state = state_change->disk_state[NEW];
+	info->dev_has_quorum = state_change->have_quorum[NEW];
+	__device_to_info(info, state_change->device);
+#ifdef CONFIG_DRBD_COMPAT_84
+	info->old_dev_disk_state = state_change->disk_state[OLD];
+#endif
+}
+
+static bool is_resync_target_in_other_connection(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_peer_device *p;
+
+	for_each_peer_device(p, device) {
+		if (p == peer_device)
+			continue;
+
+		if (p->repl_state[NOW] == L_SYNC_TARGET)
+			return true;
 	}
 
-	/* Prevent shrinking of consistent devices ! */
-	{
-	unsigned long long nsz = drbd_new_dev_size(device, nbc, nbc->disk_conf->disk_size, 0);
-	unsigned long long eff = nbc->md.la_size_sect;
-	if (drbd_md_test_flag(nbc, MDF_CONSISTENT) && nsz < eff) {
-		if (nsz == nbc->disk_conf->disk_size) {
-			drbd_warn(device, "truncating a consistent device during attach (%llu < %llu)\n", nsz, eff);
-		} else {
-			drbd_warn(device, "refusing to truncate a consistent device (%llu < %llu)\n", nsz, eff);
-			drbd_msg_sprintf_info(adm_ctx->reply_skb,
-				"To-be-attached device has last effective > current size, and is consistent\n"
-				"(%llu > %llu sectors). Refusing to attach.", eff, nsz);
-			retcode = ERR_IMPLICIT_SHRINK;
-			goto force_diskless_dec;
-		}
+	return false;
+}
+
+static enum drbd_ret_code drbd_check_name_str(const char *name, const bool strict);
+static void drbd_msg_put_name_error(struct drbd_adm_ctx *ctx, enum drbd_ret_code ret_code);
+
+static enum drbd_ret_code drbd_check_conn_name(struct drbd_resource *resource, const char *new_name)
+{
+	struct drbd_connection *connection;
+	enum drbd_ret_code retcode = NO_ERROR;
+	const char *tmp_name;
+
+	retcode = drbd_check_name_str(new_name, drbd_strict_names);
+	if (retcode != NO_ERROR)
+		return retcode;
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		/* is this even possible? */
+		if (!connection->transport.net_conf)
+			continue;
+		tmp_name = connection->transport.net_conf->name;
+		if (!tmp_name)
+			continue;
+		if (strcmp(tmp_name, new_name))
+			continue;
+		retcode = ERR_ALREADY_EXISTS;
+		break;
 	}
+	rcu_read_unlock();
+	return retcode;
+}
+
+static int adm_new_connection(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_connection_info connection_info;
+	enum drbd_notification_type flags;
+	unsigned int peer_devices = 0;
+	struct drbd_device *device;
+	struct drbd_peer_device *peer_device;
+	struct drbd_net_conf *old_net_conf, *new_net_conf = NULL;
+	struct crypto crypto = { NULL, };
+	struct drbd_connection *connection;
+	enum drbd_ret_code retcode = NO_ERROR;
+	int i, err;
+	char *transport_name;
+	struct drbd_transport_class *tr_class;
+	struct drbd_transport *transport;
+
+	/* allocation not in the IO path, drbdsetup / netlink process context */
+	new_net_conf = kzalloc_obj(*new_net_conf);
+	if (!new_net_conf)
+		return ERR_NOMEM;
+
+	drbd_set_net_conf_defaults(new_net_conf);
+
+	err = drbd_adm_overlay_net_conf(adm_ctx, new_net_conf);
+	if (err) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto fail;
 	}
 
-	lock_all_resources();
-	retcode = drbd_resync_after_valid(device, new_disk_conf->resync_after);
+	retcode = drbd_check_conn_name(adm_ctx->resource, new_net_conf->name);
 	if (retcode != NO_ERROR) {
-		unlock_all_resources();
-		goto force_diskless_dec;
+		drbd_msg_put_name_error(adm_ctx, retcode);
+		goto fail;
 	}
 
-	/* Reset the "barriers don't work" bits here, then force meta data to
-	 * be written, to ensure we determine if barriers are supported. */
-	if (new_disk_conf->md_flushes)
-		clear_bit(MD_NO_FUA, &device->flags);
-	else
-		set_bit(MD_NO_FUA, &device->flags);
-
-	/* Point of no return reached.
-	 * Devices and memory are no longer released by error cleanup below.
-	 * now device takes over responsibility, and the state engine should
-	 * clean it up somewhere.  */
-	D_ASSERT(device, device->ldev == NULL);
-	device->ldev = nbc;
-	device->resync = resync_lru;
-	device->rs_plan_s = new_plan;
-	nbc = NULL;
-	resync_lru = NULL;
-	new_disk_conf = NULL;
-	new_plan = NULL;
-
-	drbd_resync_after_changed(device);
-	drbd_bump_write_ordering(device->resource, device->ldev, WO_BDEV_FLUSH);
-	unlock_all_resources();
+	transport_name = new_net_conf->transport_name_len ? new_net_conf->transport_name :
+		new_net_conf->load_balance_paths ? "lb-tcp" : "tcp";
+	tr_class = drbd_get_transport_class(transport_name);
+	if (!tr_class) {
+		retcode = ERR_CREATE_TRANSPORT;
+		goto fail;
+	}
 
-	if (drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY))
-		set_bit(CRASHED_PRIMARY, &device->flags);
-	else
-		clear_bit(CRASHED_PRIMARY, &device->flags);
+	connection = drbd_create_connection(adm_ctx->resource, tr_class);
+	if (!connection) {
+		retcode = ERR_NOMEM;
+		goto fail_put_transport;
+	}
+	connection->peer_node_id = adm_ctx->peer_node_id;
+	/* transport class reference now owned by connection,
+	 * prevent double cleanup. */
+	tr_class = NULL;
 
-	if (drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND) &&
-	    !(device->state.role == R_PRIMARY && device->resource->susp_nod))
-		set_bit(CRASHED_PRIMARY, &device->flags);
+	mutex_lock(&adm_ctx->resource->conf_update);
+	retcode = check_net_options(connection, new_net_conf);
+	if (retcode != NO_ERROR)
+		goto unlock_fail_free_connection;
 
-	device->send_cnt = 0;
-	device->recv_cnt = 0;
-	device->read_cnt = 0;
-	device->writ_cnt = 0;
+	retcode = alloc_crypto(&crypto, new_net_conf, adm_ctx);
+	if (retcode != NO_ERROR)
+		goto unlock_fail_free_connection;
 
-	drbd_reconsider_queue_parameters(device, device->ldev, NULL);
+	((char *)new_net_conf->shared_secret)[SHARED_SECRET_MAX-1] = 0;
 
-	/* If I am currently not R_PRIMARY,
-	 * but meta data primary indicator is set,
-	 * I just now recover from a hard crash,
-	 * and have been R_PRIMARY before that crash.
-	 *
-	 * Now, if I had no connection before that crash
-	 * (have been degraded R_PRIMARY), chances are that
-	 * I won't find my peer now either.
-	 *
-	 * In that case, and _only_ in that case,
-	 * we use the degr-wfc-timeout instead of the default,
-	 * so we can automatically recover from a crash of a
-	 * degraded but active "cluster" after a certain timeout.
-	 */
-	clear_bit(USE_DEGR_WFC_T, &device->flags);
-	if (device->state.role != R_PRIMARY &&
-	     drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND) &&
-	    !drbd_md_test_flag(device->ldev, MDF_CONNECTED_IND))
-		set_bit(USE_DEGR_WFC_T, &device->flags);
-
-	dd = drbd_determine_dev_size(device, 0, NULL);
-	if (dd <= DS_ERROR) {
-		retcode = ERR_NOMEM_BITMAP;
-		goto force_diskless_dec;
-	} else if (dd == DS_GREW)
-		set_bit(RESYNC_AFTER_NEG, &device->flags);
-
-	if (drbd_md_test_flag(device->ldev, MDF_FULL_SYNC) ||
-	    (test_bit(CRASHED_PRIMARY, &device->flags) &&
-	     drbd_md_test_flag(device->ldev, MDF_AL_DISABLED))) {
-		drbd_info(device, "Assuming that all blocks are out of sync "
-		     "(aka FullSync)\n");
-		if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
-			"set_n_write from attaching", BM_LOCKED_MASK,
-			NULL)) {
-			retcode = ERR_IO_MD_DISK;
-			goto force_diskless_dec;
-		}
-	} else {
-		if (drbd_bitmap_io(device, &drbd_bm_read,
-			"read from attaching", BM_LOCKED_MASK,
-			NULL)) {
-			retcode = ERR_IO_MD_DISK;
-			goto force_diskless_dec;
+	idr_for_each_entry(&adm_ctx->resource->devices, device, i) {
+		int id;
+
+		retcode = ERR_NOMEM;
+		peer_device = create_peer_device(device, connection);
+		if (!peer_device)
+			goto unlock_fail_free_connection;
+		id = idr_alloc(&connection->peer_devices, peer_device,
+			       device->vnr, device->vnr + 1, GFP_KERNEL);
+		if (id < 0)
+			goto unlock_fail_free_connection;
+
+		if (get_ldev(device)) {
+			struct drbd_peer_md *peer_md =
+				&device->ldev->md.peers[adm_ctx->peer_node_id];
+			if (test_bit(__MDF_PEER_OUTDATED, &peer_md->flags))
+				peer_device->disk_state[NOW] = D_OUTDATED;
+			put_ldev(device);
 		}
 	}
 
-	if (_drbd_bm_total_weight(device) == drbd_bm_bits(device))
-		drbd_suspend_al(device); /* IO is still suspended here... */
+	/* Set bitmap_index if it was allocated previously */
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		unsigned int bitmap_index;
 
-	spin_lock_irq(&device->resource->req_lock);
-	os = drbd_read_state(device);
-	ns = os;
-	/* If MDF_CONSISTENT is not set go into inconsistent state,
-	   otherwise investigate MDF_WasUpToDate...
-	   If MDF_WAS_UP_TO_DATE is not set go into D_OUTDATED disk state,
-	   otherwise into D_CONSISTENT state.
-	*/
-	if (drbd_md_test_flag(device->ldev, MDF_CONSISTENT)) {
-		if (drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE))
-			ns.disk = D_CONSISTENT;
-		else
-			ns.disk = D_OUTDATED;
-	} else {
-		ns.disk = D_INCONSISTENT;
+		device = peer_device->device;
+		if (!get_ldev(device))
+			continue;
+
+		bitmap_index = device->ldev->md.peers[adm_ctx->peer_node_id].bitmap_index;
+		if (bitmap_index != -1) {
+			if (want_bitmap(peer_device))
+				peer_device->bitmap_index = bitmap_index;
+			else
+				clear_bit(__MDF_HAVE_BITMAP,
+					  &device->ldev->md.peers[adm_ctx->peer_node_id].flags);
+		}
+		put_ldev(device);
 	}
 
-	if (drbd_md_test_flag(device->ldev, MDF_PEER_OUT_DATED))
-		ns.pdsk = D_OUTDATED;
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		peer_device->send_cnt = 0;
+		peer_device->recv_cnt = 0;
+	}
 
-	rcu_read_lock();
-	if (ns.disk == D_CONSISTENT &&
-	    (ns.pdsk == D_OUTDATED || rcu_dereference(device->ldev->disk_conf)->fencing == FP_DONT_CARE))
-		ns.disk = D_UP_TO_DATE;
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		struct drbd_device *device = peer_device->device;
 
-	/* All tests on MDF_PRIMARY_IND, MDF_CONNECTED_IND,
-	   MDF_CONSISTENT and MDF_WAS_UP_TO_DATE must happen before
-	   this point, because drbd_request_state() modifies these
-	   flags. */
+		peer_device->resync_susp_other_c[NOW] =
+			is_resync_target_in_other_connection(peer_device);
+		list_add_rcu(&peer_device->peer_devices, &device->peer_devices);
+		kref_get(&connection->kref);
+		kref_get(&device->kref);
+		peer_devices++;
+		peer_device->node_id = connection->peer_node_id;
+	}
 
-	if (rcu_dereference(device->ldev->disk_conf)->al_updates)
-		device->ldev->md.flags &= ~MDF_AL_DISABLED;
-	else
-		device->ldev->md.flags |= MDF_AL_DISABLED;
+	write_lock_irq(&adm_ctx->resource->state_rwlock);
 
-	rcu_read_unlock();
+	/*
+	 * Initialize to the current dagtag so that flushes can be acked even
+	 * if no further writes occur.
+	 */
+	connection->last_peer_ack_dagtag_seen = READ_ONCE(adm_ctx->resource->dagtag_sector);
 
-	/* In case we are C_CONNECTED postpone any decision on the new disk
-	   state after the negotiation phase. */
-	if (device->state.conn == C_CONNECTED) {
-		device->new_state_tmp.i = ns.i;
-		ns.i = os.i;
-		ns.disk = D_NEGOTIATING;
+	list_add_tail_rcu(&connection->connections, &adm_ctx->resource->connections);
+	write_unlock_irq(&adm_ctx->resource->state_rwlock);
 
-		/* We expect to receive up-to-date UUIDs soon.
-		   To avoid a race in receive_state, free p_uuid while
-		   holding req_lock. I.e. atomic with the state change */
-		kfree(device->p_uuid);
-		device->p_uuid = NULL;
+	transport = &connection->transport;
+	old_net_conf = transport->net_conf;
+	if (old_net_conf) {
+		retcode = ERR_NET_CONFIGURED;
+		goto unlock_fail_free_connection;
 	}
 
-	rv = _drbd_set_state(device, ns, CS_VERBOSE, NULL);
-	spin_unlock_irq(&device->resource->req_lock);
+	err = transport->class->ops.net_conf_change(transport, new_net_conf);
+	if (err) {
+		drbd_adm_msg(adm_ctx, "transport net_conf_change failed: %d", err);
+		retcode = ERR_INVALID_REQUEST;
+		goto unlock_fail_free_connection;
+	}
 
-	if (rv < SS_SUCCESS)
-		goto force_diskless_dec;
+	rcu_assign_pointer(transport->net_conf, new_net_conf);
+	connection->fencing_policy = new_net_conf->fencing_policy;
 
-	mod_timer(&device->request_timer, jiffies + HZ);
+	connection->cram_hmac_tfm = crypto.cram_hmac_tfm;
+	connection->integrity_tfm = crypto.integrity_tfm;
+	connection->csums_tfm = crypto.csums_tfm;
+	connection->verify_tfm = crypto.verify_tfm;
 
-	if (device->state.role == R_PRIMARY)
-		device->ldev->md.uuid[UI_CURRENT] |=  (u64)1;
-	else
-		device->ldev->md.uuid[UI_CURRENT] &= ~(u64)1;
+	/* transferred ownership. prevent double cleanup. */
+	new_net_conf = NULL;
+	memset(&crypto, 0, sizeof(crypto));
 
-	drbd_md_mark_dirty(device);
-	drbd_md_sync(device);
+	if (connection->peer_node_id > adm_ctx->resource->max_node_id)
+		adm_ctx->resource->max_node_id = connection->peer_node_id;
 
-	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
-	put_ldev(device);
-	conn_reconfig_done(connection);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
+	connection_to_info(&connection_info, connection);
+	flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+	mutex_lock(&notification_mutex);
+	notify_connection_state(NULL, 0, connection, &connection_info, NOTIFY_CREATE | flags);
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		struct drbd_peer_device_info peer_device_info;
 
- force_diskless_dec:
-	put_ldev(device);
- force_diskless:
-	drbd_force_state(device, NS(disk, D_DISKLESS));
-	drbd_md_sync(device);
- fail:
-	conn_reconfig_done(connection);
-	if (nbc) {
-		close_backing_dev(device, nbc->f_md_bdev,
-			  nbc->md_bdev != nbc->backing_bdev);
-		close_backing_dev(device, nbc->backing_bdev_file, true);
-		kfree(nbc);
+		peer_device_to_info(&peer_device_info, peer_device);
+		flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
+		notify_peer_device_state(NULL, 0, peer_device, &peer_device_info, NOTIFY_CREATE | flags);
 	}
-	kfree(new_disk_conf);
-	lc_destroy(resync_lru);
-	kfree(new_plan);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
- finish:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
-}
+	mutex_unlock(&notification_mutex);
 
-static int adm_detach(struct drbd_device *device, int force)
-{
-	if (force) {
-		set_bit(FORCE_DETACH, &device->flags);
-		drbd_force_state(device, NS(disk, D_FAILED));
-		return SS_SUCCESS;
-	}
+	mutex_unlock(&adm_ctx->resource->conf_update);
+
+	drbd_debugfs_connection_add(connection); /* after ->net_conf was assigned */
+	drbd_thread_start(&connection->sender);
+	return NO_ERROR;
+
+unlock_fail_free_connection:
+	drbd_unregister_connection(connection);
+	mutex_unlock(&adm_ctx->resource->conf_update);
+	synchronize_rcu();
+	drbd_reclaim_connection(&connection->rcu);
+fail_put_transport:
+	drbd_put_transport_class(tr_class);
+fail:
+	free_crypto(&crypto);
+	kfree(new_net_conf);
 
-	return drbd_request_detach_interruptible(device);
+	return retcode;
 }
 
-/* Detaching the disk is a process in multiple stages.  First we need to lock
- * out application IO, in-flight IO, IO stuck in drbd_al_begin_io.
- * Then we transition to D_DISKLESS, and wait for put_ldev() to return all
- * internal references as well.
- * Only then we have finally detached. */
-int drbd_nl_detach_doit(struct sk_buff *skb, struct genl_info *info)
+static bool path_my_addr_eq(const struct drbd_path *path, const struct drbd_path_parms *pp)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
-	struct detach_parms parms = { };
-	int err;
+	return path->my_addr_len == pp->my_addr_len &&
+		memcmp(&path->my_addr, pp->my_addr, pp->my_addr_len) == 0;
+}
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+static bool path_peer_addr_eq(const struct drbd_path *path, const struct drbd_path_parms *pp)
+{
+	return path->peer_addr_len == pp->peer_addr_len &&
+		memcmp(&path->peer_addr, pp->peer_addr, pp->peer_addr_len) == 0;
+}
 
-	if (info->attrs[DRBD_NLA_DETACH_PARMS]) {
-		err = detach_parms_from_attrs(&parms, info);
-		if (err) {
-			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
-			goto out;
-		}
-	}
+static enum drbd_ret_code
+check_path_against_parms(const struct drbd_path *path, const struct drbd_path_parms *pp)
+{
+	enum drbd_ret_code ret = NO_ERROR;
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	retcode = adm_detach(adm_ctx->device, parms.force_detach);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
+	if (path_my_addr_eq(path, pp))
+		ret = ERR_LOCAL_ADDR;
+	if (path_peer_addr_eq(path, pp))
+		ret = (ret == ERR_LOCAL_ADDR ? ERR_LOCAL_AND_PEER_ADDR : ERR_PEER_ADDR);
+	return ret;
 }
 
-static bool conn_resync_running(struct drbd_connection *connection)
+static enum drbd_ret_code
+check_path_usable(struct drbd_adm_ctx *adm_ctx, const struct drbd_path_parms *pp)
 {
-	struct drbd_peer_device *peer_device;
-	bool rv = false;
-	int vnr;
+	struct drbd_resource *resource;
+	struct drbd_connection *connection;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		if (device->state.conn == C_SYNC_SOURCE ||
-		    device->state.conn == C_SYNC_TARGET ||
-		    device->state.conn == C_PAUSED_SYNC_S ||
-		    device->state.conn == C_PAUSED_SYNC_T) {
-			rv = true;
-			break;
-		}
+	if (!(pp->my_addr_len && pp->peer_addr_len)) {
+		drbd_adm_msg(adm_ctx, "%s", "connection endpoint(s) missing");
+		return ERR_INVALID_REQUEST;
 	}
-	rcu_read_unlock();
 
-	return rv;
+	for_each_resource_rcu(resource, &drbd_resources) {
+		for_each_connection_rcu(connection, resource) {
+			struct drbd_path *path;
+
+			list_for_each_entry_rcu(path, &connection->transport.paths, list) {
+				retcode = check_path_against_parms(path, pp);
+				if (retcode == NO_ERROR)
+					continue;
+				/* Within the same resource, it is ok to use
+				 * the same endpoint several times */
+				if (retcode != ERR_LOCAL_AND_PEER_ADDR &&
+				    resource == adm_ctx->resource)
+					continue;
+				return retcode;
+			}
+		}
+	}
+	return NO_ERROR;
 }
 
-static bool conn_ov_running(struct drbd_connection *connection)
+/* Check that adding the candidate path does not make incoming connections
+ * ambiguous between paths of distinct connections of the resource. Same-
+ * connection ambiguity is harmless because the assignment is irrelevant.
+ */
+static enum drbd_ret_code
+check_path_not_ambiguous(struct drbd_adm_ctx *adm_ctx,
+			 struct drbd_path *candidate)
 {
-	struct drbd_peer_device *peer_device;
-	bool rv = false;
-	int vnr;
+	struct drbd_resource *resource = adm_ctx->resource;
+	struct drbd_connection *connection;
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		if (device->state.conn == C_VERIFY_S ||
-		    device->state.conn == C_VERIFY_T) {
-			rv = true;
-			break;
+	for_each_connection_rcu(connection, resource) {
+		struct drbd_transport *transport = &connection->transport;
+		struct drbd_path *path;
+
+		if (connection == adm_ctx->connection)
+			continue;
+		if (transport->class != candidate->transport->class)
+			continue;
+
+		list_for_each_entry_rcu(path, &transport->paths, list) {
+			if (drbd_path_conflicts_by_listener(path, candidate)) {
+				drbd_adm_msg(adm_ctx, "%s",
+					"path indistinguishable from path in another connection");
+				return ERR_PATH_COLLISION;
+			}
 		}
 	}
-	rcu_read_unlock();
-
-	return rv;
+	return NO_ERROR;
 }
 
+
 static enum drbd_ret_code
-_check_net_options(struct drbd_connection *connection, struct net_conf *old_net_conf, struct net_conf *new_net_conf)
+adm_add_path(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_peer_device *peer_device;
-	int i;
-
-	if (old_net_conf && connection->cstate == C_WF_REPORT_PARAMS && connection->agreed_pro_version < 100) {
-		if (new_net_conf->wire_protocol != old_net_conf->wire_protocol)
-			return ERR_NEED_APV_100;
+	struct drbd_transport *transport = &adm_ctx->connection->transport;
+	struct drbd_resource *resource = adm_ctx->resource;
+	struct drbd_connection *connection = adm_ctx->connection;
+	struct drbd_path_parms pp = { };
+	struct drbd_path *path;
+	struct net *existing_net;
+	enum drbd_ret_code retcode = NO_ERROR;
+	int err;
 
-		if (new_net_conf->two_primaries != old_net_conf->two_primaries)
-			return ERR_NEED_APV_100;
+	/* parse and validate only */
+	existing_net = drbd_net_assigned_to_connection(adm_ctx->connection);
+	if (existing_net && !net_eq(adm_ctx->net, existing_net)) {
+		drbd_adm_msg(adm_ctx, "%s",
+			     "connection already assigned to a different network namespace");
+		return ERR_INVALID_REQUEST;
+	}
 
-		if (strcmp(new_net_conf->integrity_alg, old_net_conf->integrity_alg))
-			return ERR_NEED_APV_100;
+	err = drbd_adm_overlay_path_parms(adm_ctx, &pp);
+	if (err) {
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		return ERR_MANDATORY_TAG;
 	}
 
-	if (!new_net_conf->two_primaries &&
-	    conn_highest_role(connection) == R_PRIMARY &&
-	    conn_highest_peer(connection) == R_PRIMARY)
-		return ERR_NEED_ALLOW_TWO_PRI;
+	path = kzalloc(transport->class->path_instance_size, GFP_KERNEL);
+	if (!path)
+		return ERR_NOMEM;
 
-	if (new_net_conf->two_primaries &&
-	    (new_net_conf->wire_protocol != DRBD_PROT_C))
-		return ERR_NOT_PROTO_C;
+	path->net = adm_ctx->net;
+	path->my_addr_len = pp.my_addr_len;
+	memcpy(&path->my_addr, pp.my_addr, path->my_addr_len);
+	path->peer_addr_len = pp.peer_addr_len;
+	memcpy(&path->peer_addr, pp.peer_addr, path->peer_addr_len);
+	path->transport = transport;
+	kref_init(&path->kref);
+	kref_get(&adm_ctx->connection->kref);
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-		struct drbd_device *device = peer_device->device;
-		if (get_ldev(device)) {
-			enum drbd_fencing_p fp = rcu_dereference(device->ldev->disk_conf)->fencing;
-			put_ldev(device);
-			if (new_net_conf->wire_protocol == DRBD_PROT_A && fp == FP_STONITH)
-				return ERR_STONITH_AND_PROT_A;
+	rcu_read_lock();
+	retcode = check_path_usable(adm_ctx, &pp);
+	if (retcode == NO_ERROR)
+		retcode = check_path_not_ambiguous(adm_ctx, path);
+	rcu_read_unlock();
+	if (retcode != NO_ERROR) {
+		kref_put(&path->kref, drbd_destroy_path);
+		return retcode;
+	}
+
+	if (connection->resource->res_opts.drbd8_compat_mode && resource->res_opts.node_id == -1) {
+		err = drbd_setup_node_ids_84(connection, path, adm_ctx->peer_node_id);
+		if (err) {
+			drbd_adm_msg(adm_ctx, "%s",
+				err == -ENOTUNIQ ? "node-id from drbdsetup and meta-data differ" :
+				"error setting up node IDs");
+			kref_put(&path->kref, drbd_destroy_path);
+			return ERR_INVALID_REQUEST;
 		}
-		if (device->state.role == R_PRIMARY && new_net_conf->discard_my_data)
-			return ERR_DISCARD_IMPOSSIBLE;
 	}
 
-	if (new_net_conf->on_congestion != OC_BLOCK && new_net_conf->wire_protocol != DRBD_PROT_A)
-		return ERR_CONG_NOT_PROTO_A;
+	/* Exclusive with transport op "prepare_connect()" */
+	mutex_lock(&resource->conf_update);
+
+	err = transport->class->ops.add_path(path);
+
+	if (err) {
+		kref_put(&path->kref, drbd_destroy_path);
+		drbd_err(connection, "add_path() failed with %d\n", err);
+		drbd_adm_msg(adm_ctx, "%s", "add_path on transport failed");
+		mutex_unlock(&resource->conf_update);
+		return ERR_INVALID_REQUEST;
+	}
 
+	/* Exclusive with reading state, in particular remember_state_change() */
+	write_lock_irq(&resource->state_rwlock);
+	list_add_tail_rcu(&path->list, &transport->paths);
+	write_unlock_irq(&resource->state_rwlock);
+
+	mutex_unlock(&resource->conf_update);
+
+	notify_path(adm_ctx->connection, path, NOTIFY_CREATE);
 	return NO_ERROR;
 }
 
-static enum drbd_ret_code
-check_net_options(struct drbd_connection *connection, struct net_conf *new_net_conf)
+int drbd_adm_connect(struct drbd_adm_ctx *adm_ctx)
 {
-	enum drbd_ret_code rv;
+	struct drbd_connect_parms parms = { 0, };
 	struct drbd_peer_device *peer_device;
-	int i;
-
-	rcu_read_lock();
-	rv = _check_net_options(connection, rcu_dereference(connection->net_conf), new_net_conf);
-	rcu_read_unlock();
+	struct drbd_connection *connection;
+	enum drbd_ret_code retcode = NO_ERROR;
+	enum drbd_state_rv rv;
+	enum drbd_conn_state cstate;
+	int i, err;
 
-	/* connection->peer_devices protected by genl_lock() here */
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-		struct drbd_device *device = peer_device->device;
-		if (!device->bitmap) {
-			if (drbd_bm_init(device))
-				return ERR_NOMEM;
-		}
+	connection = adm_ctx->connection;
+	cstate = connection->cstate[NOW];
+	if (cstate != C_STANDALONE) {
+		retcode = ERR_NET_CONFIGURED;
+		goto out;
 	}
 
-	return rv;
-}
-
-struct crypto {
-	struct crypto_shash *verify_tfm;
-	struct crypto_shash *csums_tfm;
-	struct crypto_shash *cram_hmac_tfm;
-	struct crypto_shash *integrity_tfm;
-};
+	if (first_path(connection) == NULL) {
+		drbd_adm_msg(adm_ctx, "%s", "connection endpoint(s) missing");
+		retcode = ERR_INVALID_REQUEST;
+		goto out;
+	}
 
-static int
-alloc_shash(struct crypto_shash **tfm, char *tfm_name, int err_alg)
-{
-	if (!tfm_name[0])
-		return NO_ERROR;
+	if (!net_eq(adm_ctx->net, drbd_net_assigned_to_connection(connection))) {
+		drbd_adm_msg(adm_ctx, "%s", "connection assigned to a different network namespace");
+		retcode = ERR_INVALID_REQUEST;
+		goto out;
+	}
 
-	*tfm = crypto_alloc_shash(tfm_name, 0, 0);
-	if (IS_ERR(*tfm)) {
-		*tfm = NULL;
-		return err_alg;
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_CONNECT_PARMS)) {
+		err = drbd_adm_overlay_connect_parms(adm_ctx, &parms);
+		if (err) {
+			retcode = ERR_MANDATORY_TAG;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto out;
+		}
+	}
+	if (parms.discard_my_data) {
+		if (adm_ctx->resource->role[NOW] == R_PRIMARY) {
+			retcode = ERR_DISCARD_IMPOSSIBLE;
+			goto out;
+		}
+		set_bit(CONN_DISCARD_MY_DATA, &connection->flags);
 	}
+	if (parms.tentative)
+		set_bit(CONN_DRY_RUN, &connection->flags);
 
-	return NO_ERROR;
-}
+	/* Eventually allocate bitmap indexes for the peer_devices here */
+	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		struct drbd_device *device;
 
-static enum drbd_ret_code
-alloc_crypto(struct crypto *crypto, struct net_conf *new_net_conf)
-{
-	char hmac_name[CRYPTO_MAX_ALG_NAME];
-	enum drbd_ret_code rv;
+		if (peer_device->bitmap_index != -1 || !want_bitmap(peer_device))
+			continue;
 
-	rv = alloc_shash(&crypto->csums_tfm, new_net_conf->csums_alg,
-			 ERR_CSUMS_ALG);
-	if (rv != NO_ERROR)
-		return rv;
-	rv = alloc_shash(&crypto->verify_tfm, new_net_conf->verify_alg,
-			 ERR_VERIFY_ALG);
-	if (rv != NO_ERROR)
-		return rv;
-	rv = alloc_shash(&crypto->integrity_tfm, new_net_conf->integrity_alg,
-			 ERR_INTEGRITY_ALG);
-	if (rv != NO_ERROR)
-		return rv;
-	if (new_net_conf->cram_hmac_alg[0] != 0) {
-		snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
-			 new_net_conf->cram_hmac_alg);
+		device = peer_device->device;
+		if (!get_ldev(device))
+			continue;
 
-		rv = alloc_shash(&crypto->cram_hmac_tfm, hmac_name,
-				 ERR_AUTH_ALG);
+		err = allocate_bitmap_index(peer_device, device->ldev);
+		put_ldev(device);
+		if (err) {
+			retcode = ERR_INVALID_REQUEST;
+			goto out;
+		}
+		drbd_md_mark_dirty(device);
 	}
 
-	return rv;
-}
-
-static void free_crypto(struct crypto *crypto)
-{
-	crypto_free_shash(crypto->cram_hmac_tfm);
-	crypto_free_shash(crypto->integrity_tfm);
-	crypto_free_shash(crypto->csums_tfm);
-	crypto_free_shash(crypto->verify_tfm);
+	rv = change_cstate_tag(connection, C_UNCONNECTED, CS_VERBOSE, "connect", NULL);
+	adm_ctx->result = rv;
+	return 0;
+out:
+	adm_ctx->result = retcode;
+	return 0;
 }
 
-int drbd_nl_chg_net_opts_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_new_peer(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
 	struct drbd_connection *connection;
-	struct net_conf *old_net_conf, *new_net_conf = NULL;
-	struct nlattr **ntb;
-	int err;
-	int ovr; /* online verify running */
-	int rsr; /* re-sync running */
-	struct crypto crypto = { };
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
-
-	connection = adm_ctx->connection;
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	struct drbd_resource *resource;
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_device *device;
+	int vnr, n_connections = 0;
 
-	new_net_conf = kzalloc_obj(struct net_conf);
-	if (!new_net_conf) {
-		retcode = ERR_NOMEM;
+	resource = adm_ctx->resource;
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
 		goto out;
 	}
 
-	conn_reconfig_start(connection);
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		bool fail = false;
 
-	mutex_lock(&connection->data.mutex);
-	mutex_lock(&connection->resource->conf_update);
-	old_net_conf = connection->net_conf;
+		if (get_ldev_if_state(device, D_FAILED)) {
+			fail = !device->ldev->disk_conf->d_bitmap;
+			put_ldev(device);
+		}
+		if (fail) {
+			rcu_read_unlock();
+			retcode = ERR_INVALID_REQUEST;
+			drbd_adm_msg(adm_ctx,
+			      "Cannot add a peer while having a disk without an allocated bitmap");
+			goto out_unlock;
+		}
+	}
+	rcu_read_unlock();
 
-	if (!old_net_conf) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "net conf missing, try connect");
+	for_each_connection(connection, resource)
+		n_connections++;
+	if (resource->res_opts.drbd8_compat_mode && n_connections >= 1) {
 		retcode = ERR_INVALID_REQUEST;
-		goto fail;
+		drbd_adm_msg(adm_ctx, "drbd8 compat mode allows one peer at max");
+		goto out_unlock;
 	}
 
-	*new_net_conf = *old_net_conf;
-	if (should_set_defaults(info))
-		set_net_conf_defaults(new_net_conf);
-
-	err = net_conf_from_attrs(new_net_conf, info);
-	if (err && err != -ENOMSG) {
-		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
-		goto fail;
+	/* ensure uniqueness of peer_node_id by checking with adm_mutex */
+	connection = drbd_connection_by_node_id(resource, adm_ctx->peer_node_id);
+	if (adm_ctx->connection || connection) {
+		retcode = ERR_INVALID_REQUEST;
+		drbd_adm_msg(adm_ctx,
+			     "Connection for peer node id %d already exists",
+			     adm_ctx->peer_node_id);
+	} else {
+		retcode = adm_new_connection(adm_ctx);
 	}
 
-	err = net_conf_ntb_from_attrs(&ntb, info);
-	if (!err) {
-		if (has_invariant(ntb, DRBD_A_NET_CONF_DISCARD_MY_DATA) ||
-		    has_invariant(ntb, DRBD_A_NET_CONF_TENTATIVE)) {
-			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb,
-				"cannot change invariant setting");
-			kfree(ntb);
-			goto fail;
-		}
-		kfree(ntb);
-	}
+out_unlock:
+	mutex_unlock(&resource->adm_mutex);
+out:
+	adm_ctx->result = retcode;
+	return 0;
+}
 
-	retcode = check_net_options(connection, new_net_conf);
-	if (retcode != NO_ERROR)
-		goto fail;
+int drbd_adm_new_path(struct drbd_adm_ctx *adm_ctx)
+{
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	/* re-sync running */
-	rsr = conn_resync_running(connection);
-	if (rsr && strcmp(new_net_conf->csums_alg, old_net_conf->csums_alg)) {
-		retcode = ERR_CSUMS_RESYNC_RUNNING;
-		goto fail;
+	/* remote transport endpoints need to be globally unique */
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+	} else {
+		retcode = adm_add_path(adm_ctx);
+		mutex_unlock(&adm_ctx->resource->adm_mutex);
 	}
+	adm_ctx->result = retcode;
+	return 0;
+}
 
-	/* online verify running */
-	ovr = conn_ov_running(connection);
-	if (ovr && strcmp(new_net_conf->verify_alg, old_net_conf->verify_alg)) {
-		retcode = ERR_VERIFY_RUNNING;
-		goto fail;
+static enum drbd_ret_code
+adm_del_path(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_resource *resource = adm_ctx->resource;
+	struct drbd_connection *connection = adm_ctx->connection;
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_path_parms pp = { };
+	struct drbd_path *path;
+	int nr_paths = 0;
+	int err;
+
+	/* parse and validate only */
+	if (!net_eq(adm_ctx->net, drbd_net_assigned_to_connection(connection))) {
+		drbd_adm_msg(adm_ctx, "%s", "connection assigned to a different network namespace");
+		return ERR_INVALID_REQUEST;
 	}
 
-	retcode = alloc_crypto(&crypto, new_net_conf);
-	if (retcode != NO_ERROR)
-		goto fail;
+	err = drbd_adm_overlay_path_parms(adm_ctx, &pp);
+	if (err) {
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		return ERR_MANDATORY_TAG;
+	}
 
-	rcu_assign_pointer(connection->net_conf, new_net_conf);
+	list_for_each_entry(path, &transport->paths, list)
+		nr_paths++;
 
-	if (!rsr) {
-		crypto_free_shash(connection->csums_tfm);
-		connection->csums_tfm = crypto.csums_tfm;
-		crypto.csums_tfm = NULL;
-	}
-	if (!ovr) {
-		crypto_free_shash(connection->verify_tfm);
-		connection->verify_tfm = crypto.verify_tfm;
-		crypto.verify_tfm = NULL;
+	if (nr_paths == 1 && connection->cstate[NOW] >= C_CONNECTING) {
+		drbd_adm_msg(adm_ctx, "%s", "Can not delete last path, use disconnect first!");
+		return ERR_INVALID_REQUEST;
 	}
 
-	crypto_free_shash(connection->integrity_tfm);
-	connection->integrity_tfm = crypto.integrity_tfm;
-	if (connection->cstate >= C_WF_REPORT_PARAMS && connection->agreed_pro_version >= 100)
-		/* Do this without trying to take connection->data.mutex again.  */
-		__drbd_send_protocol(connection, P_PROTOCOL_UPDATE);
+	err = -ENOENT;
+	list_for_each_entry(path, &transport->paths, list) {
+		if (!path_my_addr_eq(path, &pp))
+			continue;
+		if (!path_peer_addr_eq(path, &pp))
+			continue;
 
-	crypto_free_shash(connection->cram_hmac_tfm);
-	connection->cram_hmac_tfm = crypto.cram_hmac_tfm;
+		/* Exclusive with transport op "prepare_connect()" */
+		mutex_lock(&resource->conf_update);
 
-	mutex_unlock(&connection->resource->conf_update);
-	mutex_unlock(&connection->data.mutex);
-	kvfree_rcu_mightsleep(old_net_conf);
+		if (!transport->class->ops.may_remove_path(path)) {
+			err = -EBUSY;
+			mutex_unlock(&resource->conf_update);
+			break;
+		}
 
-	if (connection->cstate >= C_WF_REPORT_PARAMS) {
-		struct drbd_peer_device *peer_device;
-		int vnr;
+		transport->class->ops.remove_path(path);
 
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
-			drbd_send_sync_param(peer_device);
-	}
+		set_bit(TR_UNREGISTERED, &path->flags);
+		/* Ensure flag visible before list manipulation. */
+		smp_wmb();
 
-	goto done;
+		/* Exclusive with reading state, in particular remember_state_change() */
+		write_lock_irq(&resource->state_rwlock);
+		list_del_rcu(&path->list);
+		write_unlock_irq(&resource->state_rwlock);
 
- fail:
-	mutex_unlock(&connection->resource->conf_update);
-	mutex_unlock(&connection->data.mutex);
-	free_crypto(&crypto);
-	kfree(new_net_conf);
- done:
-	conn_reconfig_done(connection);
- out:
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
- finish:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
-}
+		mutex_unlock(&resource->conf_update);
 
-static void connection_to_info(struct connection_info *info,
-			       struct drbd_connection *connection)
-{
-	info->conn_connection_state = connection->cstate;
-	info->conn_role = conn_highest_peer(connection);
-}
+		notify_path(connection, path, NOTIFY_DESTROY);
+		/* Transport modules might use RCU on the path list. */
+		call_rcu(&path->rcu, drbd_reclaim_path);
 
-static void peer_device_to_info(struct peer_device_info *info,
-				struct drbd_peer_device *peer_device)
-{
-	struct drbd_device *device = peer_device->device;
+		return NO_ERROR;
+	}
 
-	info->peer_repl_state =
-		max_t(enum drbd_conns, C_WF_REPORT_PARAMS, device->state.conn);
-	info->peer_disk_state = device->state.pdsk;
-	info->peer_resync_susp_user = device->state.user_isp;
-	info->peer_resync_susp_peer = device->state.peer_isp;
-	info->peer_resync_susp_dependency = device->state.aftr_isp;
+	drbd_err(connection, "del_path() failed with %d\n", err);
+	drbd_adm_msg(adm_ctx, "%s",
+		     err == -ENOENT ? "no such path" : "del_path on transport failed");
+	return ERR_INVALID_REQUEST;
 }
 
-int drbd_nl_connect_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_del_path(struct drbd_adm_ctx *adm_ctx)
 {
-	struct connection_info connection_info;
-	enum drbd_notification_type flags;
-	unsigned int peer_devices = 0;
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct drbd_peer_device *peer_device;
-	struct net_conf *old_net_conf, *new_net_conf = NULL;
-	struct crypto crypto = { };
-	struct drbd_resource *resource;
-	struct drbd_connection *connection;
-	enum drbd_ret_code retcode;
-	enum drbd_state_rv rv;
-	int i;
-	int err;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
-	if (!(adm_ctx->my_addr && adm_ctx->peer_addr)) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "connection endpoint(s) missing");
-		retcode = ERR_INVALID_REQUEST;
-		goto out;
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+	} else {
+		retcode = adm_del_path(adm_ctx);
+		mutex_unlock(&adm_ctx->resource->adm_mutex);
 	}
+	adm_ctx->result = retcode;
+	return 0;
+}
 
-	/* No need for _rcu here. All reconfiguration is
-	 * strictly serialized on genl_lock(). We are protected against
-	 * concurrent reconfiguration/addition/deletion */
-	for_each_resource(resource, &drbd_resources) {
-		for_each_connection(connection, resource) {
-			if (nla_len(adm_ctx->my_addr) == connection->my_addr_len &&
-			    !memcmp(nla_data(adm_ctx->my_addr), &connection->my_addr,
-				    connection->my_addr_len)) {
-				retcode = ERR_LOCAL_ADDR;
-				goto out;
-			}
+int drbd_open_ro_count(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	int vnr, open_ro_cnt = 0;
 
-			if (nla_len(adm_ctx->peer_addr) == connection->peer_addr_len &&
-			    !memcmp(nla_data(adm_ctx->peer_addr), &connection->peer_addr,
-				    connection->peer_addr_len)) {
-				retcode = ERR_PEER_ADDR;
-				goto out;
-			}
-		}
+	read_lock_irq(&resource->state_rwlock);
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (!device->writable)
+			open_ro_cnt += device->open_cnt;
 	}
+	read_unlock_irq(&resource->state_rwlock);
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	connection = first_connection(adm_ctx->resource);
-	conn_reconfig_start(connection);
-
-	if (connection->cstate > C_STANDALONE) {
-		retcode = ERR_NET_CONFIGURED;
-		goto fail;
-	}
+	return open_ro_cnt;
+}
 
-	/* allocation not in the IO path, drbdsetup / netlink process context */
-	new_net_conf = kzalloc_obj(*new_net_conf);
-	if (!new_net_conf) {
-		retcode = ERR_NOMEM;
-		goto fail;
-	}
+/* How often to repeat a disconnect that did not conclude. */
+#define DISCONNECT_RETRIES 5
 
-	set_net_conf_defaults(new_net_conf);
+static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection, bool force,
+					      const char *tag, struct drbd_adm_ctx *ctx)
+{
+	struct drbd_resource *resource = connection->resource;
+	enum drbd_conn_state cstate;
+	enum drbd_state_rv rv;
+	enum chg_state_flags flags = (force ? CS_HARD : 0) | CS_VERBOSE;
+	const char *err_str = NULL;
+	int retries = 0;
+	long t;
 
-	err = net_conf_from_attrs(new_net_conf, info);
-	if (err && err != -ENOMSG) {
-		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
-		goto fail;
+repeat:
+	rv = change_cstate_tag(connection, C_DISCONNECTING, flags, tag, &err_str);
+	switch (rv) {
+	case SS_CW_FAILED_BY_PEER:
+	case SS_NEED_CONNECTION:
+		read_lock_irq(&resource->state_rwlock);
+		cstate = connection->cstate[NOW];
+		read_unlock_irq(&resource->state_rwlock);
+		/* A peer that refused while the connection is up refuses again;
+		 * that is an answer, not something to repeat.
+		 */
+		if (rv == SS_CW_FAILED_BY_PEER && cstate >= C_CONNECTED)
+			break;
+		/* Below C_CONNECTED the repeat needs no cluster-wide agreement;
+		 * connected again, it can be disconnected properly now.
+		 * Still: bound the number of retries.
+		 */
+		if (++retries > DISCONNECT_RETRIES)
+			break;
+		goto repeat;
+	case SS_NO_UP_TO_DATE_DISK:
+		if (resource->role[NOW] == R_PRIMARY)
+			break;
+		/* Most probably udev opened it read-only. That might happen
+		   if it was demoted very recently. Wait up to one second. */
+		t = wait_event_interruptible_timeout(resource->state_wait,
+						     drbd_open_ro_count(resource) == 0,
+						     HZ);
+		if (t <= 0)
+			break;
+		goto repeat;
+	case SS_ALREADY_STANDALONE:
+		rv = SS_SUCCESS;
+		break;
+	case SS_IS_DISKLESS:
+	case SS_LOWER_THAN_OUTDATED:
+		rv = change_cstate_tag(connection, C_DISCONNECTING, CS_HARD, tag, NULL);
+		break;
+	case SS_NO_QUORUM:
+		if (!(flags & CS_VERBOSE)) {
+			flags |= CS_VERBOSE;
+			goto repeat;
+		}
+		break;
+	default:
+		break;
+		/* no special handling necessary */
 	}
 
-	retcode = check_net_options(connection, new_net_conf);
-	if (retcode != NO_ERROR)
-		goto fail;
+	if (rv >= SS_SUCCESS)
+		wait_event_interruptible_timeout(resource->state_wait,
+						 connection->cstate[NOW] == C_STANDALONE,
+						 HZ);
+	if (err_str) {
+		drbd_adm_msg(ctx, "%s", err_str);
+		kfree(err_str);
+	}
 
-	retcode = alloc_crypto(&crypto, new_net_conf);
-	if (retcode != NO_ERROR)
-		goto fail;
+	return rv;
+}
 
-	((char *)new_net_conf->shared_secret)[SHARED_SECRET_MAX-1] = 0;
+/* this can only be called immediately after a successful
+ * peer_try_disconnect, within the same resource->adm_mutex */
+static void del_connection(struct drbd_connection *connection, const char *tag)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_peer_device *peer_device;
+	enum drbd_state_rv rv2;
+	int vnr;
 
-	drbd_flush_workqueue(&connection->sender_work);
+	if (test_bit(C_UNREGISTERED, &connection->flags))
+		return;
 
-	mutex_lock(&adm_ctx->resource->conf_update);
-	old_net_conf = connection->net_conf;
-	if (old_net_conf) {
-		retcode = ERR_NET_CONFIGURED;
-		mutex_unlock(&adm_ctx->resource->conf_update);
-		goto fail;
-	}
-	rcu_assign_pointer(connection->net_conf, new_net_conf);
+	/* No one else can reconfigure the network while I am here.
+	 * The state handling only uses drbd_thread_stop_nowait(),
+	 * we want to really wait here until the receiver is no more.
+	 */
+	drbd_thread_stop(&connection->receiver);
 
-	conn_free_crypto(connection);
-	connection->cram_hmac_tfm = crypto.cram_hmac_tfm;
-	connection->integrity_tfm = crypto.integrity_tfm;
-	connection->csums_tfm = crypto.csums_tfm;
-	connection->verify_tfm = crypto.verify_tfm;
+	/* Race breaker.  This additional state change request may be
+	 * necessary, if this was a forced disconnect during a receiver
+	 * restart.  We may have "killed" the receiver thread just
+	 * after drbd_receiver() returned.  Typically, we should be
+	 * C_STANDALONE already, now, and this becomes a no-op.
+	 */
+	rv2 = change_cstate_tag(connection, C_STANDALONE, CS_VERBOSE | CS_HARD, tag, NULL);
+	if (rv2 < SS_SUCCESS)
+		drbd_err(connection,
+			"unexpected rv2=%d in del_connection()\n",
+			rv2);
+	/* Make sure the sender thread has actually stopped: state
+	 * handling only does drbd_thread_stop_nowait().
+	 */
+	drbd_thread_stop(&connection->sender);
 
-	connection->my_addr_len = nla_len(adm_ctx->my_addr);
-	memcpy(&connection->my_addr, nla_data(adm_ctx->my_addr), connection->my_addr_len);
-	connection->peer_addr_len = nla_len(adm_ctx->peer_addr);
-	memcpy(&connection->peer_addr, nla_data(adm_ctx->peer_addr), connection->peer_addr_len);
+	mutex_lock(&resource->conf_update);
+	drbd_unregister_connection(connection);
+	mutex_unlock(&resource->conf_update);
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-		peer_devices++;
-	}
+	/*
+	 * Flush the resource work queue to make sure that no more
+	 * events like state change notifications for this connection
+	 * are queued: we want the "destroy" event to come last.
+	 */
+	drbd_flush_workqueue(&resource->work);
 
-	connection_to_info(&connection_info, connection);
-	flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
 	mutex_lock(&notification_mutex);
-	notify_connection_state(NULL, 0, connection, &connection_info, NOTIFY_CREATE | flags);
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-		struct peer_device_info peer_device_info;
-
-		peer_device_to_info(&peer_device_info, peer_device);
-		flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
-		notify_peer_device_state(NULL, 0, peer_device, &peer_device_info, NOTIFY_CREATE | flags);
-	}
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		notify_peer_device_state(NULL, 0, peer_device, NULL,
+					 NOTIFY_DESTROY | NOTIFY_CONTINUES);
+	notify_connection_state(NULL, 0, connection, NULL, NOTIFY_DESTROY);
 	mutex_unlock(&notification_mutex);
-	mutex_unlock(&adm_ctx->resource->conf_update);
+	call_rcu(&connection->rcu, drbd_reclaim_connection);
+}
 
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-		struct drbd_device *device = peer_device->device;
-		device->send_cnt = 0;
-		device->recv_cnt = 0;
+static int adm_disconnect(struct drbd_adm_ctx *adm_ctx, bool destroy)
+{
+	struct drbd_disconnect_parms parms;
+	struct drbd_connection *connection;
+	struct net *existing_net;
+	enum drbd_state_rv rv;
+	enum drbd_ret_code retcode = NO_ERROR;
+	const char *tag = destroy ? "del-peer" : "disconnect";
+
+	memset(&parms, 0, sizeof(parms));
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_DISCONNECT_PARMS)) {
+		int err = drbd_adm_overlay_disconnect_parms(adm_ctx, &parms);
+
+		if (err) {
+			retcode = ERR_MANDATORY_TAG;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto fail;
+		}
 	}
-	rcu_read_unlock();
-
-	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
-
-	conn_reconfig_done(connection);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-	adm_ctx->reply_dh->ret_code = rv;
-	return 0;
 
-fail:
-	free_crypto(&crypto);
-	kfree(new_net_conf);
+	existing_net = drbd_net_assigned_to_connection(adm_ctx->connection);
+	if (existing_net && !net_eq(adm_ctx->net, existing_net)) {
+		drbd_adm_msg(adm_ctx, "%s", "connection assigned to a different network namespace");
+		retcode = ERR_INVALID_REQUEST;
+		goto fail;
+	}
 
-	conn_reconfig_done(connection);
+	connection = adm_ctx->connection;
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto fail;
+	}
+	rv = conn_try_disconnect(connection, parms.force_disconnect, tag, adm_ctx);
+	if (rv >= SS_SUCCESS && destroy)
+		del_connection(connection, tag);
+	if (rv < SS_SUCCESS)
+		retcode = (enum drbd_ret_code)rv;
+	else
+		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
+ fail:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection, bool force)
+int drbd_adm_disconnect(struct drbd_adm_ctx *adm_ctx)
 {
-	enum drbd_conns cstate;
-	enum drbd_state_rv rv;
+	return adm_disconnect(adm_ctx, 0);
+}
 
-repeat:
-	rv = conn_request_state(connection, NS(conn, C_DISCONNECTING),
-			force ? CS_HARD : 0);
+int drbd_adm_del_peer(struct drbd_adm_ctx *adm_ctx)
+{
+	return adm_disconnect(adm_ctx, 1);
+}
 
-	switch (rv) {
-	case SS_NOTHING_TO_DO:
-		break;
-	case SS_ALREADY_STANDALONE:
-		return SS_SUCCESS;
-	case SS_PRIMARY_NOP:
-		/* Our state checking code wants to see the peer outdated. */
-		rv = conn_request_state(connection, NS2(conn, C_DISCONNECTING, pdsk, D_OUTDATED), 0);
+void resync_after_online_grow(struct drbd_peer_device *peer_device)
+{
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	bool sync_source = false;
+	s32 peer_id;
+
+	drbd_info(peer_device, "Resync of new storage after online grow\n");
+	if (device->resource->role[NOW] != connection->peer_role[NOW])
+		sync_source = (device->resource->role[NOW] == R_PRIMARY);
+	else if (connection->agreed_pro_version < 111)
+		sync_source = test_bit(RESOLVE_CONFLICTS,
+				&peer_device->connection->transport.flags);
+	else if (get_ldev(device)) {
+		/* multiple or no primaries, proto new enough, resolve by node-id */
+		s32 self_id = device->ldev->md.node_id;
 
-		if (rv == SS_OUTDATE_WO_CONN) /* lost connection before graceful disconnect succeeded */
-			rv = conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_VERBOSE);
+		put_ldev(device);
+		peer_id = peer_device->node_id;
 
-		break;
-	case SS_CW_FAILED_BY_PEER:
-		spin_lock_irq(&connection->resource->req_lock);
-		cstate = connection->cstate;
-		spin_unlock_irq(&connection->resource->req_lock);
-		if (cstate <= C_WF_CONNECTION)
-			goto repeat;
-		/* The peer probably wants to see us outdated. */
-		rv = conn_request_state(connection, NS2(conn, C_DISCONNECTING,
-							disk, D_OUTDATED), 0);
-		if (rv == SS_IS_DISKLESS || rv == SS_LOWER_THAN_OUTDATED) {
-			rv = conn_request_state(connection, NS(conn, C_DISCONNECTING),
-					CS_HARD);
-		}
-		break;
-	default:;
-		/* no special handling necessary */
+		sync_source = self_id < peer_id ? 1 : 0;
 	}
 
-	if (rv >= SS_SUCCESS) {
-		enum drbd_state_rv rv2;
-		/* No one else can reconfigure the network while I am here.
-		 * The state handling only uses drbd_thread_stop_nowait(),
-		 * we want to really wait here until the receiver is no more.
-		 */
-		drbd_thread_stop(&connection->receiver);
-
-		/* Race breaker.  This additional state change request may be
-		 * necessary, if this was a forced disconnect during a receiver
-		 * restart.  We may have "killed" the receiver thread just
-		 * after drbd_receiver() returned.  Typically, we should be
-		 * C_STANDALONE already, now, and this becomes a no-op.
-		 */
-		rv2 = conn_request_state(connection, NS(conn, C_STANDALONE),
-				CS_VERBOSE | CS_HARD);
-		if (rv2 < SS_SUCCESS)
-			drbd_err(connection,
-				"unexpected rv2=%d in conn_try_disconnect()\n",
-				rv2);
-		/* Unlike in DRBD 9, the state engine has generated
-		 * NOTIFY_DESTROY events before clearing connection->net_conf. */
+	if (!sync_source && connection->agreed_pro_version < 110) {
+		stable_change_repl_state(peer_device, L_WF_SYNC_UUID,
+					 CS_VERBOSE | CS_SERIALIZE, "online-grow");
+		return;
 	}
-	return rv;
+	drbd_start_resync(peer_device, sync_source ? L_SYNC_SOURCE : L_SYNC_TARGET, "online-grow");
 }
 
-int drbd_nl_disconnect_doit(struct sk_buff *skb, struct genl_info *info)
+sector_t drbd_local_max_size(struct drbd_device *device)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct disconnect_parms parms;
-	struct drbd_connection *connection;
-	enum drbd_state_rv rv;
-	enum drbd_ret_code retcode;
-	int err;
+	struct drbd_backing_dev *tmp_bdev;
+	sector_t s;
 
-	if (!adm_ctx->reply_skb)
+	tmp_bdev = kmalloc_obj(struct drbd_backing_dev, GFP_ATOMIC);
+	if (!tmp_bdev)
 		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto fail;
 
-	connection = adm_ctx->connection;
-	memset(&parms, 0, sizeof(parms));
-	if (info->attrs[DRBD_NLA_DISCONNECT_PARMS]) {
-		err = disconnect_parms_from_attrs(&parms, info);
-		if (err) {
-			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
-			goto fail;
+	*tmp_bdev = *device->ldev;
+	drbd_md_set_sector_offsets(tmp_bdev);
+	s = drbd_get_max_capacity(device, tmp_bdev, false);
+	kfree(tmp_bdev);
+
+	return s;
+}
+
+/* Only from a cluster whose diskful members are all connected and quiet, and
+ * only on the lowest node id among them.
+ *
+ * Connected, because with dds_flags = 0 the transaction holds the size at the
+ * last agreed one while a diskful peer is absent anyway.  A peer configured
+ * with "bitmap no" is a client by intent: it agrees to no size and applies
+ * whatever is agreed, so it is not waited for.  A client the grow would leave
+ * without an UpToDate peer still stops it: it answers the prepare through the
+ * one node it is connected to, and the view it reports is short.  Quiet,
+ * because growing rewrites the bitmap a running resync reads, which is why
+ * drbd_adm_resize() refuses as well; that also keeps two grows from
+ * overlapping.  Growing needs no hurry: the next connection, or the end of the
+ * resync, arms this again.
+ *
+ * Lowest node id, so exactly one node starts the transaction: every node that
+ * noticed arms itself, and the others would find the size unchanged and abort.
+ */
+static bool may_start_auto_grow(struct drbd_device *device)
+{
+	struct drbd_resource *resource = device->resource;
+	struct drbd_peer_device *peer_device;
+	bool may = true;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		/* a client by intent, see above */
+		if (!want_bitmap(peer_device))
+			continue;
+
+		if (peer_device->connection->cstate[NOW] != C_CONNECTED ||
+		    peer_device->repl_state[NOW] != L_ESTABLISHED ||
+		    peer_device->node_id < resource->res_opts.node_id) {
+			may = false;
+			break;
 		}
 	}
+	rcu_read_unlock();
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	rv = conn_try_disconnect(connection, parms.force_disconnect);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-	if (rv < SS_SUCCESS) {
-		adm_ctx->reply_dh->ret_code = rv;
-		return 0;
-	}
-	retcode = NO_ERROR;
- fail:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
+	return may;
 }
 
-void resync_after_online_grow(struct drbd_device *device)
+/* What a node advertises in P_SIZES is the minimum over the sizes it has
+ * cached for its peers, and what it receives feeds that minimum again, so the
+ * exchange can only ratchet down.  With three or more nodes the peers that
+ * stayed connected keep each other at the size the cluster last agreed on, and
+ * a backing device that grew under DRBD never reaches the cluster.  A size
+ * transaction is immune to it: every participant answers the prepare with its
+ * own drbd_local_max_size(), so no cache takes part in the decision.
+ *
+ * Runs in the worker, armed from after_state_change();
+ * change_cluster_wide_device_size() sleeps.
+ */
+void drbd_auto_grow(struct drbd_device *device)
 {
-	int iass; /* I am sync source */
+	sector_t local_max_size, u_size;
+	enum determine_dev_size dd;
 
-	drbd_info(device, "Resync of new storage after online grow\n");
-	if (device->state.role != device->state.peer)
-		iass = (device->state.role == R_PRIMARY);
-	else
-		iass = test_bit(RESOLVE_CONFLICTS, &first_peer_device(device)->connection->flags);
+	if (!get_ldev(device))
+		return;
 
-	if (iass)
-		drbd_start_resync(device, C_SYNC_SOURCE);
-	else
-		_drbd_request_state(device, NS(conn, C_WF_SYNC_UUID), CS_VERBOSE + CS_SERIALIZE);
+	if (!may_start_auto_grow(device))
+		goto out;
+
+	rcu_read_lock();
+	u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
+	rcu_read_unlock();
+
+	local_max_size = drbd_local_max_size(device);
+	if (u_size)
+		local_max_size = min(local_max_size, u_size);
+	if (local_max_size <= get_capacity(device->vdisk))
+		goto out;
+	if (local_max_size == device->auto_grow_asked)
+		goto out;
+
+	/* dds_flags = 0: a peer this node can not see keeps whatever it
+	 * allowed when the cluster last agreed on a size, so this can never
+	 * settle above what an administrative resize would.  Growing past an
+	 * absent peer stays the explicit --assume-peer-has-space promise,
+	 * which comes with the duty to grow that peer's backend.
+	 *
+	 * automatic: commit only what every participant applies, and leave
+	 * the log to what the transaction changes.
+	 */
+	device->auto_grow_asked = local_max_size;
+	dd = change_cluster_wide_device_size(device, local_max_size, u_size, 0, true, NULL);
+	if (dd == DS_2PC_ERR)
+		/* A timeout or a competing state change is no answer at all,
+		 * so forget what was asked and let the next arming edge ask
+		 * again.  Every other outcome answers what this cluster can
+		 * do, and stands until a peer connects.
+		 */
+		device->auto_grow_asked = 0;
+	if (dd == DS_2PC_NOT_SUPPORTED)
+		dynamic_drbd_dbg(device, "Not growing: a peer is too old for cluster-wide size changes\n");
+	drbd_md_sync_if_dirty(device);
+out:
+	put_ldev(device);
 }
 
-int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_resize(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct disk_conf *old_disk_conf, *new_disk_conf = NULL;
-	struct resize_parms rs;
+	struct drbd_disk_conf *old_disk_conf, *new_disk_conf = NULL;
+	struct drbd_resize_parms rs;
 	struct drbd_device *device;
-	enum drbd_ret_code retcode;
 	enum determine_dev_size dd;
 	bool change_al_layout = false;
 	enum dds_flags ddsf;
 	sector_t u_size;
-	int err;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
+	int err, retcode = NO_ERROR;
+	struct drbd_peer_device *peer_device;
+	bool resolve_by_node_id = true;
+	bool has_up_to_date_primary;
+	bool traditional_resize = false;
+	sector_t local_max_size, wanted_size;
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
 	device = adm_ctx->device;
 	if (!get_ldev(device)) {
 		retcode = ERR_NO_DISK;
 		goto fail;
 	}
 
-	memset(&rs, 0, sizeof(struct resize_parms));
+	memset(&rs, 0, sizeof(struct drbd_resize_parms));
 	rs.al_stripes = device->ldev->md.al_stripes;
 	rs.al_stripe_size = device->ldev->md.al_stripe_size_4k * 4;
-	if (info->attrs[DRBD_NLA_RESIZE_PARMS]) {
-		err = resize_parms_from_attrs(&rs, info);
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_RESIZE_PARMS)) {
+		err = drbd_adm_overlay_resize_parms(adm_ctx, &rs);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto fail_ldev;
+		}
+	}
+
+	device = adm_ctx->device;
+	for_each_peer_device(peer_device, device) {
+		if (peer_device->repl_state[NOW] > L_ESTABLISHED) {
+			retcode = ERR_RESIZE_RESYNC;
 			goto fail_ldev;
 		}
 	}
 
-	if (device->state.conn > C_CONNECTED) {
-		retcode = ERR_RESIZE_RESYNC;
+
+	/* Without --size, check the size the device already presents: a backing
+	 * device that shrank below it can not hold the data plus the meta data.
+	 */
+	local_max_size = drbd_local_max_size(device);
+	wanted_size = rs.resize_size ? (sector_t)rs.resize_size :
+				       get_capacity(device->vdisk);
+	if (local_max_size < wanted_size) {
+		drbd_err(device, "%s %llu sectors, backend seems only able to support %llu\n",
+			 rs.resize_size ? "requested" : "device presents",
+			 (unsigned long long)wanted_size,
+			 (unsigned long long)local_max_size);
+		retcode = ERR_DISK_TOO_SMALL;
 		goto fail_ldev;
 	}
 
-	if (device->state.role == R_SECONDARY &&
-	    device->state.peer == R_SECONDARY) {
+	/* Maybe I could serve as sync source myself? */
+	has_up_to_date_primary =
+		device->resource->role[NOW] == R_PRIMARY &&
+		device->disk_state[NOW] == D_UP_TO_DATE;
+
+	if (!has_up_to_date_primary) {
+		for_each_peer_device(peer_device, device) {
+			/* ignore unless connection is fully established */
+			if (peer_device->repl_state[NOW] < L_ESTABLISHED)
+				continue;
+			if (peer_device->connection->agreed_pro_version < 111) {
+				resolve_by_node_id = false;
+				if (peer_device->connection->peer_role[NOW] == R_PRIMARY
+				&&  peer_device->disk_state[NOW] == D_UP_TO_DATE) {
+					has_up_to_date_primary = true;
+					break;
+				}
+			}
+		}
+	}
+
+	if (!has_up_to_date_primary && !resolve_by_node_id) {
 		retcode = ERR_NO_PRIMARY;
 		goto fail_ldev;
 	}
 
-	if (rs.no_resync && first_peer_device(device)->connection->agreed_pro_version < 93) {
-		retcode = ERR_NEED_APV_93;
-		goto fail_ldev;
+	for_each_peer_device(peer_device, device) {
+		struct drbd_connection *connection = peer_device->connection;
+
+		if (rs.no_resync &&
+		    connection->cstate[NOW] == C_CONNECTED &&
+		    connection->agreed_pro_version < 93) {
+			retcode = ERR_NEED_APV_93;
+			goto fail_ldev;
+		}
 	}
 
 	rcu_read_lock();
 	u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
 	rcu_read_unlock();
 	if (u_size != (sector_t)rs.resize_size) {
-		new_disk_conf = kmalloc_obj(struct disk_conf);
+		new_disk_conf = kmalloc_obj(struct drbd_disk_conf);
 		if (!new_disk_conf) {
 			retcode = ERR_NOMEM;
 			goto fail_ldev;
@@ -2923,21 +5750,21 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 			goto fail_ldev;
 		}
 
-		if (al_size_k < MD_32kB_SECT/2) {
+		if (al_size_k < (32768 >> 10)) {
 			retcode = ERR_MD_LAYOUT_TOO_SMALL;
 			goto fail_ldev;
 		}
 
+		/* Removed this pre-condition while merging from 8.4 to 9.0
 		if (device->state.conn != C_CONNECTED && !rs.resize_force) {
 			retcode = ERR_MD_LAYOUT_CONNECTED;
 			goto fail_ldev;
-		}
+		} */
 
 		change_al_layout = true;
 	}
 
-	if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev))
-		device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
+	device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
 
 	if (new_disk_conf) {
 		mutex_lock(&device->resource->conf_update);
@@ -2950,9 +5777,27 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf = NULL;
 	}
 
-	ddsf = (rs.resize_force ? DDSF_FORCED : 0) | (rs.no_resync ? DDSF_NO_RESYNC : 0);
-	dd = drbd_determine_dev_size(device, ddsf, change_al_layout ? &rs : NULL);
-	drbd_md_sync(device);
+	ddsf = (rs.resize_force ? DDSF_ASSUME_UNCONNECTED_PEER_HAS_SPACE : 0)
+		| (rs.no_resync ? DDSF_NO_RESYNC : 0);
+
+	dd = change_cluster_wide_device_size(device, local_max_size, rs.resize_size, ddsf,
+					     false, change_al_layout ? &rs : NULL);
+	if (dd == DS_2PC_NOT_SUPPORTED) {
+		traditional_resize = true;
+		dd = drbd_determine_dev_size(device, 0, ddsf, change_al_layout ? &rs : NULL);
+	} else if (dd == DS_UNCHANGED &&
+		   drbd_md_ss(device->ldev) != device->ldev->md.md_offset) {
+		/* The device keeps its size, but this node's backing device is
+		 * not the size it was, which moves internal meta data.  Only
+		 * drbd_determine_dev_size() recomputes the layout, and the size
+		 * change calls it only when it commits: apply the unchanged size
+		 * here so the meta data is written where it now belongs.
+		 */
+		dd = drbd_determine_dev_size(device, get_capacity(device->vdisk),
+					     ddsf | DDSF_2PC, NULL);
+	}
+
+	drbd_md_sync_if_dirty(device);
 	put_ldev(device);
 	if (dd == DS_ERROR) {
 		retcode = ERR_NOMEM_BITMAP;
@@ -2963,20 +5808,26 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 	} else if (dd == DS_ERROR_SHRINK) {
 		retcode = ERR_IMPLICIT_SHRINK;
 		goto fail;
+	} else if (dd == DS_2PC_ERR) {
+		retcode = SS_INTERRUPTED;
+		goto fail;
 	}
 
-	if (device->state.conn == C_CONNECTED) {
-		if (dd == DS_GREW)
-			set_bit(RESIZE_PENDING, &device->flags);
-
-		drbd_send_uuids(first_peer_device(device));
-		drbd_send_sizes(first_peer_device(device), 1, ddsf);
+	if (traditional_resize) {
+		for_each_peer_device(peer_device, device) {
+			if (peer_device->repl_state[NOW] == L_ESTABLISHED) {
+				if (dd == DS_GREW)
+					set_bit(RESIZE_PENDING, peer_device->flags);
+				drbd_send_uuids(peer_device, 0, 0);
+				drbd_send_sizes(peer_device, rs.resize_size, ddsf);
+			}
+		}
 	}
 
  fail:
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
- finish:
-	adm_ctx->reply_dh->ret_code = retcode;
+ out_no_adm_mutex:
+	adm_ctx->result = retcode;
 	return 0;
 
  fail_ldev:
@@ -2985,367 +5836,532 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 	goto fail;
 }
 
-int drbd_nl_resource_opts_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_resource_opts(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
-	struct res_opts res_opts;
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_res_opts res_opts;
 	int err;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto fail;
-
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out;
+	}
 	res_opts = adm_ctx->resource->res_opts;
-	if (should_set_defaults(info))
-		set_res_opts_defaults(&res_opts);
+	if (adm_ctx->set_defaults)
+		drbd_set_res_opts_defaults(&res_opts);
 
-	err = res_opts_from_attrs(&res_opts, info);
+	err = drbd_adm_overlay_res_opts(adm_ctx, &res_opts);
 	if (err && err != -ENOMSG) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+		drbd_adm_msg_overlay_error(adm_ctx, err);
 		goto fail;
 	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	err = set_resource_options(adm_ctx->resource, &res_opts);
+	if (adm_ctx->d->attr_present(adm_ctx, DRBD_ADM_F_RES_NODE_ID)) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg(adm_ctx, "%s", "cannot change invariant setting");
+		goto fail;
+	}
+
+	if (res_opts.explicit_drbd8_compat) {
+		struct drbd_connection *connection;
+		int n_connections = 0;
+
+		for_each_connection(connection, adm_ctx->resource)
+			n_connections++;
+
+		if (n_connections > 1) {
+			drbd_adm_msg(adm_ctx, "drbd8 compat mode allows one peer at max");
+			goto fail;
+		}
+	}
+
+	if (res_opts.node_id != -1) {
+#ifdef CONFIG_DRBD_COMPAT_84
+		if (!res_opts.drbd8_compat_mode && res_opts.explicit_drbd8_compat)
+			atomic_inc(&nr_drbd8_devices);
+		else if (res_opts.drbd8_compat_mode && !res_opts.explicit_drbd8_compat)
+			atomic_dec(&nr_drbd8_devices);
+#endif
+		res_opts.drbd8_compat_mode = res_opts.explicit_drbd8_compat;
+	}
+
+	err = set_resource_options(adm_ctx->resource, &res_opts, "resource-options");
 	if (err) {
 		retcode = ERR_INVALID_REQUEST;
 		if (err == -ENOMEM)
 			retcode = ERR_NOMEM;
 	}
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
 
 fail:
-	adm_ctx->reply_dh->ret_code = retcode;
+	mutex_unlock(&adm_ctx->resource->adm_mutex);
+out:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_invalidate_doit(struct sk_buff *skb, struct genl_info *info)
+static enum drbd_state_rv invalidate_resync(struct drbd_peer_device *peer_device)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct drbd_device *device;
-	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
+	struct drbd_resource *resource = peer_device->connection->resource;
+	enum drbd_state_rv rv;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	drbd_flush_workqueue(&peer_device->connection->sender_work);
+
+	rv = change_repl_state(peer_device, L_STARTING_SYNC_T, CS_SERIALIZE, "invalidate");
+
+	if (rv < SS_SUCCESS && rv != SS_NEED_CONNECTION)
+		rv = stable_change_repl_state(peer_device, L_STARTING_SYNC_T,
+			CS_VERBOSE | CS_SERIALIZE, "invalidate");
+
+	wait_event_interruptible(resource->state_wait,
+				 peer_device->repl_state[NOW] != L_STARTING_SYNC_T);
+
+	return rv;
+}
+
+static enum drbd_state_rv invalidate_no_resync(struct drbd_device *device)
+{
+	struct drbd_resource *resource = device->resource;
+	struct drbd_peer_device *peer_device;
+	struct drbd_connection *connection;
+	unsigned long irq_flags;
+	enum drbd_state_rv rv;
+
+	begin_state_change(resource, &irq_flags, CS_VERBOSE);
+	for_each_connection(connection, resource) {
+		peer_device = conn_peer_device(connection, device->vnr);
+		if (peer_device->repl_state[NOW] >= L_ESTABLISHED) {
+			abort_state_change(resource, &irq_flags);
+			return SS_UNKNOWN_ERROR;
+		}
+	}
+	__change_disk_state(device, D_INCONSISTENT);
+	rv = end_state_change(resource, &irq_flags, "invalidate");
+
+	if (rv >= SS_SUCCESS) {
+		drbd_bitmap_io(device, &drbd_bmio_set_all_n_write,
+			       "set_n_write from invalidate",
+			       BM_LOCK_CLEAR | BM_LOCK_BULK,
+			       NULL);
+	}
+
+	return rv;
+}
+
+int drbd_adm_invalidate(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_peer_device *sync_from_peer_device = NULL;
+	struct drbd_resource *resource;
+	struct drbd_device *device;
+	int retcode = 0; /* enum drbd_ret_code rsp. enum drbd_state_rv */
+	struct drbd_invalidate_parms inv = {
+		.sync_from_peer_node_id = -1,
+		.reset_bitmap = DRBD_INVALIDATE_RESET_BITMAP_DEF,
+	};
 
 	device = adm_ctx->device;
+
 	if (!get_ldev(device)) {
 		retcode = ERR_NO_DISK;
-		goto out;
+		goto out_no_ldev;
+	}
+
+	resource = device->resource;
+
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
 	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_INVALIDATE_PARMS)) {
+		int err;
+
+		err = drbd_adm_overlay_invalidate_parms(adm_ctx, &inv);
+		if (err) {
+			retcode = ERR_MANDATORY_TAG;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto out_no_resume;
+		}
+
+		if (inv.sync_from_peer_node_id != -1) {
+			struct drbd_connection *connection =
+				drbd_connection_by_node_id(resource, inv.sync_from_peer_node_id);
+			sync_from_peer_device = conn_peer_device(connection, device->vnr);
+		}
+
+		if (!inv.reset_bitmap && sync_from_peer_device &&
+		    sync_from_peer_device->connection->agreed_pro_version < 120) {
+			retcode = ERR_APV_TOO_LOW;
+			drbd_adm_msg(adm_ctx, "%s",
+				     "Need protocol level 120 to initiate bitmap based resync");
+			goto out_no_resume;
+		}
+	}
 
 	/* If there is still bitmap IO pending, probably because of a previous
 	 * resync just being finished, wait for it before requesting a new resync.
-	 * Also wait for it's after_state_ch(). */
-	drbd_suspend_io(device);
-	wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
-	drbd_flush_workqueue(&first_peer_device(device)->connection->sender_work);
-
-	/* If we happen to be C_STANDALONE R_SECONDARY, just change to
-	 * D_INCONSISTENT, and set all bits in the bitmap.  Otherwise,
-	 * try to start a resync handshake as sync target for full sync.
-	 */
-	if (device->state.conn == C_STANDALONE && device->state.role == R_SECONDARY) {
-		retcode = drbd_request_state(device, NS(disk, D_INCONSISTENT));
-		if (retcode >= SS_SUCCESS) {
-			if (drbd_bitmap_io(device, &drbd_bmio_set_n_write,
-				"set_n_write from invalidate", BM_LOCKED_MASK, NULL))
-				retcode = ERR_IO_MD_DISK;
+	 * Also wait for its after_state_ch(). */
+	drbd_suspend_io(device, READ_AND_WRITE);
+	wait_event(device->misc_wait, !atomic_read(&device->pending_bitmap_work.n));
+
+	if (sync_from_peer_device) {
+		if (inv.reset_bitmap) {
+			retcode = invalidate_resync(sync_from_peer_device);
+		} else {
+			retcode = change_repl_state(sync_from_peer_device, L_WF_BITMAP_T,
+					CS_VERBOSE | CS_CLUSTER_WIDE | CS_WAIT_COMPLETE |
+					CS_SERIALIZE, "invalidate");
 		}
-	} else
-		retcode = drbd_request_state(device, NS(conn, C_STARTING_SYNC_T));
-	drbd_resume_io(device);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-	put_ldev(device);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
-}
+	} else {
+		int retry = 3;
 
-static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *info,
-		union drbd_state mask, union drbd_state val)
-{
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
+		do {
+			struct drbd_connection *connection;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+			for_each_connection(connection, resource) {
+				struct drbd_peer_device *peer_device;
+
+				peer_device = conn_peer_device(connection, device->vnr);
+				if (!peer_device)
+					continue;
+
+				if (inv.reset_bitmap) {
+					retcode = invalidate_resync(peer_device);
+				} else {
+					if (connection->agreed_pro_version < 120) {
+						retcode = ERR_APV_TOO_LOW;
+						continue;
+					}
+					retcode = change_repl_state(peer_device, L_WF_BITMAP_T,
+								CS_VERBOSE | CS_CLUSTER_WIDE |
+								CS_WAIT_COMPLETE | CS_SERIALIZE,
+								"invalidate");
+				}
+				if (retcode >= SS_SUCCESS)
+					goto out;
+			}
+			if (retcode != SS_NEED_CONNECTION)
+				break;
+
+			retcode = invalidate_no_resync(device);
+		} while (retcode == SS_UNKNOWN_ERROR && retry--);
+	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	retcode = drbd_request_state(adm_ctx->device, mask, val);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	drbd_resume_io(device);
+out_no_resume:
+	mutex_unlock(&resource->adm_mutex);
+out_no_adm_mutex:
+	put_ldev(device);
+out_no_ldev:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-static int drbd_bmio_set_susp_al(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+static int drbd_bmio_set_susp_al(struct drbd_device *device, struct drbd_peer_device *peer_device)
 {
 	int rv;
 
 	rv = drbd_bmio_set_n_write(device, peer_device);
-	drbd_suspend_al(device);
+	drbd_try_suspend_al(device);
 	return rv;
 }
 
-int drbd_nl_inval_peer_doit(struct sk_buff *skb, struct genl_info *info)
+static int full_sync_from_peer(struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_resource *resource = device->resource;
+	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
+
+	retcode = stable_change_repl_state(peer_device, L_STARTING_SYNC_S, CS_SERIALIZE,
+			"invalidate-remote");
+	if (retcode < SS_SUCCESS) {
+		if (retcode == SS_NEED_CONNECTION && resource->role[NOW] == R_PRIMARY) {
+			/* The peer will get a resync upon connect anyways.
+			 * Just make that into a full resync. */
+			retcode = change_peer_disk_state(peer_device, D_INCONSISTENT,
+					CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE,
+					"invalidate-remote");
+			if (retcode >= SS_SUCCESS) {
+				if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
+						   "set_n_write from invalidate_peer",
+						   BM_LOCK_CLEAR | BM_LOCK_BULK |
+							BM_LOCK_SINGLE_SLOT,
+						   peer_device))
+					retcode = ERR_IO_MD_DISK;
+			}
+		} else {
+			retcode = stable_change_repl_state(peer_device, L_STARTING_SYNC_S,
+					CS_VERBOSE | CS_SERIALIZE, "invalidate-remote");
+		}
+	}
+
+	return retcode;
+}
+
+
+int drbd_adm_invalidate_peer(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	int retcode; /* drbd_ret_code, drbd_state_rv */
+	struct drbd_peer_device *peer_device;
+	struct drbd_resource *resource;
 	struct drbd_device *device;
+	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
+	struct drbd_invalidate_peer_parms inv = {
+		.p_reset_bitmap = DRBD_INVALIDATE_RESET_BITMAP_DEF,
+	};
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	peer_device = adm_ctx->peer_device;
+	device = peer_device->device;
+	resource = device->resource;
 
-	device = adm_ctx->device;
 	if (!get_ldev(device)) {
 		retcode = ERR_NO_DISK;
 		goto out;
 	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_INVALIDATE_PEER_PARMS)) {
+		int err;
+
+		err = drbd_adm_overlay_invalidate_peer_parms(adm_ctx, &inv);
+		if (err) {
+			retcode = ERR_MANDATORY_TAG;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto out_unlock;
+		}
+		if (!inv.p_reset_bitmap && peer_device->connection->agreed_pro_version < 120) {
+			retcode = ERR_APV_TOO_LOW;
+			drbd_adm_msg(adm_ctx, "%s",
+				     "Need protocol level 120 to initiate bitmap based resync");
+			goto out_unlock;
+		}
+	}
+
+	drbd_suspend_io(device, READ_AND_WRITE);
+	wait_event(device->misc_wait, !atomic_read(&device->pending_bitmap_work.n));
+	drbd_flush_workqueue(&peer_device->connection->sender_work);
 
-	/* If there is still bitmap IO pending, probably because of a previous
-	 * resync just being finished, wait for it before requesting a new resync.
-	 * Also wait for it's after_state_ch(). */
-	drbd_suspend_io(device);
-	wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
-	drbd_flush_workqueue(&first_peer_device(device)->connection->sender_work);
-
-	/* If we happen to be C_STANDALONE R_PRIMARY, just set all bits
-	 * in the bitmap.  Otherwise, try to start a resync handshake
-	 * as sync source for full sync.
-	 */
-	if (device->state.conn == C_STANDALONE && device->state.role == R_PRIMARY) {
-		/* The peer will get a resync upon connect anyways. Just make that
-		   into a full resync. */
-		retcode = drbd_request_state(device, NS(pdsk, D_INCONSISTENT));
-		if (retcode >= SS_SUCCESS) {
-			if (drbd_bitmap_io(device, &drbd_bmio_set_susp_al,
-				"set_n_write from invalidate_peer",
-				BM_LOCKED_SET_ALLOWED, NULL))
-				retcode = ERR_IO_MD_DISK;
-		}
-	} else
-		retcode = drbd_request_state(device, NS(conn, C_STARTING_SYNC_S));
+	if (inv.p_reset_bitmap) {
+		retcode = full_sync_from_peer(peer_device);
+	} else {
+		retcode = change_repl_state(peer_device, L_WF_BITMAP_S,
+				CS_VERBOSE | CS_CLUSTER_WIDE | CS_WAIT_COMPLETE | CS_SERIALIZE,
+				"invalidate-remote");
+	}
 	drbd_resume_io(device);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
+
+out_unlock:
+	mutex_unlock(&resource->adm_mutex);
+out_no_adm_mutex:
 	put_ldev(device);
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_pause_sync_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_pause_sync(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
+	struct drbd_peer_device *peer_device;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
 		goto out;
+	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	if (drbd_request_state(adm_ctx->device, NS(user_isp, 1)) == SS_NOTHING_TO_DO)
+	peer_device = adm_ctx->peer_device;
+	if (change_resync_susp_user(peer_device, true,
+			CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE) == SS_NOTHING_TO_DO)
 		retcode = ERR_PAUSE_IS_SET;
+
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
+ out:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_resume_sync_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_resume_sync(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	union drbd_dev_state s;
-	enum drbd_ret_code retcode;
+	struct drbd_peer_device *peer_device;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
 		goto out;
+	}
+
+	peer_device = adm_ctx->peer_device;
+	if (change_resync_susp_user(peer_device, false,
+			CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE) == SS_NOTHING_TO_DO) {
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	if (drbd_request_state(adm_ctx->device, NS(user_isp, 0)) == SS_NOTHING_TO_DO) {
-		s = adm_ctx->device->state;
-		if (s.conn == C_PAUSED_SYNC_S || s.conn == C_PAUSED_SYNC_T) {
-			retcode = s.aftr_isp ? ERR_PIC_AFTER_DEP :
-				  s.peer_isp ? ERR_PIC_PEER_DEP : ERR_PAUSE_IS_CLEAR;
+		if (peer_device->repl_state[NOW] == L_PAUSED_SYNC_S ||
+		    peer_device->repl_state[NOW] == L_PAUSED_SYNC_T) {
+			if (peer_device->resync_susp_dependency[NOW])
+				retcode = ERR_PIC_AFTER_DEP;
+			else if (peer_device->resync_susp_peer[NOW])
+				retcode = ERR_PIC_PEER_DEP;
+			else
+				retcode = ERR_PAUSE_IS_CLEAR;
 		} else {
 			retcode = ERR_PAUSE_IS_CLEAR;
 		}
 	}
+
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
+ out:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_suspend_io_doit(struct sk_buff *skb, struct genl_info *info)
+static bool io_drained(struct drbd_device *device)
 {
-	return drbd_adm_simple_request_state(skb, info, NS(susp, 1));
+	struct drbd_peer_device *peer_device;
+	bool drained = true;
+
+	if (atomic_read(&device->local_cnt))
+		return false;
+
+	rcu_read_lock();
+	for_each_peer_device_rcu(peer_device, device) {
+		if (atomic_read(&peer_device->ap_pending_cnt)) {
+			drained = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return drained;
 }
 
-int drbd_nl_resume_io_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_suspend_io(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
+	struct drbd_resource *resource;
 	struct drbd_device *device;
-	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
+	int retcode = NO_ERROR, vnr, err = 0;
+	struct drbd_suspend_io_parms params = {
+		.bdev_freeze = true,
+	};
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	resource = adm_ctx->device->resource;
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	device = adm_ctx->device;
-	if (test_bit(NEW_CUR_UUID, &device->flags)) {
-		if (get_ldev_if_state(device, D_ATTACHING)) {
-			drbd_uuid_new_current(device);
-			put_ldev(device);
-		} else {
-			/* This is effectively a multi-stage "forced down".
-			 * The NEW_CUR_UUID bit is supposedly only set, if we
-			 * lost the replication connection, and are configured
-			 * to freeze IO and wait for some fence-peer handler.
-			 * So we still don't have a replication connection.
-			 * And now we don't have a local disk either.  After
-			 * resume, we will fail all pending and new IO, because
-			 * we don't have any data anymore.  Which means we will
-			 * eventually be able to terminate all users of this
-			 * device, and then take it down.  By bumping the
-			 * "effective" data uuid, we make sure that you really
-			 * need to tear down before you reconfigure, we will
-			 * the refuse to re-connect or re-attach (because no
-			 * matching real data uuid exists).
-			 */
-			u64 val;
-			val = get_random_u64();
-			drbd_set_ed_uuid(device, val);
-			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_SUSPEND_IO_PARMS)) {
+		err = drbd_adm_overlay_suspend_io_parms(adm_ctx, &params);
+		if (err) {
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			return err;
 		}
-		clear_bit(NEW_CUR_UUID, &device->flags);
 	}
-	drbd_suspend_io(device);
-	retcode = drbd_request_state(device, NS3(susp, 0, susp_nod, 0, susp_fen, 0));
-	if (retcode == SS_SUCCESS) {
-		if (device->state.conn < C_CONNECTED)
-			tl_clear(first_peer_device(device)->connection);
-		if (device->state.disk == D_DISKLESS || device->state.disk == D_FAILED)
-			tl_restart(first_peer_device(device)->connection, FAIL_FROZEN_DISK_IO);
+
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out;
 	}
-	drbd_resume_io(device);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
-}
 
-int drbd_nl_outdate_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return drbd_adm_simple_request_state(skb, info, NS(disk, D_OUTDATED));
-}
+	idr_for_each_entry(&resource->devices, device, vnr)
+		if (params.bdev_freeze && !test_bit(BDEV_FROZEN, &device->flags)) {
+			err = bdev_freeze(device->vdisk->part0);
+			if (err)
+				goto out_thaw;
 
-static int nla_put_drbd_cfg_context(struct sk_buff *skb,
-				    struct drbd_resource *resource,
-				    struct drbd_connection *connection,
-				    struct drbd_device *device)
-{
-	struct nlattr *nla;
-	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
-	if (!nla)
-		goto nla_put_failure;
-	if (device &&
-	    nla_put_u32(skb, DRBD_A_DRBD_CFG_CONTEXT_CTX_VOLUME, device->vnr))
-		goto nla_put_failure;
-	if (nla_put_string(skb, DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME, resource->name))
-		goto nla_put_failure;
-	if (connection) {
-		if (connection->my_addr_len &&
-		    nla_put(skb, DRBD_A_DRBD_CFG_CONTEXT_CTX_MY_ADDR,
-			    connection->my_addr_len,
-			    &connection->my_addr))
-			goto nla_put_failure;
-		if (connection->peer_addr_len &&
-		    nla_put(skb, DRBD_A_DRBD_CFG_CONTEXT_CTX_PEER_ADDR,
-			    connection->peer_addr_len,
-			    &connection->peer_addr))
-			goto nla_put_failure;
-	}
-	nla_nest_end(skb, nla);
+			set_bit(BDEV_FROZEN, &device->flags);
+		}
+
+	retcode = stable_state_change(resource, change_io_susp_user(resource, true,
+						CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE));
+	mutex_unlock(&resource->adm_mutex);
+	if (retcode < SS_SUCCESS)
+		goto out;
+
+	idr_for_each_entry(&resource->devices, device, vnr)
+		wait_event_interruptible(device->misc_wait, io_drained(device));
+out:
+	adm_ctx->result = retcode;
 	return 0;
+out_thaw:
+	idr_for_each_entry(&resource->devices, device, vnr)
+		if (test_and_clear_bit(BDEV_FROZEN, &device->flags))
+			bdev_thaw(device->vdisk->part0);
 
-nla_put_failure:
-	if (nla)
-		nla_nest_cancel(skb, nla);
-	return -EMSGSIZE;
+	mutex_unlock(&resource->adm_mutex);
+	adm_ctx->result = retcode;
+	return err;
 }
 
-/*
- * net_conf_to_skb() serializes the shared secret verbatim. Any path that can
- * answer a request from an unprivileged process must pass exclude_sensitive,
- * so the secret is blanked in a private copy before it reaches the skb.
- */
-static int net_conf_to_skb_sanitized(struct sk_buff *skb, struct net_conf *nc,
-				     bool exclude_sensitive)
+int drbd_adm_resume_io(struct drbd_adm_ctx *adm_ctx)
 {
-	struct net_conf nc_clean;
+	struct drbd_connection *connection;
+	struct drbd_resource *resource;
+	struct drbd_device *device, *d;
+	unsigned long irq_flags;
+	int vnr, retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
 
-	if (!exclude_sensitive)
-		return net_conf_to_skb(skb, nc);
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out;
+	}
+	device = adm_ctx->device;
+	resource = device->resource;
+	/* gen-rotate reason: DEGRADE (deferred bump flushed on admin resume-io).
+	 * The state change below clears every suspension reason of the resource,
+	 * so it finalizes writes held on any of its volumes; the obligation is
+	 * per volume, so ask each of them.
+	 */
+	idr_for_each_entry(&resource->devices, d, vnr)
+		drbd_gen_obligation_mint_before_resume(d, 0);
+	drbd_suspend_io(device, READ_AND_WRITE);
+	begin_state_change(resource, &irq_flags, CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE);
+	__change_io_susp_user(resource, false);
+	__change_io_susp_no_data(resource, false);
+	for_each_connection(connection, resource)
+		__change_io_susp_fencing(connection, false);
+
+	__change_io_susp_quorum(resource, false);
+	retcode = end_state_change(resource, &irq_flags, "resume-io");
+	drbd_resume_io(device);
 
-	nc_clean = *nc;
-	memset(nc_clean.shared_secret, 0, sizeof(nc_clean.shared_secret));
-	nc_clean.shared_secret_len = 0;
+	idr_for_each_entry(&resource->devices, device, vnr)
+		if (test_and_clear_bit(BDEV_FROZEN, &device->flags))
+			bdev_thaw(device->vdisk->part0);
 
-	return net_conf_to_skb(skb, &nc_clean);
+	mutex_unlock(&adm_ctx->resource->adm_mutex);
+ out:
+	adm_ctx->result = retcode;
+	return 0;
 }
 
-/*
- * The generic netlink dump callbacks are called outside the genl_lock(), so
- * they cannot use the simple attribute parsing code which uses global
- * attribute tables.
- */
-static struct nlattr *find_cfg_context_attr(const struct nlmsghdr *nlh, int attr)
+int drbd_adm_outdate(struct drbd_adm_ctx *adm_ctx)
 {
-	const unsigned int hdrlen = GENL_HDRLEN + sizeof(struct drbd_genlmsghdr);
-	struct nlattr *nla;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	nla = nla_find(nlmsg_attrdata(nlh, hdrlen), nlmsg_attrlen(nlh, hdrlen),
-		       DRBD_NLA_CFG_CONTEXT);
-	if (!nla)
-		return NULL;
-	return nla_find_nested(nla, attr);
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+	} else {
+		retcode = stable_state_change(adm_ctx->device->resource,
+			change_disk_state(adm_ctx->device, D_OUTDATED,
+				  CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE, "outdate", NULL));
+		mutex_unlock(&adm_ctx->resource->adm_mutex);
+	}
+	adm_ctx->result = retcode;
+	return 0;
 }
 
-static void resource_to_info(struct resource_info *, struct drbd_resource *);
+static void resource_to_info(struct drbd_resource_info *, struct drbd_resource *);
 
-int drbd_nl_get_resources_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+void resource_to_statistics(struct drbd_resource_statistics *s, struct drbd_resource *resource)
+{
+	s->res_stat_write_ordering = resource->write_ordering;
+}
+
+int drbd_dump_resources(struct sk_buff *skb, struct netlink_callback *cb,
+			const struct drbd_nl_dialect *dialect)
 {
-	struct drbd_genlmsghdr *dh;
 	struct drbd_resource *resource;
-	struct resource_info resource_info;
-	struct resource_statistics resource_statistics;
+	struct drbd_resource_info resource_info;
+	struct drbd_resource_statistics resource_statistics;
 	int err;
 
 	rcu_read_lock();
@@ -3367,31 +6383,13 @@ int drbd_nl_get_resources_dumpit(struct sk_buff *skb, struct netlink_callback *c
 	goto out;
 
 put_result:
-	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, &drbd_nl_family,
-			NLM_F_MULTI, DRBD_ADM_GET_RESOURCES);
-	err = -ENOMEM;
-	if (!dh)
-		goto out;
-	dh->minor = -1U;
-	dh->ret_code = NO_ERROR;
-	err = nla_put_drbd_cfg_context(skb, resource, NULL, NULL);
-	if (err)
-		goto out;
-	err = res_opts_to_skb(skb, &resource->res_opts);
-	if (err)
-		goto out;
 	resource_to_info(&resource_info, resource);
-	err = resource_info_to_skb(skb, &resource_info);
-	if (err)
-		goto out;
-	resource_statistics.res_stat_write_ordering = resource->write_ordering;
-	err = resource_statistics_to_skb(skb, &resource_statistics);
+	resource_to_statistics(&resource_statistics, resource);
+	err = dialect->emit_resource(skb, cb, resource, &resource_info,
+				     &resource_statistics);
 	if (err)
 		goto out;
 	cb->args[0] = (long)resource;
-	genlmsg_end(skb, dh);
-	err = 0;
 
 out:
 	rcu_read_unlock();
@@ -3400,8 +6398,8 @@ int drbd_nl_get_resources_dumpit(struct sk_buff *skb, struct netlink_callback *c
 	return skb->len;
 }
 
-static void device_to_statistics(struct device_statistics *s,
-				 struct drbd_device *device)
+void device_to_statistics(struct drbd_device_statistics *s,
+			  struct drbd_device *device)
 {
 	memset(s, 0, sizeof(*s));
 	s->dev_upper_blocked = !may_inc_ap_bio(device);
@@ -3411,16 +6409,18 @@ static void device_to_statistics(struct device_statistics *s,
 		int n;
 
 		spin_lock_irq(&md->uuid_lock);
-		s->dev_current_uuid = md->uuid[UI_CURRENT];
-		BUILD_BUG_ON(sizeof(s->history_uuids) < UI_HISTORY_END - UI_HISTORY_START + 1);
-		for (n = 0; n < UI_HISTORY_END - UI_HISTORY_START + 1; n++)
-			history_uuids[n] = md->uuid[UI_HISTORY_START + n];
-		for (; n < HISTORY_UUIDS; n++)
-			history_uuids[n] = 0;
-		s->history_uuids_len = HISTORY_UUIDS;
+		s->dev_current_uuid = md->current_uuid;
+		BUILD_BUG_ON(sizeof(s->history_uuids) != sizeof(md->history_uuids));
+		for (n = 0; n < ARRAY_SIZE(md->history_uuids); n++)
+			history_uuids[n] = md->history_uuids[n];
+		s->history_uuids_len = sizeof(s->history_uuids);
 		spin_unlock_irq(&md->uuid_lock);
 
 		s->dev_disk_flags = md->flags;
+		/* originally, this used the bdi congestion framework,
+		 * but that was removed in linux 5.18.
+		 * so just never report the lower device as congested. */
+		s->dev_lower_blocked = false;
 		put_ldev(device);
 	}
 	s->dev_size = get_capacity(device->vdisk);
@@ -3428,10 +6428,11 @@ static void device_to_statistics(struct device_statistics *s,
 	s->dev_write = device->writ_cnt;
 	s->dev_al_writes = device->al_writ_cnt;
 	s->dev_bm_writes = device->bm_writ_cnt;
-	s->dev_upper_pending = atomic_read(&device->ap_bio_cnt);
+	s->dev_upper_pending = atomic_read(&device->ap_bio_cnt[READ]) +
+		atomic_read(&device->ap_bio_cnt[WRITE]);
 	s->dev_lower_pending = atomic_read(&device->local_cnt);
 	s->dev_al_suspended = test_bit(AL_SUSPENDED, &device->flags);
-	s->dev_exposed_data_uuid = device->ed_uuid;
+	s->dev_exposed_data_uuid = device->exposed_data_uuid;
 }
 
 static int put_resource_in_arg0(struct netlink_callback *cb, int holder_nr)
@@ -3445,37 +6446,24 @@ static int put_resource_in_arg0(struct netlink_callback *cb, int holder_nr)
 	return 0;
 }
 
-int drbd_adm_dump_devices_done(struct netlink_callback *cb) {
+int drbd_dump_devices_done(struct netlink_callback *cb)
+{
 	return put_resource_in_arg0(cb, 7);
 }
 
-static void device_to_info(struct device_info *, struct drbd_device *);
-
-int drbd_nl_get_devices_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_dump_devices(struct sk_buff *skb, struct netlink_callback *cb,
+		      const struct drbd_nl_dialect *dialect)
 {
-	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
 	struct drbd_device *device;
-	int minor, err, retcode;
-	struct drbd_genlmsghdr *dh;
-	struct device_info device_info;
-	struct device_statistics device_statistics;
+	struct drbd_disk_conf *disk_conf;
+	bool have_ldev;
+	int minor, err;
+	struct drbd_device_info device_info;
+	struct drbd_device_statistics device_statistics;
 	struct idr *idr_to_search;
 
 	resource = (struct drbd_resource *)cb->args[0];
-	if (!cb->args[0] && !cb->args[1]) {
-		resource_filter = find_cfg_context_attr(cb->nlh,
-				DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME);
-		if (resource_filter) {
-			retcode = ERR_RES_NOT_KNOWN;
-			resource = drbd_find_resource(nla_data(resource_filter));
-			if (!resource) {
-				rcu_read_lock();
-				goto put_result;
-			}
-			cb->args[0] = (long)resource;
-		}
-	}
 
 	rcu_read_lock();
 	minor = cb->args[1];
@@ -3486,48 +6474,23 @@ int drbd_nl_get_devices_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		goto out;
 	}
 	idr_for_each_entry_continue(idr_to_search, device, minor) {
-		retcode = NO_ERROR;
 		goto put_result;  /* only one iteration */
 	}
 	err = 0;
 	goto out;  /* no more devices */
 
 put_result:
-	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, &drbd_nl_family,
-			NLM_F_MULTI, DRBD_ADM_GET_DEVICES);
-	err = -ENOMEM;
-	if (!dh)
+	device_to_info(&device_info, device);
+	device_to_statistics(&device_statistics, device);
+	have_ldev = get_ldev_if_state(device, D_FAILED);
+	disk_conf = have_ldev ? rcu_dereference(device->ldev->disk_conf) : NULL;
+	err = dialect->emit_device(skb, cb, NO_ERROR, device, disk_conf,
+				   &device_info, &device_statistics);
+	if (have_ldev)
+		put_ldev(device);
+	if (err)
 		goto out;
-	dh->ret_code = retcode;
-	dh->minor = -1U;
-	if (retcode == NO_ERROR) {
-		dh->minor = device->minor;
-		err = nla_put_drbd_cfg_context(skb, device->resource, NULL, device);
-		if (err)
-			goto out;
-		if (get_ldev(device)) {
-			struct disk_conf *disk_conf =
-				rcu_dereference(device->ldev->disk_conf);
-
-			err = disk_conf_to_skb(skb, disk_conf);
-			put_ldev(device);
-			if (err)
-				goto out;
-		}
-		device_to_info(&device_info, device);
-		err = device_info_to_skb(skb, &device_info);
-		if (err)
-			goto out;
-
-		device_to_statistics(&device_statistics, device);
-		err = device_statistics_to_skb(skb, &device_statistics);
-		if (err)
-			goto out;
-		cb->args[1] = minor + 1;
-	}
-	genlmsg_end(skb, dh);
-	err = 0;
+	cb->args[1] = minor + 1;
 
 out:
 	rcu_read_unlock();
@@ -3536,49 +6499,55 @@ int drbd_nl_get_devices_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-int drbd_adm_dump_connections_done(struct netlink_callback *cb)
+int drbd_dump_connections_done(struct netlink_callback *cb)
 {
 	return put_resource_in_arg0(cb, 6);
 }
 
-enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
+void connection_to_statistics(struct drbd_connection_statistics *s,
+			      struct drbd_connection *connection)
+{
+	s->conn_congested = test_bit(NET_CONGESTED, &connection->transport.flags);
+	s->ap_in_flight = atomic_read(&connection->ap_in_flight);
+	s->rs_in_flight = atomic_read(&connection->rs_in_flight);
+}
 
-int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_dump_connections(struct sk_buff *skb, struct netlink_callback *cb,
+			  const struct drbd_nl_dialect *dialect)
 {
-	struct nlattr *resource_filter;
 	struct drbd_resource *resource = NULL, *next_resource;
-	struct drbd_connection *connection;
+	struct drbd_connection *connection = NULL;
+	struct drbd_net_conf *net_conf, nc_copy;
 	int err = 0, retcode;
-	struct drbd_genlmsghdr *dh;
-	struct connection_info connection_info;
-	struct connection_statistics connection_statistics;
+	struct drbd_connection_info connection_info;
+	struct drbd_connection_statistics connection_statistics;
 
 	rcu_read_lock();
 	resource = (struct drbd_resource *)cb->args[0];
-	if (!cb->args[0]) {
-		resource_filter = find_cfg_context_attr(cb->nlh,
-				DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME);
-		if (resource_filter) {
-			retcode = ERR_RES_NOT_KNOWN;
-			resource = drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
-				goto put_result;
-			cb->args[0] = (long)resource;
-			cb->args[1] = SINGLE_RESOURCE;
-		}
-	}
 	if (!resource) {
 		if (list_empty(&drbd_resources))
 			goto out;
 		resource = list_first_entry(&drbd_resources, struct drbd_resource, resources);
 		kref_get(&resource->kref);
 		cb->args[0] = (long)resource;
-		cb->args[1] = ITERATE_RESOURCES;
+		cb->args[1] = DRBD_DUMP_ITERATE_RESOURCES;
 	}
 
-    next_resource:
+next_resource:
 	rcu_read_unlock();
-	mutex_lock(&resource->conf_update);
+	if (mutex_lock_interruptible(&resource->conf_update)) {
+		kref_put(&resource->kref, drbd_destroy_resource);
+		resource = NULL;
+		/* Drop the stale pointer so that neither a subsequent dump
+		 * round nor the done() callback uses the reference we just
+		 * dropped.
+		 */
+		cb->args[0] = 0;
+		cb->args[2] = 0;
+		retcode = ERR_INTR;
+		rcu_read_lock();
+		goto put_result;
+	}
 	rcu_read_lock();
 	if (cb->args[2]) {
 		for_each_connection_rcu(connection, resource)
@@ -3591,14 +6560,12 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback
 
 found_connection:
 	list_for_each_entry_continue_rcu(connection, &resource->connections, connections) {
-		if (!has_net_conf(connection))
-			continue;
 		retcode = NO_ERROR;
 		goto put_result;  /* only one iteration */
 	}
 
 no_more_connections:
-	if (cb->args[1] == ITERATE_RESOURCES) {
+	if (cb->args[1] == DRBD_DUMP_ITERATE_RESOURCES) {
 		for_each_resource_rcu(next_resource, &drbd_resources) {
 			if (next_resource == resource)
 				goto found_resource;
@@ -3620,39 +6587,28 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback
 	goto out;  /* no more resources */
 
 put_result:
-	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, &drbd_nl_family,
-			NLM_F_MULTI, DRBD_ADM_GET_CONNECTIONS);
-	err = -ENOMEM;
-	if (!dh)
-		goto out;
-	dh->ret_code = retcode;
-	dh->minor = -1U;
+	net_conf = NULL;
 	if (retcode == NO_ERROR) {
-		struct net_conf *net_conf;
-
-		err = nla_put_drbd_cfg_context(skb, resource, connection, NULL);
-		if (err)
-			goto out;
-		net_conf = rcu_dereference(connection->net_conf);
-		if (net_conf) {
-			err = net_conf_to_skb_sanitized(skb, net_conf,
-							!capable(CAP_SYS_ADMIN));
-			if (err)
-				goto out;
+		struct drbd_net_conf *nc = rcu_dereference(connection->transport.net_conf);
+
+		if (nc) {
+			nc_copy = *nc;
+			if (!capable(CAP_SYS_ADMIN)) {
+				memset(nc_copy.shared_secret, 0,
+				       sizeof(nc_copy.shared_secret));
+				nc_copy.shared_secret_len = 0;
+			}
+			net_conf = &nc_copy;
 		}
 		connection_to_info(&connection_info, connection);
-		err = connection_info_to_skb(skb, &connection_info);
-		if (err)
-			goto out;
-		connection_statistics.conn_congested = test_bit(NET_CONGESTED, &connection->flags);
-		err = connection_statistics_to_skb(skb, &connection_statistics);
-		if (err)
-			goto out;
-		cb->args[2] = (long)connection;
+		connection_to_statistics(&connection_statistics, connection);
 	}
-	genlmsg_end(skb, dh);
-	err = 0;
+	err = dialect->emit_connection(skb, cb, retcode, resource, connection, net_conf,
+				       &connection_info, &connection_statistics);
+	if (err)
+		goto out;
+	if (retcode == NO_ERROR)
+		cb->args[2] = (long)connection;
 
 out:
 	rcu_read_unlock();
@@ -3663,74 +6619,113 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback
 	return skb->len;
 }
 
-enum mdf_peer_flag {
-	MDF_PEER_CONNECTED =	1 << 0,
-	MDF_PEER_OUTDATED =	1 << 1,
-	MDF_PEER_FENCING =	1 << 2,
-	MDF_PEER_FULL_SYNC =	1 << 3,
-};
-
-static void peer_device_to_statistics(struct peer_device_statistics *s,
-				      struct drbd_peer_device *peer_device)
+void peer_device_to_statistics(struct drbd_peer_device_statistics *s,
+			       struct drbd_peer_device *pd)
 {
-	struct drbd_device *device = peer_device->device;
+	struct drbd_device *device = pd->device;
+	struct drbd_md *md;
+	struct drbd_peer_md *peer_md;
+	struct drbd_bitmap *bm;
+	unsigned long now = jiffies;
+	unsigned long rs_left = 0;
+	int i;
+
+	/* userspace should get "future proof" units,
+	 * convert to sectors or milli seconds as appropriate */
 
 	memset(s, 0, sizeof(*s));
-	s->peer_dev_received = device->recv_cnt;
-	s->peer_dev_sent = device->send_cnt;
-	s->peer_dev_pending = atomic_read(&device->ap_pending_cnt) +
-			      atomic_read(&device->rs_pending_cnt);
-	s->peer_dev_unacked = atomic_read(&device->unacked_cnt);
-	s->peer_dev_out_of_sync = drbd_bm_total_weight(device) << (BM_BLOCK_SHIFT - 9);
-	s->peer_dev_resync_failed = device->rs_failed << (BM_BLOCK_SHIFT - 9);
-	if (get_ldev(device)) {
-		struct drbd_md *md = &device->ldev->md;
+	s->peer_dev_received = pd->recv_cnt;
+	s->peer_dev_sent = pd->send_cnt;
+	s->peer_dev_pending = atomic_read(&pd->ap_pending_cnt) +
+			      atomic_read(&pd->rs_pending_cnt);
+	s->peer_dev_unacked = atomic_read(&pd->unacked_cnt);
+	s->peer_dev_uuid_flags = pd->uuid_flags;
+
+	/* Below are resync / verify / bitmap / meta data stats.
+	 * Without disk, we don't have those.
+	 */
+	if (!get_ldev(device))
+		return;
 
-		spin_lock_irq(&md->uuid_lock);
-		s->peer_dev_bitmap_uuid = md->uuid[UI_BITMAP];
-		spin_unlock_irq(&md->uuid_lock);
-		s->peer_dev_flags =
-			(drbd_md_test_flag(device->ldev, MDF_CONNECTED_IND) ?
-				MDF_PEER_CONNECTED : 0) +
-			(drbd_md_test_flag(device->ldev, MDF_CONSISTENT) &&
-			 !drbd_md_test_flag(device->ldev, MDF_WAS_UP_TO_DATE) ?
-				MDF_PEER_OUTDATED : 0) +
-			/* FIXME: MDF_PEER_FENCING? */
-			(drbd_md_test_flag(device->ldev, MDF_FULL_SYNC) ?
-				MDF_PEER_FULL_SYNC : 0);
+	md = &device->ldev->md;
+	peer_md = &md->peers[pd->node_id];
+
+	spin_lock_irq(&md->uuid_lock);
+	s->peer_dev_bitmap_uuid = peer_md->bitmap_uuid;
+	spin_unlock_irq(&md->uuid_lock);
+	s->peer_dev_flags = peer_md->flags;
+
+	/* A disk attached without a bitmap has no out-of-sync, resync or
+	 * verify state to report, and no bm_block_shift to convert with.
+	 */
+	bm = device->bitmap;
+	if (!bm) {
 		put_ldev(device);
+		return;
+	}
+
+	s->peer_dev_out_of_sync = bm_bit_to_sect(bm, drbd_bm_total_weight(pd));
+
+	if (is_verify_state(pd, NOW)) {
+		rs_left = bm_bit_to_sect(bm, atomic64_read(&pd->ov_left));
+		s->peer_dev_ov_start_sector = pd->ov_start_sector;
+		s->peer_dev_ov_stop_sector = pd->ov_stop_sector;
+		s->peer_dev_ov_position = pd->ov_position;
+		s->peer_dev_ov_left = bm_bit_to_sect(bm, atomic64_read(&pd->ov_left));
+		s->peer_dev_ov_skipped = bm_bit_to_sect(bm, pd->ov_skipped);
+	} else if (is_sync_state(pd, NOW)) {
+		rs_left = s->peer_dev_out_of_sync - bm_bit_to_sect(bm, pd->rs_failed);
+		s->peer_dev_resync_failed = bm_bit_to_sect(bm, pd->rs_failed);
+		s->peer_dev_rs_same_csum = bm_bit_to_sect(bm, pd->rs_same_csum);
+	}
+
+	if (rs_left) {
+		enum drbd_repl_state repl_state = pd->repl_state[NOW];
+
+		if (repl_state == L_SYNC_TARGET || repl_state == L_VERIFY_S)
+			s->peer_dev_rs_c_sync_rate = pd->c_sync_rate;
+
+		s->peer_dev_rs_total = bm_bit_to_sect(bm, pd->rs_total);
+
+		s->peer_dev_rs_dt_start_ms = jiffies_to_msecs(now - pd->rs_start);
+		s->peer_dev_rs_paused_ms = jiffies_to_msecs(pd->rs_paused);
+
+		i = (pd->rs_last_mark + 2) % DRBD_SYNC_MARKS;
+		s->peer_dev_rs_dt0_ms = jiffies_to_msecs(now - pd->rs_mark_time[i]);
+		s->peer_dev_rs_db0_sectors = bm_bit_to_sect(bm, pd->rs_mark_left[i]) - rs_left;
+
+		i = (pd->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
+		s->peer_dev_rs_dt1_ms = jiffies_to_msecs(now - pd->rs_mark_time[i]);
+		s->peer_dev_rs_db1_sectors = bm_bit_to_sect(bm, pd->rs_mark_left[i]) - rs_left;
+
+		/* long term average:
+		 * dt = rs_dt_start_ms - rs_paused_ms;
+		 * db = rs_total - rs_left, which is
+		 *   rs_total - (ov_left? ov_left : out_of_sync - rs_failed)
+		 */
 	}
+
+	put_ldev(device);
 }
 
-int drbd_adm_dump_peer_devices_done(struct netlink_callback *cb)
+int drbd_dump_peer_devices_done(struct netlink_callback *cb)
 {
 	return put_resource_in_arg0(cb, 9);
 }
 
-int drbd_nl_get_peer_devices_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb,
+			   const struct drbd_nl_dialect *dialect)
 {
-	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device = NULL;
-	int minor, err, retcode;
-	struct drbd_genlmsghdr *dh;
+	struct drbd_peer_device_info peer_device_info;
+	struct drbd_peer_device_statistics peer_device_statistics;
+	struct drbd_peer_device_conf *peer_device_conf;
+	int minor, err;
 	struct idr *idr_to_search;
 
 	resource = (struct drbd_resource *)cb->args[0];
-	if (!cb->args[0] && !cb->args[1]) {
-		resource_filter = find_cfg_context_attr(cb->nlh,
-				DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME);
-		if (resource_filter) {
-			retcode = ERR_RES_NOT_KNOWN;
-			resource = drbd_find_resource(nla_data(resource_filter));
-			if (!resource) {
-				rcu_read_lock();
-				goto put_result;
-			}
-		}
-		cb->args[0] = (long)resource;
-	}
 
 	rcu_read_lock();
 	minor = cb->args[1];
@@ -3747,7 +6742,7 @@ int drbd_nl_get_peer_devices_dumpit(struct sk_buff *skb, struct netlink_callback
 		}
 	}
 	if (cb->args[2]) {
-		for_each_peer_device(peer_device, device)
+		for_each_peer_device_rcu(peer_device, device)
 			if (peer_device == (struct drbd_peer_device *)cb->args[2])
 				goto found_peer_device;
 		/* peer device was probably deleted */
@@ -3758,43 +6753,21 @@ int drbd_nl_get_peer_devices_dumpit(struct sk_buff *skb, struct netlink_callback
 
 found_peer_device:
 	list_for_each_entry_continue_rcu(peer_device, &device->peer_devices, peer_devices) {
-		if (!has_net_conf(peer_device->connection))
-			continue;
-		retcode = NO_ERROR;
 		goto put_result;  /* only one iteration */
 	}
 	goto next_device;
 
 put_result:
-	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, &drbd_nl_family,
-			NLM_F_MULTI, DRBD_ADM_GET_PEER_DEVICES);
-	err = -ENOMEM;
-	if (!dh)
+	peer_device_to_info(&peer_device_info, peer_device);
+	peer_device_to_statistics(&peer_device_statistics, peer_device);
+	peer_device_conf = rcu_dereference(peer_device->conf);
+	err = dialect->emit_peer_device(skb, cb, NO_ERROR, peer_device, minor,
+					&peer_device_info, &peer_device_statistics,
+					peer_device_conf);
+	if (err)
 		goto out;
-	dh->ret_code = retcode;
-	dh->minor = -1U;
-	if (retcode == NO_ERROR) {
-		struct peer_device_info peer_device_info;
-		struct peer_device_statistics peer_device_statistics;
-
-		dh->minor = minor;
-		err = nla_put_drbd_cfg_context(skb, device->resource, peer_device->connection, device);
-		if (err)
-			goto out;
-		peer_device_to_info(&peer_device_info, peer_device);
-		err = peer_device_info_to_skb(skb, &peer_device_info);
-		if (err)
-			goto out;
-		peer_device_to_statistics(&peer_device_statistics, peer_device);
-		err = peer_device_statistics_to_skb(skb, &peer_device_statistics);
-		if (err)
-			goto out;
-		cb->args[1] = minor;
-		cb->args[2] = (long)peer_device;
-	}
-	genlmsg_end(skb, dh);
-	err = 0;
+	cb->args[1] = minor;
+	cb->args[2] = (long)peer_device;
 
 out:
 	rcu_read_unlock();
@@ -3802,461 +6775,241 @@ int drbd_nl_get_peer_devices_dumpit(struct sk_buff *skb, struct netlink_callback
 		return err;
 	return skb->len;
 }
-/*
- * Return the connection of @resource if @resource has exactly one connection.
- */
-static struct drbd_connection *the_only_connection(struct drbd_resource *resource)
-{
-	struct list_head *connections = &resource->connections;
-
-	if (list_empty(connections) || connections->next->next != connections)
-		return NULL;
-	return list_first_entry(&resource->connections, struct drbd_connection, connections);
-}
-
-static int nla_put_status_info(struct sk_buff *skb, struct drbd_device *device,
-		const struct sib_info *sib)
-{
-	struct drbd_resource *resource = device->resource;
-	struct state_info *si = NULL; /* for sizeof(si->member); */
-	struct nlattr *nla;
-	int got_ldev;
-	int err = 0;
-	int exclude_sensitive;
-
-	/* If sib != NULL, this is drbd_bcast_event, which anyone can listen
-	 * to.  So we better exclude_sensitive information.
-	 *
-	 * If sib == NULL, this is drbd_nl_get_status_doit, executed synchronously
-	 * in the context of the requesting user process. Exclude sensitive
-	 * information, unless current has superuser.
-	 *
-	 * NOTE: for drbd_nl_get_status_dumpit(), this is a netlink dump, and
-	 * relies on the current implementation of netlink_dump(), which
-	 * executes the dump callback successively from netlink_recvmsg(),
-	 * always in the context of the receiving process */
-	exclude_sensitive = sib || !capable(CAP_SYS_ADMIN);
-
-	got_ldev = get_ldev(device);
-
-	/* We need to add connection name and volume number information still.
-	 * Minor number is in drbd_genlmsghdr. */
-	if (nla_put_drbd_cfg_context(skb, resource, the_only_connection(resource), device))
-		goto nla_put_failure;
-
-	if (res_opts_to_skb(skb, &device->resource->res_opts))
-		goto nla_put_failure;
-
-	rcu_read_lock();
-	if (got_ldev) {
-		struct disk_conf *disk_conf;
-
-		disk_conf = rcu_dereference(device->ldev->disk_conf);
-		err = disk_conf_to_skb(skb, disk_conf);
-	}
-	if (!err) {
-		struct net_conf *nc;
-
-		nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
-		if (nc)
-			err = net_conf_to_skb_sanitized(skb, nc, exclude_sensitive);
-	}
-	rcu_read_unlock();
-	if (err)
-		goto nla_put_failure;
-
-	nla = nla_nest_start_noflag(skb, DRBD_NLA_STATE_INFO);
-	if (!nla)
-		goto nla_put_failure;
-	if (nla_put_u32(skb, DRBD_A_STATE_INFO_SIB_REASON,
-		       sib ? sib->sib_reason : SIB_GET_STATUS_REPLY) ||
-	    nla_put_u32(skb, DRBD_A_STATE_INFO_CURRENT_STATE,
-		       device->state.i) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_ED_UUID,
-			     device->ed_uuid, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_CAPACITY,
-			     get_capacity(device->vdisk), 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_SEND_CNT,
-			     device->send_cnt, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_RECV_CNT,
-			     device->recv_cnt, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_READ_CNT,
-			     device->read_cnt, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_WRIT_CNT,
-			     device->writ_cnt, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_AL_WRIT_CNT,
-			     device->al_writ_cnt, 0) ||
-	    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_BM_WRIT_CNT,
-			     device->bm_writ_cnt, 0) ||
-	    nla_put_u32(skb, DRBD_A_STATE_INFO_AP_BIO_CNT,
-		       atomic_read(&device->ap_bio_cnt)) ||
-	    nla_put_u32(skb, DRBD_A_STATE_INFO_AP_PENDING_CNT,
-		       atomic_read(&device->ap_pending_cnt)) ||
-	    nla_put_u32(skb, DRBD_A_STATE_INFO_RS_PENDING_CNT,
-		       atomic_read(&device->rs_pending_cnt)))
-		goto nla_put_failure;
-
-	if (got_ldev) {
-		int err;
-
-		spin_lock_irq(&device->ldev->md.uuid_lock);
-		err = nla_put(skb, DRBD_A_STATE_INFO_UUIDS,
-			     sizeof(si->uuids),
-			     device->ldev->md.uuid);
-		spin_unlock_irq(&device->ldev->md.uuid_lock);
-
-		if (err)
-			goto nla_put_failure;
-
-		if (nla_put_u32(skb, DRBD_A_STATE_INFO_DISK_FLAGS, device->ldev->md.flags) ||
-		    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_BITS_TOTAL, drbd_bm_bits(device), 0) ||
-		    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_BITS_OOS,
-				      drbd_bm_total_weight(device), 0))
-			goto nla_put_failure;
-		if (C_SYNC_SOURCE <= device->state.conn &&
-		    C_PAUSED_SYNC_T >= device->state.conn) {
-			if (nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_BITS_RS_TOTAL,
-					      device->rs_total, 0) ||
-			    nla_put_u64_64bit(skb, DRBD_A_STATE_INFO_BITS_RS_FAILED,
-					      device->rs_failed, 0))
-				goto nla_put_failure;
-		}
-	}
-
-	if (sib) {
-		switch(sib->sib_reason) {
-		case SIB_SYNC_PROGRESS:
-		case SIB_GET_STATUS_REPLY:
-			break;
-		case SIB_STATE_CHANGE:
-			if (nla_put_u32(skb, DRBD_A_STATE_INFO_PREV_STATE, sib->os.i) ||
-			    nla_put_u32(skb, DRBD_A_STATE_INFO_NEW_STATE, sib->ns.i))
-				goto nla_put_failure;
-			break;
-		case SIB_HELPER_POST:
-			if (nla_put_u32(skb, DRBD_A_STATE_INFO_HELPER_EXIT_CODE,
-					sib->helper_exit_code))
-				goto nla_put_failure;
-			fallthrough;
-		case SIB_HELPER_PRE:
-			if (nla_put_string(skb, DRBD_A_STATE_INFO_HELPER, sib->helper_name))
-				goto nla_put_failure;
-			break;
-		}
-	}
-	nla_nest_end(skb, nla);
-
-	if (0)
-nla_put_failure:
-		err = -EMSGSIZE;
-	if (got_ldev)
-		put_ldev(device);
-	return err;
-}
 
-int drbd_nl_get_status_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_dump_paths_done(struct netlink_callback *cb)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
-	int err;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
-
-	err = nla_put_status_info(adm_ctx->reply_skb, adm_ctx->device, NULL);
-	if (err) {
-		nlmsg_free(adm_ctx->reply_skb);
-		adm_ctx->reply_skb = NULL;
-		return err;
-	}
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
+	return put_resource_in_arg0(cb, 10);
 }
 
-static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_dump_paths(struct sk_buff *skb, struct netlink_callback *cb,
+		    const struct drbd_nl_dialect *dialect)
 {
-	struct drbd_device *device;
-	struct drbd_genlmsghdr *dh;
-	struct drbd_resource *pos = (struct drbd_resource *)cb->args[0];
-	struct drbd_resource *resource = NULL;
-	struct drbd_resource *tmp;
-	unsigned volume = cb->args[1];
-
-	/* Open coded, deferred, iteration:
-	 * for_each_resource_safe(resource, tmp, &drbd_resources) {
-	 *      connection = "first connection of resource or undefined";
-	 *	idr_for_each_entry(&resource->devices, device, i) {
-	 *	  ...
-	 *	}
-	 * }
-	 * where resource is cb->args[0];
-	 * and i is cb->args[1];
-	 *
-	 * cb->args[2] indicates if we shall loop over all resources,
-	 * or just dump all volumes of a single resource.
-	 *
-	 * This may miss entries inserted after this dump started,
-	 * or entries deleted before they are reached.
-	 *
-	 * We need to make sure the device won't disappear while
-	 * we are looking at it, and revalidate our iterators
-	 * on each iteration.
-	 */
+	struct drbd_resource *resource = NULL, *next_resource;
+	struct drbd_connection *connection = NULL;
+	struct drbd_path *path = NULL;
+	struct drbd_nl_path_info path_info;
+	int err = 0;
 
-	/* synchronize with conn_create()/drbd_destroy_connection() */
 	rcu_read_lock();
-	/* revalidate iterator position */
-	for_each_resource_rcu(tmp, &drbd_resources) {
-		if (pos == NULL) {
-			/* first iteration */
-			pos = tmp;
-			resource = pos;
-			break;
-		}
-		if (tmp == pos) {
-			resource = pos;
-			break;
-		}
+	resource = (struct drbd_resource *)cb->args[0];
+	if (!resource) {
+		if (list_empty(&drbd_resources))
+			goto out;
+		resource = list_first_entry(&drbd_resources, struct drbd_resource, resources);
+		kref_get(&resource->kref);
+		cb->args[0] = (long)resource;
+		cb->args[1] = DRBD_DUMP_ITERATE_RESOURCES;
 	}
-	if (resource) {
+
 next_resource:
-		device = idr_get_next(&resource->devices, &volume);
-		if (!device) {
-			/* No more volumes to dump on this resource.
-			 * Advance resource iterator. */
-			pos = list_entry_rcu(resource->resources.next,
-					     struct drbd_resource, resources);
-			/* Did we dump any volume of this resource yet? */
-			if (volume != 0) {
-				/* If we reached the end of the list,
-				 * or only a single resource dump was requested,
-				 * we are done. */
-				if (&pos->resources == &drbd_resources || cb->args[2])
-					goto out;
-				volume = 0;
-				resource = pos;
-				goto next_resource;
-			}
+	rcu_read_unlock();
+	mutex_lock(&resource->conf_update);
+	rcu_read_lock();
+	if (cb->args[2]) {
+		for_each_connection_rcu(connection, resource) {
+			list_for_each_entry_rcu(path, &connection->transport.paths, list)
+				if (path == (struct drbd_path *)cb->args[2])
+					goto found_path;
 		}
+		/* path was probably deleted */
+		goto no_more_paths;
+	}
 
-		dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq, &drbd_nl_family,
-				NLM_F_MULTI, DRBD_ADM_GET_STATUS);
-		if (!dh)
-			goto out;
-
-		if (!device) {
-			/* This is a connection without a single volume.
-			 * Suprisingly enough, it may have a network
-			 * configuration. */
-			struct drbd_connection *connection;
+	connection = first_connection(resource);
+	if (!connection)
+		goto no_more_paths;
 
-			dh->minor = -1U;
-			dh->ret_code = NO_ERROR;
-			connection = the_only_connection(resource);
-			if (nla_put_drbd_cfg_context(skb, resource, connection, NULL))
-				goto cancel;
-			if (connection) {
-				struct net_conf *nc;
-
-				nc = rcu_dereference(connection->net_conf);
-				if (nc && net_conf_to_skb_sanitized(skb, nc, true) != 0)
-					goto cancel;
-			}
-			goto done;
-		}
+	path = list_entry(&connection->transport.paths, struct drbd_path, list);
 
-		D_ASSERT(device, device->vnr == volume);
-		D_ASSERT(device, device->resource == resource);
+found_path:
+	/* Advance to next path in connection. */
+	list_for_each_entry_continue_rcu(path, &connection->transport.paths, list) {
+		goto put_result;  /* only one iteration */
+	}
 
-		dh->minor = device_to_minor(device);
-		dh->ret_code = NO_ERROR;
+	/* Advance to next connection. */
+	list_for_each_entry_continue_rcu(connection, &resource->connections, connections) {
+		path = first_path(connection);
+		if (!path)
+			continue;
+		goto put_result;
+	}
 
-		if (nla_put_status_info(skb, device, NULL)) {
-cancel:
-			genlmsg_cancel(skb, dh);
-			goto out;
+no_more_paths:
+	if (cb->args[1] == DRBD_DUMP_ITERATE_RESOURCES) {
+		for_each_resource_rcu(next_resource, &drbd_resources) {
+			if (next_resource == resource)
+				goto found_resource;
 		}
-done:
-		genlmsg_end(skb, dh);
+		/* resource was probably deleted */
+	}
+	goto out;
+
+found_resource:
+	list_for_each_entry_continue_rcu(next_resource, &drbd_resources, resources) {
+		mutex_unlock(&resource->conf_update);
+		kref_put(&resource->kref, drbd_destroy_resource);
+		resource = next_resource;
+		kref_get(&resource->kref);
+		cb->args[0] = (long)resource;
+		cb->args[2] = 0;
+		goto next_resource;
 	}
+	goto out;  /* no more resources */
+
+put_result:
+	path_info.path_established = test_bit(TR_ESTABLISHED, &path->flags);
+	err = dialect->emit_path(skb, cb, NO_ERROR, resource, connection, path, &path_info);
+	if (err)
+		goto out;
+	cb->args[2] = (long)path;
 
 out:
 	rcu_read_unlock();
-	/* where to start the next iteration */
-	cb->args[0] = (long)pos;
-	cb->args[1] = (pos == resource) ? volume + 1 : 0;
-
-	/* No more resources/volumes/minors found results in an empty skb.
-	 * Which will terminate the dump. */
-        return skb->len;
+	if (resource)
+		mutex_unlock(&resource->conf_update);
+	if (err)
+		return err;
+	return skb->len;
 }
 
-/*
- * Request status of all resources, or of all volumes within a single resource.
- *
- * This is a dump, as the answer may not fit in a single reply skb otherwise.
- * Which means we cannot use the family->attrbuf or other such members, because
- * dump is NOT protected by the genl_lock().  During dump, we only have access
- * to the incoming skb, and need to opencode "parsing" of the nlattr payload.
- *
- * Once things are setup properly, we call into get_one_status().
- */
-int drbd_nl_get_status_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_adm_get_timeout_type(struct drbd_adm_ctx *adm_ctx)
 {
-	const unsigned int hdrlen = GENL_HDRLEN + sizeof(struct drbd_genlmsghdr);
-	struct nlattr *nla;
-	const char *resource_name;
-	struct drbd_resource *resource;
-
-	/* Is this a followup call? */
-	if (cb->args[0]) {
-		/* ... of a single resource dump,
-		 * and the resource iterator has been advanced already? */
-		if (cb->args[2] && cb->args[2] != cb->args[0])
-			return 0; /* DONE. */
-		goto dump;
-	}
-
-	/* First call (from netlink_dump_start).  We need to figure out
-	 * which resource(s) the user wants us to dump. */
-	nla = nla_find(nlmsg_attrdata(cb->nlh, hdrlen),
-			nlmsg_attrlen(cb->nlh, hdrlen),
-			DRBD_NLA_CFG_CONTEXT);
-
-	/* No explicit context given.  Dump all. */
-	if (!nla)
-		goto dump;
-	nla = nla_find_nested(nla, DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME);
-	/* context given, but no name present? */
-	if (!nla)
-		return -EINVAL;
-	resource_name = nla_data(nla);
-	if (!*resource_name)
-		return -ENODEV;
-	resource = drbd_find_resource(resource_name);
-	if (!resource)
-		return -ENODEV;
+	struct drbd_peer_device *peer_device;
+	enum drbd_timeout_flag timeout_type;
 
-	kref_put(&resource->kref, drbd_destroy_resource); /* get_one_status() revalidates the resource */
+	peer_device = adm_ctx->peer_device;
 
-	/* prime iterators, and set "filter" mode mark:
-	 * only dump this connection. */
-	cb->args[0] = (long)resource;
-	/* cb->args[1] = 0; passed in this way. */
-	cb->args[2] = (long)resource;
+	timeout_type =
+		peer_device->disk_state[NOW] == D_OUTDATED ? UT_PEER_OUTDATED :
+		test_bit(USE_DEGR_WFC_T, peer_device->flags) ? UT_DEGRADED :
+		UT_DEFAULT;
 
-dump:
-	return get_one_status(skb, cb);
+	adm_ctx->result = adm_ctx->d->put_timeout_type(adm_ctx, timeout_type);
+	return 0;
 }
 
-int drbd_nl_get_timeout_type_doit(struct sk_buff *skb, struct genl_info *info)
+static enum drbd_ret_code check_verify_alg_matches_peer(struct drbd_peer_device *peer_device,
+							struct drbd_adm_ctx *ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
-	struct timeout_parms tp;
-	int err;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
-
-	tp.timeout_type =
-		adm_ctx->device->state.pdsk == D_OUTDATED ? UT_PEER_OUTDATED :
-		test_bit(USE_DEGR_WFC_T, &adm_ctx->device->flags) ? UT_DEGRADED :
-		UT_DEFAULT;
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_resource *resource = connection->resource;
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_net_conf *nc;
 
-	err = timeout_parms_to_skb(adm_ctx->reply_skb, &tp);
-	if (err) {
-		nlmsg_free(adm_ctx->reply_skb);
-		adm_ctx->reply_skb = NULL;
-		return err;
-	}
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
-	return 0;
+	mutex_lock(&resource->conf_update);
+	nc = connection->transport.net_conf;
+	if (connection->agreed_pro_version >= 88 &&
+	    peer_device->repl_state[NOW] >= L_ESTABLISHED &&
+	    nc && nc->verify_alg[0] &&
+	    strcmp(nc->verify_alg, connection->peer_verify_alg)) {
+		drbd_adm_msg(ctx,
+			"Online verify refused: local verify-alg \"%s\" differs from peer verify-alg \"%s\"",
+			nc->verify_alg, connection->peer_verify_alg);
+		retcode = ERR_VERIFY_ALG;
+	}
+	mutex_unlock(&resource->conf_update);
+
+	return retcode;
 }
 
-int drbd_nl_start_ov_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_start_ov(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
 	struct drbd_device *device;
-	enum drbd_ret_code retcode;
-	struct start_ov_parms parms;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	struct drbd_peer_device *peer_device;
+	enum drbd_ret_code retcode = NO_ERROR;
+	enum drbd_state_rv rv;
+	struct drbd_start_ov_parms parms;
 
-	device = adm_ctx->device;
+	peer_device = adm_ctx->peer_device;
+	device = peer_device->device;
 
 	/* resume from last known position, if possible */
-	parms.ov_start_sector = device->ov_start_sector;
+	parms.ov_start_sector = peer_device->ov_start_sector;
 	parms.ov_stop_sector = ULLONG_MAX;
-	if (info->attrs[DRBD_NLA_START_OV_PARMS]) {
-		int err = start_ov_parms_from_attrs(&parms, info);
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_START_OV_PARMS)) {
+		int err = drbd_adm_overlay_start_ov_parms(adm_ctx, &parms);
+
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+			drbd_adm_msg_overlay_error(adm_ctx, err);
 			goto out;
 		}
 	}
-	mutex_lock(&adm_ctx->resource->adm_mutex);
+	if (!get_ldev(device)) {
+		retcode = ERR_NO_DISK;
+		goto out;
+	}
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_put_ldev;
+	}
+
+	retcode = check_verify_alg_matches_peer(peer_device, adm_ctx);
+	if (retcode != NO_ERROR) {
+		mutex_unlock(&adm_ctx->resource->adm_mutex);
+		goto out_put_ldev;
+	}
 
 	/* w_make_ov_request expects position to be aligned */
-	device->ov_start_sector = parms.ov_start_sector & ~(BM_SECT_PER_BIT-1);
-	device->ov_stop_sector = parms.ov_stop_sector;
+	peer_device->ov_start_sector = parms.ov_start_sector & ~(bm_sect_per_bit(device->bitmap)-1);
+	peer_device->ov_stop_sector = parms.ov_stop_sector;
 
 	/* If there is still bitmap IO pending, e.g. previous resync or verify
 	 * just being finished, wait for it before requesting a new resync. */
-	drbd_suspend_io(device);
-	wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
-	retcode = drbd_request_state(device, NS(conn, C_VERIFY_S));
+	drbd_suspend_io(device, READ_AND_WRITE);
+	wait_event(device->misc_wait, !atomic_read(&device->pending_bitmap_work.n));
+	rv = stable_change_repl_state(peer_device,
+		L_VERIFY_S, CS_VERBOSE | CS_WAIT_COMPLETE | CS_SERIALIZE, "verify");
 	drbd_resume_io(device);
 
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
+	put_ldev(device);
+	adm_ctx->result = rv;
+	return 0;
+
+out_put_ldev:
+	put_ldev(device);
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
+static bool should_skip_initial_sync(struct drbd_peer_device *peer_device)
+{
+	return peer_device->repl_state[NOW] == L_ESTABLISHED &&
+	       peer_device->connection->agreed_pro_version >= 90 &&
+	       drbd_current_uuid(peer_device->device) == UUID_JUST_CREATED;
+}
 
-int drbd_nl_new_c_uuid_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_new_c_uuid(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
 	struct drbd_device *device;
-	enum drbd_ret_code retcode;
-	int skip_initial_sync = 0;
+	struct drbd_peer_device *peer_device;
+	enum drbd_ret_code retcode = NO_ERROR;
 	int err;
-	struct new_c_uuid_parms args;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out_nolock;
+	struct drbd_new_c_uuid_parms args;
+	u64 nodes = 0, diskful = 0;
 
 	device = adm_ctx->device;
 	memset(&args, 0, sizeof(args));
-	if (info->attrs[DRBD_NLA_NEW_C_UUID_PARMS]) {
-		err = new_c_uuid_parms_from_attrs(&args, info);
+	if (adm_ctx->d->has_set(adm_ctx, DRBD_NL_SET_NEW_C_UUID_PARMS)) {
+		err = drbd_adm_overlay_new_c_uuid_parms(adm_ctx, &args);
 		if (err) {
 			retcode = ERR_MANDATORY_TAG;
-			drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
-			goto out_nolock;
+			drbd_adm_msg_overlay_error(adm_ctx, err);
+			goto out_no_adm_mutex;
 		}
 	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	mutex_lock(device->state_mutex); /* Protects us against serialized state changes. */
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+	if (down_interruptible(&device->resource->state_sem)) {
+		retcode = ERR_INTR;
+		goto out_no_state_sem;
+	}
 
 	if (!get_ldev(device)) {
 		retcode = ERR_NO_DISK;
@@ -4264,194 +7017,419 @@ int drbd_nl_new_c_uuid_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* this is "skip initial sync", assume to be clean */
-	if (device->state.conn == C_CONNECTED &&
-	    first_peer_device(device)->connection->agreed_pro_version >= 90 &&
-	    device->ldev->md.uuid[UI_CURRENT] == UUID_JUST_CREATED && args.clear_bm) {
-		drbd_info(device, "Preparing to skip initial sync\n");
-		skip_initial_sync = 1;
-	} else if (device->state.conn != C_STANDALONE) {
-		retcode = ERR_CONNECTED;
-		goto out_dec;
+	for_each_peer_device(peer_device, device) {
+		if ((args.clear_bm || args.force_resync) && should_skip_initial_sync(peer_device)) {
+			if (peer_device->disk_state[NOW] >= D_INCONSISTENT) {
+				drbd_info(peer_device, "Preparing to %s initial sync\n",
+					  args.clear_bm ? "skip" : "force");
+				diskful |= NODE_MASK(peer_device->node_id);
+			}
+			nodes |= NODE_MASK(peer_device->node_id);
+		} else if (peer_device->repl_state[NOW] != L_OFF) {
+			retcode = ERR_CONNECTED;
+			goto out_dec;
+		}
 	}
 
-	drbd_uuid_set(device, UI_BITMAP, 0); /* Rotate UI_BITMAP to History 1, etc... */
-	drbd_uuid_new_current(device); /* New current, previous to UI_BITMAP */
+	/* gen-rotate reason: OTHER (admin new-current-uuid) */
+	drbd_uuid_new_current_by_user(device); /* New current, previous to UI_BITMAP */
+
+	if (args.force_resync) {
+		unsigned long irq_flags;
+
+		begin_state_change(device->resource, &irq_flags, CS_VERBOSE);
+		__change_disk_state(device, D_UP_TO_DATE);
+		end_state_change(device->resource, &irq_flags, "new-c-uuid");
+
+		for_each_peer_device(peer_device, device) {
+			if (NODE_MASK(peer_device->node_id) & nodes) {
+				if (NODE_MASK(peer_device->node_id) & diskful) {
+					drbd_info(peer_device, "Forcing resync");
+					set_bit(CONSIDER_RESYNC, peer_device->flags);
+					drbd_send_uuids(peer_device, UUID_FLAG_RESYNC, 0);
+					drbd_send_current_state(peer_device);
+				} else {
+					drbd_send_uuids(peer_device, 0, 0);
+				}
+
+				drbd_print_uuids(peer_device, "forced resync UUID");
+			}
+		}
+	}
 
 	if (args.clear_bm) {
-		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
-			"clear_n_write from new_c_uuid", BM_LOCKED_MASK, NULL);
+		unsigned long irq_flags;
+
+		err = drbd_bitmap_io(device, &drbd_bmio_clear_all_n_write,
+			"clear_n_write from new_c_uuid", BM_LOCK_ALL, NULL);
 		if (err) {
 			drbd_err(device, "Writing bitmap failed with %d\n", err);
 			retcode = ERR_IO_MD_DISK;
 		}
-		if (skip_initial_sync) {
-			drbd_send_uuids_skip_initial_sync(first_peer_device(device));
-			_drbd_uuid_set(device, UI_BITMAP, 0);
-			drbd_print_uuids(device, "cleared bitmap UUID");
-			spin_lock_irq(&device->resource->req_lock);
-			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
-					CS_VERBOSE, NULL);
-			spin_unlock_irq(&device->resource->req_lock);
+		for_each_peer_device(peer_device, device) {
+			if (NODE_MASK(peer_device->node_id) & nodes) {
+				_drbd_uuid_set_bitmap(peer_device, 0);
+				drbd_send_uuids(peer_device, UUID_FLAG_SKIP_INITIAL_SYNC, 0);
+				/* The peer adopts our new UUID but does not send its
+				 * UUID back, so update our cached record here to
+				 * avoid a stale mismatch in sanitize_state().
+				 */
+				peer_device->current_uuid = drbd_current_uuid(device);
+				drbd_print_uuids(peer_device, "cleared bitmap UUID");
+			}
+		}
+		begin_state_change(device->resource, &irq_flags, CS_VERBOSE);
+		__change_disk_state(device, D_UP_TO_DATE);
+		for_each_peer_device(peer_device, device) {
+			if (NODE_MASK(peer_device->node_id) & diskful)
+				__change_peer_disk_state(peer_device, D_UP_TO_DATE);
 		}
+		end_state_change(device->resource, &irq_flags, "new-c-uuid");
 	}
 
-	drbd_md_sync(device);
+	drbd_md_sync_if_dirty(device);
 out_dec:
 	put_ldev(device);
 out:
-	mutex_unlock(device->state_mutex);
+	up(&device->resource->state_sem);
+out_no_state_sem:
 	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out_nolock:
-	adm_ctx->reply_dh->ret_code = retcode;
+out_no_adm_mutex:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-static enum drbd_ret_code
-drbd_check_resource_name(struct drbd_config_context *adm_ctx)
+/* name: a resource or connection name
+ * Comes from a NLA_NUL_STRING, and already passed validate_nla().
+ * It is known to be NUL-terminated within the bounds of our defined netlink
+ * attribute policy.
+ *
+ * It must not be empty.
+ * It must not be the literal "all".
+ *
+ * If strict:
+ * Only allow strict ascii alnum [0-9A-Za-z]
+ * and some hand selected punctuation characters
+ *
+ * If non strict:
+ * It must not contain '/', we use it as directory name in debugfs.
+ * It shall not contain "control characters" or space, as those may confuse
+ * utils when trying to parse the output of "drbdsetup events2" or similar.
+ * Otherwise, we don't care, it may be any tag that makes sense to userland,
+ * we do not enforce strict ascii or any other "encoding".
+ */
+static enum drbd_ret_code drbd_check_name_str(const char *name, const bool strict)
 {
-	const char *name = adm_ctx->resource_name;
-	if (!name || !name[0]) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "resource name missing");
+	unsigned char c;
+
+	if (name == NULL || name[0] == 0)
 		return ERR_MANDATORY_TAG;
-	}
-	/* if we want to use these in sysfs/configfs/debugfs some day,
-	 * we must not allow slashes */
-	if (strchr(name, '/')) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "invalid resource name");
+
+	/* Tools reserve the literal "all" to mean what you would expect. */
+	/* If we want to get really paranoid,
+	 * we could add a number of "reserved" names,
+	 * like the *_state_names defined in drbd_strings.c */
+	if (memcmp("all", name, 4) == 0)
 		return ERR_INVALID_REQUEST;
+
+	while ((c = *name++)) {
+		if (c == '/' || c <= ' ' || c == '\x7f')
+			return ERR_INVALID_REQUEST;
+		if (strict) {
+			switch (c) {
+			case '0' ... '9':
+			case 'A' ... 'Z':
+			case 'a' ... 'z':
+				/* if you change this, also change "strict_pattern" below */
+			case '+': case '-': case '.': case '_':
+				break;
+			default:
+				return ERR_INVALID_REQUEST;
+			}
+		}
 	}
 	return NO_ERROR;
 }
 
-static void resource_to_info(struct resource_info *info,
+int param_set_drbd_strict_names(const char *val, const struct kernel_param *kp)
+{
+	int err = 0;
+	bool new_value;
+	bool orig_value = *(bool *)kp->arg;
+	struct kernel_param dummy_kp = *kp;
+
+	dummy_kp.arg = &new_value;
+
+	err = param_set_bool(val, &dummy_kp);
+	if (err || new_value == orig_value)
+		return err;
+
+	if (new_value) {
+		struct drbd_resource *resource;
+		struct drbd_connection *connection;
+		int non_strict_cnt = 0;
+
+		/* If we transition from "not enforced" to "enforcing strict names",
+		 * we complain about all "non-strict names" that still exist,
+		 * but intentionally still enable the enforcing.
+		 *
+		 * That way we can prevent new "non-strict" from being created,
+		 * while allowing us to clean up the existing ones at some
+		 * "convenient time" later.
+		 */
+		rcu_read_lock();
+		for_each_resource_rcu(resource, &drbd_resources) {
+			for_each_connection_rcu(connection, resource) {
+				char *name = connection->transport.net_conf->name;
+
+				if (drbd_check_name_str(name, true) == NO_ERROR)
+					continue;
+				drbd_info(connection, "non-strict name still in use\n");
+				++non_strict_cnt;
+			}
+			if (drbd_check_name_str(resource->name, true) == NO_ERROR)
+				continue;
+			drbd_info(resource, "non-strict name still in use\n");
+			++non_strict_cnt;
+		}
+		rcu_read_unlock();
+		if (non_strict_cnt)
+			pr_notice("%u non-strict names still in use\n", non_strict_cnt);
+	}
+	if (!err) {
+		*(bool *)kp->arg = new_value;
+		pr_info("%s strict name checks\n", new_value ? "enabled" : "disabled");
+	}
+	return err;
+}
+
+static void drbd_msg_put_name_error(struct drbd_adm_ctx *ctx, enum drbd_ret_code ret_code)
+{
+	char *strict_pattern = " (strict_names=1 allows only [0-9A-Za-z+._-])";
+	char *non_strict_pat = " (disallowed: ascii control, space, slash)";
+
+	if (ret_code == NO_ERROR)
+		return;
+	if (ret_code == ERR_INVALID_REQUEST) {
+		drbd_adm_msg(ctx, "invalid name%s",
+			drbd_strict_names ? strict_pattern : non_strict_pat);
+	} else if (ret_code == ERR_MANDATORY_TAG) {
+		drbd_adm_msg(ctx, "%s", "name missing");
+	} else if (ret_code == ERR_ALREADY_EXISTS) {
+		drbd_adm_msg(ctx, "%s", "name already exists");
+	} else {
+		drbd_adm_msg(ctx, "%s", "unhandled error in drbd_check_name_str");
+	}
+}
+
+static enum drbd_ret_code drbd_check_resource_name(struct drbd_adm_ctx *const adm_ctx)
+{
+	enum drbd_ret_code ret_code = drbd_check_name_str(adm_ctx->resource_name, drbd_strict_names);
+
+	drbd_msg_put_name_error(adm_ctx, ret_code);
+	return ret_code;
+}
+
+static void resource_to_info(struct drbd_resource_info *info,
 			     struct drbd_resource *resource)
 {
-	info->res_role = conn_highest_role(first_connection(resource));
-	info->res_susp = resource->susp;
-	info->res_susp_nod = resource->susp_nod;
-	info->res_susp_fen = resource->susp_fen;
+	info->res_role = resource->role[NOW];
+	info->res_susp = resource->susp_user[NOW];
+	info->res_susp_nod = resource->susp_nod[NOW];
+	info->res_susp_fen = is_suspended_fen(resource, NOW);
+	info->res_susp_quorum = resource->susp_quorum[NOW];
+	info->res_fail_io = resource->fail_io[NOW];
+#ifdef CONFIG_DRBD_COMPAT_84
+	/*
+	 * This snapshot has no "before" state of its own (unlike
+	 * notify_resource_state_change()'s state_change-derived one, drbd_
+	 * state.c) -- every caller of this function reports the live state
+	 * as either a fresh object or an out-of-band status reply, not a
+	 * transition. old == new here so a v1 dialect fused event, if one
+	 * is ever built from this snapshot, reports no change and
+	 * compat84_event_flush() skips it rather than printing a
+	 * fabricated transition. Combines susp_user/susp_quorum/susp_uuid
+	 * the same way drbd_get_resource_state()'s own .susp does, since
+	 * res_susp above is susp_user alone.
+	 */
+	info->old_res_role = info->res_role;
+	info->old_res_susp = resource->susp_user[NOW] || resource->susp_quorum[NOW] ||
+		resource->susp_uuid[NOW];
+	info->old_res_susp_nod = info->res_susp_nod;
+	info->old_res_susp_fen = info->res_susp_fen;
+#endif
 }
 
-int drbd_nl_new_resource_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_new_resource(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_connection *connection;
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
-	struct res_opts res_opts;
+	struct drbd_resource *resource;
+	enum drbd_ret_code retcode = NO_ERROR;
+	struct drbd_res_opts res_opts;
 	int err;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	mutex_lock(&resources_mutex);
 
-	set_res_opts_defaults(&res_opts);
-	err = res_opts_from_attrs(&res_opts, info);
-	if (err && err != -ENOMSG) {
+	drbd_set_res_opts_defaults(&res_opts);
+	res_opts.node_id = -1;
+	err = drbd_adm_overlay_res_opts(adm_ctx, &res_opts);
+	/*
+	 * -ENOMSG here means the whole RESOURCE_OPTS container was absent
+	 * from the request. Only the v1 (8.4) dialect's plain "new-resource"
+	 * legitimately does that: an 8.4 resource has no node id to send, so
+	 * force_drbd8_compat (set only by the v1 adapter) is the signal that
+	 * this is such a request. Legacy and drbd2 both require RESOURCE_OPTS
+	 * with a node id and must keep rejecting its absence exactly as
+	 * before, so the tolerance is conditional on force_drbd8_compat
+	 * rather than blanket: res_opts.node_id is seeded to the sentinel -1
+	 * just above, which happens to wrap to UINT_MAX (node_id is __u32)
+	 * and so still trips the node_id >= DRBD_NODE_ID_MAX check below for
+	 * legacy/drbd2 even without this guard -- but that is an incidental
+	 * property of the field's type, not a designed guarantee, and must
+	 * not be the only thing standing between an unset node id and a
+	 * created resource.
+	 */
+	if (err && !(err == -ENOMSG && adm_ctx->force_drbd8_compat)) {
 		retcode = ERR_MANDATORY_TAG;
-		drbd_msg_put_info(adm_ctx->reply_skb, from_attrs_err_to_txt(err));
+		drbd_adm_msg_overlay_error(adm_ctx, err);
 		goto out;
 	}
 
+	/* ERR_ALREADY_EXISTS? */
+	if (adm_ctx->resource)
+		goto out;
+
 	retcode = drbd_check_resource_name(adm_ctx);
 	if (retcode != NO_ERROR)
 		goto out;
 
-	if (adm_ctx->resource) {
-		if (info->nlhdr->nlmsg_flags & NLM_F_EXCL) {
-			retcode = ERR_INVALID_REQUEST;
-			drbd_msg_put_info(adm_ctx->reply_skb, "resource exists");
-		}
-		/* else: still NO_ERROR */
+	/*
+	 * Record it as explicit, too: drbd_adm_resource_opts() re-derives
+	 * drbd8_compat_mode from explicit_drbd8_compat once node_id is set.
+	 */
+	if (adm_ctx->force_drbd8_compat)
+		res_opts.explicit_drbd8_compat = true;
+	if (res_opts.explicit_drbd8_compat)
+		res_opts.drbd8_compat_mode = true;
+
+	if (res_opts.drbd8_compat_mode) {
+#ifdef CONFIG_DRBD_COMPAT_84
+		pr_info("drbd: running in DRBD 8 compatibility mode.\n");
+		/*
+		 * That means we ignore the value of node_id for now. That
+		 * will be set to an actual value when the resource is
+		 * connected later.
+		 */
+		atomic_inc(&nr_drbd8_devices);
+		res_opts.auto_promote = false;
+#else
+		drbd_adm_msg(adm_ctx, "%s", "CONFIG_DRBD_COMPAT_84 not enabled");
+		goto out;
+#endif
+	} else if (res_opts.node_id >= DRBD_NODE_ID_MAX) {
+		pr_err("drbd: invalid node id (%d)\n", res_opts.node_id);
+		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
 
-	/* not yet safe for genl_family.parallel_ops */
-	mutex_lock(&resources_mutex);
-	connection = conn_create(adm_ctx->resource_name, &res_opts);
+	if (!try_module_get(THIS_MODULE)) {
+		pr_err("drbd: Could not get a module reference\n");
+		retcode = ERR_INVALID_REQUEST;
+		goto out;
+	}
+
+	resource = drbd_create_resource(adm_ctx->resource_name, &res_opts);
 	mutex_unlock(&resources_mutex);
 
-	if (connection) {
-		struct resource_info resource_info;
+	if (resource) {
+		struct drbd_resource_info resource_info;
 
 		mutex_lock(&notification_mutex);
-		resource_to_info(&resource_info, connection->resource);
-		notify_resource_state(NULL, 0, connection->resource,
-				      &resource_info, NOTIFY_CREATE);
+		resource_to_info(&resource_info, resource);
+		notify_resource_state(NULL, 0, resource, &resource_info, NULL, NOTIFY_CREATE);
 		mutex_unlock(&notification_mutex);
-	} else
+	} else {
+		module_put(THIS_MODULE);
 		retcode = ERR_NOMEM;
-
+	}
+	goto out_no_unlock;
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	mutex_unlock(&resources_mutex);
+out_no_unlock:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-static void device_to_info(struct device_info *info,
-			   struct drbd_device *device)
-{
-	info->dev_disk_state = device->state.disk;
-}
-
-
-int drbd_nl_new_minor_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_new_minor(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct drbd_genlmsghdr *dh = genl_info_userhdr(info);
-	enum drbd_ret_code retcode;
+	struct drbd_device_conf device_conf;
+	struct drbd_resource *resource;
+	struct drbd_device *device;
+	enum drbd_ret_code retcode = NO_ERROR;
+	int err;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
+	drbd_set_device_conf_defaults(&device_conf);
+	err = drbd_adm_overlay_device_conf(adm_ctx, &device_conf);
+	if (err && err != -ENOMSG) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
 		goto out;
+	}
 
-	if (dh->minor > MINORMASK) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "requested minor out of range");
+	if (adm_ctx->minor > MINORMASK) {
+		drbd_adm_msg(adm_ctx, "%s", "requested minor out of range");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
 	if (adm_ctx->volume > DRBD_VOLUME_MAX) {
-		drbd_msg_put_info(adm_ctx->reply_skb, "requested volume id out of range");
+		drbd_adm_msg(adm_ctx, "%s", "requested volume id out of range");
 		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
-
-	/* drbd_adm_prepare made sure already
-	 * that first_peer_device(device)->connection and device->vnr match the request. */
-	if (adm_ctx->device) {
-		if (info->nlhdr->nlmsg_flags & NLM_F_EXCL)
-			retcode = ERR_MINOR_OR_VOLUME_EXISTS;
-		/* else: still NO_ERROR */
+	if (device_conf.block_size != 512 && device_conf.block_size != 1024 &&
+	    device_conf.block_size != 2048 && device_conf.block_size != 4096) {
+		drbd_adm_msg(adm_ctx, "%s", "block_size not 512, 1024, 2048, or 4096");
+		retcode = ERR_INVALID_REQUEST;
+		goto out;
+	}
+	if (device_conf.discard_granularity != DRBD_DISCARD_GRANULARITY_DEF &&
+	    device_conf.discard_granularity != 0 &&
+	    device_conf.discard_granularity % device_conf.block_size != 0) {
+		drbd_adm_msg(adm_ctx, "%s",
+			"discard_granularity must be 0 or a multiple of block_size");
+		retcode = ERR_INVALID_REQUEST;
 		goto out;
 	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	retcode = drbd_create_device(adm_ctx, dh->minor);
+	if (adm_ctx->device)
+		goto out;
+
+	resource = adm_ctx->resource;
+	mutex_lock(&resource->conf_update);
+	for (;;) {
+		retcode = drbd_create_device(adm_ctx, adm_ctx->minor, &device_conf, &device);
+		if (retcode != ERR_NOMEM ||
+		    schedule_timeout_interruptible(HZ / 10))
+			break;
+		/* Keep retrying until the memory allocations eventually succeed. */
+	}
 	if (retcode == NO_ERROR) {
-		struct drbd_device *device;
 		struct drbd_peer_device *peer_device;
-		struct device_info info;
+		struct drbd_device_info info;
 		unsigned int peer_devices = 0;
 		enum drbd_notification_type flags;
 
-		device = minor_to_device(dh->minor);
-		for_each_peer_device(peer_device, device) {
-			if (!has_net_conf(peer_device->connection))
-				continue;
+		drbd_reconsider_queue_parameters(device, NULL);
+
+		for_each_peer_device(peer_device, device)
 			peer_devices++;
-		}
 
 		device_to_info(&info, device);
 		mutex_lock(&notification_mutex);
 		flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
 		notify_device_state(NULL, 0, device, &info, NOTIFY_CREATE | flags);
 		for_each_peer_device(peer_device, device) {
-			struct peer_device_info peer_device_info;
+			struct drbd_peer_device_info peer_device_info;
 
-			if (!has_net_conf(peer_device->connection))
-				continue;
 			peer_device_to_info(&peer_device_info, peer_device);
 			flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
 			notify_peer_device_state(NULL, 0, peer_device, &peer_device_info,
@@ -4459,502 +7437,420 @@ int drbd_nl_new_minor_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 		mutex_unlock(&notification_mutex);
 	}
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
+	mutex_unlock(&resource->conf_update);
 out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
 static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 {
+	struct drbd_resource *resource = device->resource;
 	struct drbd_peer_device *peer_device;
+	enum drbd_ret_code ret;
+	u64 im;
+
+	read_lock_irq(&resource->state_rwlock);
+	if (device->disk_state[NOW] == D_DISKLESS)
+		ret = test_and_set_bit(UNREGISTERED, &device->flags) ? ERR_MINOR_INVALID : NO_ERROR;
+	else
+		ret = ERR_MINOR_CONFIGURED;
+	read_unlock_irq(&resource->state_rwlock);
 
-	if (device->state.disk == D_DISKLESS &&
-	    /* no need to be device->state.conn == C_STANDALONE &&
-	     * we may want to delete a minor from a live replication group.
-	     */
-	    device->state.role == R_SECONDARY) {
-		struct drbd_connection *connection =
-			first_connection(device->resource);
+	if (ret != NO_ERROR)
+		return ret;
 
-		_drbd_request_state(device, NS(conn, C_WF_REPORT_PARAMS),
-				    CS_VERBOSE + CS_WAIT_COMPLETE);
+	for_each_peer_device_ref(peer_device, im, device) {
+		enum drbd_state_rv rv;
 
-		/* If the state engine hasn't stopped the sender thread yet, we
-		 * need to flush the sender work queue before generating the
-		 * DESTROY events here. */
-		if (get_t_state(&connection->worker) == RUNNING)
-			drbd_flush_workqueue(&connection->sender_work);
+		rv = stable_change_repl_state(peer_device, L_OFF,
+					      CS_VERBOSE | CS_WAIT_COMPLETE, "del-minor");
+		if (rv < SS_SUCCESS)
+			drbd_err(peer_device,
+				 "Deleting the volume with replication not stopped (%s)\n",
+				 drbd_set_st_err_str(rv));
+	}
+
+	/* If drbd_ldev_destroy() is pending, wait for it to run before
+	 * unregistering the device. */
+	wait_event(device->misc_wait, !test_bit(GOING_DISKLESS, &device->flags));
+	/*
+	 * Flush the resource work queue to make sure that no more events like
+	 * state change notifications for this device are queued: we want the
+	 * "destroy" event to come last.
+	 */
+	drbd_flush_workqueue(&resource->work);
+
+	drbd_unregister_device(device);
+
+	mutex_lock(&notification_mutex);
+	for_each_peer_device_ref(peer_device, im, device)
+		notify_peer_device_state(NULL, 0, peer_device, NULL,
+					 NOTIFY_DESTROY | NOTIFY_CONTINUES);
+	notify_device_state(NULL, 0, device, NULL, NOTIFY_DESTROY);
+	mutex_unlock(&notification_mutex);
 
-		mutex_lock(&notification_mutex);
-		for_each_peer_device(peer_device, device) {
-			if (!has_net_conf(peer_device->connection))
-				continue;
-			notify_peer_device_state(NULL, 0, peer_device, NULL,
-						 NOTIFY_DESTROY | NOTIFY_CONTINUES);
-		}
-		notify_device_state(NULL, 0, device, NULL, NOTIFY_DESTROY);
-		mutex_unlock(&notification_mutex);
+	if (device->open_cnt == 0 && !test_and_set_bit(DESTROYING_DEV, &device->flags))
+		call_rcu(&device->rcu, drbd_reclaim_device);
 
-		set_bit(UNREGISTERED, &device->flags);
-		drbd_delete_device(device);
-		return NO_ERROR;
-	} else
-		return ERR_MINOR_CONFIGURED;
+	return ret;
 }
 
-int drbd_nl_del_minor_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_del_minor(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	enum drbd_ret_code retcode;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto out;
+	if (mutex_lock_interruptible(&adm_ctx->resource->adm_mutex)) {
+		retcode = ERR_INTR;
+	} else {
+		retcode = adm_del_minor(adm_ctx->device);
+		mutex_unlock(&adm_ctx->resource->adm_mutex);
+	}
 
-	mutex_lock(&adm_ctx->resource->adm_mutex);
-	retcode = adm_del_minor(adm_ctx->device);
-	mutex_unlock(&adm_ctx->resource->adm_mutex);
-out:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
 static int adm_del_resource(struct drbd_resource *resource)
 {
-	struct drbd_connection *connection;
-
-	for_each_connection(connection, resource) {
-		if (connection->cstate > C_STANDALONE)
-			return ERR_NET_CONFIGURED;
-	}
-	if (!idr_is_empty(&resource->devices))
-		return ERR_RES_IN_USE;
+	int err;
 
-	/* The state engine has stopped the sender thread, so we don't
-	 * need to flush the sender work queue before generating the
-	 * DESTROY event here. */
-	mutex_lock(&notification_mutex);
-	notify_resource_state(NULL, 0, resource, NULL, NOTIFY_DESTROY);
-	mutex_unlock(&notification_mutex);
+	/*
+	 * Flush the resource work queue to make sure that no more events like
+	 * state change notifications are queued: we want the "destroy" event
+	 * to come last.
+	 */
+	drbd_flush_workqueue(&resource->work);
 
 	mutex_lock(&resources_mutex);
+	err = ERR_RES_NOT_KNOWN;
+	if (test_bit(R_UNREGISTERED, &resource->flags))
+		goto out;
+	err = ERR_NET_CONFIGURED;
+	if (!list_empty(&resource->connections))
+		goto out;
+	err = ERR_RES_IN_USE;
+	if (!idr_is_empty(&resource->devices))
+		goto out;
+
 	set_bit(R_UNREGISTERED, &resource->flags);
 	list_del_rcu(&resource->resources);
+	drbd_debugfs_resource_cleanup(resource);
 	mutex_unlock(&resources_mutex);
-	/* Make sure all threads have actually stopped: state handling only
-	 * does drbd_thread_stop_nowait(). */
-	list_for_each_entry(connection, &resource->connections, connections)
-		drbd_thread_stop(&connection->worker);
-	synchronize_rcu();
-	drbd_free_resource(resource);
+
+	if (cancel_work_sync(&resource->empty_twopc)) {
+		kref_put(&resource->kref, drbd_destroy_resource);
+	}
+	if (cancel_work_sync(&resource->resume_twopc)) {
+		kref_put(&resource->kref, drbd_destroy_resource);
+	}
+	timer_shutdown_sync(&resource->twopc_timer);
+	timer_shutdown_sync(&resource->peer_ack_timer);
+	call_rcu(&resource->rcu, drbd_reclaim_resource);
+
+	mutex_lock(&notification_mutex);
+	notify_resource_state(NULL, 0, resource, NULL, NULL, NOTIFY_DESTROY);
+	mutex_unlock(&notification_mutex);
+
+	/* When the last resource was removed do an explicit synchronize RCU.
+	   Without this a immediately following rmmod would fail, since the
+	   resource's worker thread still has a reference count to the module. */
+	if (list_empty(&drbd_resources))
+		synchronize_rcu();
 	return NO_ERROR;
+out:
+	mutex_unlock(&resources_mutex);
+	return err;
 }
 
-int drbd_nl_down_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_down(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
-	unsigned i;
-
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
+	enum drbd_ret_code ret;
+	int i;
+	u64 im;
 
 	resource = adm_ctx->resource;
-	mutex_lock(&resource->adm_mutex);
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+	set_bit(DOWN_IN_PROGRESS, &resource->flags);
 	/* demote */
-	for_each_connection(connection, resource) {
-		struct drbd_peer_device *peer_device;
-
-		idr_for_each_entry(&connection->peer_devices, peer_device, i) {
-			retcode = drbd_set_role(peer_device->device, R_SECONDARY, 0);
-			if (retcode < SS_SUCCESS) {
-				drbd_msg_put_info(adm_ctx->reply_skb, "failed to demote");
-				goto out;
-			}
-		}
+	retcode = drbd_set_role(resource, R_SECONDARY, false, "down", adm_ctx);
+	if (retcode < SS_SUCCESS) {
+		drbd_adm_msg(adm_ctx, "%s", "failed to demote");
+		goto out;
+	}
 
-		retcode = conn_try_disconnect(connection, 0);
-		if (retcode < SS_SUCCESS) {
-			drbd_msg_put_info(adm_ctx->reply_skb, "failed to disconnect");
+	for_each_connection_ref(connection, im, resource) {
+		retcode = SS_SUCCESS;
+		if (connection->cstate[NOW] > C_STANDALONE)
+			retcode = conn_try_disconnect(connection, 0, "down", adm_ctx);
+		if (retcode >= SS_SUCCESS) {
+			del_connection(connection, "down");
+		} else {
+			kref_put(&connection->kref, drbd_destroy_connection);
 			goto out;
 		}
 	}
 
-	/* detach */
+	/* detach and delete minor */
+	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, i) {
-		retcode = adm_detach(device, 0);
+		kref_get(&device->kref);
+		rcu_read_unlock();
+		retcode = adm_detach(device, 0, 0, "down", adm_ctx);
+		mutex_lock(&resource->conf_update);
+		ret = adm_del_minor(device);
+		mutex_unlock(&resource->conf_update);
+		kref_put(&device->kref, drbd_destroy_device);
 		if (retcode < SS_SUCCESS || retcode > NO_ERROR) {
-			drbd_msg_put_info(adm_ctx->reply_skb, "failed to detach");
+			drbd_adm_msg(adm_ctx, "%s", "failed to detach");
 			goto out;
 		}
-	}
-
-	/* delete volumes */
-	idr_for_each_entry(&resource->devices, device, i) {
-		retcode = adm_del_minor(device);
-		if (retcode != NO_ERROR) {
+		if (ret != NO_ERROR) {
 			/* "can not happen" */
-			drbd_msg_put_info(adm_ctx->reply_skb, "failed to delete volume");
+			drbd_adm_msg(adm_ctx, "%s", "failed to delete volume");
 			goto out;
 		}
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 
+	mutex_lock(&resource->conf_update);
 	retcode = adm_del_resource(resource);
+	/* holding a reference to resource in adm_ctx until post_doit kfree */
+	mutex_unlock(&resource->conf_update);
 out:
+	opener_info(adm_ctx->resource, adm_ctx, (enum drbd_state_rv)retcode);
+	clear_bit(DOWN_IN_PROGRESS, &resource->flags);
 	mutex_unlock(&resource->adm_mutex);
-finish:
-	adm_ctx->reply_dh->ret_code = retcode;
+out_no_adm_mutex:
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-int drbd_nl_del_resource_doit(struct sk_buff *skb, struct genl_info *info)
+int drbd_adm_del_resource(struct drbd_adm_ctx *adm_ctx)
 {
-	struct drbd_config_context *adm_ctx = info->user_ptr[0];
-	struct drbd_resource *resource;
-	enum drbd_ret_code retcode;
+	enum drbd_ret_code retcode = NO_ERROR;
 
-	if (!adm_ctx->reply_skb)
-		return 0;
-	retcode = adm_ctx->reply_dh->ret_code;
-	if (retcode != NO_ERROR)
-		goto finish;
-	resource = adm_ctx->resource;
+	retcode = adm_del_resource(adm_ctx->resource);
 
-	mutex_lock(&resource->adm_mutex);
-	retcode = adm_del_resource(resource);
-	mutex_unlock(&resource->adm_mutex);
-finish:
-	adm_ctx->reply_dh->ret_code = retcode;
+	adm_ctx->result = retcode;
 	return 0;
 }
 
-void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib)
+/*
+ * Announce an event to every registered dialect. All of them describe
+ * the same event, so it gets a single sequence number, drawn here.
+ *
+ * When a dialect is given (and then there is always an skb) this is the
+ * initial state replay of drbd_dump_initial_state() instead: build the
+ * message into the dump skb of that one dialect, under the sequence
+ * number of the dump.
+ */
+int drbd_notify_resource_state(struct sk_buff *skb,
+			       unsigned int seq,
+			       const struct drbd_nl_dialect *dialect,
+			       struct drbd_resource *resource,
+			       struct drbd_resource_info *resource_info,
+			       struct drbd_rename_resource_info *rename_resource_info,
+			       enum drbd_notification_type type)
 {
-	struct sk_buff *msg;
-	struct drbd_genlmsghdr *d_out;
-	unsigned seq;
-	int err = -ENOMEM;
+	unsigned int i;
+	int err = 0;
+
+	if (dialect)
+		return dialect->notify_resource_state(skb, seq, resource, resource_info,
+						      rename_resource_info, type);
 
+	WARN_ON_ONCE(skb);
 	seq = atomic_inc_return(&drbd_genl_seq);
-	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-	if (!msg)
-		goto failed;
-
-	err = -EMSGSIZE;
-	d_out = genlmsg_put(msg, 0, seq, &drbd_nl_family, 0, DRBD_ADM_EVENT);
-	if (!d_out) /* cannot happen, but anyways. */
-		goto nla_put_failure;
-	d_out->minor = device_to_minor(device);
-	d_out->ret_code = NO_ERROR;
-
-	if (nla_put_status_info(msg, device, sib))
-		goto nla_put_failure;
-	genlmsg_end(msg, d_out);
-	err = drbd_genl_multicast_events(msg, GFP_NOWAIT);
-	/* msg has been consumed or freed in netlink_broadcast() */
-	if (err && err != -ESRCH)
-		goto failed;
-
-	return;
-
-nla_put_failure:
-	nlmsg_free(msg);
-failed:
-	drbd_err(device, "Error %d while broadcasting event. "
-			"Event seq:%u sib_reason:%u\n",
-			err, seq, sib->sib_reason);
-}
-
-static int nla_put_notification_header(struct sk_buff *msg,
-				       enum drbd_notification_type type)
-{
-	struct drbd_notification_header nh = {
-		.nh_type = type,
-	};
+	for (i = 0; i < drbd_nl_n_dialects; i++) {
+		int e = drbd_nl_dialects[i]->notify_resource_state(NULL, seq, resource,
+				resource_info, rename_resource_info, type);
 
-	return drbd_notification_header_to_skb(msg, &nh);
+		if (e && !err)
+			err = e;
+	}
+	return err;
 }
 
 int notify_resource_state(struct sk_buff *skb,
-			   unsigned int seq,
-			   struct drbd_resource *resource,
-			   struct resource_info *resource_info,
-			   enum drbd_notification_type type)
-{
-	struct resource_statistics resource_statistics;
-	struct drbd_genlmsghdr *dh;
-	bool multicast = false;
-	int err;
+			  unsigned int seq,
+			  struct drbd_resource *resource,
+			  struct drbd_resource_info *resource_info,
+			  struct drbd_rename_resource_info *rename_resource_info,
+			  enum drbd_notification_type type)
+{
+	return drbd_notify_resource_state(skb, seq, NULL, resource, resource_info,
+					  rename_resource_info, type);
+}
 
-	if (!skb) {
-		seq = atomic_inc_return(&notify_genl_seq);
-		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-		err = -ENOMEM;
-		if (!skb)
-			goto failed;
-		multicast = true;
-	}
-
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_RESOURCE_STATE);
-	if (!dh)
-		goto nla_put_failure;
-	dh->minor = -1U;
-	dh->ret_code = NO_ERROR;
-	if (nla_put_drbd_cfg_context(skb, resource, NULL, NULL) ||
-	    nla_put_notification_header(skb, type) ||
-	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
-	     resource_info_to_skb(skb, resource_info)))
-		goto nla_put_failure;
-	resource_statistics.res_stat_write_ordering = resource->write_ordering;
-	err = resource_statistics_to_skb(skb, &resource_statistics);
-	if (err)
-		goto nla_put_failure;
-	genlmsg_end(skb, dh);
-	if (multicast) {
-		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
-		/* skb has been consumed or freed in netlink_broadcast() */
-		if (err && err != -ESRCH)
-			goto failed;
-	}
-	return 0;
+int drbd_notify_device_state(struct sk_buff *skb,
+			     unsigned int seq,
+			     const struct drbd_nl_dialect *dialect,
+			     struct drbd_device *device,
+			     struct drbd_device_info *device_info,
+			     enum drbd_notification_type type)
+{
+	unsigned int i;
+	int err = 0;
+
+	if (dialect)
+		return dialect->notify_device_state(skb, seq, device, device_info, type);
 
-nla_put_failure:
-	nlmsg_free(skb);
-failed:
-	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
-			err, seq);
+	WARN_ON_ONCE(skb);
+	seq = atomic_inc_return(&drbd_genl_seq);
+	for (i = 0; i < drbd_nl_n_dialects; i++) {
+		int e = drbd_nl_dialects[i]->notify_device_state(NULL, seq, device,
+				device_info, type);
+
+		if (e && !err)
+			err = e;
+	}
 	return err;
 }
 
 int notify_device_state(struct sk_buff *skb,
-			 unsigned int seq,
-			 struct drbd_device *device,
-			 struct device_info *device_info,
-			 enum drbd_notification_type type)
-{
-	struct device_statistics device_statistics;
-	struct drbd_genlmsghdr *dh;
-	bool multicast = false;
-	int err;
+			unsigned int seq,
+			struct drbd_device *device,
+			struct drbd_device_info *device_info,
+			enum drbd_notification_type type)
+{
+	return drbd_notify_device_state(skb, seq, NULL, device, device_info, type);
+}
 
-	if (!skb) {
-		seq = atomic_inc_return(&notify_genl_seq);
-		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-		err = -ENOMEM;
-		if (!skb)
-			goto failed;
-		multicast = true;
-	}
-
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_DEVICE_STATE);
-	if (!dh)
-		goto nla_put_failure;
-	dh->minor = device->minor;
-	dh->ret_code = NO_ERROR;
-	if (nla_put_drbd_cfg_context(skb, device->resource, NULL, device) ||
-	    nla_put_notification_header(skb, type) ||
-	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
-	     device_info_to_skb(skb, device_info)))
-		goto nla_put_failure;
-	device_to_statistics(&device_statistics, device);
-	device_statistics_to_skb(skb, &device_statistics);
-	genlmsg_end(skb, dh);
-	if (multicast) {
-		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
-		/* skb has been consumed or freed in netlink_broadcast() */
-		if (err && err != -ESRCH)
-			goto failed;
-	}
-	return 0;
+int drbd_notify_connection_state(struct sk_buff *skb,
+				 unsigned int seq,
+				 const struct drbd_nl_dialect *dialect,
+				 struct drbd_connection *connection,
+				 struct drbd_connection_info *connection_info,
+				 enum drbd_notification_type type)
+{
+	unsigned int i;
+	int err = 0;
+
+	if (dialect)
+		return dialect->notify_connection_state(skb, seq, connection,
+							connection_info, type);
 
-nla_put_failure:
-	nlmsg_free(skb);
-failed:
-	drbd_err(device, "Error %d while broadcasting event. Event seq:%u\n",
-		 err, seq);
+	WARN_ON_ONCE(skb);
+	seq = atomic_inc_return(&drbd_genl_seq);
+	for (i = 0; i < drbd_nl_n_dialects; i++) {
+		int e = drbd_nl_dialects[i]->notify_connection_state(NULL, seq, connection,
+				connection_info, type);
+
+		if (e && !err)
+			err = e;
+	}
 	return err;
 }
 
 int notify_connection_state(struct sk_buff *skb,
-			     unsigned int seq,
-			     struct drbd_connection *connection,
-			     struct connection_info *connection_info,
-			     enum drbd_notification_type type)
+			    unsigned int seq,
+			    struct drbd_connection *connection,
+			    struct drbd_connection_info *connection_info,
+			    enum drbd_notification_type type)
 {
-	struct connection_statistics connection_statistics;
-	struct drbd_genlmsghdr *dh;
-	bool multicast = false;
-	int err;
+	return drbd_notify_connection_state(skb, seq, NULL, connection,
+					    connection_info, type);
+}
 
-	if (!skb) {
-		seq = atomic_inc_return(&notify_genl_seq);
-		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-		err = -ENOMEM;
-		if (!skb)
-			goto failed;
-		multicast = true;
-	}
-
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_CONNECTION_STATE);
-	if (!dh)
-		goto nla_put_failure;
-	dh->minor = -1U;
-	dh->ret_code = NO_ERROR;
-	if (nla_put_drbd_cfg_context(skb, connection->resource, connection, NULL) ||
-	    nla_put_notification_header(skb, type) ||
-	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
-	     connection_info_to_skb(skb, connection_info)))
-		goto nla_put_failure;
-	connection_statistics.conn_congested = test_bit(NET_CONGESTED, &connection->flags);
-	connection_statistics_to_skb(skb, &connection_statistics);
-	genlmsg_end(skb, dh);
-	if (multicast) {
-		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
-		/* skb has been consumed or freed in netlink_broadcast() */
-		if (err && err != -ESRCH)
-			goto failed;
-	}
-	return 0;
+int drbd_notify_peer_device_state(struct sk_buff *skb,
+				  unsigned int seq,
+				  const struct drbd_nl_dialect *dialect,
+				  struct drbd_peer_device *peer_device,
+				  struct drbd_peer_device_info *peer_device_info,
+				  enum drbd_notification_type type)
+{
+	unsigned int i;
+	int err = 0;
+
+	if (dialect)
+		return dialect->notify_peer_device_state(skb, seq, peer_device,
+							 peer_device_info, type);
 
-nla_put_failure:
-	nlmsg_free(skb);
-failed:
-	drbd_err(connection, "Error %d while broadcasting event. Event seq:%u\n",
-		 err, seq);
+	WARN_ON_ONCE(skb);
+	seq = atomic_inc_return(&drbd_genl_seq);
+	for (i = 0; i < drbd_nl_n_dialects; i++) {
+		int e = drbd_nl_dialects[i]->notify_peer_device_state(NULL, seq, peer_device,
+				peer_device_info, type);
+
+		if (e && !err)
+			err = e;
+	}
 	return err;
 }
 
 int notify_peer_device_state(struct sk_buff *skb,
-			      unsigned int seq,
-			      struct drbd_peer_device *peer_device,
-			      struct peer_device_info *peer_device_info,
-			      enum drbd_notification_type type)
-{
-	struct peer_device_statistics peer_device_statistics;
-	struct drbd_resource *resource = peer_device->device->resource;
-	struct drbd_genlmsghdr *dh;
-	bool multicast = false;
-	int err;
+			     unsigned int seq,
+			     struct drbd_peer_device *peer_device,
+			     struct drbd_peer_device_info *peer_device_info,
+			     enum drbd_notification_type type)
+{
+	return drbd_notify_peer_device_state(skb, seq, NULL, peer_device,
+					     peer_device_info, type);
+}
 
-	if (!skb) {
-		seq = atomic_inc_return(&notify_genl_seq);
-		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-		err = -ENOMEM;
-		if (!skb)
-			goto failed;
-		multicast = true;
-	}
-
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_PEER_DEVICE_STATE);
-	if (!dh)
-		goto nla_put_failure;
-	dh->minor = -1U;
-	dh->ret_code = NO_ERROR;
-	if (nla_put_drbd_cfg_context(skb, resource, peer_device->connection, peer_device->device) ||
-	    nla_put_notification_header(skb, type) ||
-	    ((type & ~NOTIFY_FLAGS) != NOTIFY_DESTROY &&
-	     peer_device_info_to_skb(skb, peer_device_info)))
-		goto nla_put_failure;
-	peer_device_to_statistics(&peer_device_statistics, peer_device);
-	peer_device_statistics_to_skb(skb, &peer_device_statistics);
-	genlmsg_end(skb, dh);
-	if (multicast) {
-		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
-		/* skb has been consumed or freed in netlink_broadcast() */
-		if (err && err != -ESRCH)
-			goto failed;
-	}
-	return 0;
+void drbd_broadcast_peer_device_state(struct drbd_peer_device *peer_device)
+{
+	struct drbd_peer_device_info peer_device_info;
 
-nla_put_failure:
-	nlmsg_free(skb);
-failed:
-	drbd_err(peer_device, "Error %d while broadcasting event. Event seq:%u\n",
-		 err, seq);
-	return err;
+	mutex_lock(&notification_mutex);
+	peer_device_to_info(&peer_device_info, peer_device);
+	notify_peer_device_state(NULL, 0, peer_device, &peer_device_info, NOTIFY_CHANGE);
+	mutex_unlock(&notification_mutex);
 }
 
-void notify_helper(enum drbd_notification_type type,
-		   struct drbd_device *device, struct drbd_connection *connection,
-		   const char *name, int status)
+static int notify_path_state(struct drbd_connection *connection,
+			     struct drbd_path *path,
+			     struct drbd_nl_path_info *path_info,
+			     enum drbd_notification_type type)
 {
-	struct drbd_resource *resource = device ? device->resource : connection->resource;
-	struct drbd_helper_info helper_info;
-	unsigned int seq = atomic_inc_return(&notify_genl_seq);
-	struct sk_buff *skb = NULL;
-	struct drbd_genlmsghdr *dh;
-	int err;
+	unsigned int i, seq;
+	int err = 0;
 
-	strscpy(helper_info.helper_name, name, sizeof(helper_info.helper_name));
-	helper_info.helper_name_len = min(strlen(name), sizeof(helper_info.helper_name));
-	helper_info.helper_status = status;
+	seq = atomic_inc_return(&drbd_genl_seq);
+	for (i = 0; i < drbd_nl_n_dialects; i++) {
+		int e = drbd_nl_dialects[i]->notify_path_state(NULL, seq, connection, path,
+				path_info, type);
 
-	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
-	err = -ENOMEM;
-	if (!skb)
-		goto fail;
+		if (e && !err)
+			err = e;
+	}
+	return err;
+}
 
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_HELPER);
-	if (!dh)
-		goto fail;
-	dh->minor = device ? device->minor : -1;
-	dh->ret_code = NO_ERROR;
+int notify_path(struct drbd_connection *connection, struct drbd_path *path, enum drbd_notification_type type)
+{
+	struct drbd_nl_path_info path_info;
+	int err;
+
+	path_info.path_established = test_bit(TR_ESTABLISHED, &path->flags);
 	mutex_lock(&notification_mutex);
-	if (nla_put_drbd_cfg_context(skb, resource, connection, device) ||
-	    nla_put_notification_header(skb, type) ||
-	    drbd_helper_info_to_skb(skb, &helper_info))
-		goto unlock_fail;
-	genlmsg_end(skb, dh);
-	err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
-	skb = NULL;
-	/* skb has been consumed or freed in netlink_broadcast() */
-	if (err && err != -ESRCH)
-		goto unlock_fail;
+	err = notify_path_state(connection, path, &path_info, type);
 	mutex_unlock(&notification_mutex);
-	return;
+	return err;
 
-unlock_fail:
-	mutex_unlock(&notification_mutex);
-fail:
-	nlmsg_free(skb);
-	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
-		 err, seq);
 }
 
-static int notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+void notify_helper(enum drbd_notification_type type,
+		   struct drbd_device *device, struct drbd_connection *connection,
+		   const char *name, int status)
 {
-	struct drbd_genlmsghdr *dh;
-	int err;
-
-	err = -EMSGSIZE;
-	dh = genlmsg_put(skb, 0, seq, &drbd_nl_family, 0, DRBD_ADM_INITIAL_STATE_DONE);
-	if (!dh)
-		goto nla_put_failure;
-	dh->minor = -1U;
-	dh->ret_code = NO_ERROR;
-	if (nla_put_notification_header(skb, NOTIFY_EXISTS))
-		goto nla_put_failure;
-	genlmsg_end(skb, dh);
-	return 0;
+	unsigned int seq = atomic_inc_return(&drbd_genl_seq);
+	unsigned int i;
 
-nla_put_failure:
-	nlmsg_free(skb);
-	pr_err("Error %d sending event. Event seq:%u\n", err, seq);
-	return err;
+	mutex_lock(&notification_mutex);
+	for (i = 0; i < drbd_nl_n_dialects; i++)
+		drbd_nl_dialects[i]->notify_helper(NULL, seq, device, connection,
+						   name, status, type);
+	mutex_unlock(&notification_mutex);
 }
 
 static void free_state_changes(struct list_head *list)
@@ -4972,53 +7868,70 @@ static unsigned int notifications_for_state_change(struct drbd_state_change *sta
 	return 1 +
 	       state_change->n_connections +
 	       state_change->n_devices +
-	       state_change->n_devices * state_change->n_connections;
+	       state_change->n_devices * state_change->n_connections +
+	       state_change->n_paths;
 }
 
-static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
+static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb,
+			     const struct drbd_nl_dialect *dialect, unsigned int seq)
 {
 	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
-	unsigned int seq = cb->args[2];
 	unsigned int n;
 	enum drbd_notification_type flags = 0;
 	int err = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
-	   matter if the initial state events mix with later state chage
+	   matter if the initial state events mix with later state change
 	   events; we can always tell the events apart by the NOTIFY_EXISTS
 	   flag. */
 
+again:
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
-		err = notify_initial_state_done(skb, seq);
+		err = dialect->notify_initial_state_done(skb, seq);
 		goto out;
 	}
 	n = cb->args[4]++;
 	if (cb->args[4] < cb->args[3])
 		flags |= NOTIFY_CONTINUES;
 	if (n < 1) {
-		err = notify_resource_state_change(skb, seq, state_change->resource,
+		err = notify_resource_state_change(skb, seq, dialect, state_change,
 					     NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n--;
 	if (n < state_change->n_connections) {
-		err = notify_connection_state_change(skb, seq, &state_change->connections[n],
+		err = notify_connection_state_change(skb, seq, dialect,
+					       &state_change->connections[n],
 					       NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_connections;
+	if (n < state_change->n_paths) {
+		struct drbd_path_state *path_state = &state_change->paths[n];
+		struct drbd_nl_path_info path_info;
+
+		path_info.path_established = path_state->path_established;
+		err = dialect->notify_path_state(skb, seq,
+				path_state->connection,
+				path_state->path,
+				&path_info, NOTIFY_EXISTS | flags);
+		goto next;
+	}
+	n -= state_change->n_paths;
 	if (n < state_change->n_devices) {
-		err = notify_device_state_change(skb, seq, &state_change->devices[n],
+		err = notify_device_state_change(skb, seq, dialect, &state_change->devices[n],
 					   NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_devices;
 	if (n < state_change->n_devices * state_change->n_connections) {
-		err = notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
+		err = notify_peer_device_state_change(skb, seq, dialect,
+						&state_change->peer_devices[n],
 						NOTIFY_EXISTS | flags);
 		goto next;
 	}
+	n -= state_change->n_devices * state_change->n_connections;
 
 next:
 	if (cb->args[4] == cb->args[3]) {
@@ -5029,29 +7942,44 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[3] = notifications_for_state_change(next_state_change);
 		cb->args[4] = 0;
 	}
+	/*
+	 * A dialect may have nothing to send for an object (v1 has no paths).
+	 * An empty skb would end the dump before the INITIAL_STATE_DONE
+	 * message, so go on to the next notification.
+	 */
+	if (!err && !skb->len)
+		goto again;
 out:
 	if (err)
 		return err;
-	else
-		return skb->len;
+	return skb->len;
+}
+
+int drbd_dump_initial_state_done(struct netlink_callback *cb)
+{
+	LIST_HEAD(head);
+
+	if (cb->args[0]) {
+		struct drbd_state_change *state_change =
+			(struct drbd_state_change *)cb->args[0];
+		cb->args[0] = 0;
+
+		/* connect list to head */
+		list_add(&head, &state_change->list);
+		free_state_changes(&head);
+	}
+	return 0;
 }
 
-int drbd_nl_get_initial_state_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+int drbd_dump_initial_state(struct sk_buff *skb, struct netlink_callback *cb,
+			    const struct drbd_nl_dialect *dialect, unsigned int seq)
 {
 	struct drbd_resource *resource;
 	LIST_HEAD(head);
 
 	if (cb->args[5] >= 1) {
 		if (cb->args[5] > 1)
-			return get_initial_state(skb, cb);
-		if (cb->args[0]) {
-			struct drbd_state_change *state_change =
-				(struct drbd_state_change *)cb->args[0];
-
-			/* connect list to head */
-			list_add(&head, &state_change->list);
-			free_state_changes(&head);
-		}
+			return get_initial_state(skb, cb, dialect, seq);
 		return 0;
 	}
 
@@ -5060,7 +7988,9 @@ int drbd_nl_get_initial_state_dumpit(struct sk_buff *skb, struct netlink_callbac
 	for_each_resource(resource, &drbd_resources) {
 		struct drbd_state_change *state_change;
 
-		state_change = remember_old_state(resource, GFP_KERNEL);
+		read_lock_irq(&resource->state_rwlock);
+		state_change = remember_state_change(resource, GFP_ATOMIC);
+		read_unlock_irq(&resource->state_rwlock);
 		if (!state_change) {
 			if (!list_empty(&head))
 				free_state_changes(&head);
@@ -5081,23 +8011,136 @@ int drbd_nl_get_initial_state_dumpit(struct sk_buff *skb, struct netlink_callbac
 		list_del(&head);  /* detach list from head */
 	}
 
-	cb->args[2] = cb->nlh->nlmsg_seq;
-	return get_initial_state(skb, cb);
+	return get_initial_state(skb, cb, dialect, seq);
 }
 
-static const struct genl_multicast_group drbd_nl_mcgrps[] = {
-	[DRBD_NLGRP_EVENTS] = { .name = "events", },
-};
+int drbd_adm_forget_peer(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_resource *resource;
+	struct drbd_device *device;
+	struct drbd_forget_peer_parms parms = { };
+	enum drbd_ret_code retcode = NO_ERROR;
+	int vnr, peer_node_id, err;
 
-struct genl_family drbd_nl_family __ro_after_init = {
-	.name		= "drbd",
-	.version	= DRBD_FAMILY_VERSION,
-	.hdrsize	= NLA_ALIGN(sizeof(struct drbd_genlmsghdr)),
-	.split_ops	= drbd_nl_ops,
-	.n_split_ops	= ARRAY_SIZE(drbd_nl_ops),
-	.mcgrps		= drbd_nl_mcgrps,
-	.n_mcgrps	= ARRAY_SIZE(drbd_nl_mcgrps),
-	.resv_start_op	= 42,
-	.module		= THIS_MODULE,
-	.netnsok	= true,
-};
+	resource = adm_ctx->resource;
+
+	err = drbd_adm_overlay_forget_peer_parms(adm_ctx, &parms);
+	if (err) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto out_no_adm_mutex;
+	}
+
+	if (mutex_lock_interruptible(&resource->adm_mutex)) {
+		retcode = ERR_INTR;
+		goto out_no_adm_mutex;
+	}
+
+	peer_node_id = parms.forget_peer_node_id;
+	if (drbd_connection_by_node_id(resource, peer_node_id)) {
+		retcode = ERR_NET_CONFIGURED;
+		goto out;
+	}
+
+	if (peer_node_id < 0 || peer_node_id >= DRBD_NODE_ID_MAX) {
+		retcode = ERR_INVALID_PEER_NODE_ID;
+		goto out;
+	}
+
+	idr_for_each_entry(&resource->devices, device, vnr)
+		clear_peer_slot(device, peer_node_id, 0);
+out:
+	mutex_unlock(&resource->adm_mutex);
+out_no_adm_mutex:
+	idr_for_each_entry(&resource->devices, device, vnr)
+		drbd_md_sync_if_dirty(device);
+
+	adm_ctx->result = (enum drbd_ret_code)retcode;
+	return 0;
+
+}
+
+static enum drbd_ret_code validate_new_resource_name(const struct drbd_resource *resource, const char *new_name)
+{
+	enum drbd_ret_code retcode = drbd_check_name_str(new_name, drbd_strict_names);
+
+	if (retcode == NO_ERROR) {
+		struct drbd_resource *next_resource;
+
+		rcu_read_lock();
+		for_each_resource_rcu(next_resource, &drbd_resources) {
+			if (strcmp(next_resource->name, new_name) == 0) {
+				retcode = ERR_ALREADY_EXISTS;
+				break;
+			}
+		}
+		rcu_read_unlock();
+	}
+	return retcode;
+}
+
+int drbd_adm_rename_resource(struct drbd_adm_ctx *adm_ctx)
+{
+	struct drbd_resource *resource;
+	struct drbd_device *device;
+	struct drbd_rename_resource_info rename_resource_info;
+	struct drbd_rename_resource_parms parms = { };
+	char *old_res_name, *new_res_name;
+	enum drbd_ret_code retcode = NO_ERROR;
+	enum drbd_ret_code validate_err;
+	int err;
+	int vnr;
+
+	mutex_lock(&resources_mutex);
+
+	resource = adm_ctx->resource;
+
+	err = drbd_adm_overlay_rename_resource_parms(adm_ctx, &parms);
+	if (err) {
+		retcode = ERR_MANDATORY_TAG;
+		drbd_adm_msg_overlay_error(adm_ctx, err);
+		goto out;
+	}
+
+	validate_err = validate_new_resource_name(resource, parms.new_resource_name);
+	if (validate_err != NO_ERROR) {
+		if (ERR_ALREADY_EXISTS) {
+			drbd_adm_msg(adm_ctx,
+				"Cannot rename to %s: a resource with that name already exists\n",
+				 parms.new_resource_name);
+		} else {
+			drbd_msg_put_name_error(adm_ctx, validate_err);
+		}
+		retcode = validate_err;
+		goto out;
+	}
+
+	drbd_info(resource, "Renaming to %s\n", parms.new_resource_name);
+
+	strscpy(rename_resource_info.res_new_name, parms.new_resource_name, sizeof(rename_resource_info.res_new_name));
+	rename_resource_info.res_new_name_len = min(strlen(parms.new_resource_name), sizeof(rename_resource_info.res_new_name));
+
+	mutex_lock(&notification_mutex);
+	notify_resource_state(NULL, 0, resource, NULL, &rename_resource_info, NOTIFY_RENAME);
+	mutex_unlock(&notification_mutex);
+
+	new_res_name = kstrdup(parms.new_resource_name, GFP_KERNEL);
+	if (!new_res_name) {
+		retcode = ERR_NOMEM;
+		goto out;
+	}
+	old_res_name = resource->name;
+	resource->name = new_res_name;
+	kvfree_rcu_mightsleep(old_res_name);
+
+	drbd_debugfs_resource_rename(resource, new_res_name);
+
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
+	}
+
+out:
+	mutex_unlock(&resources_mutex);
+	adm_ctx->result = retcode;
+	return 0;
+}
diff --git a/drivers/block/drbd/drbd_nl.h b/drivers/block/drbd/drbd_nl.h
new file mode 100644
index 000000000000..2fcdcf15756a
--- /dev/null
+++ b/drivers/block/drbd/drbd_nl.h
@@ -0,0 +1,390 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Context and outcome of one DRBD netlink configuration command.
+ *
+ * The command implementations are independent of the wire format: they
+ * receive the identity of the object to act on and report back a result
+ * code plus a few informational messages. Translating that into the
+ * bytes of a particular netlink dialect is the job of the per-dialect
+ * pre_doit/post_doit handlers and of the struct drbd_nl_dialect ops
+ * below.
+ */
+#ifndef __DRBD_NL_H
+#define __DRBD_NL_H
+
+#include <linux/compiler.h>
+#include "drbd_nl_types.h"
+
+struct drbd_device;
+struct drbd_resource;
+struct drbd_connection;
+struct drbd_peer_device;
+struct drbd_path;
+struct net;
+struct netlink_callback;
+struct sk_buff;
+struct drbd_nl_dialect;
+
+/* per-message cap, same as drbd_msg_sprintf_info()'s reserve */
+#define DRBD_ADM_MSG_MAX	256
+/*
+ * Total info text per request; a strict superset of what the legacy
+ * NLMSG_GOODSIZE reply could carry (that is capped at
+ * SKB_WITH_OVERHEAD(8192UL) on every page size).
+ */
+#define DRBD_ADM_MSG_BUF	8192
+
+struct drbd_adm_ctx {
+	/* the dialect the request arrived in, and its private request state */
+	const struct drbd_nl_dialect *d;
+	void *req;
+
+	/* identity, filled from the request by the dialect's pre_doit */
+	unsigned int minor;
+	unsigned int volume;
+#define VOLUME_UNSPECIFIED		(-1U)
+	unsigned int peer_node_id;
+#define PEER_NODE_ID_UNSPECIFIED	(-1U)
+	const char *resource_name;	/* points into the request; limited lifetime */
+	struct net *net;
+	bool set_defaults;
+	/*
+	 * Set by a dialect that has no attribute to request DRBD 8.4
+	 * compatibility mode explicitly (the version 1 dialect: every
+	 * resource it creates is a DRBD 8.4 resource). Honoured by
+	 * drbd_adm_new_resource() the same way as res_opts.explicit_drbd8_compat.
+	 */
+	bool force_drbd8_compat;
+
+	/* resolved by drbd_adm_ctx_resolve() */
+	struct drbd_device *device;
+	struct drbd_resource *resource;
+	struct drbd_connection *connection;
+	struct drbd_peer_device *peer_device;
+
+	/* outcome, serialized by the dialect's post_doit */
+	int result;			/* NO_ERROR, ERR_*, SS_* or -errno */
+	unsigned int msg_len;		/* bytes used in msg[] */
+	/*
+	 * NUL-separated info messages, in order. Each message is truncated
+	 * at DRBD_ADM_MSG_MAX; a message that does not fit into what is
+	 * left of the buffer is dropped, exactly as an over-full reply skb
+	 * dropped it before.
+	 */
+	char msg[DRBD_ADM_MSG_BUF];
+};
+
+/* Attribute sets the core overlays onto live data or reads as parameters. */
+enum drbd_nl_attr_set {
+	DRBD_NL_SET_DISK_CONF,
+	DRBD_NL_SET_NET_CONF,
+	DRBD_NL_SET_RES_OPTS,
+	DRBD_NL_SET_PEER_DEVICE_CONF,
+	DRBD_NL_SET_DEVICE_CONF,
+	DRBD_NL_SET_SET_ROLE_PARMS,
+	DRBD_NL_SET_RESIZE_PARMS,
+	DRBD_NL_SET_START_OV_PARMS,
+	DRBD_NL_SET_NEW_C_UUID_PARMS,
+	DRBD_NL_SET_DISCONNECT_PARMS,
+	DRBD_NL_SET_DETACH_PARMS,
+	DRBD_NL_SET_INVALIDATE_PARMS,
+	DRBD_NL_SET_INVALIDATE_PEER_PARMS,
+	DRBD_NL_SET_FORGET_PEER_PARMS,
+	DRBD_NL_SET_CONNECT_PARMS,
+	DRBD_NL_SET_PATH_PARMS,
+	DRBD_NL_SET_RENAME_RESOURCE_PARMS,
+	DRBD_NL_SET_SUSPEND_IO_PARMS,
+	__DRBD_NL_SET_MAX,
+};
+
+/* Fields the core must refuse to change once set. */
+enum drbd_adm_field {
+	DRBD_ADM_F_DISK_BACKING_DEV,
+	DRBD_ADM_F_DISK_META_DEV,
+	DRBD_ADM_F_DISK_META_DEV_IDX,
+	DRBD_ADM_F_DISK_SIZE,
+	DRBD_ADM_F_NET_TRANSPORT_NAME,
+	DRBD_ADM_F_NET_LOAD_BALANCE_PATHS,
+	DRBD_ADM_F_RES_NODE_ID,
+};
+
+struct drbd_nl_dialect {
+	const char *name;
+	/* Is the attribute set present in the request at all? */
+	bool (*has_set)(struct drbd_adm_ctx *ctx, enum drbd_nl_attr_set set);
+	/*
+	 * Apply the request's attributes of "set" onto "dst" (a struct of
+	 * the matching type); attributes absent from the request leave
+	 * "dst" untouched. Returns 0, -ENOMSG (required attribute
+	 * missing), -EEXIST (invariant change attempted), or -EINVAL.
+	 */
+	int (*overlay)(struct drbd_adm_ctx *ctx, enum drbd_nl_attr_set set, void *dst);
+	/* Did the request carry this invariant field? Logs if it did. */
+	bool (*attr_present)(struct drbd_adm_ctx *ctx, enum drbd_adm_field field);
+	/* Reply payloads */
+	int (*put_timeout_type)(struct drbd_adm_ctx *ctx, enum drbd_timeout_flag type);
+
+	/*
+	 * Dump emitters: append one message describing the object to the
+	 * dump skb; return 0 or -errno. A "retcode" other than NO_ERROR
+	 * describes a failure instead of an object: only the result code
+	 * goes on the wire, and the object pointers must not be
+	 * dereferenced (they may be NULL or stale).
+	 */
+	int (*emit_resource)(struct sk_buff *skb, struct netlink_callback *cb,
+			     struct drbd_resource *resource,
+			     struct drbd_resource_info *info,
+			     struct drbd_resource_statistics *statistics);
+	int (*emit_device)(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+			   struct drbd_device *device,
+			   struct drbd_disk_conf *disk_conf /* NULL if diskless */,
+			   struct drbd_device_info *info,
+			   struct drbd_device_statistics *statistics);
+	int (*emit_connection)(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+			       struct drbd_resource *resource,
+			       struct drbd_connection *connection,
+			       struct drbd_net_conf *net_conf /* NULL if none */,
+			       struct drbd_connection_info *info,
+			       struct drbd_connection_statistics *statistics);
+	int (*emit_peer_device)(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+				struct drbd_peer_device *peer_device, unsigned int minor,
+				struct drbd_peer_device_info *info,
+				struct drbd_peer_device_statistics *statistics,
+				struct drbd_peer_device_conf *conf /* NULL if none */);
+	int (*emit_path)(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+			 struct drbd_resource *resource, struct drbd_connection *connection,
+			 struct drbd_path *path, struct drbd_nl_path_info *info);
+
+	/*
+	 * Notification emitters. skb == NULL: allocate a message, build it
+	 * and multicast it to the listeners of this dialect. skb != NULL:
+	 * this is the initial state replay, append the message to that
+	 * dump skb instead. "seq" is the sequence number of the event,
+	 * assigned once per event by the core.
+	 */
+	int (*notify_resource_state)(struct sk_buff *skb, unsigned int seq,
+				     struct drbd_resource *resource,
+				     struct drbd_resource_info *info,
+				     struct drbd_rename_resource_info *rename_info,
+				     enum drbd_notification_type type);
+	int (*notify_device_state)(struct sk_buff *skb, unsigned int seq,
+				   struct drbd_device *device,
+				   struct drbd_device_info *info,
+				   enum drbd_notification_type type);
+	int (*notify_connection_state)(struct sk_buff *skb, unsigned int seq,
+				       struct drbd_connection *connection,
+				       struct drbd_connection_info *info,
+				       enum drbd_notification_type type);
+	int (*notify_peer_device_state)(struct sk_buff *skb, unsigned int seq,
+					struct drbd_peer_device *peer_device,
+					struct drbd_peer_device_info *info,
+					enum drbd_notification_type type);
+	int (*notify_path_state)(struct sk_buff *skb, unsigned int seq,
+				 struct drbd_connection *connection, struct drbd_path *path,
+				 struct drbd_nl_path_info *info,
+				 enum drbd_notification_type type);
+	int (*notify_helper)(struct sk_buff *skb, unsigned int seq,
+			     struct drbd_device *device, struct drbd_connection *connection,
+			     const char *name, int status,
+			     enum drbd_notification_type type);
+	int (*notify_initial_state_done)(struct sk_buff *skb, unsigned int seq);
+};
+
+/* Dialects that receive notifications; registered at module init. */
+int drbd_nl_register_dialect(const struct drbd_nl_dialect *dialect);
+
+/*
+ * The "drbd" family, at version 1 for DRBD 8.4 userland (drbd_nl_84.c),
+ * exists only with CONFIG_DRBD_COMPAT_84. The out-of-tree module can serve
+ * version 2 of it instead (DRBD_NL_FAMILY_V2, see DRBD_PROC_VERSION).
+ */
+#if defined(CONFIG_DRBD_COMPAT_84) || defined(DRBD_NL_FAMILY_V2)
+int drbd_nl_legacy_init(void);
+void drbd_nl_legacy_exit(void);
+#else
+static inline int drbd_nl_legacy_init(void) { return 0; }
+static inline void drbd_nl_legacy_exit(void) { }
+#endif
+
+int drbd_nl_drbd2_init(void);
+void drbd_nl_drbd2_exit(void);
+
+static inline int drbd_adm_overlay_disk_conf(struct drbd_adm_ctx *ctx, struct drbd_disk_conf *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_DISK_CONF, c); }
+
+static inline int drbd_adm_overlay_net_conf(struct drbd_adm_ctx *ctx, struct drbd_net_conf *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_NET_CONF, c); }
+
+static inline int drbd_adm_overlay_res_opts(struct drbd_adm_ctx *ctx, struct drbd_res_opts *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_RES_OPTS, c); }
+
+static inline int drbd_adm_overlay_peer_device_conf(struct drbd_adm_ctx *ctx,
+						    struct drbd_peer_device_conf *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_PEER_DEVICE_CONF, c); }
+
+static inline int drbd_adm_overlay_device_conf(struct drbd_adm_ctx *ctx, struct drbd_device_conf *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_DEVICE_CONF, c); }
+
+static inline int drbd_adm_overlay_set_role_parms(struct drbd_adm_ctx *ctx,
+						  struct drbd_set_role_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_SET_ROLE_PARMS, c); }
+
+static inline int drbd_adm_overlay_resize_parms(struct drbd_adm_ctx *ctx,
+						struct drbd_resize_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_RESIZE_PARMS, c); }
+
+static inline int drbd_adm_overlay_start_ov_parms(struct drbd_adm_ctx *ctx,
+						  struct drbd_start_ov_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_START_OV_PARMS, c); }
+
+static inline int drbd_adm_overlay_new_c_uuid_parms(struct drbd_adm_ctx *ctx,
+						    struct drbd_new_c_uuid_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_NEW_C_UUID_PARMS, c); }
+
+static inline int drbd_adm_overlay_disconnect_parms(struct drbd_adm_ctx *ctx,
+						    struct drbd_disconnect_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_DISCONNECT_PARMS, c); }
+
+static inline int drbd_adm_overlay_detach_parms(struct drbd_adm_ctx *ctx,
+						struct drbd_detach_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_DETACH_PARMS, c); }
+
+static inline int drbd_adm_overlay_invalidate_parms(struct drbd_adm_ctx *ctx,
+						    struct drbd_invalidate_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_INVALIDATE_PARMS, c); }
+
+static inline int drbd_adm_overlay_invalidate_peer_parms(struct drbd_adm_ctx *ctx,
+							 struct drbd_invalidate_peer_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_INVALIDATE_PEER_PARMS, c); }
+
+static inline int drbd_adm_overlay_forget_peer_parms(struct drbd_adm_ctx *ctx,
+						     struct drbd_forget_peer_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_FORGET_PEER_PARMS, c); }
+
+static inline int drbd_adm_overlay_connect_parms(struct drbd_adm_ctx *ctx,
+						 struct drbd_connect_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_CONNECT_PARMS, c); }
+
+static inline int drbd_adm_overlay_path_parms(struct drbd_adm_ctx *ctx, struct drbd_path_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_PATH_PARMS, c); }
+
+static inline int drbd_adm_overlay_rename_resource_parms(struct drbd_adm_ctx *ctx,
+							 struct drbd_rename_resource_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_RENAME_RESOURCE_PARMS, c); }
+
+static inline int drbd_adm_overlay_suspend_io_parms(struct drbd_adm_ctx *ctx,
+						    struct drbd_suspend_io_parms *c)
+{ return ctx->d->overlay(ctx, DRBD_NL_SET_SUSPEND_IO_PARMS, c); }
+
+__printf(2, 3) void drbd_adm_msg(struct drbd_adm_ctx *ctx, const char *fmt, ...);
+
+/* Flags for drbd_adm_ctx_resolve() */
+#define DRBD_ADM_NEED_MINOR        (1 << 0)
+#define DRBD_ADM_NEED_RESOURCE     (1 << 1)
+#define DRBD_ADM_NEED_CONNECTION   (1 << 2)
+#define DRBD_ADM_NEED_PEER_DEVICE  (1 << 3)
+#define DRBD_ADM_NEED_PEER_NODE    (1 << 4)
+#define DRBD_ADM_IGNORE_VERSION    (1 << 5)
+
+int drbd_adm_ctx_resolve(struct drbd_adm_ctx *ctx, unsigned int flags);
+void drbd_adm_ctx_release(struct drbd_adm_ctx *ctx);
+
+/* The netlink commands; each reports its outcome through ctx->result. */
+int drbd_adm_primary(struct drbd_adm_ctx *ctx);
+int drbd_adm_secondary(struct drbd_adm_ctx *ctx);
+int drbd_adm_disk_opts(struct drbd_adm_ctx *ctx);
+int drbd_adm_attach(struct drbd_adm_ctx *ctx);
+int drbd_adm_detach(struct drbd_adm_ctx *ctx);
+int drbd_adm_net_opts(struct drbd_adm_ctx *ctx);
+int drbd_adm_peer_device_opts(struct drbd_adm_ctx *ctx);
+int drbd_adm_connect(struct drbd_adm_ctx *ctx);
+int drbd_adm_new_peer(struct drbd_adm_ctx *ctx);
+int drbd_adm_new_path(struct drbd_adm_ctx *ctx);
+int drbd_adm_del_path(struct drbd_adm_ctx *ctx);
+int drbd_adm_disconnect(struct drbd_adm_ctx *ctx);
+int drbd_adm_del_peer(struct drbd_adm_ctx *ctx);
+int drbd_adm_resize(struct drbd_adm_ctx *ctx);
+int drbd_adm_resource_opts(struct drbd_adm_ctx *ctx);
+int drbd_adm_invalidate(struct drbd_adm_ctx *ctx);
+int drbd_adm_invalidate_peer(struct drbd_adm_ctx *ctx);
+int drbd_adm_pause_sync(struct drbd_adm_ctx *ctx);
+int drbd_adm_resume_sync(struct drbd_adm_ctx *ctx);
+int drbd_adm_suspend_io(struct drbd_adm_ctx *ctx);
+int drbd_adm_resume_io(struct drbd_adm_ctx *ctx);
+int drbd_adm_outdate(struct drbd_adm_ctx *ctx);
+int drbd_adm_get_timeout_type(struct drbd_adm_ctx *ctx);
+int drbd_adm_start_ov(struct drbd_adm_ctx *ctx);
+int drbd_adm_new_c_uuid(struct drbd_adm_ctx *ctx);
+int drbd_adm_new_resource(struct drbd_adm_ctx *ctx);
+int drbd_adm_new_minor(struct drbd_adm_ctx *ctx);
+int drbd_adm_del_minor(struct drbd_adm_ctx *ctx);
+int drbd_adm_down(struct drbd_adm_ctx *ctx);
+int drbd_adm_del_resource(struct drbd_adm_ctx *ctx);
+int drbd_adm_forget_peer(struct drbd_adm_ctx *ctx);
+int drbd_adm_rename_resource(struct drbd_adm_ctx *ctx);
+
+/*
+ * The dumps. The core walks the objects and keeps its cursor in
+ * cb->args[]; the dialect turns each object into a message. The
+ * optional resource-name filter is resolved by the dialect before it
+ * calls in: cb->args[0] then holds that resource with a reference
+ * (dropped again by the matching _done callback).
+ */
+enum { DRBD_DUMP_SINGLE_RESOURCE, DRBD_DUMP_ITERATE_RESOURCES };
+
+int drbd_dump_resources(struct sk_buff *skb, struct netlink_callback *cb,
+			const struct drbd_nl_dialect *dialect);
+int drbd_dump_devices(struct sk_buff *skb, struct netlink_callback *cb,
+		      const struct drbd_nl_dialect *dialect);
+int drbd_dump_devices_done(struct netlink_callback *cb);
+int drbd_dump_connections(struct sk_buff *skb, struct netlink_callback *cb,
+			  const struct drbd_nl_dialect *dialect);
+int drbd_dump_connections_done(struct netlink_callback *cb);
+int drbd_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb,
+			   const struct drbd_nl_dialect *dialect);
+int drbd_dump_peer_devices_done(struct netlink_callback *cb);
+int drbd_dump_paths(struct sk_buff *skb, struct netlink_callback *cb,
+		    const struct drbd_nl_dialect *dialect);
+int drbd_dump_paths_done(struct netlink_callback *cb);
+int drbd_dump_initial_state(struct sk_buff *skb, struct netlink_callback *cb,
+			    const struct drbd_nl_dialect *dialect, unsigned int seq);
+int drbd_dump_initial_state_done(struct netlink_callback *cb);
+
+/* Statistics of a live object, for the dumps and for the notifications. */
+void resource_to_statistics(struct drbd_resource_statistics *s, struct drbd_resource *resource);
+void device_to_statistics(struct drbd_device_statistics *s, struct drbd_device *device);
+void connection_to_statistics(struct drbd_connection_statistics *s,
+			      struct drbd_connection *connection);
+void peer_device_to_statistics(struct drbd_peer_device_statistics *s,
+			       struct drbd_peer_device *peer_device);
+
+/*
+ * Notifications. With "dialect" NULL the event is announced to every
+ * registered dialect under a freshly drawn sequence number; that is what
+ * the notify_*_state() wrappers in drbd_int.h do. A non-NULL dialect
+ * (and then always a non-NULL skb) is the initial state replay into the
+ * dump skb of that one dialect.
+ */
+int drbd_notify_resource_state(struct sk_buff *skb, unsigned int seq,
+			       const struct drbd_nl_dialect *dialect,
+			       struct drbd_resource *resource,
+			       struct drbd_resource_info *resource_info,
+			       struct drbd_rename_resource_info *rename_resource_info,
+			       enum drbd_notification_type type);
+int drbd_notify_device_state(struct sk_buff *skb, unsigned int seq,
+			     const struct drbd_nl_dialect *dialect,
+			     struct drbd_device *device,
+			     struct drbd_device_info *device_info,
+			     enum drbd_notification_type type);
+int drbd_notify_connection_state(struct sk_buff *skb, unsigned int seq,
+				 const struct drbd_nl_dialect *dialect,
+				 struct drbd_connection *connection,
+				 struct drbd_connection_info *connection_info,
+				 enum drbd_notification_type type);
+int drbd_notify_peer_device_state(struct sk_buff *skb, unsigned int seq,
+				  const struct drbd_nl_dialect *dialect,
+				  struct drbd_peer_device *peer_device,
+				  struct drbd_peer_device_info *peer_device_info,
+				  enum drbd_notification_type type);
+
+#endif /* __DRBD_NL_H */
diff --git a/drivers/block/drbd/drbd_nl_defaults.c b/drivers/block/drbd/drbd_nl_defaults.c
new file mode 100644
index 000000000000..8a553f6762a8
--- /dev/null
+++ b/drivers/block/drbd/drbd_nl_defaults.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/*
+ * Default setters for the structs in drbd_nl_types.h, generated from
+ * drbd_genl_ynl.yaml by the YNL generator carried with the out-of-tree
+ * DRBD sources (drbd-headers, linux/generate.sh). The kernel's
+ * tools/net/ynl cannot regenerate this file.
+ */
+
+#include "drbd_nl_types.h"
+#include <linux/string.h>
+
+#include <linux/drbd.h>
+#include <linux/drbd_limits.h>
+
+void drbd_set_nl_cfg_context_defaults(struct drbd_nl_cfg_context *x)
+{
+	memset(x->ctx_conn_name, 0, sizeof(x->ctx_conn_name));
+	x->ctx_conn_name_len = 0;
+}
+
+void drbd_set_disk_conf_defaults(struct drbd_disk_conf *x)
+{
+	x->on_io_error = DRBD_ON_IO_ERROR_DEF;
+	x->resync_after = DRBD_MINOR_NUMBER_DEF;
+	x->al_extents = DRBD_AL_EXTENTS_DEF;
+	x->disk_barrier = DRBD_DISK_BARRIER_DEF;
+	x->disk_flushes = DRBD_DISK_FLUSHES_DEF;
+	x->disk_drain = DRBD_DISK_DRAIN_DEF;
+	x->md_flushes = DRBD_MD_FLUSHES_DEF;
+	x->disk_timeout = DRBD_DISK_TIMEOUT_DEF;
+	x->read_balancing = DRBD_READ_BALANCING_DEF;
+	x->unplug_watermark = DRBD_UNPLUG_WATERMARK_DEF;
+	x->al_updates = DRBD_AL_UPDATES_DEF;
+	x->discard_zeroes_if_aligned = DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF;
+	x->rs_discard_granularity = DRBD_RS_DISCARD_GRANULARITY_DEF;
+	x->disable_write_same = DRBD_DISABLE_WRITE_SAME_DEF;
+	x->d_bitmap = DRBD_BITMAP_DEF;
+}
+
+void drbd_set_res_opts_defaults(struct drbd_res_opts *x)
+{
+	memset(x->cpu_mask, 0, sizeof(x->cpu_mask));
+	x->cpu_mask_len = 0;
+	x->on_no_data = DRBD_ON_NO_DATA_DEF;
+	x->auto_promote = DRBD_AUTO_PROMOTE_DEF;
+	x->peer_ack_window = DRBD_PEER_ACK_WINDOW_DEF;
+	x->twopc_timeout = DRBD_TWOPC_TIMEOUT_DEF;
+	x->twopc_retry_timeout = DRBD_TWOPC_RETRY_TIMEOUT_DEF;
+	x->peer_ack_delay = DRBD_PEER_ACK_DELAY_DEF;
+	x->auto_promote_timeout = DRBD_AUTO_PROMOTE_TIMEOUT_DEF;
+	x->nr_requests = DRBD_NR_REQUESTS_DEF;
+	x->quorum = DRBD_QUORUM_DEF;
+	x->on_no_quorum = DRBD_ON_NO_QUORUM_DEF;
+	x->quorum_min_redundancy = DRBD_QUORUM_DEF;
+	x->on_susp_primary_outdated = DRBD_ON_SUSP_PRI_OUTD_DEF;
+	x->drbd8_compat_mode = DRBD_DRBD8_COMPAT_MODE_DEF;
+	x->explicit_drbd8_compat = DRBD_DRBD8_COMPAT_MODE_DEF;
+}
+
+void drbd_set_net_conf_defaults(struct drbd_net_conf *x)
+{
+	memset(x->shared_secret, 0, sizeof(x->shared_secret));
+	x->shared_secret_len = 0;
+	memset(x->cram_hmac_alg, 0, sizeof(x->cram_hmac_alg));
+	x->cram_hmac_alg_len = 0;
+	memset(x->integrity_alg, 0, sizeof(x->integrity_alg));
+	x->integrity_alg_len = 0;
+	memset(x->verify_alg, 0, sizeof(x->verify_alg));
+	x->verify_alg_len = 0;
+	memset(x->csums_alg, 0, sizeof(x->csums_alg));
+	x->csums_alg_len = 0;
+	x->wire_protocol = DRBD_PROTOCOL_DEF;
+	x->connect_int = DRBD_CONNECT_INT_DEF;
+	x->timeout = DRBD_TIMEOUT_DEF;
+	x->ping_int = DRBD_PING_INT_DEF;
+	x->ping_timeo = DRBD_PING_TIMEO_DEF;
+	x->sndbuf_size = DRBD_SNDBUF_SIZE_DEF;
+	x->rcvbuf_size = DRBD_RCVBUF_SIZE_DEF;
+	x->ko_count = DRBD_KO_COUNT_DEF;
+	x->max_epoch_size = DRBD_MAX_EPOCH_SIZE_DEF;
+	x->after_sb_0p = DRBD_AFTER_SB_0P_DEF;
+	x->after_sb_1p = DRBD_AFTER_SB_1P_DEF;
+	x->after_sb_2p = DRBD_AFTER_SB_2P_DEF;
+	x->rr_conflict = DRBD_RR_CONFLICT_DEF;
+	x->on_congestion = DRBD_ON_CONGESTION_DEF;
+	x->cong_fill = DRBD_CONG_FILL_DEF;
+	x->cong_extents = DRBD_CONG_EXTENTS_DEF;
+	x->two_primaries = DRBD_ALLOW_TWO_PRIMARIES_DEF;
+	x->tcp_cork = DRBD_TCP_CORK_DEF;
+	x->always_asbp = DRBD_ALWAYS_ASBP_DEF;
+	x->use_rle = DRBD_USE_RLE_DEF;
+	x->fencing_policy = DRBD_FENCING_DEF;
+	memset(x->name, 0, sizeof(x->name));
+	x->name_len = 0;
+	x->csums_after_crash_only = DRBD_CSUMS_AFTER_CRASH_ONLY_DEF;
+	x->sock_check_timeo = DRBD_SOCKET_CHECK_TIMEO_DEF;
+	memset(x->transport_name, 0, sizeof(x->transport_name));
+	x->transport_name_len = 0;
+	x->max_buffers = DRBD_MAX_BUFFERS_DEF;
+	x->allow_remote_read = DRBD_ALLOW_REMOTE_READ_DEF;
+	x->tls = DRBD_TLS_DEF;
+	x->tls_privkey = DRBD_TLS_PRIVKEY_DEF;
+	x->tls_certificate = DRBD_TLS_CERTIFICATE_DEF;
+	x->tls_keyring = DRBD_TLS_KEYRING_DEF;
+	x->load_balance_paths = DRBD_LOAD_BALANCE_PATHS_DEF;
+	x->rdma_ctrl_rcvbuf_size = DRBD_RDMA_CTRL_RCVBUF_SIZE_DEF;
+	x->rdma_ctrl_sndbuf_size = DRBD_RDMA_CTRL_SNDBUF_SIZE_DEF;
+}
+
+void drbd_set_resize_parms_defaults(struct drbd_resize_parms *x)
+{
+	x->al_stripes = DRBD_AL_STRIPES_DEF;
+	x->al_stripe_size = DRBD_AL_STRIPE_SIZE_DEF;
+}
+
+void drbd_set_detach_parms_defaults(struct drbd_detach_parms *x)
+{
+	x->intentional_diskless_detach = DRBD_DISK_DISKLESS_DEF;
+}
+
+void drbd_set_device_conf_defaults(struct drbd_device_conf *x)
+{
+	x->max_bio_size = DRBD_MAX_BIO_SIZE_DEF;
+	x->intentional_diskless = DRBD_DISK_DISKLESS_DEF;
+	x->block_size = DRBD_BLOCK_SIZE_DEF;
+	x->discard_granularity = DRBD_DISCARD_GRANULARITY_DEF;
+}
+
+void drbd_set_invalidate_parms_defaults(struct drbd_invalidate_parms *x)
+{
+	x->sync_from_peer_node_id = DRBD_SYNC_FROM_NID_DEF;
+	x->reset_bitmap = DRBD_INVALIDATE_RESET_BITMAP_DEF;
+}
+
+void drbd_set_forget_peer_parms_defaults(struct drbd_forget_peer_parms *x)
+{
+	x->forget_peer_node_id = DRBD_SYNC_FROM_NID_DEF;
+}
+
+void drbd_set_peer_device_conf_defaults(struct drbd_peer_device_conf *x)
+{
+	x->resync_rate = DRBD_RESYNC_RATE_DEF;
+	x->c_plan_ahead = DRBD_C_PLAN_AHEAD_DEF;
+	x->c_delay_target = DRBD_C_DELAY_TARGET_DEF;
+	x->c_fill_target = DRBD_C_FILL_TARGET_DEF;
+	x->c_max_rate = DRBD_C_MAX_RATE_DEF;
+	x->c_min_rate = DRBD_C_MIN_RATE_DEF;
+	x->bitmap = DRBD_BITMAP_DEF;
+	x->resync_without_replication = DRBD_RESYNC_WITHOUT_REPLICATION_DEF;
+	x->peer_tiebreaker = DRBD_PEER_TIEBREAKER_DEF;
+}
+
+void drbd_set_connect_parms_defaults(struct drbd_connect_parms *x)
+{
+	x->tentative = 0;
+	x->discard_my_data = 0;
+}
+
+void drbd_set_invalidate_peer_parms_defaults(struct drbd_invalidate_peer_parms *x)
+{
+	x->p_reset_bitmap = DRBD_INVALIDATE_RESET_BITMAP_DEF;
+}
+
+void drbd_set_suspend_io_parms_defaults(struct drbd_suspend_io_parms *x)
+{
+	x->bdev_freeze = DRBD_SUSPEND_IO_BDEV_FREEZE_DEF;
+}
diff --git a/drivers/block/drbd/drbd_nl_types.h b/drivers/block/drbd/drbd_nl_types.h
new file mode 100644
index 000000000000..a9abe161afb8
--- /dev/null
+++ b/drivers/block/drbd/drbd_nl_types.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Internal representation of DRBD configuration options, parameters,
+ * state information and statistics as exchanged over generic netlink.
+ *
+ * These structs are shared by every netlink dialect the kernel module
+ * serves (the legacy "drbd" family and "drbd2"); the per-dialect
+ * marshalling code translates between them and the wire format. They
+ * used to be generated from linux/drbd_genl_ynl.yaml; keep field names
+ * and types in sync with the specs when adding attributes.
+ */
+#ifndef __DRBD_NL_TYPES_H
+#define __DRBD_NL_TYPES_H
+
+#include <linux/types.h>
+#include <linux/drbd.h>
+
+struct drbd_nl_cfg_reply {
+	char info_text[0];
+	__u32 info_text_len;
+};
+
+struct drbd_nl_cfg_context {
+	__u32 ctx_peer_node_id;
+	__u32 ctx_volume;
+	char ctx_resource_name[128];
+	__u32 ctx_resource_name_len;
+	char ctx_my_addr[128];
+	__u32 ctx_my_addr_len;
+	char ctx_peer_addr[128];
+	__u32 ctx_peer_addr_len;
+	char ctx_conn_name[SHARED_SECRET_MAX];
+	__u32 ctx_conn_name_len;
+};
+
+struct drbd_disk_conf {
+	char backing_dev[128];
+	__u32 backing_dev_len;
+	char meta_dev[128];
+	__u32 meta_dev_len;
+	__s32 meta_dev_idx;
+	__u64 disk_size;
+	__u32 on_io_error;
+	__s32 resync_after;
+	__u32 al_extents;
+	unsigned char disk_barrier;
+	unsigned char disk_flushes;
+	unsigned char disk_drain;
+	unsigned char md_flushes;
+	__u32 disk_timeout;
+	__u32 read_balancing;
+	__u32 unplug_watermark;
+	__u32 rs_discard_granularity;
+	unsigned char al_updates;
+	unsigned char discard_zeroes_if_aligned;
+	unsigned char disable_write_same;
+	unsigned char d_bitmap;
+};
+
+struct drbd_res_opts {
+	char cpu_mask[DRBD_CPU_MASK_SIZE];
+	__u32 cpu_mask_len;
+	__u32 on_no_data;
+	unsigned char auto_promote;
+	__u32 node_id;
+	__u32 peer_ack_window;
+	__u32 twopc_timeout;
+	__u32 twopc_retry_timeout;
+	__u32 peer_ack_delay;
+	__u32 auto_promote_timeout;
+	__u32 nr_requests;
+	__s32 quorum;
+	__u32 on_no_quorum;
+	__s32 quorum_min_redundancy;
+	__u32 on_susp_primary_outdated;
+	unsigned char drbd8_compat_mode;
+	unsigned char explicit_drbd8_compat;
+};
+
+struct drbd_net_conf {
+	char shared_secret[SHARED_SECRET_MAX];
+	__u32 shared_secret_len;
+	char cram_hmac_alg[SHARED_SECRET_MAX];
+	__u32 cram_hmac_alg_len;
+	char integrity_alg[SHARED_SECRET_MAX];
+	__u32 integrity_alg_len;
+	char verify_alg[SHARED_SECRET_MAX];
+	__u32 verify_alg_len;
+	char csums_alg[SHARED_SECRET_MAX];
+	__u32 csums_alg_len;
+	__u32 wire_protocol;
+	__u32 connect_int;
+	__u32 timeout;
+	__u32 ping_int;
+	__u32 ping_timeo;
+	__u32 sndbuf_size;
+	__u32 rcvbuf_size;
+	__u32 ko_count;
+	__u32 max_epoch_size;
+	__u32 after_sb_0p;
+	__u32 after_sb_1p;
+	__u32 after_sb_2p;
+	__u32 rr_conflict;
+	__u32 on_congestion;
+	__u32 cong_fill;
+	__u32 cong_extents;
+	unsigned char two_primaries;
+	unsigned char tcp_cork;
+	unsigned char always_asbp;
+	unsigned char use_rle;
+	__u32 fencing_policy;
+	char name[SHARED_SECRET_MAX];
+	__u32 name_len;
+	unsigned char csums_after_crash_only;
+	__u32 sock_check_timeo;
+	char transport_name[SHARED_SECRET_MAX];
+	__u32 transport_name_len;
+	__u32 max_buffers;
+	unsigned char allow_remote_read;
+	unsigned char tls;
+	__s32 tls_privkey;
+	__s32 tls_certificate;
+	__s32 tls_keyring;
+	unsigned char load_balance_paths;
+	__u32 rdma_ctrl_rcvbuf_size;
+	__u32 rdma_ctrl_sndbuf_size;
+};
+
+struct drbd_set_role_parms {
+	unsigned char force;
+};
+
+struct drbd_resize_parms {
+	__u64 resize_size;
+	unsigned char resize_force;
+	unsigned char no_resync;
+	__u32 al_stripes;
+	__u32 al_stripe_size;
+};
+
+struct drbd_start_ov_parms {
+	__u64 ov_start_sector;
+	__u64 ov_stop_sector;
+};
+
+struct drbd_new_c_uuid_parms {
+	unsigned char clear_bm;
+	unsigned char force_resync;
+};
+
+struct drbd_timeout_parms {
+	__u32 timeout_type;
+};
+
+struct drbd_disconnect_parms {
+	unsigned char force_disconnect;
+};
+
+struct drbd_detach_parms {
+	unsigned char force_detach;
+	unsigned char intentional_diskless_detach;
+};
+
+struct drbd_device_conf {
+	__u32 max_bio_size;
+	unsigned char intentional_diskless;
+	__u32 block_size;
+	__u32 discard_granularity;
+};
+
+struct drbd_resource_info {
+	__u32 res_role;
+	unsigned char res_susp;
+	unsigned char res_susp_nod;
+	unsigned char res_susp_fen;
+	unsigned char res_susp_quorum;
+	unsigned char res_fail_io;
+#ifdef CONFIG_DRBD_COMPAT_84
+	/*
+	 * The pre-transition values of the four fields above, for the v1
+	 * dialect's fused DRBD_EVENT (drbd_nl_84.c's compat84_emit_event()):
+	 * 8.4's ST-prev/ST-new event lines need a real "before" state, not
+	 * just the "after" state every other field here already carries.
+	 * Filled only at notify_resource_state_change()'s NOTIFY_CHANGE call
+	 * site (drbd_state.c); left unset (and unread) everywhere else,
+	 * including every notify_resource_state() call the v1 dialect never
+	 * sees a fused event for.
+	 */
+	__u32 old_res_role;
+	unsigned char old_res_susp;
+	unsigned char old_res_susp_nod;
+	unsigned char old_res_susp_fen;
+#endif
+};
+
+struct drbd_device_info {
+	__u32 dev_disk_state;
+	unsigned char is_intentional_diskless;
+	unsigned char dev_has_quorum;
+	unsigned char dev_is_open;
+	char backing_dev_path[128];
+	__u32 backing_dev_path_len;
+#ifdef CONFIG_DRBD_COMPAT_84
+	/* dev_disk_state's pre-transition value; see resource_info above. */
+	__u32 old_dev_disk_state;
+#endif
+};
+
+struct drbd_connection_info {
+	__u32 conn_connection_state;
+	__u32 conn_role;
+#ifdef CONFIG_DRBD_COMPAT_84
+	/* Pre-transition values of the two fields above; see resource_info
+	 * above.
+	 */
+	__u32 old_conn_connection_state;
+	__u32 old_conn_role;
+#endif
+};
+
+struct drbd_peer_device_info {
+	__u32 peer_repl_state;
+	__u32 peer_disk_state;
+	__u32 peer_resync_susp_user;
+	__u32 peer_resync_susp_peer;
+	__u32 peer_resync_susp_dependency;
+	unsigned char peer_is_intentional_diskless;
+	__u32 peer_resync_susp_max_parallel;
+#ifdef CONFIG_DRBD_COMPAT_84
+	/* peer_repl_state's and peer_disk_state's pre-transition values; see
+	 * resource_info above. old_peer_resync_susp_user/_peer are the exact
+	 * pre-transition values of the two fields above them; old_peer_
+	 * resync_susp_dependency approximates peer_resync_susp_dependency's
+	 * combined derivation (resync_susp_dependency || resync_susp_other_c
+	 * || (sync-source with an inconsistent local disk)) with only its
+	 * first two terms, since the third needs the sibling device's
+	 * pre-transition disk state, not reachable from a peer-device-only
+	 * snapshot without widening the notification callback's signature.
+	 */
+	__u32 old_peer_repl_state;
+	__u32 old_peer_disk_state;
+	__u32 old_peer_resync_susp_user;
+	__u32 old_peer_resync_susp_peer;
+	__u32 old_peer_resync_susp_dependency;
+#endif
+};
+
+struct drbd_resource_statistics {
+	__u32 res_stat_write_ordering;
+};
+
+struct drbd_device_statistics {
+	__u64 dev_size;
+	__u64 dev_read;
+	__u64 dev_write;
+	__u64 dev_al_writes;
+	__u64 dev_bm_writes;
+	__u32 dev_upper_pending;
+	__u32 dev_lower_pending;
+	unsigned char dev_upper_blocked;
+	unsigned char dev_lower_blocked;
+	unsigned char dev_al_suspended;
+	__u64 dev_exposed_data_uuid;
+	__u64 dev_current_uuid;
+	__u32 dev_disk_flags;
+	char history_uuids[HISTORY_UUIDS_SIZE];
+	__u32 history_uuids_len;
+};
+
+struct drbd_connection_statistics {
+	unsigned char conn_congested;
+	__u64 ap_in_flight;
+	__u64 rs_in_flight;
+};
+
+struct drbd_peer_device_statistics {
+	__u64 peer_dev_received;
+	__u64 peer_dev_sent;
+	__u32 peer_dev_pending;
+	__u32 peer_dev_unacked;
+	__u64 peer_dev_out_of_sync;
+	__u64 peer_dev_resync_failed;
+	__u64 peer_dev_bitmap_uuid;
+	__u32 peer_dev_flags;
+	__u64 peer_dev_rs_total;
+	__u64 peer_dev_ov_start_sector;
+	__u64 peer_dev_ov_stop_sector;
+	__u64 peer_dev_ov_position;
+	__u64 peer_dev_ov_left;
+	__u64 peer_dev_ov_skipped;
+	__u64 peer_dev_rs_same_csum;
+	__u64 peer_dev_rs_dt_start_ms;
+	__u64 peer_dev_rs_paused_ms;
+	__u64 peer_dev_rs_dt0_ms;
+	__u64 peer_dev_rs_db0_sectors;
+	__u64 peer_dev_rs_dt1_ms;
+	__u64 peer_dev_rs_db1_sectors;
+	__u32 peer_dev_rs_c_sync_rate;
+	__u64 peer_dev_uuid_flags;
+};
+
+struct drbd_nl_notification_header {
+	__u32 nh_type;
+};
+
+struct drbd_nl_helper_info {
+	char helper_name[32];
+	__u32 helper_name_len;
+	__u32 helper_status;
+};
+
+struct drbd_invalidate_parms {
+	__s32 sync_from_peer_node_id;
+	unsigned char reset_bitmap;
+};
+
+struct drbd_forget_peer_parms {
+	__s32 forget_peer_node_id;
+};
+
+struct drbd_peer_device_conf {
+	__u32 resync_rate;
+	__u32 c_plan_ahead;
+	__u32 c_delay_target;
+	__u32 c_fill_target;
+	__u32 c_max_rate;
+	__u32 c_min_rate;
+	unsigned char bitmap;
+	unsigned char resync_without_replication;
+	unsigned char peer_tiebreaker;
+};
+
+struct drbd_path_parms {
+	char my_addr[128];
+	__u32 my_addr_len;
+	char peer_addr[128];
+	__u32 peer_addr_len;
+};
+
+struct drbd_connect_parms {
+	unsigned char tentative;
+	unsigned char discard_my_data;
+};
+
+struct drbd_nl_path_info {
+	unsigned char path_established;
+};
+
+struct drbd_rename_resource_parms {
+	char new_resource_name[128];
+	__u32 new_resource_name_len;
+};
+
+struct drbd_rename_resource_info {
+	char res_new_name[128];
+	__u32 res_new_name_len;
+};
+
+struct drbd_invalidate_peer_parms {
+	unsigned char p_reset_bitmap;
+};
+
+struct drbd_suspend_io_parms {
+	unsigned char bdev_freeze;
+};
+
+/*
+ * Neutral config defaults, shared by every dialect: default-value setters
+ * for the structs above that have optional fields. The core calls these
+ * before parsing a partial request, regardless of which dialect received
+ * it; the definitions live in linux/drbd_nl_defaults.c, which is always
+ * built into the module regardless of dialect configuration.
+ */
+void drbd_set_nl_cfg_context_defaults(struct drbd_nl_cfg_context *x);
+void drbd_set_disk_conf_defaults(struct drbd_disk_conf *x);
+void drbd_set_res_opts_defaults(struct drbd_res_opts *x);
+void drbd_set_net_conf_defaults(struct drbd_net_conf *x);
+void drbd_set_resize_parms_defaults(struct drbd_resize_parms *x);
+void drbd_set_detach_parms_defaults(struct drbd_detach_parms *x);
+void drbd_set_device_conf_defaults(struct drbd_device_conf *x);
+void drbd_set_invalidate_parms_defaults(struct drbd_invalidate_parms *x);
+void drbd_set_forget_peer_parms_defaults(struct drbd_forget_peer_parms *x);
+void drbd_set_peer_device_conf_defaults(struct drbd_peer_device_conf *x);
+void drbd_set_connect_parms_defaults(struct drbd_connect_parms *x);
+void drbd_set_invalidate_peer_parms_defaults(struct drbd_invalidate_peer_parms *x);
+void drbd_set_suspend_io_parms_defaults(struct drbd_suspend_io_parms *x);
+
+#endif /* __DRBD_NL_TYPES_H */
diff --git a/include/uapi/linux/drbd.h b/include/uapi/linux/drbd.h
index b7d6b1c52df0..e0e124d57c22 100644
--- a/include/uapi/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -1,10 +1,11 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
  */
 
-#ifndef _UAPI_LINUX_DRBD_H
-#define _UAPI_LINUX_DRBD_H
+#ifndef DRBD_H
+#define DRBD_H
+
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
@@ -14,8 +15,7 @@ enum drbd_io_error_p {
 	EP_DETACH
 };
 
-enum drbd_fencing_p {
-	FP_NOT_AVAIL = -1, /* Not a policy */
+enum drbd_fencing_policy {
 	FP_DONT_CARE = 0,
 	FP_RESOURCE,
 	FP_STONITH
@@ -38,7 +38,9 @@ enum drbd_after_sb_p {
 	ASB_CONSENSUS,
 	ASB_DISCARD_SECONDARY,
 	ASB_CALL_HELPER,
-	ASB_VIOLENTLY
+	ASB_VIOLENTLY,
+	ASB_RETRY_CONNECT,
+	ASB_AUTO_DISCARD,
 };
 
 enum drbd_on_no_data {
@@ -46,6 +48,16 @@ enum drbd_on_no_data {
 	OND_SUSPEND_IO
 };
 
+enum drbd_on_no_quorum {
+	ONQ_IO_ERROR = OND_IO_ERROR,
+	ONQ_SUSPEND_IO = OND_SUSPEND_IO
+};
+
+enum drbd_on_susp_primary_outdated {
+	SPO_DISCONNECT,
+	SPO_FORCE_SECONDARY,
+};
+
 enum drbd_on_congestion {
 	OC_BLOCK,
 	OC_PULL_AHEAD,
@@ -66,6 +78,11 @@ enum drbd_read_balancing {
 	RB_1M_STRIPING,
 };
 
+/* Windows km/dderror.h has that a 0L */
+#ifdef NO_ERROR
+#undef NO_ERROR
+#endif
+
 /* KEEP the order, do not delete or insert. Only append. */
 enum drbd_ret_code {
 	ERR_CODE_BASE		= 100,
@@ -109,7 +126,7 @@ enum drbd_ret_code {
 	ERR_CSUMS_ALG_ND	= 145, /* DRBD 8.2 only */
 	ERR_VERIFY_ALG		= 146, /* DRBD 8.2 only */
 	ERR_VERIFY_ALG_ND	= 147, /* DRBD 8.2 only */
-	ERR_CSUMS_RESYNC_RUNNING= 148, /* DRBD 8.2 only */
+	ERR_CSUMS_RESYNC_RUNNING = 148, /* DRBD 8.2 only */
 	ERR_VERIFY_RUNNING	= 149, /* DRBD 8.2 only */
 	ERR_DATA_NOT_CURRENT	= 150,
 	ERR_CONNECTED		= 151, /* DRBD 8.3 only */
@@ -132,6 +149,13 @@ enum drbd_ret_code {
 	ERR_MD_LAYOUT_TOO_SMALL = 168,
 	ERR_MD_LAYOUT_NO_FIT    = 169,
 	ERR_IMPLICIT_SHRINK     = 170,
+	ERR_INVALID_PEER_NODE_ID = 171,
+	ERR_CREATE_TRANSPORT    = 172,
+	ERR_LOCAL_AND_PEER_ADDR = 173,
+	ERR_ALREADY_EXISTS	= 174,
+	ERR_APV_TOO_LOW         = 175,
+	ERR_PATH_COLLISION      = 176,
+
 	/* insert new ones above this line */
 	AFTER_LAST_ERR_CODE
 };
@@ -148,54 +172,65 @@ enum drbd_role {
 };
 
 /* The order of these constants is important.
- * The lower ones (<C_WF_REPORT_PARAMS) indicate
+ * The lower ones (< C_CONNECTED) indicate
  * that there is no socket!
- * >=C_WF_REPORT_PARAMS ==> There is a socket
+ * >= C_CONNECTED ==> There is a socket
  */
-enum drbd_conns {
+enum drbd_conn_state {
 	C_STANDALONE,
-	C_DISCONNECTING,  /* Temporal state on the way to StandAlone. */
+	C_DISCONNECTING,  /* Temporary state on the way to C_STANDALONE. */
 	C_UNCONNECTED,    /* >= C_UNCONNECTED -> inc_net() succeeds */
 
-	/* These temporal states are all used on the way
-	 * from >= C_CONNECTED to Unconnected.
+	/* These temporary states are used on the way
+	 * from C_CONNECTED to C_UNCONNECTED.
 	 * The 'disconnect reason' states
-	 * I do not allow to change between them. */
+	 * I do not allow to change between them.
+	 */
 	C_TIMEOUT,
 	C_BROKEN_PIPE,
 	C_NETWORK_FAILURE,
 	C_PROTOCOL_ERROR,
 	C_TEAR_DOWN,
 
-	C_WF_CONNECTION,
-	C_WF_REPORT_PARAMS, /* we have a socket */
-	C_CONNECTED,      /* we have introduced each other */
-	C_STARTING_SYNC_S,  /* starting full sync by admin request. */
-	C_STARTING_SYNC_T,  /* starting full sync by admin request. */
-	C_WF_BITMAP_S,
-	C_WF_BITMAP_T,
-	C_WF_SYNC_UUID,
+	C_CONNECTING,
+
+	C_CONNECTED, /* we have a socket */
+
+	C_MASK = 31,
+};
+
+enum drbd_repl_state {
+	L_NEGOTIATING = C_CONNECTED, /* used for peer_device->negotiation_result only */
+	L_OFF = C_CONNECTED,
+
+	L_ESTABLISHED,      /* we have introduced each other */
+	L_STARTING_SYNC_S,  /* starting full sync by admin request. */
+	L_STARTING_SYNC_T,  /* starting full sync by admin request. */
+	L_WF_BITMAP_S,
+	L_WF_BITMAP_T,
+	L_WF_SYNC_UUID,
 
 	/* All SyncStates are tested with this comparison
-	 * xx >= C_SYNC_SOURCE && xx <= C_PAUSED_SYNC_T */
-	C_SYNC_SOURCE,
-	C_SYNC_TARGET,
-	C_VERIFY_S,
-	C_VERIFY_T,
-	C_PAUSED_SYNC_S,
-	C_PAUSED_SYNC_T,
-
-	C_AHEAD,
-	C_BEHIND,
-
-	C_MASK = 31
+	 * xx >= L_SYNC_SOURCE && xx <= L_PAUSED_SYNC_T
+	 */
+	L_SYNC_SOURCE,
+	L_SYNC_TARGET,
+	L_VERIFY_S,
+	L_VERIFY_T,
+	L_PAUSED_SYNC_S,
+	L_PAUSED_SYNC_T,
+
+	L_AHEAD,
+	L_BEHIND,
+	L_NEG_NO_RESULT = L_BEHIND,  /* used for peer_device->negotiation_result only */
 };
 
 enum drbd_disk_state {
 	D_DISKLESS,
 	D_ATTACHING,      /* In the process of reading the meta-data */
+	D_DETACHING,      /* Added in protocol version 110 */
 	D_FAILED,         /* Becomes D_DISKLESS as soon as we told it the peer */
-			  /* when >= D_FAILED it is legal to access mdev->ldev */
+			  /* when >= D_FAILED it is legal to access device->ldev */
 	D_NEGOTIATING,    /* Late attaching state, we need to talk to the peer */
 	D_INCONSISTENT,
 	D_OUTDATED,
@@ -216,31 +251,33 @@ union drbd_state {
  */
 	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
-		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
-		unsigned conn:5 ;   /* 17/32	 cstates */
-		unsigned disk:4 ;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
-		unsigned pdsk:4 ;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
-		unsigned susp:1 ;   /* 2/2	 IO suspended no/yes (by user) */
-		unsigned aftr_isp:1 ; /* isp .. imposed sync pause */
-		unsigned peer_isp:1 ;
-		unsigned user_isp:1 ;
-		unsigned susp_nod:1 ; /* IO suspended because no data */
-		unsigned susp_fen:1 ; /* IO suspended because fence peer handler runs*/
-		unsigned _pad:9;   /* 0	 unused */
+		unsigned role:2;   /* 3/4	 primary/secondary/unknown */
+		unsigned peer:2;   /* 3/4	 primary/secondary/unknown */
+		unsigned conn:5;   /* 17/32	 cstates */
+		unsigned disk:4;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
+		unsigned pdsk:4;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
+		unsigned susp:1;   /* 2/2	 IO suspended no/yes (by user) */
+		unsigned aftr_isp:1; /* isp .. imposed sync pause */
+		unsigned peer_isp:1;
+		unsigned user_isp:1;
+		unsigned susp_nod:1; /* IO suspended because no data */
+		unsigned susp_fen:1; /* IO suspended because fence peer handler runs*/
+		unsigned quorum:1;
+		unsigned _pad:8;   /* 0	 unused */
 #elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned _pad:9;
-		unsigned susp_fen:1 ;
-		unsigned susp_nod:1 ;
-		unsigned user_isp:1 ;
-		unsigned peer_isp:1 ;
-		unsigned aftr_isp:1 ; /* isp .. imposed sync pause */
-		unsigned susp:1 ;   /* 2/2	 IO suspended  no/yes */
-		unsigned pdsk:4 ;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
-		unsigned disk:4 ;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
-		unsigned conn:5 ;   /* 17/32	 cstates */
-		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
-		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
+		unsigned _pad:8;
+		unsigned quorum:1;
+		unsigned susp_fen:1;
+		unsigned susp_nod:1;
+		unsigned user_isp:1;
+		unsigned peer_isp:1;
+		unsigned aftr_isp:1; /* isp .. imposed sync pause */
+		unsigned susp:1;   /* 2/2	 IO suspended  no/yes */
+		unsigned pdsk:4;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
+		unsigned disk:4;   /* 8/16	 from D_DISKLESS to D_UP_TO_DATE */
+		unsigned conn:5;   /* 17/32	 cstates */
+		unsigned peer:2;   /* 3/4	 primary/secondary/unknown */
+		unsigned role:2;   /* 3/4	 primary/secondary/unknown */
 #else
 # error "this endianness is not supported"
 #endif
@@ -267,29 +304,70 @@ enum drbd_state_rv {
 	SS_DEVICE_IN_USE = -12,
 	SS_NO_NET_CONFIG = -13,
 	SS_NO_VERIFY_ALG = -14,       /* drbd-8.2 only */
-	SS_NEED_CONNECTION = -15,    /* drbd-8.2 only */
+	SS_NEED_CONNECTION = -15, /* Need connection this state change affects to be connected */
 	SS_LOWER_THAN_OUTDATED = -16,
-	SS_NOT_SUPPORTED = -17,      /* drbd-8.2 only */
+	SS_NOT_SUPPORTED = -17,
 	SS_IN_TRANSIENT_STATE = -18,  /* Retry after the next state change */
 	SS_CONCURRENT_ST_CHG = -19,   /* Concurrent cluster side state change! */
 	SS_O_VOL_PEER_PRI = -20,
-	SS_OUTDATE_WO_CONN = -21,
-	SS_AFTER_LAST_ERROR = -22,    /* Keep this at bottom */
+	SS_INTERRUPTED = -21,	/* interrupted in stable_state_change() */
+	SS_PRIMARY_READER = -22,
+	SS_TIMEOUT = -23,
+	SS_WEAKLY_CONNECTED = -24,
+	SS_NO_QUORUM = -25,
+	SS_ATTACH_NO_BITMAP = -26,
+	SS_HANDSHAKE_DISCONNECT = -27,
+	SS_HANDSHAKE_RETRY = -28,
+	SS_AFTER_LAST_ERROR = -29,    /* Keep this at bottom */
 };
 
 #define SHARED_SECRET_MAX 64
 
-#define MDF_CONSISTENT		(1 << 0)
-#define MDF_PRIMARY_IND		(1 << 1)
-#define MDF_CONNECTED_IND	(1 << 2)
-#define MDF_FULL_SYNC		(1 << 3)
-#define MDF_WAS_UP_TO_DATE	(1 << 4)
-#define MDF_PEER_OUT_DATED	(1 << 5)
-#define MDF_CRASHED_PRIMARY	(1 << 6)
-#define MDF_AL_CLEAN		(1 << 7)
-#define MDF_AL_DISABLED		(1 << 8)
+/* Meta data feature flags */
+#define DRBD_MDFF_DIVERGENCE_BITMAP (1ULL << 0)
+#define DRBD_MDFF_BITMAP_AUTHORITATIVE (1ULL << 1) /* MDF_PEER_BITMAP_AUTHORITATIVE is maintained */
+
+enum mdf_flag {
+	MDF_CONSISTENT =	1 << 0,
+	MDF_PRIMARY_IND =	1 << 1,
+	MDF_WAS_UP_TO_DATE =	1 << 4,
+	MDF_CRASHED_PRIMARY =	1 << 6,
+	MDF_AL_CLEAN =		1 << 7,
+	MDF_AL_DISABLED =       1 << 8,
+	MDF_PRIMARY_LOST_QUORUM = 1 << 9,
+	MDF_HAVE_QUORUM =       1 << 10,
+};
+
+/* Bit numbers, for the atomic bit operations on struct drbd_peer_md flags.
+ * Maximum value 31 because the flags are persisted as be32.
+ */
+enum mdf_peer_flag_bit {
+	__MDF_PEER_CONNECTED =	0,
+	__MDF_PEER_OUTDATED =	1,
+	__MDF_PEER_FENCING =	2,
+	__MDF_PEER_FULL_SYNC =	3,
+	__MDF_PEER_DEVICE_SEEN = 4,
+	__MDF_PEER_DIVERGENCE_BITMAP = 5, /* bitmap fully records divergence; safe to copy from */
+	__MDF_PEER_BITMAP_AUTHORITATIVE = 6, /* out-of-sync bits were set for blocks the peer lacks, not by a resync or an invalidate */
+	__MDF_NODE_EXISTS =	16,
+	__MDF_HAVE_BITMAP =	31,  /* For in core use; no meaning when persisted */
+};
+
+/* Masks, for the on-disk and netlink representations. */
+enum mdf_peer_flag {
+	MDF_PEER_CONNECTED =	1U << __MDF_PEER_CONNECTED,
+	MDF_PEER_OUTDATED =	1U << __MDF_PEER_OUTDATED,
+	MDF_PEER_FENCING =	1U << __MDF_PEER_FENCING,
+	MDF_PEER_FULL_SYNC =	1U << __MDF_PEER_FULL_SYNC,
+	MDF_PEER_DEVICE_SEEN =	1U << __MDF_PEER_DEVICE_SEEN,
+	MDF_PEER_DIVERGENCE_BITMAP = 1U << __MDF_PEER_DIVERGENCE_BITMAP,
+	MDF_PEER_BITMAP_AUTHORITATIVE = 1U << __MDF_PEER_BITMAP_AUTHORITATIVE,
+	MDF_NODE_EXISTS =       1U << __MDF_NODE_EXISTS,
+	MDF_HAVE_BITMAP =       1U << __MDF_HAVE_BITMAP,
+};
 
-#define MAX_PEERS 32
+#define DRBD_PEERS_MAX 32
+#define DRBD_NODE_ID_MAX DRBD_PEERS_MAX
 
 enum drbd_uuid_index {
 	UI_CURRENT,
@@ -301,10 +379,17 @@ enum drbd_uuid_index {
 	UI_EXTENDED_SIZE   /* Everything. */
 };
 
-#define HISTORY_UUIDS MAX_PEERS
+#define HISTORY_UUIDS_V08 (UI_HISTORY_END - UI_HISTORY_START + 1)
+#define HISTORY_UUIDS DRBD_PEERS_MAX
+#define HISTORY_UUIDS_SIZE (HISTORY_UUIDS * sizeof(__u64))
 
+/*
+ * Wire sizes of the uuid attributes of the "drbd" netlink family at
+ * version 1, as served by drbd_nl_84.c. Same values as the 8.4 driver's:
+ * UI_SIZE and HISTORY_UUIDS are identical in 8.4 and 9.
+ */
 #define DRBD_NL_UUIDS_SIZE		(UI_SIZE * sizeof(__u64))
-#define DRBD_NL_HISTORY_UUIDS_SIZE	(HISTORY_UUIDS * sizeof(__u64))
+#define DRBD_NL_HISTORY_UUIDS_SIZE	HISTORY_UUIDS_SIZE
 
 enum drbd_timeout_flag {
 	UT_DEFAULT      = 0,
@@ -312,6 +397,16 @@ enum drbd_timeout_flag {
 	UT_PEER_OUTDATED = 2,
 };
 
+#define UUID_JUST_CREATED ((__u64)4)
+#define UUID_PRIMARY ((__u64)1)
+
+enum write_ordering_e {
+	WO_NONE,
+	WO_DRAIN_IO,
+	WO_BDEV_FLUSH,
+	WO_BIO_BARRIER
+};
+
 enum drbd_notification_type {
 	NOTIFY_EXISTS,
 	NOTIFY_CREATE,
@@ -319,11 +414,13 @@ enum drbd_notification_type {
 	NOTIFY_DESTROY,
 	NOTIFY_CALL,
 	NOTIFY_RESPONSE,
+	NOTIFY_RENAME,
 
 	NOTIFY_CONTINUES = 0x8000,
 	NOTIFY_FLAGS = NOTIFY_CONTINUES,
 };
 
+/* These values are part of the ABI! */
 enum drbd_peer_state {
 	P_INCONSISTENT = 3,
 	P_OUTDATED = 4,
@@ -332,15 +429,6 @@ enum drbd_peer_state {
 	P_FENCING = 7,
 };
 
-#define UUID_JUST_CREATED ((__u64)4)
-
-enum write_ordering_e {
-	WO_NONE,
-	WO_DRAIN_IO,
-	WO_BDEV_FLUSH,
-	WO_BIO_BARRIER
-};
-
 /* magic numbers used in meta data and network packets */
 #define DRBD_MAGIC 0x83740267
 #define DRBD_MAGIC_BIG 0x835a
@@ -349,18 +437,24 @@ enum write_ordering_e {
 #define DRBD_MD_MAGIC_07   (DRBD_MAGIC+3)
 #define DRBD_MD_MAGIC_08   (DRBD_MAGIC+4)
 #define DRBD_MD_MAGIC_84_UNCLEAN	(DRBD_MAGIC+5)
-
-
-/* how I came up with this magic?
- * base64 decode "actlog==" ;) */
-#define DRBD_AL_MAGIC 0x69cb65a2
+#define DRBD_MD_MAGIC_09   (DRBD_MAGIC+6)
 
 /* these are of type "int" */
 #define DRBD_MD_INDEX_INTERNAL -1
 #define DRBD_MD_INDEX_FLEX_EXT -2
 #define DRBD_MD_INDEX_FLEX_INT -3
 
-#define DRBD_CPU_MASK_SIZE 32
+/*
+ * This is the maximum string length accepted by drbdadm.
+ * It allows a full mask for up to 908 CPUs.
+ */
+#define DRBD_CPU_MASK_SIZE 256
+
+#define DRBD_MAX_BIO_SIZE (1U << 20)
+
+#define QOU_OFF 0
+#define QOU_MAJORITY 1024
+#define QOU_ALL 1025
 
 /**
  * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
@@ -373,19 +467,13 @@ enum write_ordering_e {
  *     is used instead.
  * @flags: possible operation modifiers (relevant only for user->kernel):
  *     DRBD_GENL_F_SET_DEFAULTS
- * @volume:
- *     When creating a new minor (adding it to a resource), the resource needs
- *     to know which volume number within the resource this is supposed to be.
- *     The volume number corresponds to the same volume number on the remote side,
- *     whereas the minor number on the remote side may be different
- *     (union with flags).
  * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
  */
 struct drbd_genlmsghdr {
 	__u32 minor;
 	union {
-		__u32 flags;
-		__s32 ret_code;
+	__u32 flags;
+	__s32 ret_code;
 	};
 };
 
@@ -394,12 +482,11 @@ enum {
 	DRBD_GENL_F_SET_DEFAULTS = 1,
 };
 
-enum drbd_state_info_bcast_reason {
-	SIB_GET_STATUS_REPLY = 1,
-	SIB_STATE_CHANGE = 2,
-	SIB_HELPER_PRE = 3,
-	SIB_HELPER_POST = 4,
-	SIB_SYNC_PROGRESS = 5,
-};
+/*
+ * DRBD_GENLA_F_MANDATORY: netlink ignores attributes it does not know
+ * about by default. This flag in nlattr->nla_type indicates that this
+ * attribute must not be ignored. Checked and stripped in pre_doit.
+ */
+#define DRBD_GENLA_F_MANDATORY (1 << 14)
 
-#endif /* _UAPI_LINUX_DRBD_H */
+#endif
diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index bba0a0aa8792..41e772c9dc12 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -10,10 +10,10 @@
  * feedback about nonsense settings for certain configurable values.
  */
 
-#ifndef _UAPI_LINUX_DRBD_LIMITS_H
-#define _UAPI_LINUX_DRBD_LIMITS_H
+#ifndef DRBD_LIMITS_H
+#define DRBD_LIMITS_H 1
 
-#include <linux/drbd.h>
+#define DEBUG_RANGE_CHECK 0
 
 #define DRBD_MINOR_COUNT_MIN 1U
 #define DRBD_MINOR_COUNT_MAX 255U
@@ -51,7 +51,8 @@
 
 /* net { */
   /* timeout, unit centi seconds
-   * more than one minute timeout is not useful */
+   * more than one minute timeout is not useful
+   */
 #define DRBD_TIMEOUT_MIN 1U
 #define DRBD_TIMEOUT_MAX 600U
 #define DRBD_TIMEOUT_DEF 60U       /* 6 seconds */
@@ -63,7 +64,7 @@
 #define DRBD_DISK_TIMEOUT_DEF 0U    /* disabled */
 #define DRBD_DISK_TIMEOUT_SCALE '1'
 
-  /* active connection retries when C_WF_CONNECTION */
+  /* active connection retries when C_CONNECTING */
 #define DRBD_CONNECT_INT_MIN 1U
 #define DRBD_CONNECT_INT_MAX 120U
 #define DRBD_CONNECT_INT_DEF 10U   /* seconds */
@@ -88,12 +89,12 @@
 #define DRBD_MAX_EPOCH_SIZE_SCALE '1'
 
 #define DRBD_SNDBUF_SIZE_MIN  0U
-#define DRBD_SNDBUF_SIZE_MAX  (128U << 20)
+#define DRBD_SNDBUF_SIZE_MAX  (128U<<20)
 #define DRBD_SNDBUF_SIZE_DEF  0U
 #define DRBD_SNDBUF_SIZE_SCALE '1'
 
 #define DRBD_RCVBUF_SIZE_MIN  0U
-#define DRBD_RCVBUF_SIZE_MAX  (128U << 20)
+#define DRBD_RCVBUF_SIZE_MAX  (128U<<20)
 #define DRBD_RCVBUF_SIZE_DEF  0U
 #define DRBD_RCVBUF_SIZE_SCALE '1'
 
@@ -110,11 +111,14 @@
 #define DRBD_UNPLUG_WATERMARK_SCALE '1'
 
   /* 0 is disabled.
-   * 200 should be more than enough even for very short timeouts */
+   * 200 should be more than enough even for very short timeouts
+   */
 #define DRBD_KO_COUNT_MIN  0U
 #define DRBD_KO_COUNT_MAX  200U
 #define DRBD_KO_COUNT_DEF  7U
 #define DRBD_KO_COUNT_SCALE '1'
+
+#define DRBD_ALLOW_REMOTE_READ_DEF 1U
 /* } */
 
 /* syncer { */
@@ -125,10 +129,12 @@
 #define DRBD_RESYNC_RATE_DEF 250U
 #define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
+  /* less than 67 would hit performance unnecessarily. */
 #define DRBD_AL_EXTENTS_MIN  67U
   /* we use u16 as "slot number", (u16)~0 is "FREE".
    * If you use >= 292 kB on-disk ring buffer,
-   * this is the maximum you can use: */
+   * this is the maximum you can use:
+   */
 #define DRBD_AL_EXTENTS_MAX  0xfffeU
 #define DRBD_AL_EXTENTS_DEF  1237U
 #define DRBD_AL_EXTENTS_SCALE '1'
@@ -143,7 +149,8 @@
 /* drbdsetup XY resize -d Z
  * you are free to reduce the device size to nothing, if you want to.
  * the upper limit with 64bit kernel, enough ram and flexible meta data
- * is 1 PiB, currently. */
+ * is 1 PiB, currently.
+ */
 /* DRBD_MAX_SECTORS */
 #define DRBD_DISK_SIZE_MIN  0LLU
 #define DRBD_DISK_SIZE_MAX  (1LLU * (2LLU << 40))
@@ -180,7 +187,7 @@
 #define DRBD_C_FILL_TARGET_DEF 100U /* Try to place 50KiB in socket send buffer during resync */
 #define DRBD_C_FILL_TARGET_SCALE 's'  /* sectors */
 
-#define DRBD_C_MAX_RATE_MIN     250U
+#define DRBD_C_MAX_RATE_MIN     0U
 #define DRBD_C_MAX_RATE_MAX     (4U << 20)
 #define DRBD_C_MAX_RATE_DEF     102400U
 #define DRBD_C_MAX_RATE_SCALE	'k'  /* kilobytes */
@@ -205,26 +212,75 @@
 #define DRBD_DISK_BARRIER_DEF	0U
 #define DRBD_DISK_FLUSHES_DEF	1U
 #define DRBD_DISK_DRAIN_DEF	1U
+#define DRBD_DISK_DISKLESS_DEF	0U
 #define DRBD_MD_FLUSHES_DEF	1U
 #define DRBD_TCP_CORK_DEF	1U
 #define DRBD_AL_UPDATES_DEF     1U
-
+#define DRBD_INVALIDATE_RESET_BITMAP_DEF 1U
 /* We used to ignore the discard_zeroes_data setting.
  * To not change established (and expected) behaviour,
  * by default assume that, for discard_zeroes_data=0,
  * we can make that an effective discard_zeroes_data=1,
- * if we only explicitly zero-out unaligned partial chunks. */
+ * if we only explicitly zero-out unaligned partial chunks.
+ */
 #define DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF 1U
 
 /* Some backends pretend to support WRITE SAME,
  * but fail such requests when they are actually submitted.
- * This is to tell DRBD to not even try. */
+ * This is to tell DRBD to not even try.
+ */
 #define DRBD_DISABLE_WRITE_SAME_DEF 0U
 
 #define DRBD_ALLOW_TWO_PRIMARIES_DEF	0U
 #define DRBD_ALWAYS_ASBP_DEF	0U
 #define DRBD_USE_RLE_DEF	1U
 #define DRBD_CSUMS_AFTER_CRASH_ONLY_DEF 0U
+#define DRBD_AUTO_PROMOTE_DEF	1U
+#define DRBD_BITMAP_DEF         1U
+#define DRBD_RESYNC_WITHOUT_REPLICATION_DEF 1U
+
+#define DRBD_NR_REQUESTS_MIN	4U
+#define DRBD_NR_REQUESTS_DEF	8000U
+#define DRBD_NR_REQUESTS_MAX	-1U
+#define DRBD_NR_REQUESTS_SCALE	'1'
+
+#define DRBD_MAX_BIO_SIZE_DEF	DRBD_MAX_BIO_SIZE
+#define DRBD_MAX_BIO_SIZE_MIN	(1U << 9)
+#define DRBD_MAX_BIO_SIZE_MAX	DRBD_MAX_BIO_SIZE
+#define DRBD_MAX_BIO_SIZE_SCALE '1'
+
+#define DRBD_NODE_ID_DEF		0U
+#define DRBD_NODE_ID_MIN		0U
+#ifndef DRBD_NODE_ID_MAX /* Is also defined in drbd.h */
+#define DRBD_NODE_ID_MAX		DRBD_PEERS_MAX
+#endif
+#define DRBD_NODE_ID_SCALE		'1'
+
+#define DRBD_PEER_ACK_WINDOW_DEF	4096U   /* 2 MiByte */
+#define DRBD_PEER_ACK_WINDOW_MIN	2048U   /* 1 MiByte */
+#define DRBD_PEER_ACK_WINDOW_MAX	204800U /* 100 MiByte */
+#define DRBD_PEER_ACK_WINDOW_SCALE 's' /* sectors*/
+
+#define DRBD_PEER_ACK_DELAY_DEF	100U    /* 100ms */
+#define DRBD_PEER_ACK_DELAY_MIN 1U
+#define DRBD_PEER_ACK_DELAY_MAX 10000U  /* 10 seconds */
+#define DRBD_PEER_ACK_DELAY_SCALE '1' /* milliseconds */
+
+/* Two-phase commit timeout (1/10 seconds). */
+#define DRBD_TWOPC_TIMEOUT_MIN	50U
+#define DRBD_TWOPC_TIMEOUT_MAX	600U
+#define DRBD_TWOPC_TIMEOUT_DEF	300U
+#define DRBD_TWOPC_TIMEOUT_SCALE '1'
+
+#define DRBD_TWOPC_RETRY_TIMEOUT_MIN 1U
+#define DRBD_TWOPC_RETRY_TIMEOUT_MAX 50U
+#define DRBD_TWOPC_RETRY_TIMEOUT_DEF 1U
+#define DRBD_TWOPC_RETRY_TIMEOUT_SCALE '1'
+
+#define DRBD_SYNC_FROM_NID_DEF -1
+#define DRBD_SYNC_FROM_NID_MIN -1
+#define DRBD_SYNC_FROM_NID_MAX DRBD_PEERS_MAX
+#define DRBD_SYNC_FROM_NID_SCALE '1'
 
 #define DRBD_AL_STRIPES_MIN     1U
 #define DRBD_AL_STRIPES_MAX     1024U
@@ -241,9 +297,58 @@
 #define DRBD_SOCKET_CHECK_TIMEO_DEF 0U
 #define DRBD_SOCKET_CHECK_TIMEO_SCALE '1'
 
+/* Auto promote timeout (1/10 seconds). */
+#define DRBD_AUTO_PROMOTE_TIMEOUT_MIN 0U
+#define DRBD_AUTO_PROMOTE_TIMEOUT_MAX 600U
+#define DRBD_AUTO_PROMOTE_TIMEOUT_DEF 20U
+#define DRBD_AUTO_PROMOTE_TIMEOUT_SCALE '1'
+
 #define DRBD_RS_DISCARD_GRANULARITY_MIN 0U
 #define DRBD_RS_DISCARD_GRANULARITY_MAX (1U<<20)  /* 1MiByte */
 #define DRBD_RS_DISCARD_GRANULARITY_DEF 0U     /* disabled by default */
 #define DRBD_RS_DISCARD_GRANULARITY_SCALE '1' /* bytes */
 
-#endif /* _UAPI_LINUX_DRBD_LIMITS_H */
+#define DRBD_QUORUM_MIN 0U
+#define DRBD_QUORUM_MAX QOU_ALL /* Note: user visible min/max different */
+#define DRBD_QUORUM_DEF QOU_OFF /* kernel min/max includes symbolic values */
+#define DRBD_QUORUM_SCALE '1' /* nodes */
+
+#define DRBD_BLOCK_SIZE_MIN 512
+#define DRBD_BLOCK_SIZE_MAX 4096
+#define DRBD_BLOCK_SIZE_DEF 512
+#define DRBD_BLOCK_SIZE_SCALE '1' /* Bytes */
+
+#define DRBD_DISCARD_GRANULARITY_SCALE '1'             /* Bytes */
+#define DRBD_DISCARD_GRANULARITY_MIN 0U                /* 0 = disable discards */
+#define DRBD_DISCARD_GRANULARITY_MAX (128U<<20)        /* 128 MiB, current DRBD_MAX_BATCH_BIO_SIZE */
+#define DRBD_DISCARD_GRANULARITY_DEF 0xFFFFFFFFU       /* sentinel: not configured; use legacy behavior */
+
+/* By default freeze IO, if set error all IOs as quick as possible */
+#define DRBD_ON_NO_QUORUM_DEF ONQ_SUSPEND_IO
+
+#define DRBD_ON_SUSP_PRI_OUTD_DEF SPO_DISCONNECT
+#define DRBD_DRBD8_COMPAT_MODE_DEF 0U
+
+#define DRBD_TLS_DEF 0U /* disabled by default */
+#define DRBD_TLS_PRIVKEY_DEF 0 /* disabled by default */
+#define DRBD_TLS_CERTIFICATE_DEF 0 /* disabled by default */
+#define DRBD_TLS_KEYRING_DEF 0 /* disabled by default */
+
+#define DRBD_LOAD_BALANCE_PATHS_DEF 0U
+
+#define DRBD_PEER_TIEBREAKER_DEF 1U
+
+#define DRBD_RDMA_CTRL_RCVBUF_SIZE_MIN  0U
+#define DRBD_RDMA_CTRL_RCVBUF_SIZE_MAX  (10U<<20)
+#define DRBD_RDMA_CTRL_RCVBUF_SIZE_DEF 0
+#define DRBD_RDMA_CTRL_RCVBUF_SIZE_SCALE '1'
+
+#define DRBD_RDMA_CTRL_SNDBUF_SIZE_MIN  0U
+#define DRBD_RDMA_CTRL_SNDBUF_SIZE_MAX  (10U<<20)
+#define DRBD_RDMA_CTRL_SNDBUF_SIZE_DEF 0
+#define DRBD_RDMA_CTRL_SNDBUF_SIZE_SCALE '1'
+
+/* Enable bdev_freeze/lockfs by default */
+#define DRBD_SUSPEND_IO_BDEV_FREEZE_DEF 1U
+
+#endif
-- 
2.55.0

