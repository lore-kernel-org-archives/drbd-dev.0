Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 644B51058017
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:46 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id b189so4738505wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:46 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:10 +0200
Message-Id: <1503609794-13233-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/17] drbd: fix race between handshake and admin
	disconnect/down
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

conn_try_disconnect() could potentialy hit the BUG_ON()
in _conn_set_state() where it iterates over _drbd_set_state()
and "asserts" via BUG_ON() that the latter was successful.

If the STATE_SENT bit was not yet visible to conn_is_valid_transition()
early in _conn_request_state(), but became visible before conn_set_state()
later in that call path, we could hit the BUG_ON() after _drbd_set_state(),
because it returned SS_IN_TRANSIENT_STATE.

To avoid that race, we better protect set_bit(SENT_STATE) with the spinlock.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2489667..5e090a1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1100,7 +1100,10 @@ static int conn_connect(struct drbd_connection *connection)
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 		mutex_lock(peer_device->device->state_mutex);
 
+	/* avoid a race with conn_request_state( C_DISCONNECTING ) */
+	spin_lock_irq(&connection->resource->req_lock);
 	set_bit(STATE_SENT, &connection->flags);
+	spin_unlock_irq(&connection->resource->req_lock);
 
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 		mutex_unlock(peer_device->device->state_mutex);
-- 
2.7.4

