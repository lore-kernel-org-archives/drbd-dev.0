Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (ptdm-d9b8272a.pool.mediaWays.net [217.184.39.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F3BD1168A1
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 18:32:35 +0200 (CEST)
Date: Mon, 9 May 2005 18:31:57 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
Message-ID: <fH//25Q/o41su/Ukkqv/kes=lge@web.de>
References: <200505091030.00455.philipp.reisner@linbit.com>
	<200505091058.42759.hug@abanet.ch>
	<200505091137.01385.philipp.reisner@linbit.com>
	<LVlMtS7zpHS+KhTi1IqrJxc=lge@web.de>
	<427F8AA8.8000407@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427F8AA8.8000407@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-05-09 18:07:04 +0200
\ Helmut Wollmersdorfer:
> Lars Ellenberg wrote:
> 
> >hm.
> >maybe it is easier to NOT generate a drbd-0.7.10 package, but a drbd-0.7
> >paackage, so it can be updated to our 0.7.X releases without violating
> >any package release policies?

> > development is in 0.8, 0.7 is in "bugfix-only-mode" anyways.
> 
> Not all "bugfixes" are "security fixes".
> 
> IMHO the mainstream of users can live with 0.7.10.
> If someone has special requirements, (s)he can
> - install from Debian /unstable (or /testing after release)
> - compile from tar/SVN
> - request LINBIT services
> - backport future releases to stable
> - use another $distri
> 
> IMHO it's important for the popularity of DRBD to have the "pretty
> stable" 0.7.10 in Debian.

right.
I was just contemplating...

the SuSE drbd-0.7.4-whatever seems to be a 0.7.10+, too,
with a downpatched version number...

as a packager, if you do such things,
you are lying to yourself and your customers,
and ** I don't see any reason for that **.

But I have not been involved in politics too deeply, either, so far...
anyways.  It's probably best to just let the packagers of whatever
disribution do their work, and just help out if asked directly.

btw, packagers: thank you for increasing "the popularity of DRBD"... 

	Lars
