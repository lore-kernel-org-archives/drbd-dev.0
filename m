Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B25B2105EC2D
	for <drbd-dev@lists.linbit.com>; Sun, 23 May 2010 22:13:21 +0200 (CEST)
Resent-Message-ID: <20100523201321.GH14070@soda.linbit>
MIME-Version: 1.0
Date: Tue, 18 May 2010 13:30:16 +0800
Message-ID: <AANLkTinX8Ax9ZJFdLk3Zjzc0CBh-gIIN0wg8YjQ-7PQP@mail.gmail.com>
From: Steven Liu <lingjiujianke@gmail.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com,
	linux-kernel@vger.kernel.org, liuqi@thunderst.com
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Drbd-dev] [PATCH] drbd: Check-kmalloc-return-value before use it
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Check-kmalloc-return-value before use it

Signed-off-by: Liu Qi <lingjiujianke@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c
b/drivers/block/drbd/drbd_receiver.c
index 3f096e7..533df04 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2977,6 +2977,10 @@ static int receive_uuids(struct drbd_conf
*mdev, struct p_header *h)
        return FALSE;

    p_uuid = kmalloc(sizeof(u64)*UI_EXTENDED_SIZE, GFP_NOIO);
+   if(p_uuid == NULL){
+       printk(KERN_ERR "Kmalloc p_uuid failed in %s \n", __func__);
+       return FALSE;
+   }

    for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
        p_uuid[i] = be64_to_cpu(p->uuid[i]);
--
1.7.1


Best regards
