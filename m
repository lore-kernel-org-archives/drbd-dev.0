Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864353979F
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172411; cv=none; b=XKCsYleV2Nr1joAByRoN9NgI4fCnDK4dTHq6rvmXnXF8OIzdsPoRF/i7MsUv1gGCf/A5sAqciW5/H27DvbWtfTvgUBtWpykFBVj09GVpxgh044yhuw9Crm0Y+HxVXxVl5bU60JGjvOlt4rgcgNpKtUTcFWzvUJui2G37HWHGIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172411; c=relaxed/simple;
	bh=oQLeGHcFOEBKvK/KV/6VDCr5DCiylKfNZ+hZkYzkONE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRrW1JXmXnQ7mHH3Yks34oeJ3aewixhZA41KHW+4+DODIaNQZyS0WjXOEchU3RLBb8WXc80/TlaPrr0lUhN5ajUjWaZxKiFiYnPeQ9a8qOtMf5XH9YSgoi9QvxLqZGjDGr0eZeJSqDBpeQP8OKDOTL2uUwKV1PMomCZtoo421zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=L+AqwMEG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="L+AqwMEG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso12552435e9.2
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172405; x=1790777205; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OT8DknvFkt3c/QwXXWqPTd2AqnUqoQwgm3MlbzbyL9g=;
        b=L+AqwMEG3kGRvLrkbCceLvdDvU+/BYFpx8y6jbGPDGhLcqilSEd4Yc9sl8+27tswpD
         ZKvaTZqkJlwWnebjyfRktXzsi115svujaJ2sMfHry5BX3hImN4la3UBDZSbeOcpvcHAu
         xGnR0/G0bqgMBX5+yE7xpFq43erMrTuwFTt4YS7VzaxvSBoRdMLWtNt/Je6OlP+mIGax
         X0CreWrpGcMaZ4kAFjLmOeiIm625YPRhuLxl8J9eKUb/9R6v8xoQNqIMDz1I8aLBDDDn
         2k01c6hzB3cZyrirzrxjShStbYL1PoBHRZFKAKwnjDc3yBe5kmkuR1KQM6KsXYXKq1bG
         mwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172405; x=1790777205;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OT8DknvFkt3c/QwXXWqPTd2AqnUqoQwgm3MlbzbyL9g=;
        b=mABDTboKKf7HBcgB46khEWE8kRve1TU7XoRep2FRd5cXhlBzxs1fYzRoozU3wqSW64
         hmVm6yUzhfmGkggGTN7A+EzKmm12fF91rao1+/dYxtc7W0AkbsuqbA/qyJ261dKs8vNp
         bIOgbjPIRYv7pTynF3ocMeflqdYMiC1Ln72rDU2V3dxS8B7/gq9r4PyTwQuwWQzucdrX
         pzuw44hsKpgYQxRU+AVG+ggpRn3bleWOwL0biOga4YSBth3kT8Z2z3pEc5LXEOj1rmyh
         k6Te6lXYAvaqB0DR18VMLtA+3u/T1K4QbxxSBdHWCD2uD6cGBbh/fecWTHupy1qfg5NI
         Xh6A==
X-Forwarded-Encrypted: i=1; AKwUvByr2t5a+HC/jKvroZe25HDexh4d1UQJ69DeILHXPNu+u9cmsSS0lMcW9YBLOTOpNAXGpR+vlnBFSg==@lists.linux.dev
X-Gm-Message-State: AFuF++kZg/9nfv0dGCvbLe1cZBjdZH6lbDxVMPHOaIhwGOED6JE5rseD
	4sbVW+Ku9F2DhPVyDft80Snn3sUZELDD5oZqIxtpq5qBeLvjoEarYws+JSptXIamRIY=
