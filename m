Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9EA131058015
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:15 +1100
Message-Id: <1506897256-14072-17-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/17] lru_cache: add spaces around '|'
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

checkpatch emits CHECK: spaces preferred around that '|' (ctx:VxV)

Add spaces around '|'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 09fdb7c..5acfbe0 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -518,7 +518,8 @@ struct lc_element *lc_get(struct lru_cache *lc, unsigned int enr)
  */
 struct lc_element *lc_get_cumulative(struct lru_cache *lc, unsigned int enr)
 {
-	return __lc_get(lc, enr, LC_GET_MAY_CHANGE|LC_GET_MAY_USE_UNCOMMITTED);
+	return __lc_get(lc, enr,
+			LC_GET_MAY_CHANGE | LC_GET_MAY_USE_UNCOMMITTED);
 }
 
 /**
-- 
2.7.4

