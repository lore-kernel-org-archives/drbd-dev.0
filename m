Return-Path: <Peter.Petrakis@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Jan 2010 18:11:17 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C969FBEF@EXHQ.corp.stratus.com>
From: "Petrakis, Peter" <Peter.Petrakis@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] syncsource -> sync completed ack lost
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi guys,

This is on drbd 8.2.7. The sync target was recently outdarted and
resynced
just fine but it seems that the sync source didn't wasn't notified of
the
event. Any ideas? Thanks in advance.


version: 8.2.7 (api:88/proto:86-88)

GIT-hash: c30886320bdf6c25b6cd41fa8d7645de683032d6 build by
sntriage@church14.sn.stratus.com, 2010-01-05 01:13:04
 0: cs:Connected st:Primary/Secondary ds:UpToDate/UpToDate C r---

    ns:3337350 nr:0 dw:511950 dr:3897066 al:312 bm:615 lo:0 pe:0 ua:0
ap:0 ep:1 wo:b oos:0                    =20
 5: cs:SyncSource st:Primary/Secondary ds:UpToDate/Outdated C r---

    ns:1162884 nr:9892 dw:259796 dr:1143170 al:29 bm:156 lo:0 pe:0 ua:0
ap:0 ep:1 wo:d oos:19612              =20
        [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>....] sync'ed: =
80.0% (19612/79260)K

        stalled

GIT-hash: c30886320bdf6c25b6cd41fa8d7645de683032d6 build by
sntriage@church14.sn.stratus.com, 2010-01-05 01:13:04
 0: cs:Connected st:Secondary/Primary ds:UpToDate/UpToDate C r---
    ns:0 nr:472290 dw:472290 dr:0 al:0 bm:19 lo:0 pe:0 ua:0 ap:0 ep:1
wo:d oos:0
 5: cs:Connected st:Secondary/Primary ds:UpToDate/UpToDate C r---
    ns:0 nr:79260 dw:79260 dr:0 al:0 bm:26 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b
oos:0

From the logs... First compared to a completed sync...

Jan  5 13:11:41 node0 kernel: drbd16: conn( WFBitMapS -> SyncSource )
Jan  5 13:11:41 node0 kernel: drbd16: Began resync as SyncSource (will
sync 262100 KB [65525 bits set]).
Jan  5 13:11:42 node0 kernel: drbd16: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
Jan  5 13:11:42 node0 kernel: drbd16: Resync suspended
Jan  5 13:11:42 node0 kernel: drbd16: peer_isp( 0 -> 1 )
Jan  5 13:12:16 node0 kernel: drbd16: aftr_isp( 1 -> 0 )
Jan  5 13:12:16 node0 kernel: drbd16: conn( PausedSyncS -> SyncSource )
peer_isp( 1 -> 0 )
Jan  5 13:12:16 node0 kernel: drbd16: Syncer continues.
Jan  5 13:12:24 node0 kernel: drbd16: Resync done (total 42 sec; paused
34 sec; 32760 K/sec)
Jan  5 13:12:24 node0 kernel: drbd16: conn( SyncSource -> Connected )
pdsk( Inconsistent -> UpToDate )


and then the fault with drbd5 on node0.

Jan  5 14:29:54 node0 kernel: EXT3 FS on drbd5, internal journal
Jan  5 14:36:13 node0 kernel: drbd5: aftr_isp( 0 -> 1 )
Jan  5 14:36:15 node0 kernel: drbd5: Handshake successful: Agreed
network protocol version 88
Jan  5 14:36:15 node0 kernel: drbd5: conn( WFConnection ->
WFReportParams )
Jan  5 14:36:15 node0 kernel: drbd5: Starting asender thread (from
drbd5_receiver [22769])
Jan  5 14:36:15 node0 kernel: drbd5: data-integrity-alg: <not-used>
Jan  5 14:36:16 node0 kernel: drbd5: drbd_sync_handshake:
Jan  5 14:36:16 node0 kernel: drbd5: self
040F964A002C6EF1:52D8C510A4062918:CA9E36C8A20AD72C:C05CBA2C4A164444
Jan  5 14:36:16 node0 kernel: drbd5: peer
52D8C510A4062918:0000000000000000:CA9E36C8A20AD72C:C05CBA2C4A164444
Jan  5 14:36:16 node0 kernel: drbd5: uuid_compare()=3D1 by rule 7
Jan  5 14:36:16 node0 kernel: drbd5: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) peer_isp( 0 -> 1 )
Jan  5 14:36:16 node0 kernel: drbd5: aftr_isp( 1 -> 0 )
Jan  5 14:36:16 node0 kernel: drbd5:  uuid[History_start] now
52D8C510A4062918
Jan  5 14:36:16 node0 kernel: drbd5:  uuid[Bitmap] now 4D67E77D0615C380
Jan  5 14:36:16 node0 kernel: drbd5: conn( WFBitMapS -> PausedSyncS )
pdsk( Outdated -> Inconsistent )
Jan  5 14:36:16 node0 kernel: drbd5: Began resync as PausedSyncS (will
sync 79260 KB [19815 bits set]).
Jan  5 14:36:16 node0 kernel: drbd5: conn( PausedSyncS -> SyncSource )
pdsk( Inconsistent -> Outdated ) peer_isp( 1 -> 0 )
Jan  5 14:36:16 node0 kernel: drbd5: Syncer continues.
                                                          =20

