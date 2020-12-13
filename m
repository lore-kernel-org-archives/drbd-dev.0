Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
	[209.85.166.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 99246420636
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:12 +0100 (CET)
Received: by mail-il1-f193.google.com with SMTP id c18so12764227iln.10
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:12 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:58 -0500
Message-Id: <20201213055859.3305-8-michael.d.labriola@gmail.com>
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 7/8] drbd: don't use sched_setscheduler()
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

The sched_setscheduler() function was removed in 5.9.  Use
sched_set_fifo_low() like the mainline drbd8 module did here:

    c9ec0524 sched,drbd: Convert to sched_set_fifo*()

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd_receiver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 46368949..6fb2ec39 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -9390,13 +9390,10 @@ int drbd_ack_receiver(struct drbd_thread *thi)
 	unsigned int header_size = drbd_header_size(connection);
 	int expect   = header_size;
 	bool ping_timeout_active = false;
-	struct sched_param param = { .sched_priority = 2 };
 	struct drbd_transport *transport = &connection->transport;
 	struct drbd_transport_ops *tr_ops = transport->ops;
 
-	rv = sched_setscheduler(current, SCHED_RR, &param);
-	if (rv < 0)
-		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
+	sched_set_fifo_low(current);
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
-- 
2.17.1

