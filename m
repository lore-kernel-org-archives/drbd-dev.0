Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
	(mail-by2on0087.outbound.protection.outlook.com [207.46.100.87])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7F5A61056450
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:55:45 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <3fb67ddc-68af-806e-ea9d-ea4d96d0647f@sandisk.com>
Date: Tue, 14 Jun 2016 13:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 2/6] drbd.ocf: Avoid splitting array elements
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

This patch avoids that shellcheck reports the following:

  error: Double quote array expansions to avoid re-splitting elements. [SC2068]

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/drbd.ocf | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index 2335062..44c4e44 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -375,11 +375,11 @@ drbd_set_status_variables() {
 	[[ ${#DRBD_DSTATE_REMOTE[@]} != 0 ]] || DRBD_DSTATE_REMOTE=(DUnknown)
 
 
-	: == DEBUG == DRBD_ROLE_LOCAL    == ${DRBD_ROLE_LOCAL[@]} ==
-	: == DEBUG == DRBD_ROLE_REMOTE   == ${DRBD_ROLE_REMOTE[@]} ==
-	: == DEBUG == DRBD_CSTATE        == ${DRBD_CSTATE[@]} ==
-	: == DEBUG == DRBD_DSTATE_LOCAL  == ${DRBD_DSTATE_LOCAL[@]} ==
-	: == DEBUG == DRBD_DSTATE_REMOTE == ${DRBD_DSTATE_REMOTE[@]} ==
+	: == DEBUG == DRBD_ROLE_LOCAL    == "${DRBD_ROLE_LOCAL[@]}" ==
+	: == DEBUG == DRBD_ROLE_REMOTE   == "${DRBD_ROLE_REMOTE[@]}" ==
+	: == DEBUG == DRBD_CSTATE        == "${DRBD_CSTATE[@]}" ==
+	: == DEBUG == DRBD_DSTATE_LOCAL  == "${DRBD_DSTATE_LOCAL[@]}" ==
+	: == DEBUG == DRBD_DSTATE_REMOTE == "${DRBD_DSTATE_REMOTE[@]}" ==
 }
 
 call_unfence()
@@ -621,7 +621,7 @@ drbd_status() {
 	# done with maintenance-mode enabled.
 	# If someone does manually kill/remove only some of the volumes,
 	# we tolerate that here.
-	for dev in ${DRBD_DEVICES[@]} ""; do
+	for dev in "${DRBD_DEVICES[@]}" ""; do
 		test -b $dev && break
 	done
 	[[ $dev ]] || return $rc
@@ -701,7 +701,7 @@ figure_out_drbd_peer_uname()
 
 my_udevsettle()
 {
-	for dev in ${DRBD_DEVICES[@]}; do
+	for dev in "${DRBD_DEVICES[@]}"; do
 		while ! test -b $dev; do
 			sleep 1;
 		done
-- 
2.8.4