Node0 was never notified that node1 was done syncing. We could have
failed to send the UUID or were in some weird state and were unable to
receive it.

Compared to node1...

Jan  5 14:36:15 node1 kernel: drbd5: Starting asender thread (from
drbd5_receiver [24374])
Jan  5 14:36:15 node1 kernel: drbd5: data-integrity-alg: <not-used>
Jan  5 14:36:15 node1 kernel: drbd5: drbd_sync_handshake:
Jan  5 14:36:15 node1 kernel: drbd5: self
52D8C510A4062918:0000000000000000:CA9E36C8A20AD72C:C05CBA2C4A164444
Jan  5 14:36:15 node1 kernel: drbd5: peer
040F964A002C6EF1:52D8C510A4062918:CA9E36C8A20AD72C:C05CBA2C4A164444
Jan  5 14:36:15 node1 kernel: drbd5: uuid_compare()=3D-1 by rule 5
Jan  5 14:36:15 node1 kernel: drbd5: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapT ) disk( Consistent -> Outdated ) pdsk(
DUnknown -> UpToDate ) peer_isp( 0 -> 1 )
Jan  5 14:36:16 node1 kernel: drbd5: conn( WFBitMapT -> WFSyncUUID )
Jan  5 14:36:16 node1 kernel: drbd5: peer_isp( 1 -> 0 )
Jan  5 14:36:16 node1 kernel: drbd5: aftr_isp( 1 -> 0 )
Jan  5 14:36:16 node1 kernel: drbd5:  exposed data uuid now
4D67E77D0615C380
Jan  5 14:36:16 node1 kernel: drbd5:  uuid[Current] now 4D67E77D0615C380
Jan  5 14:36:16 node1 kernel: drbd5:  uuid[Bitmap] now 0000000000000000
Jan  5 14:36:16 node1 kernel: drbd5: helper command:
/usr/lib/spine/bin/avance_drbd_helper before-resync-target minor-5
Jan  5 14:36:16 node1 kernel: drbd5: helper command:
/usr/lib/spine/bin/avance_drbd_helper before-resync-target minor-5 exit
code 0 (0x0)
Jan  5 14:36:16 node1 kernel: drbd5: conn( WFSyncUUID -> SyncTarget )
disk( Outdated -> Inconsistent )
Jan  5 14:36:16 node1 kernel: drbd5: Began resync as SyncTarget (will
sync 79260 KB [19815 bits set]).
Jan  5 14:36:18 node1 kernel: drbd5: Resync done (total 2 sec; paused 0
sec; 39628 K/sec)
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[Bitmap] now 52D8C510A4062918
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[History_start] now
CA9E36C8A20AD72C
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[History_end] now
C05CBA2C4A164444
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[History_start] now
52D8C510A4062918
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[Bitmap] now 4D67E77D0615C380
Jan  5 14:36:18 node1 kernel: drbd5:  exposed data uuid now
040F964A002C6EF0
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[Current] now 040F964A002C6EF0
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[History_start] now
4D67E77D0615C380
Jan  5 14:36:18 node1 kernel: drbd5:  uuid[Bitmap] now 0000000000000000
Jan  5 14:36:18 node1 kernel: drbd5: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
Jan  5 14:36:18 node1 kernel: drbd5:  exposed data uuid now
040F964A002C6EF0
Jan  5 14:36:18 node1 kernel: drbd5: helper command:
/usr/lib/spine/bin/avance_drbd_helper after-resync-target minor-5
Jan  5 14:36:18 node1 kernel: drbd5: helper command:
/usr/lib/spine/bin/avance_drbd_helper after-resync-target minor-5 exit
code 0 (0x0)



