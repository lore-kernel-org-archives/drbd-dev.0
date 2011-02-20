Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A256A10576A5
	for <drbd-dev@lists.linbit.com>; Mon, 21 Feb 2011 09:25:40 +0100 (CET)
Resent-Message-ID: <20110221082540.GB20194@barkeeper1-xen.linbit>
Received: from mail-qw0-f54.google.com (mail-qw0-f54.google.com
	[209.85.216.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D3F1C1057660
	for <drbd-dev@lists.linbit.com>; Sun, 20 Feb 2011 23:45:41 +0100 (CET)
Received: by qwj9 with SMTP id 9so4781754qwj.27
	for <drbd-dev@lists.linbit.com>; Sun, 20 Feb 2011 14:45:39 -0800 (PST)
Sender: Ilia Mirkin <ibmirkin@gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
To: drbd-dev@lists.linbit.com
Date: Sun, 20 Feb 2011 17:45:14 -0500
Message-Id: <1298241914-1400-1-git-send-email-imirkin@alum.mit.edu>
Cc: linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [Drbd-dev] [PATCH] lru_cache: Use correct type in sizeof for
	allocation
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This has no actual effect, since sizeof(struct hlist_head) ==
sizeof(struct hlist_head *), but it's still the wrong type to use.

The semantic match that finds this problem:
// <smpl>
@@
type T;
identifier x;
@@
T *x;
...
* x = kzalloc(... * sizeof(T*) * ..., ...);
// </smpl>

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>

---
 lib/lru_cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Note that in lc_reset, there is the line

memset(lc->lc_slot, 0, sizeof(struct hlist_head) * lc->nr_elements);

So this seems correct. But otherwise untested.

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 270de9d..b312c8f 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -84,7 +84,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;
 
-	slot = kzalloc(e_count * sizeof(struct hlist_head*), GFP_KERNEL);
+	slot = kzalloc(e_count * sizeof(struct hlist_head), GFP_KERNEL);
 	if (!slot)
 		goto out_fail;
 	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);
-- 
1.7.3.4

