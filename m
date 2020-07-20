Return-Path: <BATV+d9f98309abae8ab29895+6175+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B703420408
	for <drbd-dev@lists.linbit.com>; Mon, 20 Jul 2020 09:54:34 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 20 Jul 2020 09:51:45 +0200
Message-Id: <20200720075148.172156-12-hch@lst.de>
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more
	intelligently
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

There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
is not set, as the device won't support it.  Also there is no point in
trying a bio submission if bdev_read_page failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ccda7679008851..63b44b8221af0f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -403,8 +403,11 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-	if (!ret) {
+	if (sis->flags & SWP_SYNCHRONOUS_IO) {
+		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
+		if (ret)
+			goto out;
+
 		if (trylock_page(page)) {
 			swap_slot_free_notify(page);
 			unlock_page(page);
-- 
2.27.0

