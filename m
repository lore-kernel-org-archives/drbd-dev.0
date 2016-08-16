Return-Path: <kmpak@mantech.co.kr>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
	[209.85.218.45]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 856D01056445
	for <drbd-dev@lists.linbit.com>; Tue, 16 Aug 2016 03:14:09 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id 4so81168854oih.2
	for <drbd-dev@lists.linbit.com>; Mon, 15 Aug 2016 18:14:09 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Date: Tue, 16 Aug 2016 10:14:07 +0900
Message-ID: <CALLFrTT9N7bbikXJCaL6NGbMvM49D2Bguy0eyRydNB1_7Sk23w@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=94eb2c032594c1b55b053a26108c
Subject: [Drbd-dev] Here's logs 3 volumes case
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

--94eb2c032594c1b55b053a26108c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

There're 3 node, and each had 100MB/100MB/95MB  volume, time synced
Please ,Watch DRBD9_3 node's log carefully
Thanks

<DRBD9_1>

...
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 204800
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560
u_size: 0 d_size: 194560 max_size: 194560
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 0
my_usize: 0 my_max_size: 204800
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: calling
drbd_determine_dev_size()
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 194560
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2432=
0
words=3D760 pages=3D2
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3:
drbd_sync_handshake:
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:0
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:24
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D0
by rule 10
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake to peer 1
successful: Agreed network protocol version 111
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [97862])
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: sock was shut down by peer
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting ->
BrokenPipe )
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: ack_receiver terminated
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv threa=
d
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Connection closed
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( BrokenPipe ->
Unconnected )
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Restarting receiver thread
Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake to peer 1
successful: Agreed network protocol version 111
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [97862])
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: sock was shut down by peer
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting ->
BrokenPipe )
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: ack_receiver terminated
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv threa=
d
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Connection closed
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( BrokenPipe ->
Unconnected )
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Restarting receiver thread
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake to peer 1
successful: Agreed network protocol version 111
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [97862])
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state
change 369176076 (0->1 499/146)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: State change 369176076:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: Committing cluster-wide state
change 369176076 (1ms)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 194560
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 0
my_usize: 0 my_max_size: 204800
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: calling
drbd_determine_dev_size()
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:24
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0
by rule 10
Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0 DRBD9_3: Preparing remote state
change 1953992009 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0 DRBD9_3: Committing remote state
change 1953992009
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0 DRBD9_3: peer( Secondary -> Primary
)
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( Inconsistent
-> UpToDate )
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3:
drbd_sync_handshake:
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: peer
D43B0300042F33B9:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000 bits:0
flags:120
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D-=
3
by rule 20
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: repl( Established
-> WFBitMapT )
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: send bitmap stats
[Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm before-resync-target
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm before-resync-target exit code 0 (0x0)
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: repl( WFBitMapT ->
SyncTarget )
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: resync-susp( no ->
connection dependency )
Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: Began resync as
SyncTarget (will sync 97280 KB [24320 bits set]).
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: Resync done (total
15 sec; paused 0 sec; 6484 K/sec)
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: updated UUIDs
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: repl( SyncTarget
-> Established )
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm after-resync-target
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm after-resync-target exit code 0 (0x0)
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: updated UUIDs
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000
Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( Inconsistent
-> UpToDate ) resync-susp( peer -> no )
Aug 16 09:33:22 DRBD9_1 kernel: drbd r0 DRBD9_3: peer( Primary -> Secondary
)
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Preparing remote state
change 3319188407 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Committing remote state
change 3319188407
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Connected ->
TearDown ) peer( Secondary -> Unknown )
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: ack_receiver terminated
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Terminating ack_recv threa=
d
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Connection closed
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( TearDown ->
Unconnected )
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Restarting receiver thread
Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Unconnected ->
Connecting )
Aug 16 09:33:27 DRBD9_1 kernel: drbd r0 DRBD9_2: Preparing remote state
change 2471101321 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:27 DRBD9_1 kernel: drbd r0 DRBD9_2: Committing remote state
change 2471101321
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Preparing remote state
change 4086777357 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Committing remote state
change 4086777357
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connected ->
TearDown ) peer( Secondary -> Unknown )
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: ack_receiver terminated
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv threa=
d
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Connection closed
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( TearDown ->
Unconnected )
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Restarting receiver thread
Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake to peer 1
successful: Agreed network protocol version 111
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [97862])
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state
change 1975720708 (0->1 499/146)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0: State change 1975720708:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0: Committing cluster-wide state
change 1975720708 (1ms)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 194560
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 194560
my_usize: 0 my_max_size: 204800
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: Resize forced while not
fully connected!
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: calling
drbd_determine_dev_size()
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: Resize forced while not
fully connected!
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 204800
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2560=
0
words=3D800 pages=3D2
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 100 MB (102400 KB=
)
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: Writing the whole bitmap,
size changed
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: self
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:20
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0
by rule 38
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: No resync, but 1280 bits
in bitmap!
Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown ->
UpToDate ) repl( Off -> Established )
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Handshake to peer 2
successful: Agreed network protocol version 111
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Starting ack_recv thread
(from drbd_r_r0 [97863])
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state
change 550148406 (0->2 499/146)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0: State change 550148406:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0: Committing cluster-wide state
change 550148406 (0ms)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 204800
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560
u_size: 0 d_size: 194560 max_size: 194560
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 204800
my_usize: 0 my_max_size: 204800
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x11 max_size: 204800 (UpToDate)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: The peer's disk
size is too small! (194560 < 204800 sectors)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: error receiving P_SIZES,
e: -5 l: 0!
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: ack_receiver terminated
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Terminating ack_recv threa=
d
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_2: Preparing remote state
change 1936541420 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Connection closed
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Terminating receiver threa=
d
Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_2: Committing remote state
change 1936541420

<DRBD9_2>
...
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 204800
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560
u_size: 0 d_size: 194560 max_size: 194560
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 0
my_usize: 0 my_max_size: 204800
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: calling
drbd_determine_dev_size()
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 194560
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2432=
0
words=3D760 pages=3D2
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3:
drbd_sync_handshake:
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:0
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:24
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D0
by rule 10
Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state
change 1968584032 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0 DRBD9_3: Committing remote state
change 1968584032
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560
u_size: 0 d_size: 194560 max_size: 194560
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 0
my_usize: 0 my_max_size: 204800
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: calling
drbd_determine_dev_size()
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: sock_recvmsg returned -11
Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
BrokenPipe )
Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: short read (expected size
8)
Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( BrokenPipe ->
Unconnected )
Aug 16 09:32:33 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: sock was reset by peer
Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
BrokenPipe )
Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: short read (expected size
8)
Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( BrokenPipe ->
Unconnected )
Aug 16 09:32:35 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0
successful: Agreed network protocol version 111
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [110256])
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
NetworkFailure )
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: ack_receiver terminated
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating ack_recv threa=
d
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( NetworkFailure ->
Unconnected )
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Restarting receiver thread
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0
successful: Agreed network protocol version 111
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [110256])
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state
change 369176076 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state
change 369176076
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 194560
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 0
my_usize: 0 my_max_size: 204800
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling
drbd_determine_dev_size()
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 194560 (Inconsistent)
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:24
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0
by rule 10
Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state
change 1953992009 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0 DRBD9_3: Committing remote state
change 1953992009
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0 DRBD9_3: peer( Secondary -> Primary
)
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( Inconsistent
-> UpToDate )
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3:
drbd_sync_handshake:
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: peer
D43B0300042F33B9:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000 bits:0
flags:120
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D-=
3
by rule 20
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: repl( Established
-> WFBitMapT )
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: send bitmap stats
[Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm before-resync-target
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm before-resync-target exit code 0 (0x0)
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: repl( WFBitMapT ->
SyncTarget )
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: resync-susp( no ->
connection dependency )
Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: Began resync as
SyncTarget (will sync 97280 KB [24320 bits set]).
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent
-> UpToDate )
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: Resync done (total
15 sec; paused 0 sec; 6484 K/sec)
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: updated UUIDs
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: repl( SyncTarget
-> Established )
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: resync-susp(
connection dependency -> no )
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm after-resync-target
Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command:
/sbin/drbdadm after-resync-target exit code 0 (0x0)
Aug 16 09:33:22 DRBD9_2 kernel: drbd r0 DRBD9_3: peer( Primary -> Secondary
)
Aug 16 09:33:26 DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state
change 3319188407 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:26 DRBD9_2 kernel: drbd r0 DRBD9_3: Committing remote state
change 3319188407
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state
change 2471101321 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Committing remote state
change 2471101321
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connected ->
TearDown ) peer( Secondary -> Unknown )
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: ack_receiver terminated
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating ack_recv threa=
d
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Connection closed
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( TearDown ->
Unconnected )
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Restarting receiver thread
Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Unconnected ->
Connecting )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0: Preparing cluster-wide state
change 4086777357 (1->0 496/16)
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0: State change 4086777357:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Cluster is now split
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0: Committing cluster-wide state
change 4086777357 (0ms)
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: ack_receiver terminated
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating ack_recv threa=
d
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating receiver threa=
d
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating sender thread
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 tcp:DRBD9_3: Closing unexpected
connection from 200.200.200.61
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connecting ->
Disconnecting )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: Connection closed
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating receiver threa=
d
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating sender thread
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1: disk( UpToDate ->
Detaching )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Detaching ->
Diskless )
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 0
Aug 16 09:33:33 DRBD9_2 kernel: drbd r0: Terminating worker thread
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0: Starting worker thread (from
drbdsetup [110439])
Aug 16 09:33:38 DRBD9_2 systemd-udevd: error: /dev/drbd1: Wrong medium type
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Diskless ->
Attaching )
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: Maximum number of peer
devices =3D 2
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0: Method to ensure write ordering:
flush
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: node_id: 2 idx: 1 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to
backing device's (32 -> 1024)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: node_id: 2 idx: 1 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 194560
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2432=
0
words=3D760 pages=3D2
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: recounting of set bits
took additional 0ms
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Attaching ->
UpToDate )
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: attached to current UUID:
D43B0300042F33B8
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting sender thread
(from drbdsetup [110450])
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: Starting sender thread
(from drbdsetup [110453])
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( StandAlone ->
Unconnected )
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting receiver thread
(from drbd_w_r0 [110440])
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( StandAlone ->
Unconnected )
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: Starting receiver thread
(from drbd_w_r0 [110440])
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Unconnected ->
Connecting )
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0
successful: Agreed network protocol version 111
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [110459])
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state
change 1975720708 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state
change 1975720708
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 194560
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 194560
my_usize: 0 my_max_size: 204800
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: Resize forced while not
fully connected!
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling
drbd_determine_dev_size()
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: Resize forced while not
fully connected!
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 204800
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2560=
0
words=3D800 pages=3D2
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 100 MB (102400 KB=
)
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: Writing the whole bitmap,
size changed
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:120
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0
by rule 38
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: No resync, but 1280 bits
in bitmap!
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown ->
UpToDate ) repl( Off -> Established )
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Handshake to peer 2
successful: Agreed network protocol version 111
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Starting ack_recv thread
(from drbd_r_r0 [110461])
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state
change 550148406 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state
change 550148406
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0: Preparing cluster-wide state
change 1936541420 (1->2 499/146)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0: State change 1936541420:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0: Committing cluster-wide state
change 1936541420 (1ms)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 204800
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560
u_size: 0 d_size: 194560 max_size: 194560
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 204800
my_usize: 0 my_max_size: 204800
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x11 max_size: 204800 (UpToDate)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: The peer's disk
size is too small! (194560 < 204800 sectors)
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: error receiving P_SIZES,
e: -5 l: 0!
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: ack_receiver terminated
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating ack_recv threa=
d
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Connection closed
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating receiver threa=
d

