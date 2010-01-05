Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DAA291072DD8
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jan 2010 12:37:46 +0100 (CET)
Resent-Message-ID: <20100106113746.GB23877@barkeeper1-xen.linbit>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0B5341072DE0
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jan 2010 22:13:00 +0100 (CET)
Message-Id: <201001052112.o05LClvd019894@imap1.linux-foundation.org>
To: julia@diku.dk, drbd-dev@lists.linbit.com, jens.axboe@oracle.com,
	philipp.reisner@linbit.com, mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Tue, 05 Jan 2010 13:12:47 -0800
Subject: [Drbd-dev] [merged]
	drivers-block-drbd-drbd_receiverc-correct-null-test.patch
	removed from -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


The patch titled
     drivers/block/drbd/drbd_receiver.c: correct NULL test
has been removed from the -mm tree.  Its filename was
     drivers-block-drbd-drbd_receiverc-correct-null-test.patch

This patch was dropped because it was merged into mainline or a subsystem tree

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: drivers/block/drbd/drbd_receiver.c: correct NULL test
From: Julia Lawall <julia@diku.dk>

Test the just-allocated value for NULL rather than some other value.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
statement S;
@@

x = \(kmalloc\|kcalloc\|kzalloc\)(...);
(
if ((x) == NULL) S
|
if (
-   y
+   x
       == NULL)
 S
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_receiver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/drbd/drbd_receiver.c~drivers-block-drbd-drbd_receiverc-correct-null-test drivers/block/drbd/drbd_receiver.c
--- a/drivers/block/drbd/drbd_receiver.c~drivers-block-drbd-drbd_receiverc-correct-null-test
+++ a/drivers/block/drbd/drbd_receiver.c
@@ -3945,7 +3945,7 @@ static int drbd_do_auth(struct drbd_conf
 	}
 
 	right_response = kmalloc(resp_size, GFP_NOIO);
-	if (response == NULL) {
+	if (right_response == NULL) {
 		dev_err(DEV, "kmalloc of right_response failed\n");
 		rv = 0;
 		goto fail;
_

Patches currently in -mm which might be from julia@diku.dk are

origin.patch
linux-next.patch
drivers-scsi-sesc-eliminate-double-free.patch
kernel-credc-use-kmem_cache_free.patch
arch-arm-plat-pxa-dmac-correct-null-test.patch
drivers-gpu-drm-nouveau-nouveau_grctxc-correct-null-test.patch
drivers-media-video-move-dereference-after-null-test.patch
arch-mips-alchemy-correct-code-taking-the-size-of-a-pointer.patch
drivers-scsi-libsas-use-sam_good.patch
drivers-scsi-remove-unnecessary-null-test.patch
drivers-message-move-dereference-after-null-test.patch
drivers-staging-tm6000-tm6000-videoc-correct-null-test.patch
drivers-edac-introduce-missing-kfree.patch

