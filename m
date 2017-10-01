Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 89E611058018
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:14 +1100
Message-Id: <1506897256-14072-16-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/17] lru_cache: remove unnecessary space before
	arguments
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

checkpatch emits WARNING: Unnecessary space before function pointer
arguments.

Remove unnecessary space before function arguments.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 012c6b8..09fdb7c 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -654,7 +654,7 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
  * Note: a leading space ' ' and trailing newline '\n' is implied.
  */
 void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext,
-			 void (*detail) (struct seq_file *, struct lc_element *))
+			 void (*detail)(struct seq_file *, struct lc_element *))
 {
 	unsigned int nr_elements = lc->nr_elements;
 	struct lc_element *e;
-- 
2.7.4

