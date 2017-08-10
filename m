Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE1211057FE7
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2017 10:20:09 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 10 Aug 2017 16:19:57 +0800
Message-Id: <20170810081957.18681-1-nwang@suse.com>
Cc: lars.ellenberg@linbit.com, jfehlig@suse.com,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [PATCH] block-drbd: Update block-drbd script to support
	modern Xen
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

The xm/xend toolstack has long been removed from Xen and replaced
with xl/libxl. The legacy xmdomain.cfg(5) configuration format is
still supported for backward compatibility, but xl.cfg(5) format
is preferred. Update the script documenation to reflect this.

When the legacy format is used, libxl places the entire target
string in $XENBUS_PATH/params, e.g. 'drbd:myresource'. To ensure
the script continues to work with the legacy configuration format,
strip any 'drbd:' prefix from the resource identifier read from
xenstore.

Signed-off-by: Jim Fehlig <jfehlig@suse.com>
Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com

---
 scripts/block-drbd | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/block-drbd b/scripts/block-drbd
index 975802b3..11ec057f 100755
--- a/scripts/block-drbd
+++ b/scripts/block-drbd
@@ -5,12 +5,16 @@
 #
 # This script implements the "drbd" VBD type. To use a DRBD resource
 # as a virtual block device, include a line similar to this in your
-# domU configuration:
+# domain xl.cfg(5) configuration:
 #
-# disk = [ 'drbd:myresource,xvda1,w' ]
+# disk = [ "vdev=vda,access=rw,script=block-drbd,target=myresource" ]
+#
+# The legacy xmdomain.cfg(5) configuration format is also supported
+#
+# disk = [ 'drbd:myresource,xvda,w' ]
 #
 # This will direct Xen to put the DRBD resource named 'myresource'
-# into the Primary role, and configure it as device xvda1 in your
+# into the Primary role, and configure it as device xvda in your
 # domU. You may use as many DRBD resources as you like. If you are
 # using DRBD in dual-Primary mode (available in DRBD versions 8.0 and
 # up), your DRBD-backed domU will be live migration capable. 
@@ -34,7 +38,6 @@
 #   made available read-only to multiple domU's, or be mounted
 #   read-only in the dom0 and be made available read-only to
 #   domU's. This is not supported by the 'drbd' VBD type.
-# - Tested, thus far, only on Debian etch with Xen 3.0.3.
 #
 # For more information about DRBD, visit http://www.drbd.org/.
 #   
@@ -246,6 +249,7 @@ case "$command" in
     if [ -n "$t" ]
     then
       p=$(xenstore_read "$XENBUS_PATH/params")
+      p=${p#drbd:}
       mode=$(xenstore_read "$XENBUS_PATH/mode")
     fi
 
-- 
2.12.0

