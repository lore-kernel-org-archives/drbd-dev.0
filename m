Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82531.AF4EEDBE"
Date: Mon, 12 Nov 2007 08:41:10 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A31@EXNA.corp.stratus.com>
In-Reply-To: 200711121339.59824.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
	200711121339.59824.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: incorrect state transition Connected ->WFBitMapS
	and UpToDate->Inconsistent
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82531.AF4EEDBE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
We have been struggling with a problem where one side gets stuck in
WFBitMapS and Inconsistent State. Consider two nodes (Node0 and node1).


* Device r5 on node0 starts syncing as the synctarget.
* Device r5 is done syncing and on node0 we call drbd_resync_finished()
this gets delayed for a bit in drbd_rs_del_all()
* During this delay, device R0   wants to resync.  So the lower priority
devices like R5 gets paused.  This is were the trouble starts.
* drbd_resync_finished() is not done on node0.
* node0 goes "Connected" and sends its states to node1 and that triggers
a sync_handshake() which results in Connected ->WFBitMapS and
UpToDate->Inconsistent. We are stuck there.

So the problem, I think, is that while the synctarget is in
drbd_resync_finished() for a bit, a state change can occur causing the
peer that already finished to go into WFBitMapS and beyond.

We had a couple of ideas on how this may be fixed:
1)=20
We could find a way to NOT actually pause the sync _if_ the sync is in
fact already completed -- Perhaps modifying the pause-resync stuff so it
doesn't do it if there's nothing left to be resunk? (or if we're already
in the drbd_resync_finished processing - I dont know that there's a way
to tell this though).
I attempted to implement this a couple of ways but failed.

2)=20
* Don't call drbd_sync_handshake() if the peer state is > Connected.
AND...
* Send the synctarget states to the peer when the stalled sync is done.
This is suspiciously problematic but seems to actually close the racy
window.  I include the implementation as a patch here.

ANY other Ideas please??

Below is a set of logs when the problem occurs:

On node0:
Oct  4 14:55:58 node0 kernel: drbd60: Began resync as PausedSyncT (will
sync 768 KB [192 bits set]).
Oct  4 14:55:58 node0 kernel: drbd60: Writing meta data super block now.
Oct  4 14:55:59 node0 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:56:00 node0 kernel: drbd60: conn( PausedSyncT -> SyncTarget )
peer_isp( 1 -> 0 )
Oct  4 14:56:00 node0 kernel: drbd60: Syncer continues.
Oct  4 14:56:00 node0 kernel: drbd60: conn( SyncTarget -> PausedSyncT )
aftr_isp( 0 -> 1 )
Oct  4 14:56:00 node0 kernel: drbd60: Resync suspended
Oct  4 14:56:01 node0 kernel: drbd60: conn( PausedSyncT -> SyncTarget )
aftr_isp( 1 -> 0 )
Oct  4 14:56:01 node0 kernel: drbd60: Syncer continues.
Oct  4 14:56:01 node0 kernel: drbd60: ASSERT(
!test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
/sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786
Oct  4 14:56:01 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:01 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:01 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:03 node0 kernel: drbd60: conn( SyncTarget -> PausedSyncT )
aftr_isp( 0 -> 1 )
Oct  4 14:56:03 node0 kernel: drbd60: Resync suspended
Oct  4 14:56:03 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:05 node0 kernel: drbd60: conn( PausedSyncT -> SyncTarget )
aftr_isp( 1 -> 0 )
Oct  4 14:56:05 node0 kernel: drbd60: Syncer continues.
Oct  4 14:56:05 node0 kernel: drbd60: ASSERT(
!test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
/sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786
Oct  4 14:56:05 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:06 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:07 node0 kernel: drbd60: conn( SyncTarget -> PausedSyncT )
aftr_isp( 0 -> 1 )
Oct  4 14:56:07 node0 kernel: drbd60: Resync suspended
Oct  4 14:56:07 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:07 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node0 kernel: drbd60: conn( PausedSyncT -> SyncTarget )
aftr_isp( 1 -> 0 )
Oct  4 14:56:09 node0 kernel: drbd60: Syncer continues.
Oct  4 14:56:09 node0 kernel: drbd60: ASSERT(
!test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
/sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786
Oct  4 14:56:09 node0 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
sec; 384 K/sec)
Oct  4 14:56:09 node0 kernel: drbd60: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
Oct  4 14:56:09 node0 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
sec; 0 K/sec)
Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
sec; 0 K/sec)
Oct  4 14:56:09 node0 kernel: drbd60: Connected in w_make_resync_request
Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
sec; 0 K/sec)
Oct  4 14:56:10 node0 kernel: drbd60: unexpected cstate (Connected) in
receive_bitmap
Oct  4 14:56:10 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:56:10 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:32 node0 kernel: drbd60: aftr_isp( 0 -> 1 )
Oct  4 14:57:33 node0 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:57:35 node0 kernel: drbd60: aftr_isp( 0 -> 1 )
Oct  4 14:57:36 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:36 node0 kernel: drbd60: peer_isp( 0 -> 1 )
Oct  4 14:57:36 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:36 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:36 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:37 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:37 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:39 node0 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:57:39 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!
Oct  4 14:57:39 node0 kernel: drbd60: peer_isp( 1 -> 0 )
Oct  4 14:57:39 node0 kernel: drbd60: No resync, but 1048535 bits in
bitmap!

