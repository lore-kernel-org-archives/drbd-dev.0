Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6F5BB426837
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:39:05 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
	5b1f17b1804b1-40572aeb73cso97147505e9.3
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:39:05 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:52 +0200
Message-ID: <20230928093852.676786-6-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/5] drbd: Get rid of conn_reconfig_start() and
	conn_reconfig_done()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Originally-from: Andreas Gruenbacher <agruen@kernel.org>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 85ab6f0f9d87..5de8a6641253 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1349,28 +1349,6 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_ba
 	drbd_setup_queue_param(device, bdev, new, o);
 }
 
-/* Starts the sender thread */
-static void conn_reconfig_start(struct drbd_connection *connection)
-{
-	drbd_thread_start(&connection->sender);
-	drbd_flush_workqueue(&connection->sender_work);
-}
-
-/* if still unconfigured, stops sender again. */
-static void conn_reconfig_done(struct drbd_connection *connection)
-{
-	bool stop_threads;
-	spin_lock_irq(&connection->resource->req_lock);
-	stop_threads = connection->cstate == C_STANDALONE;
-	spin_unlock_irq(&connection->resource->req_lock);
-	if (stop_threads) {
-		/* ack_receiver thread and ack_sender workqueue are implicitly
-		 * stopped by receiver in conn_disconnect() */
-		drbd_thread_stop(&connection->receiver);
-		drbd_thread_stop(&connection->sender);
-	}
-}
-
 /* Make sure IO is suspended before calling this function(). */
 static void drbd_suspend_al(struct drbd_device *device)
 {
@@ -2382,7 +2360,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	conn_reconfig_start(connection);
+	drbd_flush_workqueue(&connection->sender_work);
 
 	mutex_lock(&connection->data.mutex);
 	mutex_lock(&connection->resource->conf_update);
@@ -2461,15 +2439,13 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	goto done;
+	goto out;
 
  fail:
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
 	free_crypto(&crypto);
 	kfree(new_net_conf);
- done:
-	conn_reconfig_done(connection);
  out:
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
  finish:
@@ -2548,7 +2524,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	connection = first_connection(adm_ctx.resource);
-	conn_reconfig_start(connection);
 
 	if (connection->cstate > C_STANDALONE) {
 		retcode = ERR_NET_CONFIGURED;
@@ -2581,8 +2556,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	((char *)new_net_conf->shared_secret)[SHARED_SECRET_MAX-1] = 0;
 
-	drbd_flush_workqueue(&connection->sender_work);
-
 	mutex_lock(&adm_ctx.resource->conf_update);
 	old_net_conf = connection->net_conf;
 	if (old_net_conf) {
@@ -2631,7 +2604,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
-	conn_reconfig_done(connection);
+	drbd_thread_start(&connection->sender);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, rv);
 	return 0;
@@ -2640,7 +2613,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	free_crypto(&crypto);
 	kfree(new_net_conf);
 
-	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
-- 
2.41.0

