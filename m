Return-Path: <Julia.Lawall@inria.fr>
Received: from mail2-relais-roc.national.inria.fr
	(mail2-relais-roc.national.inria.fr [192.134.164.83])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2583B42012B
	for <drbd-dev@lists.linbit.com>; Mon, 30 Sep 2024 13:28:32 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 06/35] lru_cache: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:52 +0200
Message-Id: <20240930112121.95324-7-Julia.Lawall@inria.fr>
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 lib/lru_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 9e0d469c7658..40f22213c3b3 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -576,8 +576,8 @@ struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i)
 
 /**
  * lc_seq_dump_details - Dump a complete LRU cache to seq in textual form.
- * @lc: the lru cache to operate on
  * @seq: the &struct seq_file pointer to seq_printf into
+ * @lc: the lru cache to operate on
  * @utext: user supplied additional "heading" or other info
  * @detail: function pointer the user may provide to dump further details
  * of the object the lc_element is embedded in. May be NULL.

