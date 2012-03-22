Return-Path: <florian@hastexo.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D0351106DCC8
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 13:36:41 +0100 (CET)
Received: by mail-we0-f182.google.com with SMTP id n13so2996318wer.27
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 05:36:41 -0700 (PDT)
MIME-Version: 1.0
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 22 Mar 2012 13:30:17 +0100
Message-Id: <1332419419-29091-2-git-send-email-florian@hastexo.com>
In-Reply-To: <1332419419-29091-1-git-send-email-florian@hastexo.com>
References: <1332419419-29091-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH 1/3] User's Guide: Fix incorrect configuration
	syntax for c-plan-ahead and friends
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

It's a disk option, not net. Which may be confusing, but
we certainly don't alleviate that confusion by documenting
it incorrectly here.
---
 users-guide/administration.txt |    2 +-
 users-guide/recent-changes.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/users-guide/administration.txt b/users-guide/administration.txt
index 6d383bf..9c36bad 100644
--- a/users-guide/administration.txt
+++ b/users-guide/administration.txt
@@ -739,7 +739,7 @@ a deployment in conjunction with DRBD Proxy) is provided below:
 [source,drbd]
 ----------------------------
 resource <resource> {
-  net {
+  disk {
     c-plan-ahead 200;
     c-max-rate 10M;
     c-fill-target 15M;
diff --git a/users-guide/recent-changes.txt b/users-guide/recent-changes.txt
index f1a9765..3132fc6 100644
--- a/users-guide/recent-changes.txt
+++ b/users-guide/recent-changes.txt
@@ -366,7 +366,7 @@ following configuration options:
 [source,drbd]
 ----------------------------
 resource test {
-  net {
+  disk {
     c-plan-ahead 20;
     c-fill-target 50k;
     c-min-rate 250k;
-- 
1.7.5.4

