Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C20431028A42
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B63592A7231
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ipsuj3dYKhyD for <drbd-dev@lists.linbit.com>;
	Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9B10A2AA653
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4VbJAw171t8U for <drbd-dev@lists.linbit.com>;
	Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Received: from soda.linbit (unknown [217.196.73.213])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 662C62A7231
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2014 17:34:35 +0200 (CEST)
Date: Mon, 6 Oct 2014 17:34:35 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20141006153435.GE8574@soda.linbit>
References: <542EFA18.9060705@novg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <542EFA18.9060705@novg.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Bug in latest 8.4-git
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

On Fri, Oct 03, 2014 at 11:33:44PM +0400, Igor Novgorodov wrote:
> Hello!
>=20
> Just checked out latest rev of git tree and built it against latest
> LTS vanilla kernel - 3.14.19
>=20
> And the problem is that it won't connect to the peer server (it's
> drbd 8.4.3 and kernel 3.4.42) at all
> with "listen failed, err =3D -515" error. Replication link is 4x1G
> balance-rr bond which worked fine
> for years, if that's relevant. IPv6 is disabled in kernel completely.

Then why are you trying git checkouts on it...

> I've fallen back to 8.4.5 stable release and it all worked fine again.

Great.  As long as the released code works ;-)

> The thing is that last time i've checked out git version around July
> 2014 - it worked fine too,
> something broke later.

Thanks for reporting anyways.  That way we may be able to figure out
what's wrong before the next release.

errno -515  is "ENOIOCTLCMD" according to my kernel sources.
Not sure why listen would report that?

> Kernel log of the connection follows, glad to get any help or answer
> any questions:
>=20
> [  987.195779] drbd: failed to initialize debugfs -- will not be availa=
ble
> [  987.195875] drbd: initialized. Version: 8.4.5 (api:1/proto:86-101)
> [  987.195946] drbd: GIT-hash:
> ca3a67af3823b85614621a4cf95e191c5820c0eb build by
> root@debian-service, 2014-10-03 21:23:28
> [  987.196039] drbd: registered as block device major 147
> [  987.243928] drbd VM_STORAGE2_1: Starting worker thread (from
> drbdsetup-84 [7574])
> [  987.244564] block drbd0: disk( Diskless -> Attaching )
> [  987.245006] drbd VM_STORAGE2_1: Method to ensure write ordering: dra=
in
> [  987.245080] block drbd0: max BIO size =3D 286720
> [  987.245151] block drbd0: Adjusting my ra_pages to backing
> device's (32 -> 70)
> [  987.245227] block drbd0: drbd_bm_resize called with capacity =3D=3D
> 23436772800
> [  987.309127] block drbd0: resync bitmap: bits=3D2929596600
> words=3D45774947 pages=3D89405
> [  987.309223] block drbd0: size =3D 11 TB (11718386400 KB)
> [  988.983804] block drbd0: recounting of set bits took additional 8 ji=
ffies
> [  988.983884] block drbd0: 0 KB (0 bits) marked out-of-sync by on
> disk bit-map.
> [  988.983964] block drbd0: disk( Attaching -> UpToDate )
> [  988.984048] block drbd0: attached to UUIDs
> 6BCB7D550A1E86DE:0000000000000000:22A0154CECB25AF2:229F154CECB25AF3
> [  989.016875] drbd VM_STORAGE2_2: Starting worker thread (from
> drbdsetup-84 [7580])
> [  989.017381] block drbd1: disk( Diskless -> Attaching )
> [  989.017842] drbd VM_STORAGE2_2: Method to ensure write ordering: dra=
in
> [  989.017919] block drbd1: max BIO size =3D 286720
> [  989.017990] block drbd1: Adjusting my ra_pages to backing
> device's (32 -> 70)
> [  989.018066] block drbd1: drbd_bm_resize called with capacity =3D=3D
> 17577578552
> [  989.065815] block drbd1: resync bitmap: bits=3D2197197319
> words=3D34331209 pages=3D67054
> [  989.065908] block drbd1: size =3D 8382 GB (8788789276 KB)
> [  990.280610] block drbd1: recounting of set bits took additional 5 ji=
ffies
> [  990.280690] block drbd1: 0 KB (0 bits) marked out-of-sync by on
> disk bit-map.
> [  990.280771] block drbd1: disk( Attaching -> UpToDate )
> [  990.280855] block drbd1: attached to UUIDs
> 7869022EE30A1DDC:0000000000000000:BEFCB1DA3C794170:BEFBB1DA3C794171
> [  990.282283] drbd VM_STORAGE2_1: conn( StandAlone -> Unconnected )
> [  990.282382] drbd VM_STORAGE2_1: Starting receiver thread (from
> drbd_w_VM_STORA [7575])
> [  990.282590] drbd VM_STORAGE2_1: receiver (re)started
> [  990.282698] drbd VM_STORAGE2_1: conn( Unconnected -> WFConnection )
> [  990.282788] drbd VM_STORAGE2_1: listen failed, err =3D -515
> [  990.282888] drbd VM_STORAGE2_1: conn( WFConnection -> Disconnecting =
)
> [  990.283287] drbd VM_STORAGE2_1: Connection closed
> [  990.283307] drbd VM_STORAGE2_2: conn( StandAlone -> Unconnected )
> [  990.283349] drbd VM_STORAGE2_2: Starting receiver thread (from
> drbd_w_VM_STORA [7581])
> [  990.283461] drbd VM_STORAGE2_2: receiver (re)started
> [  990.283500] drbd VM_STORAGE2_2: conn( Unconnected -> WFConnection )
> [  990.283515] drbd VM_STORAGE2_2: listen failed, err =3D -515
> [  990.283542] drbd VM_STORAGE2_2: conn( WFConnection -> Disconnecting =
)
> [  990.283580] drbd VM_STORAGE2_2: Connection closed
> [  990.283611] drbd VM_STORAGE2_2: conn( Disconnecting -> StandAlone )
> [  990.283975] drbd VM_STORAGE2_1: conn( Disconnecting -> StandAlone )
> [  991.282537] drbd VM_STORAGE2_1: State change failed: Need a
> connection to start verify or resync
> [  991.282540] drbd VM_STORAGE2_2: State change failed: Need a
> connection to start verify or resync
> [  991.282541] drbd VM_STORAGE2_2:  mask =3D 0x1f0 val =3D 0x80
> [  991.282544] drbd VM_STORAGE2_2:  old_conn:StandAlone
> wanted_conn:WFConnection
> [  991.282545] drbd VM_STORAGE2_2: receiver terminated
> [  991.282546] drbd VM_STORAGE2_2: Terminating drbd_r_VM_STORA
> [  991.283005] drbd VM_STORAGE2_1:  mask =3D 0x1f0 val =3D 0x80
> [  991.283076] drbd VM_STORAGE2_1:  old_conn:StandAlone
> wanted_conn:WFConnection
> [  991.283149] drbd VM_STORAGE2_1: receiver terminated
> [  991.283220] drbd VM_STORAGE2_1: Terminating drbd_r_VM_STORA

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
