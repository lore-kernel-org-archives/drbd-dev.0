Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1834A0F0B
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301594; cv=none; b=WBseWvzLqkPsNvm1pWglEMalOX7lrtI3m2bld35DL6huvGxOTVEx4amB2zbAIKfps8wLgfmXrAe59X1eirENHDKSjv6EqG1NLp0tAfpDDBCYL1d6OX3sO0sJoqwLRhWcKpHBVCkXxOIlPxEfsqvk7Fh08rb0oQh1rCaoAWFIlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301594; c=relaxed/simple;
	bh=72dLbjksJHvwolCjnZ7pI1oL9C6NDEu2AadziM3RMDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt9zhATlZ6pM84n61t7K+FoqCpueCsKRCEWITZu8Avh4loUsOTmDGfqgx79Qg6YCXZt3+IRf/WUto46yJF23qObxI1BN3xp4mUHxAycaLGICVfZJBDy2DhVcGtiEMG0cTEAQmtSjg7RgPwXUOSHxLuTb1A5hgZJFgU4onnvsbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=Rq5+LOZ2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="Rq5+LOZ2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a020e65269so7210005e9.2
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301585; x=1791906385; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEpIfLLamuj5h5QQisKFdIWi/H78rMGHzrqGOVei1XY=;
        b=Rq5+LOZ2j/VmV9S/u987RtaUKcfiVFhw7QtaDkzpwrtLro/jaB7VuaIsQW7ARHUdEH
         ah6EudGnPF+3IQ6EWYKy8qDs+ODHjazwMt0J7CAeYHYVkT/BmnOnNfwWfbK5xuXilxxv
         kKKBBVV25Qb+eU3meYHp0yFg/HGmoyo4HcU4mYTBepbDvSh/yr5CAfP1SJZ5nc8H/c6u
         pkY6wod/t0kg6t/qsTMDJ42iKfjy8wpgJ/xpalWYPdc0xchPK3V5+dC0Hl3tZZU2yAfO
         SZPT/iqUbHavVgrzf+Kvwx2x3vc1TltDdv+J//hPomRzdPhmdDUggeEilAck7gB8RMaD
         Rgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301585; x=1791906385;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEpIfLLamuj5h5QQisKFdIWi/H78rMGHzrqGOVei1XY=;
        b=NBYzZ9lhop24Bxf2KkMqC1g4i3PH6XozAvBjRkiWQ+VZWX9vWPcbE2OlHoqOGbCd15
         H0J6Qfd8yxN13Q4QgJwxk5jcIlo01Pq7xzOkpA2DKk+B6pqYa3AT6lXCNW3SORs+raiL
         Zr3/PuNop7c2TrF2SS5G8kb8bCSju6u2Z0PtEW6lyX+PL5mabiuOI+r/sgbtmITMsrKZ
         JV09et3L/1pbfQOyBQBaRldxcJdKmCuZgLrp7irYCaxX4/26+WQ9zCyROSivqPnAUFk4
         CjxTignbzfhhG5yy+/MSpNDJi18EcpL126SP11FItoGwmm6fRl+Gw++p9lFH1lCK+sMF
         guXA==
X-Forwarded-Encrypted: i=1; AKwUvByL25slo31dCjMqajpRn7jfMdRdD2wA7mcRkCFN1l0iOlH/9qked4Lr4LgQclxcPMxRoUtbqwPybA==@lists.linux.dev
X-Gm-Message-State: AFuF++lW2MtUEtuZHjhL/MnWnXWXycLV2MBXXLkDfxPLSiegenHAxftS
	o9CgDLuQc6Pd199yysrtV3eS1tz42d+nOJwaoMicPgWbq4kKaa5kkrtGDeKTyjskcSH6077i7nd
	n33/etao=
X-Gm-Gg: AYBFou0AC+KQ8VrsmqZupmDZfM+xxNYc1Ve1xDcxcSN4QZyuoDT25t9EDHBLt1InXGG
	9gf8/n3Z0l8cRAVAG8JNnyoz8CxTfutcHcaA7+0a0KzB7GCO1/E7owelMnwBtkh7zHn80zJb0Et
	+IKVrhni7/hRdPRqkcRSttxYzQrKSk1MC3VR1cbQO+UZbdha1DD732bANi+PBpVjm+3raLuVJvj
	VuViNf7SLMuF51YxDxF4Fp+U8X6eb/7tPEyUBnO4ug2VtdcZQ7y/Tzk05jJVxMSFZmvUqz5DW1j
	y4v168XmiSYyy8lMQaxPu6HJx2mg63Ih+2BylvZsYRwEhxbtAy0zCU43tf8jlt/F5tZ1Yn/7V9/
	pXNTypLaTWOdn7yOsbz98Cwb8NLeq1DvxapT4GKJ5yqG7QOEZnqIcCxCXPcjiCaSyCOh1oFDYJc
	Chx3x1l7Y6VPRiRmOhMbm4PYI6r8aEONDoEm7aDHXZlJZyvvoCBn8xO/bFDFyfD3jo6fnOtIjs5
	6N/KHM3x891uni8gLxruuSPihftOpqX
X-Received: by 2002:a05:600c:8a16:10b0:4a1:7ba9:da34 with SMTP id 5b1f17b1804b1-4a17ba9e2f1mr22812225e9.0.1791301584983;
        Tue, 06 Oct 2026 08:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:24 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>,
	=?UTF-8?q?Moritz=20Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>
Subject: [PATCH v2 04/20] drbd: add transport layer abstraction
Date: Tue,  6 Oct 2026 17:45:51 +0200
Message-ID: <20261006154607.3936501-5-christoph.boehmwalder@linbit.com>
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

DRBD 9 decouples all network I/O from the core driver by introducing a
transport abstraction layer. The core driver interacts with the network
only through a well-defined ops table, and concrete implementations
live in separate kernel modules that register themselves at load time.

The abstraction models connections as a set of paths, each representing
a local/remote address pair. A shared listener mechanism allows multiple
paths on the same resource to reuse a single listening socket.
The core exports callbacks which the transports can call back into,
keeping protocol logic in the core and handling wire details in the
transport.

