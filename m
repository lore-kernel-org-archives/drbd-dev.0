Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
	(mail-by2on0091.outbound.protection.outlook.com [207.46.100.91])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4BDFE105644F
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:56:20 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <62d0e706-a044-f5bf-1c1f-170d96acf27d@sandisk.com>
Date: Tue, 14 Jun 2016 13:56:13 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 3/6] drbd.ocf: Tune debug log output
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

Log the name with which this script has been invoked together with
the script arguments. Make the environment variable filter more strict.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/drbd.ocf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index 44c4e44..84305db 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -135,8 +135,8 @@ then
 	# PS4='+[`date +%F\ %T.%3N`] '
 	exec 9>>"$DEBUG_LOG"
 	date >&9
-	echo "$*" >&9
-	env | grep OCF_ | sort >&9
+	echo "$0 $*" >&9
+	env | grep '^OCF_' | sort >&9
 else
 	exec 9>/dev/null
 fi
-- 
2.8.4

