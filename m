Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:40 +0100
Message-Id: <20181220162344.8430-14-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/17] drbd: don't retry connection if peers do
	not agree on "authentication" settings
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

emma: "Unexpected data packet AuthChallenge (0x0010)"
 ava: "expected AuthChallenge packet, received: ReportProtocol (0x000b)"
      "Authentication of peer failed, trying again."

Pattern repeats.

There is no point in retrying the handshake,
if we expect to receive an AuthChallenge,
but the peer is not even configured to expect or use a shared secret.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a0fe357b68b..02a327891568 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5332,7 +5332,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	if (pi.cmd != P_AUTH_CHALLENGE) {
 		drbd_err(connection, "expected AuthChallenge packet, received: %s (0x%04x)\n",
 			 cmdname(pi.cmd), pi.cmd);
-		rv = 0;
+		rv = -1;
 		goto fail;
 	}
 
-- 
2.17.1

