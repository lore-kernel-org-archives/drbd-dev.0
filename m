Return-Path: <Thomas.Schoebel-Theuer@1und1.de>
Received: from msxmx04.webde.de (msxmx04.webde.de [217.72.192.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 935C42E085E9
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 14:49:37 +0200 (CEST)
Received: from WEBEXCHANGE02.webde.local (webexc02.webde.local [10.2.3.31])
	by msxmx04.webde.de (Postfix) with ESMTP id BF64E18251
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 14:49:36 +0200 (CEST)
From: "Thomas Schoebel-Theuer" <thomas.schoebel-theuer@1und1.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Date: Wed, 1 Oct 2008 14:49:22 +0200
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<200810011328.02278.thomas.schoebel-theuer@1und1.de>
	<20081001114619.GF19381@soda.linbit>
In-Reply-To: <20081001114619.GF19381@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810011449.23052.thomas.schoebel-theuer@1und1.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Well, one problem is that the length of bvec could be nearly arbitrary
> > (in theory),
>
> BIO_MAX_PAGES
> DRBD_MAX_SEGMENT_SIZE

Ok.

> > But what about simply generating a completely new bio and copying over
> > all the stuff by hand? This would mean to implement some sort of
> > bio_copy() in the local code which could then later be lifted upstreams
> > if other people liked it too. What do you think is better?
>
> no, I think it would be enough to just set (pseudo code)
> copy_page->private = orig_page;

Hmm. what if the caller used orig_page->private already and is now accessing 
the page _in parallel_ to us? IMHO in combination with the next step it 
_could_ lead to an observable difference:

> bvec->bv_page = copy_page;

IMHO this could cause a side effect for any observer accessing "his" page 
via "his" orig_bio and finally arriving at our copy_page->private. I am not 
sure whether this really happens in the kernel anywhere, but even if 
currently not it probably could happen sometime in future. The idea behind 
bio_copy() was to _never_ touch the original and all its transitively 
reachable descendants in any way, just to be sure nothing can ever go wrong 
with it (similar to a COW style). Well, the performance might be slightly 
worse, but we are reasoning on correctness at a rather tricky high level.

I am not sure whether it really does any harm, I'm just curious and cautious.

Well, before implementing it I will reason on it for some time just to be sure 
and convinced. Maybe I should implement both alternatives and do some 
stress-testing on a debug kernel?

Thanks for your feedback,

Thomas
