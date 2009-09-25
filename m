Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 46DCD1012A9D
	for <drbd-dev@lists.linbit.com>; Mon, 28 Sep 2009 10:52:19 +0200 (CEST)
Resent-Message-ID: <20090928085219.GC8048@barkeeper1-xen.linbit>
Received: from acsinet12.oracle.com (acsinet12.oracle.com [141.146.126.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 57A75106E9A7
	for <drbd-dev@lists.linbit.com>; Sat, 26 Sep 2009 01:02:47 +0200 (CEST)
Message-ID: <4ABD4C28.9070202@oracle.com>
Date: Fri, 25 Sep 2009 16:03:04 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
In-Reply-To: <20090925133830.1ba29584.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH -next] drbd: trace depends on TRACING
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

DRBD_TRACE should depend on TRACING.
It's also possible that TRACEPOINTS should depend on TRACING.

arch/x86/built-in.o: In function `default_idle':
(.text+0x145a1): undefined reference to `__tracepoint_power_start'
arch/x86/built-in.o: In function `default_idle':
(.text+0x145d4): undefined reference to `__tracepoint_power_start'
arch/x86/built-in.o: In function `mwait_idle_with_hints':
(.text+0x1583d): undefined reference to `__tracepoint_power_start'
arch/x86/built-in.o: In function `mwait_idle_with_hints':
(.text+0x15870): undefined reference to `__tracepoint_power_start'
arch/x86/built-in.o: In function `mwait_idle':
process.c:(.text+0x15b92): undefined reference to `__tracepoint_power_start'
arch/x86/built-in.o:process.c:(.text+0x15bbe): more undefined references to `__tracepoint_power_start' follow
arch/x86/built-in.o: In function `poll_idle':
process.c:(.text+0x160bd): undefined reference to `__tracepoint_power_end'
process.c:(.text+0x160e9): undefined reference to `__tracepoint_power_end'
drivers/built-in.o: In function `cpuidle_idle_call':
cpuidle.c:(.text+0x517f16): undefined reference to `__tracepoint_power_end'
cpuidle.c:(.text+0x517f49): undefined reference to `__tracepoint_power_end'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/block/drbd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20090925.orig/drivers/block/drbd/Kconfig
+++ linux-next-20090925/drivers/block/drbd/Kconfig
@@ -40,7 +40,7 @@ config BLK_DEV_DRBD
 
 config DRBD_TRACE
 	tristate "DRBD tracing"
-	depends on BLK_DEV_DRBD
+	depends on BLK_DEV_DRBD && TRACING
 	select TRACEPOINTS
 	default n
 	help
