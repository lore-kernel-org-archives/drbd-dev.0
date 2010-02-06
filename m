Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1876B105E553
	for <drbd-dev@lists.linbit.com>; Tue,  9 Feb 2010 10:41:49 +0100 (CET)
Resent-Message-ID: <20100209094148.GE20163@soda.linbit>
Date: Sat, 6 Feb 2010 09:43:21 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	drbd-user@lists.linbit.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Message-ID: <Pine.LNX.4.64.1002060943040.8092@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] [PATCH 5/11] drivers/block/drbd: Correct NULL test
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Test the value that was just allocated rather than the previously tested one.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression *x;
expression e;
identifier l;
@@

if (x == NULL || ...) {
    ... when forall
    return ...; }
... when != goto l;
    when != x = e
    when != &x
*x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/block/drbd/drbd_main.c      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ab871e0..d0c38a6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2770,7 +2770,7 @@ static int drbd_create_mempools(void)
 
 	drbd_ee_mempool = mempool_create(number,
 		mempool_alloc_slab, mempool_free_slab, drbd_ee_cache);
-	if (drbd_request_mempool == NULL)
+	if (drbd_ee_mempool == NULL)
 		goto Enomem;
 
 	/* drbd's page pool */
