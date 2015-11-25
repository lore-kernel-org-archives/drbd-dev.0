Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 95A6310562DF
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:38 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:07 +0100
Message-Id: <1448448851-10343-35-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 34/38] drbd: fix "endless" transfer log walk in
	protocol A
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Don't remember a DRBD request as ack_pending, if it is not.

In protocol A, we usually clear RQ_NET_PENDING at the same time we set
RQ_NET_SENT, so when deciding to remember it as ack_pending,
mod_rq_state needs to look at the current request state,
not at the previous state before the current modification was applied.

This should prevent advance_conn_req_ack_pending() from walking the full
transfer log just to find NULL in protocol A, which would cause serious
performance degradation with many "in-flight" requests, e.g. when
working via DRBD-proxy, or with a huge bandwidth-delay product.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 7907fb5..2255dcf 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -458,7 +458,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 			atomic_add(req->i.size >> 9, &device->ap_in_flight);
 			set_if_null_req_not_net_done(peer_device, req);
 		}
-		if (s & RQ_NET_PENDING)
+		if (req->rq_state & RQ_NET_PENDING)
 			set_if_null_req_ack_pending(peer_device, req);
 	}
 
-- 
1.9.1

