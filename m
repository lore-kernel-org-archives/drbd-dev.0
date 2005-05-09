Return-Path: <hug@abanet.ch>
Received: from shopwall.abacus.ch (shopwall.abacus.ch [193.246.120.14])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C5C3216907
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 18:54:06 +0200 (CEST)
From: Philipp Hug <hug@abanet.ch>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
Date: Mon, 9 May 2005 18:55:24 +0200
References: <200505091030.00455.philipp.reisner@linbit.com>
	<427F8AA8.8000407@wollmersdorfer.at>
	<fH//25Q/o41su/Ukkqv/kes=lge@web.de>
In-Reply-To: <fH//25Q/o41su/Ukkqv/kes=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505091855.25243.hug@abanet.ch>
Cc: Lars Ellenberg <Lars.Ellenberg@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

in debian uploads to stable are allowed, if:
    * a truly critical functionality problem
    * the package becomes uninstallable
    * a released architecture lacks the package

so in an updated 0.7 version it is possible to fix bugs, but not to add new 
functionality...

philipp

On Monday 09 May 2005 18.31, Lars Ellenberg wrote:
> / 2005-05-09 18:07:04 +0200
>
> \ Helmut Wollmersdorfer:
> > Lars Ellenberg wrote:
> > >hm.
> > >maybe it is easier to NOT generate a drbd-0.7.10 package, but a drbd-0.7
> > >paackage, so it can be updated to our 0.7.X releases without violating
> > >any package release policies?
> > >
> > > development is in 0.8, 0.7 is in "bugfix-only-mode" anyways.
> >
> > Not all "bugfixes" are "security fixes".
> >
> > IMHO the mainstream of users can live with 0.7.10.
> > If someone has special requirements, (s)he can
> > - install from Debian /unstable (or /testing after release)
> > - compile from tar/SVN
> > - request LINBIT services
> > - backport future releases to stable
> > - use another $distri
> >
> > IMHO it's important for the popularity of DRBD to have the "pretty
> > stable" 0.7.10 in Debian.
>
> right.
> I was just contemplating...
>
> the SuSE drbd-0.7.4-whatever seems to be a 0.7.10+, too,
> with a downpatched version number...
>
> as a packager, if you do such things,
> you are lying to yourself and your customers,
> and ** I don't see any reason for that **.
>
> But I have not been involved in politics too deeply, either, so far...
> anyways.  It's probably best to just let the packagers of whatever
> disribution do their work, and just help out if asked directly.
>
> btw, packagers: thank you for increasing "the popularity of DRBD"...
>
>  Lars
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
