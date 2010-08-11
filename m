Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 333F61067A16
	for <drbd-dev@lists.linbit.com>; Thu, 12 Aug 2010 00:53:14 +0200 (CEST)
Resent-Message-ID: <20100811225313.GE9120@barkeeper1-xen.linbit>
Date: Thu, 12 Aug 2010 00:38:45 +0200
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20100811223845.GE645@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <jaxboe@fusionio.com>, kernel-janitors@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [patch] drbd: cleanup: change "<= 0" to "== 0"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

dt is unsigned so it's never less than zero.  We are calculating the
elapsed time, and that's never less than zero (unless there is a bug or
we invent time travel).  The comparison here is just to guard against
divide by zero bugs.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index be3374b..4c0c4aa 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -118,7 +118,7 @@ static void drbd_syncer_progress(struct drbd_conf *mdev, struct seq_file *seq)
 	/* mean speed since syncer started
 	 * we do account for PausedSync periods */
 	dt = (jiffies - mdev->rs_start - mdev->rs_paused) / HZ;
-	if (dt <= 0)
+	if (dt == 0)
 		dt = 1;
 	db = mdev->rs_total - rs_left;
 	dbdt = Bit2KB(db/dt);