X-Gm-Gg: AYBFou2cDRvtzwSgSGUUSPSd762vVu3CjfmJdm1UaM7izfuT0H+vqI7n9/V1Tm2KIx3
	naAEM/E0WLOR45o0zCN3odlv4bEjicWoSW96xmgWCGMun9k3LtOr+OXNek6wrNPOaeHV62oJIeu
	WJ9GpOBqdbIiHwpgAQcnUCGoDE6vFrQe4sumvxrpzD8byB+mcP0fRkGZFb/e5Lwk/a8EC4Tj4X7
	VPqRSbY9dQRVJlo6E1olUpWh3DjS6S/6T2ZLDA/T5I7L/v/QOwj0WNYfpkA+79vckuoUoAZu7ve
	x2AgdisUdi5nr23K0nOnrZFSbtFubcBAIa0JC/sn2BAz0yA5RX3w2DyI1GAmeII77iKb0uBTEm2
	oRUaC1u+Ih1fl0QSw8kJsRbRbGPbtqLvNJqBWzVa1bAnOBKs5OGZu9FjxAP57PgCeAeKukPa9bz
	VTdAOs5GhzRI9ayenOlQCrHrAEzMs3CWN7rX6sDkrMM13rBe8U4afa8phw95Pl1BoO3XkJQNii5
	WtktGPjpC3WPNYcQ5e2I3hxl0uTyj5099S3Q+koCXA=
X-Received: by 2002:a05:600c:354e:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-49fdf137081mr40436105e9.19.1790172404980;
        Wed, 23 Sep 2026 07:06:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:44 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 5/7] drbd: replace the drbd_interval bitfields with a type and flags
Date: Wed, 23 Sep 2026 16:06:06 +0200
Message-ID: <20260923140608.1116713-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct drbd_interval carries three single-bit fields: whether the
request is local, whether someone waits for it, and whether it has
completed. They only say "local or not", so every user that needs to
know what kind of request an interval belongs to has to look at the
containing object.

Record the kind of request in the interval itself as an
enum drbd_interval_type, set by whoever allocates the request, and turn
the remaining bits into an atomic flags word so they can be tested and
set with the usual bit operations. drbd_interval_is_local() replaces
the open-coded tests of the "local" bit.

This is the representation the DRBD 9 conflict handling is built on;
the types are the ones it uses, so the rework only has to add flags.

No functional change.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.h | 51 +++++++++++++++++++++++-------
 drivers/block/drbd/drbd_main.c     |  2 +-
 drivers/block/drbd/drbd_receiver.c | 21 ++++++++----
 drivers/block/drbd/drbd_req.c      | 17 +++++-----
 drivers/block/drbd/drbd_sender.c   |  5 +++
 5 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index 9d290ac120cd..3749377ec172 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -9,20 +9,47 @@
 #include <linux/types.h>
 #include <linux/rbtree.h>
 
+/*
+ * Interval types stored directly in drbd_interval so that we can handle
+ * conflicts without having to inspect the containing object. The value 0 is
+ * reserved for uninitialized intervals.
+ */
+enum drbd_interval_type {
+	INTERVAL_LOCAL_WRITE = 1,
+	INTERVAL_PEER_WRITE,
+	INTERVAL_LOCAL_READ,
+	INTERVAL_PEER_READ,
+	INTERVAL_RESYNC_WRITE, /* C_SYNC_TARGET */
+	INTERVAL_RESYNC_READ, /* C_SYNC_SOURCE */
+	INTERVAL_OV_READ_SOURCE, /* C_VERIFY_S */
+	INTERVAL_OV_READ_TARGET, /* C_VERIFY_T */
+};
+
+enum drbd_interval_flags {
+	/* Someone is waiting on device->misc_wait for this to make progress. */
+	INTERVAL_WAITING,
+
+	/* This has been completed already; ignore for conflict detection. */
+	INTERVAL_COMPLETED,
+};
+
 struct drbd_interval {
 	struct rb_node rb;
 	sector_t sector;		/* start sector of the interval */
 	sector_t end;			/* highest interval end in subtree */
 	unsigned int size;		/* size in bytes */
-	unsigned int local:1		/* local or remote request? */;
-	unsigned int waiting:1;		/* someone is waiting for completion */
-	unsigned int completed:1;	/* this has been completed already;
-					 * ignore for conflict detection */
+	enum drbd_interval_type type;	/* what type of interval this is */
+	unsigned long flags;
 
 	/* to resume a partially successful drbd_al_begin_io_nonblock(); */
 	unsigned int partially_in_al_next_enr;
 };
 
