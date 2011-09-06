Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1284310556D2
	for <drbd-dev@lists.linbit.com>; Tue,  6 Sep 2011 19:09:36 +0200 (CEST)
Resent-Message-ID: <20110906170936.GC4449@barkeeper1-xen.linbit>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 040CA10556B5
	for <drbd-dev@lists.linbit.com>; Tue,  6 Sep 2011 14:17:23 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CDE288B013
	for <drbd-dev@lists.linbit.com>; Tue,  6 Sep 2011 14:05:14 +0200 (CEST)
From: Michal Marek <mmarek@suse.cz>
To: drbd-dev@lists.linbit.com
Date: Tue,  6 Sep 2011 14:04:12 +0200
Message-Id: <1315310652-19078-1-git-send-email-mmarek@suse.cz>
Subject: [Drbd-dev] [PATCH] drbd: Fix build on bigendian
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Remove the superfluous <asm-generic/bitops/le.h> include and fix the
have_find_next_zero_bit_le test ('NULL' undeclared).

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 drbd/compat/tests/have_find_next_zero_bit_le.c |    2 +-
 drbd/drbd_bitmap.c                             |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drbd/compat/tests/have_find_next_zero_bit_le.c b/drbd/compat/tests/have_find_next_zero_bit_le.c
index 901e4b3..4338511 100644
--- a/drbd/compat/tests/have_find_next_zero_bit_le.c
+++ b/drbd/compat/tests/have_find_next_zero_bit_le.c
@@ -1,5 +1,5 @@
+#include <linux/stddef.h>
 #include <linux/bitops.h>
-#include <asm-generic/bitops/le.h>
 
 unsigned long func(void)
 {
diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
index 342aa08..4d4587e 100644
--- a/drbd/drbd_bitmap.c
+++ b/drbd/drbd_bitmap.c
@@ -30,8 +30,6 @@
 #include <linux/dynamic_debug.h>
 #include <asm/kmap_types.h>
 
-#include <asm-generic/bitops/le.h>
-
 #include "drbd_int.h"
 
 /* See the ifdefs and comments inside that header file.
-- 
1.7.6

