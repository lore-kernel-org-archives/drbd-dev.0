Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE44F105647D
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2017 06:26:30 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 11 Aug 2017 12:26:10 +0800
Message-Id: <20170811042610.3956-1-nwang@suse.com>
Cc: lars.ellenberg@linbit.com, jfehlig@suse.com,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [PATCH] block-drbd: Fix block-drbd remove command
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

Similar to a previous fix for the add command, strip any 'drbd:'
prefix from the resource identifier read from xenstore. Otherwise
the remove command can fail, leaving the resource in Primary role.
This presents a data hazard if a VM is migrated to another host,
where the resource will also be placed in Primary role.

Signed-off-by: Jim Fehlig <jfehlig@suse.com>
Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com

---
 scripts/block-drbd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/block-drbd b/scripts/block-drbd
index 11ec057f..23364cd6 100755
--- a/scripts/block-drbd
+++ b/scripts/block-drbd
@@ -284,7 +284,7 @@ case "$command" in
     case $t in 
       drbd|phy)
         p=$(xenstore_read "$XENBUS_PATH/params")
-        drbd_resource=$p
+        drbd_resource=${p#drbd:}
         drbd_role="$(drbdadm role $drbd_resource)"
         drbd_lrole="${drbd_role%%/*}"
         drbd_dev="$(drbdadm sh-dev $drbd_resource)"
-- 
2.12.0