+static inline bool drbd_interval_is_local(struct drbd_interval *i)
+{
+	return i->type == INTERVAL_LOCAL_READ || i->type == INTERVAL_LOCAL_WRITE;
+}
+
 static inline void drbd_clear_interval(struct drbd_interval *i)
 {
 	RB_CLEAR_NODE(&i->rb);
@@ -33,14 +60,14 @@ static inline bool drbd_interval_empty(struct drbd_interval *i)
 	return RB_EMPTY_NODE(&i->rb);
 }
 
-extern bool drbd_insert_interval(struct rb_root *, struct drbd_interval *);
-extern bool drbd_contains_interval(struct rb_root *, sector_t,
-				   struct drbd_interval *);
-extern void drbd_remove_interval(struct rb_root *, struct drbd_interval *);
-extern struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_t,
-					unsigned int);
-extern struct drbd_interval *drbd_next_overlap(struct drbd_interval *, sector_t,
-					unsigned int);
+bool drbd_insert_interval(struct rb_root *root, struct drbd_interval *this);
+bool drbd_contains_interval(struct rb_root *root, sector_t sector,
+			    struct drbd_interval *interval);
+void drbd_remove_interval(struct rb_root *root, struct drbd_interval *this);
+struct drbd_interval *drbd_find_overlap(struct rb_root *root, sector_t sector,
+					unsigned int size);
+struct drbd_interval *drbd_next_overlap(struct drbd_interval *i,
+					sector_t sector, unsigned int size);
 
 #define drbd_for_each_overlap(i, root, sector, size)		\
 	for (i = drbd_find_overlap(root, sector, size);		\
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 590ac5cb84f5..09e42706c83e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3656,7 +3656,7 @@ int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i)
 	rcu_read_unlock();
 
 	/* Indicate to wake up device->misc_wait on progress.  */
-	i->waiting = true;
+	set_bit(INTERVAL_WAITING, &i->flags);
 	prepare_to_wait(&device->misc_wait, &wait, TASK_INTERRUPTIBLE);
 	spin_unlock_irq(&device->resource->req_lock);
 	timeout = schedule_timeout(timeout);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2c4507add143..3ebe18535fcf 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1540,7 +1540,7 @@ static void drbd_remove_epoch_entry_interval(struct drbd_device *device,
 	drbd_clear_interval(i);
 
 	/* Wake up any processes waiting for this peer request to complete.  */
-	if (i->waiting)
+	if (test_bit(INTERVAL_WAITING, &i->flags))
 		wake_up(&device->misc_wait);
 }
 
@@ -1878,6 +1878,8 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	if (!peer_req)
 		goto fail;
 
+	peer_req->i.type = INTERVAL_RESYNC_WRITE;
+
 	dec_rs_pending(peer_device);
 
 	inc_unacked(device);
