Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 61C66101AC79
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2014 17:53:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 30 Jun 2014 17:53:00 +0200
Message-Id: <1404143587-24344-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
References: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/18] drbd: re-add lost conf_mutex protection in
	drbd_set_role
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

The conf_update mutex used to be held while clearing the
net_conf->discard_my_data flag inside drbd_set_role.

It was moved into drbd_adm_set_role with
    drbd: allow parallel promote/demote actions
but then replaced at that location by the newly introduced adm_mutex with
    drbd: Fix a potential deadlock in drbdsetup, introduce resource->adm_mutex

And I simply forgot to put it back in at the original location.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 133e9b3..23670d8 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -661,11 +661,11 @@ drbd_set_role(struct drbd_device *const device, enum drbd_role new_role, int for
 			put_ldev(device);
 		}
 	} else {
-		/* Called from drbd_adm_set_role only.
-		 * We are still holding the conf_update mutex. */
+		mutex_lock(&device->resource->conf_update);
 		nc = connection->net_conf;
 		if (nc)
 			nc->discard_my_data = 0; /* without copy; single bit op is atomic */
+		mutex_unlock(&device->resource->conf_update);
 
 		set_disk_ro(device->vdisk, false);
 		if (get_ldev(device)) {
-- 
1.9.1

