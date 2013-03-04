Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B19601017084
	for <drbd-dev@lists.linbit.com>; Mon,  4 Mar 2013 17:33:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id A89131B43F9
	for <drbd-dev@lists.linbit.com>; Mon,  4 Mar 2013 17:33:16 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tsu3esgZctnc for <drbd-dev@lists.linbit.com>;
	Mon,  4 Mar 2013 17:33:16 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 8931A1B43F8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Mar 2013 17:33:16 +0100 (CET)
Resent-Message-ID: <20130304163316.GB2696@soda.linbit>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9066E1017A24
	for <drbd-dev@lists.linbit.com>; Mon,  4 Mar 2013 14:22:53 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id fa10so3161389pad.27
	for <drbd-dev@lists.linbit.com>; Mon, 04 Mar 2013 05:22:52 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Date: Mon,  4 Mar 2013 21:58:16 +0900
Message-Id: <1362401911-14074-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1362401911-14074-1-git-send-email-akinobu.mita@gmail.com>
References: <1362401911-14074-1-git-send-email-akinobu.mita@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Akinobu Mita <akinobu.mita@gmail.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH -v3 08/23] drbd: rename random32() to
	prandom_u32()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Use more preferable function name which implies using a pseudo-random
number generator.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
---

No change from v2

 drivers/block/drbd/drbd_receiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a9eccfc..83c5ae0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -757,7 +757,8 @@ static struct socket *drbd_wait_for_connect(struct drbd_tconn *tconn, struct acc
 	rcu_read_unlock();
 
 	timeo = connect_int * HZ;
-	timeo += (random32() & 1) ? timeo / 7 : -timeo / 7; /* 28.5% random jitter */
+	/* 28.5% random jitter */
+	timeo += (prandom_u32() & 1) ? timeo / 7 : -timeo / 7;
 
 	err = wait_for_completion_interruptible_timeout(&ad->door_bell, timeo);
 	if (err <= 0)
@@ -953,7 +954,7 @@ retry:
 				conn_warn(tconn, "Error receiving initial packet\n");
 				sock_release(s);
 randomize:
-				if (random32() & 1)
+				if (prandom_u32() & 1)
 					goto retry;
 			}
 		}
-- 
1.8.1.2

