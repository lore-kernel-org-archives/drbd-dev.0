Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27346D08B
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301665; cv=none; b=pCEdQTnc3Xm1Q47ZfkN6a6r/UYXg2RxzRRVrjvJSWB8IIW5t8XHDvWziY8DnQgpU9EqOYqUUuWDhlIdBbdxyK1dgwUCFs1/bh6zMFF1PClmrA5JVccVHy2T8yci+MU4bCOdJDSqfQmFfBzB13au/Kt+isYxQIyRooLhCJe1RceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301665; c=relaxed/simple;
	bh=yJgfbebxXX2Tdf435deRcrqb57CjRQT4cbwFwJcdxV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlDTwmMpgNNJaxdKEgq4kk/ALi4vlSD9r7oFW5DCPmAZaIqO6vntp/sy+cj/we/PxjPL7Vp2xhyI7pb718ftl9Zq2J5/BwziLUK+WsVzxBOm0AWsyBTq7MoH+dOGxh7l8ny2eZtDi13OFn43d5bFMzbl6oFuYZhJSr390Q8GmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=qf90IuwK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="qf90IuwK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso7561855e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301633; x=1791906433; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcY6XZK2k0xPPgxGIWySw57hGnxwEyx8GxPn/gsY/jc=;
        b=qf90IuwKZ4UmhczTSdv63DiQE9ovkQopRBm5015qVX+wxV6XZ1oPo2nsP3Nthra6H7
         Lq1dx7Y0S5+jYdSV3sGULz6QCKEvRzD62+73p46wUuzSlKu8LKw7US7O/8RaodtYuTOS
         UZmGq6vVP3j48VpTphy0G7tRASFx41Q+gCxnhuN7MDAcXhCVA2k1Em3kgKnHjcCADEp/
         YB+HAaml1wEKUhiugxZ14+wd2ZIdvJZ/I7jURo0xWor5+HVUD7h40I8lwRDekj+rg+uc
         jWlqFjeB7A5pS6SAFjRZLjQXtj8rlfx1i2lCwJG27t4SxVYZo5/7yYLFMlqBHglZEb6C
         312A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301633; x=1791906433;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcY6XZK2k0xPPgxGIWySw57hGnxwEyx8GxPn/gsY/jc=;
        b=oZAya+njNYRIwNVJftuKWS3HKYR7q0qCniaeeG6nqkOmOx0QH/JLGDLfaQy2Txjk+D
         TjlZg42R4YCUixzF0kR6J5UmAn3AkXQTRue9ycmLYARwlCf9qpHS1k5ZC6uRj4mGJXnK
         30qWisuTntqBXEp1+ZOaPesM2cI3r1pUYfuhihqnpne78SwN2JaaxyFx30xCL71lqxVH
         ErxwVDkAWIBBegyAC2VkgGgqseFXCPgpJLgUOiqeYH54ec9u6vs3DF1Dt/vSDby5etWs
         1DR0D9Olho7DpZp2baLTCysAPxlcAwao1PWd1Yf0YwgFc4+muhgqBUiZEb4kOO86Kj0+
         IT3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKI9s3Gs5nxbdDzvVNb0OVPRBe6J/Td/+RU2dKlIHBzVyHGC9wnpdW/28qLeMWfaRAqS9KRU5NxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ny6gV74jX6vL0bBk9UjDE6yH8tjcKKKmJevufVau/fy7Cvd1qf
	CQmyIIiI3yGCrfebsVTqhgDljL92xABD7gEnY2Rv6vDJti0/3aGtC9EM+mD62BhWwtw=
X-Gm-Gg: AYBFou3F7okxB727ZslTPUbEfcYQjs+Q3IaqXLplV5nqGhJHtsidffe145AJ9YKTYLL
	RNxG2cB6hrzQiYhjI1UOLAEuFB7LEtBmVK1EJCt25EzLZmRWzxFOuIV8ATCQQOnQvW+K0SAUkia
	ks5sVyGVKlcQde3pP0rSmPxzTuQ3hqJmvcEN24GklhtDfjUBP0Ow06zvN/smT3JqY6jVPgJePAc
	zPxJ2sOkpilSf0hHrxgnDU2mIAkL+tgNgq+67zuKbEzc23WKS2eQvhIjLhiHmNW9NZo+7O0+GnU
	ZuBBZufW0gVDD9x1gkHbIvx8OcpvCJEHz7O3xAgaPmJC0ZLswqU1aXIsFPYBGwDM1/Eqrg0OAOA
	7a9UL2mysS3XOvSKWNOMK4msGyrw0QQ0CIeak38ll/j0MAq7YoHT8SN9ZC5rPnIR5KJxZIXnCOR
	xJzs5nLJmnwhv1lGQY+YmMNrzygtleHBM3zg0QlYpt7UUP5LGAcVH1RL8ZD+HX2hL7uG0ydnFUh
	SnSUaYCa6pX8V3eJm7+fCF0EWjYisGQ
X-Received: by 2002:a05:600c:190c:b0:4a0:1a18:b742 with SMTP id 5b1f17b1804b1-4a17b4f4527mr31182035e9.2.1791301632843;
        Tue, 06 Oct 2026 08:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:47:12 -0700 (PDT)
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
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [PATCH v2 19/20] drbd: update monitoring interfaces for multi-peer topology
Date: Tue,  6 Oct 2026 17:46:06 +0200
Message-ID: <20261006154607.3936501-20-christoph.boehmwalder@linbit.com>
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

Remove the /proc/drbd inline status display; detailed per-peer
monitoring moves to debugfs and netlink.
In DRBD 9, only version and build information is exposed in /proc/drbd.
The "legacy 8.4" compat mechanism restores compatible output to
/proc/drbd if necessary, ensuring userspace compat.

Restructure the debugfs tree from a fixed single-peer layout to a
per-connection hierarchy, reflecting that DRBD 9 resources can have
multiple simultaneous peers.

Request state display now iterates over all peer connections rather
than a single network state field.
Peer request tracking moves from per-device to per-connection lists,
and the transfer log is walked under RCU.

Timing statistics switch from jiffies to ktime for sub-millisecond
precision.

Transport buffer statistics are abstracted through a transport ops
callback instead of reaching into TCP internals.

New debugfs files expose two-phase commit state, transport details,
interval tree contents, activity log histograms, and per-peer resync
progress.

The connection and replication state string tables are split to match
the DRBD 9 split-state model, where transport-level connection state
and replication-level sync state are tracked separately per peer.

Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c  | 1721 +++++++++++++++++++++++-----
 drivers/block/drbd/drbd_interval.c |   37 +-
 drivers/block/drbd/drbd_proc.c     |  327 +-----
 drivers/block/drbd/drbd_strings.c  |  103 +-
 4 files changed, 1593 insertions(+), 595 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index b8e698dbb475..ef29b8833d6e 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -3,19 +3,21 @@
  * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
  */
 
-#define pr_fmt(fmt) "drbd debugfs: " fmt
+#define pr_fmt(fmt)	KBUILD_MODNAME " debugfs: " fmt
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/stat.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
+#include <generated/utsrelease.h>
+#include <linux/drbd_genl.h>
 
 #include "drbd_int.h"
 #include "drbd_req.h"
 #include "drbd_debugfs.h"
-
+#include "drbd_transport.h"
+#include "drbd_dax_pmem.h"
 
 /**********************************************************************
  * Whenever you change the file format, remember to bump the version. *
@@ -23,26 +25,48 @@
 
 static struct dentry *drbd_debugfs_root;
 static struct dentry *drbd_debugfs_version;
+static struct dentry *drbd_debugfs_refcounts;
 static struct dentry *drbd_debugfs_resources;
 static struct dentry *drbd_debugfs_minors;
+static struct dentry *drbd_debugfs_compat;
 
-static void seq_print_age_or_dash(struct seq_file *m, bool valid, unsigned long dt)
+static void seq_print_node_mask(struct seq_file *m, struct drbd_resource *resource, u64 nodes)
+{
+	struct drbd_connection *connection;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource) {
+		if (NODE_MASK(connection->peer_node_id) & nodes) {
+			char *name = rcu_dereference((connection)->transport.net_conf)->name;
+
+			seq_printf(m, "%s, ", name);
+		}
+	}
+	rcu_read_unlock();
+	seq_puts(m, "\n");
+}
+
+#ifdef CONFIG_DRBD_TIMING_STATS
+static void seq_print_age_or_dash(struct seq_file *m, bool valid, ktime_t dt)
 {
 	if (valid)
-		seq_printf(m, "\t%d", jiffies_to_msecs(dt));
+		seq_printf(m, "\t%d", (int)ktime_to_ms(dt));
 	else
-		seq_printf(m, "\t-");
+		seq_puts(m, "\t-");
 }
+#endif
 
 static void __seq_print_rq_state_bit(struct seq_file *m,
 	bool is_set, char *sep, const char *set_name, const char *unset_name)
 {
 	if (is_set && set_name) {
-		seq_putc(m, *sep);
+		if (*sep)
+			seq_putc(m, *sep);
 		seq_puts(m, set_name);
 		*sep = '|';
 	} else if (!is_set && unset_name) {
-		seq_putc(m, *sep);
+		if (*sep)
+			seq_putc(m, *sep);
 		seq_puts(m, unset_name);
 		*sep = '|';
 	}
@@ -57,17 +81,21 @@ static void seq_print_rq_state_bit(struct seq_file *m,
 /* pretty print enum drbd_req_state_bits req->rq_state */
 static void seq_print_request_state(struct seq_file *m, struct drbd_request *req)
 {
-	unsigned int s = req->rq_state;
+	struct drbd_device *device = req->device;
+	struct drbd_peer_device *peer_device;
+	unsigned int s = req->local_rq_state;
 	char sep = ' ';
+
 	seq_printf(m, "\t0x%08x", s);
-	seq_printf(m, "\tmaster: %s", req->master_bio ? "pending" : "completed");
+	seq_puts(m, "\tmaster:");
+	__seq_print_rq_state_bit(m, req->master_bio, &sep, "pending", "completed");
+	seq_print_rq_state_bit(m, s & RQ_POSTPONED, &sep, "postponed");
+	seq_print_rq_state_bit(m, s & RQ_COMPLETION_SUSP, &sep, "suspended");
 
 	/* RQ_WRITE ignored, already reported */
 	seq_puts(m, "\tlocal:");
-	seq_print_rq_state_bit(m, s & RQ_IN_ACT_LOG, &sep, "in-AL");
-	seq_print_rq_state_bit(m, s & RQ_POSTPONED, &sep, "postponed");
-	seq_print_rq_state_bit(m, s & RQ_COMPLETION_SUSP, &sep, "suspended");
 	sep = ' ';
+	seq_print_rq_state_bit(m, s & RQ_IN_ACT_LOG, &sep, "in-AL");
 	seq_print_rq_state_bit(m, s & RQ_LOCAL_PENDING, &sep, "pending");
 	seq_print_rq_state_bit(m, s & RQ_LOCAL_COMPLETED, &sep, "completed");
 	seq_print_rq_state_bit(m, s & RQ_LOCAL_ABORTED, &sep, "aborted");
@@ -75,64 +103,100 @@ static void seq_print_request_state(struct seq_file *m, struct drbd_request *req
 	if (sep == ' ')
 		seq_puts(m, " -");
 
-	/* for_each_connection ... */
-	seq_printf(m, "\tnet:");
-	sep = ' ';
-	seq_print_rq_state_bit(m, s & RQ_NET_PENDING, &sep, "pending");
-	seq_print_rq_state_bit(m, s & RQ_NET_QUEUED, &sep, "queued");
-	seq_print_rq_state_bit(m, s & RQ_NET_SENT, &sep, "sent");
-	seq_print_rq_state_bit(m, s & RQ_NET_DONE, &sep, "done");
-	seq_print_rq_state_bit(m, s & RQ_NET_SIS, &sep, "sis");
-	seq_print_rq_state_bit(m, s & RQ_NET_OK, &sep, "ok");
-	if (sep == ' ')
-		seq_puts(m, " -");
+	for_each_peer_device(peer_device, device) {
+		s = req->net_rq_state[peer_device->node_id];
+		seq_printf(m, "\tnet[%d]:", peer_device->node_id);
+		sep = ' ';
+		seq_print_rq_state_bit(m, s & RQ_NET_PENDING, &sep, "pending");
+		seq_print_rq_state_bit(m, s & RQ_NET_PENDING_OOS, &sep, "pending-oos");
+		seq_print_rq_state_bit(m, s & RQ_NET_QUEUED, &sep, "queued");
+		seq_print_rq_state_bit(m, s & RQ_NET_READY, &sep, "ready");
+		seq_print_rq_state_bit(m, s & RQ_NET_SENT, &sep, "sent");
+		seq_print_rq_state_bit(m, s & RQ_NET_DONE, &sep, "done");
+		seq_print_rq_state_bit(m, s & RQ_NET_SIS, &sep, "sis");
+		seq_print_rq_state_bit(m, s & RQ_NET_OK, &sep, "ok");
+		if (sep == ' ')
+			seq_puts(m, " -");
+
+		seq_puts(m, " :");
+		sep = ' ';
+		seq_print_rq_state_bit(m, s & RQ_EXP_RECEIVE_ACK, &sep, "B");
+		seq_print_rq_state_bit(m, s & RQ_EXP_WRITE_ACK, &sep, "C");
+		seq_print_rq_state_bit(m, s & RQ_EXP_BARR_ACK, &sep, "barr");
+		if (sep == ' ')
+			seq_puts(m, " -");
+	}
+	seq_putc(m, '\n');
+}
 
-	seq_printf(m, " :");
-	sep = ' ';
-	seq_print_rq_state_bit(m, s & RQ_EXP_RECEIVE_ACK, &sep, "B");
-	seq_print_rq_state_bit(m, s & RQ_EXP_WRITE_ACK, &sep, "C");
-	seq_print_rq_state_bit(m, s & RQ_EXP_BARR_ACK, &sep, "barr");
-	if (sep == ' ')
-		seq_puts(m, " -");
-	seq_printf(m, "\n");
+#define memberat(PTR, TYPE, OFFSET) (*(TYPE *)((char *)PTR + OFFSET))
+
+#ifdef CONFIG_DRBD_TIMING_STATS
+static void print_one_age_or_dash(struct seq_file *m, struct drbd_request *req,
+				  unsigned int set_mask, unsigned int clear_mask,
+				  ktime_t now, size_t offset)
+{
+	struct drbd_device *device = req->device;
+	struct drbd_peer_device *peer_device;
+
+	for_each_peer_device(peer_device, device) {
+		unsigned int s = req->net_rq_state[peer_device->node_id];
+
+		if (s & set_mask && !(s & clear_mask)) {
+			ktime_t ktime = ktime_sub(now, memberat(req, ktime_t, offset));
+
+			seq_printf(m, "\t[%d]%d", peer_device->node_id, (int)ktime_to_ms(ktime));
+			return;
+		}
+	}
+	seq_puts(m, "\t-");
 }
+#endif
 
-static void seq_print_one_request(struct seq_file *m, struct drbd_request *req, unsigned long now)
+static void seq_print_one_request(struct seq_file *m, struct drbd_request *req, ktime_t now, unsigned long jif)
 {
 	/* change anything here, fixup header below! */
-	unsigned int s = req->rq_state;
+	unsigned int s = req->local_rq_state;
+	unsigned long flags;
 
+	spin_lock_irqsave(&req->rq_lock, flags);
 #define RQ_HDR_1 "epoch\tsector\tsize\trw"
 	seq_printf(m, "0x%x\t%llu\t%u\t%s",
 		req->epoch,
 		(unsigned long long)req->i.sector, req->i.size >> 9,
 		(s & RQ_WRITE) ? "W" : "R");
 
+#ifdef CONFIG_DRBD_TIMING_STATS
 #define RQ_HDR_2 "\tstart\tin AL\tsubmit"
-	seq_printf(m, "\t%d", jiffies_to_msecs(now - req->start_jif));
-	seq_print_age_or_dash(m, s & RQ_IN_ACT_LOG, now - req->in_actlog_jif);
-	seq_print_age_or_dash(m, s & RQ_LOCAL_PENDING, now - req->pre_submit_jif);
+	seq_printf(m, "\t%d", (int)ktime_to_ms(ktime_sub(now, req->start_kt)));
+	seq_print_age_or_dash(m, s & RQ_IN_ACT_LOG, ktime_sub(now, req->in_actlog_kt));
+	seq_print_age_or_dash(m, s & RQ_LOCAL_PENDING, ktime_sub(now, req->pre_submit_kt));
 
 #define RQ_HDR_3 "\tsent\tacked\tdone"
-	seq_print_age_or_dash(m, s & RQ_NET_SENT, now - req->pre_send_jif);
-	seq_print_age_or_dash(m, (s & RQ_NET_SENT) && !(s & RQ_NET_PENDING), now - req->acked_jif);
-	seq_print_age_or_dash(m, s & RQ_NET_DONE, now - req->net_done_jif);
-
+	print_one_age_or_dash(m, req, RQ_NET_SENT, 0, now, offsetof(typeof(*req), pre_send_kt));
+	print_one_age_or_dash(m, req, RQ_NET_SENT, RQ_NET_PENDING, now, offsetof(typeof(*req), acked_kt));
+	print_one_age_or_dash(m, req, RQ_NET_DONE, 0, now, offsetof(typeof(*req), net_done_kt));
+#else
+#define RQ_HDR_2 "\tstart"
+#define RQ_HDR_3 ""
+	seq_printf(m, "\t%d", (int)jiffies_to_msecs(jif - req->start_jif));
+#endif
 #define RQ_HDR_4 "\tstate\n"
 	seq_print_request_state(m, req);
+	spin_unlock_irqrestore(&req->rq_lock, flags);
 }
 #define RQ_HDR RQ_HDR_1 RQ_HDR_2 RQ_HDR_3 RQ_HDR_4
 
-static void seq_print_minor_vnr_req(struct seq_file *m, struct drbd_request *req, unsigned long now)
+static void seq_print_minor_vnr_req(struct seq_file *m, struct drbd_request *req, ktime_t now, unsigned long jif)
 {
 	seq_printf(m, "%u\t%u\t", req->device->minor, req->device->vnr);
-	seq_print_one_request(m, req, now);
+	seq_print_one_request(m, req, now, jif);
 }
 
-static void seq_print_resource_pending_meta_io(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
+static void seq_print_resource_pending_meta_io(struct seq_file *m, struct drbd_resource *resource, unsigned long jif)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	int i;
 
 	seq_puts(m, "minor\tvnr\tstart\tsubmit\tintent\n");
 	rcu_read_lock();
@@ -146,45 +210,47 @@ static void seq_print_resource_pending_meta_io(struct seq_file *m, struct drbd_r
 		if (atomic_read(&tmp.in_use)) {
 			seq_printf(m, "%u\t%u\t%d\t",
 				device->minor, device->vnr,
-				jiffies_to_msecs(now - tmp.start_jif));
+				jiffies_to_msecs(jif - tmp.start_jif));
 			if (time_before(tmp.submit_jif, tmp.start_jif))
 				seq_puts(m, "-\t");
 			else
-				seq_printf(m, "%d\t", jiffies_to_msecs(now - tmp.submit_jif));
+				seq_printf(m, "%d\t", jiffies_to_msecs(jif - tmp.submit_jif));
 			seq_printf(m, "%s\n", tmp.current_use);
 		}
 	}
 	rcu_read_unlock();
 }
 
