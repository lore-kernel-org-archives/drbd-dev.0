Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:59 +0200
Message-Id: <1314284934-17999-64-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 063/118] drbd: Eliminated the user of
	drbd_task_to_thread()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    4 ++--
 drivers/block/drbd/drbd_main.c     |    6 ++----
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 drivers/block/drbd/drbd_worker.c   |    2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index fda9a4d..4dfbbbc 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1133,10 +1133,10 @@ extern int  drbd_thread_start(struct drbd_thread *thi);
 extern void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait);
 extern char *drbd_task_to_thread_name(struct drbd_conf *mdev, struct task_struct *task);
 #ifdef CONFIG_SMP
-extern void drbd_thread_current_set_cpu(struct drbd_conf *mdev);
+extern void drbd_thread_current_set_cpu(struct drbd_conf *mdev, struct drbd_thread *thi);
 extern void drbd_calc_cpu_mask(struct drbd_conf *mdev);
 #else
-#define drbd_thread_current_set_cpu(A) ({})
+#define drbd_thread_current_set_cpu(A, B) ({})
 #define drbd_calc_cpu_mask(A) ({})
 #endif
 extern void drbd_free_resources(struct drbd_conf *mdev);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5e9e57d..ed43cdc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -635,17 +635,15 @@ void drbd_calc_cpu_mask(struct drbd_conf *mdev)
 /**
  * drbd_thread_current_set_cpu() - modifies the cpu mask of the _current_ thread
  * @mdev:	DRBD device.
+ * @thi:	drbd_thread object
  *
  * call in the "main loop" of _all_ threads, no need for any mutex, current won't die
  * prematurely.
  */
-void drbd_thread_current_set_cpu(struct drbd_conf *mdev)
+void drbd_thread_current_set_cpu(struct drbd_conf *mdev, struct drbd_thread *thi)
 {
 	struct task_struct *p = current;
-	struct drbd_thread *thi = drbd_task_to_thread(mdev, p);
 
-	if (!expect(thi != NULL))
-		return;
 	if (!thi->reset_cpu_mask)
 		return;
 	thi->reset_cpu_mask = 0;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3f0f41f..78a05ec 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3777,7 +3777,7 @@ static void drbdd(struct drbd_conf *mdev)
 	int rv;
 
 	while (get_t_state(&mdev->tconn->receiver) == RUNNING) {
-		drbd_thread_current_set_cpu(mdev);
+		drbd_thread_current_set_cpu(mdev, &mdev->tconn->receiver);
 		if (!drbd_recv_header(mdev, &cmd, &packet_size))
 			goto err_out;
 
@@ -4568,7 +4568,7 @@ int drbd_asender(struct drbd_thread *thi)
 	current->rt_priority = 2;    /* more important than all other tasks */
 
 	while (get_t_state(thi) == RUNNING) {
-		drbd_thread_current_set_cpu(mdev);
+		drbd_thread_current_set_cpu(mdev, thi);
 		if (test_and_clear_bit(SEND_PING, &mdev->flags)) {
 			if (!drbd_send_ping(mdev)) {
 				dev_err(DEV, "drbd_send_ping has failed\n");
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f13d56c..0dbd20c 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1621,7 +1621,7 @@ int drbd_worker(struct drbd_thread *thi)
 	sprintf(current->comm, "drbd%d_worker", mdev_to_minor(mdev));
 
 	while (get_t_state(thi) == RUNNING) {
-		drbd_thread_current_set_cpu(mdev);
+		drbd_thread_current_set_cpu(mdev, thi);
 
 		if (down_trylock(&mdev->tconn->data.work.s)) {
 			mutex_lock(&mdev->tconn->data.mutex);
-- 
1.7.4.1

