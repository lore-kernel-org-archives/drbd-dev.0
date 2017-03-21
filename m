Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4EDFB1056332
	for <drbd-dev@lists.linbit.com>; Tue, 21 Mar 2017 05:50:08 +0100 (CET)
Message-Id: <58D1218D02000070000B43F0@prv-mh.provo.novell.com>
Date: Mon, 20 Mar 2017 22:50:21 -0600
From: "Nick Wang" <nwang@suse.com>
To: <drbd-dev@lists.linbit.com>
References: <58D1218D02000070000B43F0@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Drbd-dev] Resync finished with SyncSource still have bits set
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

Hello,

I can reproduce an unexpected drbd_resync_finished()=20
process when the SyncSource still have bits set on drbd9.0.6.=20
A connected secondary node is detaching to diskless=20
during resync process, and the resync may be treated=20
as completed when receiving the state change.=20

I think it also need to check the state of peer disk before completing=20
the resync, at least for the not weak node to avoid completing=20
resync for diskless node. With the modification by the end of this=20
mail, i can't reproduce this issue anymore.

Steps to reproduce:
1. Write errors happened on Secondary node, then turn detach to diskless=20=

2. (Manually) Down/Up the resource on the Secondary node, resync started.
3. Write errors happened again on Secondary, detach/down/up again.

Error log:
Mar 15 15:22:48 node1 kernel: [ 6909.187284] drbd drbd0/0 drbd0
node2: Began resync as SyncSource (will sync 9944 KB [2486 bits set]).
Mar 15 15:22:48 node1 failoverd: DRBD: Connecting, Primary/Unknown,
Consistent/Unknown -> Connected, Primary/Secondary, Consistent/Inconsistent=

Mar 15 15:22:51 node1 kernel: [ 6912.101262] drbd drbd0/0 drbd0
node2: SyncSource still sees bits set!! FIXME
Mar 15 15:22:51 node1 kernel: [ 6912.101541] drbd drbd0/0 drbd0
node2: Resync done (total 2 sec; paused 0 sec; 4972 K/sec)
Mar 15 15:22:51 node1 kernel: [ 6912.101544] drbd drbd0/0 drbd0
node2: ASSERTION (n_oos - peer_device->rs_failed) =3D=3D 0 FAILED in
drbd_resync_finished  <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mar 15 15:22:51 node1 kernel: [ 6912.101555] drbd drbd0/0 drbd0
node2: pdsk( Inconsistent -> Failed ) repl( SyncSource -> Established )
Mar 15 15:22:51 node1 kernel: [ 6912.104755] drbd drbd0/0 drbd0
node2: pdsk( Failed -> Diskless )

---
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 00e3e74..e33c94f 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -6240,7 +6240,8 @@ static int receive_state(struct drbd_connection =
*connection, struct packet_info
                /* if peer_state changes to connected at the same time,
                 * it explicitly notifies us that it finished resync.
                 * Maybe we should finish it up, too? */
-               else if (peer_state.conn =3D=3D L_ESTABLISHED) {
+               else if (peer_state.conn =3D=3D L_ESTABLISHED &&
+                        peer_disk_state > D_NEGOTIATING) {
                        bool finish_now =3D false;
=20
                        if (old_peer_state.conn =3D=3D L_WF_BITMAP_S) {

--=20


Best regards,
Nick

