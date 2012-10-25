Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2432D1055F68
	for <drbd-dev@lists.linbit.com>; Sat, 27 Oct 2012 11:50:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 1A9321B436A
	for <drbd-dev@lists.linbit.com>; Sat, 27 Oct 2012 11:50:04 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyLklGrobLqL for <drbd-dev@lists.linbit.com>;
	Sat, 27 Oct 2012 11:50:04 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id ECE331B4368
	for <drbd-dev@lists.linbit.com>; Sat, 27 Oct 2012 11:50:03 +0200 (CEST)
Resent-Message-ID: <20121027095003.GF16059@soda.linbit>
From: Jing Wang <windsdaemon@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	drbd-user@lists.linbit.com
Date: Thu, 25 Oct 2012 15:00:56 +0800
Message-Id: <1351148456-11129-1-git-send-email-windsdaemon@gmail.com>
Cc: Jing Wang <windsdaemon@gmail.com>
Subject: [Drbd-dev] [PATCH 1/1] drbd: check return of kmalloc in
	receive_uuids
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Signed-off-by: Jing Wang <windsdaemon@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c74ca2d..4227f38 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3076,10 +3076,14 @@ static int receive_sizes(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned
 static int receive_uuids(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned int data_size)
 {
 	struct p_uuids *p = &mdev->data.rbuf.uuids;
-	u64 *p_uuid;
+	u64 *p_uuid = NULL;
 	int i, updated_uuids = 0;
 
 	p_uuid = kmalloc(sizeof(u64)*UI_EXTENDED_SIZE, GFP_NOIO);
+	if (!p_uuid) {
+		dev_err(DEV, "kmalloc of p_uuid failed\n");
+		return -ENOMEM;
+	}
 
 	for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
 		p_uuid[i] = be64_to_cpu(p->uuid[i]);
-- 
1.7.5.4

