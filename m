Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:54:55 +0200
Message-Id: <1318247706-7732-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/13] drbd: protect updates to integrits_tfm by
	tconn->data->mutex
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Since we need to hold that mutex anyways to make sure the peer
gets that change in the right position in the data stream,
it makes a lot of sense to use the same mutex to ensure existence
of the tfm.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e167228..c59012f 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -848,7 +848,7 @@ struct drbd_tconn {			/* is a resource from the config file */
 	struct list_head out_of_sequence_requests;
 
 	struct crypto_hash *cram_hmac_tfm;
-	struct crypto_hash *integrity_tfm;  /* checksums we compute */
+	struct crypto_hash *integrity_tfm;  /* checksums we compute, updates protected by tconn->data->mutex */
 	struct crypto_hash *peer_integrity_tfm;  /* checksums we verify */
 	struct crypto_hash *csums_tfm;
 	struct crypto_hash *verify_tfm;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 939d31b..7c806b9 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1720,11 +1720,11 @@ int drbd_send_dblock(struct drbd_conf *mdev, struct drbd_request *req)
 	int dgs;
 	int err;
 
+	sock = &mdev->tconn->data;
+	p = drbd_prepare_command(mdev, sock);
 	dgs = (mdev->tconn->agreed_pro_version >= 87 && mdev->tconn->integrity_tfm) ?
 		crypto_hash_digestsize(mdev->tconn->integrity_tfm) : 0;
 
-	sock = &mdev->tconn->data;
-	p = drbd_prepare_command(mdev, sock);
 	if (!p)
 		return -EIO;
 	p->sector = cpu_to_be64(req->i.sector);
@@ -1793,11 +1793,12 @@ int drbd_send_block(struct drbd_conf *mdev, enum drbd_packet cmd,
 	int err;
 	int dgs;
 
+	sock = &mdev->tconn->data;
+	p = drbd_prepare_command(mdev, sock);
+
 	dgs = (mdev->tconn->agreed_pro_version >= 87 && mdev->tconn->integrity_tfm) ?
 		crypto_hash_digestsize(mdev->tconn->integrity_tfm) : 0;
 
-	sock = &mdev->tconn->data;
-	p = drbd_prepare_command(mdev, sock);
 	if (!p)
 		return -EIO;
 	p->sector = cpu_to_be64(peer_req->i.sector);
-- 
1.7.4.1

