Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E1721057FF0
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jul 2017 21:50:19 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id EB75CAAB9
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jul 2017 19:50:18 +0000 (UTC)
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 Jul 2017 21:49:58 +0200
Message-Id: <20170717194958.22787-1-bwiedemann@suse.de>
Subject: [Drbd-dev] [PATCH] [RFC] drbd: do not record build details
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

such as user, hostname and build date
to allow reproducible builds

See https://reproducible-builds.org/ for why this matters.

---
Note: There are plenty alternatives to this patch
but this one was the easiest to write for me
to have a fully reproducible build
and is meant as a base for discussing how to fix this part.
E.g. it could involve a [ -z "${SOURCE_DATE_EPOCH" ] || ...
---
 drbd/Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/Kbuild b/drbd/Kbuild
index 2d1b4d0..08def4e 100644
--- a/drbd/Kbuild
+++ b/drbd/Kbuild
@@ -134,5 +134,5 @@ $(obj)/drbd_buildtag.c: $(filter-out drbd_buildtag.o,$(drbd-y))
 		echo >&2 "Your DRBD source tree is broken. Unpack again.";      \
 		exit 1;								\
 	fi ;									\
-	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
+	echo -e "\t\t\" reproducible build\";\n}";	\
 	mv -f $@.new $@
-- 
2.12.3

