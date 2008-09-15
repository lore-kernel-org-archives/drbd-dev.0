Return-Path: <Peter.Petrakis@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] 8.2.6 Peer disk state handling issue when attaching
Date: Mon, 15 Sep 2008 14:26:15 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E0E3F55@EXNA.corp.stratus.com>
In-Reply-To: 20080812084946.GC19857@soda.linbit
References: <DA0E7D869C862D4095C265233CD1D41EC30F85@EXNA.corp.stratus.com>
	20080812084946.GC19857@soda.linbit
From: "Petrakis, Peter" <Peter.Petrakis@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi All,

We've evolved the original patch to the following, which seems to solve
our problem. Can you see anything wrong with it? Thanks.

diff -r f9aa469f7044 drbd_main.c
--- a/drbd_main.c       Fri Sep 12 13:51:40 2008 -0400
+++ b/drbd_main.c       Mon Sep 15 10:04:48 2008 -0400
@@ -765,7 +765,7 @@
                ns.conn =3D Connected;
        }

-       if (ns.conn !=3D os.conn && ns.conn >=3D Connected &&
+       if (ns.conn >=3D Connected &&
            (ns.disk =3D=3D Consistent || ns.disk =3D=3D Outdated)) {
                switch(ns.conn) {
                case WFBitMapT:
@@ -787,7 +787,7 @@
                        WARN("Implicit set disk from Outdate to
UpToDate\n");
        }

-       if (ns.conn !=3D os.conn && ns.conn >=3D Connected &&
+       if (ns.conn >=3D Connected &&
            (ns.pdsk =3D=3D Consistent || ns.pdsk =3D=3D Outdated)) {
                switch(ns.conn) {
                case Connected:


Peter

> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On
> Behalf Of Lars Ellenberg
> Sent: Tuesday, August 12, 2008 4:50 AM
> To: drbd-dev@linbit.com
> Subject: Re: [Drbd-dev] 8.2.6 Peer disk state handling issue when
> attaching
>=20
> On Mon, Aug 11, 2008 at 11:52:30PM -0400, Graham, Simon wrote:
> > I have noticed that with 8.2.6, if the role of a device is
> > Secondary/Secondary and you detach and then re-attach a device, the
peer
> > disk state on the other node ends up as Consistent instead of
UpToDate -
> > it seems that in this case the code does not check if a resync is
> > required and goes directly from DiskLess->Consistent on the side
that is
> > not doing the detach/attach.
> >
> > Here is a sample extract from the messages file on the two systems:
> >
> > First, on the system where you do the detach followed by attach
> > (connection state is Connected when this starts, roles are
> > Secondary/Secondary, disk UpToDate/UpToDate:
> >
> > Aug  9 04:53:11 node0 kernel: drbd16: disk( UpToDate -> Diskless )
> >
> > Aug  9 04:53:32 node0 kernel: drbd16: disk( Diskless -> Attaching )
> > Aug  9 04:53:32 node0 kernel: drbd16: No usable activity log found.
> > Aug  9 04:53:32 node0 kernel: drbd16: max_segment_size ( =3D BIO =
size
) =3D
> > 32768
> > Aug  9 04:53:32 node0 kernel: drbd16: reading of bitmap took 1
jiffies
> > Aug  9 04:53:32 node0 kernel: drbd16: recounting of set bits took
> > additional 0 jiffies
> > Aug  9 04:53:32 node0 kernel: drbd16: 0 KB (0 bits) marked
out-of-sync
> > by on disk bit-map.
> > Aug  9 04:53:32 node0 kernel: drbd16: disk( Attaching -> Negotiating
)
> > Aug  9 04:53:32 node0 kernel: drbd16: Writing meta data super block
now.
> > Aug  9 04:53:32 node0 kernel: drbd16: disk( Negotiating -> UpToDate
)
> >
> > On the other node (same starting state):
> >
> > Aug  9 04:53:11 node1 kernel: drbd16: pdsk( UpToDate -> Diskless )
> >
> > Aug  9 04:53:32 node1 kernel: drbd16: real peer disk state =3D
Consistent
> > Aug  9 04:53:32 node1 kernel: drbd16: pdsk( Diskless -> Consistent )
> >
> > I can see why the second node does not go to the UpToDate state -
there
> > is a check in _drbd_set_state such that it only overwrites
Consistent
> > with UpToDate if the connection state is also changing which it does
not
> > in this case. HOWEVER, I'm not sure this is the right place to fix
it -
> > it seems to me that we should check for a resync even in this case
since
> > one or both of the disks could have been Primary and modified the
disk
> > at some point and then been downgraded to Secondary - so we really
need
> > to call drbd_sync_handshake even in this case, but we don't seem
to...
> >
> > I don't see any fixes post 8.2.6 that obviously address this but
perhaps
> > I missed something?
>=20
> confirmed in current 8.2 git.
>=20
> > If not, any thoughts on the right way to fix this?
>=20
> I leave that question open for now.
>=20
> --
> : Lars Ellenberg                            Tel +43-1-8178292-55 :
> : LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
> : Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
