Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: failed to complete sync due to receiving
	bitmapin unexpected state
Date: Tue, 12 Dec 2006 07:46:59 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104316DC5@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Presumably there is a window where one side is out of the paused
> state
> > before the other.
> >
> > Simon Grham actually did a bit of analysis of this and think that
the
> > problem might be a race condition in
drbd_receive.c:receive_bitmap().
> > Any ideas, because I cannot reproduce this at reliably at this time.
>=20
> Not yet...
> is any state change Secondary->Primary involved,
> or are the only (re)connecting?
>=20

There is no primary/secondary change at this time - what I think I saw
looking at the logs for the one case we have is something like this:

1. drbd volume starts resyncing after target side system is restarted.
2. A 2nd volume which is ahead of the volume in question starts
resyncing, so syncing is paused,
   we enter SyncPauseT/SyncPauseS
3. When the 2nd volume completes, the source side goes back to WFBitmapS
and sends its bitmap
4. The target side is still in SyncPauseT when the bitmap arrives so we
get the message
   about being in an unexpected cstate _and_ we don't send the targets
bitmap.

Once we are here, the target goes ahead and resyncs the volume and
eventually moves itself to the Connected state but the source side never
leaves WFBitmapS since it didn't get the targets bitmap.

I've included the messages logged for the specific volume on both sides
below (as Ernest mentioned, the clock on the two systems were not
synchronized but I'm reasonably sure these are the matching logs)

My theory was that there is a timing window relative to moving from the
PauseSync{T|S} state such that one side can get there first and restart
syncing before the other side.

Simon

=3D=3D=3D=3D Source Side Messages =3D=3D=3D=3D

   4733:Dec 10 04:52:22 jane kernel: drbd1: conn( WFConnection ->
WFReportParams )=20
   4737:Dec 10 04:52:22 jane kernel: drbd1: Handshake successful: DRBD
Network Protocol version 85
   4742:Dec 10 04:52:22 jane kernel: drbd1: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )=20
   4748:Dec 10 04:52:23 jane kernel: drbd1: Writing meta data super
block now.
   4750:Dec 10 04:52:23 jane kernel: drbd1: conn( WFBitMapS ->
SyncSource ) pdsk( UpToDate -> Inconsistent )=20
   4752:Dec 10 04:52:23 jane kernel: drbd1: Began resync as SyncSource
(will sync 1136 KB [284 bits set]).
   4753:Dec 10 04:52:23 jane kernel: drbd1: Writing meta data super
block now.
   4755:Dec 10 04:52:23 jane kernel: drbd1: conn( SyncSource ->
PausedSyncS ) aftr_isp( 0 -> 1 )=20
   4756:Dec 10 04:52:23 jane kernel: drbd1: Resync suspended
   4764:Dec 10 04:52:23 jane kernel: drbd1: peer_isp( 0 -> 1 )=20
   4765:Dec 10 04:52:24 jane kernel: drbd1: Resync done (total 1 sec;
paused 0 sec; 1136 K/sec)
   4766:Dec 10 04:52:24 jane kernel: drbd1: conn( PausedSyncS ->
Connected ) pdsk( Inconsistent -> UpToDate )=20
   4767:Dec 10 04:52:24 jane kernel: drbd1: Writing meta data super
block now.
   4770:Dec 10 04:52:24 jane kernel: drbd1: aftr_isp( 1 -> 0 )=20
   4772:Dec 10 04:52:24 jane kernel: drbd1: conn( Connected -> WFBitMapS
) pdsk( UpToDate -> Inconsistent )=20
   4773:Dec 10 04:52:24 jane kernel: drbd1: Writing meta data super
block now.
   4779:Dec 10 04:52:25 jane kernel: drbd1: pdsk( Inconsistent ->
UpToDate ) peer_isp( 1 -> 0 )=20
   4782:Dec 10 04:52:25 jane kernel: drbd1: Writing meta data super
block now.

