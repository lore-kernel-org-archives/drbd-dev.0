Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:33 +0200
Message-Id: <1398703415-17780-23-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 22/24] drbd: Test cstate while holding req_lock
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

In case a connection transitions into C_TIMEOUT within the timer
function (request_timer_fn()) we need to make sure that the receiver
thread (potentially running on a different CPU) sees the updated
cstate later on.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 3 ++-
 include/linux/drbd.h         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b4fc401..f4d3aff 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -442,12 +442,13 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	char *ex_to_string;
 	int r;
 
+	spin_lock_irq(&connection->resource->req_lock);
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		drbd_err(connection, "Expected cstate < C_WF_REPORT_PARAMS\n");
+		spin_unlock_irq(&connection->resource->req_lock);
 		return false;
 	}
 
-	spin_lock_irq(&connection->resource->req_lock);
 	connect_cnt = connection->connect_cnt;
 	spin_unlock_irq(&connection->resource->req_lock);
 
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index fffd4b8..3dbe9bd 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -52,7 +52,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.4"
+#define REL_VERSION "8.4.3"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
1.9.1

