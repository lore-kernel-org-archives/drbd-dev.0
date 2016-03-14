Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9F66E1056330
	for <drbd-dev@lists.linbit.com>; Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8DDC64003AD
	for <drbd-dev@lists.linbit.com>; Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uoA0s5fZjtcL for <drbd-dev@lists.linbit.com>;
	Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 70B8140051D
	for <drbd-dev@lists.linbit.com>; Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SGdO2FxvO5nX for <drbd-dev@lists.linbit.com>;
	Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 46F0E4003AD
	for <drbd-dev@lists.linbit.com>; Mon, 14 Mar 2016 11:23:17 +0100 (CET)
Date: Mon, 14 Mar 2016 11:23:16 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160314102316.GI17669@soda.linbit>
References: <mailman.3.1457694002.12272.drbd-dev@lists.linbit.com>
	<CALLFrTQcN6N34wW2VCTmnPpExoe+3Jgh4wckTqZ_SVzb4UOobA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTQcN6N34wW2VCTmnPpExoe+3Jgh4wckTqZ_SVzb4UOobA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] request_timer continuous loop if there is
	disk-timeout
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

On Mon, Mar 14, 2016 at 02:37:21PM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> I have known more request_timer_fn(). Thanks
>=20
> I think helper function *time_min_in_future() *function will return the
> nearest future time, right?
> And, next_trigger_time is initialize now value, so always is same.
> void request_timer_fn(unsigned long data)
> {
>     if (dt) {
> ...
>         if (device->disk_state[NOW] > D_FAILED) {
>             next_trigger_time =3D *time_min_in_future*(now,
>                     next_trigger_time, oldest_submit_jif + dt);        =
 //
> 1st assign
>             restart_timer =3D true;
>         }
> ...
>     }
>     for_each_connection(connection, device->resource) {
> ...
>         next_trigger_time =3D *time_min_in_future*(now,
>                 next_trigger_time, pre_send_jif + ent);                =
 //
> 2nd assign
> ...
>     }
> ...
>     if (restart_timer) {
>         next_trigger_time =3D *time_min_in_future*(now, next_trigger_ti=
me,
> now + et);       // 3rd assign
> ...
>     }
> }
> Maybe, 3 assignments are always same, because now =3D=3D next_trigger_t=
ime,
> which is the nearest.  So, if restart_timer 's value is true, then
> loop continuously even dt or ent exists.

No.

> I don't know how to put the different thing.

Me neither.



Also, you have seen this?

> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of drbd-dev digest..."


