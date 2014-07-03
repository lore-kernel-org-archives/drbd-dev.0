Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CE637101AC79
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:43:10 +0200
Message-Id: <1404376995-4877-19-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
References: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/23] drbd: debugfs: add per connection oldest
	requests
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

Information of former /sys/block/drbdX/drbd/oldest_requests
is already with higher detail in these files:
 debugfs/drbd/resource/$name/in_flight_summary,
 debugfs/drbd/resource/$name/volumes/$vnr/oldest_requests

This patch adds
 debugfs/drbd/resource/$name/connections/peer/oldest_requests

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index a4d0666..db70d6c 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -670,6 +670,13 @@ void drbd_debugfs_connection_add(struct drbd_connection *connection)
 	if (IS_ERR_OR_NULL(dentry))
 		goto fail;
 	connection->debugfs_conn_callback_history = dentry;
+
+	dentry = debugfs_create_file("oldest_requests", S_IRUSR|S_IRGRP,
+			connection->debugfs_conn, connection,
+			&connection_oldest_requests_fops);
+	if (IS_ERR_OR_NULL(dentry))
+		goto fail;
+	connection->debugfs_conn_oldest_requests = dentry;
 	return;
 
 fail:
-- 
1.9.1

