Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 23FEE420634
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:11 +0100 (CET)
Received: by mail-il1-f194.google.com with SMTP id t9so12778973ilf.2
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:11 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:57 -0500
Message-Id: <20201213055859.3305-7-michael.d.labriola@gmail.com>
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 6/8] drbd: get rid of set_fs() usage
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

5.10 is getting rid of set_fs().  When I went looking through git commits
to figure out how to properly protect sendpage, what I found was this
commit from 4.13:

    10428957 drbd: ->sendpage() never needed set_fs()

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd_transport_tcp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drbd/drbd_transport_tcp.c b/drbd/drbd_transport_tcp.c
index 3b1d4273..4e076460 100644
--- a/drbd/drbd_transport_tcp.c
+++ b/drbd/drbd_transport_tcp.c
@@ -1138,7 +1138,6 @@ static int dtt_send_page(struct drbd_transport *transport, enum drbd_stream stre
 	struct drbd_tcp_transport *tcp_transport =
 		container_of(transport, struct drbd_tcp_transport, transport);
 	struct socket *socket = tcp_transport->stream[stream];
-	mm_segment_t oldfs = get_fs();
 	int len = size;
 	int err = -EIO;
 
@@ -1147,7 +1146,6 @@ static int dtt_send_page(struct drbd_transport *transport, enum drbd_stream stre
 
 	msg_flags |= MSG_NOSIGNAL;
 	dtt_update_congested(tcp_transport);
-	set_fs(KERNEL_DS);
 	do {
 		int sent;
 
@@ -1173,7 +1171,6 @@ static int dtt_send_page(struct drbd_transport *transport, enum drbd_stream stre
 		 * and add that to the while() condition below.
 		 */
 	} while (len > 0 /* THINK && peer_device->repl_state[NOW] >= L_ESTABLISHED */);
-	set_fs(oldfs);
 	clear_bit(NET_CONGESTED, &tcp_transport->transport.flags);
 
 	if (len == 0)
-- 
2.17.1

