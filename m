Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CB480105618B
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BDC9D2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IuelRcudtKMf for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A13C32ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A8AGscVcCVDI for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 786BC2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:14 +0100 (CET)
Resent-Message-ID: <20151130193014.GO22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7F6BF1055F71
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:28:49 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:11 +0100
Message-Id: <1448659575-13485-7-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/21] drbd: use const char * const for drbd
	strings
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

Be more strict with constant arrays

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_strings.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index 80b0f63..0eeab14 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -26,7 +26,7 @@
 #include <linux/drbd.h>
 #include "drbd_strings.h"
 
-static const char *drbd_conn_s_names[] = {
+static const char * const drbd_conn_s_names[] = {
 	[C_STANDALONE]       = "StandAlone",
 	[C_DISCONNECTING]    = "Disconnecting",
 	[C_UNCONNECTED]      = "Unconnected",
@@ -53,13 +53,13 @@ static const char *drbd_conn_s_names[] = {
 	[C_BEHIND]           = "Behind",
 };
 
-static const char *drbd_role_s_names[] = {
+static const char * const drbd_role_s_names[] = {
 	[R_PRIMARY]   = "Primary",
 	[R_SECONDARY] = "Secondary",
 	[R_UNKNOWN]   = "Unknown"
 };
 
-static const char *drbd_disk_s_names[] = {
+static const char * const drbd_disk_s_names[] = {
 	[D_DISKLESS]     = "Diskless",
 	[D_ATTACHING]    = "Attaching",
 	[D_FAILED]       = "Failed",
@@ -71,7 +71,7 @@ static const char *drbd_disk_s_names[] = {
 	[D_UP_TO_DATE]   = "UpToDate",
 };
 
-static const char *drbd_state_sw_errors[] = {
+static const char * const drbd_state_sw_errors[] = {
 	[-SS_TWO_PRIMARIES] = "Multiple primaries not allowed by config",
 	[-SS_NO_UP_TO_DATE_DISK] = "Need access to UpToDate data",
 	[-SS_NO_LOCAL_DISK] = "Can not resync without local disk",
-- 
2.1.4

