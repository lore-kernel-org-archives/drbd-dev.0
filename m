Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6E13910585E0
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 14:38:04 +0200 (CEST)
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com
	[172.25.105.84]) by smtp-out.google.com with ESMTP id o4HCc2iD029591
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 05:38:03 -0700
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 May 2010 14:37:58 +0200
Message-Id: <07dd832067f25c0f687b7afe1d37e2f432c74335.1274099535.git.iustin@google.com>
In-Reply-To: <cover.1274099535.git.iustin@google.com>
References: <cover.1274099535.git.iustin@google.com>
Cc: Iustin Pop <iustin@google.com>
Subject: [Drbd-dev] [PATCH 1/3] Implement before|after-resync-source in
	drbdadm
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 scripts/global_common.conf |    2 ++
 user/drbdadm_main.c        |    2 ++
 user/drbdadm_scanner.fl    |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/scripts/global_common.conf b/scripts/global_common.conf
index 5269515..ad07ce2 100644
--- a/scripts/global_common.conf
+++ b/scripts/global_common.conf
@@ -15,6 +15,8 @@ common {
 		# out-of-sync "/usr/lib/drbd/notify-out-of-sync.sh root";
 		# before-resync-target "/usr/lib/drbd/snapshot-resync-target-lvm.sh -p 15 -- -c 16k";
 		# after-resync-target /usr/lib/drbd/unsnapshot-resync-target-lvm.sh;
+		# before-resync-source /bin/true;
+		# after-resync-target /bin/true;
 	}
 
 	startup {
diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index b697fd6..38d427a 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -327,6 +327,8 @@ struct adm_cmd cmds[] = {
 
 	{"before-resync-target", adm_khelper, DRBD_acf3_handler},
 	{"after-resync-target", adm_khelper, DRBD_acf3_handler},
+	{"before-resync-source", adm_khelper, DRBD_acf3_handler},
+	{"after-resync-source", adm_khelper, DRBD_acf3_handler},
 	{"pri-on-incon-degr", adm_khelper, DRBD_acf3_handler},
 	{"pri-lost-after-sb", adm_khelper, DRBD_acf3_handler},
 	{"fence-peer", adm_khelper, DRBD_acf3_handler},
diff --git a/user/drbdadm_scanner.fl b/user/drbdadm_scanner.fl
index d4cad32..a4a9441 100644
--- a/user/drbdadm_scanner.fl
+++ b/user/drbdadm_scanner.fl
@@ -141,6 +141,8 @@ fence-peer		{ DP; CP; return TK_HANDLER_OPTION;	}
 local-io-error		{ DP; CP; return TK_HANDLER_OPTION;     }
 before-resync-target	{ DP; CP; return TK_HANDLER_OPTION;	}
 after-resync-target	{ DP; CP; return TK_HANDLER_OPTION;	}
+before-resync-source	{ DP; CP; return TK_HANDLER_OPTION;	}
+after-resync-source	{ DP; CP; return TK_HANDLER_OPTION;	}
 memlimit		{ DP; CP; return TK_PROXY_OPTION;       }
 read-loops		{ DP; CP; return TK_PROXY_OPTION;       }
 compression		{ DP; CP; return TK_PROXY_OPTION;       }
-- 
1.7.0.1

