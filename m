Return-Path: <algonell@gmail.com>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5DB8A160650
	for <drbd-dev@lists.linbit.com>; Mon, 10 Feb 2025 12:13:30 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
	5b1f17b1804b1-43944c51e41so7772795e9.0
	for <drbd-dev@lists.linbit.com>; Mon, 10 Feb 2025 03:13:30 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] drbd: Fix typo in error directive
Date: Mon, 10 Feb 2025 13:13:05 +0200
Message-ID: <20250210111324.29407-1-algonell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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

There is a typo in error directive:
 - endianess -> endianness

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index cbaeb8018dbf..89d7c828eb59 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -106,7 +106,7 @@ union drbd_dev_state {
 		unsigned peer:2 ;   /* 3/4	 primary/secondary/unknown */
 		unsigned role:2 ;   /* 3/4	 primary/secondary/unknown */
 #else
-# error "this endianess is not supported"
+# error "this endianness is not supported"
 #endif
 	};
 	unsigned int i;
-- 
2.48.1.268.g9520f7d998

