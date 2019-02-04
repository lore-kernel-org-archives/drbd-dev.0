Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C5B17103B4D0
	for <drbd-dev@lists.linbit.com>; Mon,  4 Feb 2019 22:00:22 +0100 (CET)
From: Johannes Thoma <johannes@johannesthoma.com>
To: drbd-dev@lists.linbit.com
Date: Mon,  4 Feb 2019 22:00:15 +0100
Message-Id: <20190204210015.7457-2-johannes@johannesthoma.com>
In-Reply-To: <20190204210015.7457-1-johannes@johannesthoma.com>
References: <20190204210015.7457-1-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH 2/2] windrbd: Include stdbool.h for bool type.
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

It seems that windrbd tool didn't compile before.

Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
---
 user/windrbd/windrbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/user/windrbd/windrbd.c b/user/windrbd/windrbd.c
index 28385cf5..2602f599 100644
--- a/user/windrbd/windrbd.c
+++ b/user/windrbd/windrbd.c
@@ -18,6 +18,7 @@
 #include <ctype.h>
 #include <sys/queue.h>
 #include <assert.h>
+#include <stdbool.h>
 
 #include <winioctl.h>
 #include <shellapi.h>
-- 
2.17.0

