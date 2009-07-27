Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 939261018D52
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2009 17:01:05 +0200 (CEST)
Resent-Message-ID: <20090727150105.GE8046@barkeeper1-xen.linbit>
Received: from acsinet11.oracle.com (acsinet11.oracle.com [141.146.126.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 14D811018D52
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2009 16:56:46 +0200 (CEST)
Date: Mon, 27 Jul 2009 07:55:36 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, drbd-dev@lists.linbit.com
Message-Id: <20090727075536.533d1801.randy.dunlap@oracle.com>
In-Reply-To: <20090727180552.eb32515b.sfr@canb.auug.org.au>
References: <20090727180552.eb32515b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH] drbd: fix build when CONFIG_MODULES=n
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, 27 Jul 2009 18:05:52 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20090724:
> 
> New trees:
> 	drbd
> 
> The drbd tree gained two build failures for which I reverted a commit from
> the rr tree and applied a patch.
> ----------------------------------------------------------------------------


(already fixed?)

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Fix drbd build when CONFIG_MODULES=n:
drivers/block/drbd/drbd_main.c:3738: error: dereferencing pointer to incomplete type

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20090727.orig/drivers/block/drbd/drbd_main.c
+++ linux-next-20090727/drivers/block/drbd/drbd_main.c
@@ -3733,12 +3733,16 @@ const char *drbd_buildtag(void)
 
 	static char buildtag[38] = "\0uilt-in";
 
+#ifdef CONFIG_MODULES
 	if (buildtag[0] == 0) {
 		if (THIS_MODULE != NULL)
 			sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
 		else
 			buildtag[0] = 'b';
 	}
+#else
+	buildtag[0] = 'b';
+#endif
 
 	return buildtag;
 }
