Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F1DC4252B7
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 14:43:11 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id x5so20703415wrt.7
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 05:43:11 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Nov 2022 14:42:58 +0100
Message-Id: <20221122134301.69258-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/4] lru_cache: use atomic operations when
	accessing lc->flags, always
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Or, depending on the way locking is implemented at the call sites,
some updates could be lost (has not been observed).

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index dc35464216d3..fec899386238 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -364,7 +364,7 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 	struct lc_element *e;
 
 	PARANOIA_ENTRY();
-	if (lc->flags & LC_STARVING) {
+	if (test_bit(__LC_STARVING, &lc->flags)) {
 		++lc->starving;
 		RETURN(NULL);
 	}
@@ -417,7 +417,7 @@ static struct lc_element *__lc_get(struct lru_cache *lc, unsigned int enr, unsig
 	 * the LRU element, we have to wait ...
 	 */
 	if (!lc_unused_element_available(lc)) {
-		__set_bit(__LC_STARVING, &lc->flags);
+		set_bit(__LC_STARVING, &lc->flags);
 		RETURN(NULL);
 	}
 
-- 
2.38.1

