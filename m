Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:30 +0200
Message-Id: <1398703415-17780-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/24] drbd: Fix a hole in the challange-response
	connection authentication
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

In the implementation as it was, the two peers sent each other
a challenge, and expects the challenge hashed with the shared
secret back.

A attacker could simply wait for the challenge of the peer, and
send the same challenge back. Then it waits for the response, and
sends the same response back.

Prevent this by not accepting a challenge from the peer that is
the same as the challenge sent to the peer.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3fa3b78..b6c8aaf 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4846,6 +4846,12 @@ static int drbd_do_auth(struct drbd_connection *connection)
 		goto fail;
 	}
 
+	if (pi.size < CHALLENGE_LEN) {
+		drbd_err(connection, "AuthChallenge payload too small.\n");
+		rv = -1;
+		goto fail;
+	}
+
 	peers_ch = kmalloc(pi.size, GFP_NOIO);
 	if (peers_ch == NULL) {
 		drbd_err(connection, "kmalloc of peers_ch failed\n");
@@ -4859,6 +4865,12 @@ static int drbd_do_auth(struct drbd_connection *connection)
 		goto fail;
 	}
 
+	if (!memcmp(my_challenge, peers_ch, CHALLENGE_LEN)) {
+		drbd_err(connection, "Peer presented the same challenge!\n");
+		rv = -1;
+		goto fail;
+	}
+
 	resp_size = crypto_hash_digestsize(connection->cram_hmac_tfm);
 	response = kmalloc(resp_size, GFP_NOIO);
 	if (response == NULL) {
-- 
1.9.1

