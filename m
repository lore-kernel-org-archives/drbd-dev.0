Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com
	[209.85.128.181])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 922711057FF0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 16:45:54 +0200 (CEST)
Received: by mail-wr0-f181.google.com with SMTP id v105so2432191wrb.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 07:45:54 -0700 (PDT)
Date: Tue, 18 Jul 2017 16:45:51 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718144551.GE1453@rck.sh>
References: <20170718083536.13668-1-bwiedemann@suse.de>
	<20170718091350.16310-1-bwiedemann@suse.de>
	<20170718123532.GD1453@rck.sh>
	<ce35732f-d0c4-cd8d-66f9-e5785d0bdbe2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce35732f-d0c4-cd8d-66f9-e5785d0bdbe2@suse.de>
Subject: Re: [Drbd-dev] [PATCH] drbd: Allow to override build date (v2)
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

On Tue, Jul 18, 2017 at 02:47:54PM +0200, Bernhard M. Wiedemann wrote:
> 
> > No. What if setting SOURCE_DATE_EPOCH becomes the default in the future?
> > Maybe it already is for some of the distributions we as LINBIT build
> > packages for. Sorry for being the spoilsport here, but as it stands I
> > only see the potential of breaking the way we want it .
> 
> It already _is_ the default for openSUSE Tumbleweed (aka Factory)...

See, then it was good not taking it as it was, as it would have changed
the behavior from what *we intentionally* want to what *you* want.

> If you are that reliant/insistent on this date, we could add another

I'm insistent on one simple thing: Don't break our existing code/builds
with something you want.

> [ -z "${WANT_DRBD_REPRODUCIBLE_BUILD}" ] ||

Looks good, merged your v3 patch.

Thanks, rck
