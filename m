Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6501C101E043
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2009 18:49:26 +0200 (CEST)
Resent-Message-ID: <20090828164926.GA8088@barkeeper1-xen.linbit>
Received: from mailmx.ins.com (mailmx.ins.com [198.134.150.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D790B10003F3
	for <drbd-dev@lists.linbit.com>; Wed, 19 Aug 2009 00:21:59 +0200 (CEST)
From: <Anthony.D'Ambrosio@ins.com>
To: <gui@moolfreet.com>, <drbd-dev@lists.linbit.com>
Date: Tue, 18 Aug 2009 16:24:17 -0500
Message-ID: <1E4636828B4AD841900A31378A9FE3CD02D19D9591@usemp11.ins.com>
References: <479b87b70908160900ue855e71l8212d7f6936064c4@mail.gmail.com>
	<200908182259.10699.philipp.reisner@linbit.com>,
	<479b87b70908181416x32ff9912g98a6f39c1cd52fca@mail.gmail.com>
In-Reply-To: <479b87b70908181416x32ff9912g98a6f39c1cd52fca@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Drbd-dev] Patch for an up-to-date script/patch-kernel
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks also for the fix and thumbs up on the core Linux merge! (We discover=
ed the resulting kernel build errors, and being a good lazy developer figur=
ed you folks would fix it and moved on to some other tasks while we waited.=
  Thanks to Guillaume for the fix.)

We patch for the same reason.

Anthony
________________________________________
From: drbd-dev-bounces@lists.linbit.com [drbd-dev-bounces@lists.linbit.com]=
 On Behalf Of Guillaume Plessis [gui@moolfreet.com]
Sent: Tuesday, August 18, 2009 5:16 PM
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Patch for an up-to-date script/patch-kernel

Hello,

I use the patch method to avoid CONFIG_MODULES to be set.
That's one more way to prevent malicious kernel modules to be loaded on ris=
ky machines (web servers with unsecure PHP application =3D> www-data shell =
access =3D> privilege escalation =3D> malicious module loaded).

Thanks for the patch having been applyed and good news that DRBD is getting=
 merged to Linux upstream!

--
Guillaume Plessis



2009/8/18 Philipp Reisner <philipp.reisner@linbit.com<mailto:philipp.reisne=
r@linbit.com>>

Whow the second patch of this kind within a few days. I never expected
that people actually patch DRBD into their kernels...

I have applied it.

Other than that we aim to get DRBD merged to Linux upstream with the
2.6.32 release. You can track out integration work from here:

git://git.drbd.org/linux-2.6-drbd.git<http://git.drbd.org/linux-2.6-drbd.gi=
t>

-Phil


