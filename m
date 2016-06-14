Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0067.outbound.protection.outlook.com [65.55.169.67])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 78497105644F
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:58:47 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <f75f3c8d-c875-8df1-45be-9cc6fbbd80f4@sandisk.com>
Date: Tue, 14 Jun 2016 13:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 6/6] crm-fence-peer.sh: Avoid expansion of
	$have_constraint
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

This patch avoids that shellcheck reports the following warning:

  warning: The surrounding quotes actually unquote this. Remove or escape them. [SC2027]

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/crm-fence-peer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/crm-fence-peer.sh b/scripts/crm-fence-peer.sh
index bc67259..794cdd4 100755
--- a/scripts/crm-fence-peer.sh
+++ b/scripts/crm-fence-peer.sh
@@ -417,7 +417,7 @@ drbd_peer_fencing()
 			rc=0
 		elif [[ -n "$have_constraint" ]] ; then
 			# if this id already exists, but looks different, we may have lost a shootout
-			echo WARNING "constraint "$have_constraint" already exists"
+			echo WARNING "constraint $have_constraint already exists"
 			# anything != 0 will do;
 			# 21 happend to be "The object already exists" with my cibadmin
 			rc=21
-- 
2.8.4

