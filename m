Return-Path: <cgel.zte@gmail.com>
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
	[209.85.160.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 983794201B9
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2022 10:36:45 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id bp39so1602243qtb.6
	for <drbd-dev@lists.linbit.com>; Fri, 01 Apr 2022 01:36:45 -0700 (PDT)
From: cgel.zte@gmail.com
To: philipp.reisner@linbit.com
Date: Fri,  1 Apr 2022 08:36:37 +0000
Message-Id: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, Lv Ruyi <lv.ruyi@zte.com.cn>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	Zeal Robot <zealci@zte.com.cn>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block: fix potential dereference null pointer
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

rcu_dereference may return NULL, so check the returned pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/block/drbd/drbd_req.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e1e58e91ee58..8ab6da155e2f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -577,6 +577,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		D_ASSERT(device, !(req->rq_state & RQ_NET_MASK));
 		rcu_read_lock();
 		nc = rcu_dereference(connection->net_conf);
+		if (!nc) {
+			rcu_read_unlock();
+			break;
+		}
 		p = nc->wire_protocol;
 		rcu_read_unlock();
 		req->rq_state |=
@@ -690,6 +694,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		/* close the epoch, in case it outgrew the limit */
 		rcu_read_lock();
 		nc = rcu_dereference(connection->net_conf);
+		if (!nc) {
+			rcu_read_unlock();
+			break;
+		}
 		p = nc->max_epoch_size;
 		rcu_read_unlock();
 		if (connection->current_tle_writes >= p)
-- 
2.25.1

