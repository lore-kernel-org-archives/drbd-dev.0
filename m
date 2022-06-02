Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
	[209.85.218.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 08F96420177
	for <drbd-dev@lists.linbit.com>; Thu,  2 Jun 2022 13:21:01 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id jx22so9274921ejb.12
	for <drbd-dev@lists.linbit.com>; Thu, 02 Jun 2022 04:21:01 -0700 (PDT)
Message-ID: <79d35a2a-2603-41fd-18b8-19f4544ca09a@linbit.com>
Date: Thu, 2 Jun 2022 13:20:59 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Michael Labriola <veggiemike@sourceruckus.org>
References: <CAA1fRFhZrTfHegCWwNoSsUkmvBBfFmd9viQVsmCpSMFQNH5vTg@mail.gmail.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <CAA1fRFhZrTfHegCWwNoSsUkmvBBfFmd9viQVsmCpSMFQNH5vTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 01.06.22 um 16:03 schrieb Michael Labriola:
> Ahoy!  Looks like the drbd-9.1 branch doesn't compile against 5.18
> yet.  Is somebody working through the 5.18 block layer changes
> already?  If anyone's got a branch to test, I'd gladly try it out.
> 
> --
> Michael D Labriola
> 401-316-9844 (cell)

Hi,

I'm working on 5.18 compat as we speak. Since no distribution we build
for is using 5.18, this has a somewhat lower priority, but it is being done.

I would estimate we have around 5 or 6 remaining non-trivial patches
that require real attention before we can build for 5.18.

If everything goes to plan, the fixes might make it into the next DRBD
release in mid-June, but I really can't make any promises.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
