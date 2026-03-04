Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 36143163117
	for <drbd-dev@lists.linbit.com>; Wed,  4 Mar 2026 20:11:02 +0100 (CET)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: consecutive blk_status_t error codes
Date: Wed,  4 Mar 2026 20:04:06 +0100
Message-ID: <20260304190424.291743-2-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-1-agruenba@redhat.com>
References: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

Since commit 9da3d1e912f3 ("block: Add core atomic write support"),
there is a gap in the blk_status_t codes and block status code 18 is
unused.  This causes blk_status_to_errno() and blk_status_to_str() to
return incorrect values for that code.  Make the blk_status_t codes
consecutive again to avoid that.

Fixes: 9da3d1e912f3 ("block: Add core atomic write support")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..89a722d76c28 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -168,7 +168,7 @@ typedef u16 blk_short_t;
 /*
  * Invalid size or alignment.
  */
-#define BLK_STS_INVAL	((__force blk_status_t)19)
+#define BLK_STS_INVAL	((__force blk_status_t)18)
 
 /**
  * blk_path_error - returns true if error may be path related
-- 
2.52.0

