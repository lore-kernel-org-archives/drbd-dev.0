Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B52961055F5A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AF60F2AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:13 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xQ0yNUTDQcY8 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A2B4D2AE8C3
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:12 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 07nuKECE89W0 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:12 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7AC502AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:12 +0100 (CET)
Resent-Message-ID: <20151130193012.GM22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 985951055F4A
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:27:33 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:10 +0100
Message-Id: <1448659575-13485-6-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/21] drbd: rework is_valid_state()
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

Remove empty condition to avoid semantic warnings

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_state.c | 86 ++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 5a7ef78..a7631a3 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -813,54 +813,44 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 		}
 	}
 
-	if (rv <= 0)
-		/* already found a reason to abort */;
-	else if (ns.role == R_SECONDARY && device->open_cnt)
-		rv = SS_DEVICE_IN_USE;
-
-	else if (ns.role == R_PRIMARY && ns.conn < C_CONNECTED && ns.disk < D_UP_TO_DATE)
-		rv = SS_NO_UP_TO_DATE_DISK;
-
-	else if (fp >= FP_RESOURCE &&
-		 ns.role == R_PRIMARY && ns.conn < C_CONNECTED && ns.pdsk >= D_UNKNOWN)
-		rv = SS_PRIMARY_NOP;
-
-	else if (ns.role == R_PRIMARY && ns.disk <= D_INCONSISTENT && ns.pdsk <= D_INCONSISTENT)
-		rv = SS_NO_UP_TO_DATE_DISK;
-
-	else if (ns.conn > C_CONNECTED && ns.disk < D_INCONSISTENT)
-		rv = SS_NO_LOCAL_DISK;
-
-	else if (ns.conn > C_CONNECTED && ns.pdsk < D_INCONSISTENT)
-		rv = SS_NO_REMOTE_DISK;
-
-	else if (ns.conn > C_CONNECTED && ns.disk < D_UP_TO_DATE && ns.pdsk < D_UP_TO_DATE)
-		rv = SS_NO_UP_TO_DATE_DISK;
-
-	else if ((ns.conn == C_CONNECTED ||
-		  ns.conn == C_WF_BITMAP_S ||
-		  ns.conn == C_SYNC_SOURCE ||
-		  ns.conn == C_PAUSED_SYNC_S) &&
-		  ns.disk == D_OUTDATED)
-		rv = SS_CONNECTED_OUTDATES;
-
-	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		 (nc->verify_alg[0] == 0))
-		rv = SS_NO_VERIFY_ALG;
-
-	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		  first_peer_device(device)->connection->agreed_pro_version < 88)
-		rv = SS_NOT_SUPPORTED;
-
-	else if (ns.role == R_PRIMARY && ns.disk < D_UP_TO_DATE && ns.pdsk < D_UP_TO_DATE)
-		rv = SS_NO_UP_TO_DATE_DISK;
-
-	else if ((ns.conn == C_STARTING_SYNC_S || ns.conn == C_STARTING_SYNC_T) &&
-                 ns.pdsk == D_UNKNOWN)
-		rv = SS_NEED_CONNECTION;
-
-	else if (ns.conn >= C_CONNECTED && ns.pdsk == D_UNKNOWN)
-		rv = SS_CONNECTED_OUTDATES;
+	if (rv > 0) {
+		if (ns.role == R_SECONDARY && device->open_cnt)
+			rv = SS_DEVICE_IN_USE;
+		else if (ns.role == R_PRIMARY && ns.conn < C_CONNECTED &&
+			 ns.disk < D_UP_TO_DATE)
+			rv = SS_NO_UP_TO_DATE_DISK;
+		else if (fp >= FP_RESOURCE && ns.role == R_PRIMARY &&
+			 ns.conn < C_CONNECTED && ns.pdsk >= D_UNKNOWN)
+			rv = SS_PRIMARY_NOP;
+		else if (ns.role == R_PRIMARY && ns.disk <= D_INCONSISTENT &&
+			 ns.pdsk <= D_INCONSISTENT)
+			rv = SS_NO_UP_TO_DATE_DISK;
+		else if (ns.conn > C_CONNECTED && ns.disk < D_INCONSISTENT)
+			rv = SS_NO_LOCAL_DISK;
+		else if (ns.conn > C_CONNECTED && ns.pdsk < D_INCONSISTENT)
+			rv = SS_NO_REMOTE_DISK;
+		else if (ns.conn > C_CONNECTED && ns.disk < D_UP_TO_DATE &&
+			 ns.pdsk < D_UP_TO_DATE)
+			rv = SS_NO_UP_TO_DATE_DISK;
+		else if ((ns.conn == C_CONNECTED || ns.conn == C_WF_BITMAP_S ||
+			  ns.conn == C_SYNC_SOURCE ||
+			  ns.conn == C_PAUSED_SYNC_S) && ns.disk == D_OUTDATED)
+			rv = SS_CONNECTED_OUTDATES;
+		else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
+			 (nc->verify_alg[0] == 0))
+			rv = SS_NO_VERIFY_ALG;
+		else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
+			  first_peer_device(device)->connection->agreed_pro_version < 88)
+			rv = SS_NOT_SUPPORTED;
+		else if (ns.role == R_PRIMARY && ns.disk < D_UP_TO_DATE &&
+			 ns.pdsk < D_UP_TO_DATE)
+			rv = SS_NO_UP_TO_DATE_DISK;
+		else if ((ns.conn == C_STARTING_SYNC_S ||
+			  ns.conn == C_STARTING_SYNC_T) && ns.pdsk == D_UNKNOWN)
+			rv = SS_NEED_CONNECTION;
+		else if (ns.conn >= C_CONNECTED && ns.pdsk == D_UNKNOWN)
+			rv = SS_CONNECTED_OUTDATES;
+	}
 
 	rcu_read_unlock();
 
-- 
2.1.4

