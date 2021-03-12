Return-Path: <lee.jones@linaro.org>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D431942032D
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 11:55:40 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
	u5-20020a7bcb050000b029010e9316b9d5so11954358wmj.2
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 02:55:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Date: Fri, 12 Mar 2021 10:55:24 +0000
Message-Id: <20210312105530.2219008-6-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/11] block: drbd: drbd_receiver: Demote
	non-conformant kernel-doc headers
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

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_receiver.c:265: warning: Function parameter or member 'peer_device' not described in 'drbd_alloc_pages'
 drivers/block/drbd/drbd_receiver.c:265: warning: Excess function parameter 'device' description in 'drbd_alloc_pages'
 drivers/block/drbd/drbd_receiver.c:1362: warning: Function parameter or member 'connection' not described in 'drbd_may_finish_epoch'
 drivers/block/drbd/drbd_receiver.c:1362: warning: Excess function parameter 'device' description in 'drbd_may_finish_epoch'
 drivers/block/drbd/drbd_receiver.c:1451: warning: Function parameter or member 'resource' not described in 'drbd_bump_write_ordering'
 drivers/block/drbd/drbd_receiver.c:1451: warning: Function parameter or member 'bdev' not described in 'drbd_bump_write_ordering'
 drivers/block/drbd/drbd_receiver.c:1451: warning: Excess function parameter 'connection' description in 'drbd_bump_write_ordering'
 drivers/block/drbd/drbd_receiver.c:1643: warning: Function parameter or member 'op' not described in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:1643: warning: Function parameter or member 'op_flags' not described in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:1643: warning: Function parameter or member 'fault_type' not described in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:1643: warning: Excess function parameter 'rw' description in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:3055: warning: Function parameter or member 'peer_device' not described in 'drbd_asb_recover_0p'
 drivers/block/drbd/drbd_receiver.c:3138: warning: Function parameter or member 'peer_device' not described in 'drbd_asb_recover_1p'
 drivers/block/drbd/drbd_receiver.c:3195: warning: Function parameter or member 'peer_device' not described in 'drbd_asb_recover_2p'
 drivers/block/drbd/drbd_receiver.c:4684: warning: Function parameter or member 'peer_device' not described in 'receive_bitmap_plain'
 drivers/block/drbd/drbd_receiver.c:4684: warning: Function parameter or member 'size' not described in 'receive_bitmap_plain'
 drivers/block/drbd/drbd_receiver.c:4684: warning: Function parameter or member 'p' not described in 'receive_bitmap_plain'
 drivers/block/drbd/drbd_receiver.c:4684: warning: Function parameter or member 'c' not described in 'receive_bitmap_plain'
 drivers/block/drbd/drbd_receiver.c:4738: warning: Function parameter or member 'peer_device' not described in 'recv_bm_rle_bits'
 drivers/block/drbd/drbd_receiver.c:4738: warning: Function parameter or member 'p' not described in 'recv_bm_rle_bits'
 drivers/block/drbd/drbd_receiver.c:4738: warning: Function parameter or member 'c' not described in 'recv_bm_rle_bits'
 drivers/block/drbd/drbd_receiver.c:4738: warning: Function parameter or member 'len' not described in 'recv_bm_rle_bits'
 drivers/block/drbd/drbd_receiver.c:4807: warning: Function parameter or member 'peer_device' not described in 'decode_bitmap_c'
 drivers/block/drbd/drbd_receiver.c:4807: warning: Function parameter or member 'p' not described in 'decode_bitmap_c'
 drivers/block/drbd/drbd_receiver.c:4807: warning: Function parameter or member 'c' not described in 'decode_bitmap_c'
 drivers/block/drbd/drbd_receiver.c:4807: warning: Function parameter or member 'len' not described in 'decode_bitmap_c'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_receiver.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c3f09a122f20c..89818a5e0ac67 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -242,9 +242,9 @@ static void conn_reclaim_net_peer_reqs(struct drbd_connection *connection)
 
 /**
  * drbd_alloc_pages() - Returns @number pages, retries forever (or until signalled)
- * @device:	DRBD device.
- * @number:	number of pages requested
- * @retry:	whether to retry, if not enough pages are available right now
+ * @peer_device:	DRBD device.
+ * @number:		number of pages requested
+ * @retry:		whether to retry, if not enough pages are available right now
  *
  * Tries to allocate number pages, first from our own page pool, then from
  * the kernel.
@@ -1352,7 +1352,7 @@ static void drbd_flush(struct drbd_connection *connection)
 
 /**
  * drbd_may_finish_epoch() - Applies an epoch_event to the epoch's state, eventually finishes it.
- * @device:	DRBD device.
+ * @connection:	DRBD connection.
  * @epoch:	Epoch object.
  * @ev:		Epoch event.
  */
@@ -1441,9 +1441,8 @@ max_allowed_wo(struct drbd_backing_dev *bdev, enum write_ordering_e wo)
 	return wo;
 }
 
-/**
+/*
  * drbd_bump_write_ordering() - Fall back to an other write ordering method
- * @connection:	DRBD connection.
  * @wo:		Write ordering method to try.
  */
 void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backing_dev *bdev,
@@ -1623,7 +1622,6 @@ static void drbd_issue_peer_wsame(struct drbd_device *device,
  * drbd_submit_peer_request()
  * @device:	DRBD device.
  * @peer_req:	peer request
- * @rw:		flag field, see bio->bi_opf
  *
  * May spread the pages to multiple bios,
  * depending on bio_add_page restrictions.
@@ -3048,7 +3046,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	return -EIO;
 }
 
-/**
+/*
  * drbd_asb_recover_0p  -  Recover after split-brain with no remaining primaries
  */
 static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold(local)
@@ -3131,7 +3129,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 	return rv;
 }
 
-/**
+/*
  * drbd_asb_recover_1p  -  Recover after split-brain with one remaining primary
  */
 static int drbd_asb_recover_1p(struct drbd_peer_device *peer_device) __must_hold(local)
@@ -3188,7 +3186,7 @@ static int drbd_asb_recover_1p(struct drbd_peer_device *peer_device) __must_hold
 	return rv;
 }
 
-/**
+/*
  * drbd_asb_recover_2p  -  Recover after split-brain with two remaining primaries
  */
 static int drbd_asb_recover_2p(struct drbd_peer_device *peer_device) __must_hold(local)
@@ -4672,7 +4670,7 @@ static int receive_sync_uuid(struct drbd_connection *connection, struct packet_i
 	return 0;
 }
 
-/**
+/*
  * receive_bitmap_plain
  *
  * Return 0 when done, 1 when another iteration is needed, and a negative error
@@ -4724,7 +4722,7 @@ static int dcbp_get_pad_bits(struct p_compressed_bm *p)
 	return (p->encoding >> 4) & 0x7;
 }
 
-/**
+/*
  * recv_bm_rle_bits
  *
  * Return 0 when done, 1 when another iteration is needed, and a negative error
@@ -4793,7 +4791,7 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 	return (s != c->bm_bits);
 }
 
-/**
+/*
  * decode_bitmap_c
  *
  * Return 0 when done, 1 when another iteration is needed, and a negative error
-- 
2.27.0

