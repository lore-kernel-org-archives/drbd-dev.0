Return-Path: <Peter.Petrakis@stratus.com>
Received: from mailhub4.stratus.com (mailhub.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B0F4E1086353
	for <drbd-dev@lists.linbit.com>; Tue,  1 Dec 2009 21:50:49 +0100 (CET)
Received: from EXHQ.corp.stratus.com (exhq.corp.stratus.com [134.111.201.100])
	by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id
	nB1KohZ3001563
	for <drbd-dev@lists.linbit.com>; Tue, 1 Dec 2009 15:50:48 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 1 Dec 2009 15:50:42 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C90ADFAC@EXHQ.corp.stratus.com>
In-Reply-To: 20091130191058.GC12030@racke
From: "Petrakis, Peter" <Peter.Petrakis@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] changing the fencing policy on the fly
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

=20

> -----Original Message-----
> > IPV6 link local addressing which would help in this case=20
> because the=20
> > nodes are directly attached.
>=20
> IPv6 is supposed to work.

and it does, it's this particular construct doesn't seem supported,
fe80::a00:5aff:fe38:6f86%eth0 .

It's not an issue anyways, I was misunderstood how it worked, I
assumed I needed only my MAC address and not my peers.=20

> modinfo drbd
> usermode_helper:string
> 	(default: /sbin/drbdadm)
> 	also available via /sys/modules/drbd/parameters/usermode_helper
>=20
> You can add your own wrapper around drbdadm as "hanlder" helper.

That's definitely a possibility.=20
=20
> But feel free to write a patch to replace the DRBD config=20
> interface (currently netlink/connector resp. genetlink based)=20
> to a sysfs based one, and we might consider it ;)

ok :)
=20
> Use a "DRBD" bus, each sub dir being a single drbd, expose=20
> all parameters we currently have, see that you don't step on=20
> each others toes when configuring those.
> you probably need a "live" and a "pending" config set, so you=20
> can change paramters when configuring in sequence, then=20
> "commit" them in one go.
>=20
> Post on drbd-dev and possibly on lkml.
>=20
> Converting single parameters to sysfs in some ad-hoc fashion,=20
> just because you feel _this_ one should be there, is not=20
> useful und unmaintainable.

Agreed. I scanned the code again regarding the use of the fencing
policy and noticed something that might solve this particular problem.

enum drbd_disk_state drbd_try_outdate_peer(struct drbd_conf *mdev)
{
    char *ex_to_string;
    int r;
    enum drbd_disk_state nps;
    enum fencing_policy fp;

    D_ASSERT(mdev->state.pdsk =3D=3D DUnknown);

    if (inc_local_if_state(mdev, Consistent)) {
        fp =3D mdev->bc->dc.fencing;
        dec_local(mdev);
    } else {
        WARN("Not outdating peer, I'm not even Consistent myself.\n");
        return mdev->state.pdsk;
    }

    if (fp =3D=3D Stonith)
        _drbd_request_state(mdev, NS(susp,1), ChgWaitComplete);

    r =3D drbd_khelper(mdev, "outdate-peer");

    switch ((r>>8) & 0xff) {
    case 3: /* peer is inconsistent */
        ex_to_string =3D "peer is inconsistent or worse";
        nps =3D Inconsistent;
        break;
    case 4:
        ex_to_string =3D "peer is outdated";
        nps =3D Outdated;
        break;
    case 5: /* peer was down, we will(have) create(d) a new UUID
anyways... */
        /* If we would be more strict, we would return DUnknown here. */
        ex_to_string =3D "peer is unreachable, assumed to be dead";
        nps =3D Outdated;
        break;
...

Nowhere does the code check that a valid network config ever existed. It
presuppposes that a peer must exist if a fencing policy is configured.
Could
I safely argue that if mdev->net_conf =3D=3D NULL then we could return =
5?
Thanks.

Peter
