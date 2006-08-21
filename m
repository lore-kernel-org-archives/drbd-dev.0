Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 36B102CE9DC0
	for <drbd-dev@lists.linbit.com>; Mon, 21 Aug 2006 12:32:34 +0200 (CEST)
Date: Mon, 21 Aug 2006 12:32:35 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Debian and DRBD cooperation
Message-ID: <20060821103235.GD7214@soda.linbit>
References: <87sljrdwxg.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sljrdwxg.fsf@wide.bouthors.org>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-20 22:33:31 +0300
\ Cyril Bouthors:
> Hi,
> 
> As the Debian maintainer of the DRBD packages, I have forwarded 4 bugs
> to you in the last few months and I still haven't received any news so
> far.
> 
> Could you please have a look at those bugs:
> 
> http://bugs.debian.org/cgi-bin/pkgreport.cgi?source=drbd0.7#_1_4_5
> http://bugs.debian.org/cgi-bin/pkgreport.cgi?source=drbd0.7#_1_6_5

these links do not work.
but if I go to bugs.debian.org, and search by package for drbd0.7,
I find exactly three bugs all of them classified as wishlist,
two of them regarding how to package it (which is a debian internal
thing), and one of them (the only "forwarded" one) about how to adjust
the debian/rules file, which is also debian internal.

> and tell me what's still in progress and what's already fixed?

if these are in fact the only ones, I don't know it they are fixed,
since they cannot be fixed by us but have to be fixed debian internally.

> I would really like the Debian and DRBD teams to work together.

there are even people at debian who have full access to the debian/
subdir on svn.drbd.org (where we have our linbit "debian" rules and stuff,
as far as we understand how to do those), but never used it;
seem to prefer to get the drbd.tar.gz without the debian subdir, and
apply the debian internal debian/* stuff.

so, how can I further help you with this?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
