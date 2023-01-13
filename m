Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EC8F8422117
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 13:35:48 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id qk9so52025534ejc.3
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 04:35:48 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2023 13:35:37 +0100
Message-Id: <20230113123538.144276-8-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 7/8] drbd: interval tree: make removing an
	"empty" interval a no-op
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Trying to remove an "empty" (just initialized, or "cleared") interval
from the tree, this results in an endless loop.

As we typically protect the tree with a spinlock_irq,
the result is a hung system.

Be nice to error cleanup code paths, ignore removal of empty intervals.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 5024ffd6143d..b6aaf0d4d85b 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -95,6 +95,10 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 void
 drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 {
+	/* avoid endless loop */
+	if (drbd_interval_empty(this))
+		return;
+
 	rb_erase_augmented(&this->rb, root, &augment_callbacks);
 }
 
-- 
2.38.1

