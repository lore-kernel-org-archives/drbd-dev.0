Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4CD3D1058012
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:41:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:01 +1100
Message-Id: <1506897256-14072-3-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/17] lru_cache: fix licence comment format
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

checkpatch emits WARNING: Block comments use * on subsequent lines

Add '*' to each subsequent line of licence comment.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 44d7ab0..273af4b 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -1,21 +1,21 @@
 /*
-   lru_cache.c
-
-   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-
-   Copyright (C) 2003-2008, LINBIT Information Technologies GmbH.
-   Copyright (C) 2003-2008, Philipp Reisner <philipp.reisner@linbit.com>.
-   Copyright (C) 2003-2008, Lars Ellenberg <lars.ellenberg@linbit.com>.
-
-   drbd is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2, or (at your option)
-   any later version.
-
-   drbd is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
+ *   lru_cache.c
+ *
+ *   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
+ *
+ *   Copyright (C) 2003-2008, LINBIT Information Technologies GmbH.
+ *   Copyright (C) 2003-2008, Philipp Reisner <philipp.reisner@linbit.com>.
+ *   Copyright (C) 2003-2008, Lars Ellenberg <lars.ellenberg@linbit.com>.
+ *
+ *   drbd is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2, or (at your option)
+ *   any later version.
+ *
+ *   drbd is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
  */
 
 #include <linux/module.h>
-- 
2.7.4

