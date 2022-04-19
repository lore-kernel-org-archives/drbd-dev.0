Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2837.qiye.163.com (mail-m2837.qiye.163.com [103.74.28.37])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 02C54420193
	for <drbd-dev@lists.linbit.com>; Tue, 19 Apr 2022 14:26:46 +0200 (CEST)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	joel.colledge@linbit.com
Date: Tue, 19 Apr 2022 20:16:47 +0800
Message-Id: <20220419121647.638794-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH] drbd: fix a race of drbd_free_peer_req
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

Commit e061feb8 and 9a11ebeb5 introduce a bug to race with drbd_free_peer_req()
in got_peer_ack.

drbd_free_page_chain in drbd_finish_peer_reqs and got_peer_ack may happen
concurrently， the sequence is as follows:

drbd_finish_peer_reqs                 got_peer_ack
drbd_free_page_chain		      drbd_free_peer_req
spin_lock()
page_chain_add
spin_unlock()                         spin_lock()
				      page_chain_add
				      spin_unlock()
We can see that page_chain_add will be called twice which will lead
to crash.

Revert those two commits to ensure that drbd_free_page_chain will only
called once for one peer_req.

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_receiver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index f077f2b..8cac89b 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -653,10 +653,12 @@ static int drbd_finish_peer_reqs(struct drbd_connection *connection)
 
 		++n;
 		/* list_del not necessary, next/prev members not touched */
-		/* The callback may free peer_req. */
 		err2 = peer_req->w.cb(&peer_req->w, !!err);
 		if (!err)
 			err = err2;
+	
+		if (list_empty(&peer_req->recv_order)) {
+			drbd_free_peer_req(peer_req);
 	}
 	if (atomic_sub_and_test(n, &connection->done_ee_cnt))
 		wake_up(&connection->ee_wait);
@@ -2293,7 +2295,6 @@ static int e_end_resync_block(struct drbd_work *w, int unused)
 	}
 	dec_unacked(peer_device);
 
-	drbd_free_peer_req(peer_req);
 	return err;
 }
 
@@ -2562,7 +2563,6 @@ static int e_end_block(struct drbd_work *w, int cancel)
 
 	drbd_may_finish_epoch(peer_device->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
 
-	drbd_free_page_chain(&peer_device->connection->transport, &peer_req->page_chain, 0);
 	return err;
 }
 
-- 
1.8.3.1

