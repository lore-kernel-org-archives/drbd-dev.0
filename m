Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 31B4510556DB
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:55 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:39:01 +0800
Message-Id: <1436776744-3135-8-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 07/10] drbd: Flags for background drbd device
	work
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Background drbd device work for zeroing out device.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h    | 3 +++
 drbd/drbd_worker.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index dd680a9..287ffd7 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -622,6 +622,9 @@ enum {
 	RS_START,		/* tell worker to start resync/OV */
 	RS_PROGRESS,		/* tell worker that resync made significant progress */
 	RS_DONE,		/* tell worker that resync is done */
+	P_ZERO_START,		/* tell worker to zero out device */
+	S_ZERO_START,		/* tell worker to zero out device as requested*/
+
 	/* used for zero out device */
 	ZERO_DONE,		/* succeed on zero out a device */
 	ZERO_FAIL,		/* fail to zero out a device */
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 293aa27..23e82c1 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -2070,6 +2070,10 @@ static void do_device_work(struct drbd_device *device, const unsigned long todo)
 		drbd_ldev_destroy(device);
 	if (test_bit(RS_START, &todo))
 		do_start_resync(device);
+	if (test_bit(P_ZERO_START, &todo))
+		require_zero_out_local_device(device);
+	if (test_bit(S_ZERO_START, &todo))
+		receive_zero_out_local_device(device);
 }
 
 #define DRBD_DEVICE_WORK_MASK	\
@@ -2079,6 +2083,8 @@ static void do_device_work(struct drbd_device *device, const unsigned long todo)
 	|(1UL << RS_START)	\
 	|(1UL << RS_PROGRESS)	\
 	|(1UL << RS_DONE)	\
+	|(1UL << P_ZERO_START)	\
+	|(1UL << S_ZERO_START)	\
 	)
 
 static unsigned long get_work_bits(unsigned long *flags)
-- 
1.8.4.5

