Return-Path: <glass.su@suse.com>
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
	[209.85.167.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E70FD42062A
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2024 10:13:13 +0100 (CET)
Received: by mail-lf1-f54.google.com with SMTP id
	2adb3069b0e04-512e39226efso3313011e87.0
	for <drbd-dev@lists.linbit.com>; Sun, 03 Mar 2024 01:13:13 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 1/2] crm-fence-peer.9.sh: fix parsing in_ccm crmd fields of
	node_state with Pacemaker 2.1.7
Date: Sun,  3 Mar 2024 17:12:58 +0800
Message-ID: <20240303091259.5045-1-l@damenly.org>
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

If pacemaker version < 2.1.7, in_ccm of node_state is "true" or "false"
and crmd is "online" or "offline".

pacemaker 2.1.7 changed the two fields into timestamps.
For in_ccm, the value is timestamp since when node has been a cluster
member("true"). A value 0 of means the node is not a cluster member("false").
For crmd, the value is timestamp since when peer has been online in
CPG("online"). A value 0 means the peer is offline in CPG("offline").

The original code doesn't handle these fields in timestamp format.
Since there are many comprare of strings in context, converting in_ccm and crmd
from timestamps/0 to old strings is simpler and clearer.

Link: https://github.com/ClusterLabs/pacemaker/blob/Pacemaker-2.1.7/lib/pengine/unpack.c#L1581
Signed-off-by: Su Yue <glass.su@suse.com>
---
 scripts/crm-fence-peer.9.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/crm-fence-peer.9.sh b/scripts/crm-fence-peer.9.sh
index 44da6516bf3f..a3353a7354a6 100755
--- a/scripts/crm-fence-peer.9.sh
+++ b/scripts/crm-fence-peer.9.sh
@@ -888,6 +888,31 @@ guess_if_pacemaker_will_fence()
 		esac
 	done
 
+	# Copied from pacemaker-2.1.7:lib/pengine/unpack.c:
+	# Since crm_feature_set 3.18.0 (pacemaker-2.1.7):
+	#
+	# - in_ccm		::= <timestamp>|0
+	# Since when node has been a cluster member. A value 0 of means the
+	# node is not a cluster member.
+	# - crmd		::= <timestamp>|0
+	# Since when peer has been online in CPG. A value 0 means the peer
+	# is offline in CPG.
+	if [[ $in_ccm =~ ^[0-9]+$ ]]; then
+		if [[ $in_ccm = "0" ]]; then
+			in_ccm="false"
+		else
+			in_ccm="true"
+		fi
+	fi
+
+	if [[ $crmd =~ ^[0-9]+$ ]]; then
+		if [[ $crmd = "0" ]]; then
+			crmd="offline"
+		else
+			crmd="online"
+		fi
+	fi
+
 	# if it is not enabled, no point in waiting for it.
 	if ! $stonith_enabled ; then
 		# "normalize" the rest of the logic
-- 
2.44.0

