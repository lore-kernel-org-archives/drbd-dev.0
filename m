Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-76-87.b.dial.de.ignite.net [62.134.76.87])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A29CA142F9
	for <drbd-dev@lists.linbit.com>; Wed, 20 Oct 2004 16:22:30 +0200 (CEST)
Date: Wed, 20 Oct 2004 16:22:18 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <ZcWazeDK8bJMyAq1zhsLD7I=lge@web.de>
References: <gt0q2bPC2BjLTdYvoniqOkA=lge@web.de>
	<n/0nVbG2W2wQDG4jMwN41Pc=lge@web.de>
	<NPUp4T3Ya1hNzMAxjFRXf0M=lge@web.de>
	<200410201239.55282.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410201239.55282.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: DRBD IOCTLs nicht 64bit clean...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-20 12:39:55 +0200
\ Philipp Reisner:

> I have not yet decided if I will do the reordering of the
> members as well and increase the API version, 
> 
> OR, 
> 
> leave the members in this order and no change to the API
> version number .... This would be more conventient for our
> i386 users, but plain frong for the users of 64bit archs...

please rather do it right, than have __u64 odd-aligned.

an while we are at it, use a unified prefix ioctl struct,
which includes the api version, device id and result fields,
and only then the specific data.  halfes our ioctls, since the api
version now can be verified with each ioctl, and has other advantages
as well...

	lge
