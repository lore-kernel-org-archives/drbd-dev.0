Return-Path: <richard.lyu@suse.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3650A16084A
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2026 09:35:36 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
	5b1f17b1804b1-485345e1013so5366725e9.1
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2026 01:35:36 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:35:31 +0800
From: Richard Lyu <richard.lyu@suse.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] drbd: fix pointer cast spacing
Message-ID: <20260311083510.183631-1-richard.lyu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Richard Lyu <richard.lyu@suse.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

Checkpatch.pl reports the following coding style issue:
ERROR: "(foo*)" should be "(foo *)"
+		struct p_trim *t = (struct p_trim*)p;

Place '*' next to the variable in the cast expression to follow
the kernel coding style. No functional change.

Signed-off-by: Richard Lyu <richard.lyu@suse.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b8f0eddf7e87..978023e969f8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1681,7 +1681,7 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 
 	if (dp_flags & (DP_DISCARD|DP_ZEROES)) {
 		enum drbd_packet cmd = (dp_flags & DP_ZEROES) ? P_ZEROES : P_TRIM;
-		struct p_trim *t = (struct p_trim*)p;
+		struct p_trim *t = (struct p_trim *)p;
 		t->size = cpu_to_be32(req->i.size);
 		err = __send_command(peer_device->connection, device->vnr, sock, cmd, sizeof(*t), NULL, 0);
 		goto out;
-- 
2.51.0

