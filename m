Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:48 +0100
Message-Id: <1364389729-17559-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/17] drbd: use sched_setscheduler()
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

It was unnoticed for some time that assigning to current->policy is
no longer sufficient to set a real time priority for a kernel thread.

Reported-by: Charlie Suffin <Charlie.Suffin@stratus.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    6 ++++--
 include/linux/drbd.h               |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a75c0b1..0f449bb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5257,9 +5257,11 @@ int drbd_asender(struct drbd_thread *thi)
 	bool ping_timeout_active = false;
 	struct net_conf *nc;
 	int ping_timeo, tcp_cork, ping_int;
+	struct sched_param param = { .sched_priority = 2 };
 
-	current->policy = SCHED_RR;  /* Make this a realtime task! */
-	current->rt_priority = 2;    /* more important than all other tasks */
+	rv = sched_setscheduler(current, SCHED_RR, &param);
+	if (rv < 0)
+		conn_err(tconn, "drbd_asender: ERROR set priority, ret=%d\n", rv);
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 3163307..1b4d4ee 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -52,7 +52,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.2"
+#define REL_VERSION "8.4.3"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
1.7.9.5

