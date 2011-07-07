Return-Path: <mrten@ii.nl>
Received: from mail1.ii.nl (mail1.ii.nl [82.94.191.120])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 582E8105669B
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jul 2011 18:00:14 +0200 (CEST)
From: Mrten <mrten+drbd@ii.nl>
To: drbd-dev@lists.linbit.com
Date: Thu,  7 Jul 2011 17:44:20 +0200
Message-Id: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
Subject: [Drbd-dev] [PATCH 1/2] add extra paragraph about manpages/ directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 README.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/README.txt b/README.txt
index 20e664b..3dc4a18 100644
--- a/README.txt
+++ b/README.txt
@@ -72,6 +72,19 @@ of your choice, and the git version control system. The documentation
 syntax is AsciiDoc; see http://www.methods.co.nz/asciidoc/ for details
 on this format.
 
+Manpages
+--------
+
+To edit the manpages you need to check out the relevant drbd too in the same directory as 
+the drbd-documentation (adjust version number  here):
+
+-----------------------------------
+git clone git://git.drbd.org/drbd-8.3.git
+-----------------------------------
+
+Then adjust the Makefile in drbd-documentation/manpages to point to the right 
+drbd version and 'make' there will work (create symlinks).
+
 
 Submitting documentation patches
 --------------------------------
-- 
1.7.0.4

