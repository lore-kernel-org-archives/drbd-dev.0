Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E1ED6106DCC2
	for <drbd-dev@lists.linbit.com>; Wed,  4 Apr 2012 16:23:23 +0200 (CEST)
Resent-Message-ID: <20120404142323.GE9163@barkeeper1-xen.linbit>
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue,  3 Apr 2012 14:13:36 +0800
Message-Id: <1333433616-8315-1-git-send-email-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: WANG Cong <xiyou.wangcong@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] =?utf-8?q?=5BPatch=5D_drbd=3A_check_MODULE_for_THIS=5F?=
	=?utf-8?q?MODULE?=
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

THIS_MODULE is NULL only when drbd is compiled as built-in,
so the #ifdef CONFIG_MODULES should be #ifdef MODULE instead.

This fixes the warning:

drivers/block/drbd/drbd_main.c: In function ‘drbd_buildtag’:
drivers/block/drbd/drbd_main.c:4187:24: warning: the comparison will always evaluate as ‘true’ for the address of ‘__this_module’ will never be NULL [-Waddress]

Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 211fc44..96c432f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -4183,12 +4183,11 @@ const char *drbd_buildtag(void)
 	static char buildtag[38] = "\0uilt-in";
 
 	if (buildtag[0] == 0) {
-#ifdef CONFIG_MODULES
-		if (THIS_MODULE != NULL)
-			sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-		else
+#ifdef MODULE
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
+#else
+		buildtag[0] = 'b';
 #endif
-			buildtag[0] = 'b';
 	}
 
 	return buildtag;
