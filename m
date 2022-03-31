Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
	[209.85.218.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CB0EE4205A5
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 15:45:58 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id bg10so48226236ejb.4
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 06:45:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 31 Mar 2022 15:42:36 +0200
Message-Id: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] MAINTAINERS: add drbd co-maintainer
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

In light of the recent controversy surrounding the (lack of)
maintenance of the in-tree DRBD driver, we have decided to add myself
as co-maintainer. This allows us to better distribute the workload and
reduce the chance of patches getting lost.

I will be keeping an eye on the mailing list in order to ensure that all
patches get the attention they need.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53df75660f16..b1f5f034b2ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6038,6 +6038,7 @@ F:	drivers/scsi/dpt/
 DRBD DRIVER
 M:	Philipp Reisner <philipp.reisner@linbit.com>
 M:	Lars Ellenberg <lars.ellenberg@linbit.com>
+M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
 L:	drbd-dev@lists.linbit.com
 S:	Supported
 W:	http://www.drbd.org
-- 
2.35.1

