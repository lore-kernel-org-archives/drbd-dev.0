Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 630B61056198
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5479F2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HIKzfNdaP6Tv for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2A7FE2ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:18 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CG3gXd3pud8F for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:17 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B1D802A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:17 +0100 (CET)
Resent-Message-ID: <20151130193017.GR22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3412F1056197
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:29:42 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:25 +0100
Message-Id: <1448659775-13596-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/21] drbd: fix typo
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

s/reqest/request

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index bd98953..6c9d5d4 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -140,7 +140,7 @@ extern void drbd_resume_al(struct drbd_device *device);
 extern bool conn_all_vols_unconf(struct drbd_connection *connection);
 
 /**
- * drbd_request_state() - Reqest a state change
+ * drbd_request_state() - Request a state change
  * @device:	DRBD device.
  * @mask:	mask of state bits to change.
  * @val:	value of new state bits.
-- 
2.1.4

