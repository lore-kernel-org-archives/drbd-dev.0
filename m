Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  3 Oct 2011 22:58:32 +0200
Message-Id: <1317675513-12745-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
References: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/10] drbd: remove useless kobject_uevent from
	drbd_adm_connect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Calling kobject_uevent, which may sleep, from within rcu_read_lock()
protected regions is not possible.
This particular kobject_uevent also is also wrong. It was supposed to
trigger a udev run, just in case something relevant to udev symlink
magic has changed, when adjusting runtime re-configurable settings while
we still had the "syncer conf".  It was improperly placed in connect
when we dropped the "syncer conf".  The right thing to do is probably to
call "udevadm trigger" directly in those cases where drbdadm thinks
there was a need to trigger extra udev runs.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 7926491..c475654 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2088,15 +2088,15 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&tconn->net_conf_update);
 
-	retcode = conn_request_state(tconn, NS(conn, C_UNCONNECTED), CS_VERBOSE);
-
 	rcu_read_lock();
 	idr_for_each_entry(&tconn->volumes, mdev, i) {
 		mdev->send_cnt = 0;
 		mdev->recv_cnt = 0;
-		kobject_uevent(&disk_to_dev(mdev->vdisk)->kobj, KOBJ_CHANGE);
 	}
 	rcu_read_unlock();
+
+	retcode = conn_request_state(tconn, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+
 	conn_reconfig_done(tconn);
 	drbd_adm_finish(info, retcode);
 	return 0;
-- 
1.7.4.1