#################On node1###################
Oct  4 14:55:58 node1 kernel: drbd60: Began resync as PausedSyncS (will
sync 768 KB [192 bits set]).
Oct  4 14:55:58 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:00 node1 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:56:00 node1 kernel: drbd60: conn( PausedSyncS -> SyncSource )
peer_isp( 1 -> 0 )
Oct  4 14:56:00 node1 kernel: drbd60: Syncer continues.
Oct  4 14:56:01 node1 kernel: drbd60: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
Oct  4 14:56:01 node1 kernel: drbd60: Resync suspended
Oct  4 14:56:01 node1 kernel: drbd60: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
Oct  4 14:56:01 node1 kernel: drbd60: Syncer continues.
Oct  4 14:56:01 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:04 node1 kernel: drbd60: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
Oct  4 14:56:04 node1 kernel: drbd60: Resync suspended
Oct  4 14:56:04 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:05 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:06 node1 kernel: drbd60: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
Oct  4 14:56:06 node1 kernel: drbd60: Syncer continues.
Oct  4 14:56:06 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:08 node1 kernel: drbd60: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
Oct  4 14:56:08 node1 kernel: drbd60: Resync suspended
Oct  4 14:56:08 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:08 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node1 kernel: drbd60: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
Oct  4 14:56:09 node1 kernel: drbd60: Syncer continues.
Oct  4 14:56:09 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node1 kernel: drbd60: Retrying drbd_rs_del_all() later.
refcnt=3D1
Oct  4 14:56:09 node1 kernel: drbd60: Resync done (total 1 sec; paused 0
sec; 768 K/sec)
Oct  4 14:56:09 node1 kernel: drbd60: conn( SyncSource -> Connected )
pdsk( Inconsistent -> UpToDate )
Oct  4 14:56:09 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:09 node1 kernel: drbd60: Resync done (total 2 sec; paused 0
sec; 0 K/sec)
Oct  4 14:56:10 node1 kernel: drbd60: Becoming sync source due to disk
states.
Oct  4 14:56:10 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:10 node1 kernel: drbd60: writing of bitmap took 2 jiffies
Oct  4 14:56:10 node1 kernel: drbd60: 4095 MB marked out-of-sync by on
disk bit-map.
Oct  4 14:56:10 node1 kernel: drbd60: 4194140 KB now marked out-of-sync
by on disk bit-map.
Oct  4 14:56:10 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:10 node1 kernel: drbd60: conn( Connected -> WFBitMapS )
pdsk( UpToDate -> Inconsistent )
Oct  4 14:56:10 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:56:10 node1 kernel: drbd60: pdsk( Inconsistent -> UpToDate )
Oct  4 14:56:10 node1 kernel: drbd60: Writing meta data super block now.
Oct  4 14:57:34 node1 kernel: drbd60: aftr_isp( 0 -> 1 )
Oct  4 14:57:35 node1 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:57:35 node1 kernel: drbd60: aftr_isp( 0 -> 1 )
Oct  4 14:57:35 node1 kernel: drbd60: peer_isp( 0 -> 1 )
Oct  4 14:57:35 node1 kernel: drbd60: peer_isp( 1 -> 0 )
Oct  4 14:57:35 node1 kernel: drbd60: peer_isp( 0 -> 1 )
Oct  4 14:57:40 node1 kernel: drbd60: aftr_isp( 1 -> 0 )
Oct  4 14:57:40 node1 kernel: drbd60: peer_isp( 1 -> 0 )