-static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
+static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *resource, ktime_t now, unsigned long jif)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	int i;
 
 	seq_puts(m, "minor\tvnr\tage\t#waiting\n");
 	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, i) {
-		unsigned long jif;
 		struct drbd_request *req;
 		int n = atomic_read(&device->ap_actlog_cnt);
+
 		if (n) {
-			spin_lock_irq(&device->resource->req_lock);
+			spin_lock_irq(&device->pending_completion_lock);
 			req = list_first_entry_or_null(&device->pending_master_completion[1],
 				struct drbd_request, req_pending_master_completion);
 			/* if the oldest request does not wait for the activity log
 			 * it is not interesting for us here */
-			if (req && !(req->rq_state & RQ_IN_ACT_LOG))
-				jif = req->start_jif;
-			else
+			if (req && (req->local_rq_state & RQ_IN_ACT_LOG))
 				req = NULL;
-			spin_unlock_irq(&device->resource->req_lock);
+			spin_unlock_irq(&device->pending_completion_lock);
 		}
 		if (n) {
 			seq_printf(m, "%u\t%u\t", device->minor, device->vnr);
-			if (req)
-				seq_printf(m, "%u\t", jiffies_to_msecs(now - jif));
-			else
+			if (req) {
+#ifdef CONFIG_DRBD_TIMING_STATS
+				seq_printf(m, "%d\t", (int)ktime_to_ms(ktime_sub(now, req->start_kt)));
+#else
+				seq_printf(m, "%d\t", (int)jiffies_to_msecs(jif - req->start_jif));
+#endif
+			} else
 				seq_puts(m, "-\t");
 			seq_printf(m, "%u\n", n);
 		}
@@ -192,13 +258,14 @@ static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *r
 	rcu_read_unlock();
 }
 
-static void seq_print_device_bitmap_io(struct seq_file *m, struct drbd_device *device, unsigned long now)
+static void seq_print_device_bitmap_io(struct seq_file *m, struct drbd_device *device, unsigned long jif)
 {
 	struct drbd_bm_aio_ctx *ctx;
 	unsigned long start_jif;
 	unsigned int in_flight;
 	unsigned int flags;
-	spin_lock_irq(&device->resource->req_lock);
+
+	spin_lock_irq(&device->pending_bmio_lock);
 	ctx = list_first_entry_or_null(&device->pending_bitmap_io, struct drbd_bm_aio_ctx, list);
 	if (ctx && ctx->done)
 		ctx = NULL;
@@ -207,25 +274,25 @@ static void seq_print_device_bitmap_io(struct seq_file *m, struct drbd_device *d
 		in_flight = atomic_read(&ctx->in_flight);
 		flags = ctx->flags;
 	}
-	spin_unlock_irq(&device->resource->req_lock);
+	spin_unlock_irq(&device->pending_bmio_lock);
 	if (ctx) {
 		seq_printf(m, "%u\t%u\t%c\t%u\t%u\n",
 			device->minor, device->vnr,
 			(flags & BM_AIO_READ) ? 'R' : 'W',
-			jiffies_to_msecs(now - start_jif),
+			jiffies_to_msecs(jif - start_jif),
 			in_flight);
 	}
 }
 
-static void seq_print_resource_pending_bitmap_io(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
+static void seq_print_resource_pending_bitmap_io(struct seq_file *m, struct drbd_resource *resource, unsigned long jif)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	int i;
 
 	seq_puts(m, "minor\tvnr\trw\tage\t#in-flight\n");
 	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, i) {
-		seq_print_device_bitmap_io(m, device, now);
+		seq_print_device_bitmap_io(m, device, jif);
 	}
 	rcu_read_unlock();
 }
@@ -234,104 +301,198 @@ static void seq_print_resource_pending_bitmap_io(struct seq_file *m, struct drbd
 static void seq_print_peer_request_flags(struct seq_file *m, struct drbd_peer_request *peer_req)
 {
 	unsigned long f = peer_req->flags;
-	char sep = ' ';
-
-	__seq_print_rq_state_bit(m, f & EE_SUBMITTED, &sep, "submitted", "preparing");
-	__seq_print_rq_state_bit(m, f & EE_APPLICATION, &sep, "application", "internal");
-	seq_print_rq_state_bit(m, f & EE_CALL_AL_COMPLETE_IO, &sep, "in-AL");
+	char sep = 0;
+
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &peer_req->i.flags),
+			&sep, "submit-conflict-queued");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_SUBMITTED, &peer_req->i.flags),
+			&sep, "submitted");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_CONFLICT, &peer_req->i.flags),
+			&sep, "conflict");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_SENT, &peer_req->i.flags),
+			&sep, "sent");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_READY_TO_SEND, &peer_req->i.flags),
+			&sep, "ready-to-send");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_RECEIVED, &peer_req->i.flags),
+			&sep, "received");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_BACKING_COMPLETED, &peer_req->i.flags),
+			&sep, "backing-completed");
+	seq_print_rq_state_bit(m, test_bit(INTERVAL_COMPLETED, &peer_req->i.flags),
+			&sep, "completed");
+	seq_print_rq_state_bit(m, f & EE_IS_BARRIER, &sep, "barr");
 	seq_print_rq_state_bit(m, f & EE_SEND_WRITE_ACK, &sep, "C");
 	seq_print_rq_state_bit(m, f & EE_MAY_SET_IN_SYNC, &sep, "set-in-sync");
+	seq_print_rq_state_bit(m, f & EE_SET_OUT_OF_SYNC, &sep, "set-out-of-sync");
+	seq_print_rq_state_bit(m, peer_req->i.type == INTERVAL_PEER_WRITE && !(f & EE_IN_ACTLOG), &sep, "blocked-on-al");
 	seq_print_rq_state_bit(m, f & EE_TRIM, &sep, "trim");
 	seq_print_rq_state_bit(m, f & EE_ZEROOUT, &sep, "zero-out");
 	seq_print_rq_state_bit(m, f & EE_WRITE_SAME, &sep, "write-same");
 	seq_putc(m, '\n');
 }
 
-static void seq_print_peer_request(struct seq_file *m,
-	struct drbd_device *device, struct list_head *lh,
-	unsigned long now)
+enum drbd_peer_request_state {
+	PRS_NEW,
+	PRS_READY_TO_SEND,
+	PRS_SUBMITTED,
+	PRS_LAST,
+};
+
+static enum drbd_peer_request_state drbd_get_peer_request_state(struct drbd_peer_request *peer_req)
+{
+	unsigned long interval_flags = peer_req->i.flags;
+
+	if (interval_flags & INTERVAL_SUBMITTED)
+		return PRS_SUBMITTED;
+
+	if (interval_flags & INTERVAL_READY_TO_SEND)
+		return PRS_READY_TO_SEND;
+
+	return PRS_NEW;
+}
+
+static void seq_print_peer_request_one(struct seq_file *m,
+	struct drbd_peer_request *peer_req,
+	const char *list_name, unsigned long jif)
 {
-	bool reported_preparing = false;
+	struct drbd_peer_device *peer_device = peer_req->peer_device;
+	struct drbd_device *device = peer_device ? peer_device->device : NULL;
+
+	seq_printf(m, "%s\t", list_name);
+
+	if (device)
+		seq_printf(m, "%u\t%u\t", device->minor, device->vnr);
+
+	seq_printf(m, "%llu\t%u\t%s\t%u\t",
+			(unsigned long long)peer_req->i.sector, peer_req->i.size >> 9,
+			drbd_interval_type_str(&peer_req->i),
+			jiffies_to_msecs(jif - peer_req->submit_jif));
+	seq_print_peer_request_flags(m, peer_req);
+}
+
+static void seq_print_peer_request_w(struct seq_file *m,
+	struct drbd_connection *connection, struct list_head *lh,
+	const char *list_name, unsigned long jif)
+{
+	int count[PRS_LAST] = {0};
 	struct drbd_peer_request *peer_req;
+
 	list_for_each_entry(peer_req, lh, w.list) {
-		if (reported_preparing && !(peer_req->flags & EE_SUBMITTED))
-			continue;
+		enum drbd_peer_request_state state = drbd_get_peer_request_state(peer_req);
 
-		if (device)
-			seq_printf(m, "%u\t%u\t", device->minor, device->vnr);
+		count[state]++;
+		if (count[state] <= 16)
+			seq_print_peer_request_one(m, peer_req, list_name, jif);
+	}
+}
 
-		seq_printf(m, "%llu\t%u\t%c\t%u\t",
-			(unsigned long long)peer_req->i.sector, peer_req->i.size >> 9,
-			(peer_req->flags & EE_WRITE) ? 'W' : 'R',
-			jiffies_to_msecs(now - peer_req->submit_jif));
-		seq_print_peer_request_flags(m, peer_req);
-		if (peer_req->flags & EE_SUBMITTED)
-			break;
-		else
-			reported_preparing = true;
+static void seq_print_peer_request(struct seq_file *m,
+	struct drbd_connection *connection, struct list_head *lh,
+	const char *list_name, unsigned long jif)
+{
+	int count = 0;
+	struct drbd_peer_request *peer_req;
+
+	list_for_each_entry(peer_req, lh, recv_order) {
+		count++;
+		if (count <= 16)
+			seq_print_peer_request_one(m, peer_req, list_name, jif);
 	}
 }
 