<DRBD9_3>
...
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 204800
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 0
my_usize: 0
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: calling
drbd_determine_dev_size()
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:24
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0
by rule 10
Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Handshake successful:
Agreed network protocol version 111
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [109747])
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Preparing remote state
change 1968584032 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Committing remote state
change 1968584032
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 204800
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 0
my_usize: 0
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 204800 (Inconsistent)
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: calling
drbd_determine_dev_size()
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x13 max_size: 204800 (Inconsistent)
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:24
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0
by rule 10
Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Aug 16 09:32:36 DRBD9_3 kernel: drbd r0 DRBD9_1: Preparing remote state
change 369176076 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:32:36 DRBD9_3 kernel: drbd r0 DRBD9_1: Committing remote state
change 369176076
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: Preparing cluster-wide state
change 1953992009 (2->-1 7683/4609)
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: State change 1953992009:
primary_nodes=3D4, weak_nodes=3DFFFFFFFFFFFFFFF8
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: Committing cluster-wide state
change 1953992009 (0ms)
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: role( Secondary -> Primary )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: Forced to consider local data as
UpToDate!
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: new current UUID:
D43B0300042F33B9 weak: FFFFFFFFFFFFFFF8
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: self
D43B0300042F33B9:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer
0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000
bits:24320 flags:104
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D3
by rule 30
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: self
D43B0300042F33B9:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer
0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000
bits:24320 flags:104
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D3
by rule 30
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: drbd_r_r0[109748] going to
'set_n_write from sync_handshake' but bitmap already locked for
'set_n_write from sync_handshake' by drbd_r_r0[109747]
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: repl( Established
-> WFBitMapS )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: send bitmap stats
[Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: repl( Established
-> WFBitMapS )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: send bitmap stats
[Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: helper command:
/sbin/drbdadm before-resync-source
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: helper command:
/sbin/drbdadm before-resync-source
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: helper command:
/sbin/drbdadm before-resync-source exit code 0 (0x0)
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: repl( WFBitMapS ->
SyncSource )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: Began resync as
SyncSource (will sync 97280 KB [24320 bits set]).
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: helper command:
/sbin/drbdadm before-resync-source exit code 0 (0x0)
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: repl( WFBitMapS ->
SyncSource )
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: Began resync as
SyncSource (will sync 97280 KB [24320 bits set]).
Aug 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: Resync done (total
15 sec; paused 0 sec; 6484 K/sec)
Aug 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent
-> UpToDate ) repl( SyncSource -> Established )
Aug 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: Resync done (total
15 sec; paused 0 sec; 6484 K/sec)
Aug 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( Inconsistent
-> UpToDate ) repl( SyncSource -> Established )
Aug 16 09:33:22 DRBD9_3 kernel: drbd r0: role( Primary -> Secondary )
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0: Preparing cluster-wide state
change 3319188407 (2->0 496/16)
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0: State change 3319188407:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0: Committing cluster-wide state
change 3319188407 (0ms)
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: ack_receiver terminated
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating ack_recv threa=
d
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating receiver threa=
d
Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating sender thread
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: Preparing cluster-wide state
change 2471101321 (2->1 496/16)
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: State change 2471101321:
primary_nodes=3D0, weak_nodes=3D0
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Cluster is now split
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: Committing cluster-wide state
change 2471101321 (6ms)
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: ack_receiver terminated
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating ack_recv threa=
d
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Connection closed
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Disconnecting ->
StandAlone )
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating receiver threa=
d
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating sender thread
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1: disk( UpToDate ->
Detaching )
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1: disk( Detaching ->
Diskless )
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 0
Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: Terminating worker thread
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0: Starting worker thread (from
drbdsetup [109966])
Aug 16 09:33:45 DRBD9_3 systemd-udevd: error: /dev/drbd1: Wrong medium type
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: disk( Diskless ->
Attaching )
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: Maximum number of peer
devices =3D 2
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0: Method to ensure write ordering:
flush
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 1 idx: 1 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to
backing device's (32 -> 1024)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 1 idx: 1 bm-uuid:
0x0 flags: 0x10 (not currently reachable)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 194560
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D2432=
0
words=3D760 pages=3D2
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: recounting of set bits
took additional 0ms
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: disk( Attaching ->
UpToDate )
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: attached to current UUID:
D43B0300042F33B8
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_1: Starting sender thread
(from drbdsetup [109976])
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: Starting sender thread
(from drbdsetup [109980])
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( StandAlone ->
Unconnected )
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_1: Starting receiver thread
(from drbd_w_r0 [109967])
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( StandAlone ->
Unconnected )
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: Starting receiver thread
(from drbd_w_r0 [109967])
Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Handshake successful:
Agreed network protocol version 111
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [109985])
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Handshake successful:
Agreed network protocol version 111
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [109986])
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Preparing remote state
change 550148406 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Committing remote state
change 550148406
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 204800
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 194560
my_usize: 0
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: calling
drbd_determine_dev_size()
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: self
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:120
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0
by rule 38
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown ->
UpToDate ) repl( Off -> Established )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: sock was shut down by peer
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connected ->
BrokenPipe ) peer( Secondary -> Unknown )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: ack_receiver terminated
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating ack_recv threa=
d
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Preparing remote state
change 1936541420 (primary_nodes=3D0, weak_nodes=3D0)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Committing remote state
change 1936541420
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 204800
u_size: 0 d_size: 204800 max_size: 204800
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 194560
my_usize: 0
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: calling
drbd_determine_dev_size()
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1
bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1: my node_id: 2
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: self
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer
D43B0300042F33B8:0000000000000000:0000000000000000:0000000000000000
bits:1280 flags:20
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0
by rule 40
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown ->
UpToDate ) repl( Off -> Established )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Connection closed
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( BrokenPipe ->
Unconnected )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Restarting receiver thread
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: sock was shut down by peer
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Connected ->
BrokenPipe ) peer( Secondary -> Unknown )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( UpToDate ->
DUnknown ) repl( Established -> Off )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: ack_receiver terminated
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating ack_recv threa=
d
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Connection closed
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( BrokenPipe ->
Unconnected )
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Restarting receiver thread
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
=E1=90=A7

--94eb2c032594c1b55b053a26108c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:14px">There&#39;re 3 node, and eac=
h had 100MB/100MB/95MB =C2=A0volume, time synced</div><div style=3D"font-si=
ze:14px">Please ,Watch DRBD9_3 node&#39;s log carefully</div><div style=3D"=
font-size:14px">Thanks</div><div><br></div><div class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><p sty=
le=3D"margin:0cm 0cm 0.0001pt;line-height:21px"><span style=3D"font-size:14=
px;line-height:normal">&lt;DRBD9_1&gt;</span><font color=3D"#000000" face=
=3D"verdana, sans-serif"><span lang=3D"EN-US" style=3D"font-size:8pt;line-h=
eight:16px"><br></span></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-=
height:21px"><span style=3D"font-size:14px;line-height:normal">...</span></=
p><div style=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 d=
rbd1: current_size: 204800</div><div style=3D"font-size:14px">Aug 16 09:32:=
30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560 u_size: 0 d_size=
: 194560 max_size: 194560</div><div style=3D"font-size:14px">Aug 16 09:32:3=
0 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 0 my_usize: 0 my_max_si=
ze: 204800</div><div style=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kerne=
l: drbd r0/0 drbd1: my node_id: 0</div><div style=3D"font-size:14px">Aug 16=
 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0 bm-uui=
d: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div style=3D"font-size:14px"=
>Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1=
 bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)</div><div style=3D"fon=
t-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: calli=
ng drbd_determine_dev_size()</div><div style=3D"font-size:14px">Aug 16 09:3=
2:30 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div style=3D"font=
-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_i=
d: 1 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div style=
=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3=
: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)</di=
v><div style=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 d=
rbd1: drbd_bm_resize called with capacity =3D=3D 194560</div><div style=3D"=
font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: resync bit=
map: bits=3D24320 words=3D760 pages=3D2</div><div style=3D"font-size:14px">=
Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: drbd_sync_handshak=
e:</div><div style=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd =
r0/0 drbd1 DRBD9_3: self 0000000000000004:<wbr>0000000000000000:<wbr>000000=
0000000000:<wbr>0000000000000000 bits:1280 flags:0</div><div style=3D"font-=
size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: peer 00=
00000000000004:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>00000000000=
00000 bits:0 flags:24</div><div style=3D"font-size:14px">Aug 16 09:32:30 DR=
BD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D0 by rule 10</div><=
div style=3D"font-size:14px">Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd=
1 DRBD9_3: pdsk( DUnknown -&gt; Inconsistent ) repl( Off -&gt; Established =
)</div><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd r=
0 DRBD9_2: Handshake to peer 1 successful: Agreed network protocol version =
111</div><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd=
 r0 DRBD9_2: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC =
