Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 40D3B1056479
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:49 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:36 +0200
Message-Id: <1465856799-2151-28-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 27/30] drbd: get rid of empty statement in
	is_valid_state
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

From: Roland Kammerer <roland.kammerer@linbit.com>

This should silence a warning about an empty statement. Thanks to Fabian
Frederick <fabf@skynet.be> who sent a patch I modified to be smaller and
avoids an additional indent level.

Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index aca68a5..eea0c4a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -814,7 +814,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 	}
 
 	if (rv <= 0)
-		/* already found a reason to abort */;
+		goto out; /* already found a reason to abort */
 	else if (ns.role == R_SECONDARY && device->open_cnt)
 		rv = SS_DEVICE_IN_USE;
 
@@ -862,6 +862,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 	else if (ns.conn >= C_CONNECTED && ns.pdsk == D_UNKNOWN)
 		rv = SS_CONNECTED_OUTDATES;
 
+out:
 	rcu_read_unlock();
 
 	return rv;
-- 
2.7.4

