Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2BC89106DCC0
	for <drbd-dev@lists.linbit.com>; Tue, 20 Mar 2012 21:00:10 +0100 (CET)
Resent-Message-ID: <20120320200009.GG4969@barkeeper1-xen.linbit>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Date: Mon, 19 Mar 2012 17:11:27 +0100
Message-Id: <1332173487-14167-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block/drbd: simplify drbd_buildtag fixing a
	build warning
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This fixes:
	drivers/block/drbd/drbd_main.c: In function ‘drbd_buildtag’:
	drivers/block/drbd/drbd_main.c:4187:24: warning: the comparison will always evaluate as ‘true’ for the address of ‘__this_module’ will never be NULL [-Waddress]

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/block/drbd/drbd_main.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 211fc44..9cc7178 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -4177,21 +4177,19 @@ _drbd_insert_fault(struct drbd_conf *mdev, unsigned int type)
 
 const char *drbd_buildtag(void)
 {
+#if IS_MODULE(CONFIG_BLK_DEV_DRBD)
 	/* DRBD built from external sources has here a reference to the
 	   git hash of the source code. */
 
-	static char buildtag[38] = "\0uilt-in";
+	static char buildtag[38] = "\0";
 
-	if (buildtag[0] == 0) {
-#ifdef CONFIG_MODULES
-		if (THIS_MODULE != NULL)
-			sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-		else
-#endif
-			buildtag[0] = 'b';
-	}
+	if (buildtag[0] == '\0')
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
 
 	return buildtag;
+#else
+	return "built-in";
+#endif
 }
 
 module_init(drbd_init)
-- 
1.7.9.1

