Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 11DC01056197
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F40F62A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id WUJwtxshaGe8 for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D18042ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 65T3H9coMu6g for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A50CF2A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:16 +0100 (CET)
Resent-Message-ID: <20151130193016.GQ22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0724C1056192
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:28:51 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:14 +0100
Message-Id: <1448659575-13485-10-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/21] drbd: use bool for peer is_ states
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

is_write and is_discard are used as boolean.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_worker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index e47bde9..e427ba0 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -173,8 +173,8 @@ void drbd_peer_request_endio(struct bio *bio)
 {
 	struct drbd_peer_request *peer_req = bio->bi_private;
 	struct drbd_device *device = peer_req->peer_device->device;
-	int is_write = bio_data_dir(bio) == WRITE;
-	int is_discard = !!(bio->bi_rw & REQ_DISCARD);
+	bool is_write = bio_data_dir(bio) == WRITE;
+	bool is_discard = !!(bio->bi_rw & REQ_DISCARD);
 
 	if (bio->bi_error && __ratelimit(&drbd_ratelimit_state))
 		drbd_warn(device, "%s: error=%d s=%llus\n",
-- 
2.1.4

