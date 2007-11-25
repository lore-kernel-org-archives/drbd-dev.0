Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Possible synchronization problems in 8.0.6
Date: Sun, 25 Nov 2007 18:17:27 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671072830AC@EXNA.corp.stratus.com>
In-Reply-To: 20071125213646.GA12868@racke.local
References: <342BAC0A5467384983B586A6B0B37671072830AA@EXNA.corp.stratus.com>
	20071125213646.GA12868@racke.local
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> this is not true.
>=20
> STATIC void drbd_global_lock(void)
> {
> 	drbd_dev *mdev;
> 	int i;
>=20
> 	local_irq_disable();
> 	for (i=3D0; i < minor_count; i++) {
> 		if(!(mdev =3D minor_to_mdev(i))) continue;
> 		spin_lock(&mdev->req_lock);
> 	}
> }
>=20
> this disables irq,
> then aquires _all_ reqest locks of all (allocated) devices _in order_.
>=20

Hah! It would help if I read the code properly wouldn't it... OK, so
this isn't the cause of my problems...

Well, that's possibly better then -- maybe my problems are purely caused
by not kicking the resync timer and by the re-ordering of netlink
broadcasts because the after_state_change is not always handled in a
worker..

I will look at changing all after-state-changes to be scheduled and
backing out Phil's fix for kicking the resync timer.

Thanks,
/simgr
