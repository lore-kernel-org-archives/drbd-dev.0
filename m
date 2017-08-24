Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 996D91057FFE
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:28:52 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id b189so4571525wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:28:52 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:05 +0200
Message-Id: <1503609794-13233-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/17] drbd: fix potential get_ldev/put_ldev
	refcount imbalance during attach
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Race:

drbd_adm_attach()               | async drbd_md_endio()
                                |
device->ldev is still NULL.     |
                                |
drbd_md_read(                   |
 .endio = drbd_md_endio;        |
 submit;                        |
 ....                           |
 wait for done == 1;            |       done = 1;
);                              |       wake_up();
.. lot of other stuff,          |
.. includeing taking and        |
...giving up locks,             |
.. doing further IO,            |
.. stuff that takes "some time" |
                                | while in this context,
                                | this is the next statement.
                                | which means this context was scheduled
.. only then, finally,          | away for "some time".
device->ldev = nbc;             |
                                |       if (device->ldev)
                                |               put_ldev()

Unlikely, but possible. I was able to provoke it "reliably"
by adding an mdelay(500); after the wake_up().
Fixed by moving the if (!NULL) put_ldev() before done = 1;

Impact of the bug was that the resulting refcount imbalance
could lead to premature destruction of the object, potentially
causing a NULL pointer dereference during a subsequent detach.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index e48012d..f0717a9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -65,6 +65,11 @@ void drbd_md_endio(struct bio *bio)
 	device = bio->bi_private;
 	device->md_io.error = blk_status_to_errno(bio->bi_status);
 
+	/* special case: drbd_md_read() during drbd_adm_attach() */
+	if (device->ldev)
+		put_ldev(device);
+	bio_put(bio);
+
 	/* We grabbed an extra reference in _drbd_md_sync_page_io() to be able
 	 * to timeout on the lower level device, and eventually detach from it.
 	 * If this io completion runs after that timeout expired, this
@@ -79,9 +84,6 @@ void drbd_md_endio(struct bio *bio)
 	drbd_md_put_buffer(device);
 	device->md_io.done = 1;
 	wake_up(&device->misc_wait);
-	bio_put(bio);
-	if (device->ldev) /* special case: drbd_md_read() during drbd_adm_attach() */
-		put_ldev(device);
 }
 
 /* reads on behalf of the partner,
-- 
2.7.4