=3D=3D=3D=3D Target Side Messages =3D=3D=3D=3D

   6421:Dec 10 04:52:51 george kernel: drbd1: disk( Diskless ->
Attaching )=20
   6423:Dec 10 04:52:51 george kernel: drbd1: Found 6 transactions (324
active extents) in activity log.
   6425:Dec 10 04:52:51 george kernel: drbd1: max_segment_size ( =3D BIO
size ) =3D 32768
   6427:Dec 10 04:52:51 george kernel: drbd1: drbd_bm_resize called with
capacity =3D=3D 30735368
   6429:Dec 10 04:52:51 george kernel: drbd1: resync bitmap:
bits=3D3841921 words=3D120062
   6431:Dec 10 04:52:51 george kernel: drbd1: size =3D 14 GB (15367684 =
KB)
   6433:Dec 10 04:52:51 george kernel: drbd1: reading of bitmap took 58
jiffies
   6435:Dec 10 04:52:51 george kernel: drbd1: recounting of set bits
took additional 0 jiffies
   6437:Dec 10 04:52:51 george kernel: drbd1: 0 KB marked out-of-sync by
on disk bit-map.
   6439:Dec 10 04:52:51 george kernel: drbd1: disk( Attaching ->
UpToDate )=20
   6441:Dec 10 04:52:51 george kernel: drbd1: Writing meta data super
block now.
   6477:Dec 10 04:52:51 george kernel: drbd1: conn( StandAlone ->
Unconnected )=20
   6479:Dec 10 04:52:51 george kernel: drbd1: receiver (re)started
   6481:Dec 10 04:52:51 george kernel: drbd1: conn( Unconnected ->
WFConnection )=20
   6497:Dec 10 04:52:51 george kernel: drbd1: conn( WFConnection ->
WFReportParams )=20
   6499:Dec 10 04:52:51 george kernel: drbd1: Handshake successful: DRBD
Network Protocol version 85
   6513:Dec 10 04:52:51 george kernel: drbd1: peer( Unknown -> Primary )
conn( WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )=20
   6515:Dec 10 04:52:51 george kernel: drbd1: Writing meta data super
block now.
   6529:Dec 10 04:52:51 george kernel: drbd1: conn( WFBitMapT ->
WFSyncUUID )=20
   6530:Dec 10 04:52:51 george kernel: drbd1: conn( WFSyncUUID ->
SyncTarget ) disk( UpToDate -> Inconsistent )=20
   6532:Dec 10 04:52:51 george kernel: drbd1: Began resync as SyncTarget
(will sync 1136 KB [284 bits set]).
   6533:Dec 10 04:52:51 george kernel: drbd1: Writing meta data super
block now.
   6536:Dec 10 04:52:51 george kernel: drbd1: conn( SyncTarget ->
PausedSyncT ) aftr_isp( 0 -> 1 )=20
   6537:Dec 10 04:52:51 george kernel: drbd1: Resync suspended
   6552:Dec 10 04:52:52 george kernel: drbd1: peer_isp( 0 -> 1 )=20
   6553:Dec 10 04:52:52 george kernel: drbd1: peer_isp( 1 -> 0 )=20
   6554:Dec 10 04:52:52 george kernel: drbd1: unexpected cstate
(PausedSyncT) in receive_bitmap
   6558:Dec 10 04:52:53 george kernel: drbd1: Resync done (total 1 sec;
paused 0 sec; 1136 K/sec)
   6562:Dec 10 04:52:53 george kernel: drbd1: conn( PausedSyncT ->
Connected ) disk( Inconsistent -> UpToDate )=20
   6564:Dec 10 04:52:53 george kernel: drbd1: Writing meta data super
block now.
   6570:Dec 10 04:52:53 george kernel: drbd1: aftr_isp( 1 -> 0 )=20
   6592:Dec 10 04:52:54 george kernel: drbd1: Writing meta data super
block now.
   6612:Dec 10 04:52:54 george kernel: drbd1: writing of bitmap took 4
jiffies