WRITE_SAME.</div><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kern=
el: drbd r0 DRBD9_2: Starting ack_recv thread (from drbd_r_r0 [97862])</div=
><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD=
9_2: sock was shut down by peer</div><div style=3D"font-size:14px">Aug 16 0=
9:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting -&gt; BrokenPipe =
)</div><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd r=
0 DRBD9_2: ack_receiver terminated</div><div style=3D"font-size:14px">Aug 1=
6 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv thread</di=
v><div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRB=
D9_2: Connection closed</div><div style=3D"font-size:14px">Aug 16 09:32:34 =
DRBD9_1 kernel: drbd r0 DRBD9_2: conn( BrokenPipe -&gt; Unconnected )</div>=
<div style=3D"font-size:14px">Aug 16 09:32:34 DRBD9_1 kernel: drbd r0 DRBD9=
_2: Restarting receiver thread</div><div style=3D"font-size:14px">Aug 16 09=
:32:34 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected -&gt; Connecting =
)</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r=
0 DRBD9_2: Handshake to peer 1 successful: Agreed network protocol version =
111</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd=
 r0 DRBD9_2: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC =
WRITE_SAME.</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kern=
el: drbd r0 DRBD9_2: Starting ack_recv thread (from drbd_r_r0 [97862])</div=
><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD=
9_2: sock was shut down by peer</div><div style=3D"font-size:14px">Aug 16 0=
9:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting -&gt; BrokenPipe =
)</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r=
0 DRBD9_2: ack_receiver terminated</div><div style=3D"font-size:14px">Aug 1=
6 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv thread</di=
v><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRB=
D9_2: Connection closed</div><div style=3D"font-size:14px">Aug 16 09:32:36 =
DRBD9_1 kernel: drbd r0 DRBD9_2: conn( BrokenPipe -&gt; Unconnected )</div>=
<div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0 DRBD9=
_2: Restarting receiver thread</div><div style=3D"font-size:14px">Aug 16 09=
:32:36 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected -&gt; Connecting =
)</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r=
0 DRBD9_2: Handshake to peer 1 successful: Agreed network protocol version =
111</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd=
 r0 DRBD9_2: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC =
WRITE_SAME.</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kern=
el: drbd r0 DRBD9_2: Starting ack_recv thread (from drbd_r_r0 [97862])</div=
><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: Pre=
paring cluster-wide state change 369176076 (0-&gt;1 499/146)</div><div styl=
e=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: State change =
369176076: primary_nodes=3D0, weak_nodes=3D0</div><div style=3D"font-size:1=
4px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0: Committing cluster-wide state=
 change 369176076 (1ms)</div><div style=3D"font-size:14px">Aug 16 09:32:36 =
DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting -&gt; Connected ) peer( U=
nknown -&gt; Secondary )</div><div style=3D"font-size:14px">Aug 16 09:32:36=
 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 194560</div><div style=3D"f=
ont-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_s=
ize: 194560 u_size: 0 d_size: 204800 max_size: 204800</div><div style=3D"fo=
nt-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_s=
ize: 0 my_usize: 0 my_max_size: 204800</div><div style=3D"font-size:14px">A=
ug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div sty=
le=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9=
_2: node_id: 1 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)</=
div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0=
 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x13 max_size: 194560=
 (Inconsistent)</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 =
kernel: drbd r0/0 drbd1 DRBD9_2: calling drbd_determine_dev_size()</div><di=
v style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1:=
 my node_id: 0</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 k=
ernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0 bm-uuid: 0x0 flags: 0x0 m=
ax_size: 204800 (DUnknown)</div><div style=3D"font-size:14px">Aug 16 09:32:=
36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 =
flags: 0x13 max_size: 194560 (Inconsistent)</div><div style=3D"font-size:14=
px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: drbd_sync_hand=
shake:</div><div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: d=
rbd r0/0 drbd1 DRBD9_2: self 0000000000000004:<wbr>0000000000000000:<wbr>00=
00000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div style=3D"font=
-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer 0=
000000000000004:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000=
000000 bits:0 flags:24</div><div style=3D"font-size:14px">Aug 16 09:32:36 D=
RBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0 by rule 10</div>=
<div style=3D"font-size:14px">Aug 16 09:32:36 DRBD9_1 kernel: drbd r0/0 drb=
d1 DRBD9_2: pdsk( DUnknown -&gt; Inconsistent ) repl( Off -&gt; Established=
 )</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd =
r0 DRBD9_3: Preparing remote state change 1953992009 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 ke=
rnel: drbd r0 DRBD9_3: Committing remote state change 1953992009</div><div =
style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0 DRBD9_3: p=
eer( Secondary -&gt; Primary )</div><div style=3D"font-size:14px">Aug 16 09=
:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( Inconsistent -&gt; Up=
ToDate )</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel:=
 drbd r0/0 drbd1: size =3D 95 MB (97280 KB)</div><div style=3D"font-size:14=
px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: drbd_sync_hand=
shake:</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: d=
rbd r0/0 drbd1 DRBD9_3: self 0000000000000004:<wbr>0000000000000000:<wbr>00=
00000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div style=3D"font=
-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: peer D=
43B0300042F33B9:<wbr>FFFFFFFFFFFFFFFF:<wbr>0000000000000000:<wbr>0000000000=
000000 bits:0 flags:120</div><div style=3D"font-size:14px">Aug 16 09:32:56 =
DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_compare()=3D-3 by rule 20</di=
v><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 d=
rbd1 DRBD9_3: Writing the whole bitmap, full sync required after drbd_sync_=
handshake.</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kerne=
l: drbd r0/0 drbd1 DRBD9_3: repl( Established -&gt; WFBitMapT )</div><div s=
tyle=3D"font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRB=
D9_3: receive bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 2=
1; compression: 99.4%</div><div style=3D"font-size:14px">Aug 16 09:32:56 DR=
BD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: send bitmap stats [Bytes(packets)]: =
plain 0(0), RLE 21(1), total 21; compression: 99.4%</div><div style=3D"font=
-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper=
 command: /sbin/drbdadm before-resync-target</div><div style=3D"font-size:1=
4px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: helper comman=
d: /sbin/drbdadm before-resync-target exit code 0 (0x0)</div><div style=3D"=
font-size:14px">Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: re=
pl( WFBitMapT -&gt; SyncTarget )</div><div style=3D"font-size:14px">Aug 16 =
09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: resync-susp( no -&gt; con=
nection dependency )</div><div style=3D"font-size:14px">Aug 16 09:32:56 DRB=
D9_1 kernel: drbd r0/0 drbd1 DRBD9_3: Began resync as SyncTarget (will sync=
 97280 KB [24320 bits set]).</div><div style=3D"font-size:14px">Aug 16 09:3=
3:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: Resync done (total 15 sec; pa=
used 0 sec; 6484 K/sec)</div><div style=3D"font-size:14px">Aug 16 09:33:12 =
DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: updated UUIDs D43B0300042F33B8:<wb=
r>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000</div><div st=
yle=3D"font-size:14px">Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1: dis=
k( Inconsistent -&gt; UpToDate )</div><div style=3D"font-size:14px">Aug 16 =
09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: repl( SyncTarget -&gt; Es=
tablished )</div><div style=3D"font-size:14px">Aug 16 09:33:12 DRBD9_1 kern=
el: drbd r0/0 drbd1 DRBD9_3: helper command: /sbin/drbdadm after-resync-tar=
get</div><div style=3D"font-size:14px">Aug 16 09:33:12 DRBD9_1 kernel: drbd=
 r0/0 drbd1 DRBD9_3: helper command: /sbin/drbdadm after-resync-target exit=
 code 0 (0x0)</div><div style=3D"font-size:14px">Aug 16 09:33:12 DRBD9_1 ke=
rnel: drbd r0/0 drbd1 DRBD9_2: updated UUIDs D43B0300042F33B8:<wbr>00000000=
00000000:<wbr>0000000000000000:<wbr>0000000000000000</div><div style=3D"fon=
t-size:14px">Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk(=
 Inconsistent -&gt; UpToDate ) resync-susp( peer -&gt; no )</div><div style=
=3D"font-size:14px">Aug 16 09:33:22 DRBD9_1 kernel: drbd r0 DRBD9_3: peer( =
Primary -&gt; Secondary )</div><div style=3D"font-size:14px">Aug 16 09:33:2=
6 DRBD9_1 kernel: drbd r0 DRBD9_3: Preparing remote state change 3319188407=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div style=3D"font-size:14px">Aug=
 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Committing remote state chang=
e 3319188407</div><div style=3D"font-size:14px">Aug 16 09:33:26 DRBD9_1 ker=
nel: drbd r0 DRBD9_3: conn( Connected -&gt; TearDown ) peer( Secondary -&gt=
; Unknown )</div><div style=3D"font-size:14px">Aug 16 09:33:26 DRBD9_1 kern=
el: drbd r0/0 drbd1 DRBD9_3: pdsk( UpToDate -&gt; DUnknown ) repl( Establis=
hed -&gt; Off )</div><div style=3D"font-size:14px">Aug 16 09:33:26 DRBD9_1 =
kernel: drbd r0 DRBD9_3: ack_receiver terminated</div><div style=3D"font-si=
ze:14px">Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: Terminating ack_r=
ecv thread</div><div style=3D"font-size:14px">Aug 16 09:33:26 DRBD9_1 kerne=
l: drbd r0 DRBD9_3: Connection closed</div><div style=3D"font-size:14px">Au=
g 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( TearDown -&gt; Unconne=
cted )</div><div style=3D"font-size:14px">Aug 16 09:33:26 DRBD9_1 kernel: d=
rbd r0 DRBD9_3: Restarting receiver thread</div><div style=3D"font-size:14p=
x">Aug 16 09:33:26 DRBD9_1 kernel: drbd r0 DRBD9_3: conn( Unconnected -&gt;=
 Connecting )</div><div style=3D"font-size:14px">Aug 16 09:33:27 DRBD9_1 ke=
