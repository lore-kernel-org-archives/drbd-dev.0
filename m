Return-Path: <zhengbing.huang@easystack.cn>
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com
	[101.71.155.98])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D2C08162251
	for <drbd-dev@lists.linbit.com>; Tue, 19 Aug 2025 07:55:07 +0200 (CEST)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] drbd: Fix the seq_num conversion error in got_OVResult()
Date: Tue, 19 Aug 2025 13:49:59 +0800
Message-ID: <20250819054959.1168661-1-zhengbing.huang@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the got_OVResult function, seq_num was converted twice by the be32_to_cpu,
which led to an abnormal value of peer_device->peer_seq.
Any subsequent use peer_device->peer_seq would result in an error.

For example, we encounter the follow error:
xxx: Timed out waiting for missing ack packets; disconnecting

So, we remove the second erroneous be32_to_cpu conversion.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index fdb6eb458..21bc84c5b 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -10743,7 +10743,7 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 		result = be32_to_cpu(p->result);
 	}
 
-	update_peer_seq(peer_device, be32_to_cpu(seq_num));
+	update_peer_seq(peer_device, seq_num);
 
 	peer_req = find_resync_request(peer_device, INTERVAL_TYPE_MASK(INTERVAL_OV_READ_TARGET),
 			sector, size, block_id);
-- 
2.43.0

