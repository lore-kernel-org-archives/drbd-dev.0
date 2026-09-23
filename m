Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E417B50A
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143505; cv=none; b=VIBGHzYg+m4Sck9PZoOY/CTivhoamdfqZMJD45TYh0D9riLBEDRQYx6XypI7Ib133bSiWa5uBcaxjTKlV8a65faS+jx4kU8IpM6d0J6+tBipCMeHnHaE0L79LDbDvs0DlgokPd8NJFYUHkSIdYV8T6TnN3E64DYRLLaf5iuMz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143505; c=relaxed/simple;
	bh=hrx0lGZWdU0Dm0UybKB2WopjWKrXrWn7fbCfBI30Vgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxzNnXqBwi2BuvaeE7xtrwkrw5q+uHylZLK8tIfmqTNW0mtVBYnNTTWXh/x5jldiPVOjTCj597q5etkiIAIZzMQyVX1xLinNFMST1uj9GdnTUDs+eVacacM8oz+x2r3i3an/aSrU6X+7uC60FwpWFWOmXxkPhlVPMo8ISytsKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from hzb-HP-Laptop-14s-cr2xxx.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f6b4c729;
	Wed, 23 Sep 2026 13:59:40 +0800 (GMT+08:00)
From: "zhengbing.huang" <zhengbing.huang@easystack.cn>
To: drbd-dev@lists.linux.dev
Cc: "zhengbing . huang" <zhengbing.huang@easystack.cn>
Subject: [PATCH 1/2] drbd: fix CONSIDER_RESYNC race in receive_state
Date: Wed, 23 Sep 2026 13:59:39 +0800
Message-ID: <20260923055939.3207539-1-zhengbing.huang@easystack.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ccd92d950227kunmf7c564bf13fc03
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkpCVh5CH0JCHh1NQ05NHlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

receive_state() cleared CONSIDER_RESYNC unconditionally at its tail,
even when the resync handshake block was skipped (e.g. UUIDS_RECEIVED
not yet set or local disk below NEGOTIATING).  This could drop the
flag set by drbd_set_role() for a forced primary, so the forced
resync was never started.

Consume the flag atomically with test_and_clear_bit() in the handshake
block, and restore it if the state change is retried, so a concurrent
set is never lost and a forced resync survives the retry loop.

Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
---
 drbd/drbd_receiver.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index f6a8d2217..039ba24d9 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -9775,6 +9775,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	enum drbd_disk_state peer_disk_state;
 	enum drbd_repl_state new_repl_state;
 	bool peer_was_resync_target, do_handshake = false;
+	bool consumed_resync;
 	enum chg_state_flags begin_state_chg_flags = CS_VERBOSE | CS_WAIT_COMPLETE;
 	unsigned long irq_flags;
 	int rv;
@@ -9821,6 +9822,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	read_unlock_irq(&resource->state_rwlock);
  retry:
 	new_repl_state = max_t(enum drbd_repl_state, old_peer_state.conn, L_OFF);
+	consumed_resync = false;
 
 	/* If some other part of the code (ack_receiver thread, timeout)
 	 * already decided to close the connection again,
@@ -9944,7 +9946,8 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 					!test_bit(INITIAL_STATE_RECEIVED, peer_device->flags);
 		/* if we have both been inconsistent, and the peer has been
 		 * forced to be UpToDate with --force */
-		consider_resync |= test_bit(CONSIDER_RESYNC, peer_device->flags);
+		consumed_resync = test_and_clear_bit(CONSIDER_RESYNC, &peer_device->flags);
+		consider_resync |= consumed_resync;
 		/* if we had been plain connected, and the admin requested to
 		 * start a sync by "invalidate" or "invalidate-remote" */
 		consider_resync |= (old_peer_state.conn == L_ESTABLISHED &&
@@ -10133,12 +10136,13 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 
 	begin_state_change(resource, &irq_flags, begin_state_chg_flags);
 	if (old_peer_state.i != drbd_get_peer_device_state(peer_device, NOW).i) {
+		if (consumed_resync)
+			set_bit(CONSIDER_RESYNC, &peer_device->flags);
 		old_peer_state = drbd_get_peer_device_state(peer_device, NOW);
 		abort_state_change_locked(resource);
 		write_unlock_irq(&resource->state_rwlock);
 		goto retry;
 	}
-	clear_bit(CONSIDER_RESYNC, peer_device->flags);
 	if ((repl_is_sync_source(old_peer_state.conn) && new_repl_state == L_WF_BITMAP_S) ||
 	    (repl_is_sync_target(old_peer_state.conn) && new_repl_state == L_WF_BITMAP_T)) {
 		/* Re-entering the bitmap exchange is refused while that resync
-- 
2.43.0