This commit adds the header defining the interface and some
infrastructure. Actual transport implementations follow later in the
series.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                  |   1 +
 drivers/block/drbd/drbd_transport.c          | 545 +++++++++++++++++++
 drivers/block/drbd/drbd_transport.h          | 480 ++++++++++++++++
 drivers/block/drbd/drbd_transport_template.c | 164 ++++++
 4 files changed, 1190 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_template.c

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 1a6dc0f482f5..d4fa578325dc 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -4,6 +4,7 @@ drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
+drbd-y += drbd_transport.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
diff --git a/drivers/block/drbd/drbd_transport.c b/drivers/block/drbd/drbd_transport.c
new file mode 100644
index 000000000000..567cc5b9b13a
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <net/ipv6.h>
+#include "drbd_transport.h"
+#include "drbd_int.h"
+
+static LIST_HEAD(transport_classes);
+static DECLARE_RWSEM(transport_classes_lock);
+
+static struct drbd_transport_class *__find_transport_class(const char *transport_name)
+{
+	struct drbd_transport_class *transport_class;
+
+	list_for_each_entry(transport_class, &transport_classes, list)
+		if (!strcmp(transport_class->name, transport_name))
+			return transport_class;
+
+	return NULL;
+}
+
+int drbd_register_transport_class(struct drbd_transport_class *transport_class, int version,
+				  int drbd_transport_size)
+{
+	int rv = 0;
+
+	if (version != DRBD_TRANSPORT_API_VERSION) {
+		pr_err("DRBD_TRANSPORT_API_VERSION not compatible\n");
+		return -EINVAL;
+	}
+
+	if (drbd_transport_size != sizeof(struct drbd_transport)) {
+		pr_err("sizeof(drbd_transport) not compatible\n");
+		return -EINVAL;
+	}
+
+	down_write(&transport_classes_lock);
+	if (__find_transport_class(transport_class->name)) {
+		pr_err("transport class '%s' already registered\n", transport_class->name);
+		rv = -EEXIST;
+	} else {
+		list_add_tail(&transport_class->list, &transport_classes);
+		pr_info("registered transport class '%s' (version:%s)\n",
+			transport_class->name,
+			transport_class->module->version ?: "N/A");
+	}
+	up_write(&transport_classes_lock);
+	return rv;
+}
+
+void drbd_unregister_transport_class(struct drbd_transport_class *transport_class)
+{
+	down_write(&transport_classes_lock);
+	if (!__find_transport_class(transport_class->name)) {
+		pr_crit("unregistering unknown transport class '%s'\n",
+			transport_class->name);
+		BUG();
+	}
+	list_del_init(&transport_class->list);
+	pr_info("unregistered transport class '%s'\n", transport_class->name);
+	up_write(&transport_classes_lock);
+}
+
+static struct drbd_transport_class *get_transport_class(const char *name)
+{
+	struct drbd_transport_class *tc;
+
+	down_read(&transport_classes_lock);
+	tc = __find_transport_class(name);
+	if (tc && !try_module_get(tc->module))
+		tc = NULL;
+	up_read(&transport_classes_lock);
+	return tc;
+}
+
+struct drbd_transport_class *drbd_get_transport_class(const char *name)
+{
+	struct drbd_transport_class *tc = get_transport_class(name);
+
+	if (!tc) {
+		request_module("drbd_transport_%s", name);
+		tc = get_transport_class(name);
+	}
+
+	return tc;
+}
+
+void drbd_put_transport_class(struct drbd_transport_class *tc)
+{
+	/* convenient in the error cleanup path */
+	if (!tc)
+		return;
+	down_read(&transport_classes_lock);
+	module_put(tc->module);
+	up_read(&transport_classes_lock);
+}
+
+void drbd_print_transports_loaded(struct seq_file *seq)
+{
+	struct drbd_transport_class *tc;
+
+	down_read(&transport_classes_lock);
+
+	seq_puts(seq, "Transports (api:" __stringify(DRBD_TRANSPORT_API_VERSION) "):");
+	list_for_each_entry(tc, &transport_classes, list) {
+		seq_printf(seq, " %s (%s)", tc->name,
+				tc->module->version ? tc->module->version : "NONE");
+	}
+	seq_putc(seq, '\n');
+
+	up_read(&transport_classes_lock);
+}
+
+static bool addr_equal(const struct sockaddr_storage *addr1, const struct sockaddr_storage *addr2)
+{
+	if (addr1->ss_family != addr2->ss_family)
+		return false;
+
+	if (addr1->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *v6a1 = (const struct sockaddr_in6 *)addr1;
+		const struct sockaddr_in6 *v6a2 = (const struct sockaddr_in6 *)addr2;
+
+		if (!ipv6_addr_equal(&v6a1->sin6_addr, &v6a2->sin6_addr))
+			return false;
+		else if (ipv6_addr_type(&v6a1->sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			return v6a1->sin6_scope_id == v6a2->sin6_scope_id;
+		return true;
+	} else /* AF_INET, AF_SSOCKS, AF_SDP */ {
+		const struct sockaddr_in *v4a1 = (const struct sockaddr_in *)addr1;
+		const struct sockaddr_in *v4a2 = (const struct sockaddr_in *)addr2;
+
+		return v4a1->sin_addr.s_addr == v4a2->sin_addr.s_addr;
+	}
+}
+
+static bool addr_and_port_equal(const struct sockaddr_storage *addr1, const struct sockaddr_storage *addr2)
+{
+	if (!addr_equal(addr1, addr2))
+		return false;
+
+	if (addr1->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *v6a1 = (const struct sockaddr_in6 *)addr1;
+		const struct sockaddr_in6 *v6a2 = (const struct sockaddr_in6 *)addr2;
+
+		return v6a1->sin6_port == v6a2->sin6_port;
+	} else /* AF_INET, AF_SSOCKS, AF_SDP */ {
+		const struct sockaddr_in *v4a1 = (const struct sockaddr_in *)addr1;
+		const struct sockaddr_in *v4a2 = (const struct sockaddr_in *)addr2;
+
+		return v4a1->sin_port == v4a2->sin_port;
+	}
+
+	return false;
+}
+
+static struct drbd_listener *find_listener(struct drbd_connection *connection,
+					   const struct sockaddr_storage *addr)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_listener *listener;
+
+	list_for_each_entry(listener, &resource->listeners, list) {
+		if (addr_and_port_equal(&listener->listen_addr, addr)) {
+			if (kref_get_unless_zero(&listener->kref))
+				return listener;
+		}
+	}
+	return NULL;
+}
+
+int drbd_get_listener(struct drbd_path *path)
+{
+	struct drbd_transport *transport = path->transport;
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	struct sockaddr *addr = (struct sockaddr *)&path->my_addr;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_transport_class *tc = transport->class;
+	struct drbd_listener *listener;
+	bool needs_init = false;
+	int err;
+
+	spin_lock_bh(&resource->listeners_lock);
+	listener = find_listener(connection, (struct sockaddr_storage *)addr);
+	if (!listener) {
+		listener = kzalloc(tc->listener_instance_size, GFP_ATOMIC);
+		if (!listener) {
+			spin_unlock_bh(&resource->listeners_lock);
+			return -ENOMEM;
+		}
+		kref_init(&listener->kref);
+		INIT_LIST_HEAD(&listener->waiters);
+		listener->resource = resource;
+		listener->pending_accepts = 0;
+		spin_lock_init(&listener->waiters_lock);
+		init_completion(&listener->ready);
+		listener->listen_addr = *(struct sockaddr_storage *)addr;
+		listener->transport_class = NULL;
+
+		list_add(&listener->list, &resource->listeners);
+		needs_init = true;
+	}
+	spin_unlock_bh(&resource->listeners_lock);
+
+	if (needs_init) {
+		if (try_module_get(tc->module)) {
+			listener->transport_class = tc;
+			err = tc->ops.init_listener(transport, addr, path->net, listener);
+		} else {
+			err = -ENODEV;
+		}
+		listener->err = err;
+		complete_all(&listener->ready);
+	} else {
+		wait_for_completion(&listener->ready);
+		err = listener->err;
+	}
+
+	if (err) {
+		kref_put(&listener->kref, drbd_listener_destroy);
+		return err;
+	}
+
+	spin_lock_bh(&listener->waiters_lock);
+	kref_get(&path->kref);
+	list_add(&path->listener_link, &listener->waiters);
+	path->listener = listener;
+	spin_unlock_bh(&listener->waiters_lock);
+	/* After exposing the listener on a path, drbd_put_listenr() can destroy it. */
+
+	return 0;
+}
+
+void drbd_listener_destroy(struct kref *kref)
+{
+	struct drbd_listener *listener = container_of(kref, struct drbd_listener, kref);
+	struct drbd_transport_class *tc = listener->transport_class;
+	struct drbd_resource *resource = listener->resource;
+
+	spin_lock_bh(&resource->listeners_lock);
+	list_del(&listener->list);
+	spin_unlock_bh(&resource->listeners_lock);
+
+	if (tc) {
+		tc->ops.release_listener(listener);
+		module_put(tc->module);
+	}
+	kfree(listener);
+}
+
+void drbd_put_listener(struct drbd_path *path)
+{
+	struct drbd_listener *listener;
+
+	listener = xchg(&path->listener, NULL);
+	if (!listener)
+		return;
+
+	spin_lock_bh(&listener->waiters_lock);
+	list_del(&path->listener_link);
+	kref_put(&path->kref, drbd_destroy_path);
+	spin_unlock_bh(&listener->waiters_lock);
+	kref_put(&listener->kref, drbd_listener_destroy);
+}
+
+/**
+ * drbd_listener_try_get_ref() - Acquire a reference to path->listener.
+ * @path: The path whose listener should be pinned.
+ *
+ * Necessary to protect from a concurrently running del-path.
+ */
+struct drbd_listener *drbd_listener_try_get_ref(struct drbd_path *path)
+{
+	struct drbd_connection *connection =
+		container_of(path->transport, struct drbd_connection, transport);
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_listener *listener;
+
+	spin_lock_bh(&resource->listeners_lock);
+	listener = READ_ONCE(path->listener);
+	if (!listener || !kref_get_unless_zero(&listener->kref))
+		listener = NULL;
+	spin_unlock_bh(&resource->listeners_lock);
+	return listener;
+}
+
+struct drbd_path *drbd_find_path_by_addr(struct drbd_listener *listener, struct sockaddr_storage *addr)
+{
+	struct drbd_path *path;
+
+	list_for_each_entry(path, &listener->waiters, listener_link) {
+		if (addr_equal(&path->peer_addr, addr))
+			return path;
+	}
+
+	return NULL;
+}
+
+/* An incoming connection is routed by matching the listener (my_addr and
+ * my_port) and then the peer IP. Two paths that agree on all three are
+ * therefore indistinguishable to the receiver.
+ */
+bool drbd_path_conflicts_by_listener(struct drbd_path *existing,
+				     struct drbd_path *candidate)
+{
+	return addr_and_port_equal(&existing->my_addr, &candidate->my_addr) &&
+	       addr_equal(&existing->peer_addr, &candidate->peer_addr);
+}
+
+/**
+ * drbd_stream_send_timed_out() - Tells transport if the connection should stay alive
+ * @transport:	DRBD transport to operate on.
+ * @stream:     DATA_STREAM or CONTROL_STREAM
+ *
+ * When it returns true, the transport should return -EAGAIN to its caller of the
+ * send function. When it returns false the transport should keep on trying to
+ * get the packet through.
+ */
+bool drbd_stream_send_timed_out(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	bool drop_it;
+
+	drop_it = stream == CONTROL_STREAM || connection->cstate[NOW] < C_CONNECTED;
+
+	if (drop_it)
+		return true;
+
+	if (connection->transport.ko_count == 0) {
+		drbd_err(connection, "[%s/%d] sending time expired, pinging peer\n",
+			 current->comm, current->pid);
+		drbd_queue_ping(connection);
+		return false;
+	}
+
+	drop_it = !--connection->transport.ko_count;
+	if (!drop_it) {
+		drbd_err(connection, "[%s/%d] sending time expired, ko = %u\n",
+			 current->comm, current->pid, connection->transport.ko_count);
+		drbd_queue_ping(connection);
+	}
+
+	return drop_it;
+}
+
+bool drbd_should_abort_listening(struct drbd_transport *transport)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	bool abort = false;
+
+	if (connection->cstate[NOW] <= C_DISCONNECTING)
+		abort = true;
+	if (signal_pending(current)) {
+		flush_signals(current);
+		smp_rmb();
+		if (get_t_state(&connection->receiver) == EXITING)
+			abort = true;
+	}
+
+	return abort;
+}
+
+/* Called by a transport if a path was established / disconnected */
+void drbd_path_event(struct drbd_transport *transport, struct drbd_path *path)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+
+	notify_path(connection, path, NOTIFY_CHANGE);
+}
+
+struct drbd_path *__drbd_next_path_ref(struct drbd_path *drbd_path,
+					      struct drbd_transport *transport)
+{
+	rcu_read_lock();
+	if (!drbd_path) {
+		drbd_path = list_first_or_null_rcu(&transport->paths, struct drbd_path, list);
+	} else {
+		struct list_head *pos;
+		bool in_list;
+
+		pos = list_next_rcu(&drbd_path->list);
+		/* Ensure list head is read before flag. */
+		smp_rmb();
+		in_list = !test_bit(TR_UNREGISTERED, &drbd_path->flags);
+		kref_put(&drbd_path->kref, drbd_destroy_path);
+
+		if (pos == &transport->paths) {
+			drbd_path = NULL;
+		} else if (in_list) {
+			drbd_path = list_entry_rcu(pos, struct drbd_path, list);
+		} else {
+			/* No longer on the list, element might be freed, restart from the start */
+			drbd_path = list_first_or_null_rcu(&transport->paths,
+					struct drbd_path, list);
+		}
+	}
+	if (drbd_path)
+		kref_get(&drbd_path->kref);
+	rcu_read_unlock();
+
+	return drbd_path;
+}
+
+static struct bio *drbd_bio_alloc_next(struct bio *bio)
+{
+	return bio_alloc_bioset(bio->bi_bdev, bio->bi_max_vecs, bio->bi_opf, GFP_NOIO,
+				bio->bi_pool);
+}
+
+int drbd_bio_add_page(struct drbd_transport *transport, struct bio_list *bios,
+		      struct page *page, unsigned int len, unsigned int offset)
+{
+	struct bio *bio = bios->tail;
+	struct bio *new_bio;
+	int r;
+
+	r = bio_add_page(bio, page, len, offset);
+	if (r)
+		return r;
+
+	new_bio = drbd_bio_alloc_next(bio);
+	if (!new_bio)
+		return -ENOMEM;
+
+	bio_list_add(bios, new_bio);
+	r = bio_add_page(new_bio, page, len, offset);
+	if (r)
+		return r;
+
+	return -ENOENT;
+}
+
+/* The coarsest queue dma_alignment (as a byte count) among the resource's
+ * attached backing devices; 0 if none is attached. Received payload submitted
+ * to any of them must honour it, see set_rx_alignment.
+ */
+static unsigned int drbd_resource_rx_alignment(struct drbd_resource *resource)
+{
+	struct drbd_device *device;
+	unsigned int align = 0;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&resource->devices, device, vnr) {
+		if (!get_ldev_if_state(device, D_ATTACHING))
+			continue;
+		if (device->ldev) {
+			struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
+
+			align = max_t(unsigned int, align, queue_dma_alignment(q) + 1);
+		}
+		put_ldev(device);
+	}
+	rcu_read_unlock();
+
+	return align;
+}
+
+void drbd_connection_update_rx_alignment(struct drbd_resource *resource,
+					 struct drbd_connection *connection)
+{
+	struct drbd_transport_ops *tr_ops = &connection->transport.class->ops;
+
+	if (tr_ops->set_rx_alignment)
+		tr_ops->set_rx_alignment(&connection->transport,
+					 drbd_resource_rx_alignment(resource));
+}
+
+void drbd_resource_update_rx_alignment(struct drbd_resource *resource)
+{
+	struct drbd_connection *connection;
+
+	rcu_read_lock();
+	for_each_connection_rcu(connection, resource)
+		drbd_connection_update_rx_alignment(resource, connection);
+	rcu_read_unlock();
+}
+
+/* Like drbd_bio_add_page(), but never merges into the tail bvec: the range
+ * becomes a bvec of its own, even if it is physically contiguous with the
+ * previous one. For a transport whose received chunks may share a page (the
+ * chunk boundary falls mid-page), one bvec then owns exactly one page
+ * reference per page it touches, which is what drbd_peer_req_strip_bio()
+ * releases.
+ */
+int drbd_bio_add_page_nomerge(struct drbd_transport *transport, struct bio_list *bios,
+			      struct page *page, unsigned int len, unsigned int offset)
+{
+	struct bio *bio = bios->tail;
+
+	if (bio->bi_vcnt >= bio->bi_max_vecs || bio->bi_iter.bi_size > UINT_MAX - len) {
+		struct bio *new_bio = drbd_bio_alloc_next(bio);
+
+		if (!new_bio)
+			return -ENOMEM;
+		bio_list_add(bios, new_bio);
+		bio = new_bio;
+	}
+	__bio_add_page(bio, page, len, offset);
+	return len;
+}
+
+void drbd_transport_lock(struct drbd_transport *transport)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+
+	mutex_lock(&connection->mutex[DATA_STREAM]);
+	mutex_lock(&connection->mutex[CONTROL_STREAM]);
+}
+EXPORT_SYMBOL_GPL(drbd_transport_lock);
+
+void drbd_transport_unlock(struct drbd_transport *transport)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+
+	mutex_unlock(&connection->mutex[CONTROL_STREAM]);
+	mutex_unlock(&connection->mutex[DATA_STREAM]);
+}
+EXPORT_SYMBOL_GPL(drbd_transport_unlock);
+
+/* Network transport abstractions */
+EXPORT_SYMBOL_GPL(drbd_register_transport_class);
+EXPORT_SYMBOL_GPL(drbd_unregister_transport_class);
+EXPORT_SYMBOL_GPL(drbd_get_listener);
+EXPORT_SYMBOL_GPL(drbd_put_listener);
+EXPORT_SYMBOL_GPL(drbd_listener_try_get_ref);
+EXPORT_SYMBOL_GPL(drbd_find_path_by_addr);
+EXPORT_SYMBOL_GPL(drbd_stream_send_timed_out);
+EXPORT_SYMBOL_GPL(drbd_should_abort_listening);
+EXPORT_SYMBOL_GPL(drbd_path_event);
+EXPORT_SYMBOL_GPL(drbd_listener_destroy);
+EXPORT_SYMBOL_GPL(__drbd_next_path_ref);
+EXPORT_SYMBOL_GPL(drbd_bio_add_page);
+EXPORT_SYMBOL_GPL(drbd_bio_add_page_nomerge);
diff --git a/drivers/block/drbd/drbd_transport.h b/drivers/block/drbd/drbd_transport.h
new file mode 100644
index 000000000000..2be455319ca3
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport.h
@@ -0,0 +1,480 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
+ */
+
+#ifndef DRBD_TRANSPORT_H
+#define DRBD_TRANSPORT_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/socket.h>
+
+/*
+ * Whenever touch this file in a non-trivial way, increase the
+ * DRBD_TRANSPORT_API_VERSION
+ * So that transport compiled against an older version of this
+ * header will no longer load in a module that assumes a newer
+ * version.
+ */
+#define DRBD_TRANSPORT_API_VERSION 23
+
+/*
+ * MSG_MSG_DONTROUTE and MSG_PROBE are not used by DRBD. I.e.
+ * we can reuse these flags for our purposes
+ */
+#define CALLER_BUFFER  MSG_DONTROUTE
+#define GROW_BUFFER    MSG_PROBE
+
+/*
+ * gfp_mask for allocating memory with no write-out.
+ *
+ * When drbd allocates memory on behalf of the peer, we prevent it from causing
+ * write-out because in a criss-cross setup, the write-out could lead to memory
+ * pressure on the peer, eventually leading to deadlock.
+ */
+#define GFP_TRY	(__GFP_HIGHMEM | __GFP_NOWARN | __GFP_RECLAIM)
+
+#define tr_printk(level, transport, fmt, args...)  ({		\
+	rcu_read_lock();					\
+	printk(level "drbd %s %s:%s: " fmt,			\
+	       (transport)->log_prefix,				\
+	       (transport)->class->name,			\
+	       rcu_dereference((transport)->net_conf)->name,	\
+	       ## args);					\
+	rcu_read_unlock();					\
+	})
+
+#define tr_err(transport, fmt, args...) \
+	tr_printk(KERN_ERR, transport, fmt, ## args)
+#define tr_warn(transport, fmt, args...) \
+	tr_printk(KERN_WARNING, transport, fmt, ## args)
+#define tr_notice(transport, fmt, args...) \
+	tr_printk(KERN_NOTICE, transport, fmt, ## args)
+#define tr_info(transport, fmt, args...) \
+	tr_printk(KERN_INFO, transport, fmt, ## args)
+
+#define TR_ASSERT(x, exp)							\
+	do {									\
+		if (!(exp))							\
+			tr_err(x, "ASSERTION %s FAILED in %s\n",		\
+				 #exp, __func__);				\
+	} while (0)
+
+struct drbd_resource;
+struct drbd_listener;
+struct drbd_transport;
+struct bio;
+
+enum drbd_stream {
+	DATA_STREAM,
+	CONTROL_STREAM
+};
+
+enum drbd_tr_hints {
+	CORK,
+	UNCORK,
+	NODELAY,
+	NOSPACE,
+	QUICKACK
+};
+
+enum { /* bits in the flags word */
+	NET_CONGESTED,		/* The data socket is congested */
+	RESOLVE_CONFLICTS,	/* Set on one node, cleared on the peer! */
+};
+
+enum drbd_tr_free_op {
+	CLOSE_CONNECTION,
+	DESTROY_TRANSPORT
+};
+
+enum drbd_tr_event {
+	CLOSED_BY_PEER,
+	TIMEOUT,
+};
+
+enum drbd_tr_path_flag {
+	TR_ESTABLISHED, /* updated by the transport */
+	TR_UNREGISTERED,
+	TR_TRANSPORT_PRIVATE = 32, /* flags starting here are used exclusively by the transport */
+};
+
+/*
+ * A transport might wrap its own data structure around this. Having
+ * this base class as its first member.
+ */
+struct drbd_path {
+	struct sockaddr_storage my_addr;
+	struct sockaddr_storage peer_addr;
+
+	struct kref kref;
+
+	struct net *net;
+	int my_addr_len;
+	int peer_addr_len;
+	unsigned long flags;
+
+	struct drbd_transport *transport;
+	struct list_head list; /* paths of a connection */
+	/* paths waiting for an incoming connection,
+	 * head is in a drbd_listener
+	 */
+	struct list_head listener_link;
+	struct drbd_listener *listener;
+
+	struct rcu_head rcu;
+};
+
+/*
+ * Each transport implementation should embed a struct drbd_transport
+ * into its instance data structure.
+ */
+struct drbd_transport {
+	struct drbd_transport_class *class;
+
+	struct list_head paths;
+
+	const char *log_prefix;		/* resource name */
+	struct drbd_net_conf __rcu *net_conf;	/* content protected by rcu */
+
+	/* These members are intended to be updated by the transport: */
+	unsigned int ko_count;
+	unsigned long flags;
+};
+
+struct drbd_transport_stats {
+	int unread_received;
+	int unacked_send;
+	int send_buffer_size;
+	int send_buffer_used;
+};
+
+struct drbd_const_buffer {
+	const u8 *buffer;
+	unsigned int avail;
+};
+
+/**
+ * struct drbd_transport_ops - Operations implemented by the transport.
+ *
+ * The user of this API guarantees that all of the following will be exclusive
+ * with respect to each other for a given transport instance:
+ * * init()
+ * * free()
+ * * prepare_connect()
+ * * finish_connect()
+ * * add_path() and the subsequent list_add_tail_rcu() for the paths list
+ * * may_remove_path(), remove_path() and the subsequent list_del_rcu() for the paths list
+ *
+ * The connection sequence is as follows:
+ * 1. prepare_connect(), with the above exclusivity guarantee
+ * 2. connect(), this may take a long time
+ * 3. finish_connect(), with the above exclusivity guarantee
+ */
+struct drbd_transport_ops {
+	int (*init)(struct drbd_transport *);
+	void (*free)(struct drbd_transport *, enum drbd_tr_free_op free_op);
+	int (*init_listener)(struct drbd_transport *, const struct sockaddr *, struct net *net,
+			     struct drbd_listener *);
+	void (*release_listener)(struct drbd_listener *);
+	int (*prepare_connect)(struct drbd_transport *);
+	int (*connect)(struct drbd_transport *);
+	void (*finish_connect)(struct drbd_transport *);
+
+/**
+ * recv() - Receive data via the transport
+ * @transport:	The transport to use
+ * @stream:	The stream within the transport to use. Ether DATA_STREAM or CONTROL_STREAM
+ * @buf:	The function will place here the pointer to the data area
+ * @size:	Number of byte to receive
+ * @msg_flags:	Bitmask of CALLER_BUFFER, GROW_BUFFER and MSG_DONTWAIT
+ *
+ * recv() returns the requests data in a buffer (owned by the transport).
+ * You may pass MSG_DONTWAIT as flags.  Usually with the next call to recv()
+ * or recv_pages() on the same stream, the buffer may no longer be accessed
+ * by the caller. I.e. it is reclaimed by the transport.
+ *
+ * If the transport was not capable of fulfilling the complete "wish" of the
+ * caller (that means it returned a smaller size that size), the caller may
+ * call recv() again with the flag GROW_BUFFER, and *buf as returned by the
+ * previous call.
+ * Note1: This can happen if MSG_DONTWAIT was used, or if a receive timeout
+ *	was we with set_rcvtimeo().
+ * Note2: recv() is free to re-locate the buffer in such a call. I.e. to
+ *	modify *buf. Then it copies the content received so far to the new
+ *	memory location.
+ *
+ * Last not least the caller may also pass an arbitrary pointer in *buf with
+ * the CALLER_BUFFER flag. This is expected to be used for small amounts
+ * of data only
+ *
+ * Upon success the function returns the bytes read. Upon error the return
+ * code is negative. A 0 indicates that the socket was closed by the remote
+ * side.
+ */
+	int (*recv)(struct drbd_transport *, enum drbd_stream, void **buf, size_t size, int flags);
+
+/**
+ * recv_bio() - Receive bulk data via the transport's DATA_STREAM into bios
+ * @peer_device: Identify the transport and the device
+ * @bios:	the bio_list to add received data to
+ * @size:	Number of bytes to receive
+ * @misalign_bits: Out: the bitwise OR of the offset of every bvec added to
+ *		@bios, and of the length of every bvec but the last
+ *
+ * recv_bio() receives the requested amount of data from DATA_STREAM. It
+ * allocates pages by using drbd_alloc_pages() and adds them to bios in the
+ * bio_list.
+ *
+ * The core submits the bvecs to a backing device whose queue dma_alignment
+ * constrains their offset and length. Reporting @misalign_bits lets it test
+ * the payload with a single mask, and copy it into aligned pages when it has
+ * to. The length of the last bvec is the payload size the core asked for; no
+ * copy can change it, so it stays out of @misalign_bits.
+ *
+ * Upon success the function returns the bytes read. Upon error the return
+ * code is negative. A 0 indicates that the socket was closed by the remote
+ * side.
+ */
+	int (*recv_bio)(struct drbd_transport *, struct bio_list *bios, size_t size,
+			unsigned int *misalign_bits);
+
+	void (*stats)(struct drbd_transport *, struct drbd_transport_stats *stats);
+/**
+ * net_conf_change() - Notify about changed network configuration on the transport.
+ * @new_net_conf: The new network configuration that should be applied.
+ *
+ * net_conf_change() is called in the context of either the initial creation of the connection,
+ * or when the net_conf is changed via netlink. Note that assignment of the net_conf to the
+ * transport object happens after this function is called.
+ *
+ * On a negative (error) return value, it is expected that any changes are reverted and
+ * the old net_conf (if any) is still in effect.
+ *
+ * Upon success the function return 0. Upon error the function returns a negative value.
+ */
+	int (*net_conf_change)(struct drbd_transport *, struct drbd_net_conf *new_net_conf);
+	void (*set_rcvtimeo)(struct drbd_transport *, enum drbd_stream, long timeout);
+	long (*get_rcvtimeo)(struct drbd_transport *, enum drbd_stream);
+	int (*send_page)(struct drbd_transport *, enum drbd_stream, struct page *,
+			 int offset, size_t size, unsigned int msg_flags);
+	int (*send_bio)(struct drbd_transport *, struct bio *bio, unsigned int msg_flags);
+	bool (*stream_ok)(struct drbd_transport *, enum drbd_stream);
+	bool (*hint)(struct drbd_transport *, enum drbd_stream, enum drbd_tr_hints hint);
+	void (*debugfs_show)(struct drbd_transport *, struct seq_file *m);
+
+/**
+ * set_rx_alignment() - Tell the transport the alignment received payload needs
+ * @bytes:	Alignment in bytes (a power of two, at most PAGE_SIZE), or 0 if
+ *		no backing device is attached.
+ *
+ * The DRBD core submits pages received via recv_bio() to its backing devices,
+ * whose queue dma_alignment constrains the offset and length of every bvec. A
+ * transport that places received payload at sub-page offsets uses this to
+ * align it accordingly. Purely a performance hint: the core copies misaligned
+ * payload into aligned pages itself. Called whenever the set of attached
+ * backing devices changes. Optional; must not sleep.
+ */
+	void (*set_rx_alignment)(struct drbd_transport *, unsigned int bytes);
+
+/**
+ * add_path() - Prepare path to be added
+ * @path: The path that is being added
+ *
+ * Called before the path is added to the paths list.
+ *
+ * Return: 0 if path may be added, error code otherwise.
+ */
+	int (*add_path)(struct drbd_path *path);
+
+/**
+ * may_remove_path() - Query whether path may currently be removed
+ * @path: The path to be removed
+ *
+ * Return: true is path may be removed, false otherwise.
+ */
+	bool (*may_remove_path)(struct drbd_path *path);
+
+/**
+ * remove_path() - Tear down a path that is being removed
+ * @path: The path that is being removed
+ *
+ * Clean up a path that is being removed. Called with the path still on the
+ * transport's paths list and with references still held, under the same
+ * exclusivity guarantee as may_remove_path(). The transport may sleep here,
+ * e.g. to gracefully shut down an established connection, before the caller
+ * removes the path from the list and drops the remaining references.
+ */
+	void (*remove_path)(struct drbd_path *path);
+};
+
+struct drbd_transport_class {
+	const char *name;
+	const int instance_size;
+	const int path_instance_size;
+	const int listener_instance_size;
+	struct drbd_transport_ops ops;
+
+	struct module *module;
+
+	struct list_head list;
+};
+
+/*
+ * An "abstract base class" for transport implementations. I.e. it
+ * should be embedded into a transport specific representation of a
+ * listening "socket"
+ */
+struct drbd_listener {
+	struct kref kref;
+	struct drbd_resource *resource;
+	struct drbd_transport_class *transport_class;
+	struct list_head list; /* link for resource->listeners */
+	struct list_head waiters; /* list head for paths */
+	spinlock_t waiters_lock;
+	int pending_accepts;
+	struct sockaddr_storage listen_addr;
+	struct completion ready;
+	int err;
+};
+
+/* drbd_main.c */
+void drbd_destroy_path(struct kref *kref);
+
+/* drbd_transport.c */
+int drbd_register_transport_class(struct drbd_transport_class *transport_class,
+				  int version, int drbd_transport_size);
+void drbd_unregister_transport_class(struct drbd_transport_class *transport_class);
+struct drbd_transport_class *drbd_get_transport_class(const char *name);
+void drbd_put_transport_class(struct drbd_transport_class *tc);
+void drbd_print_transports_loaded(struct seq_file *seq);
+
+int drbd_get_listener(struct drbd_path *path);
+void drbd_put_listener(struct drbd_path *path);
+struct drbd_listener *drbd_listener_try_get_ref(struct drbd_path *path);
+struct drbd_path *drbd_find_path_by_addr(struct drbd_listener *listener,
+					 struct sockaddr_storage *addr);
+bool drbd_path_conflicts_by_listener(struct drbd_path *existing,
+				     struct drbd_path *candidate);
+bool drbd_stream_send_timed_out(struct drbd_transport *transport,
+				enum drbd_stream stream);
+bool drbd_should_abort_listening(struct drbd_transport *transport);
+void drbd_path_event(struct drbd_transport *transport, struct drbd_path *path);
+void drbd_listener_destroy(struct kref *kref);
+struct drbd_path *__drbd_next_path_ref(struct drbd_path *drbd_path,
+				       struct drbd_transport *transport);
+int drbd_bio_add_page(struct drbd_transport *transport, struct bio_list *bios,
+		      struct page *page, unsigned int len, unsigned int offset);
+int drbd_bio_add_page_nomerge(struct drbd_transport *transport, struct bio_list *bios,
+			      struct page *page, unsigned int len, unsigned int offset);
+
+void drbd_transport_lock(struct drbd_transport *transport);
+void drbd_transport_unlock(struct drbd_transport *transport);
+
+/* Might restart iteration, if current element is removed from list!! */
+#define for_each_path_ref(path, transport)			\
+	for (path = __drbd_next_path_ref(NULL, transport);	\
+	     path;						\
+	     path = __drbd_next_path_ref(path, transport))
+
+/* drbd_receiver.c*/
+struct page *drbd_alloc_pages(struct drbd_transport *transport, gfp_t gfp_mask, unsigned int size);
+struct page *drbd_alloc_pages_split(struct drbd_transport *transport, gfp_t gfp_mask, int *order);
+void drbd_free_page(struct drbd_transport *transport, struct page *page);
+void drbd_get_page(struct drbd_transport *transport, struct page *page);
+void drbd_control_data_ready(struct drbd_transport *transport,
+			     struct drbd_const_buffer *pool);
+void drbd_control_event(struct drbd_transport *transport,
+			enum drbd_tr_event event);
+
+/*
+ * Some helper functions to deal with our page chains.
+ */
+/* Our transports may sometimes need to only partially use a page.
+ * We need to express that somehow.  Use this struct, and "graft" it into
+ * struct page at page->lru.
+ *
+ * According to include/linux/mm.h:
+ *  | A page may be used by anyone else who does a __get_free_page().
+ *  | In this case, page_count still tracks the references, and should only
+ *  | be used through the normal accessor functions. The top bits of page->flags
+ *  | and page->virtual store page management information, but all other fields
+ *  | are unused and could be used privately, carefully. The management of this
+ *  | page is the responsibility of the one who allocated it, and those who have
+ *  | subsequently been given references to it.
+ * (we do alloc_page(), that is equivalent).
+ *
+ * Red Hat struct page is different from upstream (layout and members) :(
+ * So I am not too sure about the "all other fields", and it is not as easy to
+ * find a place where sizeof(struct drbd_page_chain) would fit on all archs and
+ * distribution-changed layouts.
+ *
+ * But (upstream) struct page also says:
+ *  | struct list_head lru;   * ...
+ *  |       * Can be used as a generic list
+ *  |       * by the page owner.
+ *
+ * On 32bit, use unsigned short for offset and size,
+ * to still fit in sizeof(page->lru).
+ */
+
+/* grafted over struct page.lru */
+struct drbd_page_chain {
+	struct page *next;	/* next page in chain, if any */
+#ifdef CONFIG_64BIT
+	unsigned int offset;	/* start offset of data within this page */
+	unsigned int size;	/* number of data bytes within this page */
+#else
+#if PAGE_SIZE > (1U<<16)
+#error "won't work."
+#endif
+	unsigned short offset;	/* start offset of data within this page */
+	unsigned short size;	/* number of data bytes within this page */
+#endif
+};
+
+static inline void dummy_for_buildbug(void)
+{
+	struct page *dummy;
+
+	BUILD_BUG_ON(sizeof(struct drbd_page_chain) > sizeof(dummy->lru));
+}
+
+#define page_chain_next(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->next)
+#define page_chain_size(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->size)
+#define page_chain_offset(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->offset)
+#define set_page_chain_next(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->next = (v))
+#define set_page_chain_size(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->size = (v))
+#define set_page_chain_offset(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->offset = (v))
+#define set_page_chain_next_offset_size(page, n, o, s)			\
+	(*((struct drbd_page_chain *)&(page)->lru) =			\
+		((struct drbd_page_chain){				\
+			.next = (n),					\
+			.offset = (o),					\
+			.size = (s),					\
+		}))
+
+#define page_chain_for_each(page) \
+	for (; page && ({ prefetch(page_chain_next(page)); 1; }); \
+			page = page_chain_next(page))
+#define page_chain_for_each_safe(page, n) \
+	for (; page && ({ n = page_chain_next(page); 1; }); page = n)
+
+#ifndef SK_CAN_REUSE
+/*
+ * This constant was introduced by Pavel Emelyanov <xemul@parallels.com> on
+ * Thu Apr 19 03:39:36 2012 +0000. Before the release of linux-3.5
+ * commit 4a17fd52 sock: Introduce named constants for sk_reuse
+ */
+#define SK_CAN_REUSE   1
+#endif
+
+#endif
diff --git a/drivers/block/drbd/drbd_transport_template.c b/drivers/block/drbd/drbd_transport_template.c
new file mode 100644
index 000000000000..02130d424e57
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport_template.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
+ */
+
+#include <linux/module.h>
+#include "drbd_transport.h"
+#include "drbd_int.h"
+
+
+MODULE_AUTHOR("xxx");
+MODULE_DESCRIPTION("xxx transport layer for DRBD");
+MODULE_LICENSE("GPL");
+
+
+struct drbd_xxx_transport {
+	struct drbd_transport transport;
+	/* xxx */
+};
+
+struct xxx_listener {
+	struct drbd_listener listener;
+	/* xxx */
+};
+
+struct xxx_waiter {
+	struct drbd_waiter waiter;
+	/* xxx */
+};
+
+static struct drbd_transport *xxx_create(struct drbd_connection *connection);
+static void xxx_free(struct drbd_transport *transport, enum drbd_tr_free_op free_op);
+static int xxx_connect(struct drbd_transport *transport);
+static int xxx_recv(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, int flags);
+static void xxx_stats(struct drbd_transport *transport, struct drbd_transport_stats *stats);
+static void xxx_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream, long timeout);
+static long xxx_get_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream);
+static int xxx_send_page(struct drbd_transport *transport, enum drbd_stream stream, struct page *page,
+		    int offset, size_t size, unsigned msg_flags);
+static bool xxx_stream_ok(struct drbd_transport *transport, enum drbd_stream stream);
+static bool xxx_hint(struct drbd_transport *transport, enum drbd_stream stream, enum drbd_tr_hints hint);
+
+
+static struct drbd_transport_class xxx_transport_class = {
+	.name = "xxx",
+	.create = xxx_create,
+	.list = LIST_HEAD_INIT(xxx_transport_class.list),
+};
+
+static struct drbd_transport_ops xxx_ops = {
+	.free = xxx_free,
+	.connect = xxx_connect,
+	.recv = xxx_recv,
+	.stats = xxx_stats,
+	.set_rcvtimeo = xxx_set_rcvtimeo,
+	.get_rcvtimeo = xxx_get_rcvtimeo,
+	.send_page = xxx_send_page,
+	.stream_ok = xxx_stream_ok,
+	.hint = xxx_hint,
+};
+
+
+static struct drbd_transport *xxx_create(struct drbd_connection *connection)
+{
+	struct drbd_xxx_transport *xxx_transport;
+
+	if (!try_module_get(THIS_MODULE))
+		return NULL;
+
+	xxx_transport = kzalloc_obj(struct drbd_xxx_transport);
+	if (!xxx_transport) {
+		module_put(THIS_MODULE);
+		return NULL;
+	}
+
+	xxx_transport->transport.ops = &xxx_ops;
+	xxx_transport->transport.connection = connection;
+
+	return &xxx_transport->transport;
+}
+
+static void xxx_free(struct drbd_transport *transport, enum drbd_tr_free_op free_op)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	/* disconnect here */
+
+	if (free_op == DESTROY_TRANSPORT) {
+		kfree(xxx_transport);
+		module_put(THIS_MODULE);
+	}
+}
+
+static int xxx_send(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, unsigned msg_flags)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return 0;
+}
+
+static int xxx_recv(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, int flags)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return 0;
+}
+
+static void xxx_stats(struct drbd_transport *transport, struct drbd_transport_stats *stats)
+{
+}
+
+static int xxx_connect(struct drbd_transport *transport)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return true;
+}
+
+static void xxx_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream, long timeout)
+{
+}
+
+static long xxx_get_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	return 0;
+}
+
+static bool xxx_stream_ok(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	return true;
+}
+
+static int xxx_send_page(struct drbd_transport *transport, enum drbd_stream stream, struct page *page,
+		    int offset, size_t size, unsigned msg_flags)
+{
+	return 0;
+}
+
+static bool xxx_hint(struct drbd_transport *transport, enum drbd_stream stream,
+		enum drbd_tr_hints hint)
+{
+	switch (hint) {
+	default: /* not implemented, but should not trigger error handling */
+		return true;
+	}
+	return true;
+}
+
+static int __init xxx_init(void)
+{
+	return drbd_register_transport_class(&xxx_transport_class);
+}
+
+static void __exit xxx_cleanup(void)
+{
+	drbd_unregister_transport_class(&xxx_transport_class);
+}
+
+module_init(xxx_init)
+module_exit(xxx_cleanup)
-- 
2.55.0

