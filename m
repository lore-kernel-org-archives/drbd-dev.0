Return-Path: <florian.haas@hastexo.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
	[209.85.216.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D0F9D106DCC0
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 11:25:40 +0100 (CET)
Received: by qcsg15 with SMTP id g15so2636559qcs.27
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 03:25:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120323102300.GI3743@barkeeper1-xen.linbit>
References: <1332420276-29946-1-git-send-email-florian@hastexo.com>
	<1332420276-29946-2-git-send-email-florian@hastexo.com>
	<20120323100432.GH3743@barkeeper1-xen.linbit>
	<CAPUexz_0+mzbbrVmyXq+yBxCdUpkmrh9tvWEKyBNcaxXMUVO7g@mail.gmail.com>
	<20120323102300.GI3743@barkeeper1-xen.linbit>
Date: Fri, 23 Mar 2012 11:25:37 +0100
Message-ID: <CAPUexz8cKDooO0DkK_eEH45OkDnb6UdiQmv5tudqQ-vz4cS1dw@mail.gmail.com>
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] udev rules file: skip if invoked for a
 subsystem other than block
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Mar 23, 2012 at 11:23 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
>> http://lists.linbit.com/pipermail/drbd-dev/2011-November/002007.html
>
> Right. I remember now.
> Should not happen, as the "drbdlinks" is not a "KERNEL=3D*" name
> anymore... =C2=A0But whatever. Udev voodoo.
>
> I don't see how this can possible break things,
> and apparently it fixes some. So:
>
> Thanks :-)

alamar did report back at the time that it fixed his problem. So,
you're welcome. :)

Cheers,
Florian

--=20
Need help with High Availability?
http://www.hastexo.com/now
