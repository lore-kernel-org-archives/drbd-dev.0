Return-Path: <glass.su@suse.com>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D0FF4203BF
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 15:34:29 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
	ffacd0b85a97d-369c609d0c7so1904343f8f.3
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jul 2024 06:34:29 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [RFC PATCH 1/3] drbd.ocf: replace crm_master with ocf_promotion_score
Date: Mon, 29 Jul 2024 21:34:08 +0800
Message-ID: <20240729133410.8332-2-glass.su@suse.com>
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

The crm_master command has been deprecated and replaced with a new
crm_attribute --promotion option that defaults to --lifetime=reboot
(example: crm_master -l reboot -v 10 becomes
crm_attribute --promotion -v 10. The old command will still work for
now, but the new one should be used if available. The new option is
available as of CRM feature set 3.9.0).

Also define ocf_promotion_score() as
resource-agents/heartbeat/ocf-shellfuncs.in if it doesn't exist.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 scripts/drbd.ocf | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index 1d051baa550d..133aff737455 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -104,6 +104,18 @@ if ! command -v ocf_is_true &> /dev/null ; then
 	}
 fi
 
+if ! command -v ocf_promotion_score &> /dev/null ; then
+	ocf_promotion_score() {
+		ocf_version_cmp "$OCF_RESKEY_crm_feature_set" "3.10.0"
+		res=$?
+		if [ $res -eq 2 ] || [ $res -eq 1 ] || ! have_binary "crm_master"; then
+			${HA_SBIN_DIR}/crm_attribute -p ${OCF_RESOURCE_INSTANCE} $@
+		else
+			${HA_SBIN_DIR}/crm_master -l reboot $@
+		fi
+	}
+fi
+
 # Defaults
 OCF_RESKEY_drbdconf_default="/etc/drbd.conf"
 OCF_RESKEY_unfence_extra_args_default="--quiet --flock-required --flock-timeout 0 --unfence-only-if-owner-match"
@@ -570,9 +582,9 @@ do_drbdadm() {
 unset current_master_score
 get_current_master_score()
 {
-	# only call crm_master once
+	# only call get crm master once
 	[[ ${current_master_score+set} ]] ||
-	current_master_score=$(crm_master -q -l reboot -G 2>/dev/null)
+	current_master_score=$(ocf_promotion_score -q -G 2>/dev/null)
 	# return value of this function:
 	# true if master_score is present
 	# false if master_score is not present
@@ -585,13 +597,13 @@ set_master_score() {
 	if [[ $1 -le 0 ]]; then
 		remove_master_score
 	else
-		do_cmd ${HA_SBIN_DIR}/crm_master -Q -l reboot -v $1 &&
+		do_cmd ocf_promotion_score -Q -v $1 &&
 		current_master_score=$1
 	fi
 }
 
 remove_master_score() {
-	do_cmd ${HA_SBIN_DIR}/crm_master -l reboot -D
+	do_cmd ocf_promotion_score -D
 	current_master_score=""
 }
 
-- 
2.45.2

