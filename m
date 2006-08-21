Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 83EFE2CE9DC5
	for <drbd-dev@lists.linbit.com>; Mon, 21 Aug 2006 12:54:23 +0200 (CEST)
Date: Mon, 21 Aug 2006 12:54:26 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Debian and DRBD cooperation
Message-ID: <20060821105426.GE7214@soda.linbit>
References: <87sljrdwxg.fsf@wide.bouthors.org>
	<20060821103235.GD7214@soda.linbit>
	<877j12pe64.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877j12pe64.fsf@wide.bouthors.org>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-21 13:37:55 +0300
\ Cyril Bouthors:
> On 21 Aug 2006, Lars Ellenberg wrote:
> 
> > these links do not work.
> 
> sorry about this:
> 
> http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=drbd0.7#_1_4_5

#308640: /sbin/drbdsetup: doesn't work with x86_64 kernel
  fixed; was broken because of a minor glitch between versions.
	 we now have compile time asserts in place so this is
         unlikely to ever happen again.

#337210: drbd0.7-utils: man page of drbdsetup is wrong
  fixed;
         example section has been removed/replaced with a url pointer to
         examples on the web -- which may or may not be correct ;)

#337242: drbd0.7-utils: Wrong argument supplied to drbdsetup
  bogus; the "you must not give an index with internal" is correct
	 for the drbd.conf syntax. because it _implies_ the -1 on the drbdsetup
	 commandline. whatever the problem of the reporter was, this is not it.

> http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=drbd0.7#_1_6_5

#357298: drbd: fix building for x86_64 on i386 
	has to be fixed debian internally, I think, in case it still
	applies.

all of these have been dealt with very quickly
on drbd-user when first reported there.

cheers,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
