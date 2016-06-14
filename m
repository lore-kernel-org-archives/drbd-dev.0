Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
	(mail-by2on0096.outbound.protection.outlook.com [207.46.100.96])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 544991056453
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:55:00 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <b831e1af-0c16-8e78-f18b-1823018cee81@sandisk.com>
Date: Tue, 14 Jun 2016 13:54:52 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 1/6] drbd.ocf: Make it possible for shellcheck to
 parse this script
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

Shellcheck is a useful tool for verifying syntactical correctness
of shell scripts. Hence make it possible to verify this script
with shellcheck. This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/drbd.ocf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index 632e16e..2335062 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -967,7 +967,7 @@ meta_expect()
 	local val=${!whatvar}
 	if [[ -n $val ]]; then
 		# [, not [[, or it won't work ;)
-		[ $val $op $expect ] && return
+		eval "[ $val $op $expect ]" && return
 	fi
 	ocf_log err "meta parameter misconfigured, expected $what $op $expect, but found ${val:-unset}."
 	exit $OCF_ERR_CONFIGURED
-- 
2.8.4


