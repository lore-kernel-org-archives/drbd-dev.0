Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C2681062644
	for <drbd-dev@lists.linbit.com>; Tue, 15 Dec 2009 23:20:18 +0100 (CET)
Resent-Message-ID: <20091215222017.GD19038@barkeeper1-xen.linbit>
Message-ID: <4B2805E0.2080304@gmail.com>
Date: Tue, 15 Dec 2009 22:55:44 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH] drbd: Fix test of unsigned in
	_drbd_fault_random()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

rsp->count is unsigned so the test does not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 157d1e4..c2594c1 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3623,7 +3623,7 @@ _drbd_fault_random(struct fault_random_state *rsp)
 {
 	long refresh;
 
-	if (--rsp->count < 0) {
+	if (!rsp->count--) {
 		get_random_bytes(&refresh, sizeof(refresh));
 		rsp->state += refresh;
 		rsp->count = FAULT_RANDOM_REFRESH;
