Return-Path: <duan.zhang@easystack.cn>
Received: from m9784.mail.qiye.163.com (m9784.mail.qiye.163.com
	[220.181.97.84])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 029874202DB
	for <drbd-dev@lists.linbit.com>; Wed, 18 Nov 2020 09:46:22 +0100 (CET)
From: Zhang Duan <duan.zhang@easystack.cn>
To: philipp.reisner@linbit.com
Message-ID: <859ad180-0e92-5542-4d52-730589e99682@easystack.cn>
Date: Wed, 18 Nov 2020 16:46:21 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/2] drbd: delay resync start unless source has
 transferred to L_SYNC_SOURCE
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

drbd_start_resync may be rescheduled due to down_trylock failure, leaves a
state of L_WF_BITMAP_S while target state is L_SYNC_TARGET and already has
sent its resync request. Then, resync going on while the source is 
L_WF_BITMAP_S
will lead to data lose by time sequence below:

L_WF_BITMAP_S                   L_SYNC_TARGET
                                 resync request(sector A)
reply old data(A)               read & write old data(A)
new IO(A)
send oos(A)                     set oos(A)
A is at new version             resync write A done
                                 set in sync(A) but A is at old version

Signed-off-by: ZhangDuan <duan.zhang@easystack.cn>
---
  drbd/drbd_receiver.c | 9 +++++++++
  1 file changed, 9 insertions(+)

diff --git drbd/drbd_receiver.c drbd/drbd_receiver.c
index a31e44b2..7a9ce4d0 100644
--- drbd/drbd_receiver.c
+++ drbd/drbd_receiver.c
@@ -3301,6 +3301,15 @@ static int receive_DataRequest(struct 
drbd_connection *connection, struct packet
  		return ignore_remaining_packet(connection, pi->size);
  	}
  +	/* Tell target to have a retry, waiting for the rescheduled
+	 * drbd_start_resync to complete. Otherwise the concurrency
+	 * of send oos and resync may lead to a data lose. */
+	if ((pi->cmd == P_RS_DATA_REQUEST || pi->cmd == P_CSUM_RS_REQUEST) &&
+			peer_device->repl_state[NOW] == L_WF_BITMAP_S) {
+		drbd_send_ack_rp(peer_device, P_RS_CANCEL, p);
+		return ignore_remaining_packet(connection, pi->size);
+	}
+	
  	peer_req = drbd_alloc_peer_req(peer_device, GFP_TRY);
  	err = -ENOMEM;
  	if (!peer_req)
-- 
2.24.0.windows.2


-- 
Sincerely Yours,
Zhang Duan
