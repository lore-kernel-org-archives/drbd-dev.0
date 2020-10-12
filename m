Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 01302420317
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:33:30 +0200 (CEST)
Received: by mail-ed1-f67.google.com with SMTP id o18so17433708edq.4
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:33:30 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	j22sm10705107edp.77.2020.10.12.08.32.29
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:32:29 -0700 (PDT)
Resent-Message-ID: <20201012153228.GM2116@soda.linbit>
Received: from m97179.mail.qiye.163.com (m97179.mail.qiye.163.com
	[220.181.97.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A3EDF420E62
	for <drbd-dev@lists.linbit.com>; Fri, 18 Sep 2020 07:33:46 +0200 (CEST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com
Message-Id: <1600406708-15123-1-git-send-email-dongsheng.yang@easystack.cn>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [Drbd-dev] [PATCH] drbd_state: dont clear NEW_CUR_UUID when
	re-gained quorum
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
Date: Mon, 12 Oct 2020 15:33:53 -0000

We cant clear NEW_CUR_UUID when we re-gain quorum, because
there is a secondary offline.

E.g:
There is a cluster with 3 nodes, 1 primary (node-1), 2 secondary (node-2, node-3)

(1) all uptodate, primary with quorum=2, quorum-minimum-redundancy=2.
(2) node-1 network error -> node-1 lost quorum
(3) node-3 down.
(4) node-1 network recovery -> node-1 regain quorum, clear NEW_CUR_UUID (node-1 uptodate, node-2 uptodate, node-3 offline)
(5) write data on primary node. -> as NEW_CUR_UUID cleared, the uuid is old.
(6) node-3 up. -> as the uuid in primary is old, same with what in node-3. there is no-sync.

Then we will loss the new data in node-3.

To fix it, dont clear NEW_CUR_UUID in (4).

Fixes: aaaa257b837a26ac4a38f2e86632d682fc57a2
Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drbd/drbd_state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index 5b1744a..358bcc0 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -2592,7 +2592,6 @@ static void finish_state_change(struct drbd_resource *resource, struct completio
 
 		if (!device->have_quorum[OLD] && device->have_quorum[NEW]) {
 			clear_bit(PRIMARY_LOST_QUORUM, &device->flags);
-			clear_bit(NEW_CUR_UUID, &device->flags);
 		}
 	}
 
-- 
1.8.3.1

