Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 1 Oct 2008 12:46:31 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Thomas Schoebel-Theuer <thomas.schoebel-theuer@1und1.de>
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20081001104631.GD19381@soda.linbit>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<20080911092512.GC9756@soda.linbit> <20080930201016.GB30030@racke>
	<200810011116.41804.thomas.schoebel-theuer@1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200810011116.41804.thomas.schoebel-theuer@1und1.de>
Cc: Michael Ziegel <Michael.Ziegel@1und1.de>,
	Peter Scheitterer <Peter.Scheitterer@1und1.de>, drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 01, 2008 at 11:16:41AM +0200, Thomas Schoebel-Theuer wrote:
> Hi Lars,
> 
> I have two different patches, both based on your git version from 2008-09-11.

great.

> The first one implements the checksumming method while the second one 
> implements the copy method proposed by you.
> 
> I found that your suggestion was much more easier to implement than the 
> checksumming method. However, the copy method works completely silently (you 
> get no response whether a race on the data is actually taking place or not), 
> while the checksumming method writes reports to the kernel log (so you can 
> observe the behavior).

I briefly had a look at the copy method.

as private_bio is a clone of master_bio,
it shares its bvec, thus the pages.

you assign the copy pages to the bvec->bv_page
(you have to do that, master_bio->bvec->bv_page is used in sendpage)
but you don't restore the original pages before completion,
even free the pages already.
you
 * potentially leak the original pages
 * potentially double free the copy pages
as the submitter (file system, page cache, whatever)
in its completion callback may reference or free those.

did you try this on a debug kernel,
memory poisoning and page allocation debugging switched on?
(of course, that is not the kernel you want to use for
 performance benchmarks).

you need to remember the original pages, and you need to restore them
before completion of the master bio.

for diagnostics, you can "memcmp" on that occasion as well.

and you probably need to increase the "emergency reserve" amount of
pre-allocated pages, to avoid resource starvation deadlocks.

you should use copy_page or copy_highpage.

for performance impact, assuming that your memory bandwidth is much
higher than your IO bandwidth, this will "only" increase CPU cycles.
which is probably ok on a generic file server, but may become critical
when running a data base directly on drbd.
so, when doing benchmarks, have a look at the cpu usage as well.

I'll have a look at the checksumming method later.

thanks again,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
