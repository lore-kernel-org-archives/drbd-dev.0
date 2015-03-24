Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 62F7A105059E
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5EB153CBB2B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pkrTvj7zuvki for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3EBA13D4561
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FbfNo7dhfYzD for <drbd-dev@lists.linbit.com>;
	Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1577C3CBB2B
	for <drbd-dev@lists.linbit.com>; Fri, 27 Mar 2015 15:46:03 +0100 (CET)
Resent-Message-ID: <20150327144602.GB13700@soda.linbit>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
	[209.85.213.181]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 568B71050594
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2015 00:22:35 +0100 (CET)
Received: by igbqf9 with SMTP id qf9so11501032igb.1
	for <drbd-dev@lists.linbit.com>; Tue, 24 Mar 2015 16:22:34 -0700 (PDT)
Date: Tue, 24 Mar 2015 16:22:32 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1503241622090.21805@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [patch resend 2/3] block,
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
