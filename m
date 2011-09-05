Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:21 +0200
Message-Id: <1315223145-20640-31-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 30/54] drbd: _drbd_send_zc_ee(): Return 0 upon
	success and an error code otherwise
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 39d1cd1..1b61727 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1502,16 +1502,19 @@ static int _drbd_send_zc_ee(struct drbd_conf *mdev,
 {
 	struct page *page = peer_req->pages;
 	unsigned len = peer_req->i.size;
+	int err;
 
 	/* hint all but last page with MSG_MORE */
 	page_chain_for_each(page) {
 		unsigned l = min_t(unsigned, len, PAGE_SIZE);
-		if (_drbd_send_page(mdev, page, 0, l,
-				    page_chain_next(page) ? MSG_MORE : 0))
-			return 0;
+
+		err = _drbd_send_page(mdev, page, 0, l,
+				      page_chain_next(page) ? MSG_MORE : 0);
+		if (err)
+			return err;
 		len -= l;
 	}
-	return 1;
+	return 0;
 }
 
 static u32 bio_flags_to_wire(struct drbd_conf *mdev, unsigned long bi_rw)
@@ -1636,7 +1639,7 @@ int drbd_send_block(struct drbd_conf *mdev, enum drbd_packet cmd,
 		ok = dgs == drbd_send(mdev->tconn, mdev->tconn->data.socket, dgb, dgs, 0);
 	}
 	if (ok)
-		ok = _drbd_send_zc_ee(mdev, peer_req);
+		ok = !_drbd_send_zc_ee(mdev, peer_req);
 
 	drbd_put_data_sock(mdev->tconn);
 
-- 
1.7.4.1

