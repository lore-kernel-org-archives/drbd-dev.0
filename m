Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 436622D9D9E5
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2007 08:45:11 +0100 (CET)
Date: Mon, 15 Jan 2007 08:45:12 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-svn can't handle modular hmac,
	and crashes if hash can't be found
Message-ID: <20070115074512.GD8577@soda.linbit>
References: <45AA65F4.90709@glines.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AA65F4.90709@glines.org>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-01-14 09:18:44 -0800
\ Mark Glines:
> Hi,
> 
> A few minor issues.
> 
> 1.  CONFIG_CRYPTO_HMAC can be defined as a module; the drbd code currently requires it to be built into the kernel, 
> apparently for no good reason.
> 
> 2.  If the hash algorithm itself isn't available (like sha1.ko wasn't loaded yet), crypto_alloc_hash() returns 
> -ENOENT.  It does not return NULL, which is what the drbd code currently checks for.  This leads to crashes later.

right... we know 't was unfinished code,
but checked in anyways, to get it going.

> 3.  Once #2 is fixed, the user tools try to report the error, and the error message contains a typo, an extra ")".  
> "Failure: (120) The 'cram-hmac-alg' you specified is not known in )the kernel."  It also doesn't tell the user what 
> to do to fix it.
> 
> The attached patch fixes the above issues, and applies cleanly to your current svn.  Please review and apply.

thanks, will do.

> P.S.  Since drbd no longer requires any exported symbols from the hmac/hash module, is there any reason to check 
> CONFIG_CRYPTO_HMAC at all?  A simpler check on CONFIG_CRYPTO to make sure the basic API exists should be all you 
> need...

we build against older kernels as well,
and as long as debian, suse, redhat & co have their
vendor kernels the way they are, this probably needs to stay this way.
we should be able to relax it for builds against newer kernels, though.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
