Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 252511055F71
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:57:01 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:43 +0200
Message-Id: <1438693003-17554-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/19] MAINTAINERS: Updated information for DRBD
	DRIVER
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

From: Roland Kammerer <roland.kammerer@linbit.com>

- Changed obsoleted 'P' to 'M' entries.
- Removed the user related mailing list.
- Changed git repos to current versions

Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9289ecb..d5ce1c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3472,13 +3472,12 @@ F:	drivers/scsi/dpt*
 F:	drivers/scsi/dpt/
 
 DRBD DRIVER
-P:	Philipp Reisner
-P:	Lars Ellenberg
-M:	drbd-dev@lists.linbit.com
-L:	drbd-user@lists.linbit.com
+M:	Philipp Reisner <philipp.reisner@linbit.com>
+M:	Lars Ellenberg <lars.ellenberg@linbit.com>
+L:	drbd-dev@lists.linbit.com
 W:	http://www.drbd.org
-T:	git git://git.drbd.org/linux-2.6-drbd.git drbd
-T:	git git://git.drbd.org/drbd-8.3.git
+T:	git git://git.linbit.com/linux-drbd.git
+T:	git git://git.linbit.com/drbd-8.4.git
 S:	Supported
 F:	drivers/block/drbd/
 F:	lib/lru_cache.c
-- 
1.9.1