-static void seq_print_device_peer_requests(struct seq_file *m,
-	struct drbd_device *device, unsigned long now)
+static void seq_print_connection_peer_requests(struct seq_file *m,
+	struct drbd_connection *connection, unsigned long jif)
+{
+	struct drbd_peer_device *peer_device;
+	int i;
+
+	seq_puts(m, "list\t\tminor\tvnr\tsector\tsize\ttype\t\tage\tflags\n");
+	spin_lock_irq(&connection->peer_reqs_lock);
+	seq_print_peer_request_w(m, connection, &connection->done_ee, "done\t", jif);
+	seq_print_peer_request_w(m, connection, &connection->dagtag_wait_ee, "dagtag_wait", jif);
+	seq_print_peer_request(m, connection, &connection->peer_requests, "peer_requests", jif);
+	seq_print_peer_request(m, connection, &connection->peer_reads, "peer_reads", jif);
+	idr_for_each_entry(&connection->peer_devices, peer_device, i)
+		seq_print_peer_request(m, connection, &peer_device->resync_requests,
+				"resync_requests", jif);
+	spin_unlock_irq(&connection->peer_reqs_lock);
+}
+
+static void seq_print_device_peer_flushes(struct seq_file *m,
+	struct drbd_device *device, unsigned long jif)
 {
-	seq_puts(m, "minor\tvnr\tsector\tsize\trw\tage\tflags\n");
-	spin_lock_irq(&device->resource->req_lock);
-	seq_print_peer_request(m, device, &device->active_ee, now);
-	seq_print_peer_request(m, device, &device->read_ee, now);
-	seq_print_peer_request(m, device, &device->sync_ee, now);
-	spin_unlock_irq(&device->resource->req_lock);
 	if (test_bit(FLUSH_PENDING, &device->flags)) {
 		seq_printf(m, "%u\t%u\t-\t-\tF\t%u\tflush\n",
 			device->minor, device->vnr,
-			jiffies_to_msecs(now - device->flush_jif));
+			jiffies_to_msecs(jif - device->flush_jif));
 	}
 }
 
 static void seq_print_resource_pending_peer_requests(struct seq_file *m,
-	struct drbd_resource *resource, unsigned long now)
+	struct drbd_resource *resource, unsigned long jif)
 {
+	struct drbd_connection *connection;
 	struct drbd_device *device;
-	unsigned int i;
+	int i;
 
 	rcu_read_lock();
+
+	for_each_connection_rcu(connection, resource) {
+		seq_printf(m, "oldest peer requests (peer: %s)\n",
+			rcu_dereference(connection->transport.net_conf)->name);
+		seq_print_connection_peer_requests(m, connection, jif);
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "flushes\n");
 	idr_for_each_entry(&resource->devices, device, i) {
-		seq_print_device_peer_requests(m, device, now);
+		seq_print_device_peer_flushes(m, device, jif);
 	}
+	seq_putc(m, '\n');
+
 	rcu_read_unlock();
 }
 
 static void seq_print_resource_transfer_log_summary(struct seq_file *m,
 	struct drbd_resource *resource,
-	struct drbd_connection *connection,
-	unsigned long now)
+	ktime_t now, unsigned long jif)
 {
 	struct drbd_request *req;
 	unsigned int count = 0;
 	unsigned int show_state = 0;
 
 	seq_puts(m, "n\tdevice\tvnr\t" RQ_HDR);
-	spin_lock_irq(&resource->req_lock);
-	list_for_each_entry(req, &connection->transfer_log, tl_requests) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(req, &resource->transfer_log, tl_requests) {
+		struct drbd_device *device = req->device;
+		struct drbd_peer_device *peer_device;
 		unsigned int tmp = 0;
 		unsigned int s;
-		++count;
 
-		/* don't disable irq "forever" */
-		if (!(count & 0x1ff)) {
-			struct drbd_request *req_next;
-			kref_get(&req->kref);
-			spin_unlock_irq(&resource->req_lock);
+		/* don't disable preemption "forever" */
+		if ((count & 0x1ff) == 0x1ff) {
+			struct list_head *next_hdr;
+			/* Only get if the request hasn't already been removed from transfer_log. */
+			if (!refcount_inc_not_zero(&req->oos_send_ref))
+				continue;
+			rcu_read_unlock();
 			cond_resched();
-			spin_lock_irq(&resource->req_lock);
-			req_next = list_next_entry(req, tl_requests);
-			if (kref_put(&req->kref, drbd_req_destroy))
-				req = req_next;
-			if (&req->tl_requests == &connection->transfer_log)
-				break;
+			rcu_read_lock();
+			next_hdr = rcu_dereference(list_next_rcu(&req->tl_requests));
+			read_lock_irq(&resource->state_rwlock);
+			drbd_put_ref_tl_walk(req, 0, 1);
+			read_unlock_irq(&resource->state_rwlock);
+			if (!refcount_read(&req->done_ref)) {
+				if (next_hdr == &resource->transfer_log)
+					break;
+				req = list_entry_rcu(next_hdr,
+						     struct drbd_request,
+						     tl_requests);
+			}
 		}
+		++count;
 
-		s = req->rq_state;
+		spin_lock_irq(&req->rq_lock);
+		s = req->local_rq_state;
 
 		/* This is meant to summarize timing issues, to be able to tell
 		 * local disk problems from network problems.
@@ -341,40 +502,43 @@ static void seq_print_resource_transfer_log_summary(struct seq_file *m,
 			tmp |= 1;
 		if ((s & RQ_LOCAL_MASK) && (s & RQ_LOCAL_PENDING))
 			tmp |= 2;
-		if (s & RQ_NET_MASK) {
-			if (!(s & RQ_NET_SENT))
-				tmp |= 4;
-			if (s & RQ_NET_PENDING)
-				tmp |= 8;
-			if (!(s & RQ_NET_DONE))
-				tmp |= 16;
+
+		for_each_peer_device_rcu(peer_device, device) {
+			s = READ_ONCE(req->net_rq_state[peer_device->node_id]);
+			if (s & RQ_NET_MASK) {
+				if (!(s & RQ_NET_SENT))
+					tmp |= 4;
+				if (s & RQ_NET_PENDING)
+					tmp |= 8;
+				if (!(s & RQ_NET_DONE))
+					tmp |= 16;
+			}
 		}
+		spin_unlock_irq(&req->rq_lock);
+
 		if ((tmp & show_state) == tmp)
 			continue;
 		show_state |= tmp;
 		seq_printf(m, "%u\t", count);
-		seq_print_minor_vnr_req(m, req, now);
+		seq_print_minor_vnr_req(m, req, now, jif);
 		if (show_state == 0x1f)
 			break;
 	}
-	spin_unlock_irq(&resource->req_lock);
+	rcu_read_unlock();
+	seq_printf(m, "%u total\n", count);
 }
 
-/* TODO: transfer_log and friends should be moved to resource */
-static int in_flight_summary_show(struct seq_file *m, void *pos)
+static int resource_in_flight_summary_show(struct seq_file *m, void *pos)
 {
 	struct drbd_resource *resource = m->private;
 	struct drbd_connection *connection;
+	struct drbd_transport *transport;
+	struct drbd_transport_stats transport_stats;
+	ktime_t now = ktime_get();
 	unsigned long jif = jiffies;
 
-	connection = first_connection(resource);
-	/* This does not happen, actually.
-	 * But be robust and prepare for future code changes. */
-	if (!connection || !kref_get_unless_zero(&connection->kref))
-		return -ESTALE;
-
 	/* BUMP me if you change the file format/content/presentation */
-	seq_printf(m, "v: %u\n\n", 0);
+	seq_printf(m, "v: %u\n\n", 1);
 
 	seq_puts(m, "oldest bitmap IO\n");
 	seq_print_resource_pending_bitmap_io(m, resource, jif);
@@ -384,43 +548,132 @@ static int in_flight_summary_show(struct seq_file *m, void *pos)
 	seq_print_resource_pending_meta_io(m, resource, jif);
 	seq_putc(m, '\n');
 
-	seq_puts(m, "socket buffer stats\n");
-	/* for each connection ... once we have more than one */
+	seq_puts(m, "transport buffer stats\n");
+	seq_puts(m, "peer\ttransport class\tunread receive buffer\tunacked send buffer\n");
 	rcu_read_lock();
-	if (connection->data.socket) {
-		/* open coded SIOCINQ, the "relevant" part */
-		struct tcp_sock *tp = tcp_sk(connection->data.socket->sk);
-		int answ = tp->rcv_nxt - tp->copied_seq;
-		seq_printf(m, "unread receive buffer: %u Byte\n", answ);
-		/* open coded SIOCOUTQ, the "relevant" part */
-		answ = tp->write_seq - tp->snd_una;
-		seq_printf(m, "unacked send buffer: %u Byte\n", answ);
+	for_each_connection_rcu(connection, resource) {
+		char *name;
+
+		transport = &connection->transport;
+		name = rcu_dereference(transport->net_conf)->name;
+		seq_printf(m, "%s\t%s\t", name, transport->class->name);
+
+		if (transport->class->ops.stream_ok(transport, DATA_STREAM)) {
+			transport->class->ops.stats(transport, &transport_stats);
+			seq_printf(m, "%u\t%u\n",
+				transport_stats.unread_received,
+				transport_stats.unacked_send);
+		} else {
+			seq_puts(m, "-\t-\n");
+		}
 	}
 	rcu_read_unlock();
 	seq_putc(m, '\n');
 
-	seq_puts(m, "oldest peer requests\n");
 	seq_print_resource_pending_peer_requests(m, resource, jif);
-	seq_putc(m, '\n');
 
 	seq_puts(m, "application requests waiting for activity log\n");
-	seq_print_waiting_for_AL(m, resource, jif);
+	seq_print_waiting_for_AL(m, resource, now, jif);
 	seq_putc(m, '\n');
 
 	seq_puts(m, "oldest application requests\n");
-	seq_print_resource_transfer_log_summary(m, resource, connection, jif);
+	seq_print_resource_transfer_log_summary(m, resource, now, jif);
 	seq_putc(m, '\n');
 
 	jif = jiffies - jif;
 	if (jif)
 		seq_printf(m, "generated in %d ms\n", jiffies_to_msecs(jif));
-	kref_put(&connection->kref, drbd_destroy_connection);
+	return 0;
+}
+
+static int resource_state_twopc_show(struct seq_file *m, void *pos)
+{
+	struct drbd_resource *resource = m->private;
+	struct twopc_reply twopc;
+	bool active = false;
+	unsigned long jif;
+
+	read_lock_irq(&resource->state_rwlock);
+	if (resource->remote_state_change) {
+		twopc = resource->twopc_reply;
+		active = true;
+	}
+	read_unlock_irq(&resource->state_rwlock);
+
+	seq_printf(m, "v: %u\n\n", 1);
+	if (active) {
+		struct drbd_connection *connection;
+
+		seq_printf(m,
+			   "Executing tid: %u\n"
+			   "  initiator_node_id: %d\n"
+			   "  target_node_id: %d\n",
+			   twopc.tid, twopc.initiator_node_id,
+			   twopc.target_node_id);
+
+		if (twopc.initiator_node_id != resource->res_opts.node_id) {
+			seq_puts(m, "  parent node mask: ");
+			seq_print_node_mask(m, resource, resource->twopc_parent_nodes);
+
+			if (resource->twopc_prepare_reply_cmd)
+				seq_printf(m,
+					   "  Reply sent: %s\n",
+					   resource->twopc_prepare_reply_cmd == P_TWOPC_YES ? "yes" :
+					   resource->twopc_prepare_reply_cmd == P_TWOPC_NO ? "no" :
+					   resource->twopc_prepare_reply_cmd == P_TWOPC_RETRY ? "retry" :
+					   "else!?!");
+		}
+
+		seq_puts(m, "  received replies: ");
+		rcu_read_lock();
+		for_each_connection_rcu(connection, resource) {
+			char *name = rcu_dereference((connection)->transport.net_conf)->name;
+
+			if (!test_bit(TWOPC_PREPARED, &connection->flags))
+				/* seq_printf(m, "%s n.p., ", name) * print nothing! */;
+			else if (test_bit(TWOPC_NO, &connection->flags))
+				seq_printf(m, "%s no, ", name);
+			else if (test_bit(TWOPC_RETRY, &connection->flags))
+				seq_printf(m, "%s ret, ", name);
+			else if (test_bit(TWOPC_YES, &connection->flags))
+				seq_printf(m, "%s yes, ", name);
+			else
+				seq_printf(m, "%s ___, ", name);
+		}
+		rcu_read_unlock();
+		seq_puts(m, "\n");
+		if (twopc.initiator_node_id != resource->res_opts.node_id) {
+			/* The timer is only relevant for twopcs initiated by other nodes */
+			jif = resource->twopc_timer.expires - jiffies;
+			seq_printf(m, "  timer expires in: %d ms\n", jiffies_to_msecs(jif));
+		}
+	} else {
+		seq_puts(m, "No ongoing two phase state transaction\n");
+	}
+
+	return 0;
+}
+
+static int resource_worker_pid_show(struct seq_file *m, void *pos)
+{
+	struct drbd_resource *resource = m->private;
+
+	if (resource->worker.task)
+		seq_printf(m, "%d\n", resource->worker.task->pid);
+	return 0;
+}
+
+static int resource_members_show(struct seq_file *m, void *pos)
+{
+	struct drbd_resource *resource = m->private;
+
+	seq_printf(m, "0x%016llX\n", resource->members);
 	return 0;
 }
 
 /* make sure at *open* time that the respective object won't go away. */
 static int drbd_single_open(struct file *file, int (*show)(struct seq_file *, void *),
-		                void *data, struct kref *kref,
+				void *data, struct kref *kref,
 				void (*release)(struct kref *))
 {
 	struct dentry *parent;
@@ -429,6 +682,9 @@ static int drbd_single_open(struct file *file, int (*show)(struct seq_file *, vo
 	/* Are we still linked,
 	 * or has debugfs_remove() already been called? */
 	parent = file->f_path.dentry->d_parent;
+	/* not sure if this can happen: */
+	if (!parent || !parent->d_inode)
+		goto out;
 	/* serialize with d_delete() */
 	inode_lock(d_inode(parent));
 	/* Make sure the object is still alive */
@@ -441,31 +697,56 @@ static int drbd_single_open(struct file *file, int (*show)(struct seq_file *, vo
 		if (ret)
 			kref_put(kref, release);
 	}
+out:
 	return ret;
 }
 
-static int in_flight_summary_open(struct inode *inode, struct file *file)
+static int resource_attr_release(struct inode *inode, struct file *file)
 {
 	struct drbd_resource *resource = inode->i_private;
-	return drbd_single_open(file, in_flight_summary_show, resource,
-				&resource->kref, drbd_destroy_resource);
-}
 
-static int in_flight_summary_release(struct inode *inode, struct file *file)
-{
-	struct drbd_resource *resource = inode->i_private;
 	kref_put(&resource->kref, drbd_destroy_resource);
 	return single_release(inode, file);
 }
 
-static const struct file_operations in_flight_summary_fops = {
-	.owner		= THIS_MODULE,
-	.open		= in_flight_summary_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= in_flight_summary_release,
+#define drbd_debugfs_resource_attr(name)				\
+static int resource_ ## name ## _open(struct inode *inode, struct file *file) \
+{									\
+	struct drbd_resource *resource = inode->i_private;		\
+	return drbd_single_open(file, resource_ ## name ## _show, resource, \
+				&resource->kref, drbd_destroy_resource); \
+}									\
+static const struct file_operations resource_ ## name ## _fops = {	\
+	.owner		= THIS_MODULE,					\
+	.open		= resource_ ## name ## _open,			\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= resource_attr_release,			\
 };
 
+drbd_debugfs_resource_attr(in_flight_summary)
+drbd_debugfs_resource_attr(state_twopc)
+drbd_debugfs_resource_attr(worker_pid)
+drbd_debugfs_resource_attr(members)
+
+#define drbd_dcf(top, obj, attr, perm) do {			\
+	dentry = debugfs_create_file(#attr, perm,		\
+			top, obj, &obj ## _ ## attr ## _fops);	\
+	top ## _ ## attr = dentry;				\
+	} while (0)
+
+#define res_dcf(attr) \
+	drbd_dcf(resource->debugfs_res, resource, attr, 0400)
+
+#define conn_dcf(attr) \
+	drbd_dcf(connection->debugfs_conn, connection, attr, 0400)
+
+#define vol_dcf(attr) \
+	drbd_dcf(device->debugfs_vol, device, attr, 0400)
+
+#define peer_dev_dcf(attr) \
+	drbd_dcf(peer_device->debugfs_peer_dev, peer_device, attr, 0400)
+
 void drbd_debugfs_resource_add(struct drbd_resource *resource)
 {
 	struct dentry *dentry;
@@ -479,10 +760,11 @@ void drbd_debugfs_resource_add(struct drbd_resource *resource)
 	dentry = debugfs_create_dir("connections", resource->debugfs_res);
 	resource->debugfs_res_connections = dentry;
 
-	dentry = debugfs_create_file("in_flight_summary", 0440,
-				     resource->debugfs_res, resource,
-				     &in_flight_summary_fops);
-	resource->debugfs_res_in_flight_summary = dentry;
+	/* debugfs create file */
+	res_dcf(in_flight_summary);
+	res_dcf(state_twopc);
+	res_dcf(worker_pid);
+	res_dcf(members);
 }
 
 static void drbd_debugfs_remove(struct dentry **dp)
@@ -493,16 +775,35 @@ static void drbd_debugfs_remove(struct dentry **dp)
 
 void drbd_debugfs_resource_cleanup(struct drbd_resource *resource)
 {
+	/* Older kernels have a broken implementation of
+	 * debugfs_remove_recursive (prior to upstream commit 776164c1f)
+	 * That unfortunately includes a number of "enterprise" kernels.
+	 * Even older kernels do not even have the _recursive() helper at all.
+	 * For now, remember all debugfs nodes we created,
+	 * and call debugfs_remove on all of them separately.
+	 */
 	/* it is ok to call debugfs_remove(NULL) */
+	drbd_debugfs_remove(&resource->debugfs_res_members);
+	drbd_debugfs_remove(&resource->debugfs_res_worker_pid);
+	drbd_debugfs_remove(&resource->debugfs_res_state_twopc);
 	drbd_debugfs_remove(&resource->debugfs_res_in_flight_summary);
 	drbd_debugfs_remove(&resource->debugfs_res_connections);
 	drbd_debugfs_remove(&resource->debugfs_res_volumes);
 	drbd_debugfs_remove(&resource->debugfs_res);
 }
 
+void drbd_debugfs_resource_rename(struct drbd_resource *resource, const char *new_name)
+{
+	int err;
+
+	err = debugfs_change_name(resource->debugfs_res, "%s", new_name);
+	if (err)
+		drbd_err(resource, "failed to rename debugfs entry for resource\n");
+}
+
 static void seq_print_one_timing_detail(struct seq_file *m,
 	const struct drbd_thread_timing_details *tdp,
-	unsigned long now)
+	unsigned long jif)
 {
 	struct drbd_thread_timing_details td;
 	/* No locking...
@@ -514,14 +815,14 @@ static void seq_print_one_timing_detail(struct seq_file *m,
 		return;
 	seq_printf(m, "%u\t%d\t%s:%u\t%ps\n",
 			td.cb_nr,
-			jiffies_to_msecs(now - td.start_jif),
+			jiffies_to_msecs(jif - td.start_jif),
 			td.caller_fn, td.line,
 			td.cb_addr);
 }
 
 static void seq_print_timing_details(struct seq_file *m,
 		const char *title,
-		unsigned int cb_nr, struct drbd_thread_timing_details *tdp, unsigned long now)
+		unsigned int cb_nr, struct drbd_thread_timing_details *tdp, unsigned long jif)
 {
 	unsigned int start_idx;
 	unsigned int i;
@@ -533,135 +834,313 @@ static void seq_print_timing_details(struct seq_file *m,
 	 */
 	start_idx = cb_nr % DRBD_THREAD_DETAILS_HIST;
 	for (i = start_idx; i < DRBD_THREAD_DETAILS_HIST; i++)
-		seq_print_one_timing_detail(m, tdp+i, now);
+		seq_print_one_timing_detail(m, tdp+i, jif);
 	for (i = 0; i < start_idx; i++)
-		seq_print_one_timing_detail(m, tdp+i, now);
+		seq_print_one_timing_detail(m, tdp+i, jif);
 }
 
-static int callback_history_show(struct seq_file *m, void *ignored)
+static int connection_callback_history_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_connection *connection = m->private;
+	struct drbd_resource *resource = connection->resource;
 	unsigned long jif = jiffies;
 
 	/* BUMP me if you change the file format/content/presentation */
 	seq_printf(m, "v: %u\n\n", 0);
 
 	seq_puts(m, "n\tage\tcallsite\tfn\n");
-	seq_print_timing_details(m, "worker", connection->w_cb_nr, connection->w_timing_details, jif);
+	seq_print_timing_details(m, "sender", connection->s_cb_nr, connection->s_timing_details, jif);
 	seq_print_timing_details(m, "receiver", connection->r_cb_nr, connection->r_timing_details, jif);
+	seq_print_timing_details(m, "worker", resource->w_cb_nr, resource->w_timing_details, jif);
 	return 0;
 }
 
-static int callback_history_open(struct inode *inode, struct file *file)
-{
-	struct drbd_connection *connection = inode->i_private;
-	return drbd_single_open(file, callback_history_show, connection,
-				&connection->kref, drbd_destroy_connection);
-}
-
-static int callback_history_release(struct inode *inode, struct file *file)
-{
-	struct drbd_connection *connection = inode->i_private;
-	kref_put(&connection->kref, drbd_destroy_connection);
-	return single_release(inode, file);
-}
-
-static const struct file_operations connection_callback_history_fops = {
-	.owner		= THIS_MODULE,
-	.open		= callback_history_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= callback_history_release,
-};
-
 static int connection_oldest_requests_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_connection *connection = m->private;
-	unsigned long now = jiffies;
+	ktime_t now = ktime_get();
+	unsigned long jif = jiffies;
 	struct drbd_request *r1, *r2;
 
 	/* BUMP me if you change the file format/content/presentation */
-	seq_printf(m, "v: %u\n\n", 0);
+	seq_printf(m, "v: %u\n\n", 1);
 
-	spin_lock_irq(&connection->resource->req_lock);
-	r1 = connection->req_next;
+	rcu_read_lock();
+	r1 = READ_ONCE(connection->todo.req_next);
 	if (r1)
-		seq_print_minor_vnr_req(m, r1, now);
-	r2 = connection->req_ack_pending;
+		seq_print_minor_vnr_req(m, r1, now, jif);
+	r2 = READ_ONCE(connection->req_next_ready);
 	if (r2 && r2 != r1) {
 		r1 = r2;
-		seq_print_minor_vnr_req(m, r1, now);
+		seq_print_minor_vnr_req(m, r1, now, jif);
 	}
-	r2 = connection->req_not_net_done;
+	r2 = READ_ONCE(connection->req_ack_pending);
+	if (r2 && r2 != r1) {
+		r1 = r2;
+		seq_print_minor_vnr_req(m, r1, now, jif);
+	}
+	r2 = READ_ONCE(connection->req_not_net_done);
 	if (r2 && r2 != r1)
-		seq_print_minor_vnr_req(m, r2, now);
-	spin_unlock_irq(&connection->resource->req_lock);
+		seq_print_minor_vnr_req(m, r2, now, jif);
+	rcu_read_unlock();
 	return 0;
 }
 
-static int connection_oldest_requests_open(struct inode *inode, struct file *file)
+static int connection_transport_show(struct seq_file *m, void *ignored)
 {
-	struct drbd_connection *connection = inode->i_private;
-	return drbd_single_open(file, connection_oldest_requests_show, connection,
-				&connection->kref, drbd_destroy_connection);
+	struct drbd_connection *connection = m->private;
+	struct drbd_transport *transport = &connection->transport;
+	struct drbd_transport_ops *tr_ops = &transport->class->ops;
+	enum drbd_stream i;
+
+	/* BUMP me if you change the file format/content/presentation */
+	seq_printf(m, "v: %u\n\n", 1);
+
+	for (i = DATA_STREAM; i <= CONTROL_STREAM; i++) {
+		struct drbd_send_buffer *sbuf = &connection->send_buffer[i];
+
+		seq_printf(m, "%s stream\n", i == DATA_STREAM ? "data" : "control");
+		seq_printf(m, "  corked: %d\n", test_bit(CORKED + i, &connection->flags));
+		seq_printf(m, "  unsent: %ld bytes\n", (long)(sbuf->pos - sbuf->unsent));
+		seq_printf(m, "  allocated: %d bytes\n", sbuf->allocated_size);
+	}
+
+	seq_printf(m, "\nrx_misaligned_copies: %u\n", connection->rx_misaligned_copies);
+
+	seq_printf(m, "transport_type: %s\n", transport->class->name);
+
+	tr_ops->debugfs_show(transport, m);
+
+	return 0;
+}
+
+static int connection_debug_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_connection *connection = m->private;
+	struct drbd_resource *resource = connection->resource;
+	unsigned long flags = connection->flags;
+	unsigned int u1, u2;
+	unsigned long long ull1, ull2;
+	int in_flight;
+	char sep = ' ';
+
+	seq_puts(m, "content and format of this will change without notice\n");
+
+	seq_printf(m, "flags: 0x%04lx :", flags);
+#define pretty_print_bit(n) \
+	seq_print_rq_state_bit(m, test_bit(n, &flags), &sep, #n)
+	pretty_print_bit(PING_PENDING);
+	pretty_print_bit(TWOPC_PREPARED);
+	pretty_print_bit(TWOPC_YES);
+	pretty_print_bit(TWOPC_NO);
+	pretty_print_bit(TWOPC_RETRY);
+	pretty_print_bit(CONN_DRY_RUN);
+	pretty_print_bit(DISCONNECT_EXPECTED);
+	pretty_print_bit(BARRIER_ACK_PENDING);
+	pretty_print_bit(DATA_CORKED);
+	pretty_print_bit(CONTROL_CORKED);
+	pretty_print_bit(C_UNREGISTERED);
+	pretty_print_bit(RECONNECT);
+	pretty_print_bit(CONN_DISCARD_MY_DATA);
+	pretty_print_bit(SEND_STATE_AFTER_AHEAD_C);
+	pretty_print_bit(NOTIFY_PEERS_LOST_PRIMARY);
+	pretty_print_bit(CHECKING_PEER);
+	pretty_print_bit(CONN_CONGESTED);
+	pretty_print_bit(CONN_HANDSHAKE_DISCONNECT);
+	pretty_print_bit(CONN_HANDSHAKE_RETRY);
+	pretty_print_bit(CONN_HANDSHAKE_READY);
+#undef pretty_print_bit
+	seq_putc(m, '\n');
+
+	u1 = atomic_read(&resource->current_tle_nr);
+	u2 = connection->send.current_epoch_nr;
+	seq_printf(m, "resource->current_tle_nr: %u\n", u1);
+	seq_printf(m, "   send.current_epoch_nr: %u (%d)\n", u2, (int)(u2 - u1));
+
+	ull1 = resource->dagtag_sector;
+	ull2 = resource->last_peer_acked_dagtag;
+	seq_printf(m, " resource->dagtag_sector: %llu\n", ull1);
+	seq_printf(m, "  last_peer_acked_dagtag: %llu (%lld)\n", ull2, (long long)(ull2 - ull1));
+	ull2 = connection->send.current_dagtag_sector;
+	seq_printf(m, " send.current_dagtag_sec: %llu (%lld)\n", ull2, (long long)(ull2 - ull1));
+	ull2 = atomic64_read(&connection->last_dagtag_sector);
+	seq_printf(m, "      last_dagtag_sector: %llu\n", ull2);
+	seq_printf(m, "last_peer_ack_dagtag_seen: %llu\n",
+			(unsigned long long) connection->last_peer_ack_dagtag_seen);
+
+	spin_lock_irq(&resource->initiator_flush_lock);
+	seq_printf(m, "resource->current_flush_sequence: %llu\n",
+			(unsigned long long) resource->current_flush_sequence);
+	seq_puts(m, "      pending_flush_mask: ");
+	seq_print_node_mask(m, resource, connection->pending_flush_mask);
+	spin_unlock_irq(&resource->initiator_flush_lock);
+
+	spin_lock_irq(&connection->primary_flush_lock);
+	seq_printf(m, "   flush_requests_dagtag: %llu\n",
+			(unsigned long long) connection->flush_requests_dagtag);
+	seq_printf(m, "          flush_sequence: %llu\n",
+			(unsigned long long) connection->flush_sequence);
+	seq_puts(m, " flush_forward_sent_mask: ");
+	seq_print_node_mask(m, resource, connection->flush_forward_sent_mask);
+	spin_unlock_irq(&connection->primary_flush_lock);
+
+	spin_lock_irq(&connection->flush_ack_lock);
+	for (u1 = 0; u1 < DRBD_PEERS_MAX; u1++) {
+		if (connection->flush_ack_sequence[u1])
+			seq_printf(m, "      flush_ack_sequence[%u]: %llu\n", u1,
+					(unsigned long long) connection->flush_ack_sequence[u1]);
+	}
+	spin_unlock_irq(&connection->flush_ack_lock);
+
+	in_flight = atomic_read(&connection->ap_in_flight);
+	seq_printf(m, "            ap_in_flight: %d KiB (%d sectors)\n", in_flight / 2, in_flight);
+
+	in_flight = atomic_read(&connection->rs_in_flight);
+	seq_printf(m, "            rs_in_flight: %d KiB (%d sectors)\n", in_flight / 2, in_flight);
+
+	seq_printf(m, "             done_ee_cnt: %d\n"
+			"          backing_ee_cnt: %d\n"
+			"           active_ee_cnt: %d\n",
+			atomic_read(&connection->done_ee_cnt),
+			atomic_read(&connection->backing_ee_cnt),
+			atomic_read(&connection->active_ee_cnt));
+	seq_printf(m, "      agreed_pro_version: %d\n", connection->agreed_pro_version);
+	seq_printf(m, "            send control: %u bytes/pckt (%u bytes, %u pckts)\n",
+		   connection->ctl_bytes / (connection->ctl_packets ?: 1),
+		   connection->ctl_bytes, connection->ctl_packets);
+	return 0;
 }
 
-static int connection_oldest_requests_release(struct inode *inode, struct file *file)
+static void pid_show(struct seq_file *m, struct drbd_thread *thi)
+{
+	struct task_struct *task = NULL;
+	pid_t pid;
+
+	spin_lock_irq(&thi->t_lock);
+	task = thi->task;
+	if (task)
+		pid = task->pid;
+	spin_unlock_irq(&thi->t_lock);
+	if (task)
+		seq_printf(m, "%d\n", pid);
+}
+
+static int connection_receiver_pid_show(struct seq_file *m, void *pos)
+{
+	struct drbd_connection *connection = m->private;
+
+	pid_show(m, &connection->receiver);
+	return 0;
+}
+
+static int connection_sender_pid_show(struct seq_file *m, void *pos)
+{
+	struct drbd_connection *connection = m->private;
+
+	pid_show(m, &connection->sender);
+	return 0;
+}
+
+static int connection_attr_release(struct inode *inode, struct file *file)
 {
 	struct drbd_connection *connection = inode->i_private;
+
 	kref_put(&connection->kref, drbd_destroy_connection);
 	return single_release(inode, file);
 }
 
-static const struct file_operations connection_oldest_requests_fops = {
-	.owner		= THIS_MODULE,
-	.open		= connection_oldest_requests_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= connection_oldest_requests_release,
+#define drbd_debugfs_connection_attr(name)				\
+static int connection_ ## name ## _open(struct inode *inode, struct file *file) \
+{									\
+	struct drbd_connection *connection = inode->i_private;		\
+	return drbd_single_open(file, connection_ ## name ## _show,	\
+				connection, &connection->kref,		\
+				drbd_destroy_connection);		\
+}									\
+static const struct file_operations connection_ ## name ## _fops = {	\
+	.owner		= THIS_MODULE,					\
+	.open		= connection_ ## name ##_open,			\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= connection_attr_release,			\
 };
 
+drbd_debugfs_connection_attr(oldest_requests)
+drbd_debugfs_connection_attr(callback_history)
+drbd_debugfs_connection_attr(transport)
+drbd_debugfs_connection_attr(debug)
+drbd_debugfs_connection_attr(receiver_pid)
+drbd_debugfs_connection_attr(sender_pid)
+
 void drbd_debugfs_connection_add(struct drbd_connection *connection)
 {
 	struct dentry *conns_dir = connection->resource->debugfs_res_connections;
+	struct drbd_peer_device *peer_device;
+	char conn_name[SHARED_SECRET_MAX];
 	struct dentry *dentry;
+	int vnr;
 
-	/* Once we enable mutliple peers,
-	 * these connections will have descriptive names.
-	 * For now, it is just the one connection to the (only) "peer". */
-	dentry = debugfs_create_dir("peer", conns_dir);
-	connection->debugfs_conn = dentry;
+	rcu_read_lock();
+	strscpy(conn_name, rcu_dereference(connection->transport.net_conf)->name);
+	rcu_read_unlock();
 
-	dentry = debugfs_create_file("callback_history", 0440,
-				     connection->debugfs_conn, connection,
-				     &connection_callback_history_fops);
-	connection->debugfs_conn_callback_history = dentry;
+	dentry = debugfs_create_dir(conn_name, conns_dir);
+	connection->debugfs_conn = dentry;
 
-	dentry = debugfs_create_file("oldest_requests", 0440,
-				     connection->debugfs_conn, connection,
-				     &connection_oldest_requests_fops);
-	connection->debugfs_conn_oldest_requests = dentry;
+	/* debugfs create file */
+	conn_dcf(callback_history);
+	conn_dcf(oldest_requests);
+	conn_dcf(transport);
+	conn_dcf(debug);
+	conn_dcf(receiver_pid);
+	conn_dcf(sender_pid);
+
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		if (!peer_device->debugfs_peer_dev)
+			drbd_debugfs_peer_device_add(peer_device);
+	}
 }
 
 void drbd_debugfs_connection_cleanup(struct drbd_connection *connection)
 {
+	drbd_debugfs_remove(&connection->debugfs_conn_sender_pid);
+	drbd_debugfs_remove(&connection->debugfs_conn_receiver_pid);
+	drbd_debugfs_remove(&connection->debugfs_conn_debug);
+	drbd_debugfs_remove(&connection->debugfs_conn_transport);
 	drbd_debugfs_remove(&connection->debugfs_conn_callback_history);
 	drbd_debugfs_remove(&connection->debugfs_conn_oldest_requests);
 	drbd_debugfs_remove(&connection->debugfs_conn);
 }
 
-static void resync_dump_detail(struct seq_file *m, struct lc_element *e)
+static void seq_printf_nice_histogram(struct seq_file *m, unsigned int *hist, unsigned int const n)
 {
-       struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
+	unsigned int i;
+	unsigned int max = 0;
+	unsigned int n_transactions = 0;
+	unsigned long n_updates = 0;
+
+	for (i = 1; i <= n; i++) {
+		if (hist[i] > max)
+			max = hist[i];
+		n_updates += i * hist[i];
+		n_transactions += hist[i];
+	}
+
+	seq_puts(m, "updates per activity log transaction\n");
+	seq_printf(m, "avg: %lu\n", n_transactions == 0 ? 0 : n_updates / n_transactions);
 
-       seq_printf(m, "%5d %s %s %s", bme->rs_left,
-		  test_bit(BME_NO_WRITES, &bme->flags) ? "NO_WRITES" : "---------",
-		  test_bit(BME_LOCKED, &bme->flags) ? "LOCKED" : "------",
-		  test_bit(BME_PRIORITY, &bme->flags) ? "PRIORITY" : "--------"
-		  );
+	if (!max)
+		return;
+
+	for (i = 0; i <= n; i++) {
+		unsigned int v = (hist[i] * 60UL + max-1) / max;
+		seq_printf(m, "%2u : %10u : %-60.*s\n", i, hist[i], v,
+			"############################################################");
+	}
 }
 
-static int device_resync_extents_show(struct seq_file *m, void *ignored)
+
+static int device_act_log_histogram_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_device *device = m->private;
 
@@ -669,8 +1148,7 @@ static int device_resync_extents_show(struct seq_file *m, void *ignored)
 	seq_printf(m, "v: %u\n\n", 0);
 
 	if (get_ldev_if_state(device, D_FAILED)) {
-		lc_seq_printf_stats(m, device->resync);
-		lc_seq_dump_details(m, device->resync, "rs_left flags", resync_dump_detail);
+		seq_printf_nice_histogram(m, device->al_histogram, AL_UPDATES_PER_TRANSACTION);
 		put_ldev(device);
 	}
 	return 0;
@@ -694,8 +1172,8 @@ static int device_act_log_extents_show(struct seq_file *m, void *ignored)
 static int device_oldest_requests_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_device *device = m->private;
-	struct drbd_resource *resource = device->resource;
-	unsigned long now = jiffies;
+	ktime_t now = ktime_get();
+	unsigned long jif = jiffies;
 	struct drbd_request *r1, *r2;
 	int i;
 
@@ -703,7 +1181,7 @@ static int device_oldest_requests_show(struct seq_file *m, void *ignored)
 	seq_printf(m, "v: %u\n\n", 0);
 
 	seq_puts(m, RQ_HDR);
-	spin_lock_irq(&resource->req_lock);
+	spin_lock_irq(&device->pending_completion_lock);
 	/* WRITE, then READ */
 	for (i = 1; i >= 0; --i) {
 		r1 = list_first_entry_or_null(&device->pending_master_completion[i],
@@ -711,11 +1189,89 @@ static int device_oldest_requests_show(struct seq_file *m, void *ignored)
 		r2 = list_first_entry_or_null(&device->pending_completion[i],
 			struct drbd_request, req_pending_local);
 		if (r1)
-			seq_print_one_request(m, r1, now);
+			seq_print_one_request(m, r1, now, jif);
 		if (r2 && r2 != r1)
-			seq_print_one_request(m, r2, now);
+			seq_print_one_request(m, r2, now, jif);
+	}
+	spin_unlock_irq(&device->pending_completion_lock);
+	return 0;
+}
+
+static int device_openers_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	struct drbd_resource *resource = device->resource;
+	ktime_t now = ktime_get_real();
+	struct opener *tmp;
+
+	spin_lock(&device->openers_lock);
+	list_for_each_entry(tmp, &device->openers, list)
+		seq_printf(m, "%s\t%d\t%lld\n", tmp->comm, tmp->pid,
+			ktime_to_ms(ktime_sub(now, tmp->opened)));
+	spin_unlock(&device->openers_lock);
+	if (mutex_trylock(&resource->open_release)) {
+		if (resource->auto_promoted_by.pid != 0
+		&&  device->minor == resource->auto_promoted_by.minor) {
+			seq_printf(m, "+%s\t%d\t%lld\n",
+				resource->auto_promoted_by.comm,
+				resource->auto_promoted_by.pid,
+				ktime_to_ms(ktime_sub(now, resource->auto_promoted_by.opened)));
+		}
+		mutex_unlock(&resource->open_release);
 	}
-	spin_unlock_irq(&resource->req_lock);
+
+	return 0;
+}
+
+static int device_md_io_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+
+	if (get_ldev_if_state(device, D_FAILED)) {
+		seq_puts(m, drbd_md_dax_active(device->ldev) ? "dax-pmem\n" : "blk-bio\n");
+		put_ldev(device);
+	}
+
+	return 0;
+}
+
+static void seq_printf_interval_tree(struct seq_file *m, struct rb_root *root)
+{
+	struct rb_node *node;
+
+	node = rb_first(root);
+	while (node) {
+		struct drbd_interval *i = rb_entry(node, struct drbd_interval, rb);
+		char sep = ' ';
+
+		seq_printf(m, "%llus+%u %s", (unsigned long long) i->sector, i->size, drbd_interval_type_str(i));
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_READY_TO_SEND, &i->flags), &sep,
+				"ready-to-send");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_SENT, &i->flags), &sep, "sent");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_RECEIVED, &i->flags), &sep, "received");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_SUBMIT_CONFLICT_QUEUED, &i->flags), &sep, "submit-conflict-queued");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_SUBMITTED, &i->flags), &sep, "submitted");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_BACKING_COMPLETED, &i->flags), &sep, "backing-completed");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_COMPLETED, &i->flags), &sep, "completed");
+		seq_print_rq_state_bit(m, test_bit(INTERVAL_CANCELED, &i->flags), &sep, "canceled");
+		seq_putc(m, '\n');
+
+		node = rb_next(node);
+	}
+}
+
+static int device_interval_tree_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+
+	spin_lock_irq(&device->interval_lock);
+	seq_puts(m, "Write requests:\n");
+	seq_printf_interval_tree(m, &device->requests);
+	seq_putc(m, '\n');
+	seq_puts(m, "Read requests:\n");
+	seq_printf_interval_tree(m, &device->read_requests);
+	spin_unlock_irq(&device->interval_lock);
+
 	return 0;
 }
 
