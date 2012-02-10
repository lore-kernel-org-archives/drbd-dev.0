Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 039931019A4E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Feb 2012 20:39:37 +0100 (CET)
Resent-Message-ID: <20120210193931.GC1817@barkeeper1-xen.linbit>
From: Danny Kukawka <danny.kukawka@bisect.de>
To: drbd-dev@lists.linbit.com
Date: Fri, 10 Feb 2012 18:03:53 +0100
Message-Id: <1328893433-28017-1-git-send-email-danny.kukawka@bisect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <phil@linbit.com>, Lars Ellenberg <lars@linbit.com>,
	Danny Kukawka <dkukawka@suse.de>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: fix -Waddress warning
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Fix for:
drivers/block/drbd/drbd_main.c: In function ‘drbd_buildtag’:
drivers/block/drbd/drbd_main.c:4187:19: warning: the comparison will
 always evaluate as ‘true’ for the address of ‘__this_module’ will
 never be NULL [-Waddress]

Remove "THIS_MODULE != NULL" check since always true and move else 
block to #else.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/block/drbd/drbd_main.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 211fc44..36a51ac 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -4184,11 +4184,10 @@ const char *drbd_buildtag(void)
 
 	if (buildtag[0] == 0) {
 #ifdef CONFIG_MODULES
-		if (THIS_MODULE != NULL)
-			sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-		else
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
+#else
+		buildtag[0] = 'b';
 #endif
-			buildtag[0] = 'b';
 	}
 
 	return buildtag;
-- 
1.7.7.3

