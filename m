Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E1C651056331
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CEFAA3FB4C6
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id geJOXhQc5PQi for <drbd-dev@lists.linbit.com>;
	Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B2F9D3FB4CB
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lfoM1d5OOfji for <drbd-dev@lists.linbit.com>;
	Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6AC3F3FB4C6
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 15:04:03 +0100 (CET)
Date: Thu, 10 Mar 2016 15:04:03 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160310140403.GY17669@soda.linbit>
References: <CAF6H8oHKSrNsOA2UnaT_jOfQgvrBNEQh3B-BUNH=823=a5WhGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAF6H8oHKSrNsOA2UnaT_jOfQgvrBNEQh3B-BUNH=823=a5WhGA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [CASE-30] dec_ap_bio wakeup condition difference
 between V8.4.7 and V9.0.1
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

On Thu, Mar 10, 2016 at 09:39:46PM +0900, Jaeheon Kim wrote:
> 2. Sources
>=20
> 1) Ver 9.0.1
>=20
>     static inline void inc_ap_bio(struct drbd_device *device, int rw)
>     {
>         wait_event(device->misc_wait, inc_ap_bio_cond(device, rw));
>     }
>=20
>     static inline void dec_ap_bio(struct drbd_device *device, int rw)
>     {
>          int ap_bio =3D atomic_dec_return(&device->ap_bio_cnt[rw]);
>        .........
>=20
>          if (ap_bio =3D=3D 0)
>                 wake_up(&device->misc_wait);
>     }
>=20
>=20
> 2) Ver 8.4.7
>=20
>     static inline void inc_ap_bio(struct drbd_device *device)
>     {
>          wait_event(device->misc_wait, inc_ap_bio_cond(device));
>     }
>=20
>     static inline void dec_ap_bio(struct drbd_device *device)
>     {
>          int mxb =3D drbd_get_max_buffers(device);
>          int ap_bio =3D atomic_dec_return(&device->ap_bio_cnt);
>=20
>         .............
>=20
>=20
>          /* this currently does wake_up for every dec_ap_bio!
>           * maybe rather introduce some type of hysteresis?
>           * e.g. (ap_bio =3D=3D mxb/2 || ap_bio =3D=3D 0) ? */
>=20
>           if (ap_bio < mxb)
>                  wake_up(&device->misc_wait);
>     }
>=20
>=20
>=20
> 3. Questions
>=20
> 1) See "1. Stacks".
>     I think, The Linux "drbd_make_request+0x14a/0x360 [drbd]" will prob=
ably
>     mean the same thing as the Windows "drbd!inc_ap_bio+0x49".
>     What do you think about it?
>=20
> 2) In version 8.4.7, dec_ap_bio wakes up misc_wait when condition is
> "ap_bio < max".
>     I mean, this version has greater tolerance than version 9.0.1.
>     My question is Why do you change this condition from "ap_bio < max"=
 to
> "ap_bio =3D=3D 0"  in version 9.0.1?


Because there is no more "max" in 9, no-one can possibly wait for
count < max. There are however things that still wait for count =3D=3D 0.

Though we probably will re-introduce some (resource wide) limit
on the maximum amount of "in-flight bios" we accept to be queued.

"misc" wait queue is used for a lot of things,
and a lot of things wake it.


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
