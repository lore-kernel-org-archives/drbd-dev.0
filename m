Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 01ED11028A54
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:27 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:34 +0100
Message-Id: <1448448851-10343-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/38] MAINTAINERS: Updated information for DRBD
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
index 050d0e7..2ea2604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3592,13 +3592,12 @@ F:	drivers/scsi/dpt*
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