rnel: drbd r0 DRBD9_2: Preparing remote state change 2471101321 (primary_no=
des=3D0, weak_nodes=3D0)</div><div style=3D"font-size:14px">Aug 16 09:33:27=
 DRBD9_1 kernel: drbd r0 DRBD9_2: Committing remote state change 2471101321=
</div><div style=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0=
 DRBD9_2: Preparing remote state change 4086777357 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div style=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kern=
el: drbd r0 DRBD9_2: Committing remote state change 4086777357</div><div st=
yle=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: con=
n( Connected -&gt; TearDown ) peer( Secondary -&gt; Unknown )</div><div sty=
le=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9=
_2: pdsk( UpToDate -&gt; DUnknown ) repl( Established -&gt; Off )</div><div=
 style=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: =
ack_receiver terminated</div><div style=3D"font-size:14px">Aug 16 09:33:33 =
DRBD9_1 kernel: drbd r0 DRBD9_2: Terminating ack_recv thread</div><div styl=
e=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Conne=
ction closed</div><div style=3D"font-size:14px">Aug 16 09:33:33 DRBD9_1 ker=
nel: drbd r0 DRBD9_2: conn( TearDown -&gt; Unconnected )</div><div style=3D=
"font-size:14px">Aug 16 09:33:33 DRBD9_1 kernel: drbd r0 DRBD9_2: Restartin=
g receiver thread</div><div style=3D"font-size:14px">Aug 16 09:33:33 DRBD9_=
1 kernel: drbd r0 DRBD9_2: conn( Unconnected -&gt; Connecting )</div><div s=
tyle=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: Ha=
ndshake to peer 1 successful: Agreed network protocol version 111</div><div=
 style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: =
Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</=
div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 D=
RBD9_2: Starting ack_recv thread (from drbd_r_r0 [97862])</div><div style=
=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0: Preparing clus=
ter-wide state change 1975720708 (0-&gt;1 499/146)</div><div style=3D"font-=
size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0: State change 1975720708=
: primary_nodes=3D0, weak_nodes=3D0</div><div style=3D"font-size:14px">Aug =
16 09:33:39 DRBD9_1 kernel: drbd r0: Committing cluster-wide state change 1=
975720708 (1ms)</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 =
kernel: drbd r0 DRBD9_2: conn( Connecting -&gt; Connected ) peer( Unknown -=
&gt; Secondary )</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1=
 kernel: drbd r0/0 drbd1: current_size: 194560</div><div style=3D"font-size=
:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 194=
560 u_size: 0 d_size: 204800 max_size: 204800</div><div style=3D"font-size:=
14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 194=
560 my_usize: 0 my_max_size: 204800</div><div style=3D"font-size:14px">Aug =
16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div style=
=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2=
: node_id: 1 idx: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)</d=
iv><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 =
drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x10 max_size: 194560 =
(DUnknown)</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kerne=
l: drbd r0/0 drbd1: Resize forced while not fully connected!</div><div styl=
e=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_=
2: calling drbd_determine_dev_size()</div><div style=3D"font-size:14px">Aug=
 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div style=
=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2=
: node_id: 1 idx: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)</d=
iv><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 =
drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x10 max_size: 194560 =
(DUnknown)</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kerne=
l: drbd r0/0 drbd1: Resize forced while not fully connected!</div><div styl=
e=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: drbd_=
bm_resize called with capacity =3D=3D 204800</div><div style=3D"font-size:1=
4px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitmap: bits=
=3D25600 words=3D800 pages=3D2</div><div style=3D"font-size:14px">Aug 16 09=
:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 100 MB (102400 KB)</div><d=
iv style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1=
: Writing the whole bitmap, size changed</div><div style=3D"font-size:14px"=
>Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: drbd_sync_handsha=
ke:</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd=
 r0/0 drbd1 DRBD9_2: self D43B0300042F33B8:<wbr>0000000000000000:<wbr>00000=
00000000000:<wbr>0000000000000000 bits:0 flags:0</div><div style=3D"font-si=
ze:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer D43B=
0300042F33B8:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000=
000 bits:0 flags:20</div><div style=3D"font-size:14px">Aug 16 09:33:39 DRBD=
9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0 by rule 38</div><di=
v style=3D"font-size:14px">Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1:=
 No resync, but 1280 bits in bitmap!</div><div style=3D"font-size:14px">Aug=
 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown -&gt; =
UpToDate ) repl( Off -&gt; Established )</div><div style=3D"font-size:14px"=
>Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Handshake to peer 2 succe=
ssful: Agreed network protocol version 111</div><div style=3D"font-size:14p=
x">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Feature flags enabled o=
n protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div style=3D"font-=
size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Starting ack_re=
cv thread (from drbd_r_r0 [97863])</div><div style=3D"font-size:14px">Aug 1=
6 09:33:46 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state change 550=
148406 (0-&gt;2 499/146)</div><div style=3D"font-size:14px">Aug 16 09:33:46=
 DRBD9_1 kernel: drbd r0: State change 550148406: primary_nodes=3D0, weak_n=
odes=3D0</div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel:=
 drbd r0: Committing cluster-wide state change 550148406 (0ms)</div><div st=
yle=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: con=
n( Connecting -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div s=
tyle=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1: cu=
rrent_size: 204800</div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9=
_1 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560 u_size: 0 d_size: 194560=
 max_size: 194560</div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_=
1 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 204800 my_usize: 0 my_max_size:=
 204800</div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: =
drbd r0/0 drbd1: my node_id: 0</div><div style=3D"font-size:14px">Aug 16 09=
:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0 bm-uuid: =
0x0 flags: 0x11 max_size: 204800 (UpToDate)</div><div style=3D"font-size:14=
px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx=
: 1 bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)</div><div style=3D=
"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: T=
he peer&#39;s disk size is too small! (194560 &lt; 204800 sectors)</div><di=
v style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3:=
 conn( Connected -&gt; Disconnecting ) peer( Secondary -&gt; Unknown )</div=
><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD=
9_3: error receiving P_SIZES, e: -5 l: 0!</div><div style=3D"font-size:14px=
">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: ack_receiver terminated<=
/div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 =
DRBD9_3: Terminating ack_recv thread</div><div style=3D"font-size:14px">Aug=
 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_2: Preparing remote state change=
 1936541420 (primary_nodes=3D0, weak_nodes=3D0)</div><div style=3D"font-siz=
e:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Connection closed<=
/div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 =
DRBD9_3: conn( Disconnecting -&gt; StandAlone )</div><div style=3D"font-siz=
e:14px">Aug 16 09:33:46 DRBD9_1 kernel: drbd r0 DRBD9_3: Terminating receiv=
er thread</div><div style=3D"font-size:14px">Aug 16 09:33:46 DRBD9_1 kernel=
: drbd r0 DRBD9_2: Committing remote state change 1936541420</div></div><di=
v style=3D"font-size:14px"><br></div><div style=3D"font-size:14px">&lt;DRBD=
9_2&gt;</div><div style=3D"font-size:14px">...</div><div style=3D"font-size=
:14px"><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: =
204800</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c=
_size: 194560 u_size: 0 d_size: 194560 max_size: 194560</div><div>Aug 16 09=
:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: la_size: 0 my_usize: 0 my_m=
ax_size: 204800</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 D=
RBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)</d=
iv><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div=
><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 i=
dx: 1 bm-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)</div><div>Aug 16 =
09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: calling drbd_determine_de=
v_size()</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:=
 node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div=
>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>A=
ug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 b=
m-uuid: 0x0 flags: 0x0 max_size: 194560 (DUnknown)</div><div>Aug 16 09:32:2=
7 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with capacity =3D=
=3D 194560</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: resyn=
c bitmap: bits=3D24320 words=3D760 pages=3D2</div><div>Aug 16 09:32:27 DRBD=
9_2 kernel: drbd r0/0 drbd1 DRBD9_3: drbd_sync_handshake:</div><div>Aug 16 =
09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: self 0000000000000004:<wb=
r>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:1280 fl=
ags:0</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pe=
er 0000000000000004:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>000000=
0000000000 bits:0 flags:24</div><div>Aug 16 09:32:27 DRBD9_2 kernel: drbd r=
0/0 drbd1 DRBD9_3: uuid_compare()=3D0 by rule 10</div><div>Aug 16 09:32:27 =
DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( DUnknown -&gt; Inconsistent =
) repl( Off -&gt; Established )</div><div>Aug 16 09:32:30 DRBD9_2 kernel: d=
rbd r0 DRBD9_3: Preparing remote state change 1968584032 (primary_nodes=3D0=
, weak_nodes=3D0)</div><div>Aug 16 09:32:30 DRBD9_2 kernel: drbd r0 DRBD9_3=
: Committing remote state change 1968584032</div><div>Aug 16 09:32:30 DRBD9=
_2 kernel: drbd r0/0 drbd1: current_size: 194560</div><div>Aug 16 09:32:30 =
DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560 u_size: 0 d_size: 1=
94560 max_size: 194560</div><div>Aug 16 09:32:30 DRBD9_2 kernel: drbd r0/0 =
drbd1 DRBD9_3: la_size: 0 my_usize: 0 my_max_size: 204800</div><div>Aug 16 =
09:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid=
: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div>Aug 16 09:32:30 DRBD9_2 k=
ernel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16 09:32:30 DRBD9_2 ker=
nel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x13 ma=
x_size: 194560 (Inconsistent)</div><div>Aug 16 09:32:30 DRBD9_2 kernel: drb=
d r0/0 drbd1 DRBD9_3: calling drbd_determine_dev_size()</div><div>Aug 16 09=
:32:30 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: =
0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div>Aug 16 09:32:30 DRBD9_2 ker=
nel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16 09:32:30 DRBD9_2 kerne=
l: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x13 max_=
size: 194560 (Inconsistent)</div><div>Aug 16 09:32:32 DRBD9_2 kernel: drbd =
r0 DRBD9_1: sock_recvmsg returned -11</div><div>Aug 16 09:32:32 DRBD9_2 ker=
nel: drbd r0 DRBD9_1: conn( Connecting -&gt; BrokenPipe )</div><div>Aug 16 =
09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: short read (expected size 8)</div=
><div>Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection closed</d=
iv><div>Aug 16 09:32:32 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( BrokenPipe -=
&gt; Unconnected )</div><div>Aug 16 09:32:33 DRBD9_2 kernel: drbd r0 DRBD9_=
1: conn( Unconnected -&gt; Connecting )</div><div>Aug 16 09:32:34 DRBD9_2 k=
ernel: drbd r0 DRBD9_1: sock was reset by peer</div><div>Aug 16 09:32:34 DR=
BD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting -&gt; BrokenPipe )</div><di=
v>Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: short read (expected siz=
e 8)</div><div>Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: Connection =
closed</div><div>Aug 16 09:32:34 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Bro=
kenPipe -&gt; Unconnected )</div><div>Aug 16 09:32:35 DRBD9_2 kernel: drbd =
r0 DRBD9_1: conn( Unconnected -&gt; Connecting )</div><div>Aug 16 09:32:36 =
DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0 successful: Agreed net=
work protocol version 111</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0=
 DRBD9_1: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRI=
