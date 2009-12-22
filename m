Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 27AC21061700
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2009 18:33:16 +0100 (CET)
Resent-Message-ID: <20091222173315.GJ4717@barkeeper1-xen.linbit>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 50AEE1072E8B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2009 01:32:21 +0100 (CET)
Message-Id: <200912220027.nBM0Rrsj005415@imap1.linux-foundation.org>
To: jens.axboe@oracle.com
From: akpm@linux-foundation.org
Date: Mon, 21 Dec 2009 16:27:52 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Cc: akpm@linux-foundation.org, roel.kluin@gmail.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch 5/5] drbd: fix test of unsigned in
	_drbd_fault_random()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Roel Kluin <roel.kluin@gmail.com>

rsp->count is unsigned so the test does not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/drbd/drbd_main.c~drbd-fix-test-of-unsigned-in-_drbd_fault_random drivers/block/drbd/drbd_main.c
--- a/drivers/block/drbd/drbd_main.c~drbd-fix-test-of-unsigned-in-_drbd_fault_random
+++ a/drivers/block/drbd/drbd_main.c
@@ -3623,7 +3623,7 @@ _drbd_fault_random(struct fault_random_s
 {
 	long refresh;
 
-	if (--rsp->count < 0) {
+	if (!rsp->count--) {
 		get_random_bytes(&refresh, sizeof(refresh));
 		rsp->state += refresh;
 		rsp->count = FAULT_RANDOM_REFRESH;
_
