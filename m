Return-Path: <glass.su@suse.com>
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
	[209.85.208.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E0DF4205D7
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 15:34:33 +0200 (CEST)
Received: by mail-lj1-f180.google.com with SMTP id
	38308e7fff4ca-2ef2fccca2cso43117981fa.1
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 06:34:33 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [RFC PATCH 3/3] drbd.ocf: update for OCF 1.1
Date: Mon, 29 Jul 2024 21:34:10 +0800
Message-ID: <20240729133410.8332-4-glass.su@suse.com>
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

According to [1], the commit
1. bumps drbd ocf version to 1.5
2. updates the <version> element to 1.1 for declare support OCF 1.1.
3. uses unique-group attribute but keeps deprecated unique attribute.
4. advertises new role names 'Unpromoted' and 'Unpromoted' instead of
    'Master' and 'Slave'.

Because of change[4], the drbd ocf RA won't be able to support old
names so we need to bump version of the RA.

Links: https://projects.clusterlabs.org/w/development/update_resource_agent_for_ocf_1.1/
Signed-off-by: Su Yue <glass.su@suse.com>
---
 scripts/drbd.ocf | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index bbe25f38edda..5b213640ec38 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -233,13 +233,13 @@ meta_data() {
 <?xml version="1.0"?>
 <!DOCTYPE resource-agent SYSTEM "ra-api-1.dtd">
 <!-- version attribute is version of this resource agent -->
-<resource-agent name="drbd" version="LINBIT 1.4">
+<resource-agent name="drbd" version="LINBIT 1.5">
 
 <!-- Version number of the standard this agent complies with -->
-<version>1.0</version>
+<version>1.1</version>
 
 <longdesc lang="en">
-This resource agent manages a DRBD resource as a master/slave resource.
+This resource agent manages a DRBD resource as a promotable resource.
 DRBD is a shared-nothing replicated storage device.
 
 NOTE:
@@ -253,10 +253,10 @@ See the DRBD User's Guide for more information.
 https://docs.linbit.com/
 </longdesc>
 
-<shortdesc lang="en">Manages a DRBD device as a Master/Slave resource</shortdesc>
+<shortdesc lang="en">Manages a DRBD device as a promotable resource</shortdesc>
 
 <parameters>
-<parameter name="drbd_resource" unique="1" required="1">
+<parameter name="drbd_resource" unique="1" unique-group="name" required="1">
 <longdesc lang="en">
 The name of the drbd resource from the drbd.conf file.
 </longdesc>
@@ -483,8 +483,8 @@ to be generated after the failover of a "healthy" DRBD.
 <action name="demote"	timeout="90" />
 <action name="notify"	timeout="90" />
 <action name="stop"    timeout="100" />
-<action name="monitor"  timeout="20" interval="20" role="Slave" />
-<action name="monitor"  timeout="20" interval="10" role="Master" />
+<action name="monitor"  timeout="20" interval="20" role="Unpromoted" />
+<action name="monitor"  timeout="20" interval="10" role="Promoted" />
 <action name="meta-data"  timeout="5" />
 <action name="validate-all" />
 </actions>
@@ -974,7 +974,7 @@ drbd_monitor() {
 	fi
 
 	case $status in
-	(0) : "OCF_SUCCESS aka 'running/slave'" ;;
+	(0) : "OCF_SUCCESS aka 'running/unpromotable'" ;;
 	(1) : "OCF_ERR_GENERIC" ;;
 	(2) : "OCF_ERR_ARGS" ;;
 	(3) : "OCF_ERR_UNIMPLEMENTED" ;;
-- 
2.45.2

