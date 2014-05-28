Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ED518101AC71
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:57:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DCF9B3014F8
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:57:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vJppZp-vo5mO for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:57:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BE79D302EAE
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:57:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D276ZriJf3f9 for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:57:33 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9B8063014F8
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:57:33 +0200 (CEST)
Resent-Message-ID: <20140529215733.GD6434@soda.linbit>
Received: from mailer.skroutz.gr (mailer.skroutz.gr [185.6.78.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7DFA2101AC79
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 09:30:28 +0200 (CEST)
From: Apollon Oikonomopoulos <apoikos@debian.org>
To: drbd-dev@lists.linbit.com
Date: Wed, 28 May 2014 10:24:29 +0300
Message-Id: <1401261869-28459-1-git-send-email-apoikos@debian.org>
Cc: 749441-forwarded@bugs.debian.org, 749441@bugs.debian.org, mt@debian.org
Subject: [Drbd-dev] [PATCH drbd-utils] Fix conflicting declarations of
	my_parse()
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

my_parse() is declared as void in drbdadm_parser.c, but as int in
drbdadm_main.c. Since the return value is never used, we change the
latter to void. See also Debian bug #749441[1].

[1] https://bugs.debian.org/749441

Reported-by: Michael Tautschnig <mt@debian.org>
Signed-off-by: Apollon Oikonomopoulos <apoikos@debian.org>
---
 user/drbdadm_main.c           | 2 +-
 user/legacy-84/drbdadm_main.c | 2 +-
 user/legacy/drbdadm_main.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index b974b02..fb72a40 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -83,7 +83,7 @@ struct option general_admopt[] = {
 };
 struct option *admopt = general_admopt;
 
-extern int my_parse();
+extern void my_parse();
 extern int yydebug;
 extern FILE *yyin;
 
diff --git a/user/legacy-84/drbdadm_main.c b/user/legacy-84/drbdadm_main.c
index ba894ee..b3ae91a 100644
--- a/user/legacy-84/drbdadm_main.c
+++ b/user/legacy-84/drbdadm_main.c
@@ -129,7 +129,7 @@ struct option general_admopt[] = {
 };
 struct option *admopt = general_admopt;
 
-extern int my_parse();
+extern void my_parse();
 extern int yydebug;
 extern FILE *yyin;
 
diff --git a/user/legacy/drbdadm_main.c b/user/legacy/drbdadm_main.c
index f5710a5..ccdacb4 100644
--- a/user/legacy/drbdadm_main.c
+++ b/user/legacy/drbdadm_main.c
@@ -117,7 +117,7 @@ struct option admopt[] = {
 	{0, 0, 0, 0}
 };
 
-extern int my_parse();
+extern void my_parse();
 extern int yydebug;
 extern FILE *yyin;
 
-- 
2.0.0.rc2

