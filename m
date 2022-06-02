Return-Path: <veggiemike@sourceruckus.org>
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
	[209.85.216.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 84BFB420177
	for <drbd-dev@lists.linbit.com>; Thu,  2 Jun 2022 15:44:07 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id n10so4951386pjh.5
	for <drbd-dev@lists.linbit.com>; Thu, 02 Jun 2022 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1fRFhZrTfHegCWwNoSsUkmvBBfFmd9viQVsmCpSMFQNH5vTg@mail.gmail.com>
	<79d35a2a-2603-41fd-18b8-19f4544ca09a@linbit.com>
In-Reply-To: <79d35a2a-2603-41fd-18b8-19f4544ca09a@linbit.com>
From: Michael Labriola <veggiemike@sourceruckus.org>
Date: Thu, 2 Jun 2022 09:43:55 -0400
Message-ID: <CAA1fRFhU8NYwYWudMLM+S6FwaOY-SCkSv1jFkTdOKEAKq0=A0Q@mail.gmail.com>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Linux 5.18 status
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jun 2, 2022 at 7:21 AM Christoph B=C3=B6hmwalder
<christoph.boehmwalder@linbit.com> wrote:
>
> Am 01.06.22 um 16:03 schrieb Michael Labriola:
> > Ahoy!  Looks like the drbd-9.1 branch doesn't compile against 5.18
> > yet.  Is somebody working through the 5.18 block layer changes
> > already?  If anyone's got a branch to test, I'd gladly try it out.
> >
> > --
> > Michael D Labriola
> > 401-316-9844 (cell)
>
> Hi,
>
> I'm working on 5.18 compat as we speak. Since no distribution we build
> for is using 5.18, this has a somewhat lower priority, but it is being do=
ne.

That's good to hear.  I took a look at the changes the other day, and
they looked a little too deep for me to safely fix on my own.

> I would estimate we have around 5 or 6 remaining non-trivial patches
> that require real attention before we can build for 5.18.
>
> If everything goes to plan, the fixes might make it into the next DRBD
> release in mid-June, but I really can't make any promises.

I'd love to help test things out as things start to come together.
Let me know where to pull from, and I'll compile and give it some
gentle testing on a 3-node setup.

I historically make drbd9 work "for-me" on new kernels as they come
out with the intent of prettying up my patches and submitting them
here (e.g., compat patch build system stuff for older kernels), but
rarely manage to follow through before you guys fix it upstream.

--
Michael D Labriola
401-316-9844 (cell)
