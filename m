Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Jan 2008 11:25:18 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E89B45@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Barrier assert failures with latest 8.0 sources
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I'm attempting to run with the latest 8.0 sources from Git (plus a
couple of patches - basically the ones I have submitted that have not
yet been applied) and am seeing a lot of assert failures in the barrier
code since the latest change to send barriers as early as possible. A
representative trace for a device is attached - you will see that the
device gets connected then pauses resync (not sure if this is really
relevant) and then we start streaming the assert failures -- apparently
we are off by one barrier from this point on...

Any suggestions?
Simon

   5270:Jan 19 00:15:43 node1 kernel: drbd5: conn( Unconnected ->
WFConnection )=20
   6214:Jan 19 00:34:45 node1 kernel: drbd5: Handshake successful: DRBD
Network Protocol version 86
   6216:Jan 19 00:34:46 node1 kernel: drbd5: conn( WFConnection ->
WFReportParams )=20
   6219:Jan 19 00:34:46 node1 kernel: drbd5: Starting asender thread
(from drbd5_receiver [15383])
   6221:Jan 19 00:34:47 node1 kernel: drbd5: drbd_sync_handshake:
   6222:Jan 19 00:34:48 node1 kernel: drbd5: self
0D17E6C6F3714F2F:E0FEF0615D2424EF:2953DE3A10384390:169A43D80FC7A631
   6224:Jan 19 00:34:48 node1 kernel: drbd5: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000
   6226:Jan 19 00:34:49 node1 kernel: drbd5: uuid_compare()=3D2 by rule =
3
   6228:Jan 19 00:34:50 node1 kernel: drbd5: Becoming sync source due to
disk states.
   6231:Jan 19 00:34:51 node1 kernel: drbd5: Writing meta data super
block now.
   6234:Jan 19 00:34:53 node1 kernel: drbd5: writing of bitmap took 0
jiffies
   6237:Jan 19 00:34:53 node1 kernel: drbd5: 1023 MB (262127 bits)
marked out-of-sync by on disk bit-map.
   6240:Jan 19 00:34:54 node1 kernel: drbd5: Writing meta data super
block now.
   6246:Jan 19 00:35:04 node1 kernel: drbd5: peer( Unknown -> Secondary
) conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> Inconsistent )=20
   6251:Jan 19 00:35:14 node1 kernel: drbd5: Writing meta data super
block now.
   6257:Jan 19 00:35:19 node1 kernel: drbd5:  uuid[History_start] now
E0FEF0615D2424EF
   6261:Jan 19 00:35:23 node1 kernel: drbd5:  uuid[Bitmap] now
BF161CBD2512E46A
   6264:Jan 19 00:35:28 node1 kernel: drbd5: conn( WFBitMapS ->
SyncSource )=20
   6279:Jan 19 00:35:53 node1 kernel: drbd5: Began resync as SyncSource
(will sync 1048508 KB [262127 bits set]).
   6281:Jan 19 00:35:56 node1 kernel: drbd5: Writing meta data super
block now.
   6290:Jan 19 00:36:07 node1 kernel: drbd5: conn( SyncSource ->
PausedSyncS ) aftr_isp( 0 -> 1 )=20
   6292:Jan 19 00:36:08 node1 kernel: drbd5: Resync suspended
   6303:Jan 19 00:36:23 node1 kernel: drbd5: peer_isp( 0 -> 1 )=20
   6308:Jan 19 00:36:25 node1 kernel: drbd5: ASSERT( b->br_number =3D=3D
barrier_nr ) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:240
   6311:Jan 19 00:36:27 node1 kernel: drbd5: ASSERT( b->n_req =3D=3D
set_size ) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:241
   6314:Jan 19 00:36:28 node1 kernel: drbd5: b->br_number =3D 4711 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:245
   6318:Jan 19 00:36:29 node1 kernel: drbd5: barrier_nr =3D 4712 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:246
   6322:Jan 19 00:36:30 node1 kernel: drbd5: b->n_req =3D 0 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:249
   6326:Jan 19 00:36:31 node1 kernel: drbd5: set_size =3D 1 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:250
   6334:Jan 19 00:36:37 node1 kernel: drbd5: ASSERT( b->br_number =3D=3D
barrier_nr ) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:240
   6337:Jan 19 00:36:38 node1 kernel: drbd5: b->br_number =3D 4712 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:245
   6340:Jan 19 00:36:38 node1 kernel: drbd5: barrier_nr =3D 4713 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:246
   6343:Jan 19 00:36:39 node1 kernel: drbd5: ASSERT( b->br_number =3D=3D
barrier_nr ) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:240
   6347:Jan 19 00:36:40 node1 kernel: drbd5: ASSERT( b->n_req =3D=3D
set_size ) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:241
   6350:Jan 19 00:36:42 node1 kernel: drbd5: b->br_number =3D 4713 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:245
   6353:Jan 19 00:36:43 node1 kernel: drbd5: barrier_nr =3D 4714 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:246
   6356:Jan 19 00:36:43 node1 kernel: drbd5: b->n_req =3D 1 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUIn_req =3D 1 in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_main.c:249
