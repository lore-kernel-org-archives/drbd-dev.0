Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D62B81055702
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:23:57 +0100 (CET)
Resent-Message-ID: <20111107092357.GC15431@barkeeper1-xen.linbit>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2B41C10556DA
	for <drbd-dev@lists.linbit.com>; Sun,  6 Nov 2011 17:10:29 +0100 (CET)
Received: by mail-fx0-f54.google.com with SMTP id r19so8390582faa.27
	for <drbd-dev@lists.linbit.com>; Sun, 06 Nov 2011 08:10:29 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Sun,  6 Nov 2011 17:09:56 +0100
Message-Id: <1320595796-5181-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1320595796-5181-1-git-send-email-florian@hastexo.com>
References: <1320595796-5181-1-git-send-email-florian@hastexo.com>
Cc: Florian Haas <florian@hastexo.com>
Subject: [Drbd-dev] [PATCH] build: properly create DRBD_LIB_DIR and
	DRBD_RUN_DIR
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

configure defines DRBD_LIB_DIR and DRBD_RUN_DIR to be
$localstatedir/{lib,run}/${PACKAGE_TARNAME), but "make install"

- does not create DRBD_RUN_DIR at all,
- does not define DRBD_LIB_DIR in terms of $(PACKAGE_TARNAME).

Bring the Makefile into sync with what the userland tools expect.
---
 user/Makefile.in |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/user/Makefile.in b/user/Makefile.in
index 8252f01..4a26752 100644
--- a/user/Makefile.in
+++ b/user/Makefile.in
@@ -113,7 +113,8 @@ distclean: clean
 install:
 ifeq ($(WITH_UTILS),yes)
 	install -d $(DESTDIR)/sbin/
-	install -d $(DESTDIR)$(localstatedir)/lib/drbd
+	install -d $(DESTDIR)$(localstatedir)/lib/$(PACKAGE_TARNAME)
+	install -d $(DESTDIR)$(localstatedir)/run/$(PACKAGE_TARNAME)
 	install -d $(DESTDIR)$(localstatedir)/lock
 	if getent group haclient > /dev/null 2> /dev/null ; then	\
 		install -g haclient -m 4750 drbdsetup $(DESTDIR)/sbin/ ;	\
-- 
1.7.4.1

