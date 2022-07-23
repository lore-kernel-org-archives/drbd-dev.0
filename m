Return-Path: <sanpeqf@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 55B3C4201D6
	for <drbd-dev@lists.linbit.com>; Sat, 23 Jul 2022 10:00:06 +0200 (CEST)
Received: by mail-pf1-f193.google.com with SMTP id w185so6227663pfb.4
	for <drbd-dev@lists.linbit.com>; Sat, 23 Jul 2022 01:00:06 -0700 (PDT)
From: John Sanpe <sanpeqf@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Date: Sat, 23 Jul 2022 15:59:31 +0800
Message-Id: <20220723075931.163245-1-sanpeqf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: John Sanpe <sanpeqf@gmail.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] lib/lru_cache: Fixed array overflow caused by
	incorrect boundary handling.
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

This problem occurs when malloc element failed on the first time.
At this time, the counter i is 0. When it's released, we subtract 1
in advance without checking, which will cause i to become UINT_MAX,
resulting in array overflow.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 52313acbfa62..04d95de92602 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -147,7 +147,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		return lc;
 
 	/* else: could not allocate all elements, give up */
-	for (i--; i; i--) {
+	while (i--) {
 		void *p = element[i];
 		kmem_cache_free(cache, p - e_off);
 	}
-- 
2.36.1

