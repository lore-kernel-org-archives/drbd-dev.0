Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847308;
	b=izjOL5BKoj3afAb18MSqfTuEYEMMqypxexXlLPKeY9xl3stkyuKKq3sgDQgJUDlNtGFY
	 wODIuhRYmdyHLT5DDOCxJhxLhnNDbwfeWApvhUlxeAVMzXX8gtY3DLdgkqXVWm0V9KPpR
	 4I8XNrhN3O4scMdxNNtRHbsGB2ej5QjUTlrKDklD+k4BB6Z85vGrFX9LQHv0jjydswGsC
	 0AzPnFUO/RemQa42LpPisCWQjK2bOLKCAatwUI08XB5RdtzxyPy+338NVlPmRU/PrV1nC
	 00LExA03nLeodnF4LXuqG4Szr2ORGrAzSEIl+BpcUxE5zsZHXwvWwKe72SVu5YE47JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847308;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=930Y6vfGOqM8F0xki+1nGoN6DNJqS/6qz71r9HbW45M=;
	b=1cQSjBhqjUnGUDMHhwuvM/zs9iy3ZD++Sryf2J2yYAFZC+GhPL28uYxxwtshUPGWC3qx
	 pdvCcLWuszl6kluOf/071uxdtoah3pxj7deogpVK4Q90hPN5Bj9SbcIjLfK+OYmlClXN+
	 mrnyt67np0BemK2MxFOo9Dxkw8PPVuqockiPkoqjIakugUlQtLT8L7HY9ssZQRcpxQ+ji
	 9DLfbD63d79QdcIJEiFYFxvh+LgfxGS8e4cZjf/ykuE9zgesNew4VHrElOOi41KPFFnCF
	 fB+EvbjTNcY41U6elifIHb4PSLf//Zm5tL86iUi4eEk+eWCLu29Wg3BNMNKgVLN9F1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	dkim=pass header.d=easystack.cn header.i=@easystack.cn header.a=rsa-sha256 header.s=default header.b=QbT6FP4D;
	arc=none smtp.remote-ip=210.79.60.35
