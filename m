Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0087.outbound.protection.outlook.com [65.55.169.87])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7B1F2105644F
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:57:50 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <a1b7e232-3d0b-9131-77e0-b2b5e7f1bc54@sandisk.com>
Date: Tue, 14 Jun 2016 13:57:45 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 5/6] crm-fence-peer.sh: Modify empty string
 assignment statements
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

This patch does not change any functionality but avoids that
shellcheck reports the following warning:

  warning: Remove space after = if trying to assign a value (for empty string, use var='' ... ). [SC1007]

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/crm-fence-peer.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/crm-fence-peer.sh b/scripts/crm-fence-peer.sh
index 1eac65a..bc67259 100755
--- a/scripts/crm-fence-peer.sh
+++ b/scripts/crm-fence-peer.sh
@@ -488,7 +488,7 @@ guess_if_pacemaker_will_fence()
 	local x
 
 	# "return values:"
-	crmd= in_ccm= expected= join= will_fence=false
+	crmd='' in_ccm='' expected='' join='' will_fence=false
 
 	# Older pacemaker has an "ha" attribute, too.
 	# For stonith-enabled=false, the "crmd" attribute may stay "online",
@@ -573,8 +573,8 @@ check_peer_node_reachable()
 	nr_other_nodes=$#
 
 	while :; do
-		local state_lines= node_state=
-		local crmd= in_ccm= expected= join= will_fence= ha_dead=
+		local state_lines='' node_state='' crmd='' in_ccm=''
+		local expected='' join='' will_fence='' ha_dead=''
 
 		while :; do
 			local t=$SECONDS
-- 
2.8.4

