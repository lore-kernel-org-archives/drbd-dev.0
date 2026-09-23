Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF653161C
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172417; cv=none; b=WvdBFDSI26kkquMT9zWgZbfZ3iLKTlb8HPwi+NNNJ+C2t6wOA6EbmZ0ZDog1H+9GE5hd5WukF8DFJVKIRBkHZ2VqTX/kEdsC3f2+XL1I2PoFQmrW4kqd7RY0+aGZiJjRp3w40knpwVL/eGiCYkgLcdVu5OYgDOto6nhkANqD4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172417; c=relaxed/simple;
	bh=ZuKtznTq4e3n+MbCr28rFujBIV666kK8FwgOMTSOLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l27SpyrIu9yL8DrHzjW5cZqojJzuTbWg4nr02wMmxs2kWmCSgECuXcEdrmlKF22RwOdDmAvttq7RgNQDQYKRFmBUQLEe6IkKE6fLSBx8dbXqZXiOzvFVIunGEWppi4ieJSzhYjXczVeSNaUxghRJedNsZsGamoahPDLbofx98O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=wawHLmWE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="wawHLmWE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so6363035e9.1
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172410; x=1790777210; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uffotF5NTK2DASzVldYKkQNBUqb76T/GJhFbh5NUv0c=;
        b=wawHLmWEMW//k9RiFQdn7PzepltNQUGxTIAMy5pxicF9OYqFkz+j6T5I9yQjTBCFiq
         mFMuXpWOKstUpV4LyD9+/XFMg4u3Or91XcXJU81M1FbG0AX8kjlWZCe7assemlctn4XH
         sblI8pfucNhDZMP7r+ZUbjlkHV1hpLUERoCSIhUcbTP6To3iO4HjuuPaUWfp1Vry5ZqW
         n9/jPsLkxUW7FI8CojTgQssS1jP7YcG2dnRG2+PPs1Qv8NQGQ5kfnhpKdRP8RS0e7Emo
         81chZvr05ZoWHYDLnKlpwlOHqIfxBGSOJgw0OR7gAARjTSclG10vUoV6QzsMlRyE7b+8
         EvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172410; x=1790777210;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uffotF5NTK2DASzVldYKkQNBUqb76T/GJhFbh5NUv0c=;
        b=OXyRcZIWA8P9BLTa0y7dgAfytziTTzzdBcIhTWM3m3jcLRPIODk0mpjuOq3hltbOm3
         iILQhIK7V14odQitEMBb9BI6BQboZucaeq1oPwDKKaOkf23Ha1FAzyi7MfVhJxDBPxa6
         sbo6q7EwAqr/TosIZIc0YkJfD3hBX1e9OZZ9waRBVHKbqkmqmcxi7I2RK5/ZOqAFeQeq
         VJCwLHPI6yTQ/vmowsYaC36XF3Tx74bn36D2qK5FSi/EqC+Gv8oMk99QjGGt9QAA+MFy
         w2WG4D+xhCsALTUzg28jdjFySFm4y7Keb26q+WBrV0q6Bd71+W5nR79fYRTqK8m7vcpH
         sH5g==
X-Forwarded-Encrypted: i=1; AKwUvByGI2+hcIayKQ5ffxyWJ4AuZ1j6L6KmppzGaA5e6DyqbtOO/R5MKQCbVOYf+sdZtE7jOYtyAodCNg==@lists.linux.dev
X-Gm-Message-State: AFuF++nNgXzZsd2uAJlsRdUNwIoAcwaX6e0XNRr3A1W9vTO06vVfb6xl
	EgXY0mliG4sr+YozU7KSknx1niFcrLbBNsYhFWNQiQCjmsOmNc83u5mIOLzAutm833I=
X-Gm-Gg: AYBFou0yKmuIrUsdgNulm7aaSPk9v6vvqG3rsqXmuP4yPKvnbbrA3eTvvCMtMkINGWb
	nSJMgZpDpGnJF7ndAoDYzdByLopqU2skgA9hk/2y1UEBf+Y/u8IpSCVDqhMWBQ0DjoTOX2BtMq4
	eAqRLX2zgT6GGXZDW0SREg/2KrLKTfhAhGS+SnhwrfvNI/X4/ydOnnJbOYojYSybdre1xcvKOfu
	ocSK0rCL2QKZnNu8aORfOXXemi0LQ4UTmhBs/JyzSz1tRzHSg+bK7afgYKqyE41LJZWcPuHnxQg
	tDS303ZIBVc7PSlnNKi/cLJdtIdq6Zl12Y+yZbNc+2PgEbKD23hBqrIif/r+5sOsfJYULTYtOYq
	yHyXoNGNtlKLjzEga7QdjczknAfW3vHVaSh8tRaYO8cYU7f6tjIMs+K6/ijM1bc1a7wwQTTVVj9
	QD+e/2cTSNvrMwf96EL8RpE9x2zTWRzn4VnNzct27/O7k3rhYnPHHPfKerUh9exdE5+b4wGv6qZ
	bYPoUynjW4grlf7trVT1PZ1bj5NMzc=
