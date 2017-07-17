Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 312171057FD4
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jul 2017 21:43:49 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 58E1CAAB9
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jul 2017 19:29:34 +0000 (UTC)
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 Jul 2017 21:29:30 +0200
Message-Id: <20170717192930.21694-1-bwiedemann@suse.de>
Subject: [Drbd-dev] [PATCH] drbd: sort file list
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

because it influences the ordering of entries in compat.h
which influences srcversion= checksum
which prevents drbd.ko from building reproducibly.

See https://reproducible-builds.org/ for why this matters.
---
 drbd/Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/Kbuild b/drbd/Kbuild
index 2d1b4d0..c5787a6 100644
--- a/drbd/Kbuild
+++ b/drbd/Kbuild
@@ -70,7 +70,7 @@ COMPAT_FORCE := FORCE
 endif
 
 ifneq ($(KBUILD_STAGE),modpost)
-TEST_C := $(wildcard $(src)/drbd-kernel-compat/tests/*.c)
+TEST_C := $(sort $(wildcard $(src)/drbd-kernel-compat/tests/*.c))
 TEST_R := $(TEST_C:$(src)/drbd-kernel-compat/tests/%.c=$(obj)/.compat_test.%.result)
 $(obj)/.compat_test.%.result: $(src)/drbd-kernel-compat/tests/%.c $(COMPAT_FORCE)
 	$(call cmd,compat_test_result)
-- 
2.12.3

