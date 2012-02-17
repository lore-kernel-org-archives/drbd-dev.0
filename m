Return-Path: <florian@hastexo.com>
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com
	[209.85.215.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 305D6104C140
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2012 16:11:30 +0100 (CET)
Received: by eaan10 with SMTP id n10so1658879eaa.27
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2012 07:11:30 -0800 (PST)
MIME-Version: 1.0
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 17 Feb 2012 16:10:04 +0100
Message-Id: <1329491404-15769-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1329491404-15769-1-git-send-email-florian@hastexo.com>
References: <1329491404-15769-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH] Pacemaker integration: add fencing handler that
	uses stonith_admin
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 drbd.spec.in                        |    1 +
 scripts/Makefile.in                 |    1 +
 scripts/stonith_admin-fence-peer.sh |   43 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 scripts/stonith_admin-fence-peer.sh

diff --git a/drbd.spec.in b/drbd.spec.in
index ba250bd..2b52359 100644
--- a/drbd.spec.in
+++ b/drbd.spec.in
@@ -185,6 +185,7 @@ Pacemaker High Availability cluster manager.
 %defattr(755,root,root,-)
 %{_prefix}/lib/%{name}/crm-fence-peer.sh
 %{_prefix}/lib/%{name}/crm-unfence-peer.sh
+%{_prefix}/lib/%{name}/stonith_admin-fence-peer.sh
 %{_prefix}/lib/ocf/resource.d/linbit/drbd
 %endif # with pacemaker
 
diff --git a/scripts/Makefile.in b/scripts/Makefile.in
index 21c6c35..d89fd9e 100644
--- a/scripts/Makefile.in
+++ b/scripts/Makefile.in
@@ -69,6 +69,7 @@ ifeq ($(WITH_UTILS),yes)
 	install -m 755 outdate-peer.sh $(DESTDIR)$(LIBDIR)
 	install -m 755 snapshot-resync-target-lvm.sh $(DESTDIR)$(LIBDIR)
 	install -m 755 notify.sh $(DESTDIR)$(LIBDIR)
+	install -m 755 stonith_admin-fence-peer.sh $(DESTDIR)$(LIBDIR)
 	( set -e ; cd $(DESTDIR)$(LIBDIR) ;\
 	  $(LN_S) -f snapshot-resync-target-lvm.sh unsnapshot-resync-target-lvm.sh ;\
 	  $(LN_S) -f notify.sh notify-split-brain.sh ;\
diff --git a/scripts/stonith_admin-fence-peer.sh b/scripts/stonith_admin-fence-peer.sh
new file mode 100755
index 0000000..3e3a1e0
--- /dev/null
+++ b/scripts/stonith_admin-fence-peer.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# DRBD fence-peer handler for Pacemaker 1.1 clusters
+# (via stonith-ng).
+#
+# Requires that the cluster is running with STONITH
+# enabled, and has configured and functional STONITH
+# agents.
+#
+# Also requires that the DRBD disk fencing policy
+# is at least "resource-only", but "resource-and-stonith"
+# is more likely to be useful as most people will
+# use this in dual-Primary configurations.
+#
+# Returns 7 on on success (DRBD fence-peer exit code
+# for "yes, I've managed to fence this node").
+# Returns 1 on any error (undefined generic error code,
+# causes DRBD devices with the "resource-and-stonith"
+# fencing policy to remain suspended).
+
+log() {
+  local msg
+  msg="$1"
+  logger -i -t "`basename $0`" -s "$msg"
+}
+
+if [ -z "$DRBD_PEERS" ]; then
+  log "DRBD_PEERS is empty or unset, cannot continue."
+  exit 1
+fi
+
+for p in $DRBD_PEERS; do
+  stonith_admin --fence $p
+  rc=$?
+  if [ $rc -eq 0 ]; then
+    log "stonith_admin successfully fenced peer $p."
+  else
+    log "Failed to fence peer $p. stonith_admin returned $rc."
+    exit 1
+  fi
+done
+
+exit 7
-- 
1.7.5.4

