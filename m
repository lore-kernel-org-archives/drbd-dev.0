Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A8352DE3CC0
	for <drbd-dev@lists.linbit.com>; Thu,  6 Nov 2008 22:13:54 +0100 (CET)
Resent-Message-ID: <20081106211354.GB21501@soda.linbit>
Received: from lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9018C2E115C3
	for <drbd-dev@lists.linbit.com>; Thu,  6 Nov 2008 11:00:33 +0100 (CET)
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim
	4.63) (envelope-from <nyoushchenko@ru.mvista.com>)
	id 1Ky1PV-0002gq-Em
	for drbd-dev@lists.linbit.com; Thu, 06 Nov 2008 12:44:20 +0300
From: "Nikita V. Youshchenko" <nyoushchenko@ru.mvista.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 6 Nov 2008 12:44:14 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200811061244.14732@blacky.localdomain>
Cc: hakan.engblom@ericsson.com, Alexander Kaliadin <akaliadin@mvista.com>
Subject: [Drbd-dev] [PATCH] Fix stale receiver thread state when
	drbd_connect() returns zero
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello.

Although I know that drbd 0.7 is old and not supported anymore, I still feel
that this information may be usable for people.

I have spent a while trying to find out why sometimes failover on drbd 0.7.=
24
fails on out customer's system.
At last, I was able to track what was hapenning.

I did not check, but the same issue may be present in later versions of drb=
d=20
as well.

The patch below is against drbd 0.7.24 release.


=46rom cf7541852c39bb507b4a3ccc42a9d8fa365cbbd3 Mon Sep 17 00:00:00 2001
=46rom: Nikita V. Youshchenko <nyoushchenko@ru.mvista.com>
Date: Thu, 6 Nov 2008 00:42:47 +0300
Subject: [PATCH] Fix stale receiver thread state when drbd_connect() return=
s zero.

The following call stack may happen:

drbd_init() ->
  drbd_connect() ->
    drbd_do_handshake() ->
      drbd_recv_header() ->
        drbd_recv()

At this level socket receive is called, that may return 0 (in case of peer
connection reset). Then drbd_thread_restart_nowait(&mdev->receiver) will
be called, and receiver state will be set to Restarting.

Later control returns to drbd_init(), goes to error path, and then to a new
iteration of connection loop, leaving receiver state set to Restarting.

Much later, this causes breakages. For example, drbd device does not handle
failover correctly.

This patch fixes stale receiver state on the described error path.

Signed-off-by: Nikita V. Youshchenko <nyoushchenko@ru.mvista.com>
=2D--
 drbd/drbd_receiver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index e769739..3a66b28 100644
=2D-- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2105,6 +2105,10 @@ int drbdd_init(struct Drbd_thread *thi)
 			drbd_disconnect(mdev);
 			if (h =3D=3D 0) {
 				schedule_timeout(HZ);
+				spin_lock(&thi->t_lock);
+				if (thi->t_state =3D=3D Restarting)
+					thi->t_state =3D Running;
+				spin_unlock(&thi->t_lock);
 				continue;
 			}
=20
=2D-=20
1.5.6.5

