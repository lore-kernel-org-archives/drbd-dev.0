Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: rr-conflict violently breaks sync states.
Date: Mon, 4 Dec 2006 08:52:36 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C855@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks for looking at this.  I am still investigating as well.  But here
is what's in the kernel log on both nodes.

Kernel message buffer log for a device that won't sync:
Node1:
drbd2: disk( Diskless -> Attaching )
drbd2: No usable activity log found.
drbd2: max_segment_size ( =3D BIO size ) =3D 32768
drbd2: drbd_bm_resize called with capacity =3D=3D 30735368
drbd2: resync bitmap: bits=3D3841921 words=3D120062
drbd2: size =3D 14 GB (15367684 KB)
drbd2: writing of bitmap took 19 jiffies
drbd2: 14 GB marked out-of-sync by on disk bit-map.
drbd2: 15367684 KB now marked out-of-sync by on disk bit-map.
drbd2: reading of bitmap took 16 jiffies
drbd2: recounting of set bits took additional 1 jiffies
drbd2: 14 GB marked out-of-sync by on disk bit-map.
drbd2: disk( Attaching -> Inconsistent )
drbd2: Writing meta data super block now.
drbd2: conn( StandAlone -> Unconnected )
drbd2: receiver (re)started
drbd2: conn( Unconnected -> WFConnection )
drbd2: conn( WFConnection -> WFReportParams )
drbd2: Handshake successful: DRBD Network Protocol version 85
drbd2: No resync, but bits in bitmap!
drbd2: peer( Unknown -> Secondary ) conn( WFReportParams -> Connected )
pdsk( DUnknown -> Inconsistent )
drbd2: Writing meta data super block now.
drbd2: aftr_isp( 0 -> 1 )
drbd2: No resync, but bits in bitmap!
drbd2: peer_isp( 0 -> 1 )
drbd2: aftr_isp( 1 -> 0 )
drbd2: No resync, but bits in bitmap!
drbd2: peer_isp( 1 -> 0 )


On node2:
drbd2: disk( Diskless -> Attaching )
drbd2: No usable activity log found.
drbd2: max_segment_size ( =3D BIO size ) =3D 32768
drbd2: drbd_bm_resize called with capacity =3D=3D 30735368
drbd2: resync bitmap: bits=3D3841921 words=3D120062
drbd2: size =3D 14 GB (15367684 KB)
drbd2: writing of bitmap took 19 jiffies
drbd2: 14 GB marked out-of-sync by on disk bit-map.
drbd2: 15367684 KB now marked out-of-sync by on disk bit-map.
drbd2: reading of bitmap took 12 jiffies
drbd2: recounting of set bits took additional 1 jiffies
drbd2: 14 GB marked out-of-sync by on disk bit-map.
drbd2: disk( Attaching -> Inconsistent )
drbd2: Writing meta data super block now.
drbd2: conn( StandAlone -> Unconnected )
drbd2: receiver (re)started
drbd2: conn( Unconnected -> WFConnection )
drbd2: conn( WFConnection -> WFReportParams )
drbd2: Handshake successful: DRBD Network Protocol version 85
drbd2: No resync, but bits in bitmap!
drbd2: peer( Unknown -> Secondary ) conn( WFReportParams -> Connected )
pdsk( DUnknown -> Inconsistent )
drbd2: Writing meta data super block now.
drbd2: aftr_isp( 0 -> 1 )
drbd2: No resync, but bits in bitmap!
drbd2: peer_isp( 0 -> 1 )
drbd2: No resync, but bits in bitmap!
drbd2: peer_isp( 1 -> 0 )
drbd2: aftr_isp( 1 -> 0 )

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Monday, December 04, 2006 5:29 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: rr-conflict violently breaks sync states.

Am Freitag, 1. Dezember 2006 23:10 schrieb Montrose, Ernest:
> If "rr-conflict vilently;" is present in /etc/drbd.conf then the drbd
> volumes will not sync completely. Some of them ends up in :
> cs: Connected:St: secondary/Secondary:ds: Inconsistent/Inconsistent
>
> These states are on both nodes.
>
> It seems like this rr-conflict violently is not fully implemented.


Hi Ernest,

Actually it is. Could you grep in the kernel-logfile for all messages of
the devices that ended up in that state. Preferrable from both nodes.

Thanks!

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
