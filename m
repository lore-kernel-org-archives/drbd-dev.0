Return-Path: <shixinhe6@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 48711160963
	for <drbd-dev@lists.linbit.com>; Sun, 29 Dec 2024 05:28:07 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id
	d9443c01a7336-21644aca3a0so2402625ad.3
	for <drbd-dev@lists.linbit.com>; Sat, 28 Dec 2024 20:28:07 -0800 (PST)
From: Shi Xinhe <shixinhe6@gmail.com>
To: minchan@kernel.org
Subject: [PATCH] Documentation zram: fix description about huge page writeback
	example
Message-Id: <20241229042758.163842-1-shixinhe6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
	Shi Xinhe <shixinhe6@gmail.com>, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
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
Date: Sun, 29 Dec 2024 04:28:08 -0000

Corrected the description to accurately reflect that huge page writeback example.

Signed-off-by: Shi Xinhe <shixinhe6@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 1576fb93f06c..48ba192e667b 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -343,7 +343,7 @@ To use the feature, admin should set up backing device via::
 	echo /dev/sda5 > /sys/block/zramX/backing_dev
 
 before disksize setting. It supports only partitions at this moment.
-If admin wants to use incompressible page writeback, they could do it via::
+If admin wants to use huge page writeback, they could do it via::
 
 	echo huge > /sys/block/zramX/writeback
 
-- 
2.34.1