@@ -1916,7 +1918,7 @@ find_request(struct drbd_device *device, struct rb_root *root, u64 id,
 
 	/* Request object according to our peer */
 	req = (struct drbd_request *)(unsigned long)id;
-	if (drbd_contains_interval(root, sector, &req->i) && req->i.local)
+	if (drbd_contains_interval(root, sector, &req->i) && drbd_interval_is_local(&req->i))
 		return req;
 	if (!missing_ok) {
 		drbd_err(device, "%s: failed to find request 0x%lx, sector %llus\n", func,
@@ -1999,7 +2001,7 @@ static void restart_conflicting_writes(struct drbd_device *device,
 	struct drbd_request *req;
 
 	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
-		if (!i->local)
+		if (!drbd_interval_is_local(i))
 			continue;
 		req = container_of(i, struct drbd_request, i);
 		if (req->rq_state & RQ_LOCAL_PENDING ||
@@ -2239,7 +2241,7 @@ static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
 		struct drbd_request *req;
 		struct bio_and_error m;
 
-		if (!i->local)
+		if (!drbd_interval_is_local(i))
 			continue;
 		req = container_of(i, struct drbd_request, i);
 		if (!(req->rq_state & RQ_POSTPONED))
@@ -2275,10 +2277,10 @@ static int handle_write_conflicts(struct drbd_device *device,
 	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
 		if (i == &peer_req->i)
 			continue;
-		if (i->completed)
+		if (test_bit(INTERVAL_COMPLETED, &i->flags))
 			continue;
 
-		if (!i->local) {
+		if (!drbd_interval_is_local(i)) {
 			/*
 			 * Our peer has sent a conflicting remote request; this
 			 * should not happen in a two-node setup.  Wait for the
@@ -2409,6 +2411,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 		return -EIO;
 	}
 
+	peer_req->i.type = INTERVAL_PEER_WRITE;
 	peer_req->w.cb = e_end_block;
 	peer_req->submit_jif = jiffies;
 	peer_req->flags |= EE_APPLICATION;
@@ -2687,6 +2690,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 
 	switch (pi->cmd) {
 	case P_DATA_REQUEST:
+		peer_req->i.type = INTERVAL_PEER_READ;
 		peer_req->w.cb = w_e_end_data_req;
 		/* application IO, don't drbd_rs_begin_io */
 		peer_req->flags |= EE_APPLICATION;
@@ -2700,6 +2704,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		peer_req->flags |= EE_RS_THIN_REQ;
 		fallthrough;
 	case P_RS_DATA_REQUEST:
+		peer_req->i.type = INTERVAL_RESYNC_READ;
 		peer_req->w.cb = w_e_end_rsdata_req;
 		/* used in the sector offset progress display */
 		device->bm_resync_fo = BM_SECT_TO_BIT(sector);
@@ -2722,6 +2727,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 
 		if (pi->cmd == P_CSUM_RS_REQUEST) {
 			D_ASSERT(device, peer_device->connection->agreed_pro_version >= 89);
+			peer_req->i.type = INTERVAL_RESYNC_READ;
 			peer_req->w.cb = w_e_end_csum_rs_req;
 			/* used in the sector offset progress display */
 			device->bm_resync_fo = BM_SECT_TO_BIT(sector);
@@ -2730,6 +2736,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		} else if (pi->cmd == P_OV_REPLY) {
 			/* track progress, we may need to throttle */
 			atomic_add(size >> 9, &device->rs_sect_in);
+			peer_req->i.type = INTERVAL_OV_READ_SOURCE;
 			peer_req->w.cb = w_e_end_ov_reply;
 			dec_rs_pending(peer_device);
 			/* drbd_rs_begin_io done when we sent this request,
@@ -2754,6 +2761,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			drbd_info(device, "Online Verify start sector: %llu\n",
 					(unsigned long long)sector);
 		}
+		peer_req->i.type = INTERVAL_OV_READ_TARGET;
 		peer_req->w.cb = w_e_end_ov_req;
 		break;
 
@@ -4786,6 +4794,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 			return -ENOMEM;
 		}
 
+		peer_req->i.type = INTERVAL_RESYNC_WRITE;
 		peer_req->w.cb = e_end_resync_block;
 		peer_req->opf = REQ_OP_DISCARD;
 		peer_req->submit_jif = jiffies;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 1648d0dabcbd..f16b925fecc1 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -35,8 +35,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	drbd_clear_interval(&req->i);
 	req->i.sector     = bio_src->bi_iter.bi_sector;
 	req->i.size      = bio_src->bi_iter.bi_size;
-	req->i.local = true;
-	req->i.waiting = false;
+	req->i.type = bio_data_dir(bio_src) == WRITE ? INTERVAL_LOCAL_WRITE : INTERVAL_LOCAL_READ;
 
 	INIT_LIST_HEAD(&req->tl_requests);
 	INIT_LIST_HEAD(&req->w.list);
@@ -59,7 +58,7 @@ static void drbd_remove_request_interval(struct rb_root *root,
 	drbd_remove_interval(root, i);
 
 	/* Wake up any processes waiting for this request to complete.  */
-	if (i->waiting)
+	if (test_bit(INTERVAL_WAITING, &i->flags))
 		wake_up(&device->misc_wait);
 }
 
@@ -270,10 +269,10 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		 * write-acks in protocol != C during resync.
 		 * But we mark it as "complete", so it won't be counted as
 		 * conflict in a multi-primary setup. */
-		req->i.completed = true;
+		set_bit(INTERVAL_COMPLETED, &req->i.flags);
 	}
 
-	if (req->i.waiting)
+	if (test_bit(INTERVAL_WAITING, &req->i.flags))
 		wake_up(&device->misc_wait);
 
 	/* Either we are about to complete to upper layers,
@@ -505,7 +504,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 	/* potentially complete and destroy */
 
 	/* If we made progress, retry conflicting peer requests, if any. */
-	if (req->i.waiting)
+	if (test_bit(INTERVAL_WAITING, &req->i.flags))
 		wake_up(&device->misc_wait);
 
 	drbd_req_put_completion_ref(req, m, c_put);
@@ -786,7 +785,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		 */
 		D_ASSERT(device, req->rq_state & RQ_NET_PENDING);
 		req->rq_state |= RQ_POSTPONED;
-		if (req->i.waiting)
+		if (test_bit(INTERVAL_WAITING, &req->i.flags))
 			wake_up(&device->misc_wait);
 		/* Do not clear RQ_NET_PENDING. This request will make further
 		 * progress via restart_conflicting_writes() or
@@ -957,7 +956,7 @@ static void complete_conflicting_writes(struct drbd_request *req)
 	for (;;) {
 		drbd_for_each_overlap(i, &device->write_requests, sector, size) {
 			/* Ignore, if already completed to upper layers. */
-			if (i->completed)
+			if (test_bit(INTERVAL_COMPLETED, &i->flags))
 				continue;
 			/* Handle the first found overlap.  After the schedule
 			 * we have to restart the tree walk. */
@@ -968,7 +967,7 @@ static void complete_conflicting_writes(struct drbd_request *req)
 
 		/* Indicate to wake up device->misc_wait on progress.  */
 		prepare_to_wait(&device->misc_wait, &wait, TASK_UNINTERRUPTIBLE);
-		i->waiting = true;
+		set_bit(INTERVAL_WAITING, &i->flags);
 		spin_unlock_irq(&device->resource->req_lock);
 		schedule();
 		spin_lock_irq(&device->resource->req_lock);
diff --git a/drivers/block/drbd/drbd_sender.c b/drivers/block/drbd/drbd_sender.c
index df0b6c99a59f..69b3676961d2 100644
--- a/drivers/block/drbd/drbd_sender.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -394,6 +394,11 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 	if (!peer_req)
 		goto defer;
 
+	/*
+	 * This will be a resync write once we receive the data back from the
+	 * peer, assuming the checksums differ.
+	 */
+	peer_req->i.type = INTERVAL_RESYNC_WRITE;
 	peer_req->w.cb = w_e_send_csum;
 	peer_req->opf = REQ_OP_READ;
 	spin_lock_irq(&device->resource->req_lock);
-- 
2.55.0

