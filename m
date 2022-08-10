Return-Path: <sanpeqf@gmail.com>
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
	[209.85.216.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CCC47420667
	for <drbd-dev@lists.linbit.com>; Wed, 10 Aug 2022 18:23:34 +0200 (CEST)
Received: by mail-pj1-f68.google.com with SMTP id
	o3-20020a17090a0a0300b001f7649cd317so2718456pjo.0
	for <drbd-dev@lists.linbit.com>; Wed, 10 Aug 2022 09:23:34 -0700 (PDT)
From: John Sanpe <sanpeqf@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Date: Thu, 11 Aug 2022 00:23:01 +0800
Message-Id: <20220810162301.201540-1-sanpeqf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: John Sanpe <sanpeqf@gmail.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] lib/ubsan: add missing line feed of
	alignment-assumption.
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

Added three missing '\n' to pr_err format.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/ubsan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 36bd75e33426..705250ba88bf 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -371,14 +371,14 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
 	ubsan_prologue(&data->location, "alignment-assumption");
 
 	if (offset)
-		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
+		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed\n",
 		       align, offset, data->type->type_name);
 	else
-		pr_err("assumption of %lu byte alignment for pointer of type %s failed",
+		pr_err("assumption of %lu byte alignment for pointer of type %s failed\n",
 		       align, data->type->type_name);
 
 	real_ptr = ptr - offset;
-	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
+	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes\n",
 	       offset ? "offset " : "", BIT(real_ptr ? __ffs(real_ptr) : 0),
 	       real_ptr & (align - 1));
 
-- 
2.36.1

