Return-Path: <Peter.Petrakis@stratus.com>
Received: from mailhub5.stratus.com (mailhub.stratus.com [134.111.1.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B154B108636C
	for <drbd-dev@lists.linbit.com>; Thu,  3 Dec 2009 17:23:43 +0100 (CET)
Received: from EXHQ.corp.stratus.com (exhq.corp.stratus.com [134.111.201.100])
	by mailhub5.stratus.com (8.12.11/8.12.11) with ESMTP id
	nB3GNKdx004807
	for <drbd-dev@lists.linbit.com>; Thu, 3 Dec 2009 11:23:20 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Dec 2009 11:23:41 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C90ADFB5@EXHQ.corp.stratus.com>
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

Implementing a usermode helper seems to have solved all my problems.
I'm a little dissapointed though, it would've been cool to have the=20
green light to do the sysfs work :). It doesn't seem like any of the
kernel drivers that require usermode configuration have fully solved
this issue, even mdadm. There are arguments to use sysfs for reading and
tweaking and then configfs for the first time create stuff.

http://lkml.indiana.edu/hypermail/linux/kernel/0602.0/0462.html

Though the only real user of configfs to date is ocfs2!

Peter

> -----Original Message-----
> From: drbd-dev-bounces@lists.linbit.com=20
> [mailto:drbd-dev-bounces@lists.linbit.com] On Behalf Of Lars Ellenberg
> Sent: Monday, November 30, 2009 2:11 PM
> To: drbd-dev@lists.linbit.com
> Subject: Re: [Drbd-dev] changing the fencing policy on the fly
>=20
> On Mon, Nov 30, 2009 at 01:51:02PM -0500, Petrakis, Peter wrote:
> > Hi All,
> > =20
> > I have a challenge with the use of fencing and the state of flux in=20
> > our cluster. The system will setup drbd devices in advance and use=20
> > them independent of it's peer, which will mirror it's=20
> config once it=20
> > joins the cluster. Since the fencing helper makes use of=20
> drbdadm and=20
> > thus the config file we have a problem. If fencing were to be=20
> > triggered, it would immediately fail with a bad exit status because=20
> > the config file is inconsistent. We use a naming convention for the=20
> > disks in our cluster so the only piece of information I=20
> don't know at=20
> > this time is my peers ip address.
> >=20
> > To work around this bug I set the fencing policy to 'dont-care' and=20
> > then once the resource is connected and uptodate, detach=20
> the backing=20
> > store and then reattach it with the desired fencing policy. This=20
> > leaves us vulnerable however, should the link go down for=20
> any reason=20
> > we're in big trouble.
> >=20
> > I'm trying to eliminate this hole without detaching the=20
> backing store.=20
> > I can't play tricks with aliasing the eth interface to some address=20
> > because I'm not physically in control of the box and don't want to=20
> > ruin someone's network in case they hook up the wires incorrectly.=20
> > DRBD doesn't seem to support
> > IPV6 link local addressing which would help in this case=20
> because the=20
> > nodes are directly attached.
>=20
> IPv6 is supposed to work.
>=20
> > What I'd like to do is to change the fencing policy on=20
> demand and the=20
> > mechanism I wish to use is sysfs.
> > Do you guys see any pitfalls with this approach, locking=20
> especially?=20
> > The reason I want to use sysfs is two fold. I want to get away from=20
> > using drbdadm for the userspace helper and it'll make=20
> writing software=20
> > to manage drbd more straight forward. Thanks in advance.
>=20
> modinfo drbd
> usermode_helper:string
> 	(default: /sbin/drbdadm)
> 	also available via /sys/modules/drbd/parameters/usermode_helper
>=20
> You can add your own wrapper around drbdadm as "hanlder" helper.
>=20
> But feel free to write a patch to replace the DRBD config=20
> interface (currently netlink/connector resp. genetlink based)=20
> to a sysfs based one, and we might consider it ;)
>=20
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
>=20
> Thanks,
>=20
> 	Lars
>=20
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>=20
