Return-Path: <philipp@hug.cx>
Received: from dandelion.nextdomain.net (unknown [62.2.150.10])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B1911431A
	for <drbd-dev@lists.linbit.com>; Tue,  5 Oct 2004 22:40:22 +0200 (CEST)
From: Philipp Hug <philipp@hug.cx>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 debian stuff
Date: Tue, 5 Oct 2004 22:37:50 +0200
References: <41615E9A.5070203@csee.wvu.edu>
In-Reply-To: <41615E9A.5070203@csee.wvu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052237.50672.philipp@hug.cx>
Cc: David Krovich <dkrovich@csee.wvu.edu>, 244291@bugs.debian.org
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


On Monday 04 October 2004 16.30, David Krovich wrote:
> Have the drbd source package create 2 binary packages, one named
> drbd-utils and one named drbd-modules-source.  I think those would be
> much cleaner names for the binary packages.
>
agreed... I'll change them

> I like the fact that drbd0.7 conflicts drbd << 0.7, but do we think
> 0.6.x is no longer being used?  If we upload this package into debian,
> how would we ever be able to upload a newer version of the 0.6.x series?
actually, I thought we'd put drbd0.6 into sarge and drbd0.7 into unstable/sid.
but if you want to have both in sid, you'd need two different source packages.
does it really make sense to keep 0.6 in unstable as upstream isn't working on 
it anymore and has already started the 0.8 branch...?
(or am I wrong here?)

in my opinion, the only reason for having 0.6 packages is to make sure that 
existing 0.6 users don't get automatically upgraded to 0.7.
so, what we have to do is: rename the current packages to drbd0.6 and put them 
into sarge...
then we can start uploading the drbd0.7 version to unstable...

philipp
