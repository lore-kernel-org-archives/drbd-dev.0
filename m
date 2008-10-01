Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id CB52B2E05E98
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 13:46:19 +0200 (CEST)
Date: Wed, 1 Oct 2008 13:46:19 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20081001114619.GF19381@soda.linbit>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<200810011116.41804.thomas.schoebel-theuer@1und1.de>
	<20081001104631.GD19381@soda.linbit>
	<200810011328.02278.thomas.schoebel-theuer@1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200810011328.02278.thomas.schoebel-theuer@1und1.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 01, 2008 at 01:28:02PM +0200, Thomas Schoebel-Theuer wrote:
> > as private_bio is a clone of master_bio,
> > it shares its bvec, thus the pages.
> 
> Oops, I didn't realize that (and I tested the copy version only briefly 
> because I was more interested in the checksumming because of the kernel log 
> messages). The implications are clear to me.
> 
> IMHO best solution would be the existence of a bio_copy() in addition to 
> bio_clone() in bio.h, but even if we would get it into the upstream it would 
> not help for elder kernels.
> 
> > you need to remember the original pages, and you need to restore them
> > before completion of the master bio.
> 
> Well, one problem is that the length of bvec could be nearly arbitrary (in 
> theory),

BIO_MAX_PAGES
DRBD_MAX_SEGMENT_SIZE

> so preclaiming "enough" space in struct drbd_request is probably no 
> good idea. Well, kmalloc() would be possible to keep the allocation dynamic 
> without wasting space.

I meant the pre-allocating in drbd_pp_alloc. number of pages.

> But what about simply generating a completely new bio and copying over all the 
> stuff by hand? This would mean to implement some sort of bio_copy() in the 
> local code which could then later be lifted upstreams if other people liked 
> it too. What do you think is better?

no, I think it would be enough to just set (pseudo code)
copy_page->private = orig_page;
bvec->bv_page = copy_page;

then, later before completion,
bio_for_each_segment
  memcmp,
  restore orig
  drbd_pp_free copy

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
