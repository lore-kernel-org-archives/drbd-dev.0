Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DAEC5101E043
	for <drbd-dev@lists.linbit.com>; Sun, 26 Jul 2009 16:46:49 +0200 (CEST)
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id n6QEaFxK030627
	for <drbd-dev@lists.linbit.com>; Sun, 26 Jul 2009 07:36:16 -0700
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 26 Jul 2009 16:36:00 +0200
Message-Id: <1248618960-3269-1-git-send-email-iustin@google.com>
Cc: Iustin Pop <iustin@google.com>
Subject: [Drbd-dev] [PATCH] drbdmeta: also show negotiated size in sectors
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Currently drbdmeta shows the last agreed size in "nice" units, e.g.
100GB. But this is imprecise, as the shifting of cfg->md.la_sect loses
the low-order bits.

This small patch adds a new line to the output of drbdmeta that shows
the exact negotiated size in sectors (for both new and initialized
devices), such that the output of drbdmeta can be parsed.
---
 This is against drbd 8.3 but should apply (and I would be grateful if this is
 applied) to 8.0 too.

 thanks,
 iustin

 user/drbdmeta.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/user/drbdmeta.c b/user/drbdmeta.c
index 00b269d..ca72c96 100644
--- a/user/drbdmeta.c
+++ b/user/drbdmeta.c
@@ -1481,6 +1481,8 @@ int meta_show_gi(struct format *cfg, char **argv __attribute((unused)), int argc
 	} else {
 		printf("zero size device -- never seen peer yet?\n");
 	}
+	printf("last agreed size in sectors: %zd\n",
+               cfg->md.la_sect);
 
 	return cfg->ops->close(cfg);
 }
-- 
1.6.3.3

