Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  6 Oct 2011 15:37:58 +0200
Message-Id: <1317908280-28951-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
References: <1317908280-28951-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/15] drbd: Turn no-disk-drain into
	disk-drain={yes|no}
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Change the --no-disk-drain drbdsetup command line option as well as
the no_disk_drain netlink packet.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    2 +-
 include/linux/drbd_genl.h          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1024f04..a80f064 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1181,7 +1181,7 @@ void drbd_bump_write_ordering(struct drbd_conf *mdev, enum write_ordering_e wo)
 
 	if (wo == WO_bdev_flush && !dc->disk_flushes)
 		wo = WO_drain_io;
-	if (wo == WO_drain_io && dc->no_disk_drain)
+	if (wo == WO_drain_io && !dc->disk_drain)
 		wo = WO_none;
 	rcu_read_unlock();
 	mdev->write_ordering = wo;
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index c5e7a99..96e5b18 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -126,7 +126,7 @@ GENL_struct(DRBD_NLA_DISK_CONF, 3, disk_conf,
 
 	__flg_field_def(16, GENLA_F_MANDATORY,	disk_barrier, 1)
 	__flg_field_def(17, GENLA_F_MANDATORY,	disk_flushes, 1)
-	__flg_field_def(18, GENLA_F_MANDATORY,	no_disk_drain, 0)
+	__flg_field_def(18, GENLA_F_MANDATORY,	disk_drain, 1)
 	__flg_field_def(19, GENLA_F_MANDATORY,	no_md_flush, 0)
 )
 
-- 
1.7.4.1

