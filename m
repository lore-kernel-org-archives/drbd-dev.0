Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3CBC0105B1DE
	for <drbd-dev@lists.linbit.com>; Fri, 14 May 2010 08:07:47 +0200 (CEST)
Resent-Message-ID: <20100514060746.GA14070@soda.linbit>
Date: Thu, 13 May 2010 22:02:21 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	drbd-user@lists.linbit.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Message-ID: <Pine.LNX.4.64.1005132202040.6282@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] [PATCH 10/20] drivers/block/drbd: Use kzalloc
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than the combination of kmalloc and memset.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,size,flags;
statement S;
@@

-x = kmalloc(size,flags);
+x = kzalloc(size,flags);
 if (x == NULL) S
-memset(x, 0, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/block/drbd/drbd_nl.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1199,13 +1199,12 @@ static int drbd_nl_net_conf(struct drbd_
 	}
 
 	/* allocation not in the IO path, cqueue thread context */
-	new_conf = kmalloc(sizeof(struct net_conf), GFP_KERNEL);
+	new_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
 	if (!new_conf) {
 		retcode = ERR_NOMEM;
 		goto fail;
 	}
 
-	memset(new_conf, 0, sizeof(struct net_conf));
 	new_conf->timeout	   = DRBD_TIMEOUT_DEF;
 	new_conf->try_connect_int  = DRBD_CONNECT_INT_DEF;
 	new_conf->ping_int	   = DRBD_PING_INT_DEF;
