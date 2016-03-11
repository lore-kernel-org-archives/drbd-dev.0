Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DCD9B1056312
	for <drbd-dev@lists.linbit.com>; Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CD96F3FB83D
	for <drbd-dev@lists.linbit.com>; Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A8PXp5U1NkPE for <drbd-dev@lists.linbit.com>;
	Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8AE893FB848
	for <drbd-dev@lists.linbit.com>; Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sH6v_DEtcQ67 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5B5323FB83D
	for <drbd-dev@lists.linbit.com>; Fri, 11 Mar 2016 11:02:36 +0100 (CET)
Date: Fri, 11 Mar 2016 11:02:35 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160311100235.GD17669@soda.linbit>
References: <CALLFrTRUdak0CT0mJ-y=f9YtZSnTrROFYwB4Y4ZK3ikUA9Ncsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTRUdak0CT0mJ-y=f9YtZSnTrROFYwB4Y4ZK3ikUA9Ncsw@mail.gmail.com>
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

On Fri, Mar 11, 2016 at 04:30:27PM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> Hello.
> I'm a software engineer in Mantech.
>=20
> In testing about disk-timeout property,
> if not default value, which will lead into a continuous loop.
>=20
> in request_timer_fn()
> ...
> if (device->disk_state[NOW] > D_FAILED) {
> et =3D min_not_zero(et, dt);
> next_trigger_time =3D time_min_in_future(now,
> next_trigger_time, oldest_submit_jif + dt);
> restart_timer =3D true;
> }
> ...
> I think, if there is no request, next_trigger_time should be calculated
> below
> next_trigger_time =3D time_min_in_future(now,
> next_trigger_time + *dt*, oldest_submit_jif + dt);
>=20
> However, I can't be sure.

"dt" : disk timeout
"et" : effective timeout
"ent" : effective network timeout
"now" : well, now.
"next_trigger_time" : when to trigger the next timer

next_trigger_time is initialized to "now".

it gets adjusted using "time_min_in_future()",
which is this helper:
static unsigned long time_min_in_future(unsigned long now,
                unsigned long t1, unsigned long t2)
{
        t1 =3D time_after(now, t1) ? now : t1;
        t2 =3D time_after(now, t2) ? now : t2;
        return time_after(t1, t2) ? t2 : t1;
}

time_after is ((long)((b) - (a)) < 0)), NOT <=3D.

next_trigger_time will become larger than now,
or stay at its initial value, which is now.

function ends with

	if (restart_timer) {
                next_trigger_time =3D time_min_in_future(now, next_trigge=
r_time, now + et);
                mod_timer(&device->request_timer, next_trigger_time);
        }

so in case next_trigger_time will still be equal to now at the end of the
function, it will be set to "now + et" before it is passed to mod_timer.

et can only be zero if both network and disk timeout where zero,
in which case the whole thing would not even be used,
because that would mean timeouts are disabled.=20


Besides that,
I would be surprised if disk timeout in 9 worked properly yet.

Also, disk timeout is evil in any case, and NOT TO BE USED
(not even in 8.4, where it *does* work properly ("as designed"), afaik)

Why? Because if it triggers, and the IO subsystem ("disk") decides to
still process the submitted request some time later,
you'd get stuff RDMA'd to some random memory page which may well be meanw=
hile
re-used for unrelated things. In which case we intentionally panic().

But you knew that already.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT
