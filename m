Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AD85A105630C
	for <drbd-dev@lists.linbit.com>; Wed, 24 May 2017 12:02:57 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 24 May 2017 18:02:35 +0800
Message-Id: <20170524100235.22887-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [PATCH] drbd: Fix expression to check new replication
	state
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

Only tell peers when replication link is established.

Signed-off-by: Nick Wang <nwang@suse.com>

CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com

---
 drbd/drbd-kernel-compat | 2 +-
 drbd/drbd_state.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd-kernel-compat b/drbd/drbd-kernel-compat
index bd3fb0d9..bca18431 160000
--- a/drbd/drbd-kernel-compat
+++ b/drbd/drbd-kernel-compat
@@ -1 +1 @@
-Subproject commit bd3fb0d970e496c9d374101888b15ecf3618fc8a
+Subproject commit bca18431a58fc53485d969f8745d886dd9537755
diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index 9829d94f..816b8ffe 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -3040,7 +3040,7 @@ static int w_after_state_change(struct drbd_work *w, int unused)
 
 			/* Outdated myself, or became D_UP_TO_DATE tell peers */
 			if (disk_state[NEW] >= D_INCONSISTENT && disk_state[NEW] != disk_state[OLD] &&
-			    repl_state[OLD] >= L_ESTABLISHED && repl_state[OLD] >= L_ESTABLISHED)
+			    repl_state[OLD] >= L_ESTABLISHED && repl_state[NEW] >= L_ESTABLISHED)
 				send_state = true;
 
 			/* Skipped resync with peer_device, tell others... */
-- 
2.12.0