@@ -723,63 +1279,250 @@ static int device_data_gen_id_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_device *device = m->private;
 	struct drbd_md *md;
-	enum drbd_uuid_index idx;
+	int node_id, i = 0;
 
 	if (!get_ldev_if_state(device, D_FAILED))
 		return -ENODEV;
 
 	md = &device->ldev->md;
+
 	spin_lock_irq(&md->uuid_lock);
-	for (idx = UI_CURRENT; idx <= UI_HISTORY_END; idx++) {
-		seq_printf(m, "0x%016llX\n", md->uuid[idx]);
+	seq_printf(m, "0x%016llX\n", drbd_current_uuid(device));
+
+	for (node_id = 0; node_id < DRBD_NODE_ID_MAX; node_id++) {
+		struct drbd_peer_md *peer_md = &md->peers[node_id];
+
+		if (!test_bit(__MDF_HAVE_BITMAP, &peer_md->flags))
+			continue;
+		/* A divergence bitmap fully records the divergence and is safe to
+		 * copy; without the flag it is a convergence bitmap being cleared
+		 * by a resync.
+		 */
+		seq_printf(m, "%s[%d]0x%016llX%s%s", i++ ? " " : "", node_id,
+			   peer_md->bitmap_uuid,
+			   test_bit(__MDF_PEER_DIVERGENCE_BITMAP, &peer_md->flags) ?
+				   "(DIVERGENCE_BITMAP)" : "",
+			   test_bit(__MDF_PEER_BITMAP_AUTHORITATIVE, &peer_md->flags) ?
+				   "(BITMAP_AUTHORITATIVE)" : "");
 	}
+	seq_putc(m, '\n');
+
+	for (i = 0; i < HISTORY_UUIDS; i++)
+		seq_printf(m, "0x%016llX\n", drbd_history_uuid(device, i));
 	spin_unlock_irq(&md->uuid_lock);
 	put_ldev(device);
 	return 0;
 }
 
