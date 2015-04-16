Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 16 Apr 2015 15:46:44 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Message-ID: <20150416134644.GB18767@soda.linbit>
References: <CAEBniQ5wGKGuTpQ3OR3eobqYJStc+3zfrqKup3X2rARHwTGGcw@mail.gmail.com>
	<CAEBniQ506H3-wwBfYMSNv3hDyd3Pg1OwR3QXqQ4GE6rfL49NHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAEBniQ506H3-wwBfYMSNv3hDyd3Pg1OwR3QXqQ4GE6rfL49NHA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [DRBD-user] A question about drbd hang in
	conn_disconnect
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

On Mon, Apr 13, 2015 at 05:45:25PM -0600, Fang Sun wrote:
> Hi drbd developers,
>=20
> After some research and tests I feel I found the reason of this problem=
 and
> a possible fix in drbd.
> Would you please check if my theory is correct?
>=20
>=20
> Let me use 8.4.6 as the code base when I explain it.
> When conn_disconnect hang it is hanging at line drbd_receiver.c:5178
> static int drbd_disconnected(struct drbd_peer_device *peer_device)
> {
> ........
> wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
> }
>=20
> The reason is device has flag BITMAP_IO set.
>=20
>=20
> The reason why flag BITMAP_IO is set and not clear is:
> Disk state changes when network is disconnected and after_state_ch is
> called.
>=20
> At drbd_state.c line 1949 drbd_queue_bitmap_io is called inafter_state_=
ch()
> .
>=20
> I think the real reason is in drbd_queue_bitmap_io. drbd_main.c line 36=
41.
> void drbd_queue_bitmap_io(struct drbd_device *device,
>   int (*io_fn)(struct drbd_device *),
>   void (*done)(struct drbd_device *, int),
>   char *why, enum bm_flag flags)
> {
> .........
> set_bit(BITMAP_IO, &device->flags);
> if (atomic_read(&device->ap_bio_cnt) =3D=3D 0) {
> if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
> drbd_queue_work(&first_peer_device(device)->connection->sender_work,
> &device->bm_io_work.w);
> }
> ........
> }
>=20
> In the code the only code to clear BITMAP_IO is in
> device->bm_io_work.w(w_bitmap_io). But when
> atomic_read(&device->ap_bio_cnt) !=3D 0 the flag BITMAP_IO  is set, how=
ever
> bm_io_work.w is not called.
> Then drbd_disconnected() is blocked.
>=20
> Should we move set_bit(BITMAP_IO, &device->flags) to the front of
> drbd_queue_work()?

No.  That would be the wrong fix,
and cause potential inconsistencies later.

It may need to be fixed, but in a different way.

Let me (reproduce locally ... and) think about that for a bit.

Thanks,

--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
