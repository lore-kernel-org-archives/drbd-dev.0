Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (unknown [60.234.198.231])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 821E114303
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 23:21:14 +0100 (CET)
Date: Thu, 25 Nov 2004 11:21:08 +1300
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
Message-ID: <Z+CHtpDcVPhqXMZ3GOO8Jts=lge@web.de>
References: <200411152259.28960.philipp.reisner@linbit.com>
	<41A48BB0.4080707@wollmersdorfer.at> <41A4909F.4070806@hug.cx>
	<200411241518.55023.philipp.reisner@linbit.com>
	<41A4A309.9030705@hug.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A4A309.9030705@hug.cx>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-11-24 16:04:41 +0100
\ Philipp Hug:
> yes, that would be nice
> 
> Philipp Reisner wrote:
> 
> >[...]
> > 
> >
> >>sounds easier than it is: according to debian policy the upstream source
> >>tgz must not be modified when uploaded to debian, instead a diff.gz is
> >>upload that contains the diffs between upstream and debian release + it
> >>normally contains the debian directory.
> >>its not possible for the debian packager to remove files from the
> >>original tgz not even in the diffs. you could call this a bug in the
> >>dpkg-buildpackage tool but that's the way it is now.
> >>
> >>2nd: if an upstream package already contains a debian directory is
> >>called a "native-debian" package and the version number should be e.g.
> >>0.7.6 (without -debianversion). but the problem here would be, that the
> >>drbd release must be the version that goes into debian.org and that's
> >>not the case here...
> >>
> >>so I think that removing ./debian at least from the release tarball
> >>would be a good idea... maybe we could add a "make releasetarball"
> >>target...
> >>
> >>   
> >>
> >
> >Ok... So ./debian stays in SVN but will be removed from the release-
> >tarball. Ok. 
> >Do you want to have it this way even with 0.7.6 ?

what about renaming it to debian.upstream or so.
then, if you are the official debian, then you can put your debian in
there, if not, you can symlink it.

does that make sense?

	lge