+static int device_io_frozen_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	unsigned long flags = device->flags;
+	char obligation[GEN_OBL_STR_MAX];
+	char sep = ' ';
+
+	if (!get_ldev_if_state(device, D_FAILED))
+		return -ENODEV;
+
+	/* BUMP me if you change the file format/content/presentation */
+	seq_printf(m, "v: %u\n\n", 2);
+
+	seq_printf(m, "drbd_suspended(): %d\n", drbd_suspended(device));
+	seq_printf(m, "suspend_cnt: %d\n", atomic_read(&device->suspend_cnt));
+	seq_printf(m, "!drbd_state_is_stable(): %d\n", device->cached_state_unstable);
+	seq_printf(m, "ap_bio_cnt[READ]: %d\n", atomic_read(&device->ap_bio_cnt[READ]));
+	seq_printf(m, "ap_bio_cnt[WRITE]: %d\n", atomic_read(&device->ap_bio_cnt[WRITE]));
+	seq_printf(m, "device->pending_bitmap_work.n: %d\n", atomic_read(&device->pending_bitmap_work.n));
+	seq_printf(m, "may_inc_ap_bio(): %d\n", may_inc_ap_bio(device));
+	drbd_gen_obligation_str(READ_ONCE(device->gen_obligation), obligation, sizeof(obligation));
+	seq_printf(m, "gen-obligation: %s\n", obligation);
+	seq_printf(m, "flags: 0x%04lx :", flags);
+#define pretty_print_bit(n) \
+	seq_print_rq_state_bit(m, test_bit(n, &flags), &sep, #n)
+	pretty_print_bit(MAKE_NEW_CUR_UUID);
+#undef pretty_print_bit
+	seq_putc(m, '\n');
+	put_ldev(device);
+
+	return 0;
+}
+
+static int device_al_updates_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	bool al_updates, cfg_al_updates;
+
+	if (!get_ldev_if_state(device, D_FAILED))
+		return -ENODEV;
+
+	al_updates = !(device->ldev->md.flags & MDF_AL_DISABLED);
+	rcu_read_lock();
+	cfg_al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
+	rcu_read_unlock();
+	put_ldev(device);
+
+	seq_printf(m, "%s\n",
+		    al_updates &&  cfg_al_updates ? "yes" :
+		   !al_updates &&  cfg_al_updates ? "no (optimized)" :
+		   !al_updates && !cfg_al_updates ? "no" :
+		   "?");
+	return 0;
+}
+
 static int device_ed_gen_id_show(struct seq_file *m, void *ignored)
 {
 	struct drbd_device *device = m->private;
-	seq_printf(m, "0x%016llX\n", (unsigned long long)device->ed_uuid);
+
+	seq_printf(m, "0x%016llX\n", (unsigned long long)device->exposed_data_uuid);
+	return 0;
+}
+
+static int device_multi_bio_cnt_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+
+	seq_printf(m, "%u\n", device->multi_bio_cnt);
 	return 0;
 }
 