X-Received: by 2002:a05:600c:468c:b0:49f:dd6d:79a1 with SMTP id 5b1f17b1804b1-49fdf138a05mr42138115e9.26.1790172409446;
        Wed, 23 Sep 2026 07:06:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:48 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 7/7] drbd: rate limit log messages per object
Date: Wed, 23 Sep 2026 16:06:08 +0200
Message-ID: <20260923140608.1116713-8-christoph.boehmwalder@linbit.com>
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

drbd_ratelimit() throttles with one static ratelimit state per call
site. A device with a failing backing disk therefore keeps the log
noisy no matter what the other devices do, and a message a single
device produces in a burst suppresses the same message from every
other device on the node.

Give each resource, connection, peer device and device its own
ratelimit states, selected by a class (GENERIC, and for devices also
METADATA and BACKEND), and route every drbd_printk() through them: the
existing drbd_err() & co. take the NOLIMIT class and behave as before,
the new drbd_err_ratelimit() & co. throttle per object, and
drbd_device_ratelimit(device, class) & co. are available for the
sites that need the decision separately. Convert the drbd_ratelimit()
users accordingly, choosing BACKEND for backing device I/O errors and
METADATA for on-disk bitmap access errors.

While the printk macros are being restructured anyway, let them mark
messages from objects that have already been unregistered: a device,
connection or resource that is deleted but still referenced is now
flagged with UNREGISTERED/C_UNREGISTERED/R_UNREGISTERED, and its
messages carry an "/unregistered/" prefix.

