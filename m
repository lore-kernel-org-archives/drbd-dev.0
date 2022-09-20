Return-Path: <cuigaosheng1@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A51E94204BE
	for <drbd-dev@lists.linbit.com>;
	Tue, 20 Sep 2022 03:52:20 +0200 (CEST)
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
	<cuigaosheng1@huawei.com>
Date: Tue, 20 Sep 2022 09:52:16 +0800
Message-ID: <20220920015216.782190-3-cuigaosheng1@huawei.com>
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/2] block/drbd: remove useless comments in
	receive_DataReply()
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

All implementations of req->collision, _req_may_be_done and
drbd_fail_pending_reads have been removed, so remove the comments
in receive_DataReply() that provide no useful information.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index af4c7d65490b..c897c4572036 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2113,9 +2113,6 @@ static int receive_DataReply(struct drbd_connection *connection, struct packet_i
 	if (unlikely(!req))
 		return -EIO;
 
-	/* hlist_del(&req->collision) is done in _req_may_be_done, to avoid
-	 * special casing it there for the various failure cases.
-	 * still no race with drbd_fail_pending_reads */
 	err = recv_dless_read(peer_device, req, sector, pi->size);
 	if (!err)
 		req_mod(req, DATA_RECEIVED);
-- 
2.25.1

