Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
	[209.85.166.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 55F2A42062C
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:11 +0100 (CET)
Received: by mail-il1-f193.google.com with SMTP id q1so12796032ilt.6
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:10 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:56 -0500
Message-Id: <20201213055859.3305-6-michael.d.labriola@gmail.com>
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 5/8] drbd: use sock_set_keepalive() instead of
	kernel_setsockopt()
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

Looks like the rest of the code has been updated to use 5.8's sock_set_*
and tcp_set_* functions, but we've missed this one case.

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd_transport_tcp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drbd/drbd_transport_tcp.c b/drbd/drbd_transport_tcp.c
index 203dc4e0..3b1d4273 100644
--- a/drbd/drbd_transport_tcp.c
+++ b/drbd/drbd_transport_tcp.c
@@ -883,7 +883,6 @@ static int dtt_connect(struct drbd_transport *transport)
 	struct socket *dsocket, *csocket;
 	struct net_conf *nc;
 	int timeout, err;
-	int one = 1;
 	bool ok;
 
 	dsocket = NULL;
@@ -1065,9 +1064,7 @@ randomize:
 	dsocket->sk->sk_sndtimeo = timeout;
 	csocket->sk->sk_sndtimeo = timeout;
 
-	err = kernel_setsockopt(dsocket, SOL_SOCKET, SO_KEEPALIVE, (char *)&one, sizeof(one));
-	if (err)
-		tr_warn(transport, "Failed to enable SO_KEEPALIVE %d\n", err);
+	sock_set_keepalive(dsocket->sk);
 
 	return 0;
 
-- 
2.17.1

