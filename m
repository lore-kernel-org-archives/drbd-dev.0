Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B02961087028
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2011 16:02:54 +0200 (CEST)
Resent-Message-ID: <20110531140253.GF9498@barkeeper1-xen.linbit>
From: Joe Perches <joe@perches.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Jiri Kosina <trivial@kernel.org>
Date: Sat, 28 May 2011 10:36:24 -0700
Message-Id: <c6d0069e093ffb3508c515aea7e301fac9c2cfc8.1306603968.git.joe@perches.com>
In-Reply-To: <cover.1306603968.git.joe@perches.com>
References: <cover.1306603968.git.joe@perches.com>
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [TRIVIAL PATCH next 04/15] drbd: Convert vmalloc/memset
	to vzalloc
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
index f440a02..9dd03b0 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -381,15 +381,14 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
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
1.7.5.rc3.dirty