This matches the logging infrastructure of DRBD 9.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c           |   3 +-
 drivers/block/drbd/drbd_bitmap.c           |   6 +-
 drivers/block/drbd/drbd_int.h              |  43 +++-
 drivers/block/drbd/drbd_main.c             |  14 +-
 drivers/block/drbd/drbd_nl.c               |   2 +
 drivers/block/drbd/drbd_polymorph_printk.h | 256 +++++++++++++--------
 drivers/block/drbd/drbd_receiver.c         |   9 +-
 drivers/block/drbd/drbd_req.c              |  10 +-
 drivers/block/drbd/drbd_sender.c           |  22 +-
 9 files changed, 243 insertions(+), 122 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 04b8d50e4e9e..43345b82daa2 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -1138,8 +1138,7 @@ void drbd_rs_complete_io(struct drbd_device *device, sector_t sector)
 	bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
 	if (!bm_ext) {
 		spin_unlock_irqrestore(&device->al_lock, flags);
-		if (drbd_ratelimit())
-			drbd_err(device, "drbd_rs_complete_io() called, but extent not found\n");
+		drbd_err_ratelimit(device, "%s() called, but extent not found\n", __func__);
 		return;
 	}
 
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 8416c7e8257c..6892a99eb6f0 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -109,7 +109,7 @@ struct drbd_bitmap {
 static void __bm_print_lock_info(struct drbd_device *device, const char *func)
 {
 	struct drbd_bitmap *b = device->bitmap;
-	if (!drbd_ratelimit())
+	if (!drbd_device_ratelimit(device, GENERIC))
 		return;
 	drbd_err(device, "FIXME %s[%d] in %s, bitmap locked for '%s' by %s[%d]\n",
 		 current->comm, task_pid_nr(current),
@@ -948,7 +948,7 @@ static void drbd_bm_endio(struct bio *bio)
 		bm_set_page_io_err(b->bm_pages[idx]);
 		/* Not identical to on disk version of it.
 		 * Is BM_PAGE_IO_ERROR enough? */
-		if (drbd_ratelimit())
+		if (drbd_device_ratelimit(device, BACKEND))
 			drbd_err(device, "IO ERROR %d on bitmap page idx %u\n",
 					bio->bi_status, idx);
 	} else {
@@ -1009,7 +1009,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		else
 			len = PAGE_SIZE;
 	} else {
-		if (drbd_ratelimit()) {
+		if (drbd_device_ratelimit(device, METADATA)) {
 			drbd_err(device, "Invalid offset during on-disk bitmap access: "
 				 "page idx %u, sector %llu\n", page_nr, on_disk_sector);
 		}
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 297deac20f7e..40be382b24d2 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -449,6 +449,7 @@ enum {
 	RS_START,		/* tell worker to start resync/OV */
 	RS_PROGRESS,		/* tell worker that resync made significant progress */
 	RS_DONE,		/* tell worker that resync is done */
+	UNREGISTERED,		/* minor removed, device may still be referenced */
 };
 
 struct drbd_bitmap; /* opaque for drbd_device */
@@ -573,10 +574,21 @@ enum {
 	DISCONNECT_SENT,
 
 	DEVICE_WORK_PENDING,	/* tell worker that some device has pending work */
+	C_UNREGISTERED,		/* removed from the resource, may still be referenced */
 };
 
 enum which_state { NOW, OLD = NOW, NEW };
 
+/* flag bits per resource */
+enum {
+	R_UNREGISTERED,		/* removed from the resources list, may still be referenced */
+};
+
+enum drbd_per_resource_ratelimit {
+	D_RL_R_NOLIMIT = -1,
+	D_RL_R_GENERIC,
+};
+
 struct drbd_resource {
 	char *name;
 #ifdef CONFIG_DEBUG_FS
@@ -587,6 +599,10 @@ struct drbd_resource {
 #endif
 	struct kref kref;
 	struct idr devices;		/* volume number to device mapping */
+
+	struct ratelimit_state ratelimit[1];
+
+	unsigned long flags;
 	struct list_head connections;
 	struct list_head resources;
 	struct res_opts res_opts;
@@ -612,6 +628,11 @@ struct drbd_thread_timing_details
 	unsigned int cb_nr;
 };
 
+enum drbd_per_connection_ratelimit {
+	D_RL_C_NOLIMIT = -1,
+	D_RL_C_GENERIC,
+};
+
 struct drbd_connection {
 	struct list_head connections;
 	struct drbd_resource *resource;
@@ -622,6 +643,9 @@ struct drbd_connection {
 #endif
 	struct kref kref;
 	struct idr peer_devices;	/* volume number to peer device mapping */
+
+	struct ratelimit_state ratelimit[1];
+
 	enum drbd_conns cstate;		/* Only C_STANDALONE to C_WF_REPORT_PARAMS */
 	struct mutex cstate_mutex;	/* Protects graceful disconnects */
 	unsigned int connect_cnt;	/* Inc each time a connection is established */
@@ -730,16 +754,32 @@ struct submit_worker {
 	struct list_head writes;
 };
 
+enum drbd_per_peer_device_ratelimit {
+	D_RL_PD_NOLIMIT = -1,
+	D_RL_PD_GENERIC,
+};
+
 struct drbd_peer_device {
 	struct list_head peer_devices;
 	struct drbd_device *device;
 	struct drbd_connection *connection;
 	struct work_struct send_acks_work;
+
+	struct ratelimit_state ratelimit[1];
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_peer_dev;
 #endif
 };
 
+enum drbd_per_device_ratelimit {
+	D_RL_D_NOLIMIT = -1,
+	D_RL_D_GENERIC,
+	D_RL_D_METADATA,
+	D_RL_D_BACKEND,
+	__D_RL_D_N
+};
+
 struct drbd_device {
 	struct drbd_resource *resource;
 	struct list_head peer_devices;
@@ -755,6 +795,7 @@ struct drbd_device {
 	struct dentry *debugfs_vol_data_gen_id;
 	struct dentry *debugfs_vol_ed_gen_id;
 #endif
+	struct ratelimit_state ratelimit[__D_RL_D_N];
 
 	unsigned int vnr;	/* volume number within the connection */
 	unsigned int minor;	/* device minor number */
@@ -1622,7 +1663,7 @@ static inline void __drbd_chk_io_error_(struct drbd_device *device,
 	switch (ep) {
 	case EP_PASS_ON: /* FIXME would this be better named "Ignore"? */
 		if (df == DRBD_READ_ERROR || df == DRBD_WRITE_ERROR) {
-			if (drbd_ratelimit())
+			if (drbd_device_ratelimit(device, BACKEND))
 				drbd_err(device, "Local IO failed in %s.\n", where);
 			if (device->state.disk > D_INCONSISTENT)
 				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index fc674acf8bd4..aa6ddb2bac15 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2288,6 +2288,7 @@ void drbd_free_resource(struct drbd_resource *resource)
 	struct drbd_connection *connection, *tmp;
 
 	for_each_connection_safe(connection, tmp, resource) {
+		set_bit(C_UNREGISTERED, &connection->flags);
 		list_del(&connection->connections);
 		drbd_debugfs_connection_cleanup(connection);
 		kref_put(&connection->kref, drbd_destroy_connection);
@@ -2515,6 +2516,7 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	if (!zalloc_cpumask_var(&resource->cpu_mask, GFP_KERNEL))
 		goto fail_free_name;
 	kref_init(&resource->kref);
+	ratelimit_state_init(&resource->ratelimit[D_RL_R_GENERIC], 5 * HZ, 10);
 	idr_init(&resource->devices);
 	INIT_LIST_HEAD(&resource->connections);
 	resource->write_ordering = WO_BDEV_FLUSH;
@@ -2583,6 +2585,7 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 	connection->ack_receiver.connection = connection;
 
 	kref_init(&connection->kref);
+	ratelimit_state_init(&connection->ratelimit[D_RL_C_GENERIC], 5 * HZ, /* no burst */ 1);
 
 	connection->resource = resource;
 
@@ -2667,6 +2670,10 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		return ERR_NOMEM;
 	kref_init(&device->kref);
 
+	ratelimit_state_init(&device->ratelimit[D_RL_D_GENERIC], 5 * HZ, /* no burst */ 1);
+	ratelimit_state_init(&device->ratelimit[D_RL_D_METADATA], 5 * HZ, 10);
+	ratelimit_state_init(&device->ratelimit[D_RL_D_BACKEND], 5 * HZ, 10);
+
 	kref_get(&resource->kref);
 	device->resource = resource;
 	device->minor = minor;
@@ -2726,6 +2733,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 			goto out_idr_remove_from_resource;
 		peer_device->connection = connection;
 		peer_device->device = device;
+		ratelimit_state_init(&peer_device->ratelimit[D_RL_PD_GENERIC],
+				     5 * HZ, /* no burst */ 1);
 
 		list_add(&peer_device->peer_devices, &device->peer_devices);
 		kref_get(&device->kref);
@@ -3677,9 +3686,8 @@ _drbd_insert_fault(struct drbd_device *device, unsigned int type)
 	if (ret) {
 		drbd_fault_count++;
 
-		if (drbd_ratelimit())
-			drbd_warn(device, "***Simulating %s failure\n",
-				_drbd_fault_str(type));
+		drbd_warn_ratelimit(device, "***Simulating %s failure\n",
+				    _drbd_fault_str(type));
 	}
 
 	return ret;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 51ba8e542928..aa7aae9003be 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4496,6 +4496,7 @@ static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 		notify_device_state(NULL, 0, device, NULL, NOTIFY_DESTROY);
 		mutex_unlock(&notification_mutex);
 
+		set_bit(UNREGISTERED, &device->flags);
 		drbd_delete_device(device);
 		return NO_ERROR;
 	} else
@@ -4540,6 +4541,7 @@ static int adm_del_resource(struct drbd_resource *resource)
 	mutex_unlock(&notification_mutex);
 
 	mutex_lock(&resources_mutex);
+	set_bit(R_UNREGISTERED, &resource->flags);
 	list_del_rcu(&resource->resources);
 	mutex_unlock(&resources_mutex);
 	/* Make sure all threads have actually stopped: state handling only
diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
index 8e0082d139ba..71dcdd1f45b9 100644
--- a/drivers/block/drbd/drbd_polymorph_printk.h
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -11,104 +11,179 @@
 #define DYNAMIC_DEBUG_BRANCH(D) false
 #endif
 
+#define __drbd_printk(level, fmt, args...)				\
+	printk(level fmt, ## args)
+#define __drbd_dyn_dbg(descriptor, fmt, args...)			\
+	__dynamic_pr_debug(descriptor, fmt, ## args)
+
+#define ___drbd_printk_device(prmacro, rlt, device, lvl_or_desc, fmt, args...)\
+({									\
+	const struct drbd_device *__d =					\
+		(const struct drbd_device *)(device);			\
+	const struct drbd_resource *__r = __d->resource;		\
+	const char *__unregistered = "";				\
+	if (test_bit(UNREGISTERED, &__d->flags))			\
+		__unregistered = "/unregistered/";			\
+	if (drbd_device_ratelimit(__d, rlt))				\
+		prmacro(lvl_or_desc, "drbd %s%s/%u drbd%u: " fmt,	\
+			__unregistered, __r->name, __d->vnr, __d->minor,\
+			## args);					\
+})
+
+#define ___drbd_printk_resource(prmacro, rlt, resource, lvl_or_desc, fmt, args...)\
+({									\
+	const struct drbd_resource *__r =				\
+		(const struct drbd_resource *)(resource);		\
+	const char *__unregistered = "";				\
+	if (test_bit(R_UNREGISTERED, &__r->flags))			\
+		__unregistered = "/unregistered/";			\
+	if (drbd_resource_ratelimit(__r, rlt))				\
+		prmacro(lvl_or_desc, "drbd %s%s: " fmt,			\
+			__unregistered, __r->name, ## args);		\
+})
 
-#define __drbd_printk_drbd_device_prep(device)			\
-	const struct drbd_device *__d = (device);		\
-	const struct drbd_resource *__r = __d->resource
-#define __drbd_printk_drbd_device_fmt(fmt)	"drbd %s/%u drbd%u: " fmt
-#define __drbd_printk_drbd_device_args()	__r->name, __d->vnr, __d->minor
-#define __drbd_printk_drbd_device_unprep()
-
-#define __drbd_printk_drbd_peer_device_prep(peer_device)	\
-	const struct drbd_device *__d;				\
-	const struct drbd_resource *__r;			\
-	__d = (peer_device)->device;				\
-	__r = __d->resource
-#define __drbd_printk_drbd_peer_device_fmt(fmt) \
-	"drbd %s/%u drbd%u: " fmt
-#define __drbd_printk_drbd_peer_device_args() \
-	__r->name, __d->vnr, __d->minor
-#define __drbd_printk_drbd_peer_device_unprep()
-
-#define __drbd_printk_drbd_resource_prep(resource) \
-	const struct drbd_resource *__r = resource
-#define __drbd_printk_drbd_resource_fmt(fmt) "drbd %s: " fmt
-#define __drbd_printk_drbd_resource_args()	__r->name
-#define __drbd_printk_drbd_resource_unprep(resource)
-
-#define __drbd_printk_drbd_connection_prep(connection)		\
-	const struct drbd_connection *__c = (connection);	\
-	const struct drbd_resource *__r = __c->resource
-#define __drbd_printk_drbd_connection_fmt(fmt)			\
-	"drbd %s: " fmt
-#define __drbd_printk_drbd_connection_args()			\
-	__r->name
-#define __drbd_printk_drbd_connection_unprep()
+/*
+ * As long as the connection is still "registered", the resource
+ * can not yet be "unregistered", no need to test R_UNREGISTERED
+ */
+#define ___drbd_printk_peer_device(prmacro, rlt, peer_device, lvl_or_desc, fmt, args...)\
+({									\
+	const struct drbd_peer_device *__pd =				\
+		(const struct drbd_peer_device *)(peer_device);		\
+	const struct drbd_device *__d = __pd->device;			\
+	const struct drbd_connection *__c = __pd->connection;		\
+	const struct drbd_resource *__r = __d->resource;		\
+	const char *__unregistered = "";				\
+	if (test_bit(C_UNREGISTERED, &__c->flags))			\
+		__unregistered = "/unregistered/";			\
+	if (drbd_peer_device_ratelimit(__pd, rlt))			\
+		prmacro(lvl_or_desc, "drbd %s%s/%u drbd%u: " fmt,	\
+			__unregistered, __r->name, __d->vnr, __d->minor,\
+			## args);					\
+})
+
+#define ___drbd_printk_connection(prmacro, rlt, connection, lvl_or_desc, fmt, args...)	\
+({									\
+	const struct drbd_connection *__c =				\
+		(const struct drbd_connection *)(connection);		\
+	const struct drbd_resource *__r = __c->resource;		\
+	const char *__unregistered = "";				\
+	if (test_bit(C_UNREGISTERED, &__c->flags))			\
+		__unregistered = "/unregistered/";			\
+	if (drbd_connection_ratelimit(__c, rlt))			\
+		prmacro(lvl_or_desc, "drbd %s%s: " fmt,			\
+			__unregistered, __r->name, ## args);		\
+})
+
+#define __drbd_printk_device(rlt, device, level, fmt, args...)\
+	___drbd_printk_device(__drbd_printk, rlt, device, level, fmt, ## args)
+#define __drbd_printk_resource(rlt, resource, level, fmt, args...)\
+	 ___drbd_printk_resource(__drbd_printk, rlt, resource, level, fmt, ## args)
+#define __drbd_printk_peer_device(rlt, peer_device, level, fmt, args...)\
+	 ___drbd_printk_peer_device(__drbd_printk, rlt, peer_device, level, fmt, ## args)
+#define __drbd_printk_connection(rlt, connection, level, fmt, args...)\
+	 ___drbd_printk_connection(__drbd_printk, rlt, connection, level, fmt, ## args)
 
 void drbd_printk_with_wrong_object_type(void);
 void drbd_dyn_dbg_with_wrong_object_type(void);
 
 #define __drbd_printk_choose_cond(obj, struct_name) \
-	(__builtin_types_compatible_p(typeof(obj), struct struct_name *) || \
-	 __builtin_types_compatible_p(typeof(obj), const struct struct_name *))
-#define __drbd_printk_if_same_type(obj, struct_name, level, fmt, args...) \
-	__drbd_printk_choose_cond(obj, struct_name), \
-({ \
-	__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
-	printk(level __drbd_printk_ ## struct_name ## _fmt(fmt), \
-		__drbd_printk_ ## struct_name ## _args(), ## args); \
-	__drbd_printk_ ## struct_name ## _unprep(); \
-})
-
-#define drbd_printk(level, obj, fmt, args...) \
-	__builtin_choose_expr( \
-	  __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
-	  __builtin_choose_expr( \
-	    __drbd_printk_if_same_type(obj, drbd_resource, level, fmt, ## args), \
-	    __builtin_choose_expr( \
-	      __drbd_printk_if_same_type(obj, drbd_connection, level, fmt, ## args), \
-	      __builtin_choose_expr( \
-		__drbd_printk_if_same_type(obj, drbd_peer_device, level, fmt, ## args), \
-		drbd_printk_with_wrong_object_type()))))
+	(__builtin_types_compatible_p(typeof(obj), struct drbd_ ## struct_name *) || \
+	 __builtin_types_compatible_p(typeof(obj), const struct drbd_ ## struct_name *))
+
+#define __drbd_obj_ratelimit(struct_name, obj, rlt)		\
+	({							\
+	int __rlt = (rlt);					\
+	BUILD_BUG_ON(!__drbd_printk_choose_cond(obj, struct_name)); \
+	BUILD_BUG_ON(__rlt < -1);				\
+	BUILD_BUG_ON(__rlt >= (int)ARRAY_SIZE(obj->ratelimit)); \
+	__rlt == -1 ? 1						\
+	: __ratelimit(/* unconst cast ratelimit state */	\
+		(struct ratelimit_state *)(unsigned long)	\
+		&obj->ratelimit[__rlt]);			\
+	})
+
+#define drbd_device_ratelimit(obj, rlt)		\
+	__drbd_obj_ratelimit(device, obj, D_RL_D_ ## rlt)
+#define drbd_resource_ratelimit(obj, rlt)	\
+	__drbd_obj_ratelimit(resource, obj, D_RL_R_ ## rlt)
+#define drbd_connection_ratelimit(obj, rlt)	\
+	__drbd_obj_ratelimit(connection, obj, D_RL_C_ ## rlt)
+#define drbd_peer_device_ratelimit(obj, rlt)	\
+	__drbd_obj_ratelimit(peer_device, obj, D_RL_PD_ ## rlt)
+
+#define drbd_printk(ratelimit_type, level, obj, fmt, args...) \
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, device), \
+	__drbd_printk_device(ratelimit_type, obj, level, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, resource), \
+	__drbd_printk_resource(ratelimit_type, obj, level, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, connection), \
+	__drbd_printk_connection(ratelimit_type, obj, level, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, peer_device), \
+	__drbd_printk_peer_device(ratelimit_type, obj, level, fmt, ## args), \
+	\
+	drbd_printk_with_wrong_object_type() \
+	))))
 
 #define __drbd_dyn_dbg_if_same_type(obj, struct_name, fmt, args...) \
-	__drbd_printk_choose_cond(obj, struct_name), \
 ({ \
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {			\
-		__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
-		__dynamic_pr_debug(&descriptor, __drbd_printk_ ## struct_name ## _fmt(fmt), \
-			__drbd_printk_ ## struct_name ## _args(), ## args); \
-		__drbd_printk_ ## struct_name ## _unprep();	\
+		___drbd_printk_ ## struct_name(			\
+			__drbd_dyn_dbg,				\
+				NOLIMIT, obj,			\
+				&descriptor, fmt, ## args);	\
 	}							\
 })
 
 #define dynamic_drbd_dbg(obj, fmt, args...) \
-	__builtin_choose_expr( \
-	  __drbd_dyn_dbg_if_same_type(obj, drbd_device, fmt, ## args), \
-	  __builtin_choose_expr( \
-	    __drbd_dyn_dbg_if_same_type(obj, drbd_resource, fmt, ## args), \
-	    __builtin_choose_expr( \
-	      __drbd_dyn_dbg_if_same_type(obj, drbd_connection, fmt, ## args), \
-	      __builtin_choose_expr( \
-		__drbd_dyn_dbg_if_same_type(obj, drbd_peer_device, fmt, ## args), \
-		drbd_dyn_dbg_with_wrong_object_type()))))
-
-#define drbd_emerg(device, fmt, args...) \
-	drbd_printk(KERN_EMERG, device, fmt, ## args)
-#define drbd_alert(device, fmt, args...) \
-	drbd_printk(KERN_ALERT, device, fmt, ## args)
-#define drbd_crit(device, fmt, args...) \
-	drbd_printk(KERN_CRIT, device, fmt, ## args)
-#define drbd_err(device, fmt, args...) \
-	drbd_printk(KERN_ERR, device, fmt, ## args)
-#define drbd_warn(device, fmt, args...) \
-	drbd_printk(KERN_WARNING, device, fmt, ## args)
-#define drbd_notice(device, fmt, args...) \
-	drbd_printk(KERN_NOTICE, device, fmt, ## args)
-#define drbd_info(device, fmt, args...) \
-	drbd_printk(KERN_INFO, device, fmt, ## args)
-
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, device), \
+	__drbd_dyn_dbg_if_same_type(obj, device, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, resource), \
+	__drbd_dyn_dbg_if_same_type(obj, resource, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, connection), \
+	__drbd_dyn_dbg_if_same_type(obj, connection, fmt, ## args), \
+	\
+	__builtin_choose_expr(__drbd_printk_choose_cond(obj, peer_device), \
+	__drbd_dyn_dbg_if_same_type(obj, peer_device, fmt, ## args), \
+	\
+	drbd_dyn_dbg_with_wrong_object_type() \
+	))))
+
+#define drbd_emerg_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_EMERG, obj, fmt, ## args)
+#define drbd_alert_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_ALERT, obj, fmt, ## args)
+#define drbd_crit_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_CRIT, obj, fmt, ## args)
+#define drbd_err_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_ERR, obj, fmt, ## args)
+#define drbd_warn_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_WARNING, obj, fmt, ## args)
+#define drbd_notice_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_NOTICE, obj, fmt, ## args)
+#define drbd_info_ratelimit(obj, fmt, args...) \
+	drbd_printk(GENERIC, KERN_INFO, obj, fmt, ## args)
+
+#define drbd_emerg(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_EMERG, obj, fmt,  ## args)
+#define drbd_alert(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_ALERT, obj, fmt,  ## args)
+#define drbd_crit(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_CRIT, obj, fmt,  ## args)
+#define drbd_err(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_ERR, obj, fmt,  ## args)
+#define drbd_warn(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_WARNING, obj, fmt,  ## args)
+#define drbd_notice(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_NOTICE, obj, fmt,  ## args)
+#define drbd_info(obj, fmt, args...) \
+	drbd_printk(NOLIMIT, KERN_INFO, obj, fmt,  ## args)
 
 #define drbd_ratelimit() \
 ({						\
@@ -122,7 +197,7 @@ void drbd_dyn_dbg_with_wrong_object_type(void);
 	do {									\
 		if (!(exp))							\
 			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
-				#exp, __func__);				\
+				 #exp, __func__);				\
 	} while (0)
 
 /**
@@ -130,12 +205,13 @@ void drbd_dyn_dbg_with_wrong_object_type(void);
  *
  * Unlike the assert macro, this macro returns a boolean result.
  */
-#define expect(x, exp) ({							\
-		bool _bool = (exp);						\
-		if (!_bool && drbd_ratelimit())					\
-			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
-				#exp, __func__);				\
-		_bool;								\
+#define expect(x, exp) ({					\
+		bool _bool = (exp);				\
+		if (!_bool)					\
+			drbd_err_ratelimit(x,			\
+				"ASSERTION %s FAILED in %s\n",	\
+				#exp, __func__);		\
+		_bool;						\
 		})
 
 #endif
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index fa87cbba756b..d31b05bac2c1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1981,8 +1981,7 @@ static int receive_RSDataReply(struct drbd_connection *connection, struct packet
 		 * or in drbd_peer_request_endio. */
 		err = recv_resync_read(peer_device, sector, pi);
 	} else {
-		if (drbd_ratelimit())
-			drbd_err(device, "Can not write resync data to local disk.\n");
+		drbd_err_ratelimit(device, "Can not write resync data to local disk.\n");
 
 		err = drbd_drain_block(peer_device, pi->size);
 
@@ -2669,9 +2668,9 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		default:
 			BUG();
 		}
-		if (verb && drbd_ratelimit())
-			drbd_err(device, "Can not satisfy peer's read request, "
-			    "no local data.\n");
+		if (verb)
+			drbd_err_ratelimit(device,
+					   "Can not satisfy peer's read request, no local data.\n");
 
 		/* drain possibly payload */
 		return drbd_drain_block(peer_device, pi->size);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f16b925fecc1..1412524e849c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -139,7 +139,7 @@ void drbd_req_destroy(struct kref *kref)
 			if (get_ldev_if_state(device, D_FAILED)) {
 				drbd_al_complete_io(device, &req->i);
 				put_ldev(device);
-			} else if (drbd_ratelimit()) {
+			} else if (drbd_device_ratelimit(device, BACKEND)) {
 				drbd_warn(device, "Should have called drbd_al_complete_io(, %llu, %u), "
 					 "but my Disk seems to have failed :(\n",
 					 (unsigned long long) req->i.sector, req->i.size);
@@ -513,7 +513,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 
 static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
 {
-	if (!drbd_ratelimit())
+	if (!drbd_device_ratelimit(device, BACKEND))
 		return;
 
 	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
@@ -1403,9 +1403,9 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		submit_private_bio = true;
 	} else if (no_remote) {
 nodata:
-		if (drbd_ratelimit())
-			drbd_err(device, "IO ERROR: neither local nor remote data, sector %llu+%u\n",
-					(unsigned long long)req->i.sector, req->i.size >> 9);
+		drbd_err_ratelimit(device,
+				   "IO ERROR: neither local nor remote data, sector %llu+%u\n",
+				   (unsigned long long)req->i.sector, req->i.size >> 9);
 		/* A write may have been queued for send_oos, however.
 		 * So we can not simply free it, we must go through drbd_req_put_completion_ref() */
 	}
diff --git a/drivers/block/drbd/drbd_sender.c b/drivers/block/drbd/drbd_sender.c
index 69b3676961d2..b848adfaf494 100644
--- a/drivers/block/drbd/drbd_sender.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -171,7 +171,7 @@ void drbd_peer_request_endio(struct bio *bio)
 	bool is_discard = bio_op(bio) == REQ_OP_WRITE_ZEROES ||
 			  bio_op(bio) == REQ_OP_DISCARD;
 
-	if (bio->bi_status && drbd_ratelimit())
+	if (bio->bi_status && drbd_device_ratelimit(device, BACKEND))
 		drbd_warn(device, "%s: error=%d s=%llus\n",
 				is_write ? (is_discard ? "discard" : "write")
 					: "read", bio->bi_status,
@@ -235,7 +235,7 @@ void drbd_request_endio(struct bio *bio)
 	 * though we still will complain noisily about it.
 	 */
 	if (unlikely(req->rq_state & RQ_LOCAL_ABORTED)) {
-		if (drbd_ratelimit())
+		if (drbd_device_ratelimit(device, BACKEND))
 			drbd_emerg(device, "delayed completion of aborted local request; disk-timeout may be too aggressive\n");
 
 		if (!bio->bi_status)
@@ -1050,9 +1050,8 @@ int w_e_end_data_req(struct drbd_work *w, int cancel)
 	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
 		err = drbd_send_block(peer_device, P_DATA_REPLY, peer_req);
 	} else {
-		if (drbd_ratelimit())
-			drbd_err(device, "Sending NegDReply. sector=%llus.\n",
-			    (unsigned long long)peer_req->i.sector);
+		drbd_err_ratelimit(peer_device, "Sending NegDReply. sector=%llus.\n",
+				   (unsigned long long)peer_req->i.sector);
 
 		err = drbd_send_ack(peer_device, P_NEG_DREPLY, peer_req);
 	}
@@ -1122,15 +1121,13 @@ int w_e_end_rsdata_req(struct drbd_work *w, int cancel)
 			else
 				err = drbd_send_block(peer_device, P_RS_DATA_REPLY, peer_req);
 		} else {
-			if (drbd_ratelimit())
-				drbd_err(device, "Not sending RSDataReply, "
-				    "partner DISKLESS!\n");
+			drbd_err_ratelimit(peer_device,
+					   "Not sending RSDataReply, partner DISKLESS!\n");
 			err = 0;
 		}
 	} else {
-		if (drbd_ratelimit())
-			drbd_err(device, "Sending NegRSDReply. sector %llus.\n",
-			    (unsigned long long)peer_req->i.sector);
+		drbd_err_ratelimit(peer_device, "Sending NegRSDReply. sector %llus.\n",
+				   (unsigned long long)peer_req->i.sector);
 
 		err = drbd_send_ack(peer_device, P_NEG_RS_DREPLY, peer_req);
 
@@ -1197,8 +1194,7 @@ int w_e_end_csum_rs_req(struct drbd_work *w, int cancel)
 		}
 	} else {
 		err = drbd_send_ack(peer_device, P_NEG_RS_DREPLY, peer_req);
-		if (drbd_ratelimit())
-			drbd_err(device, "Sending NegDReply. I guess it gets messy.\n");
+		drbd_err_ratelimit(device, "Sending NegDReply. I guess it gets messy.\n");
 	}
 	if (unlikely(err))
 		drbd_err(device, "drbd_send_block/ack() failed\n");
-- 
2.55.0

