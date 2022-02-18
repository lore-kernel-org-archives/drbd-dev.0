Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2458.qiye.163.com (mail-m2458.qiye.163.com
	[220.194.24.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C6134205EC
	for <drbd-dev@lists.linbit.com>; Fri, 18 Feb 2022 09:46:45 +0100 (CET)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Date: Fri, 18 Feb 2022 16:37:13 +0800
Message-Id: <20220218083713.3645497-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH] drbd:don't increase unacked_cnt when resync
	write error
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

In drbd_endio_write_sec_final, if a write error has occured and
protocol is not 'C', inc_unacked will be called.

But when it is a resync write, we shouldn't increase the unacked_cnt
there because of there is no corresponding dec_unacked, then unacked_cnt
will never be zero, which leads to the problem that in do_start_resync,
start_resync_timer will be added over and over again and will never end.

Fix this problem by adding a determine, when resync write error, don't
increase unacked_cnt in drbd_endio_write_sec_final.

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_sender.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_sender.c b/drbd/drbd_sender.c
index 7238730..aaccd07 100644
--- a/drbd/drbd_sender.c
+++ b/drbd/drbd_sender.c
@@ -148,7 +148,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	sector = peer_req->i.sector;
 	block_id = peer_req->block_id;
 
-	if (peer_req->flags & EE_WAS_ERROR) {
+	if ((peer_req->flags & EE_WAS_ERROR) && (block_id != ID_SYNCER)) {
                 /* In protocol != C, we usually do not send write acks.
                  * In case of a write error, send the neg ack anyways. */
                 if (!__test_and_set_bit(__EE_SEND_WRITE_ACK, &peer_req->flags))
-- 
1.8.3.1

