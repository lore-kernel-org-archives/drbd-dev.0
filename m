Return-Path: <yamagu-m@saturn.dti.ne.jp>
Received: from smtp14.dti.ne.jp (smtp14.dti.ne.jp [202.216.231.189])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D982A1087142
	for <drbd-dev@lists.linbit.com>; Fri, 28 May 2010 02:01:58 +0200 (CEST)
Message-Id: <201005272346.o4RNkutF012753@smtp14.dti.ne.jp>
Date: Fri, 28 May 2010 08:46:56 +0900
From: YAMAGUCHI Masashi <yamagu-m@saturn.dti.ne.jp>
To: drbd-dev@lists.linbit.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Drbd-dev] [PATCH] scripts/notify.sh: Fix event identification
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

"notify.sh" cannot identify the events of "notify-pri-lost.sh" and
"notify-pri-lost-after-sb.sh" so the mails sent by these scripts are
treated as "Unspecified DRBD notification".

--- drbd/scripts/notify.sh
+++ drbd/scripts/notify.sh
@@ -53,14 +53,14 @@
 on $DRBD_LOCAL_HOST.
 Please see the system logs for details."
 		;;
-	*pri-lost)
+	*pri-lost.sh)
 		SUBJECT="DRBD resource $DRBD_RESOURCE is currently Primary, but is to become SyncTarget on $DRBD_LOCAL_HOST"
 		BODY="
 The DRBD resource $DRBD_RESOURCE is currently in the Primary
 role on host $DRBD_LOCAL_HOST, but lost the SyncSource election
 process."
 		;;
-	*pri-lost-after-sb)
+	*pri-lost-after-sb.sh)
 		SUBJECT="DRBD resource $DRBD_RESOURCE is currently Primary, but lost split brain auto recovery on $DRBD_LOCAL_HOST"
 		BODY="
 The DRBD resource $DRBD_RESOURCE is currently in the Primary

---
Masashi YAMAGUCHI
