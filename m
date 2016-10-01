Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F3840105646A
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D102E2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DxexCVTSK9mZ for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AC9AF47E26D
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tjs11GPU_Chb for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8159B2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:23 +0200 (CEST)
Resent-Message-ID: <20161003144623.GH3302@soda.linbit>
Received: from mail3-relais-sop.national.inria.fr
	(mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0E8ED105646B
	for <drbd-dev@lists.linbit.com>; Sat,  1 Oct 2016 22:14:58 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Sat,  1 Oct 2016 21:46:21 +0200
Message-Id: <1475351192-27079-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/15] lru_cache: improve function-level
	documentation
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

Use the actual function name and reorder the listed variables to correspond
to their order in the function parameter list.

Issue detected using Coccinelle (http://coccinelle.lip6.fr/)

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 lib/lru_cache.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 28ba40b..07d3507 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -639,9 +639,9 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
 }
 
 /**
- * lc_dump - Dump a complete LRU cache to seq in textual form.
- * @lc: the lru cache to operate on
+ * lc_seq_dump_details - Dump a complete LRU cache to seq in textual form.
  * @seq: the &struct seq_file pointer to seq_printf into
+ * @lc: the lru cache to operate on
  * @utext: user supplied additional "heading" or other info
  * @detail: function pointer the user may provide to dump further details
  * of the object the lc_element is embedded in. May be NULL.

