Return-Path: <richard120310@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A8195420178
	for <drbd-dev@lists.linbit.com>; Mon, 11 Mar 2024 04:08:00 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
	d9443c01a7336-1dcf0d7dc8bso3171245ad.0
	for <drbd-dev@lists.linbit.com>; Sun, 10 Mar 2024 20:08:00 -0700 (PDT)
From: I-HSIN CHENG <richard120310@gmail.com>
To: philipp.reisner@linbit.com
Subject: [PATCH] lru_cache: Initialize hlist_head in lc_create
Date: Mon, 11 Mar 2024 11:07:35 +0800
Message-Id: <20240311030735.233470-1-richard120310@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lars.ellenberg@linbit.com, I-HSIN CHENG <richard120310@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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

Use INIT_HLIST_HEAD to perform the initialization for each pointer to
struct list_head in the variable "slot" to provide more safety and
prevent possible bugs from uninitialized behavior.

Signed-off-by: I-HSIN CHENG <richard120310@gmail.com>
---
 lib/lru_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d918761..f2197aae1 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -105,6 +105,9 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	if (!lc)
 		goto out_fail;
 
+	for (int i = 0; i < e_count; i++)
+		INIT_HLIST_HEAD(slot + (i * sizeof(struct hlist_head)));
+
 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
 	INIT_LIST_HEAD(&lc->free);
-- 
2.34.1

