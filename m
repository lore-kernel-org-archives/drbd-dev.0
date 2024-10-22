Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m24105.xmail.ntesmail.com (mail-m24105.xmail.ntesmail.com
	[45.195.24.105])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C837242006B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Oct 2024 13:46:57 +0200 (CEST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] drbd: Fix seq_num numeric conversion error
Date: Tue, 22 Oct 2024 19:41:51 +0800
Message-Id: <20241022114151.8050-1-zhengbing.huang@easystack.cn>
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

seq_num is a 32-bit value and should not be converted with be64_to_cpu().

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 4f0670f42..4d3ab28b3 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2217,7 +2217,7 @@ static void p_req_detail_from_pi(struct drbd_connection *connection,
 
 	d->sector = be64_to_cpu(p->p_data.sector);
 	d->block_id = p->p_data.block_id;
-	d->peer_seq = be64_to_cpu(p->p_data.seq_num);
+	d->peer_seq = be32_to_cpu(p->p_data.seq_num);
 	d->dp_flags = be32_to_cpu(p->p_data.dp_flags);
 	d->length = pi->size;
 	d->bi_size = is_trim_or_zeroes ? be32_to_cpu(p->size) : pi->size - digest_size;
-- 
2.17.1