-#define drbd_debugfs_device_attr(name)						\
+#define show_per_peer(M) do {							\
+		seq_printf(m, "%-16s", #M ":");					\
+		for_each_peer_device(peer_device, device)			\
+			seq_printf(m, " %12lld", ktime_to_ns(peer_device->M));	\
+		seq_printf(m, "\n");						\
+	} while (0)
+
+#define PRId64 "lld"
+
+#ifdef CONFIG_DRBD_TIMING_STATS
+static int device_req_timing_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	struct drbd_peer_device *peer_device;
+
+	seq_printf(m,
+		   "timing values are nanoseconds; write an 'r' to reset all to 0\n\n"
+		   "requests:        %12lu\n"
+		   "before_queue:    %12" PRId64 "\n"
+		   "before_al_begin  %12" PRId64 "\n"
+		   "in_actlog:       %12" PRId64 "\n"
+		   "pre_submit:      %12" PRId64 "\n\n"
+		   "al_updates:      %12u\n"
+		   "before_bm_write  %12" PRId64 "\n"
+		   "mid              %12" PRId64 "\n"
+		   "after_sync_page  %12" PRId64 "\n",
+		   device->reqs,
+		   ktime_to_ns(device->before_queue_kt),
+		   ktime_to_ns(device->before_al_begin_io_kt),
+		   ktime_to_ns(device->in_actlog_kt),
+		   ktime_to_ns(device->pre_submit_kt),
+		   device->al_writ_cnt,
+		   ktime_to_ns(device->al_before_bm_write_hinted_kt),
+		   ktime_to_ns(device->al_mid_kt),
+		   ktime_to_ns(device->al_after_sync_page_kt));
+
+	seq_puts(m, "\npeer:           ");
+	for_each_peer_device(peer_device, device) {
+		struct drbd_connection *connection = peer_device->connection;
+
+		seq_printf(m, " %12.12s", rcu_dereference(connection->transport.net_conf)->name);
+	}
+	seq_puts(m, "\n");
+	show_per_peer(pre_send_kt);
+	show_per_peer(acked_kt);
+	show_per_peer(net_done_kt);
+
+	return 0;
+}
+
+static ssize_t device_req_timing_write(struct file *file, const char __user *ubuf,
+				       size_t cnt, loff_t *ppos)
+{
+	struct drbd_device *device = file_inode(file)->i_private;
+	char buffer;
+
+	if (copy_from_user(&buffer, ubuf, 1))
+		return -EFAULT;
+
+	if (buffer == 'r' || buffer == 'R') {
+		struct drbd_peer_device *peer_device;
+		unsigned long flags;
+
+		spin_lock_irqsave(&device->timing_lock, flags);
+		device->reqs = 0;
+		device->in_actlog_kt = ns_to_ktime(0);
+		device->pre_submit_kt = ns_to_ktime(0);
+
+		device->before_queue_kt = ns_to_ktime(0);
+		device->before_al_begin_io_kt = ns_to_ktime(0);
+		device->al_writ_cnt = 0;
+		device->al_before_bm_write_hinted_kt = ns_to_ktime(0);
+		device->al_mid_kt = ns_to_ktime(0);
+		device->al_after_sync_page_kt = ns_to_ktime(0);
+
+		for_each_peer_device(peer_device, device) {
+			peer_device->pre_send_kt = ns_to_ktime(0);
+			peer_device->acked_kt = ns_to_ktime(0);
+			peer_device->net_done_kt = ns_to_ktime(0);
+		}
+		spin_unlock_irqrestore(&device->timing_lock, flags);
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+#endif
+
+static int device_attr_release(struct inode *inode, struct file *file)
+{
+	struct drbd_device *device = inode->i_private;
+
+	kref_put(&device->kref, drbd_destroy_device);
+	return single_release(inode, file);
+}
+
+#define __drbd_debugfs_device_attr(name, write_fn)				\
 static int device_ ## name ## _open(struct inode *inode, struct file *file)	\
 {										\
 	struct drbd_device *device = inode->i_private;				\
 	return drbd_single_open(file, device_ ## name ## _show, device,		\
 				&device->kref, drbd_destroy_device);		\
 }										\
-static int device_ ## name ## _release(struct inode *inode, struct file *file)	\
-{										\
-	struct drbd_device *device = inode->i_private;				\
-	kref_put(&device->kref, drbd_destroy_device);				\
-	return single_release(inode, file);					\
-}										\
 static const struct file_operations device_ ## name ## _fops = {		\
 	.owner		= THIS_MODULE,						\
 	.open		= device_ ## name ## _open,				\
+	.write          = write_fn,						\
 	.read		= seq_read,						\
 	.llseek		= seq_lseek,						\
-	.release	= device_ ## name ## _release,				\
+	.release	= device_attr_release,					\
 };
+#define drbd_debugfs_device_attr(name) __drbd_debugfs_device_attr(name, NULL)
 
 drbd_debugfs_device_attr(oldest_requests)
 drbd_debugfs_device_attr(act_log_extents)
-drbd_debugfs_device_attr(resync_extents)
+drbd_debugfs_device_attr(act_log_histogram)
 drbd_debugfs_device_attr(data_gen_id)
+drbd_debugfs_device_attr(io_frozen)
 drbd_debugfs_device_attr(ed_gen_id)
+drbd_debugfs_device_attr(openers)
+drbd_debugfs_device_attr(md_io)
+drbd_debugfs_device_attr(interval_tree)
+drbd_debugfs_device_attr(al_updates)
+drbd_debugfs_device_attr(multi_bio_cnt)
+#ifdef CONFIG_DRBD_TIMING_STATS
+__drbd_debugfs_device_attr(req_timing, device_req_timing_write)
+#endif
 
 void drbd_debugfs_device_add(struct drbd_device *device)
 {
 	struct dentry *vols_dir = device->resource->debugfs_res_volumes;
+	struct drbd_peer_device *peer_device;
 	char minor_buf[8]; /* MINORMASK, MINORBITS == 20; */
 	char vnr_buf[8];   /* volume number vnr is even 16 bit only; */
 	char *slink_name = NULL;
 
 	struct dentry *dentry;
+
 	if (!vols_dir || !drbd_debugfs_minors)
 		return;
 
@@ -797,19 +1540,28 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	kfree(slink_name);
 	slink_name = NULL;
 
-#define DCF(name)	do {					\
-	dentry = debugfs_create_file(#name, 0440,	\
-			device->debugfs_vol, device,		\
-			&device_ ## name ## _fops);		\
-	device->debugfs_vol_ ## name = dentry;			\
-	} while (0)
+	/* debugfs create file */
+	vol_dcf(oldest_requests);
+	vol_dcf(act_log_extents);
+	vol_dcf(act_log_histogram);
+	vol_dcf(data_gen_id);
+	vol_dcf(io_frozen);
+	vol_dcf(ed_gen_id);
+	vol_dcf(openers);
+	vol_dcf(md_io);
+	vol_dcf(interval_tree);
+	vol_dcf(al_updates);
+	vol_dcf(multi_bio_cnt);
+#ifdef CONFIG_DRBD_TIMING_STATS
+	drbd_dcf(device->debugfs_vol, device, req_timing, 0600);
+#endif
+
+	/* Caller holds conf_update */
+	for_each_peer_device(peer_device, device) {
+		if (!peer_device->debugfs_peer_dev)
+			drbd_debugfs_peer_device_add(peer_device);
+	}
 
-	DCF(oldest_requests);
-	DCF(act_log_extents);
-	DCF(resync_extents);
-	DCF(data_gen_id);
-	DCF(ed_gen_id);
-#undef DCF
 	return;
 
 fail:
@@ -822,12 +1574,383 @@ void drbd_debugfs_device_cleanup(struct drbd_device *device)
 	drbd_debugfs_remove(&device->debugfs_minor);
 	drbd_debugfs_remove(&device->debugfs_vol_oldest_requests);
 	drbd_debugfs_remove(&device->debugfs_vol_act_log_extents);
-	drbd_debugfs_remove(&device->debugfs_vol_resync_extents);
+	drbd_debugfs_remove(&device->debugfs_vol_act_log_histogram);
 	drbd_debugfs_remove(&device->debugfs_vol_data_gen_id);
+	drbd_debugfs_remove(&device->debugfs_vol_io_frozen);
 	drbd_debugfs_remove(&device->debugfs_vol_ed_gen_id);
+	drbd_debugfs_remove(&device->debugfs_vol_openers);
+	drbd_debugfs_remove(&device->debugfs_vol_md_io);
+	drbd_debugfs_remove(&device->debugfs_vol_interval_tree);
+	drbd_debugfs_remove(&device->debugfs_vol_al_updates);
+	drbd_debugfs_remove(&device->debugfs_vol_multi_bio_cnt);
+#ifdef CONFIG_DRBD_TIMING_STATS
+	drbd_debugfs_remove(&device->debugfs_vol_req_timing);
+#endif
 	drbd_debugfs_remove(&device->debugfs_vol);
 }
 
+static int drbd_single_open_peer_device(struct file *file,
+					int (*show)(struct seq_file *, void *),
+					struct drbd_peer_device *peer_device)
+{
+	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
+	bool got_connection, got_device;
+	struct dentry *parent;
+
+	parent = file->f_path.dentry->d_parent;
+	if (!parent || !parent->d_inode)
+		goto out;
+	inode_lock(d_inode(parent));
+	if (!simple_positive(file->f_path.dentry))
+		goto out_unlock;
+
+	got_connection = kref_get_unless_zero(&connection->kref);
+	got_device = kref_get_unless_zero(&device->kref);
+
+	if (got_connection && got_device) {
+		int ret;
+
+		inode_unlock(d_inode(parent));
+		ret = single_open(file, show, peer_device);
+		if (ret) {
+			kref_put(&connection->kref, drbd_destroy_connection);
+			kref_put(&device->kref, drbd_destroy_device);
+		}
+		return ret;
+	}
+
+	if (got_connection)
+		kref_put(&connection->kref, drbd_destroy_connection);
+	if (got_device)
+		kref_put(&device->kref, drbd_destroy_device);
+out_unlock:
+	inode_unlock(d_inode(parent));
+out:
+	return -ESTALE;
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
+static void drbd_get_syncer_progress(struct drbd_peer_device *pd,
+		enum drbd_repl_state repl_state, unsigned long *rs_total,
+		unsigned long *bits_left, unsigned int *per_mil_done)
+{
+	/* this is to break it at compile time when we change that, in case we
+	 * want to support more than (1<<32) bits on a 32bit arch. */
+	typecheck(unsigned long, pd->rs_total);
+	*rs_total = pd->rs_total;
+
+	/* note: both rs_total and rs_left are in bits, i.e. in
+	 * units of BM_BLOCK_SIZE.
+	 * for the percentage, we don't care. */
+
+	if (repl_state == L_VERIFY_S || repl_state == L_VERIFY_T)
+		*bits_left = atomic64_read(&pd->ov_left);
+	else
+		*bits_left = drbd_bm_total_weight(pd) - pd->rs_failed;
+	/* >> 10 to prevent overflow,
+	 * +1 to prevent division by zero */
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
+	drbd_get_syncer_progress(pd, repl_state, &rs_total, &rs_left, &res);
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
+	 * least DRBD_SYNC_MARK_STEP time before it will be modified. */
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
+	/* mean speed since syncer started
+	 * we do account for PausedSync periods */
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
+		/* 64 bit:
+		 * we convert to sectors in the display below. */
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
+		/* Total sectors may be slightly off for oddly
+		 * sized devices. So what. */
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
+static int peer_device_proc_drbd_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_peer_device *peer_device = m->private;
+	struct drbd_device *device = peer_device->device;
+	union drbd_state state;
+	const char *sn;
+	struct drbd_net_conf *nc;
+	bool have_ldev;
+	char wp;
+
+	state.disk = device->disk_state[NOW];
+	state.pdsk = peer_device->disk_state[NOW];
+	state.conn = peer_device->repl_state[NOW];
+	state.role = device->resource->role[NOW];
+	state.peer = peer_device->connection->peer_role[NOW];
+
+	state.user_isp = peer_device->resync_susp_user[NOW];
+	state.peer_isp = peer_device->resync_susp_peer[NOW];
+	state.aftr_isp = peer_device->resync_susp_dependency[NOW];
+
+	sn = drbd_repl_str(state.conn);
+
+	rcu_read_lock();
+	have_ldev = get_ldev_if_state(device, D_FAILED);
+
+	/* reset device->congestion_reason */
+
+	nc = rcu_dereference(peer_device->connection->transport.net_conf);
+	wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
+	seq_printf(m,
+		   "%2d: cs:%s ro:%s/%s ds:%s/%s %c %c%c%c%c%c%c\n"
+		   "    ns:%u nr:%u dw:%u dr:%u al:%u bm:%u "
+		   "lo:%d pe:[%d;%d] ua:%d ap:[%d;%d] ep:%d wo:%d",
+		   device->minor, sn,
+		   drbd_role_str(state.role),
+		   drbd_role_str(state.peer),
+		   drbd_disk_str(state.disk),
+		   drbd_disk_str(state.pdsk),
+		   wp,
+		   drbd_suspended(device) ? 's' : 'r',
+		   state.aftr_isp ? 'a' : '-',
+		   state.peer_isp ? 'p' : '-',
+		   state.user_isp ? 'u' : '-',
+		   '-' /* congestion reason... FIXME */,
+		   test_bit(AL_SUSPENDED, &device->flags) ? 's' : '-',
+		   peer_device->send_cnt/2,
+		   peer_device->recv_cnt/2,
+		   device->writ_cnt/2,
+		   device->read_cnt/2,
+		   device->al_writ_cnt,
+		   device->bm_writ_cnt,
+		   atomic_read(&device->local_cnt),
+		   atomic_read(&peer_device->ap_pending_cnt),
+		   atomic_read(&peer_device->rs_pending_cnt),
+		   atomic_read(&peer_device->unacked_cnt),
+		   atomic_read(&device->ap_bio_cnt[WRITE]),
+		   atomic_read(&device->ap_bio_cnt[READ]),
+		   peer_device->connection->epochs,
+		   device->resource->write_ordering
+		);
+
+	seq_printf(m, " oos:%llu\n",
+		   have_ldev ? device_bit_to_kb(device, drbd_bm_total_weight(peer_device)) : 0);
+
+	if (have_ldev) {
+		if (state.conn == L_SYNC_SOURCE ||
+		    state.conn == L_SYNC_TARGET ||
+		    state.conn == L_VERIFY_S ||
+		    state.conn == L_VERIFY_T)
+			drbd_syncer_progress(peer_device, m, state.conn);
+
+		lc_seq_printf_stats(m, device->act_log);
+
+		put_ldev(device);
+	}
+
+	seq_printf(m, "\tblocked on activity log: %d/%d/%d\n",
+		atomic_read(&device->ap_actlog_cnt),	/* requests */
+		atomic_read(&device->wait_for_actlog),	/* peer_requests */
+		/* nr extents needed to satisfy the above in the worst case */
+		atomic_read(&device->wait_for_actlog_ecnt));
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
+#define drbd_debugfs_peer_device_attr(name)					\
+static int peer_device_ ## name ## _open(struct inode *inode, struct file *file)\
+{										\
+	struct drbd_peer_device *peer_device = inode->i_private;		\
+	return drbd_single_open_peer_device(file,				\
+					    peer_device_ ## name ## _show,	\
+					    peer_device);			\
+}										\
+static int peer_device_ ## name ## _release(struct inode *inode, struct file *file)\
+{										\
+	struct drbd_peer_device *peer_device = inode->i_private;		\
+	kref_put(&peer_device->connection->kref, drbd_destroy_connection);	\
+	kref_put(&peer_device->device->kref, drbd_destroy_device);		\
+	return single_release(inode, file);					\
+}										\
+static const struct file_operations peer_device_ ## name ## _fops = {		\
+	.owner		= THIS_MODULE,						\
+	.open		= peer_device_ ## name ## _open,			\
+	.read		= seq_read,						\
+	.llseek		= seq_lseek,						\
+	.release	= peer_device_ ## name ## _release,			\
+};
+
+drbd_debugfs_peer_device_attr(proc_drbd)
+
 void drbd_debugfs_peer_device_add(struct drbd_peer_device *peer_device)
 {
 	struct dentry *conn_dir = peer_device->connection->debugfs_conn;
@@ -837,10 +1960,14 @@ void drbd_debugfs_peer_device_add(struct drbd_peer_device *peer_device)
 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", peer_device->device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, conn_dir);
 	peer_device->debugfs_peer_dev = dentry;
+
+	/* debugfs create file */
+	peer_dev_dcf(proc_drbd);
 }
 
 void drbd_debugfs_peer_device_cleanup(struct drbd_peer_device *peer_device)
 {
+	drbd_debugfs_remove(&peer_device->debugfs_peer_dev_proc_drbd);
 	drbd_debugfs_remove(&peer_device->debugfs_peer_dev);
 }
 
@@ -851,6 +1978,11 @@ static int drbd_version_show(struct seq_file *m, void *ignored)
 	seq_printf(m, "API_VERSION=%u\n", DRBD_FAMILY_VERSION);
 	seq_printf(m, "PRO_VERSION_MIN=%u\n", PRO_VERSION_MIN);
 	seq_printf(m, "PRO_VERSION_MAX=%u\n", PRO_VERSION_MAX);
+#ifdef UTS_RELEASE
+	/* the UTS_RELEASE string of the prepared kernel source tree this
+	 * module was built against */
+	seq_printf(m, "UTS_RELEASE=%s\n", UTS_RELEASE);
+#endif
 	return 0;
 }
 
@@ -867,13 +1999,52 @@ static const struct file_operations drbd_version_fops = {
 	.release = single_release,
 };
 
+static int drbd_refcounts_show(struct seq_file *m, void *ignored)
+{
+	seq_printf(m, "v: %u\n\n", 0);
+	return 0;
+}
+
+static int drbd_refcounts_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, drbd_refcounts_show, NULL);
+}
+
+static const struct file_operations drbd_refcounts_fops = {
+	.owner = THIS_MODULE,
+	.open = drbd_refcounts_open,
+	.llseek = seq_lseek,
+	.read = seq_read,
+	.release = single_release,
+};
+
+static int drbd_compat_show(struct seq_file *m, void *ignored)
+{
+	return 0;
+}
+
+static int drbd_compat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, drbd_compat_show, NULL);
+}
+
+static const struct file_operations drbd_compat_fops = {
+	.owner = THIS_MODULE,
+	.open = drbd_compat_open,
+	.llseek = seq_lseek,
+	.read = seq_read,
+	.release = single_release,
+};
+
 /* not __exit, may be indirectly called
  * from the module-load-failure path as well. */
 void drbd_debugfs_cleanup(void)
 {
+	drbd_debugfs_remove(&drbd_debugfs_compat);
 	drbd_debugfs_remove(&drbd_debugfs_resources);
 	drbd_debugfs_remove(&drbd_debugfs_minors);
 	drbd_debugfs_remove(&drbd_debugfs_version);
+	drbd_debugfs_remove(&drbd_debugfs_refcounts);
 	drbd_debugfs_remove(&drbd_debugfs_root);
 }
 
