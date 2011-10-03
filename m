Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  3 Oct 2011 22:58:25 +0200
Message-Id: <1317675513-12745-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
References: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/10] drbd: fix setsockopt for user mode linux
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We use our own copy of kernel_setsockopt, and did not mess around with
get_fs/set_fs, since we thought we knew we would always be KERNEL_DS
anyways. Apparently not so for at least user mode linux, so put the
set_fs(KERNEL_DS) in there.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 3833d56..3080192 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1484,46 +1484,53 @@ static inline void drbd_flush_workqueue(struct drbd_conf *mdev)
 	conn_flush_workqueue(mdev->tconn);
 }
 
-/* yes, there is kernel_setsockopt, but only since 2.6.18. we don't need to
- * mess with get_fs/set_fs, we know we are KERNEL_DS always. */
+/* Yes, there is kernel_setsockopt, but only since 2.6.18.
+ * So we have our own copy of it here. */
 static inline int drbd_setsockopt(struct socket *sock, int level, int optname,
-			char __user *optval, int optlen)
+				  char *optval, int optlen)
 {
+	mm_segment_t oldfs = get_fs();
+	char __user *uoptval;
 	int err;
+
+	uoptval = (char __user __force *)optval;
+
+	set_fs(KERNEL_DS);
 	if (level == SOL_SOCKET)
-		err = sock_setsockopt(sock, level, optname, optval, optlen);
+		err = sock_setsockopt(sock, level, optname, uoptval, optlen);
 	else
-		err = sock->ops->setsockopt(sock, level, optname, optval,
+		err = sock->ops->setsockopt(sock, level, optname, uoptval,
 					    optlen);
+	set_fs(oldfs);
 	return err;
 }
 
 static inline void drbd_tcp_cork(struct socket *sock)
 {
-	int __user val = 1;
+	int val = 1;
 	(void) drbd_setsockopt(sock, SOL_TCP, TCP_CORK,
-			(char __user *)&val, sizeof(val));
+			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_uncork(struct socket *sock)
 {
-	int __user val = 0;
+	int val = 0;
 	(void) drbd_setsockopt(sock, SOL_TCP, TCP_CORK,
-			(char __user *)&val, sizeof(val));
+			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_nodelay(struct socket *sock)
 {
-	int __user val = 1;
+	int val = 1;
 	(void) drbd_setsockopt(sock, SOL_TCP, TCP_NODELAY,
-			(char __user *)&val, sizeof(val));
+			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_quickack(struct socket *sock)
 {
-	int __user val = 2;
+	int val = 2;
 	(void) drbd_setsockopt(sock, SOL_TCP, TCP_QUICKACK,
-			(char __user *)&val, sizeof(val));
+			(char*)&val, sizeof(val));
 }
 
 void drbd_bump_write_ordering(struct drbd_conf *mdev, enum write_ordering_e wo);
-- 
1.7.4.1

