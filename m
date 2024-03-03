Return-Path: <glass.su@suse.com>
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
	[209.85.167.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9FFC042062A
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2024 10:13:15 +0100 (CET)
Received: by mail-lf1-f45.google.com with SMTP id
	2adb3069b0e04-5133bd7eb47so1037354e87.3
	for <drbd-dev@lists.linbit.com>; Sun, 03 Mar 2024 01:13:15 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 2/2] crm-fence-peer.9.sh: use join of node_state to judge
	whether node is banned
Date: Sun,  3 Mar 2024 17:12:59 +0800
Message-ID: <20240303091259.5045-2-l@damenly.org>
In-Reply-To: <20240303091259.5045-1-l@damenly.org>
References: <20240303091259.5045-1-l@damenly.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lars.ellenberg@linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Su Yue <glass.su@suse.com>

crmd in node_state can't be "banned". join should be used instead
of crmd.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 scripts/crm-fence-peer.9.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/crm-fence-peer.9.sh b/scripts/crm-fence-peer.9.sh
index a3353a7354a6..b326a1656c15 100755
--- a/scripts/crm-fence-peer.9.sh
+++ b/scripts/crm-fence-peer.9.sh
@@ -934,7 +934,7 @@ guess_if_pacemaker_will_fence()
 
 	# for further inspiration, see pacemaker:lib/pengine/unpack.c, determine_online_status_fencing()
 	[[ -z $in_ccm ]] && will_fence=true
-	[[ $crmd = "banned" ]] && will_fence=true
+	[[ $join = "banned" ]] && will_fence=true
 	if [[ ${expected-down} = "down" && $in_ccm = "false"  && $crmd != "online" ]]; then
 		: "pacemaker considers this as clean down"
 	elif [[ $in_ccm = false ]] || [[ $crmd != "online" ]]; then
-- 
2.44.0

