Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 80C9410518AB
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:28 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:36 +0100
Message-Id: <1448448851-10343-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/38] drbd: De-inline drbd_should_do_remote()
	and drbd_should_send_out_of_sync()
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

From: Andreas Gruenbacher <agruen@linbit.com>

There is no need to have these two as inline functions.  In addition,
drbd_should_send_out_of_sync() is only used in a single place, anyway.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 18 ++++++++++++++++++
 drivers/block/drbd/drbd_req.h | 17 +----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3ae2c00..55fca68 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1095,6 +1095,24 @@ static bool do_remote_read(struct drbd_request *req)
 	return false;
 }
 
+bool drbd_should_do_remote(union drbd_dev_state s)
+{
+	return s.pdsk == D_UP_TO_DATE ||
+		(s.pdsk >= D_INCONSISTENT &&
+		 s.conn >= C_WF_BITMAP_T &&
+		 s.conn < C_AHEAD);
+	/* Before proto 96 that was >= CONNECTED instead of >= C_WF_BITMAP_T.
+	   That is equivalent since before 96 IO was frozen in the C_WF_BITMAP*
+	   states. */
+}
+
+static bool drbd_should_send_out_of_sync(union drbd_dev_state s)
+{
+	return s.conn == C_AHEAD || s.conn == C_WF_BITMAP_S;
+	/* pdsk = D_INCONSISTENT as a consequence. Protocol 96 check not necessary
+	   since we enter state C_AHEAD only if proto >= 96 */
+}
+
 /* returns number of connections (== 1, for drbd 8.4)
  * expected to actually write this data,
  * which does NOT include those that we are L_AHEAD for. */
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 9f6a040..bb2ef78 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -331,21 +331,6 @@ static inline int req_mod(struct drbd_request *req,
 	return rv;
 }
 
-static inline bool drbd_should_do_remote(union drbd_dev_state s)
-{
-	return s.pdsk == D_UP_TO_DATE ||
-		(s.pdsk >= D_INCONSISTENT &&
-		 s.conn >= C_WF_BITMAP_T &&
-		 s.conn < C_AHEAD);
-	/* Before proto 96 that was >= CONNECTED instead of >= C_WF_BITMAP_T.
-	   That is equivalent since before 96 IO was frozen in the C_WF_BITMAP*
-	   states. */
-}
-static inline bool drbd_should_send_out_of_sync(union drbd_dev_state s)
-{
-	return s.conn == C_AHEAD || s.conn == C_WF_BITMAP_S;
-	/* pdsk = D_INCONSISTENT as a consequence. Protocol 96 check not necessary
-	   since we enter state C_AHEAD only if proto >= 96 */
-}
+extern bool drbd_should_do_remote(union drbd_dev_state);
 
 #endif
-- 
1.9.1

