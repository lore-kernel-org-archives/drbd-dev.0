Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 550BA101AC75
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2014 11:32:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: stable@vger.kernel.org
Date: Wed, 01 Oct 2014 11:32:29 +0200
Message-ID: <2120692.Pa81LKFuHn@fat-tyre>
In-Reply-To: <026a6017e1b052f58cf908fc2f63aea7@de.mcbf.net>
References: <026a6017e1b052f58cf908fc2f63aea7@de.mcbf.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Axboe <axboe@kernel.dk>, David Mohr <david@mcbf.net>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: fix regression 'out of mem,
	failed to invoke fence-peer helper'
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

Stable info:
  This patch landed in upstream with v3.16 as commit
  bbc1c5e8ad6dfebf9d13b8a4ccdf66c92913eac9
  it should go into v3.14+

Since linux kernel 3.13, kthread_run() internally uses
wait_for_completion_killable().  We sometimes may use kthread_run()
while we still have a signal pending, which we used to kick our threads
out of potentially blocking network functions, causing kthread_run() to
mistake that as a new fatal signal and fail.

Fix: flush_signals() before kthread_run().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/drbd/drbd_nl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1b35c45..3f2e167 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -544,6 +544,12 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
        struct task_struct *opa;

        kref_get(&connection->kref);
+       /* We may just have force_sig()'ed this thread
+        * to get it out of some blocking network function.
+        * Clear signals; otherwise kthread_run(), which internally uses
+        * wait_on_completion_killable(), will mistake our pending signal
+        * for a new fatal signal and fail. */
+       flush_signals(current);
        opa = kthread_run(_try_outdate_peer_async, connection, "drbd_async_h");
        if (IS_ERR(opa)) {
                drbd_err(connection, "out of mem, failed to invoke fence-peer helper\n");
-- 
1.9.1

