Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E1C12426846
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:39:03 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
	ffacd0b85a97d-3231d67aff2so9084288f8f.0
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:51 +0200
Message-ID: <20230928093852.676786-5-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/5] drbd: Keep connection threads running while
	connection is up only
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

Connection independent work has been moved from the connection "sender" to the
resource "worker", so there no longer is a need to keep the "sender" running
when the connection is down.

Originally-from: Andreas Gruenbacher <agruen@kernel.org>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c    |  6 +-----
 drivers/block/drbd/drbd_state.c | 21 ---------------------
 drivers/block/drbd/drbd_state.h |  1 -
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9d9ced46f968..85ab6f0f9d87 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1361,8 +1361,7 @@ static void conn_reconfig_done(struct drbd_connection *connection)
 {
 	bool stop_threads;
 	spin_lock_irq(&connection->resource->req_lock);
-	stop_threads = conn_all_vols_unconf(connection) &&
-		connection->cstate == C_STANDALONE;
+	stop_threads = connection->cstate == C_STANDALONE;
 	spin_unlock_irq(&connection->resource->req_lock);
 	if (stop_threads) {
 		/* ack_receiver thread and ack_sender workqueue are implicitly
@@ -1749,7 +1748,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	peer_device = first_peer_device(device);
 	connection = peer_device->connection;
-	conn_reconfig_start(connection);
 
 	/* if you want to reconfigure, please tear down first */
 	if (device->state.disk > D_DISKLESS) {
@@ -2117,7 +2115,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 
 	kobject_uevent(&disk_to_dev(device->vdisk)->kobj, KOBJ_CHANGE);
 	put_ldev(device);
-	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2128,7 +2125,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	drbd_force_state(device, NS(disk, D_DISKLESS));
 	drbd_md_sync(device);
  fail:
-	conn_reconfig_done(connection);
 	if (nbc) {
 		close_backing_dev(device, nbc->md_bdev,
 			  nbc->disk_conf->meta_dev_idx < 0 ?
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c623769abc1a..0a901e5aca0a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -291,27 +291,6 @@ static inline bool is_susp(union drbd_state s)
         return s.susp || s.susp_nod || s.susp_fen;
 }
 
-bool conn_all_vols_unconf(struct drbd_connection *connection)
-{
-	struct drbd_peer_device *peer_device;
-	bool rv = true;
-	int vnr;
-
-	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-		struct drbd_device *device = peer_device->device;
-		if (device->state.disk != D_DISKLESS ||
-		    device->state.conn != C_STANDALONE ||
-		    device->state.role != R_SECONDARY) {
-			rv = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return rv;
-}
-
 /* Unfortunately the states where not correctly ordered, when
    they where defined. therefore can not use max_t() here. */
 static enum drbd_role max_role(enum drbd_role role1, enum drbd_role role2)
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index cbaeb8018dbf..67371bd563e4 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -142,7 +142,6 @@ conn_request_state(struct drbd_connection *connection, union drbd_state mask, un
 		   enum chg_state_flags flags);
 
 extern void drbd_resume_al(struct drbd_device *device);
-extern bool conn_all_vols_unconf(struct drbd_connection *connection);
 
 /**
  * drbd_request_state() - Request a state change
-- 
2.41.0

