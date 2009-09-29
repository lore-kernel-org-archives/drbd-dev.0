Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 29 Sep 2009 17:32:50 +0200
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
	<4ABD4C28.9070202@oracle.com>
In-Reply-To: <4ABD4C28.9070202@oracle.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200909291732.51383.philipp.reisner@linbit.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH -next] drbd: trace depends on TRACING
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Saturday 26 September 2009 01:03:04 Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> DRBD_TRACE should depend on TRACING.
> It's also possible that TRACEPOINTS should depend on TRACING.
>

Hi Randy,

I tried to figure out in which way that should be done. By looking
at "BLK_DEV_IO_TRACE" I got the impression that this should
be done by adding "select GENERIC_TRACER".

I will further examine this tomorrow. I just wanted to let you know
that this did not fall off the table...

-Phil

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 4e6f90f..7b35287 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -7,7 +7,7 @@ comment "DRBD disabled because PROC_FS, INET or CONNECTOR not 
selected"

 config BLK_DEV_DRBD
        tristate "DRBD Distributed Replicated Block Device support"
-       depends on PROC_FS && INET && CONNECTOR
+       depends on BLOCK && PROC_FS && INET && CONNECTOR
        select LRU_CACHE
        default n
        help
@@ -42,6 +42,7 @@ config DRBD_TRACE
        tristate "DRBD tracing"
        depends on BLK_DEV_DRBD
        select TRACEPOINTS
+       select GENERIC_TRACER
        default n
        help
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

