Return-Path: <philipp@hug.cx>
Received: from postman.abacus.ch (postman.abacus.ch [193.246.101.142])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C70A14311
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 14:46:53 +0100 (CET)
Message-ID: <41A4909F.4070806@hug.cx>
Date: Wed, 24 Nov 2004 14:46:07 +0100
From: Philipp Hug <philipp@hug.cx>
MIME-Version: 1.0
To: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
References: <200411152259.28960.philipp.reisner@linbit.com>	<87llcy0zn8.fsf@wide.bouthors.org>	<200411191512.50171.philipp.reisner@linbit.com>	<873bz2tiuk.fsf@wide.bouthors.org>
	<41A48BB0.4080707@wollmersdorfer.at>
In-Reply-To: <41A48BB0.4080707@wollmersdorfer.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


> The convenient way is to do "make tarball" before "dpkg-buildpackage 
> ..." and "make-kpkg ...". And I never really understood the 
> module-assistant, even after nearly a day of studying the docs. Same 
> is true for the newer packaging stuff.

You can still do make-kpkg even with the new packaging: If it doesn't
work, it's a bug.

> So, what's easier:
>
> 1) change and test the drbd/make plus writing a new "HOWTO build 
> debian packages from SVN/tarball", and test the HOWTO under different 
> conditions.

well actually I could change the debian scripts to work directly within
the svn directory. that's probably easier than doing "make tarball" first.

> OR
>
> 2) rm debian/  by debian maintainers

sounds easier than it is: according to debian policy the upstream source
tgz must not be modified when uploaded to debian, instead a diff.gz is
upload that contains the diffs between upstream and debian release + it
normally contains the debian directory.
its not possible for the debian packager to remove files from the
original tgz not even in the diffs. you could call this a bug in the
dpkg-buildpackage tool but that's the way it is now.

2nd: if an upstream package already contains a debian directory is
called a "native-debian" package and the version number should be e.g.
0.7.6 (without -debianversion). but the problem here would be, that the
drbd release must be the version that goes into debian.org and that's
not the case here...

so I think that removing ./debian at least from the release tarball
would be a good idea... maybe we could add a "make releasetarball" target...

philipp

