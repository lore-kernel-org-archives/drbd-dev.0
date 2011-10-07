Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  7 Oct 2011 13:27:41 +0200
Message-Id: <1317986865-3706-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
References: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/12] drbd: Refer to resync-rate consistently
	throughout the code
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    6 +++---
 drivers/block/drbd/drbd_main.c     |    4 ++--
 drivers/block/drbd/drbd_receiver.c |    2 +-
 include/linux/drbd_genl.h          |    2 +-
 include/linux/drbd_limits.h        |    7 ++++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index fa36757..8026ada 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -389,21 +389,21 @@ struct p_barrier_ack {
 } __packed;
 
 struct p_rs_param {
-	u32 rate;
+	u32 resync_rate;
 
 	      /* Since protocol version 88 and higher. */
 	char verify_alg[0];
 } __packed;
 
 struct p_rs_param_89 {
-	u32 rate;
+	u32 resync_rate;
         /* protocol version 89: */
 	char verify_alg[SHARED_SECRET_MAX];
 	char csums_alg[SHARED_SECRET_MAX];
 } __packed;
 
 struct p_rs_param_95 {
-	u32 rate;
+	u32 resync_rate;
 	char verify_alg[SHARED_SECRET_MAX];
 	char csums_alg[SHARED_SECRET_MAX];
 	u32 c_plan_ahead;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a3154be..939d31b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -888,14 +888,14 @@ int drbd_send_sync_param(struct drbd_conf *mdev)
 
 	if (get_ldev(mdev)) {
 		dc = rcu_dereference(mdev->ldev->disk_conf);
-		p->rate = cpu_to_be32(dc->resync_rate);
+		p->resync_rate = cpu_to_be32(dc->resync_rate);
 		p->c_plan_ahead = cpu_to_be32(dc->c_plan_ahead);
 		p->c_delay_target = cpu_to_be32(dc->c_delay_target);
 		p->c_fill_target = cpu_to_be32(dc->c_fill_target);
 		p->c_max_rate = cpu_to_be32(dc->c_max_rate);
 		put_ldev(mdev);
 	} else {
-		p->rate = cpu_to_be32(DRBD_RATE_DEF);
+		p->resync_rate = cpu_to_be32(DRBD_RESYNC_RATE_DEF);
 		p->c_plan_ahead = cpu_to_be32(DRBD_C_PLAN_AHEAD_DEF);
 		p->c_delay_target = cpu_to_be32(DRBD_C_DELAY_TARGET_DEF);
 		p->c_fill_target = cpu_to_be32(DRBD_C_FILL_TARGET_DEF);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e4e8f8a..684f795 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3221,7 +3221,7 @@ static int receive_SyncParam(struct drbd_tconn *tconn, struct packet_info *pi)
 		old_disk_conf = mdev->ldev->disk_conf;
 		*new_disk_conf = *old_disk_conf;
 
-		new_disk_conf->resync_rate = be32_to_cpu(p->rate);
+		new_disk_conf->resync_rate = be32_to_cpu(p->resync_rate);
 	}
 
 	if (apv >= 88) {
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index 1d707f9..4d76d0a 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -115,7 +115,7 @@ GENL_struct(DRBD_NLA_DISK_CONF, 3, disk_conf,
 	__u32_field_def(6, GENLA_F_MANDATORY,	on_io_error, DRBD_ON_IO_ERROR_DEF)
 	__u32_field_def(7, GENLA_F_MANDATORY,	fencing, DRBD_FENCING_DEF)
 
-	__u32_field_def(8,	GENLA_F_MANDATORY,	resync_rate, DRBD_RATE_DEF)
+	__u32_field_def(8,	GENLA_F_MANDATORY,	resync_rate, DRBD_RESYNC_RATE_DEF)
 	__u32_field_def(9,	GENLA_F_MANDATORY,	resync_after, DRBD_AFTER_DEF)
 	__u32_field_def(10,	GENLA_F_MANDATORY,	al_extents, DRBD_AL_EXTENTS_DEF)
 	__u32_field_def(11,	GENLA_F_MANDATORY,	c_plan_ahead, DRBD_C_PLAN_AHEAD_DEF)
diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index f44a0b3..27f5a13 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -96,10 +96,11 @@
 
 /* syncer { */
   /* FIXME allow rate to be zero? */
-#define DRBD_RATE_MIN 1
+#define DRBD_RESYNC_RATE_MIN 1
 /* channel bonding 10 GbE, or other hardware */
-#define DRBD_RATE_MAX (4 << 20)
-#define DRBD_RATE_DEF 250  /* kb/second */
+#define DRBD_RESYNC_RATE_MAX (4 << 20)
+#define DRBD_RESYNC_RATE_DEF 250
+#define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
   /* less than 7 would hit performance unnecessarily.
    * 919 slots context information per transaction,
-- 
1.7.4.1

