Return-Path: <lijinlin3@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 22E07420629
	for <drbd-dev@lists.linbit.com>;
	Fri, 10 Dec 2021 06:05:51 +0100 (CET)
From: Li Jinlin <lijinlin3@huawei.com>
To: <song@kernel.org>, <philipp.reisner@linbit.com>,
	<lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
	<jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<mcgrof@kernel.org>, <mcroce@microsoft.com>
Date: Fri, 10 Dec 2021 13:17:07 +0800
Message-ID: <20211210051707.2202646-4-lijinlin3@huawei.com>
In-Reply-To: <20211210051707.2202646-1-lijinlin3@huawei.com>
References: <20211210051707.2202646-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
	linfeilong@huawei.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/3] drdb: Remove useless variable in struct
	drbd_device
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

rs_last_sect_ev is unused since added in 1d7734a0df02, so just remove it.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 drivers/block/drbd/drbd_int.h    | 1 -
 drivers/block/drbd/drbd_main.c   | 1 -
 drivers/block/drbd/drbd_state.c  | 1 -
 drivers/block/drbd/drbd_worker.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1b71adc07e83..a163141aff1b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -955,7 +955,6 @@ struct drbd_device {
 	char congestion_reason;  /* Why we where congested... */
 	atomic_t rs_sect_in; /* for incoming resync data rate, SyncTarget */
 	atomic64_t rs_sect_ev; /* for submitted resync data rate, both */
-	int rs_last_sect_ev; /* counter to compare with */
 	s64 rs_last_events;  /* counter of read or write "events" (unit sectors)
 			      * on the lower level device when we last looked. */
 	int c_sync_rate; /* current resync rate after syncer throttle magic */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ea057bd60541..f1fa03c69809 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2046,7 +2046,6 @@ void drbd_device_cleanup(struct drbd_device *device)
 	device->rs_total     =
 	device->rs_failed    = 0;
 	device->rs_last_events = 0;
-	device->rs_last_sect_ev = 0;
 	for (i = 0; i < DRBD_SYNC_MARKS; i++) {
 		device->rs_mark_left[i] = 0;
 		device->rs_mark_time[i] = 0;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..4a6c69133c62 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1389,7 +1389,6 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 		set_ov_position(device, ns.conn);
 		device->rs_start = now;
-		device->rs_last_sect_ev = 0;
 		device->ov_last_oos_size = 0;
 		device->ov_last_oos_start = 0;
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index a4edd0a9c875..45ae4abd355a 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1829,7 +1829,6 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		device->rs_failed    = 0;
 		device->rs_paused    = 0;
 		device->rs_same_csum = 0;
-		device->rs_last_sect_ev = 0;
 		device->rs_total     = tw;
 		device->rs_start     = now;
 		for (i = 0; i < DRBD_SYNC_MARKS; i++) {
-- 
2.27.0

