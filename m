Return-Path: <rui.xu@easystack.cn>
Received: from mail-m2458.qiye.163.com (mail-m2458.qiye.163.com
	[220.194.24.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70E1D4201B3
	for <drbd-dev@lists.linbit.com>; Wed, 23 Feb 2022 09:44:45 +0100 (CET)
From: Rui Xu <rui.xu@easystack.cn>
To: philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 23 Feb 2022 16:44:42 +0800
Message-Id: <20220223084442.3312409-1-rui.xu@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rui Xu <rui.xu@easystack.cn>, dongsheng.yang@easystack.cn
Subject: [Drbd-dev] [PATCH] drbd: fix a bug of do_change_disk_state when
	attach
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

There is a bug in do_change_disk_state when attach disk to
drbd. Consider this scenario:

Primary: node-1, Secondary: node-2, node-3

(1) Network failure occurs on node-1 so that node-2 and
node-3 will lose connection to node-1

(2) Detach the disk of drbd on node-2 use 'drbdadm detach'

(3) Attach the disk of drbd on node-2 use 'drbdadm attach'

we can see that disk state of node-2 will stay in the negotiating
and miss a handshake with node-3, what causes this is when we attach,
disk state will going to negotiating from attaching, we will determine
whether a two-pc is required in do_change_disk_state, since we lose the
connection with node-1 and node-1 was first connection, connection->agreeed
_pro_version will less than 110, at last, we will not do a two-pc, which
leads a problem that node-3 will not send p_state to node-2, then node-2 miss
a handshake with node-3 and the disk state of node-2 will not change.

Fix it by using supports_two_phase_commit to determine whether a two-pc is
really required.

Signed-off-by: Rui Xu <rui.xu@easystack.cn>
---
 drbd/drbd_state.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index aeaf36a..2cb501d 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -5173,10 +5173,7 @@ static bool do_change_disk_state(struct change_context *context, enum change_pha
 	if (device->disk_state[NOW] == D_ATTACHING &&
 	    context->val.disk == D_NEGOTIATING) {
 		if (device_has_peer_devices_with_disk(device)) {
-			struct drbd_connection *connection =
-				first_connection(device->resource);
-			cluster_wide_state_change =
-				connection && connection->agreed_pro_version >= 110;
+			cluster_wide_state_change = supports_two_phase_commit(device->resource);
 		} else {
 			/* very last part of attach */
 			context->val.disk = disk_state_from_md(device);
-- 
1.8.3.1

