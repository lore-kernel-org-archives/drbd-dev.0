Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B373101E043
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jan 2019 16:53:39 +0100 (CET)
From: Johannes Thoma <johannes@johannesthoma.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 30 Jan 2019 16:48:16 +0100
Message-Id: <20190130154816.6480-1-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH] Fix an uninitialized use of loop condition.
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

On a continue the loop condition is checked, however the
condition used a yet uninitialied variable. gcc does not
warn about this, however other compilers (Microsoft Visual C,
IBM AS/400 C compiler) do.
---
 drbd/drbd_transport_tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drbd/drbd_transport_tcp.c b/drbd/drbd_transport_tcp.c
index 64515dce..0eb45567 100644
--- a/drbd/drbd_transport_tcp.c
+++ b/drbd/drbd_transport_tcp.c
@@ -941,6 +941,7 @@ static int dtt_connect(struct drbd_transport *transport)
 	connect_to_path = container_of(drbd_path, struct dtt_path, path);
 	spin_unlock(&tcp_transport->paths_lock);
 
+	ok = false;
 	do {
 		struct socket *s = NULL;
 
-- 
2.17.0

