Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 784FA1058017
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:10 +1100
Message-Id: <1506897256-14072-12-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/17] lru_cache: remove multiple blank lines
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

checkpatch emits CHECK: Please don't use multiple blank lines.

Remove multiple blank lines.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index dc34bbc..b9cc261 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -260,7 +260,6 @@ static struct hlist_head *lc_hash_slot(struct lru_cache *lc, unsigned int enr)
 	return  lc->lc_slot + (enr % lc->nr_elements);
 }
 
-
 static struct lc_element *__lc_find(struct lru_cache *lc, unsigned int enr,
 				    bool include_changing)
 {
@@ -566,7 +565,6 @@ void lc_committed(struct lru_cache *lc)
 	RETURN();
 }
 
-
 /**
  * lc_put - give up refcnt of @e
  * @lc: the lru cache to operate on
-- 
2.7.4

