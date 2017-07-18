Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D87CF1057FE2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 11:14:02 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 70D7CAB22
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 09:14:02 +0000 (UTC)
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: drbd-dev@lists.linbit.com
Date: Tue, 18 Jul 2017 11:13:50 +0200
Message-Id: <20170718091350.16310-1-bwiedemann@suse.de>
In-Reply-To: <20170718083536.13668-1-bwiedemann@suse.de>
References: <20170718083536.13668-1-bwiedemann@suse.de>
Subject: [Drbd-dev] [PATCH] drbd: Allow to override build date (v2)
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

and to not record build user and hostname if requested
in order to allow for reproducible builds.
See https://reproducible-builds.org/ for why this is good
and https://reproducible-builds.org/specs/source-date-epoch/
for the definition of this variable.
---
 drbd/Kbuild | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drbd/Kbuild b/drbd/Kbuild
index 2d1b4d0..9898e93 100644
--- a/drbd/Kbuild
+++ b/drbd/Kbuild
@@ -134,5 +134,10 @@ $(obj)/drbd_buildtag.c: $(filter-out drbd_buildtag.o,$(drbd-y))
 		echo >&2 "Your DRBD source tree is broken. Unpack again.";      \
 		exit 1;								\
 	fi ;									\
-	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
+	if [ -z "${SOURCE_DATE_EPOCH}" ] ; then \
+		buildinfo="build by $$USER@$$HOSTNAME, `date "+%F %T"`" ; \
+	else \
+		buildinfo="reproducible build, `date -u -d@${SOURCE_DATE_EPOCH} "+%F %T"`" ; \
+	fi ; \
+	echo -e "\t\t\" $$buildinfo\";\n}";	\
 	mv -f $@.new $@
-- 
2.12.3