------_=_NextPart_001_01C82531.AF4EEDBE
Content-Type: application/octet-stream;
	name="Wbimaps_stuck.patch"
Content-Transfer-Encoding: base64
Content-Description: Wbimaps_stuck.patch
Content-Disposition: attachment;
	filename="Wbimaps_stuck.patch"

SW5kZXg6IGRyYmRfcmVjZWl2ZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkX3JlY2VpdmVyLmMJKHJl
dmlzaW9uIDIwNzc4KQorKysgZHJiZF9yZWNlaXZlci5jCSh3b3JraW5nIGNvcHkpCkBAIC0yNDEw
LDYgKzI0MTAsNyBAQAogCWlmIChuY29ubiA9PSBXRlJlcG9ydFBhcmFtcyApIG5jb25uID0gQ29u
bmVjdGVkOwogCiAJaWYgKG1kZXYtPnBfdXVpZCAmJiBvY29ubiA8PSBDb25uZWN0ZWQgJiYKKyAg
ICAgICAgICAgcGVlcl9zdGF0ZS5jb25uIDw9IENvbm5lY3RlZCAmJgogCSAgICBwZWVyX3N0YXRl
LmRpc2sgPj0gTmVnb3RpYXRpbmcgJiYKIAkgICAgaW5jX2xvY2FsX2lmX3N0YXRlKG1kZXYsTmVn
b3RpYXRpbmcpICkgewogCQluY29ubj1kcmJkX3N5bmNfaGFuZHNoYWtlKG1kZXYscGVlcl9zdGF0
ZS5yb2xlLHBlZXJfc3RhdGUuZGlzayk7CkluZGV4OiBkcmJkX21haW4uYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBkcmJkX21haW4uYwkocmV2aXNpb24gMjA3NzgpCisrKyBkcmJkX21haW4uYwkod29ya2luZyBj
b3B5KQpAQCAtOTYxLDYgKzk2MSwxMiBAQAogCQlkcmJkX3NlbmRfc3RhdGUobWRldik7CiAJfQog
CisgICAgICAgLyogd2UganVzdCBmaW5pc2hlZCBzeW5jaW5nIGFzIHRoZSB0YXJnZXQgLCB0ZWxs
IHBlZXIgaW4gY2FzZSB3ZSB3ZXJlIGRlbGF5ZWQqLworICAgICAgIGlmICgob3MuY29ubiA9PSBT
eW5jVGFyZ2V0IHx8IG9zLmNvbm4gPT0gUGF1c2VkU3luY1QpICYmCisgICAgICAgICAgIChucy5j
b25uID09IENvbm5lY3RlZCkgKSB7CisgICAgICAgICAgZHJiZF9zZW5kX3N0YXRlKG1kZXYpOwor
ICAgICAgIH0KKwogCS8qIEluIGNhc2Ugb25lIG9mIHRoZSBpc3AgYml0cyBnb3Qgc2V0LCBzdXNw
ZW5kIG90aGVyIGRldmljZXMuICovCiAJaWYgKCAoICFvcy5hZnRyX2lzcCAmJiAhb3MucGVlcl9p
c3AgJiYgIW9zLnVzZXJfaXNwKSAmJgogCSAgICAgKCBucy5hZnRyX2lzcCB8fCBucy5wZWVyX2lz
cCB8fCBucy51c2VyX2lzcCkgKSB7Cg==

------_=_NextPart_001_01C82531.AF4EEDBE--
