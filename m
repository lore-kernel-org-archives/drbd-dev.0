Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1777C1057FD4
	for <drbd-dev@lists.linbit.com>; Sun, 23 Jul 2017 17:58:19 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 41B6DAAB6
	for <drbd-dev@lists.linbit.com>; Sun, 23 Jul 2017 15:58:18 +0000 (UTC)
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: drbd-dev@lists.linbit.com
Date: Sun, 23 Jul 2017 17:57:51 +0200
Message-Id: <20170723155751.16226-1-bwiedemann@suse.de>
In-Reply-To: <20170718124813.31529-1-bwiedemann@suse.de>
References: <20170718124813.31529-1-bwiedemann@suse.de>
Cc: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: [Drbd-dev] [PATCH] drbd-utils: Allow to override build date
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
 user/shared/Makefile.in | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/user/shared/Makefile.in b/user/shared/Makefile.in
index cce7c1bc..596bcf81 100644
--- a/user/shared/Makefile.in
+++ b/user/shared/Makefile.in
@@ -84,7 +84,12 @@ drbd_buildtag.c:
 	else									\
 		grep return $@ ;						\
 	fi ;									\
-	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
+	if [ -z "${WANT_DRBD_REPRODUCIBLE_BUILD}" ] || [ -z "${SOURCE_DATE_EPOCH}" ] ; then \
+		buildinfo="build by $$USER@$$HOSTNAME, `date "+%F %T"`" ; \
+	else \
+		buildinfo="reproducible build, `date -u -d@${SOURCE_DATE_EPOCH} "+%F %T"`" ; \
+	fi ; \
+	echo -e "\t\t\" $$buildinfo\";\n}";	\
 	mv -f $@.new $@
 
 drbdmeta_scanner.c: drbdmeta_scanner.fl drbdmeta_parser.h
-- 
2.12.3

