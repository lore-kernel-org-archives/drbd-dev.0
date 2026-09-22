Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1054B1B3
	for <drbd-dev@lists.linux.dev>; Tue, 22 Sep 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089291; cv=none; b=mRIibPD1g7N9U1XG+VnvL1GahOzalSzJEzX69DWNMETry0LsnbrI0LuDnUvtB+s1Z4st2ltgt3Z9iijGshJYuSfaMfI4NTWdZu8yL/nhg4L7/e6TEHET2VgzidCioudPucOzz+iASvpjR8Bcd5xhpzWs5ltk72EI5utqeYyn8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089291; c=relaxed/simple;
	bh=Xx8OpgywHGcsMeIvcyLKY53xhgcQ53vAtUHJ1T4t+ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8ljc+XyIxAQ5KOYRXx5XBOlbi8UWDELmyQR0sDDC7rSdrZ2/c3rymF52rA3LNbMc2/iZIP1oq9IzcPx/9ejE9MxjPq5x0SWo6zgcDKXhbbSEStyaL4jvDGb6UTLSFzQHEB3z79L+UcyC0vcIBcPhQ/vs+FAgly+dmWIzGrKvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KLXmWEc6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KLXmWEc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ky
	nlDgai36MsbIl72qSEa5NJ1VukAAFb/WIGZOyQrXs=; b=KLXmWEc6euuUVnYiLy
	dOuN0v0MTSkSDKMG3dc7OMDTyPZtpNI3n/6LnR91d/gmYc3DcvLhCEmK5Q3yRum5
	XBiDQacQkTYEBfRvM5KVMJF+Q9TvarNukkvQ0Q0E+ts2zsNqnX28EE/zyClkT5py
	1gNZJyBW5EQU2860oHFfNNb8Y=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXlWozmLJqCKtEAw--.24065S2;
	Tue, 22 Sep 2026 23:01:08 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] drbd: fix use-after-frees of disk_conf and rs_plan_s in chg-disk-opts
Date: Tue, 22 Sep 2026 23:01:04 +0800
Message-ID: <20260922150104.156635-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXlWozmLJqCKtEAw--.24065S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4xKr47CrWxAFykKFWfZrb_yoW5KF1xpF
	W5Ka1UAr1Utw4YvF4ak3WrWr45tan7XF9rGrZ7Ka12vw43Ar9xXFW3Z3ya9Fnxur97CFyx
	Za9xJFs7K3sYkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRyCJPUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4BR6XmqymDSkPgAA3+

drbd_nl_chg_disk_opts_doit() installs a new disk_conf, drops conf_update
and then keeps reading from the old and the new object. A concurrent
receive_SyncParam(), which runs from the receiver thread and serialises
on the same mutex, may install another disk_conf and kfree() the published
one as soon as conf_update is released.  Its synchronize_rcu() does not
wait for these reads, because they are not inside an RCU read-side
critical section, so the object can be freed while it is still being read.

BUG: KASAN: slab-use-after-free in drbd_nl_chg_disk_opts_doit+0x16a8/0x18b0
Read of size 1 at addr ffff888100d84950 by task drbdsetup-84/100447
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_report+0xd0/0x630
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? drbd_nl_chg_disk_opts_doit+0x16a8/0x18b0
 ? genlmsg_put+0x12f/0x330
 ? __pfx_drbd_nl_chg_disk_opts_doit+0x10/0x10
 ? __nla_parse+0x24/0x30
 ? genl_family_rcv_msg_attrs_parse.isra.0+0x17a/0x290
 genl_family_rcv_msg_doit+0x1e0/0x2c0
 ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
 ? __pfx_cred_has_capability.isra.0+0x10/0x10
 genl_rcv_msg+0x419/0x6d0
 ? __pfx_genl_rcv_msg+0x10/0x10
 ? __pfx_drbd_pre_doit+0x10/0x10
 ? __pfx_drbd_nl_chg_disk_opts_doit+0x10/0x10
 ? __pfx_drbd_post_doit+0x10/0x10
 netlink_rcv_skb+0x11f/0x350
 ? __pfx_genl_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? __pfx___netlink_lookup+0x10/0x10
 genl_rcv+0x23/0x30
 netlink_unicast+0x5f5/0x860
 ? __pfx_netlink_unicast+0x10/0x10
 ? __pfx_sock_has_perm+0x10/0x10
 netlink_sendmsg+0x70a/0xba0
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? selinux_socket_sendmsg+0x8c/0x270
 sock_write_iter+0x405/0x4a0
 ? __pfx_sock_write_iter+0x10/0x10
 ? __file_has_perm+0x30f/0x410
 ? folio_add_new_anon_rmap+0x254/0x5d0
 vfs_write+0xa4b/0xcf0
 ? __handle_mm_fault+0xd1a/0x1e30
 ? __pfx_vfs_write+0x10/0x10
 ? fdget_pos+0x53/0x4b0
 ksys_write+0x17c/0x1c0
 ? __pfx_ksys_write+0x10/0x10
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Fix this by caching the values needed from the disk_conf objects while
conf_update is still held, and by waiting for a grace period before
freeing the previous rs_plan_s.

Fixes: 813472ced7fac ("drbd: RCU for rs_plan_s")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/block/drbd/drbd_nl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b77f901fc3ef..f34ed481217e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1657,7 +1657,6 @@ int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
 		old_plan = device->rs_plan_s;
 		rcu_assign_pointer(device->rs_plan_s, new_plan);
 	}
-
 	mutex_unlock(&device->resource->conf_update);
 
 	if (new_disk_conf->al_updates)
@@ -1687,7 +1686,16 @@ int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	kvfree_rcu_mightsleep(old_disk_conf);
-	kfree(old_plan);
+	if (old_plan) {
+		/*
+		 * rs_plan_s is dereferenced by the resync controller
+		 * (drbd_rs_controller()) under rcu_read_lock(), so wait for
+		 * a grace period before releasing the previous plan, like
+		 * receive_SyncParam() does.
+		 */
+		synchronize_rcu();
+		kfree(old_plan);
+	}
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
 
-- 
2.43.0

