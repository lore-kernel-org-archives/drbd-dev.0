Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DA38C163116
	for <drbd-dev@lists.linbit.com>; Wed,  4 Mar 2026 20:11:01 +0100 (CET)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block: get rid of blk_status_to_{errno, str} inconsistency
Date: Wed,  4 Mar 2026 20:04:07 +0100
Message-ID: <20260304190424.291743-3-agruenba@redhat.com>
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

Change blk_status_to_str() to be consistent with blk_status_to_errno()
and return "I/O" for undefined status codes.

With that, the fallback case in the blk_errors array can be removed with
no change in behavior.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c..a20042f15790 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -161,9 +161,6 @@ static const struct {
 	[BLK_STS_DURATION_LIMIT]	= { -ETIME, "duration limit exceeded" },
 
 	[BLK_STS_INVAL]		= { -EINVAL,	"invalid" },
-
-	/* everything else not covered above: */
-	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
 blk_status_t errno_to_blk_status(int errno)
@@ -194,7 +191,7 @@ const char *blk_status_to_str(blk_status_t status)
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
-		return "<null>";
+		return "I/O";
 	return blk_errors[idx].name;
 }
 EXPORT_SYMBOL_GPL(blk_status_to_str);
-- 
2.52.0

