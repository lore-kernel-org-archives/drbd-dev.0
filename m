Return-Path: <glass.su@suse.com>
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
	[209.85.208.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1B8184203C0
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 15:34:31 +0200 (CEST)
Received: by mail-lj1-f181.google.com with SMTP id
	38308e7fff4ca-2f025b94e07so45144911fa.0
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 06:34:31 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [RFC PATCH 2/3] drbd.ocf: update regex of sed for new output from
	crm_resource
Date: Mon, 29 Jul 2024 21:34:09 +0800
Message-ID: <20240729133410.8332-3-glass.su@suse.com>
In-Reply-To: <20240729133410.8332-1-glass.su@suse.com>
References: <20240729133410.8332-1-glass.su@suse.com>
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

Since Pacemaker-2.1.0
crm_resource --resource "$OCF_RESOURCE_INSTANCE" --locate outputs
'resource promotable-clone is running on: cluster02 Promoted'
was
'resource promotable-clone is running on: cluster02 Master'.

So update the regular expression.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 scripts/drbd.ocf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index 133aff737455..bbe25f38edda 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -999,7 +999,7 @@ crm_resource_locate_master()
 	called_crm_resource_locate=true
 	DRBD_PRIMARY_PEER_according_to_pcmk=$(
 		crm_resource --resource "$OCF_RESOURCE_INSTANCE" --locate 2>/dev/null |
-		sed -ne 's/^.*is running on: \([^ ]*\) Master.*$/\1/p' |
+		sed -ne 's/^.*is running on: \([^ ]*\) \(Master\|Promoted\).*$/\1/p' |
 		grep -vix -m1 -e "$HOSTNAME")
 }
 
-- 
2.45.2

