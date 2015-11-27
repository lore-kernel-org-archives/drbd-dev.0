Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AD46610561A4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A2C1E2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ycqwVG1FE3KT for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 67B7B2ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rblERg_MVbuI for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 439A32A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:23 +0100 (CET)
Resent-Message-ID: <20151130193022.GW22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E516A10561A4
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:54 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:30 +0100
Message-Id: <1448659775-13596-6-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/21] drbd: introduce peer state union
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

Add peer structure and propagate in conn_khelper() instead
of hardcoded values.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_nl.c | 13 +++++++------
 include/linux/drbd.h         |  8 ++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index ef136a9..7a5f148 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -387,7 +387,8 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	return ret;
 }
 
-static int conn_khelper(struct drbd_connection *connection, char *cmd)
+static enum drbd_peer_state conn_khelper(struct drbd_connection *connection,
+					 char *cmd)
 {
 	char *envp[] = { "HOME=/",
 			"TERM=linux",
@@ -485,17 +486,17 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	r = conn_khelper(connection, "fence-peer");
 
 	switch ((r>>8) & 0xff) {
-	case 3: /* peer is inconsistent */
+	case P_INCONSISTENT: /* peer is inconsistent */
 		ex_to_string = "peer is inconsistent or worse";
 		mask.pdsk = D_MASK;
 		val.pdsk = D_INCONSISTENT;
 		break;
-	case 4: /* peer got outdated, or was already outdated */
+	case P_OUTDATED: /* peer got outdated, or was already outdated */
 		ex_to_string = "peer was fenced";
 		mask.pdsk = D_MASK;
 		val.pdsk = D_OUTDATED;
 		break;
-	case 5: /* peer was down */
+	case P_DOWN: /* peer was down */
 		if (conn_highest_disk(connection) == D_UP_TO_DATE) {
 			/* we will(have) create(d) a new UUID anyways... */
 			ex_to_string = "peer is unreachable, assumed to be dead";
@@ -505,7 +506,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 			ex_to_string = "peer unreachable, doing nothing since disk != UpToDate";
 		}
 		break;
-	case 6: /* Peer is primary, voluntarily outdate myself.
+	case P_PRIMARY: /* Peer is primary, voluntarily outdate myself.
 		 * This is useful when an unconnected R_SECONDARY is asked to
 		 * become R_PRIMARY, but finds the other peer being active. */
 		ex_to_string = "peer is active";
@@ -513,7 +514,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 		mask.disk = D_MASK;
 		val.disk = D_OUTDATED;
 		break;
-	case 7:
+	case P_FENCING:
 		if (fp != FP_STONITH)
 			drbd_err(connection, "fence-peer() = 7 && fencing != Stonith !!!\n");
 		ex_to_string = "peer was stonithed";
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index d6b3c99..1f20a62 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -370,6 +370,14 @@ enum drbd_notification_type {
 	NOTIFY_FLAGS = NOTIFY_CONTINUES,
 };
 
+enum drbd_peer_state {
+	P_INCONSISTENT = 3,
+	P_OUTDATED = 4,
+	P_DOWN = 5,
+	P_PRIMARY = 6,
+	P_FENCING = 7
+};
+
 #define UUID_JUST_CREATED ((__u64)4)
 
 enum write_ordering_e {
-- 
2.1.4

