Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep18-int.chello.at (viefep18-int.chello.at [213.46.255.21])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2BFB414311
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 14:25:05 +0100 (CET)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep18-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041124132504.KIXT26867.viefep18-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 14:25:04 +0100
Message-ID: <41A48BB0.4080707@wollmersdorfer.at>
Date: Wed, 24 Nov 2004 14:25:04 +0100
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
References: <200411152259.28960.philipp.reisner@linbit.com>	<87llcy0zn8.fsf@wide.bouthors.org>	<200411191512.50171.philipp.reisner@linbit.com>
	<873bz2tiuk.fsf@wide.bouthors.org>
In-Reply-To: <873bz2tiuk.fsf@wide.bouthors.org>
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
> On 19 Nov 2004,

>>It was told me before. But I will continue to maintain it for my own
>>(possibly other's) convenience. [With 'maintain' I mean to take the
>>official debian/ directory and to put it intdo DRBD's SVN.]

> Sure, I understand that the debian/ directory is useful for SVN users,
> it has to be kept in for them but is it necessary to distribute it in
> the tarballs?

See the thread with subject "0.7.5 release tomorrow..." around 2004-10-06.

The convenient way is to do "make tarball" before "dpkg-buildpackage 
..." and "make-kpkg ...". And I never really understood the 
module-assistant, even after nearly a day of studying the docs. Same is 
true for the newer packaging stuff.

So, what's easier:

1) change and test the drbd/make plus writing a new "HOWTO build debian 
packages from SVN/tarball", and test the HOWTO under different conditions.

OR

2) rm debian/  by debian maintainers

Helmut Wollmersdorfer