TE_SAME.</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Startin=
g ack_recv thread (from drbd_r_r0 [110256])</div><div>Aug 16 09:32:36 DRBD9=
_2 kernel: drbd r0 DRBD9_1: conn( Connecting -&gt; NetworkFailure )</div><d=
iv>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: ack_receiver terminated=
</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating ack=
_recv thread</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Con=
nection closed</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: c=
onn( NetworkFailure -&gt; Unconnected )</div><div>Aug 16 09:32:36 DRBD9_2 k=
ernel: drbd r0 DRBD9_1: Restarting receiver thread</div><div>Aug 16 09:32:3=
6 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected -&gt; Connecting )</di=
v><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0=
 successful: Agreed network protocol version 111</div><div>Aug 16 09:32:36 =
DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on protocol level: 0=
x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Aug 16 09:32:36 DRBD9_2 kernel: d=
rbd r0 DRBD9_1: Starting ack_recv thread (from drbd_r_r0 [110256])</div><di=
v>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state c=
hange 369176076 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:32:=
36 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state change 36917607=
6</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecti=
ng -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Aug 16 09:32=
:36 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560</div><div>Aug 16 =
09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 194560 u_size: 0 =
d_size: 204800 max_size: 204800</div><div>Aug 16 09:32:36 DRBD9_2 kernel: d=
rbd r0/0 drbd1 DRBD9_1: la_size: 0 my_usize: 0 my_max_size: 204800</div><di=
v>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: =
0 bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)</div><div>Aug 16 09:3=
2:36 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16 09:32:=
36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0x0 =
flags: 0x13 max_size: 194560 (Inconsistent)</div><div>Aug 16 09:32:36 DRBD9=
_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling drbd_determine_dev_size()</div>=
<div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 id=
x: 0 bm-uuid: 0x0 flags: 0x0 max_size: 204800 (DUnknown)</div><div>Aug 16 0=
9:32:36 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16 09:=
32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid: 0=
x0 flags: 0x13 max_size: 194560 (Inconsistent)</div><div>Aug 16 09:32:36 DR=
BD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: drbd_sync_handshake:</div><div>Aug 1=
6 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self 0000000000000004:<=
wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 fla=
gs:0</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pee=
r 0000000000000004:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000=
000000000 bits:0 flags:24</div><div>Aug 16 09:32:36 DRBD9_2 kernel: drbd r0=
/0 drbd1 DRBD9_1: uuid_compare()=3D0 by rule 10</div><div>Aug 16 09:32:36 D=
RBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown -&gt; Inconsistent )=
 repl( Off -&gt; Established )</div><div>Aug 16 09:32:56 DRBD9_2 kernel: dr=
bd r0 DRBD9_3: Preparing remote state change 1953992009 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0 DRBD9_3:=
 Committing remote state change 1953992009</div><div>Aug 16 09:32:56 DRBD9_=
2 kernel: drbd r0 DRBD9_3: peer( Secondary -&gt; Primary )</div><div>Aug 16=
 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( Inconsistent -&gt;=
 UpToDate )</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1: size=
 =3D 95 MB (97280 KB)</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 d=
rbd1 DRBD9_3: drbd_sync_handshake:</div><div>Aug 16 09:32:56 DRBD9_2 kernel=
: drbd r0/0 drbd1 DRBD9_3: self 0000000000000004:<wbr>0000000000000000:<wbr=
>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>Aug 16 09:=
32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: peer D43B0300042F33B9:<wbr>F=
FFFFFFFFFFFFFFF:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:12=
0</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: uuid_c=
ompare()=3D-3 by rule 20</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/=
0 drbd1 DRBD9_3: Writing the whole bitmap, full sync required after drbd_sy=
nc_handshake.</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRB=
D9_3: repl( Established -&gt; WFBitMapT )</div><div>Aug 16 09:32:56 DRBD9_2=
 kernel: drbd r0/0 drbd1 DRBD9_3: receive bitmap stats [Bytes(packets)]: pl=
ain 0(0), RLE 21(1), total 21; compression: 99.4%</div><div>Aug 16 09:32:56=
 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: send bitmap stats [Bytes(packets)=
]: plain 0(0), RLE 21(1), total 21; compression: 99.4%</div><div>Aug 16 09:=
32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command: /sbin/drbdad=
m before-resync-target</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 =
drbd1 DRBD9_3: helper command: /sbin/drbdadm before-resync-target exit code=
 0 (0x0)</div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3:=
 repl( WFBitMapT -&gt; SyncTarget )</div><div>Aug 16 09:32:56 DRBD9_2 kerne=
l: drbd r0/0 drbd1 DRBD9_1: resync-susp( no -&gt; connection dependency )</=
div><div>Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: Began res=
ync as SyncTarget (will sync 97280 KB [24320 bits set]).</div><div>Aug 16 0=
9:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent -&gt; U=
pToDate )</div><div>Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3=
: Resync done (total 15 sec; paused 0 sec; 6484 K/sec)</div><div>Aug 16 09:=
33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: updated UUIDs D43B0300042F33=
B8:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000</div><=
div>Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Inconsistent -&g=
t; UpToDate )</div><div>Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRB=
D9_3: repl( SyncTarget -&gt; Established )</div><div>Aug 16 09:33:12 DRBD9_=
2 kernel: drbd r0/0 drbd1 DRBD9_1: resync-susp( connection dependency -&gt;=
 no )</div><div>Aug 16 09:33:12 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: he=
lper command: /sbin/drbdadm after-resync-target</div><div>Aug 16 09:33:12 D=
RBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: helper command: /sbin/drbdadm after=
-resync-target exit code 0 (0x0)</div><div>Aug 16 09:33:22 DRBD9_2 kernel: =
drbd r0 DRBD9_3: peer( Primary -&gt; Secondary )</div><div>Aug 16 09:33:26 =
DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state change 3319188407 (=
primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33:26 DRBD9_2 kernel=
: drbd r0 DRBD9_3: Committing remote state change 3319188407</div><div>Aug =
16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Preparing remote state change =
2471101321 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33:27 DR=
BD9_2 kernel: drbd r0 DRBD9_3: Committing remote state change 2471101321</d=
iv><div>Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connected -&=
gt; TearDown ) peer( Secondary -&gt; Unknown )</div><div>Aug 16 09:33:27 DR=
BD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( UpToDate -&gt; DUnknown ) repl=
( Established -&gt; Off )</div><div>Aug 16 09:33:27 DRBD9_2 kernel: drbd r0=
 DRBD9_3: ack_receiver terminated</div><div>Aug 16 09:33:27 DRBD9_2 kernel:=
 drbd r0 DRBD9_3: Terminating ack_recv thread</div><div>Aug 16 09:33:27 DRB=
D9_2 kernel: drbd r0 DRBD9_3: Connection closed</div><div>Aug 16 09:33:27 D=
RBD9_2 kernel: drbd r0 DRBD9_3: conn( TearDown -&gt; Unconnected )</div><di=
v>Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: Restarting receiver thre=
ad</div><div>Aug 16 09:33:27 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Unconne=
cted -&gt; Connecting )</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0: =
Preparing cluster-wide state change 4086777357 (1-&gt;0 496/16)</div><div>A=
ug 16 09:33:33 DRBD9_2 kernel: drbd r0: State change 4086777357: primary_no=
des=3D0, weak_nodes=3D0</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 D=
RBD9_1: Cluster is now split</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd=
 r0: Committing cluster-wide state change 4086777357 (0ms)</div><div>Aug 16=
 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connected -&gt; Disconnect=
ing ) peer( Secondary -&gt; Unknown )</div><div>Aug 16 09:33:33 DRBD9_2 ker=
nel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate -&gt; DUnknown ) repl( Establi=
shed -&gt; Off )</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1:=
 ack_receiver terminated</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 =
DRBD9_1: Terminating ack_recv thread</div><div>Aug 16 09:33:33 DRBD9_2 kern=
el: drbd r0 DRBD9_1: Connection closed</div><div>Aug 16 09:33:33 DRBD9_2 ke=
rnel: drbd r0 DRBD9_1: conn( Disconnecting -&gt; StandAlone )</div><div>Aug=
 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating receiver thread</=
div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_1: Terminating sende=
r thread</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 tcp:DRBD9_3: Clo=
sing unexpected connection from 200.200.200.61</div><div>Aug 16 09:33:33 DR=
BD9_2 kernel: drbd r0 DRBD9_3: conn( Connecting -&gt; Disconnecting )</div>=
<div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: Connection closed</di=
v><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Disconnecting=
 -&gt; StandAlone )</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0 DRBD9=
