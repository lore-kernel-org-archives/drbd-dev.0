Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ECF91105800A
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:06 +1100
Message-Id: <1506897256-14072-8-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/17] lru_cache: clean macro definition
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

checkpatch emits ERROR: trailing statements should be on next line.
Also macro definition is slightly cluttered. If we lay the definition
out more cleanly the code is easier to read.

Clean macro definition, clearing checkpatch error.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 18043b9..c15df31 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -44,13 +44,14 @@ MODULE_LICENSE("GPL");
 	return x ; } while (0)
 
 /* BUG() if e is not one of the elements tracked by lc */
-#define PARANOIA_LC_ELEMENT(lc, e) do {	\
-	struct lru_cache *lc_ = (lc);	\
-	struct lc_element *e_ = (e);	\
-	unsigned int i = e_->lc_index;	\
-	BUG_ON(i >= lc_->nr_elements);	\
-	BUG_ON(lc_->lc_element[i] != e_); } while (0)
-
+#define PARANOIA_LC_ELEMENT(lc, e)			\
+	do {						\
+		struct lru_cache *lc_ = (lc);		\
+		struct lc_element *e_ = (e);		\
+		unsigned int i = e_->lc_index;		\
+		BUG_ON(i >= lc_->nr_elements);		\
+		BUG_ON(lc_->lc_element[i] != e_);	\
+	} while (0)
 
 /* We need to atomically
  *  - try to grab the lock (set LC_LOCKED)
-- 
2.7.4