Received: from mail-m6035.netease.com (mail-m6035.netease.com [210.79.60.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D2606A328
	for <drbd-dev@lists.linux.dev>; Thu,  5 Nov 2026 02:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 096D2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=easystack.cn header.i=@easystack.cn header.a=rsa-sha256 header.s=default header.b=QbT6FP4D
Received: from hzb-HP-Laptop-14s-cr2xxx.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 255e6971b;
	Thu, 5 Nov 2026 10:54:55 +0800 (GMT+08:00)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linux.dev
Cc: "zhengbing . huang" <zhengbing.huang@easystack.cn>
Subject: [PATCH] drbd: rdma/rdma2: fix control timer use-after-free on teardown
Date: Thu,  5 Nov 2026 10:54:54 +0800
Message-ID: <20261105025454.2444754-1-zhengbing.huang@easystack.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a9a17d160227kunm5f6078c294280
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUhPVkhPQxpPQh0aGR0dGlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=QbT6FP4DrUSioUgViONc9QVMepWe7NzLmO9Ln4WgjOXeObusF4ITunRmXUeRNgg9HB8jnlnY6z2YW/QJx18dPJ2sUvZjKvfhYdKl8B2nEC1XPuiIejfV16Xd49yPzAGEVcH3DxDU1F64YfBbAKM4/c7uZ71X4pjUENID1szJGeI=; s=default; c=relaxed/relaxed; d=easystack.cn; v=1;
	bh=930Y6vfGOqM8F0xki+1nGoN6DNJqS/6qz71r9HbW45M=;
	h=date:mime-version:subject:message-id:from;

Both rdma transports use a per-connection control timer to detect a
stalled control stream. dtr_set_rcvtimeo() and the rx completion path arm
it with mod_timer(). When it expires, dtr_control_timer_fn() calls
drbd_control_event(transport, TIMEOUT), which either queues
connection->send_ping_work or initiates a connection state change.

dtr_free() only removed that timer with timer_delete_sync(). That
serializes against the timer callback, but not against other contexts
arming the timer: drbd_send_ping_wf() runs on the system workqueue and
calls set_rcvtimeo() -> dtr_set_rcvtimeo() -> mod_timer() with no
synchronization against the teardown. If it runs after dtr_free()
returned, it re-arms the timer on a transport whose connection is about
to be (or already has been) freed.

Concrete example - "drbdadm down" on a node whose peer just went away:

  CPU 0 (timer softirq)                CPU 1 (admin, drbdadm down)

  control_timer expires
  dtr_control_timer_fn()
    drbd_control_event(TIMEOUT)
      schedule_work(send_ping_work)
                                       conn_disconnect()
                                       drbd_transport_shutdown()
                                         dtr_free()
                                           timer_delete_sync()
                                             -> timer deleted
                                             -> connection freed
                                             -> drbd_resource freed
  send_ping_work finally runs:
    set_rcvtimeo(PING_TIMEOUT)
      dtr_set_rcvtimeo()
        mod_timer(control_timer, ...)
          -> timer armed again on freed memory

  ... one ping timeout later ...

  dtr_control_timer_fn()
    drbd_control_event(TIMEOUT)
      change_cstate_tag()
        change_cluster_wide_state()
          ___begin_state_change(resource)
            -> oops on the freed drbd_resource

The window is easiest to hit right after a connection loss, because the
control timer tends to expire and queue the ping work just when the
administrator tears the resource down. The resulting crash looks like:

  pc : state_change_lock+0x54/0x130 [drbd]
  lr : change_cluster_wide_state+0x54/0x1120 [drbd]
  Call trace:
   state_change_lock
   change_cluster_wide_state
   change_cstate_tag
   drbd_control_event
   dtr_control_timer_fn [drbd_transport_rdma]
   call_timer_fn

Shut the timer down with timer_shutdown_sync() instead of just deleting
it: once it returns, mod_timer()/add_timer() refuse to arm the timer
again, no matter which context races with the teardown. Because the
transport object (and with it the timer) is reused for reconnects,
dtr_prepare_connect() re-initializes the timer with timer_setup().

Both arming sites also check rdma_transport->active now, so nothing arms
the timer once teardown started. This matters for kernels where the
compat layer maps timer_shutdown_sync() back to del_timer_sync(): the
late arming attempt is then a no-op instead of re-arming the timer.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_transport_rdma.c  | 12 +++++++++---
 drbd/drbd_transport_rdma2.c | 12 +++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
index 7f72377d0..2488fab82 100644
--- a/drbd/drbd_transport_rdma.c
+++ b/drbd/drbd_transport_rdma.c
@@ -492,7 +492,7 @@ static void dtr_free(struct drbd_transport *transport, enum drbd_tr_free_op free
 		}
 	}
 
-	timer_delete_sync(&rdma_transport->control_timer);
+	timer_shutdown_sync(&rdma_transport->control_timer);
 
 	if (free_op == DESTROY_TRANSPORT) {
 		list_for_each_entry(drbd_path, &transport->paths, list) {
@@ -1838,7 +1838,7 @@ static void dtr_rx_cqe_done(struct ib_cq *cq, struct ib_wc *wc)
 		smp_wmb(); /* smp_rmb() is in dtr_new_rx_descs() */
 		atomic_dec(&flow->rx_descs_known_to_peer);
 
-		if (stream == ST_CONTROL)
+		if (stream == ST_CONTROL && rdma_transport->active)
 			mod_timer(&rdma_transport->control_timer,
 				  jiffies + rdma_stream->recv_timeout);
 
@@ -2989,6 +2989,9 @@ static int dtr_prepare_connect(struct drbd_transport *transport)
 	atomic_set(&rdma_transport->first_path_connect_err, 1);
 	init_completion(&rdma_transport->connected);
 
+	/* dtr_free() shut the control timer down; make it armable again. */
+	timer_setup(&rdma_transport->control_timer, dtr_control_timer_fn, 0);
+
 	rdma_transport->active = true;
 
 	list_for_each_entry(path, &transport->paths, path.list) {
@@ -3089,7 +3092,10 @@ static void dtr_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream
 
 	rdma_transport->stream[stream].recv_timeout = timeout;
 
-	if (stream == CONTROL_STREAM)
+	/* Not armed once teardown started: the ping work that calls this can
+	 * run after dtr_free() shut the timer down (see dtr_free()).
+	 */
+	if (stream == CONTROL_STREAM && rdma_transport->active)
 		mod_timer(&rdma_transport->control_timer, jiffies + timeout);
 }
 
diff --git a/drbd/drbd_transport_rdma2.c b/drbd/drbd_transport_rdma2.c
index 2b27c71d9..e4e731560 100644
--- a/drbd/drbd_transport_rdma2.c
+++ b/drbd/drbd_transport_rdma2.c
@@ -963,7 +963,7 @@ static void dtr_free(struct drbd_transport *transport, enum drbd_tr_free_op free
 		}
 	}
 
-	timer_delete_sync(&rdma_transport->control_timer);
+	timer_shutdown_sync(&rdma_transport->control_timer);
 
 	if (free_op == DESTROY_TRANSPORT) {
 		list_for_each_entry(drbd_path, &transport->paths, list) {
@@ -2812,7 +2812,7 @@ static void dtr_rx_cqe_done(struct ib_cq *cq, struct ib_wc *wc)
 			return;
 		}
 
-		if (stream == ST_CONTROL)
+		if (stream == ST_CONTROL && rdma_transport->active)
 			mod_timer(&rdma_transport->control_timer,
 				  jiffies + rdma_stream->recv_timeout);
 
@@ -5708,6 +5708,9 @@ static int dtr_prepare_connect(struct drbd_transport *transport)
 	atomic_set(&rdma_transport->first_path_connect_err, 1);
 	init_completion(&rdma_transport->connected);
 
+	/* dtr_free() shut the control timer down; make it armable again. */
+	timer_setup(&rdma_transport->control_timer, dtr_control_timer_fn, 0);
+
 	rdma_transport->active = true;
 
 	list_for_each_entry(path, &transport->paths, path.list) {
@@ -5808,7 +5811,10 @@ static void dtr_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream
 
 	rdma_transport->stream[stream].recv_timeout = timeout;
 
-	if (stream == CONTROL_STREAM)
+	/* Not armed once teardown started: the ping work that calls this can
+	 * run after dtr_free() shut the timer down (see dtr_free()).
+	 */
+	if (stream == CONTROL_STREAM && rdma_transport->active)
 		mod_timer(&rdma_transport->control_timer, jiffies + timeout);
 }
 
-- 
2.43.0

