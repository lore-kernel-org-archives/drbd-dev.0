Return-Path: <fsimonce@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1B7B110556D8
	for <drbd-dev@lists.linbit.com>; Tue, 13 Sep 2011 10:49:33 +0200 (CEST)
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8D8nXdM007061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <drbd-dev@lists.linbit.com>; Tue, 13 Sep 2011 04:49:33 -0400
From: Federico Simoncelli <fsimonce@redhat.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 13 Sep 2011 08:49:00 +0000
Message-Id: <1315903740-3442-2-git-send-email-fsimonce@redhat.com>
In-Reply-To: <1315903740-3442-1-git-send-email-fsimonce@redhat.com>
References: <1315903740-3442-1-git-send-email-fsimonce@redhat.com>
Subject: [Drbd-dev] [drbd][PATCH 2/2] drbdsetup: sh-status should use _pdsk
	in all cases
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Either the resource is StandAlone/Diskless or not we should report
the peer disk status using the same label (_pdsk).
---
 user/drbdsetup.c        |    2 +-
 user/legacy/drbdsetup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/user/drbdsetup.c b/user/drbdsetup.c
index ac0618d..81ee13a 100644
--- a/user/drbdsetup.c
+++ b/user/drbdsetup.c
@@ -1808,7 +1808,7 @@ static int sh_status_scmd(struct drbd_cmd *cm __attribute((unused)),
 		printf("%s_role=\n", _P);
 		printf("%s_peer=\n", _P);
 		printf("%s_disk=\n", _P);
-		printf("%s_pdisk=\n", _P);
+		printf("%s_pdsk=\n", _P);
 		printf("%s_flags_susp=\n", _P);
 		printf("%s_flags_aftr_isp=\n", _P);
 		printf("%s_flags_peer_isp=\n", _P);
diff --git a/user/legacy/drbdsetup.c b/user/legacy/drbdsetup.c
index 3492d0c..c04c0fa 100644
--- a/user/legacy/drbdsetup.c
+++ b/user/legacy/drbdsetup.c
@@ -1653,7 +1653,7 @@ static int sh_status_scmd(struct drbd_cmd *cm __attribute((unused)),
 		printf("%s_role=\n", _P);
 		printf("%s_peer=\n", _P);
 		printf("%s_disk=\n", _P);
-		printf("%s_pdisk=\n", _P);
+		printf("%s_pdsk=\n", _P);
 		printf("%s_flags_susp=\n", _P);
 		printf("%s_flags_aftr_isp=\n", _P);
 		printf("%s_flags_peer_isp=\n", _P);
-- 
1.7.1

