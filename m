Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Aug 2008 23:52:30 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41EC30F85@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] 8.2.6 Peer disk state handling issue when attaching
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I have noticed that with 8.2.6, if the role of a device is
Secondary/Secondary and you detach and then re-attach a device, the peer
disk state on the other node ends up as Consistent instead of UpToDate -
it seems that in this case the code does not check if a resync is
required and goes directly from DiskLess->Consistent on the side that is
not doing the detach/attach.

Here is a sample extract from the messages file on the two systems:

First, on the system where you do the detach followed by attach
(connection state is Connected when this starts, roles are
Secondary/Secondary, disk UpToDate/UpToDate:

Aug  9 04:53:11 node0 kernel: drbd16: disk( UpToDate -> Diskless )=20

Aug  9 04:53:32 node0 kernel: drbd16: disk( Diskless -> Attaching )=20
Aug  9 04:53:32 node0 kernel: drbd16: No usable activity log found.
Aug  9 04:53:32 node0 kernel: drbd16: max_segment_size ( =3D BIO size ) =
=3D
32768
Aug  9 04:53:32 node0 kernel: drbd16: reading of bitmap took 1 jiffies
Aug  9 04:53:32 node0 kernel: drbd16: recounting of set bits took
additional 0 jiffies
Aug  9 04:53:32 node0 kernel: drbd16: 0 KB (0 bits) marked out-of-sync
by on disk bit-map.
Aug  9 04:53:32 node0 kernel: drbd16: disk( Attaching -> Negotiating )=20
Aug  9 04:53:32 node0 kernel: drbd16: Writing meta data super block now.
Aug  9 04:53:32 node0 kernel: drbd16: disk( Negotiating -> UpToDate )

On the other node (same starting state):

Aug  9 04:53:11 node1 kernel: drbd16: pdsk( UpToDate -> Diskless )=20

Aug  9 04:53:32 node1 kernel: drbd16: real peer disk state =3D =
Consistent
Aug  9 04:53:32 node1 kernel: drbd16: pdsk( Diskless -> Consistent )

I can see why the second node does not go to the UpToDate state - there
is a check in _drbd_set_state such that it only overwrites Consistent
with UpToDate if the connection state is also changing which it does not
in this case. HOWEVER, I'm not sure this is the right place to fix it -
it seems to me that we should check for a resync even in this case since
one or both of the disks could have been Primary and modified the disk
at some point and then been downgraded to Secondary - so we really need
to call drbd_sync_handshake even in this case, but we don't seem to...

I don't see any fixes post 8.2.6 that obviously address this but perhaps
I missed something? If not, any thoughts on the right way to fix this?

Thanks,
Simon
