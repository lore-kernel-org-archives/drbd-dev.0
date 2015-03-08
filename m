Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AB8D91050584
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:07:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6479E44D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:07:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uQnHNC_eY7pg for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:07:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3D92C44D394
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:07:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 07RTn2ODlUtk for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:07:59 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A4ED444D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:07:58 +0100 (CET)
Resent-Message-ID: <20150312230758.GL3961@soda.linbit>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
	[209.85.213.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0A07D1050584
	for <drbd-dev@lists.linbit.com>; Sun,  8 Mar 2015 01:31:33 +0100 (CET)
Received: by igbhl2 with SMTP id hl2so12748439igb.5
	for <drbd-dev@lists.linbit.com>; Sat, 07 Mar 2015 16:31:32 -0800 (PST)
Date: Sat, 7 Mar 2015 16:24:02 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Jens Axboe <axboe@fb.com>, Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch 1/2] block,
	drbd: fix drbd_req_new() initialization
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

mempool_alloc() does not support __GFP_ZERO since elements may come from
memory that has already been released by mempool_free().

Remove __GFP_ZERO from mempool_alloc() in drbd_req_new() and properly
initialize it to 0.

Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -52,9 +52,10 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device,
 {
 	struct drbd_request *req;
 
-	req = mempool_alloc(drbd_request_mempool, GFP_NOIO | __GFP_ZERO);
+	req = mempool_alloc(drbd_request_mempool, GFP_NOIO);
 	if (!req)
 		return NULL;
+	memset(req, 0, sizeof(*req));
 
 	drbd_req_make_private_bio(req, bio_src);
 	req->rq_state    = bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0;
