Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2837.qiye.163.com (mail-m2837.qiye.163.com [103.74.28.37])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B1F0D4201DC
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2022 10:09:08 +0200 (CEST)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	joel.colledge@linbit.com
Date: Tue, 26 Apr 2022 16:09:03 +0800
Message-Id: <20220426080903.1831211-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH v2] drbd: fix a race of drbd_free_peer_req
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
drbd_free_page_chain                  drbd_free_peer_req
spin_lock()
page_chain_add
spin_unlock()                         spin_lock()
                                      page_chain_add
                                      spin_unlock()

We can see that page_chain_add will be called twice which will lead
to crash.

Swap drbd_may_finish_epoch() and drbd_free_page_chain() in e_end_block()
to ensure that got_peer_ack will not be called while still processing
the request in drbd_finish_peer_reqs().

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_receiver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index f077f2b..d0f42d3 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2560,9 +2560,10 @@ static int e_end_block(struct drbd_work *w, int cancel)
 	} else
 		D_ASSERT(device, drbd_interval_empty(&peer_req->i));
 
+	drbd_free_page_chain(&peer_device->connection->transport, &peer_req->page_chain, 0);
+
 	drbd_may_finish_epoch(peer_device->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
 
-	drbd_free_page_chain(&peer_device->connection->transport, &peer_req->page_chain, 0);
 	return err;
 }
 
-- 
1.8.3.1

