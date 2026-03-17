Return-Path: <ethantidmore06@gmail.com>
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
	[209.85.128.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B7CF1622B5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 00:23:22 +0100 (CET)
Received: by mail-yw1-f171.google.com with SMTP id
	00721157ae682-7927261a3acso51072437b3.0
	for <drbd-dev@lists.linbit.com>; Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] drbd: Fix variable dereference before check
Date: Tue, 17 Mar 2026 18:23:16 -0500
Message-ID: <20260317232318.18923-3-ethantidmore06@gmail.com>
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Ethan Tidmore <ethantidmore06@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The struct is 'req' is checked for NULL after resource was assigned from
a member from it.

Check 'req' for NULL before assigning resource.

Detected by Smatch:
drivers/block/drbd/drbd_req.c:1996 drbd_unplug() warn:
variable dereferenced before check 'req' (see line 1993)

Fixes: 71d075200b462 ("drbd: rework request processing for DRBD 9 multi-peer IO")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e88b5da15c1e..4cbd9ec15157 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1990,12 +1990,14 @@ static void drbd_unplug(struct blk_plug_cb *cb, bool from_schedule)
 {
 	struct drbd_plug_cb *plug = container_of(cb, struct drbd_plug_cb, cb);
 	struct drbd_request *req = plug->most_recent_req;
-	struct drbd_resource *resource = req->device->resource;
+	struct drbd_resource *resource;
 
 	kfree(cb);
 	if (!req)
 		return;
 
+	resource = req->device->resource;
+
 	read_lock_irq(&resource->state_rwlock);
 	/* In case the sender did not process it yet, raise the flag to
 	 * have it followed with P_UNPLUG_REMOTE just after. */
-- 
2.53.0

