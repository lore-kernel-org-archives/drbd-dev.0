Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D0D0B1028A59
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 12:09:01 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:39:04 +0800
Message-Id: <1436776744-3135-11-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 10/10] drbd: Handle new-current-uuid
	--zap-devices
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

Zap devices for zeroing out device on both side
instead of initial full sync.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_nl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 1d17663..131f112 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -4068,7 +4068,7 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 	drbd_uuid_set(device, UI_BITMAP, 0); /* Rotate UI_BITMAP to History 1, etc... */
 	drbd_uuid_new_current(device); /* New current, previous to UI_BITMAP */
 
-	if (args.clear_bm) {
+	if (args.clear_bm || args.zap_devices) {
 		err = drbd_bitmap_io(device, &drbd_bmio_clear_n_write,
 			"clear_n_write from new_c_uuid", BM_LOCKED_MASK);
 		if (err) {
@@ -4084,6 +4084,16 @@ int drbd_adm_new_c_uuid(struct sk_buff *skb, struct genl_info *info)
 					CS_VERBOSE, NULL);
 			spin_unlock_irq(&device->resource->req_lock);
 		}
+		if (zero_out_devices) {
+			drbd_send_zero_out_start(first_peer_device(device));
+			_drbd_uuid_set(device, UI_BITMAP, 0);
+			drbd_print_uuids(device, "cleared bitmap UUID for zeroing device");
+
+			/* CLear bit flag of zero out */
+			clear_bit(ZERO_DONE, &device->flags);
+			clear_bit(ZERO_FAIL, &device->flags);
+			drbd_device_post_work(device, P_ZERO_START);
+		}
 	}
 
 	drbd_md_sync(device);
-- 
1.8.4.5