@@ -887,9 +2058,15 @@ void __init drbd_debugfs_init(void)
 	dentry = debugfs_create_file("version", 0444, drbd_debugfs_root, NULL, &drbd_version_fops);
 	drbd_debugfs_version = dentry;
 
+	dentry = debugfs_create_file("reference_counts", 0444, drbd_debugfs_root, NULL, &drbd_refcounts_fops);
+	drbd_debugfs_refcounts = dentry;
+
 	dentry = debugfs_create_dir("resources", drbd_debugfs_root);
 	drbd_debugfs_resources = dentry;
 
 	dentry = debugfs_create_dir("minors", drbd_debugfs_root);
 	drbd_debugfs_minors = dentry;
+
+	dentry = debugfs_create_file("compat", 0444, drbd_debugfs_root, NULL, &drbd_compat_fops);
+	drbd_debugfs_compat = dentry;
 }
diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 2c12297ffdaf..8f4606e5bc62 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -4,6 +4,7 @@
  */
 
 #include <asm/bug.h>
+#include <linux/kernel.h>
 #include <linux/rbtree_augmented.h>
 #include "drbd_interval.h"
 
@@ -14,13 +15,33 @@ static inline
 sector_t interval_end(struct rb_node *node)
 {
 	struct drbd_interval *this = rb_entry(node, struct drbd_interval, rb);
+
 	return this->end;
 }
 
 #define NODE_END(node) ((node)->sector + ((node)->size >> 9))
+RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks, struct drbd_interval, rb,
+		sector_t, end, NODE_END);
+
+static const char * const drbd_interval_type_names[] = {
+	[INTERVAL_LOCAL_WRITE]    = "LocalWrite",
+	[INTERVAL_PEER_WRITE]     = "PeerWrite",
+	[INTERVAL_RESYNC_WRITE]   = "ResyncWrite",
+	[INTERVAL_RESYNC_READ]    = "ResyncRead",
+	[INTERVAL_OV_READ_SOURCE] = "VerifySource",
+	[INTERVAL_OV_READ_TARGET] = "VerifyTarget",
+	[INTERVAL_PEERS_IN_SYNC_LOCK] = "PeersInSync",
+};
+
+const char *drbd_interval_type_str(struct drbd_interval *i)
+{
+	enum drbd_interval_type type = i->type;
+	unsigned int size = ARRAY_SIZE(drbd_interval_type_names);
 
-RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
-			 struct drbd_interval, rb, sector_t, end, NODE_END);
+	return (type < 0 || type >= size ||
+		!drbd_interval_type_names[type]) ?
+		       "?" : drbd_interval_type_names[type];
+}
 
 /*
  * drbd_insert_interval  -  insert a new interval into a tree
@@ -106,6 +127,18 @@ drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 	rb_erase_augmented(&this->rb, root, &augment_callbacks);
 }
 
+void drbd_update_interval_size(struct drbd_interval *this, unsigned int new_size)
+{
+	this->size = new_size;
+
+	/* The size is one of the inputs to calculate the tree node's
+	 * augmented value. When we change it we need to update the augmented
+	 * value in this node and maybe in some parent nodes. That might be
+	 * all the way up to the root. As this function is used for joining
+	 * intervals, usually it will propagate only to the parent node. */
+	augment_callbacks_propagate(&this->rb, NULL);
+}
+
 /**
  * drbd_find_overlap  - search for an interval overlapping with [sector, sector + size)
  * @root:	red black tree root
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index fb2b68c5c5f7..0f5a83288a44 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -3,313 +3,44 @@
  * Copyright (C) 2001, LINBIT HA-Solutions GmbH.
  */
 
-#include <linux/module.h>
-
-#include <linux/uaccess.h>
-#include <linux/fs.h>
-#include <linux/file.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/drbd.h>
+#include <linux/drbd_genl.h>
 #include "drbd_int.h"
+#include "drbd_transport.h"
+#include "drbd_legacy_84.h"
 
 struct proc_dir_entry *drbd_proc;
 
-static void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
-{
-	/* v is in kB/sec. We don't expect TiByte/sec yet. */
-	if (unlikely(v >= 1000000)) {
-		/* cool: > GiByte/s */
-		seq_printf(seq, "%ld,", v / 1000000);
-		v %= 1000000;
-		seq_printf(seq, "%03ld,%03ld", v/1000, v % 1000);
-	} else if (likely(v >= 1000))
-		seq_printf(seq, "%ld,%03ld", v/1000, v % 1000);
-	else
-		seq_printf(seq, "%ld", v);
-}
-
-static void drbd_get_syncer_progress(struct drbd_device *device,
-		union drbd_dev_state state, unsigned long *rs_total,
-		unsigned long *bits_left, unsigned int *per_mil_done)
-{
-	/* this is to break it at compile time when we change that, in case we
-	 * want to support more than (1<<32) bits on a 32bit arch. */
-	typecheck(unsigned long, device->rs_total);
-	*rs_total = device->rs_total;
-
-	/* note: both rs_total and rs_left are in bits, i.e. in
-	 * units of BM_BLOCK_SIZE.
-	 * for the percentage, we don't care. */
-
-	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)
-		*bits_left = device->ov_left;
-	else
-		*bits_left = drbd_bm_total_weight(device) - device->rs_failed;
-	/* >> 10 to prevent overflow,
-	 * +1 to prevent division by zero */
-	if (*bits_left > *rs_total) {
-		/* D'oh. Maybe a logic bug somewhere.  More likely just a race
-		 * between state change and reset of rs_total.
-		 */
-		*bits_left = *rs_total;
-		*per_mil_done = *rs_total ? 0 : 1000;
-	} else {
-		/* Make sure the division happens in long context.
-		 * We allow up to one petabyte storage right now,
-		 * at a granularity of 4k per bit that is 2**38 bits.
-		 * After shift right and multiplication by 1000,
-		 * this should still fit easily into a 32bit long,
-		 * so we don't need a 64bit division on 32bit arch.
-		 * Note: currently we don't support such large bitmaps on 32bit
-		 * arch anyways, but no harm done to be prepared for it here.
-		 */
-		unsigned int shift = *rs_total > UINT_MAX ? 16 : 10;
-		unsigned long left = *bits_left >> shift;
-		unsigned long total = 1UL + (*rs_total >> shift);
-		unsigned long tmp = 1000UL - left * 1000UL/total;
-		*per_mil_done = tmp;
-	}
-}
-
-
-/*lge
- * progress bars shamelessly adapted from driver/md/md.c
- * output looks like
- *	[=====>..............] 33.5% (23456/123456)
- *	finish: 2:20:20 speed: 6,345 (6,456) K/sec
- */
-static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *seq,
-		union drbd_dev_state state)
-{
-	unsigned long db, dt, dbdt, rt, rs_total, rs_left;
-	unsigned int res;
-	int i, x, y;
-	int stalled = 0;
-
-	drbd_get_syncer_progress(device, state, &rs_total, &rs_left, &res);
-
-	x = res/50;
-	y = 20-x;
-	seq_puts(seq, "\t[");
-	for (i = 1; i < x; i++)
-		seq_putc(seq, '=');
-	seq_putc(seq, '>');
-	for (i = 0; i < y; i++)
-		seq_putc(seq, '.');
-	seq_puts(seq, "] ");
-
-	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)
-		seq_puts(seq, "verified:");
-	else
-		seq_puts(seq, "sync'ed:");
-	seq_printf(seq, "%3u.%u%% ", res / 10, res % 10);
-
-	/* if more than a few GB, display in MB */
-	if (rs_total > (4UL << (30 - BM_BLOCK_SHIFT)))
-		seq_printf(seq, "(%lu/%lu)M",
-			    (unsigned long) Bit2KB(rs_left >> 10),
-			    (unsigned long) Bit2KB(rs_total >> 10));
-	else
-		seq_printf(seq, "(%lu/%lu)K",
-			    (unsigned long) Bit2KB(rs_left),
-			    (unsigned long) Bit2KB(rs_total));
-
-	seq_puts(seq, "\n\t");
-
-	/* see drivers/md/md.c
-	 * We do not want to overflow, so the order of operands and
-	 * the * 100 / 100 trick are important. We do a +1 to be
-	 * safe against division by zero. We only estimate anyway.
-	 *
-	 * dt: time from mark until now
-	 * db: blocks written from mark until now
-	 * rt: remaining time
-	 */
-	/* Rolling marks. last_mark+1 may just now be modified.  last_mark+2 is
-	 * at least (DRBD_SYNC_MARKS-2)*DRBD_SYNC_MARK_STEP old, and has at
-	 * least DRBD_SYNC_MARK_STEP time before it will be modified. */
-	/* ------------------------ ~18s average ------------------------ */
-	i = (device->rs_last_mark + 2) % DRBD_SYNC_MARKS;
-	dt = (jiffies - device->rs_mark_time[i]) / HZ;
-	if (dt > 180)
-		stalled = 1;
-
-	if (!dt)
-		dt++;
-	db = device->rs_mark_left[i] - rs_left;
-	rt = (dt * (rs_left / (db/100+1)))/100; /* seconds */
-
-	seq_printf(seq, "finish: %lu:%02lu:%02lu",
-		rt / 3600, (rt % 3600) / 60, rt % 60);
-
-	dbdt = Bit2KB(db/dt);
-	seq_puts(seq, " speed: ");
-	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_puts(seq, " (");
-	/* ------------------------- ~3s average ------------------------ */
-	if (drbd_proc_details >= 1) {
-		/* this is what drbd_rs_should_slow_down() uses */
-		i = (device->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
-		dt = (jiffies - device->rs_mark_time[i]) / HZ;
-		if (!dt)
-			dt++;
-		db = device->rs_mark_left[i] - rs_left;
-		dbdt = Bit2KB(db/dt);
-		seq_printf_with_thousands_grouping(seq, dbdt);
-		seq_puts(seq, " -- ");
-	}
-
-	/* --------------------- long term average ---------------------- */
-	/* mean speed since syncer started
-	 * we do account for PausedSync periods */
-	dt = (jiffies - device->rs_start - device->rs_paused) / HZ;
-	if (dt == 0)
-		dt = 1;
-	db = rs_total - rs_left;
-	dbdt = Bit2KB(db/dt);
-	seq_printf_with_thousands_grouping(seq, dbdt);
-	seq_putc(seq, ')');
-
-	if (state.conn == C_SYNC_TARGET ||
-	    state.conn == C_VERIFY_S) {
-		seq_puts(seq, " want: ");
-		seq_printf_with_thousands_grouping(seq, device->c_sync_rate);
-	}
-	seq_printf(seq, " K/sec%s\n", stalled ? " (stalled)" : "");
-
-	if (drbd_proc_details >= 1) {
-		/* 64 bit:
-		 * we convert to sectors in the display below. */
-		unsigned long bm_bits = drbd_bm_bits(device);
-		unsigned long bit_pos;
-		unsigned long long stop_sector = 0;
-		if (state.conn == C_VERIFY_S ||
-		    state.conn == C_VERIFY_T) {
-			bit_pos = bm_bits - device->ov_left;
-			if (verify_can_do_stop_sector(device))
-				stop_sector = device->ov_stop_sector;
-		} else
-			bit_pos = device->bm_resync_fo;
-		/* Total sectors may be slightly off for oddly
-		 * sized devices. So what. */
-		seq_printf(seq,
-			"\t%3d%% sector pos: %llu/%llu",
-			(int)(bit_pos / (bm_bits/100+1)),
-			(unsigned long long)bit_pos * BM_SECT_PER_BIT,
-			(unsigned long long)bm_bits * BM_SECT_PER_BIT);
-		if (stop_sector != 0 && stop_sector != ULLONG_MAX)
-			seq_printf(seq, " stop sector: %llu", stop_sector);
-		seq_putc(seq, '\n');
-	}
-}
-
 int drbd_seq_show(struct seq_file *seq, void *v)
 {
-	int i, prev_i = -1;
-	const char *sn;
-	struct drbd_device *device;
-	struct net_conf *nc;
-	union drbd_dev_state state;
-	char wp;
-
-	static char write_ordering_chars[] = {
-		[WO_NONE] = 'n',
-		[WO_DRAIN_IO] = 'd',
-		[WO_BDEV_FLUSH] = 'f',
-	};
-
-	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d-%d)\n%s\n",
-		   DRBD_FAMILY_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
-
+	bool any_legacy;
 	/*
-	  cs .. connection state
-	  ro .. node role (local/remote)
-	  ds .. disk state (local/remote)
-	     protocol
-	     various flags
-	  ns .. network send
-	  nr .. network receive
-	  dw .. disk write
-	  dr .. disk read
-	  al .. activity log write count
-	  bm .. bitmap update write count
-	  pe .. pending (waiting for ack or data reply)
-	  ua .. unack'd (still need to send ack or data reply)
-	  ap .. application requests accepted, but not yet completed
-	  ep .. number of epochs currently "on the fly", P_BARRIER_ACK pending
-	  wo .. write ordering mode currently in use
-	 oos .. known out-of-sync kB
-	*/
-
-	rcu_read_lock();
-	idr_for_each_entry(&drbd_devices, device, i) {
-		if (prev_i != i - 1)
-			seq_putc(seq, '\n');
-		prev_i = i;
-
-		state = device->state;
-		sn = drbd_conn_str(state.conn);
-
-		if (state.conn == C_STANDALONE &&
-		    state.disk == D_DISKLESS &&
-		    state.role == R_SECONDARY) {
-			seq_printf(seq, "%2d: cs:Unconfigured\n", i);
-		} else {
-			/* reset device->congestion_reason */
-
-			nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
-			wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
-			seq_printf(seq,
-			   "%2d: cs:%s ro:%s/%s ds:%s/%s %c %c%c%c%c%c%c\n"
-			   "    ns:%u nr:%u dw:%u dr:%u al:%u bm:%u "
-			   "lo:%d pe:%d ua:%d ap:%d ep:%d wo:%c",
-			   i, sn,
-			   drbd_role_str(state.role),
-			   drbd_role_str(state.peer),
-			   drbd_disk_str(state.disk),
-			   drbd_disk_str(state.pdsk),
-			   wp,
-			   drbd_suspended(device) ? 's' : 'r',
-			   state.aftr_isp ? 'a' : '-',
-			   state.peer_isp ? 'p' : '-',
-			   state.user_isp ? 'u' : '-',
-			   device->congestion_reason ?: '-',
-			   test_bit(AL_SUSPENDED, &device->flags) ? 's' : '-',
-			   device->send_cnt/2,
-			   device->recv_cnt/2,
-			   device->writ_cnt/2,
-			   device->read_cnt/2,
-			   device->al_writ_cnt,
-			   device->bm_writ_cnt,
-			   atomic_read(&device->local_cnt),
-			   atomic_read(&device->ap_pending_cnt) +
-			   atomic_read(&device->rs_pending_cnt),
-			   atomic_read(&device->unacked_cnt),
-			   atomic_read(&device->ap_bio_cnt),
-			   first_peer_device(device)->connection->epochs,
-			   write_ordering_chars[device->resource->write_ordering]
-			);
-			seq_printf(seq, " oos:%llu\n",
-				   Bit2KB((unsigned long long)
-					   drbd_bm_total_weight(device)));
-		}
-		if (state.conn == C_SYNC_SOURCE ||
-		    state.conn == C_SYNC_TARGET ||
-		    state.conn == C_VERIFY_S ||
-		    state.conn == C_VERIFY_T)
-			drbd_syncer_progress(device, seq, state);
-
-		if (drbd_proc_details >= 1 && get_ldev_if_state(device, D_FAILED)) {
-			lc_seq_printf_stats(seq, device->resync);
-			lc_seq_printf_stats(seq, device->act_log);
-			put_ldev(device);
-		}
-
-		if (drbd_proc_details >= 2)
-			seq_printf(seq, "\tblocked on activity log: %d\n", atomic_read(&device->ap_actlog_cnt));
+	 * drbd-utils pick their tools by the token after "version:". A v1
+	 * build also names its real release as "core:". "(compat 8.4)" tells
+	 * drbdadm that "new-resource" without a node id gives an 8.4
+	 * compatibility resource; drbdadm-84 only acts on it after a 9.x token.
+	 */
+	static const char legacy_info[] =
+#if defined(CONFIG_DRBD_COMPAT_84) && !defined(DRBD_NL_FAMILY_V2)
+		" (compat 8.4) core: " REL_VERSION;
+#elif defined(CONFIG_DRBD_COMPAT_84)
+		" (compat 8.4)";
+#else
+		"";
+#endif
+
+	seq_printf(seq, "version: " DRBD_PROC_VERSION " (api:%d/proto:%d-%d)%s\n%s\n",
+		   DRBD_FAMILY_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, legacy_info,
+		   drbd_buildtag());
+
+	any_legacy = drbd_show_legacy_device(seq, v);
+	if (!any_legacy) {
+		/*
+		 * DRBD 8 did not output the transport information, so do not
+		 * display it if any resources are in DRBD 8 compatibility mode.
+		 */
+		drbd_print_transports_loaded(seq);
 	}
-	rcu_read_unlock();
-
 	return 0;
 }
diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index f9fde9defedb..2db43bd60365 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -16,23 +16,9 @@ static const char * const __conn_state_names[] = {
 	[C_BROKEN_PIPE]      = "BrokenPipe",
 	[C_NETWORK_FAILURE]  = "NetworkFailure",
 	[C_PROTOCOL_ERROR]   = "ProtocolError",
-	[C_WF_CONNECTION]    = "WFConnection",
-	[C_WF_REPORT_PARAMS] = "WFReportParams",
 	[C_TEAR_DOWN]        = "TearDown",
-	[C_CONNECTED]        = "Connected",
-	[C_STARTING_SYNC_S]  = "StartingSyncS",
-	[C_STARTING_SYNC_T]  = "StartingSyncT",
-	[C_WF_BITMAP_S]      = "WFBitMapS",
-	[C_WF_BITMAP_T]      = "WFBitMapT",
-	[C_WF_SYNC_UUID]     = "WFSyncUUID",
-	[C_SYNC_SOURCE]      = "SyncSource",
-	[C_SYNC_TARGET]      = "SyncTarget",
-	[C_PAUSED_SYNC_S]    = "PausedSyncS",
-	[C_PAUSED_SYNC_T]    = "PausedSyncT",
-	[C_VERIFY_S]         = "VerifyS",
-	[C_VERIFY_T]         = "VerifyT",
-	[C_AHEAD]            = "Ahead",
-	[C_BEHIND]           = "Behind",
+	[C_CONNECTING]       = "Connecting",
+	[C_CONNECTED]	     = "Connected",
 };
 
 struct state_names drbd_conn_state_names = {
@@ -40,6 +26,29 @@ struct state_names drbd_conn_state_names = {
 	.size = ARRAY_SIZE(__conn_state_names),
 };
 
+static const char * const __repl_state_names[] = {
+	[L_OFF]              = "Off",
+	[L_ESTABLISHED]      = "Established",
+	[L_STARTING_SYNC_S]  = "StartingSyncS",
+	[L_STARTING_SYNC_T]  = "StartingSyncT",
+	[L_WF_BITMAP_S]      = "WFBitMapS",
+	[L_WF_BITMAP_T]      = "WFBitMapT",
+	[L_WF_SYNC_UUID]     = "WFSyncUUID",
+	[L_SYNC_SOURCE]      = "SyncSource",
+	[L_SYNC_TARGET]      = "SyncTarget",
+	[L_VERIFY_S]         = "VerifyS",
+	[L_VERIFY_T]         = "VerifyT",
+	[L_PAUSED_SYNC_S]    = "PausedSyncS",
+	[L_PAUSED_SYNC_T]    = "PausedSyncT",
+	[L_AHEAD]            = "Ahead",
+	[L_BEHIND]           = "Behind",
+};
+
+struct state_names drbd_repl_state_names = {
+	.names = __repl_state_names,
+	.size = ARRAY_SIZE(__repl_state_names),
+};
+
 static const char * const __role_state_names[] = {
 	[R_UNKNOWN]   = "Unknown",
 	[R_PRIMARY]   = "Primary",
@@ -54,6 +63,7 @@ struct state_names drbd_role_state_names = {
 static const char * const __disk_state_names[] = {
 	[D_DISKLESS]     = "Diskless",
 	[D_ATTACHING]    = "Attaching",
+	[D_DETACHING]    = "Detaching",
 	[D_FAILED]       = "Failed",
 	[D_NEGOTIATING]  = "Negotiating",
 	[D_INCONSISTENT] = "Inconsistent",
@@ -82,13 +92,20 @@ static const char * const __error_messages[] = {
 	[-SS_DEVICE_IN_USE] = "Device is held open by someone",
 	[-SS_NO_NET_CONFIG] = "Have no net/connection configuration",
 	[-SS_NO_VERIFY_ALG] = "Need a verify algorithm to start online verify",
-	[-SS_NEED_CONNECTION] = "Need a connection to start verify or resync",
+	[-SS_NEED_CONNECTION] = "State change requires a connection",
 	[-SS_NOT_SUPPORTED] = "Peer does not support protocol",
 	[-SS_LOWER_THAN_OUTDATED] = "Disk state is lower than outdated",
 	[-SS_IN_TRANSIENT_STATE] = "In transient state, retry after next state change",
 	[-SS_CONCURRENT_ST_CHG] = "Concurrent state changes detected and aborted",
-	[-SS_OUTDATE_WO_CONN] = "Need a connection for a graceful disconnect/outdate peer",
 	[-SS_O_VOL_PEER_PRI] = "Other vol primary on peer not allowed by config",
+	[-SS_PRIMARY_READER] = "Peer may not become primary while device is opened read-only",
+	[-SS_INTERRUPTED] = "Interrupted state change",
+	[-SS_TIMEOUT] = "Timeout in operation",
+	[-SS_WEAKLY_CONNECTED] = "Primary nodes must be strongly connected among each other",
+	[-SS_NO_QUORUM] = "No quorum",
+	[-SS_ATTACH_NO_BITMAP] = "Intentional diskless peer may not attach a disk",
+	[-SS_HANDSHAKE_DISCONNECT] = "Disconnect chosen in handshake",
+	[-SS_HANDSHAKE_RETRY] = "Retry chosen in handshake",
 };
 
 struct state_names drbd_error_messages = {
@@ -140,12 +157,45 @@ static const char * const __packet_names[] = {
 	[P_OUT_OF_SYNC]		= "P_OUT_OF_SYNC",
 	[P_RETRY_WRITE]		= "P_RETRY_WRITE",
 	[P_RS_CANCEL]		= "P_RS_CANCEL",
+	[P_RS_CANCEL_AHEAD]	= "P_RS_CANCEL_AHEAD",
 	[P_CONN_ST_CHG_REQ]	= "P_CONN_ST_CHG_REQ",
 	[P_CONN_ST_CHG_REPLY]	= "P_CONN_ST_CHG_REPLY",
 	[P_PROTOCOL_UPDATE]	= "P_PROTOCOL_UPDATE",
+	[P_TWOPC_PREPARE]	= "P_TWOPC_PREPARE",
+	[P_TWOPC_ABORT]		= "P_TWOPC_ABORT",
+	[P_DAGTAG]		= "P_DAGTAG",
 	[P_RS_THIN_REQ]         = "P_RS_THIN_REQ",
 	[P_RS_DEALLOCATED]      = "P_RS_DEALLOCATED",
+	[P_TWOPC_PREP_RSZ]      = "P_TWOPC_PREP_RSZ",
 	[P_ZEROES]              = "P_ZEROES",
+	[P_PEER_ACK]		= "P_PEER_ACK",
+	[P_PEERS_IN_SYNC]       = "P_PEERS_IN_SYNC",
+	[P_UUIDS110]            = "P_UUIDS110",
+	[P_PEER_DAGTAG]         = "P_PEER_DAGTAG",
+	[P_CURRENT_UUID]        = "P_CURRENT_UUID",
+	[P_TWOPC_COMMIT]	= "P_TWOPC_COMMIT",
+	[P_TWOPC_YES]		= "P_TWOPC_YES",
+	[P_TWOPC_NO]		= "P_TWOPC_NO",
+	[P_TWOPC_RETRY]		= "P_TWOPC_RETRY",
+	[P_CONFIRM_STABLE]      = "P_CONFIRM_STABLE",
+	[P_DISCONNECT]		= "P_DISCONNECT",
+	[P_RS_DAGTAG_REQ]	= "P_RS_DAGTAG_REQ",
+	[P_RS_CSUM_DAGTAG_REQ]	= "P_RS_CSUM_DAGTAG_REQ",
+	[P_RS_THIN_DAGTAG_REQ]	= "P_RS_THIN_DAGTAG_REQ",
+	[P_OV_DAGTAG_REQ]	= "P_OV_DAGTAG_REQ",
+	[P_OV_DAGTAG_REPLY]	= "P_OV_DAGTAG_REPLY",
+	[P_WRITE_ACK_IN_SYNC]   = "P_WRITE_ACK_IN_SYNC",
+	[P_RS_NEG_ACK]          = "P_RS_NEG_ACK",
+	[P_OV_RESULT_ID]        = "P_OV_RESULT_ID",
+	[P_RS_DEALLOCATED_ID]   = "P_RS_DEALLOCATED_ID",
+	[P_FLUSH_REQUESTS]      = "P_FLUSH_REQUESTS",
+	[P_FLUSH_FORWARD]       = "P_FLUSH_FORWARD",
+	[P_FLUSH_REQUESTS_ACK]  = "P_FLUSH_REQUESTS_ACK",
+	[P_ENABLE_REPLICATION_NEXT] = "P_ENABLE_REPLICATION_NEXT",
+	[P_ENABLE_REPLICATION]  = "P_ENABLE_REPLICATION",
+	[P_RS_DAGTAG_WAIT_REQ]  = "P_RS_DAGTAG_WAIT_REQ",
+	[P_RS_DAGTAG_REACHED]   = "P_RS_DAGTAG_REACHED",
+	[P_RS_DAGTAG_UNREACHABLE] = "P_RS_DAGTAG_UNREACHABLE",
 	/* enum drbd_packet, but not commands - obsoleted flags:
 	 *	P_MAY_IGNORE
 	 *	P_MAX_OPT_CMD
@@ -157,32 +207,39 @@ struct state_names drbd_packet_names = {
 	.size = ARRAY_SIZE(__packet_names),
 };
 
-const char *drbd_conn_str(enum drbd_conns s)
+const char *drbd_repl_str(enum drbd_repl_state s)
+{
+	return (s < 0 || s >= drbd_repl_state_names.size ||
+		!drbd_repl_state_names.names[s]) ?
+		       "?" : drbd_repl_state_names.names[s];
+}
+
+const char *drbd_conn_str(enum drbd_conn_state s)
 {
 	return (s < 0 || s >= drbd_conn_state_names.size ||
 		!drbd_conn_state_names.names[s]) ?
-	       "?" : drbd_conn_state_names.names[s];
+		       "?" : drbd_conn_state_names.names[s];
 }
 
 const char *drbd_role_str(enum drbd_role s)
 {
 	return (s < 0 || s >= drbd_role_state_names.size ||
 		!drbd_role_state_names.names[s]) ?
-	       "?" : drbd_role_state_names.names[s];
+		       "?" : drbd_role_state_names.names[s];
 }
 
 const char *drbd_disk_str(enum drbd_disk_state s)
 {
 	return (s < 0 || s >= drbd_disk_state_names.size ||
 		!drbd_disk_state_names.names[s]) ?
-	       "?" : drbd_disk_state_names.names[s];
+		       "?" : drbd_disk_state_names.names[s];
 }
 
 const char *drbd_set_st_err_str(enum drbd_state_rv err)
 {
 	return (-err < 0 || -err >= drbd_error_messages.size ||
 		!drbd_error_messages.names[-err]) ?
-	       "?" : drbd_error_messages.names[-err];
+		       "?" : drbd_error_messages.names[-err];
 }
 
 const char *drbd_packet_name(enum drbd_packet cmd)
-- 
2.55.0

