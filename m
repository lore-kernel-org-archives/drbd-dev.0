Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 77D721056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 22:53:21 +0100 (CET)
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  9 Nov 2016 22:52:58 +0100
Message-Id: <1478728378-22289-1-git-send-email-lars.ellenberg@linbit.com>
In-Reply-To: <60514f9b-6f1c-8b7e-429a-490cdaae14d8@kernel.dk>
References: <60514f9b-6f1c-8b7e-429a-490cdaae14d8@kernel.dk>
Cc: wolfgang.glas@iteg.at, Richard Weinberger <richard@nod.at>,
	christoph.lechleitner@iteg.at, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, philipp.reisner@linbit.com,
	viro@zeniv.linux.org.uk, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] drbd: Fix kernel_sendmsg() usage - potential
	NULL deref
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

From: Richard Weinberger <richard@nod.at>

Don't pass a size larger than iov_len to kernel_sendmsg().
Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
returns with rv < size.

DRBD as external module has been around in the kernel 2.4 days already.
We used to be compatible to 2.4 and very early 2.6 kernels,
we used to use
 rv = sock_sendmsg(sock, &msg, iov.iov_len);
then later changed to
 rv = kernel_sendmsg(sock, &msg, &iov, 1, size);
when we should have used
 rv = kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);

tcp_sendmsg() used to totally ignore the size parameter.
 57be5bd ip: convert tcp_sendmsg() to iov_iter primitives
changes that, and exposes our long standing error.

Even with this error exposed, to trigger the bug, we would need to have
an environment (config or otherwise) causing us to not use sendpage()
for larger transfers, a failing connection, and have it fail "just at the
right time".  Apparently that was unlikely enough for most, so this went
unnoticed for years.

Still, it is known to trigger at least some of these,
and suspected for the others:
[0] http://lists.linbit.com/pipermail/drbd-user/2016-July/023112.html
[1] http://lists.linbit.com/pipermail/drbd-dev/2016-March/003362.html
[2] https://forums.grsecurity.net/viewtopic.php?f=3&t=4546
[3] https://ubuntuforums.org/showthread.php?t=2336150
[4] http://e2.howsolveproblem.com/i/1175162/

This should go into 4.9,
and into all stable branches since and including v4.0,
which is the first to contain the exposing change.

It is correct for all stable branches older than that as well
(which contain the DRBD driver; which is 2.6.33 and up).

It requires a small "conflict" resolution for v4.4 and earlier, with v4.5
we dropped the comment block immediately preceding the kernel_sendmsg().

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: <stable@vger.kernel.org> # 2.6.33.x-
Cc: viro@zeniv.linux.org.uk
Cc: christoph.lechleitner@iteg.at
Cc: wolfgang.glas@iteg.at
Reported-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
Tested-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
[changed oneliner to be "obvious" without context; more verbose message]
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 100be55..8348272 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1871,7 +1871,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 		drbd_update_congested(connection);
 	}
 	do {
-		rv = kernel_sendmsg(sock, &msg, &iov, 1, size);
+		rv = kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);
 		if (rv == -EAGAIN) {
 			if (we_should_drop_the_connection(connection, sock))
 				break;
-- 
2.7.4

