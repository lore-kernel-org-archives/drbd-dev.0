Return-Path: <cvubrugier@fastmail.fm>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3D5D210556D9
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:16:16 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id F310D2035A
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:14 -0400 (EDT)
Received: from PAL-U515208D001.lacie.com (200.5-14-84.ripe.coltfrance.com
	[84.14.5.200])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5B771C00291
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:14 -0400 (EDT)
From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To: drbd-dev@lists.linbit.com
Date: Wed,  9 Sep 2015 15:16:06 +0200
Message-Id: <1441804567-2372-2-git-send-email-cvubrugier@fastmail.fm>
In-Reply-To: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
References: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
Subject: [Drbd-dev] [PATCH 1/2] drbd_endian: fix compilation error with the
	musl C library
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

drbd-utils does not build with the musl C library due to the following
define directive:

  #define BITS_PER_LONG __WORDSIZE

The musl C library does not define __WORDSIZE unless <sys/reg.h> is
included. However, including <sys/reg.h> looks weird and does not work
with old compilers.

This patch defines BITS_PER_LONG in a more portable way:

  #define BITS_PER_LONG (__SIZEOF_LONG__ * 8)

Signed-off-by: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
---
 user/shared/drbd_endian.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/user/shared/drbd_endian.h b/user/shared/drbd_endian.h
index 014516f..8d8d43e 100644
--- a/user/shared/drbd_endian.h
+++ b/user/shared/drbd_endian.h
@@ -15,7 +15,7 @@
 #include <endian.h>
 
 #ifndef BITS_PER_LONG
-# define BITS_PER_LONG __WORDSIZE
+# define BITS_PER_LONG (__SIZEOF_LONG__ * 8)
 #endif
 
 /* linux/byteorder/swab.h */
-- 
2.5.0

