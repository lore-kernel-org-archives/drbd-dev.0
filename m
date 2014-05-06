Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BFC0E101AC71
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A39D32A58C8
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:20:13 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zbfeMBRQPFa7 for <drbd-dev@lists.linbit.com>;
	Wed,  7 May 2014 12:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6EDD42A5D21
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:20:13 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ItlzuJcNbe0O for <drbd-dev@lists.linbit.com>;
	Wed,  7 May 2014 12:20:13 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3B3962A58C8
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:20:13 +0200 (CEST)
Resent-Message-ID: <20140507102013.GD32422@soda.linbit>
Date: Tue, 6 May 2014 14:28:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20140506112832.GA25561@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: silence underflow warning in
	read_in_block()
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

My static checker warns that "data_size" could be negative and underflow
the limit check.  The code looks suspicious but I don't know if it is a
real bug.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index b6c8aaf..15daf86d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1528,7 +1528,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	struct drbd_peer_request *peer_req;
 	struct page *page;
 	int dgs, ds, err;
-	int data_size = pi->size;
+	unsigned int data_size = pi->size;
 	void *dig_in = peer_device->connection->int_dig_in;
 	void *dig_vv = peer_device->connection->int_dig_vv;
 	unsigned long *data;
