Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep14-int.chello.at (viefep14-int.chello.at [213.46.255.13])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 41D98142F8
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 16:39:10 +0100 (CET)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep14-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041119153909.IQMQ12345.viefep14-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 16:39:09 +0100
Message-ID: <419E139D.8020803@wollmersdorfer.at>
Date: Fri, 19 Nov 2004 16:39:09 +0100
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
References: <200411152259.28960.philipp.reisner@linbit.com>
	<87llcy0zn8.fsf@wide.bouthors.org>
In-Reply-To: <87llcy0zn8.fsf@wide.bouthors.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Cyril Bouthors wrote:
> On 16 Nov 2004, philipp.reisner@public.gmane.org wrote:

>>What exactly should I put into debian/changelog ?

> Since DRBD is not a native Debian package (i.e., package which have
> been written especially for Debian), I think the tarball must not
> contain a debian/changelog nor a debian/ directory.

Its for convenience if somebody wants to install from latest svn.

> Please read the docs a http://debian.org/devel/ for more information.

> FYI, the debian/ tree from upstream is not used for the official
> Debian package.  

ACK. At least debian maintainers are responsible for the content of the 
official Debian package, and upstream maintainers are responsible for 
the tarball.
The cooperation of debian maintainers and drbd-dev in the past, with 
copying ideas and code in both directions had advantages.
I would like to keep it.

> If you want to help maintaining the Debian package,
> Philipp Hug and I would be glad to welcome you as a co-maintainer.

Ohh, glad to see you as drbd co-maintainer.

Helmut Wollmersdorfer
