Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D81EE1057314
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jan 2018 07:27:43 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 25 Jan 2018 14:27:29 +0800
Message-Id: <20180125062729.4142-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [PATCH] drbdadm: Fix does not allocate bitmap for
	stacked res
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

In e01b8b3e, allow peer_devices without bitmap.
However, should exclude stacked resource in this
case to avoid call trace caused by no bitmap,
bitmap->bitmap_index = -1.

Call Trace when init syncing to the stacked resource:
    drbd_bmio_set_n_write+0x39/0x70 [drbd]
    drbd_bitmap_io+0x8e/0xe0 [drbd]
    bitmap_mod_after_handshake+0xcb/0x1f0 [drbd]
    receive_state+0xada/0x16c0 [drbd]
    drbd_receiver+0x3b1/0x660 [drbd]

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com
---
 user/v9/drbdadm_postparse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/user/v9/drbdadm_postparse.c b/user/v9/drbdadm_postparse.c
index 1cefd5c2..2dabba66 100644
--- a/user/v9/drbdadm_postparse.c
+++ b/user/v9/drbdadm_postparse.c
@@ -465,7 +465,8 @@ static void add_no_bitmap_opt(struct d_resource *res)
 			continue;
 
 		STAILQ_FOREACH(peer_device, &conn->peer_devices, connection_link) {
-			if (peer_device->connection->peer && peer_diskless(peer_device))
+			if (peer_device->connection->peer && !peer_device->connection->peer->lower &&
+				peer_diskless(peer_device))
 				insert_tail(&peer_device->pd_options, new_opt("bitmap", "no"));
 		}
 	}
-- 
2.12.0

