Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
	[209.85.214.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70FC6420367
	for <drbd-dev@lists.linbit.com>; Mon, 13 Dec 2021 23:33:41 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id m24so12190772pls.10
	for <drbd-dev@lists.linbit.com>; Mon, 13 Dec 2021 14:33:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Date: Mon, 13 Dec 2021 14:33:24 -0800
Message-Id: <20211213223331.135412-11-keescook@chromium.org>
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/17] drbd: Use struct_group() to zero algs
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add a struct_group() for the algs so that memset() can correctly reason
about the size. "objdump -d" shows no changes to the executable
instructions.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/drbd/drbd_main.c     | 3 ++-
 drivers/block/drbd/drbd_protocol.h | 6 ++++--
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 07b3c6093e7d..6f450816c4fa 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -729,7 +729,8 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
 	cmd = apv >= 89 ? P_SYNC_PARAM89 : P_SYNC_PARAM;
 
 	/* initialize verify_alg and csums_alg */
-	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
+	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
+	memset(&p->algs, 0, sizeof(p->algs));
 
 	if (get_ldev(peer_device->device)) {
 		dc = rcu_dereference(peer_device->device->ldev->disk_conf);
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index dea59c92ecc1..a882b65ab5d2 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -283,8 +283,10 @@ struct p_rs_param_89 {
 
 struct p_rs_param_95 {
 	u32 resync_rate;
-	char verify_alg[SHARED_SECRET_MAX];
-	char csums_alg[SHARED_SECRET_MAX];
+	struct_group(algs,
+		char verify_alg[SHARED_SECRET_MAX];
+		char csums_alg[SHARED_SECRET_MAX];
+	);
 	u32 c_plan_ahead;
 	u32 c_delay_target;
 	u32 c_fill_target;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..6df2539e215b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3921,7 +3921,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 
 	/* initialize verify_alg and csums_alg */
 	p = pi->data;
-	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
+	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
+	memset(&p->algs, 0, sizeof(p->algs));
 
 	err = drbd_recv_all(peer_device->connection, p, header_size);
 	if (err)
-- 
2.30.2