_3: Terminating receiver thread</div><div>Aug 16 09:33:33 DRBD9_2 kernel: d=
rbd r0 DRBD9_3: Terminating sender thread</div><div>Aug 16 09:33:33 DRBD9_2=
 kernel: drbd r0/0 drbd1: disk( UpToDate -&gt; Detaching )</div><div>Aug 16=
 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Detaching -&gt; Diskless )=
</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize =
called with capacity =3D=3D 0</div><div>Aug 16 09:33:33 DRBD9_2 kernel: drb=
d r0: Terminating worker thread</div><div>Aug 16 09:33:38 DRBD9_2 kernel: d=
rbd r0: Starting worker thread (from drbdsetup [110439])</div><div>Aug 16 0=
9:33:38 DRBD9_2 systemd-udevd: error: /dev/drbd1: Wrong medium type</div><d=
iv>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Diskless -&gt; At=
taching )</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: Maximu=
m number of peer devices =3D 2</div><div>Aug 16 09:33:38 DRBD9_2 kernel: dr=
bd r0: Method to ensure write ordering: flush</div><div>Aug 16 09:33:38 DRB=
D9_2 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x10 (n=
ot currently reachable)</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0=
 drbd1: my node_id: 1</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 d=
rbd1: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x10 (not currently reachable)<=
/div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: Adjusting my ra_=
pages to backing device&#39;s (32 -&gt; 1024)</div><div>Aug 16 09:33:38 DRB=
D9_2 kernel: drbd r0/0 drbd1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x10 (n=
ot currently reachable)</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0=
 drbd1: my node_id: 1</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 d=
rbd1: node_id: 2 idx: 1 bm-uuid: 0x0 flags: 0x10 (not currently reachable)<=
/div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize c=
alled with capacity =3D=3D 194560</div><div>Aug 16 09:33:38 DRBD9_2 kernel:=
 drbd r0/0 drbd1: resync bitmap: bits=3D24320 words=3D760 pages=3D2</div><d=
iv>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 K=
B)</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: recounting of=
 set bits took additional 0ms</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drb=
d r0/0 drbd1: disk( Attaching -&gt; UpToDate )</div><div>Aug 16 09:33:38 DR=
BD9_2 kernel: drbd r0/0 drbd1: attached to current UUID: D43B0300042F33B8</=
div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting sender t=
hread (from drbdsetup [110450])</div><div>Aug 16 09:33:38 DRBD9_2 kernel: d=
rbd r0 DRBD9_3: Starting sender thread (from drbdsetup [110453])</div><div>=
Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( StandAlone -&gt; Unc=
onnected )</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_1: Start=
ing receiver thread (from drbd_w_r0 [110440])</div><div>Aug 16 09:33:38 DRB=
D9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected -&gt; Connecting )</div><di=
v>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( StandAlone -&gt; U=
nconnected )</div><div>Aug 16 09:33:38 DRBD9_2 kernel: drbd r0 DRBD9_3: Sta=
rting receiver thread (from drbd_w_r0 [110440])</div><div>Aug 16 09:33:38 D=
RBD9_2 kernel: drbd r0 DRBD9_3: conn( Unconnected -&gt; Connecting )</div><=
div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake to peer 0 su=
ccessful: Agreed network protocol version 111</div><div>Aug 16 09:33:39 DRB=
D9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on protocol level: 0x7 =
TRIM THIN_RESYNC WRITE_SAME.</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd=
 r0 DRBD9_1: Starting ack_recv thread (from drbd_r_r0 [110459])</div><div>A=
ug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state chan=
ge 1975720708 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33:39=
 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state change 1975720708=
</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connectin=
g -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Aug 16 09:33:=
39 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560</div><div>Aug 16 0=
9:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 194560 u_size: 0 d=
_size: 204800 max_size: 204800</div><div>Aug 16 09:33:39 DRBD9_2 kernel: dr=
bd r0/0 drbd1 DRBD9_1: la_size: 194560 my_usize: 0 my_max_size: 204800</div=
><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 i=
dx: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)</div><div>Aug 16=
 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16 0=
9:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uuid:=
 0x0 flags: 0x10 max_size: 0 (DUnknown)</div><div>Aug 16 09:33:39 DRBD9_2 k=
ernel: drbd r0/0 drbd1: Resize forced while not fully connected!</div><div>=
Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling drbd_deter=
mine_dev_size()</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 D=
RBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnkno=
wn)</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: =
1</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_i=
d: 2 idx: 1 bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)</div><div>Aug 1=
6 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: Resize forced while not fully c=
onnected!</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_b=
m_resize called with capacity =3D=3D 204800</div><div>Aug 16 09:33:39 DRBD9=
_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D25600 words=3D800 pages=
=3D2</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 10=
0 MB (102400 KB)</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1:=
 Writing the whole bitmap, size changed</div><div>Aug 16 09:33:39 DRBD9_2 k=
ernel: drbd r0/0 drbd1 DRBD9_1: drbd_sync_handshake:</div><div>Aug 16 09:33=
:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self D43B0300042F33B8:<wbr>000=
0000000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</d=
iv><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer D43B0=
300042F33B8:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>00000000000000=
00 bits:0 flags:120</div><div>Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drb=
d1 DRBD9_1: uuid_compare()=3D0 by rule 38</div><div>Aug 16 09:33:39 DRBD9_2=
 kernel: drbd r0/0 drbd1: No resync, but 1280 bits in bitmap!</div><div>Aug=
 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown -&gt; =
UpToDate ) repl( Off -&gt; Established )</div><div>Aug 16 09:33:46 DRBD9_2 =
kernel: drbd r0 DRBD9_3: Handshake to peer 2 successful: Agreed network pro=
tocol version 111</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3=
: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.=
</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Starting ack_re=
cv thread (from drbd_r_r0 [110461])</div><div>Aug 16 09:33:46 DRBD9_2 kerne=
l: drbd r0 DRBD9_1: Preparing remote state change 550148406 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRB=
D9_1: Committing remote state change 550148406</div><div>Aug 16 09:33:46 DR=
BD9_2 kernel: drbd r0: Preparing cluster-wide state change 1936541420 (1-&g=
t;2 499/146)</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0: State chang=
e 1936541420: primary_nodes=3D0, weak_nodes=3D0</div><div>Aug 16 09:33:46 D=
RBD9_2 kernel: drbd r0: Committing cluster-wide state change 1936541420 (1m=
s)</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Connect=
ing -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Aug 16 09:3=
3:46 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 204800</div><div>Aug 16=
 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: c_size: 194560 u_size: 0=
 d_size: 194560 max_size: 194560</div><div>Aug 16 09:33:46 DRBD9_2 kernel: =
drbd r0/0 drbd1 DRBD9_3: la_size: 204800 my_usize: 0 my_max_size: 204800</d=
iv><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0=
 idx: 0 bm-uuid: 0x0 flags: 0x11 max_size: 204800 (UpToDate)</div><div>Aug =
16 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>Aug 16=
 09:33:46 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx: 1 bm-uui=
d: 0x0 flags: 0x10 max_size: 194560 (DUnknown)</div><div>Aug 16 09:33:46 DR=
BD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: The peer&#39;s disk size is too smal=
l! (194560 &lt; 204800 sectors)</div><div>Aug 16 09:33:46 DRBD9_2 kernel: d=
rbd r0 DRBD9_3: conn( Connected -&gt; Disconnecting ) peer( Secondary -&gt;=
 Unknown )</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: error=
 receiving P_SIZES, e: -5 l: 0!</div><div>Aug 16 09:33:46 DRBD9_2 kernel: d=
rbd r0 DRBD9_3: ack_receiver terminated</div><div>Aug 16 09:33:46 DRBD9_2 k=
ernel: drbd r0 DRBD9_3: Terminating ack_recv thread</div><div>Aug 16 09:33:=
46 DRBD9_2 kernel: drbd r0 DRBD9_3: Connection closed</div><div>Aug 16 09:3=
3:46 DRBD9_2 kernel: drbd r0 DRBD9_3: conn( Disconnecting -&gt; StandAlone =
)</div><div>Aug 16 09:33:46 DRBD9_2 kernel: drbd r0 DRBD9_3: Terminating re=
ceiver thread</div><div><br></div><div>&lt;DRBD9_3&gt;</div><div>...</div><=
div><div>Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194=
560</div><div>Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: c_si=
ze: 204800 u_size: 0 d_size: 204800 max_size: 204800</div><div>Aug 16 09:32=
:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 0 my_usize: 0</div><d=
iv>Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx:=
 0 bm-uuid: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div>Aug 16 09:32:27=
 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 fl=
ags: 0x0 max_size: 204800 (DUnknown)</div><div>Aug 16 09:32:27 DRBD9_3 kern=
el: drbd r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:32:27 DRBD9_3 kernel=
: drbd r0/0 drbd1 DRBD9_2: calling drbd_determine_dev_size()</div><div>Aug =
16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-u=
uid: 0x0 flags: 0x0 max_size: 0 (DUnknown)</div><div>Aug 16 09:32:27 DRBD9_=
3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0x=
0 max_size: 204800 (DUnknown)</div><div>Aug 16 09:32:27 DRBD9_3 kernel: drb=
d r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:32:27 DRBD9_3 kernel: drbd =
r0/0 drbd1 DRBD9_2: drbd_sync_handshake:</div><div>Aug 16 09:32:27 DRBD9_3 =
kernel: drbd r0/0 drbd1 DRBD9_2: self 0000000000000004:<wbr>000000000000000=
0:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>Aug =
16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer 0000000000000004:=
<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:1280=
 flags:24</div><div>Aug 16 09:32:27 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2=
: uuid_compare()=3D0 by rule 10</div><div>Aug 16 09:32:27 DRBD9_3 kernel: d=
rbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown -&gt; Inconsistent ) repl( Off -&gt;=
 Established )</div><div>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: H=
