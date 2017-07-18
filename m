Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 85B641057FE2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 10:21:59 +0200 (CEST)
Received: by mail-wr0-f180.google.com with SMTP id a10so18009885wrd.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 01:21:59 -0700 (PDT)
Date: Tue, 18 Jul 2017 10:21:57 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718082157.GC1453@rck.sh>
References: <20170717194958.22787-1-bwiedemann@suse.de>
	<20170718072542.GB1453@rck.sh>
	<e66b3632-f591-4874-dc47-2a79b986b684@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66b3632-f591-4874-dc47-2a79b986b684@suse.de>
Subject: Re: [Drbd-dev] [PATCH] [RFC] drbd: do not record build details
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

On Tue, Jul 18, 2017 at 10:08:16AM +0200, Bernhard M. Wiedemann wrote:
> On 2017-07-18 09:25, Roland Kammerer wrote:
> > 
> > I'm a big fan of reproducible builds, but only as long as it does not
> > break very useful information for us when we actually look at customer
> > installations. In that case it IMO does break that.
> 
> it was only meant as an example (see comment in patch).
> We can make something nicer.
> 
> https://lists.samba.org/archive/samba-technical/2017-July/121677.html
> actually preferred to completely drop such build-time data collection
> over my initial patch of making it optional.
> 
> > Again, I totally understand what the reproducible build project tries to
> > achieve, and it is important, but why isn't that just a vendor-patch for
> > the distribution you care about like the Debian guys do it?
> 
> because it is also us (open)SUSE guys, the Fedora guys, the FreeBSD guys
> and there are probably a dozen other distributions out there, which is
> why I try to upstream such patches as much as possible to only have to
> fix it once for everyone.

Yes, minimizing the required patch set obviously makes sense. I will
take the first one (the sort thing), because if it helps why not.

The second one is not going to happen, sorry. Here we intentionally do
not want anything to be reproducible. We want to have that information,
that is why it is there in the first place, that was no
coincidence/mistake.

Regards, rck
