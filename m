Return-Path: <prvs=655a99766=chaitanya.kulkarni@wdc.com>
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 83BBF4203D0
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 08:17:14 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
	xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 27 Jan 2021 23:11:32 -0800
Message-Id: <20210128071133.60335-34-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: shaggy@kernel.org, sergey.senozhatsky.work@gmail.com, snitzer@redhat.com,
	tiwai@suse.de, djwong@kernel.org, gustavoars@kernel.org,
	joseph.qi@linux.alibaba.com, pavel@ucw.cz,
	alex.shi@linux.alibaba.com, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, mark@fasheh.com,
	osandov@fb.com, ebiggers@kernel.org, ngupta@vflare.org,
	len.brown@intel.com, chaitanya.kulkarni@wdc.com,
	konrad.wilk@oracle.com, hare@suse.de, ming.lei@redhat.com,
	viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com,
	jaegeuk@kernel.org, konishi.ryusuke@gmail.com,
	bvanassche@acm.org, axboe@kernel.dk, damien.lemoal@wdc.com,
	tytso@mit.edu, akpm@linux-foundation.org,
	martin.petersen@oracle.com, rjw@rjwysocki.net,
	philipp.reisner@linbit.com, minchan@kernel.org, tj@kernel.org,
	lars.ellenberg@linbit.com, jth@kernel.org,
	asml.silence@gmail.com, jlbec@evilplan.org, roger.pau@citrix.com
Subject: [Drbd-dev] [RFC PATCH 33/34] mm: use bio_new in swap_readpage
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

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 25b321489703..7579485ccb5e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -342,7 +342,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	bio = bio_alloc(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
+	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
 			REQ_SWAP | wbc_to_write_flags(wbc), 1, GFP_NOIO);
 	bio->bi_end_io = end_write_func;
 	bio_add_page(bio, page, thp_size(page), 0);
@@ -406,10 +406,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	ret = 0;
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_opf = REQ_OP_READ;
-	bio->bi_iter.bi_sector = swap_page_sector(page);
+	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_READ, 0, 1,
+			GFP_KERNEL);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_page(bio, page, thp_size(page), 0);
 
-- 
2.22.1