andshake successful: Agreed network protocol version 111</div><div>Aug 16 0=
9:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Feature flags enabled on protocol =
level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Aug 16 09:32:30 DRBD9_3 k=
ernel: drbd r0 DRBD9_1: Starting ack_recv thread (from drbd_r_r0 [109747])<=
/div><div>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Preparing remote=
 state change 1968584032 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug =
16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: Committing remote state change=
 1968584032</div><div>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0 DRBD9_1: conn=
( Connecting -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Au=
g 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560</div><d=
iv>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 204800 =
u_size: 0 d_size: 204800 max_size: 204800</div><div>Aug 16 09:32:30 DRBD9_3=
 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 0 my_usize: 0</div><div>Aug 16 0=
9:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid:=
 0x0 flags: 0x0 max_size: 204800 (DUnknown)</div><div>Aug 16 09:32:30 DRBD9=
_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0=
x13 max_size: 204800 (Inconsistent)</div><div>Aug 16 09:32:30 DRBD9_3 kerne=
l: drbd r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:32:30 DRBD9_3 kernel:=
 drbd r0/0 drbd1 DRBD9_1: calling drbd_determine_dev_size()</div><div>Aug 1=
6 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uu=
id: 0x0 flags: 0x0 max_size: 204800 (DUnknown)</div><div>Aug 16 09:32:30 DR=
BD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags=
: 0x13 max_size: 204800 (Inconsistent)</div><div>Aug 16 09:32:30 DRBD9_3 ke=
rnel: drbd r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:32:30 DRBD9_3 kern=
el: drbd r0/0 drbd1 DRBD9_1: drbd_sync_handshake:</div><div>Aug 16 09:32:30=
 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: self 0000000000000004:<wbr>000000=
0000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div>=
<div>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer 00000000=
00000004:<wbr>0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000 =
bits:1280 flags:24</div><div>Aug 16 09:32:30 DRBD9_3 kernel: drbd r0/0 drbd=
1 DRBD9_1: uuid_compare()=3D0 by rule 10</div><div>Aug 16 09:32:30 DRBD9_3 =
kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown -&gt; Inconsistent ) repl( =
Off -&gt; Established )</div><div>Aug 16 09:32:36 DRBD9_3 kernel: drbd r0 D=
RBD9_1: Preparing remote state change 369176076 (primary_nodes=3D0, weak_no=
des=3D0)</div><div>Aug 16 09:32:36 DRBD9_3 kernel: drbd r0 DRBD9_1: Committ=
ing remote state change 369176076</div><div>Aug 16 09:32:56 DRBD9_3 kernel:=
 drbd r0: Preparing cluster-wide state change 1953992009 (2-&gt;-1 7683/460=
9)</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: State change 19539920=
09: primary_nodes=3D4, weak_nodes=3DFFFFFFFFFFFFFFF8</div><div>Aug 16 09:32=
:56 DRBD9_3 kernel: drbd r0: Committing cluster-wide state change 195399200=
9 (0ms)</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0: role( Secondary =
-&gt; Primary )</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: =
disk( Inconsistent -&gt; UpToDate )</div><div>Aug 16 09:32:56 DRBD9_3 kerne=
l: drbd r0/0 drbd1: size =3D 95 MB (97280 KB)</div><div>Aug 16 09:32:56 DRB=
D9_3 kernel: drbd r0: Forced to consider local data as UpToDate!</div><div>=
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1: new current UUID: D43B0300=
042F33B9 weak: FFFFFFFFFFFFFFF8</div><div>Aug 16 09:32:56 DRBD9_3 kernel: d=
rbd r0/0 drbd1 DRBD9_1: drbd_sync_handshake:</div><div>Aug 16 09:32:56 DRBD=
9_3 kernel: drbd r0/0 drbd1 DRBD9_1: self D43B0300042F33B9:<wbr>00000000000=
00000:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>=
Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer 0000000000000=
004:<wbr>FFFFFFFFFFFFFFFF:<wbr>0000000000000000:<wbr>0000000000000000 bits:=
24320 flags:104</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 D=
RBD9_1: uuid_compare()=3D3 by rule 30</div><div>Aug 16 09:32:56 DRBD9_3 ker=
nel: drbd r0/0 drbd1 DRBD9_1: Writing the whole bitmap, full sync required =
after drbd_sync_handshake.</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r=
0/0 drbd1 DRBD9_2: drbd_sync_handshake:</div><div>Aug 16 09:32:56 DRBD9_3 k=
ernel: drbd r0/0 drbd1 DRBD9_2: self D43B0300042F33B9:<wbr>0000000000000000=
:<wbr>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>Aug 1=
6 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer 0000000000000004:<=
wbr>FFFFFFFFFFFFFFFF:<wbr>0000000000000000:<wbr>0000000000000000 bits:24320=
 flags:104</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_=
2: uuid_compare()=3D3 by rule 30</div><div>Aug 16 09:32:56 DRBD9_3 kernel: =
drbd r0/0 drbd1 DRBD9_2: Writing the whole bitmap, full sync required after=
 drbd_sync_handshake.</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 d=
rbd1: drbd_r_r0[109748] going to &#39;set_n_write from sync_handshake&#39; =
but bitmap already locked for &#39;set_n_write from sync_handshake&#39; by =
drbd_r_r0[109747]</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1=
 DRBD9_1: repl( Established -&gt; WFBitMapS )</div><div>Aug 16 09:32:56 DRB=
D9_3 kernel: drbd r0/0 drbd1 DRBD9_1: send bitmap stats [Bytes(packets)]: p=
lain 0(0), RLE 21(1), total 21; compression: 99.4%</div><div>Aug 16 09:32:5=
6 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: repl( Established -&gt; WFBitMap=
S )</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: send=
 bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compressio=
n: 99.4%</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1:=
 receive bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; co=
mpression: 99.4%</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 =
DRBD9_1: helper command: /sbin/drbdadm before-resync-source</div><div>Aug 1=
6 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: receive bitmap stats [B=
ytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.4%</div><d=
iv>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: helper command:=
 /sbin/drbdadm before-resync-source</div><div>Aug 16 09:32:56 DRBD9_3 kerne=
l: drbd r0/0 drbd1 DRBD9_2: helper command: /sbin/drbdadm before-resync-sou=
rce exit code 0 (0x0)</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 d=
rbd1 DRBD9_2: repl( WFBitMapS -&gt; SyncSource )</div><div>Aug 16 09:32:56 =
DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: Began resync as SyncSource (will s=
ync 97280 KB [24320 bits set]).</div><div>Aug 16 09:32:56 DRBD9_3 kernel: d=
rbd r0/0 drbd1 DRBD9_1: helper command: /sbin/drbdadm before-resync-source =
exit code 0 (0x0)</div><div>Aug 16 09:32:56 DRBD9_3 kernel: drbd r0/0 drbd1=
 DRBD9_1: repl( WFBitMapS -&gt; SyncSource )</div><div>Aug 16 09:32:56 DRBD=
9_3 kernel: drbd r0/0 drbd1 DRBD9_1: Began resync as SyncSource (will sync =
97280 KB [24320 bits set]).</div><div>Aug 16 09:33:12 DRBD9_3 kernel: drbd =
r0/0 drbd1 DRBD9_1: Resync done (total 15 sec; paused 0 sec; 6484 K/sec)</d=
iv><div>Aug 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inco=
nsistent -&gt; UpToDate ) repl( SyncSource -&gt; Established )</div><div>Au=
g 16 09:33:12 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: Resync done (total 1=
5 sec; paused 0 sec; 6484 K/sec)</div><div>Aug 16 09:33:12 DRBD9_3 kernel: =
drbd r0/0 drbd1 DRBD9_2: pdsk( Inconsistent -&gt; UpToDate ) repl( SyncSour=
ce -&gt; Established )</div><div>Aug 16 09:33:22 DRBD9_3 kernel: drbd r0: r=
ole( Primary -&gt; Secondary )</div><div>Aug 16 09:33:26 DRBD9_3 kernel: dr=
bd r0: Preparing cluster-wide state change 3319188407 (2-&gt;0 496/16)</div=
><div>Aug 16 09:33:26 DRBD9_3 kernel: drbd r0: State change 3319188407: pri=
mary_nodes=3D0, weak_nodes=3D0</div><div>Aug 16 09:33:26 DRBD9_3 kernel: dr=
bd r0: Committing cluster-wide state change 3319188407 (0ms)</div><div>Aug =
16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connected -&gt; Disconne=
cting ) peer( Secondary -&gt; Unknown )</div><div>Aug 16 09:33:26 DRBD9_3 k=
ernel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate -&gt; DUnknown ) repl( Estab=
lished -&gt; Off )</div><div>Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_=
1: ack_receiver terminated</div><div>Aug 16 09:33:26 DRBD9_3 kernel: drbd r=
0 DRBD9_1: Terminating ack_recv thread</div><div>Aug 16 09:33:26 DRBD9_3 ke=
rnel: drbd r0 DRBD9_1: Connection closed</div><div>Aug 16 09:33:26 DRBD9_3 =
kernel: drbd r0 DRBD9_1: conn( Disconnecting -&gt; StandAlone )</div><div>A=
ug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating receiver thread=
</div><div>Aug 16 09:33:26 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating sen=
der thread</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: Preparing clu=
ster-wide state change 2471101321 (2-&gt;1 496/16)</div><div>Aug 16 09:33:2=
7 DRBD9_3 kernel: drbd r0: State change 2471101321: primary_nodes=3D0, weak=
_nodes=3D0</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Clust=
er is now split</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0: Committi=
ng cluster-wide state change 2471101321 (6ms)</div><div>Aug 16 09:33:27 DRB=
D9_3 kernel: drbd r0 DRBD9_2: conn( Connected -&gt; Disconnecting ) peer( S=
econdary -&gt; Unknown )</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/=
0 drbd1 DRBD9_2: pdsk( UpToDate -&gt; DUnknown ) repl( Established -&gt; Of=
f )</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: ack_receiver=
 terminated</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Term=
