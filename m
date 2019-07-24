Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E8310101AC47
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 13:19:43 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id c2so43332551wrm.8
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 04:19:43 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	h16sm46109183wrv.88.2019.07.24.04.19.42
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jul 2019 04:19:43 -0700 (PDT)
Resent-Message-ID: <20190724111941.GF6697@soda.linbit>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 950EB101AC44
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 05:55:45 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id f20so11240321pgj.0
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 20:55:45 -0700 (PDT)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	axboe@kernel.dk
Date: Wed, 24 Jul 2019 11:49:16 +0800
Message-Id: <20190724034916.28703-1-baijiaju1990@gmail.com>
Cc: linux-block@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/2] block: drbd: Fix a possible null-pointer
	dereference in receive_protocol()
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

In receive_protocol(), when crypto_alloc_shash() on line 3754 fails,
peer_integrity_tfm is NULL, and error handling code is executed.
In this code, crypto_free_shash() is called with NULL, which can cause a
null-pointer dereference, because:
crypto_free_shash(NULL)
    crypto_ahash_tfm(NULL)
        "return &NULL->base"

To fix this bug, peer_integrity_tfm is checked before calling
crypto_free_shash().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..a4df2b8291f6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3807,7 +3807,8 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 disconnect_rcu_unlock:
 	rcu_read_unlock();
 disconnect:
-	crypto_free_shash(peer_integrity_tfm);
+	if (peer_integrity_tfm)
+		crypto_free_shash(peer_integrity_tfm);
 	kfree(int_dig_in);
 	kfree(int_dig_vv);
 	conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-- 
2.17.0

