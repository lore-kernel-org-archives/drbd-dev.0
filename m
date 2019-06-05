Return-Path: <dab21774@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 520591028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:15:29 +0200 (CEST)
Received: by mail-it1-f195.google.com with SMTP id l21so4377509ita.2
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:15:29 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	l11sm1385633ioj.32.2019.06.05.09.15.28
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:15:28 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <28397d5c-72ca-e4b5-fb00-7b55466e7441@gmail.com>
Date: Wed, 5 Jun 2019 10:15:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] main.c comments
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

These three comments about main.c are the end of what I have on DRBD for now.

Three more things I noticed in drbd_main.c:

(1) Isn't the third argument to module_param_named() supposed to be the type of
    the second argument?  (But seems to require it as a single token??)

(2) The cast avoids a compiler warning about signed/unsigned comparison.

(3) q->queue_lock is needed by blk_queue_flag_set(), even if !defined(blk_queue_plugged),
    so I would move its initialization outside the #ifdef blk_queue_plugged.

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 4204deff..69245c57 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -146,7 +153,7 @@ const struct kernel_param_ops param_ops_drbd_protocol_version = {
 #endif

 unsigned int drbd_protocol_version_min = PRO_VERSION_MIN;
-module_param_named(protocol_version_min, drbd_protocol_version_min, drbd_protocol_version, 0644);
+module_param_named(protocol_version_min, drbd_protocol_version_min, uint, 0644);


 /* in 2.6.x, our device mapping and config info contains our virtual gendisks
@@ -1831,7 +1840,7 @@ static void dcbp_set_start(struct p_compressed_bm *p, int set)
 static void dcbp_set_pad_bits(struct p_compressed_bm *p, int n)
 {
        BUG_ON(n & ~0x7);
-       p->encoding = (p->encoding & (~0x7 << 4)) | (n << 4);
+       p->encoding = (p->encoding & ((unsigned)~0x7 << 4)) | (n << 4);
 }

 static int fill_bitmap_rle_bits(struct drbd_peer_device *peer_device,
@@ -3760,8 +3769,9 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 #ifdef COMPAT_HAVE_BLK_QUEUE_MERGE_BVEC
        blk_queue_merge_bvec(q, drbd_merge_bvec);
 #endif
+       q->queue_lock = &resource->req_lock; /* used by blk_queue_flag_set() */
 #ifdef blk_queue_plugged
-       q->queue_lock = &resource->req_lock; /* needed since we use */
+       /* needed since we use */
        /* plugging on a queue, that actually has no requests! */
        q->unplug_fn = drbd_unplug_fn;
 #endif
