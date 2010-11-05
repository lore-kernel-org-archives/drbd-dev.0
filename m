Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 26C851059631
	for <drbd-dev@lists.linbit.com>; Fri,  5 Nov 2010 12:09:54 +0100 (CET)
Resent-Message-ID: <20101105110953.GA7730@barkeeper1-xen.linbit>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Date: Thu,  4 Nov 2010 20:07:32 -0700
Message-Id: <888ee71767447f484d9212b2bb13b9312724c126.1288925424.git.joe@perches.com>
In-Reply-To: <alpine.DEB.2.00.1011031108260.11625@router.home>
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
In-Reply-To: <cover.1288925424.git.joe@perches.com>
References: <cover.1288925424.git.joe@perches.com>
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 08/49] drivers/block: Use vzalloc
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/drbd/drbd_bitmap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index fd42832..09e8cfc 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -250,15 +250,14 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
 	 * thread.  As we have no disk yet, we are not in the IO path,
 	 * not even the IO path of the peer. */
 	bytes = sizeof(struct page *)*want;
-	new_pages = kmalloc(bytes, GFP_KERNEL);
+	new_pages = kzalloc(bytes, GFP_KERNEL);
 	if (!new_pages) {
-		new_pages = vmalloc(bytes);
+		new_pages = vzalloc(bytes);
 		if (!new_pages)
 			return NULL;
 		vmalloced = 1;
 	}
 
-	memset(new_pages, 0, bytes);
 	if (want >= have) {
 		for (i = 0; i < have; i++)
 			new_pages[i] = old_pages[i];
-- 
1.7.3.1.g432b3.dirty

