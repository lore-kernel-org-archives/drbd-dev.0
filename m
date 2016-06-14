Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0087.outbound.protection.outlook.com [65.55.169.87])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 19B371056444
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 14:31:55 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <dbe8ed17-f86c-9729-3750-8ab6a6bf67a2@sandisk.com>
Date: Tue, 14 Jun 2016 13:56:56 +0200
MIME-Version: 1.0
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 4/6] crm-fence-peer.sh: Fix a typo
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

Compare $i with 0 instead of assigning 0 to $i in an if-test.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 scripts/crm-fence-peer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/crm-fence-peer.sh b/scripts/crm-fence-peer.sh
index 67f3457..1eac65a 100755
--- a/scripts/crm-fence-peer.sh
+++ b/scripts/crm-fence-peer.sh
@@ -773,7 +773,7 @@ set_states_from_proc_drbd()
 		[[ $pdsk != UpToDate ]] && DRBD_pdsk_all_uptodate=false
 		let i++
 	done
-	if (( i = 0 )) ; then
+	if (( i == 0 )) ; then
 		DRBD_pdsk_all_uptodate=false
 		DRBD_disk_all_uptodate=false
 		DRBD_disk_all_consistent=false
-- 
2.8.4

