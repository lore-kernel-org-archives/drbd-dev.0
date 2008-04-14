Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [PATCH] - DRBD 8.0: Add standard disk counters toDRBD
	devices
Date: Mon, 14 Apr 2008 18:10:34 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767108F0325F@EXNA.corp.stratus.com>
In-Reply-To: 20080414214418.GB11768@racke.local
References: <342BAC0A5467384983B586A6B0B3767108F031F6@EXNA.corp.stratus.com>
	20080414214418.GB11768@racke.local
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

> > +/* Update disk stats at start of I/O request */
> > +static inline void _drbd_start_io_acct(drbd_dev *mdev,
> drbd_request_t *req, struct bio *bio)
> > +{
> > +	int rw =3D bio_data_dir(bio);
> > +
> > +	MUST_HOLD(&mdev->req_lock)
> > +
> > +	disk_stat_inc(mdev->vdisk, ios[rw]);
> > +	disk_stat_add(mdev->vdisk, sectors[rw], bio_sectors(bio));
> > +	preempt_disable();
>=20
> we are inside a spin_lock, no need to manipulate preempt,
> there is no preemptible spin_lock yet.
>=20

I'll take your word for it BUT this is what ll_rw_blk.c/md do... well,
at least I think they do... I did merge some code in my version so maybe
they don't hold the lock when they call disk_round_stats()...

Simon

