Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 23 Sep 2011 16:31:25 +0200
Message-Id: <1316788285-17433-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/10] drbd: For protocol versions before 100,
	use mixed header versions
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Previous versions of drbd are using version 80 headers for all packets
short enough for protocol 80.  They support both header versions in
worker context, but only version 80 headers in asynchronous context.
For backwards compatibility, continue to use version 80 headers for
short packets before protocol version 100.

From protocol version 100 on, use the same header version for all
packets.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 99b467e..6afcfab 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -741,7 +741,8 @@ static unsigned int prepare_header(struct drbd_tconn *tconn, int vnr,
 {
 	if (tconn->agreed_pro_version >= 100)
 		return prepare_header100(buffer, cmd, size, vnr);
-	else if (tconn->agreed_pro_version >= 95)
+	else if (tconn->agreed_pro_version >= 95 &&
+		 size > DRBD_MAX_SIZE_H80_PACKET)
 		return prepare_header95(buffer, cmd, size);
 	else
 		return prepare_header80(buffer, cmd, size);
-- 
1.7.4.1

