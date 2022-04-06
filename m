Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 61D524205EF
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:38 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id d7so3765585edn.11
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:38 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:14 +0200
Message-Id: <20220406190715.1938174-7-christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Uladzislau Rezki \(Sony\)" <urezki@gmail.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 6/7] drdb: Switch to kvfree_rcu() API
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: Jens Axboe <axboe@kernel.dk>
TO: Philipp Reisner <philipp.reisner@linbit.com>
TO: Jason Gunthorpe <jgg@nvidia.com>
TO: drbd-dev@lists.linbit.com
TO: linux-block@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c       | 9 +++------
 drivers/block/drbd/drbd_receiver.c | 6 ++----
 drivers/block/drbd/drbd_state.c    | 3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 074b884ec225..ad6e40864b37 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1612,8 +1612,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	synchronize_rcu();
-	kfree(old_disk_conf);
+	kvfree_rcu(old_disk_conf);
 	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
@@ -2444,8 +2443,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
@@ -2859,8 +2857,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf->disk_size = (sector_t)rs.resize_size;
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		mutex_unlock(&device->resource->conf_update);
-		synchronize_rcu();
-		kfree(old_disk_conf);
+		kvfree_rcu(old_disk_conf);
 		new_disk_conf = NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0825766ce910..5e10572a4d3e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3751,8 +3751,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		drbd_info(connection, "peer data-integrity-alg: %s\n",
 			  integrity_alg[0] ? integrity_alg : "(none)");
 
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 	return 0;
 
 disconnect_rcu_unlock:
@@ -4120,8 +4119,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 			mutex_unlock(&connection->resource->conf_update);
-			synchronize_rcu();
-			kfree(old_disk_conf);
+			kvfree_rcu(old_disk_conf);
 
 			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
 				 (unsigned long)p_usize, (unsigned long)my_usize);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..826e496821c7 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2071,8 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-		synchronize_rcu();
-		kfree(old_conf);
+		kvfree_rcu(old_conf);
 	}
 
 	if (ns_max.susp_fen) {
-- 
2.35.1

