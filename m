Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 07FBD1011B93
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 16:23:00 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so16894464wmf.3
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 07:23:00 -0700 (PDT)
Date: Mon, 11 Jun 2018 16:22:58 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20180611142258.GA24736@soda.linbit>
References: <2527777.WaVWHdIFCo@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2527777.WaVWHdIFCo@stwm.de>
Cc: lars.ellenberg@linbit.com, philipp.reisner@linbit.com
Subject: Re: [Drbd-dev] WARNING: CPU: 5 PID: 8321 at block/blk-core.c:172
 blk_status_to_errno+0x1a/0x30
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

On Mon, Jun 11, 2018 at 01:02:26PM +0200, Wolfgang Walter wrote:
> After switching from 4.9.102 to 4.14.48 I got the following warning:
> 
> 
> [204738.619214] ------------[ cut here ]------------
> [204738.619225] WARNING: CPU: 5 PID: 8321 at block/blk-core.c:172 blk_status_to_errno+0x1a/0x30
> [204738.619354] Call Trace:
> [204738.619366]  drbd_request_endio+0x5d/0x280 [drbd]


This is the same issue as was found and reported on 30 April 2018 by
Sarah Newman [PATCH] drbd: avoid use-after-free in drbd_request_endio
I was under the impression that she'd push for upstream inclusion of the fix.
Apparently not, so we'll have to followup with upstream ourselves.

It is broken since 4246a0b 2015-07 (during the v4.3 release cycle),
which changed:
        bio_put(req->private_bio);
-       req->private_bio = ERR_PTR(error);
+       req->private_bio = ERR_PTR(bio->bi_error);

which is an access after (potential) free,
because req->private_bio == bio (before the assignment).

That later changed to
 req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));

Which now "sometimes" catches the access-after-free
with its WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors));

In the DRBD driver upstream (our development happens out-of-tree),
we don't have this, but still use an on-stack "status" variable.
The effect of this (potential) access-after-free is invisible,
unless you run your kernel with "CONFIG_DEBUG_PAGEALLOC".
This is why this was never catched.

I think the correct fix would be:

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 1476cb3439f4..5e793dd7adfb 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -282,8 +282,8 @@ void drbd_request_endio(struct bio *bio)
 		what = COMPLETED_OK;
 	}
 
-	bio_put(req->private_bio);
 	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
 
 	/* not req_mod(), we need irqsave here! */
 	spin_lock_irqsave(&device->resource->req_lock, flags);


The behaviour without that patch is effectively identical to the
behaviour with this patch, though sometimes in multiple failure
scenarios (both local disk failure AND replication / remote IO errors)
we might give back an "EIO" instead of a more specific error, if such
more specific error had been handed to us in the first place.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
