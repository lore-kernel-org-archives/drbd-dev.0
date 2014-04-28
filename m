Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:35 +0200
Message-Id: <1398703415-17780-25-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 24/24] drbd: use list_first_entry_or_null in
	first_peer_device/first_connection
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

If there are no peer_devices or connections, I'd rather have NULL
than some "arbitrary" address pretending to point to a struct.

Helps to avoid hard to debug symptoms, in case we ever try to use
and dereference a drbd_connection or drbd_peer_device
where we in fact don't have any connection at all.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 297ba40..a76ceb3 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -853,7 +853,7 @@ static inline struct drbd_device *minor_to_device(unsigned int minor)
 
 static inline struct drbd_peer_device *first_peer_device(struct drbd_device *device)
 {
-	return list_first_entry(&device->peer_devices, struct drbd_peer_device, peer_devices);
+	return list_first_entry_or_null(&device->peer_devices, struct drbd_peer_device, peer_devices);
 }
 
 #define for_each_resource(resource, _resources) \
@@ -2222,7 +2222,7 @@ static inline void drbd_md_flush(struct drbd_device *device)
 
 static inline struct drbd_connection *first_connection(struct drbd_resource *resource)
 {
-	return list_first_entry(&resource->connections,
+	return list_first_entry_or_null(&resource->connections,
 				struct drbd_connection, connections);
 }
 
-- 
1.9.1

