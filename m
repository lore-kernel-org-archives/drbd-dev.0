Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C23701028A4A
	for <drbd-dev@lists.linbit.com>; Wed, 29 Oct 2014 17:37:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 29 Oct 2014 17:37:56 +0100
Message-Id: <1414600676-11203-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1414600676-11203-1-git-send-email-philipp.reisner@linbit.com>
References: <1414600676-11203-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 7/7] drbd: Remove an useless copy of
	kernel_setsockopt()
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

Old backward-compat cruft

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d2a7589..b905e98 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1557,52 +1557,31 @@ extern void drbd_set_recv_tcq(struct drbd_device *device, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_head *to_be_freed);
 extern int drbd_connected(struct drbd_peer_device *);
 
-/* Yes, there is kernel_setsockopt, but only since 2.6.18.
- * So we have our own copy of it here. */
-static inline int drbd_setsockopt(struct socket *sock, int level, int optname,
-				  char *optval, int optlen)
-{
-	mm_segment_t oldfs = get_fs();
-	char __user *uoptval;
-	int err;
-
-	uoptval = (char __user __force *)optval;
-
-	set_fs(KERNEL_DS);
-	if (level == SOL_SOCKET)
-		err = sock_setsockopt(sock, level, optname, uoptval, optlen);
-	else
-		err = sock->ops->setsockopt(sock, level, optname, uoptval,
-					    optlen);
-	set_fs(oldfs);
-	return err;
-}
-
 static inline void drbd_tcp_cork(struct socket *sock)
 {
 	int val = 1;
-	(void) drbd_setsockopt(sock, SOL_TCP, TCP_CORK,
+	(void) kernel_setsockopt(sock, SOL_TCP, TCP_CORK,
 			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_uncork(struct socket *sock)
 {
 	int val = 0;
-	(void) drbd_setsockopt(sock, SOL_TCP, TCP_CORK,
+	(void) kernel_setsockopt(sock, SOL_TCP, TCP_CORK,
 			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_nodelay(struct socket *sock)
 {
 	int val = 1;
-	(void) drbd_setsockopt(sock, SOL_TCP, TCP_NODELAY,
+	(void) kernel_setsockopt(sock, SOL_TCP, TCP_NODELAY,
 			(char*)&val, sizeof(val));
 }
 
 static inline void drbd_tcp_quickack(struct socket *sock)
 {
 	int val = 2;
-	(void) drbd_setsockopt(sock, SOL_TCP, TCP_QUICKACK,
+	(void) kernel_setsockopt(sock, SOL_TCP, TCP_QUICKACK,
 			(char*)&val, sizeof(val));
 }
 
-- 
1.9.1

