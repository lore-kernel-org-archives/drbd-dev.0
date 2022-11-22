Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D03C34252C7
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 14:43:13 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id g12so24735680wrs.10
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 05:43:13 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Nov 2022 14:42:59 +0100
Message-Id: <20221122134301.69258-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/4] lru_cache: remove compiled out code
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

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 lib/lru_cache.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index fec899386238..5dd5e4c00a23 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -60,17 +60,6 @@ int lc_try_lock(struct lru_cache *lc)
 	} while (unlikely (val == LC_PARANOIA));
 	/* Spin until no-one is inside a PARANOIA_ENTRY()/RETURN() section. */
 	return 0 == val;
-#if 0
-	/* Alternative approach, spin in case someone enters or leaves a
-	 * PARANOIA_ENTRY()/RETURN() section. */
-	unsigned long old, new, val;
-	do {
-		old = lc->flags & LC_PARANOIA;
-		new = old | LC_LOCKED;
-		val = cmpxchg(&lc->flags, old, new);
-	} while (unlikely (val == (old ^ LC_PARANOIA)));
-	return old == val;
-#endif
 }
 
 /**
-- 
2.38.1

