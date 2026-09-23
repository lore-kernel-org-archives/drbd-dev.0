Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com [115.236.121.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B643A7FF
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151833; cv=none; b=EAY05Wux9wsn0PSyZcguNpol0s1bCek0rC5+1Ae6yqb/sq+HY/QqSaZq7RiuN8vdcS1ZIUnXQgWNKOaGTwj7cL0srCpjvPk8OO8kAd7PuLNsneGVXtpRJ81fCuiOnWoYjFrFaw3qUxBxuBg/lXaJUE+KtWoDvfuCo5eypnCMLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151833; c=relaxed/simple;
	bh=0z7+QP7RVFQSs0HcE25TLYAvk1BuoT2Vchw2YNCLASk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr5Y+jSjMiIIol2iB2Y5W0y89O5ugEyhAEAlpMVQjTWBDUrxSFvOE24nOliJkijWLdAS00d8/i2V8lHmQcbYUbo4JcHHbSnzIun0JSRx2b3vazboq0n4LunGgZcYtYbxjdUIsq+fVcKjjvtmizoYAnfi/CvEQ+LGKDeKxC20DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.121.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from hzb-HP-Laptop-14s-cr2xxx.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f6b66e1e;
	Wed, 23 Sep 2026 14:01:10 +0800 (GMT+08:00)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linux.dev
Cc: "zhengbing . huang" <zhengbing.huang@easystack.cn>
Subject: [PATCH 2/2] drbd: send state before bitmap to avoid receive_bitmap race
Date: Wed, 23 Sep 2026 14:01:09 +0800
Message-ID: <20260923060109.3208507-1-zhengbing.huang@easystack.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ccda8df20227kunm4fa6eee113fe5c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkNNVktISkNDQ0odGUpCHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

When a node becomes SyncSource (L_WF_BITMAP_S), after_state_chg() on the
worker thread queues the bitmap send while receive_state() on the receiver
thread sends the P_STATE that lets the peer reach L_WF_BITMAP_T. These race,
so the bitmap can arrive while the peer is still L_ESTABLISHED and get
dropped in receive_bitmap(), logging "unexpected repl_state (Established) in
receive_bitmap".

Send the current state synchronously before queueing the bitmap so the peer
transitions to L_WF_BITMAP_T first.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index 4ddb31cb8..65414a774 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -4884,6 +4884,12 @@ static int w_after_state_change(struct drbd_work *w, int unused)
 				 * it does no harm to resync a small amount of
 				 * additional data. */
 				drbd_set_pending_out_of_sync(peer_device);
+				/* Tell the peer about our new state before sending the
+				 * bitmap, so it can reach L_WF_BITMAP_T first. Otherwise
+				 * the bitmap may arrive while the peer is still
+				 * L_ESTABLISHED and get dropped in receive_bitmap().
+				 */
+				drbd_send_state(peer_device, new_state);
 				/* ldev_safe: ref from extra_ldev_ref_for_after_state_chg() */
 				drbd_queue_bitmap_io(device, &drbd_send_bitmap, NULL,
 						"send_bitmap (WFBitMapS)",
-- 
2.43.0

