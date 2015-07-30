Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 831B51055F44
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:09 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:53 +0200
Message-Id: <1438255314-14877-19-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/19] drbd: fix NULL deref in remember_new_state
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

The recent (not yet released) backport of the extended state broadcasts
to support the "events2" subcommand of drbdsetup had some glitches.

remember_old_state() would first count all connections with a
net_conf != NULL, then allocate a suitable array, then populate that
array with all connections found to have net_conf != NULL.

This races with the state change to C_STANDALONE,
and the NULL assignment there.

remember_new_state() then iterates over said connection array,
assuming that it would be fully populated.

But rcu_lock() just makes sure the thing some pointer points to,
if any, won't go away. It does not make the pointer itself immutable.

In fact there is no need to "filter" connections based on whether or not
they have a currently valid configuration.  Just record them always, if
they don't have a config, that's fine, there will be no change then.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 46 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index a4e4505..f022e99 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -63,11 +63,8 @@ static void count_objects(struct drbd_resource *resource,
 
 	idr_for_each_entry(&resource->devices, device, vnr)
 		(*n_devices)++;
-	for_each_connection(connection, resource) {
-		if (!has_net_conf(connection))
-			continue;
+	for_each_connection(connection, resource)
 		(*n_connections)++;
-	}
 }
 
 static struct drbd_state_change *alloc_state_change(unsigned int n_devices, unsigned int n_connections, gfp_t gfp)
@@ -108,23 +105,13 @@ struct drbd_state_change *remember_old_state(struct drbd_resource *resource, gfp
 	struct drbd_peer_device_state_change *peer_device_state_change;
 	struct drbd_connection_state_change *connection_state_change;
 
-retry:
-	rcu_read_lock();
+	/* Caller holds req_lock spinlock.
+	 * No state, no device IDR, no connections lists can change. */
 	count_objects(resource, &n_devices, &n_connections);
-	rcu_read_unlock();
 	state_change = alloc_state_change(n_devices, n_connections, gfp);
 	if (!state_change)
 		return NULL;
 
-	rcu_read_lock();
-	count_objects(resource, &n_devices, &n_connections);
-	if (n_devices != state_change->n_devices ||
-	    n_connections != state_change->n_connections) {
-		kfree(state_change);
-		rcu_read_unlock();
-		goto retry;
-	}
-
 	kref_get(&resource->kref);
 	state_change->resource->resource = resource;
 	state_change->resource->role[OLD] =
@@ -133,6 +120,17 @@ retry:
 	state_change->resource->susp_nod[OLD] = resource->susp_nod;
 	state_change->resource->susp_fen[OLD] = resource->susp_fen;
 
+	connection_state_change = state_change->connections;
+	for_each_connection(connection, resource) {
+		kref_get(&connection->kref);
+		connection_state_change->connection = connection;
+		connection_state_change->cstate[OLD] =
+			connection->cstate;
+		connection_state_change->peer_role[OLD] =
+			conn_highest_peer(connection);
+		connection_state_change++;
+	}
+
 	device_state_change = state_change->devices;
 	peer_device_state_change = state_change->peer_devices;
 	idr_for_each_entry(&resource->devices, device, vnr) {
@@ -145,8 +143,6 @@ retry:
 		for_each_connection(connection, resource) {
 			struct drbd_peer_device *peer_device;
 
-			if (!has_net_conf(connection))
-				continue;
 			peer_device = conn_peer_device(connection, device->vnr);
 			peer_device_state_change->peer_device = peer_device;
 			peer_device_state_change->disk_state[OLD] =
@@ -165,20 +161,6 @@ retry:
 		device_state_change++;
 	}
 
-	connection_state_change = state_change->connections;
-	for_each_connection(connection, resource) {
-		if (!has_net_conf(connection))
-			continue;
-		kref_get(&connection->kref);
-		connection_state_change->connection = connection;
-		connection_state_change->cstate[OLD] =
-			connection->cstate;
-		connection_state_change->peer_role[OLD] =
-			conn_highest_peer(connection);
-		connection_state_change++;
-	}
-	rcu_read_unlock();
-
 	return state_change;
 }
 
-- 
1.9.1