inating ack_recv thread</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0 D=
RBD9_2: Connection closed</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0=
 DRBD9_2: conn( Disconnecting -&gt; StandAlone )</div><div>Aug 16 09:33:27 =
DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating receiver thread</div><div>Aug =
16 09:33:27 DRBD9_3 kernel: drbd r0 DRBD9_2: Terminating sender thread</div=
><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1: disk( UpToDate -&gt;=
 Detaching )</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drbd r0/0 drbd1: dis=
k( Detaching -&gt; Diskless )</div><div>Aug 16 09:33:27 DRBD9_3 kernel: drb=
d r0/0 drbd1: drbd_bm_resize called with capacity =3D=3D 0</div><div>Aug 16=
 09:33:27 DRBD9_3 kernel: drbd r0: Terminating worker thread</div><div>Aug =
16 09:33:45 DRBD9_3 kernel: drbd r0: Starting worker thread (from drbdsetup=
 [109966])</div><div>Aug 16 09:33:45 DRBD9_3 systemd-udevd: error: /dev/drb=
d1: Wrong medium type</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 d=
rbd1: disk( Diskless -&gt; Attaching )</div><div>Aug 16 09:33:45 DRBD9_3 ke=
rnel: drbd r0/0 drbd1: Maximum number of peer devices =3D 2</div><div>Aug 1=
6 09:33:45 DRBD9_3 kernel: drbd r0: Method to ensure write ordering: flush<=
/div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 0 idx: =
0 bm-uuid: 0x0 flags: 0x10 (not currently reachable)</div><div>Aug 16 09:33=
:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 1 idx: 1 bm-uuid: 0x0 flags: =
0x10 (not currently reachable)</div><div>Aug 16 09:33:45 DRBD9_3 kernel: dr=
bd r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd=
 r0/0 drbd1: Adjusting my ra_pages to backing device&#39;s (32 -&gt; 1024)<=
/div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 0 idx: =
0 bm-uuid: 0x0 flags: 0x10 (not currently reachable)</div><div>Aug 16 09:33=
:45 DRBD9_3 kernel: drbd r0/0 drbd1: node_id: 1 idx: 1 bm-uuid: 0x0 flags: =
0x10 (not currently reachable)</div><div>Aug 16 09:33:45 DRBD9_3 kernel: dr=
bd r0/0 drbd1: my node_id: 2</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd=
 r0/0 drbd1: drbd_bm_resize called with capacity =3D=3D 194560</div><div>Au=
g 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D24320 =
words=3D760 pages=3D2</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 d=
rbd1: size =3D 95 MB (97280 KB)</div><div>Aug 16 09:33:45 DRBD9_3 kernel: d=
rbd r0/0 drbd1: recounting of set bits took additional 0ms</div><div>Aug 16=
 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: disk( Attaching -&gt; UpToDate )=
</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0/0 drbd1: attached to cur=
rent UUID: D43B0300042F33B8</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd =
r0 DRBD9_1: Starting sender thread (from drbdsetup [109976])</div><div>Aug =
16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: Starting sender thread (from d=
rbdsetup [109980])</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_=
1: conn( StandAlone -&gt; Unconnected )</div><div>Aug 16 09:33:45 DRBD9_3 k=
ernel: drbd r0 DRBD9_1: Starting receiver thread (from drbd_w_r0 [109967])<=
/div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Unconnecte=
d -&gt; Connecting )</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD=
9_2: conn( StandAlone -&gt; Unconnected )</div><div>Aug 16 09:33:45 DRBD9_3=
 kernel: drbd r0 DRBD9_2: Starting receiver thread (from drbd_w_r0 [109967]=
)</div><div>Aug 16 09:33:45 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Unconnec=
ted -&gt; Connecting )</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DR=
BD9_1: Handshake successful: Agreed network protocol version 111</div><div>=
Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Feature flags enabled on p=
rotocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Aug 16 09:33:46 D=
RBD9_3 kernel: drbd r0 DRBD9_1: Starting ack_recv thread (from drbd_r_r0 [1=
09985])</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Handshak=
e successful: Agreed network protocol version 111</div><div>Aug 16 09:33:46=
 DRBD9_3 kernel: drbd r0 DRBD9_2: Feature flags enabled on protocol level: =
0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Aug 16 09:33:46 DRBD9_3 kernel: =
drbd r0 DRBD9_2: Starting ack_recv thread (from drbd_r_r0 [109986])</div><d=
iv>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Preparing remote state =
change 550148406 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33=
:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Committing remote state change 5501484=
06</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Connect=
ing -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Aug 16 09:3=
3:46 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560</div><div>Aug 16=
 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 204800 u_size: 0=
 d_size: 204800 max_size: 204800</div><div>Aug 16 09:33:46 DRBD9_3 kernel: =
drbd r0/0 drbd1 DRBD9_1: la_size: 194560 my_usize: 0</div><div>Aug 16 09:33=
:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0=
 flags: 0x10 max_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 =
kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0x10=
 max_size: 0 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0=
 drbd1: my node_id: 2</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 d=
rbd1 DRBD9_1: calling drbd_determine_dev_size()</div><div>Aug 16 09:33:46 D=
RBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 flag=
s: 0x10 max_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kerne=
l: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0x10 max_=
size: 0 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd=
1: my node_id: 2</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 =
DRBD9_1: drbd_sync_handshake:</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drb=
d r0/0 drbd1 DRBD9_1: self D43B0300042F33B8:<wbr>0000000000000000:<wbr>0000=
000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>Aug 16 09:33:46=
 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: peer D43B0300042F33B8:<wbr>000000=
0000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:1280 flags:120<=
/div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_com=
pare()=3D0 by rule 38</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 d=
rbd1 DRBD9_1: pdsk( DUnknown -&gt; UpToDate ) repl( Off -&gt; Established )=
</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: sock was shut d=
own by peer</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn=
( Connected -&gt; BrokenPipe ) peer( Secondary -&gt; Unknown )</div><div>Au=
g 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( UpToDate -&gt;=
 DUnknown ) repl( Established -&gt; Off )</div><div>Aug 16 09:33:46 DRBD9_3=
 kernel: drbd r0 DRBD9_1: ack_receiver terminated</div><div>Aug 16 09:33:46=
 DRBD9_3 kernel: drbd r0 DRBD9_1: Terminating ack_recv thread</div><div>Aug=
 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Preparing remote state change=
 1936541420 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Aug 16 09:33:46 D=
RBD9_3 kernel: drbd r0 DRBD9_2: Committing remote state change 1936541420</=
div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Connecting =
-&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Aug 16 09:33:46=
 DRBD9_3 kernel: drbd r0/0 drbd1: current_size: 194560</div><div>Aug 16 09:=
33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 204800 u_size: 0 d_s=
ize: 204800 max_size: 204800</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd=
 r0/0 drbd1 DRBD9_2: la_size: 194560 my_usize: 0</div><div>Aug 16 09:33:46 =
DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 fla=
gs: 0x10 max_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kern=
el: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0x10 max=
_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/=
0 drbd1: my node_id: 2</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 =
drbd1 DRBD9_2: calling drbd_determine_dev_size()</div><div>Aug 16 09:33:46 =
DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 fla=
gs: 0x10 max_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kern=
el: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 1 bm-uuid: 0x0 flags: 0x10 max=
_size: 204800 (DUnknown)</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/=
0 drbd1: my node_id: 2</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 =
drbd1 DRBD9_2: drbd_sync_handshake:</div><div>Aug 16 09:33:46 DRBD9_3 kerne=
l: drbd r0/0 drbd1 DRBD9_2: self D43B0300042F33B8:<wbr>0000000000000000:<wb=
r>0000000000000000:<wbr>0000000000000000 bits:0 flags:0</div><div>Aug 16 09=
:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: peer D43B0300042F33B8:<wbr>=
0000000000000000:<wbr>0000000000000000:<wbr>0000000000000000 bits:1280 flag=
s:20</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: uui=
d_compare()=3D0 by rule 40</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r=
0/0 drbd1 DRBD9_2: pdsk( DUnknown -&gt; UpToDate ) repl( Off -&gt; Establis=
hed )</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: Connection=
 closed</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_1: conn( Br=
okenPipe -&gt; Unconnected )</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd=
 r0 DRBD9_1: Restarting receiver thread</div><div>Aug 16 09:33:46 DRBD9_3 k=
ernel: drbd r0 DRBD9_1: conn( Unconnected -&gt; Connecting )</div><div>Aug =
16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: sock was shut down by peer</di=
v><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Connected -&g=
t; BrokenPipe ) peer( Secondary -&gt; Unknown )</div><div>Aug 16 09:33:46 D=
RBD9_3 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( UpToDate -&gt; DUnknown ) rep=
l( Established -&gt; Off )</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r=
0 DRBD9_2: ack_receiver terminated</div><div>Aug 16 09:33:46 DRBD9_3 kernel=
: drbd r0 DRBD9_2: Terminating ack_recv thread</div><div>Aug 16 09:33:46 DR=
BD9_3 kernel: drbd r0 DRBD9_2: Connection closed</div><div>Aug 16 09:33:46 =
DRBD9_3 kernel: drbd r0 DRBD9_2: conn( BrokenPipe -&gt; Unconnected )</div>=
<div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: Restarting receiver t=
hread</div><div>Aug 16 09:33:46 DRBD9_3 kernel: drbd r0 DRBD9_2: conn( Unco=
nnected -&gt; Connecting )</div></div></div></div></div></div></div></div><=
/div></div></div></div></div>
</div><div hspace=3D"streak-pt-mark" style=3D"max-height:1px"><img style=3D=
"width:0px;max-height:0px;overflow:hidden" src=3D"https://mailfoogae.appspo=
t.com/t?sender=3Daa21wYWtAbWFudGVjaC5jby5rcg%3D%3D&amp;type=3Dzerocontent&a=
mp;guid=3D5e583dbe-1b1d-4264-a7f6-ebd983105e89"><font color=3D"#ffffff" siz=
e=3D"1">=E1=90=A7</font></div>

--94eb2c032594c1b55b053a26108c--
