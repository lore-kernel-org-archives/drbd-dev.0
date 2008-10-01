Return-Path: <Thomas.Schoebel-Theuer@1und1.de>
Received: from msxmx04.webde.de (msxmx04.webde.de [217.72.192.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F3C542E05E98
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 13:28:16 +0200 (CEST)
Received: from WEBEXCHANGE02.webde.local (webexc02.webde.local [10.2.3.31])
	by msxmx04.webde.de (Postfix) with ESMTP id 1988518444
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 13:28:16 +0200 (CEST)
From: "Thomas Schoebel-Theuer" <thomas.schoebel-theuer@1und1.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Date: Wed, 1 Oct 2008 13:28:02 +0200
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<200810011116.41804.thomas.schoebel-theuer@1und1.de>
	<20081001104631.GD19381@soda.linbit>
In-Reply-To: <20081001104631.GD19381@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810011328.02278.thomas.schoebel-theuer@1und1.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> as private_bio is a clone of master_bio,
> it shares its bvec, thus the pages.

Oops, I didn't realize that (and I tested the copy version only briefly 
because I was more interested in the checksumming because of the kernel log 
messages). The implications are clear to me.

IMHO best solution would be the existence of a bio_copy() in addition to 
bio_clone() in bio.h, but even if we would get it into the upstream it would 
not help for elder kernels.

> you need to remember the original pages, and you need to restore them
> before completion of the master bio.

Well, one problem is that the length of bvec could be nearly arbitrary (in 
theory), so preclaiming "enough" space in struct drbd_request is probably no 
good idea. Well, kmalloc() would be possible to keep the allocation dynamic 
without wasting space.

But what about simply generating a completely new bio and copying over all the 
stuff by hand? This would mean to implement some sort of bio_copy() in the 
local code which could then later be lifted upstreams if other people liked 
it too. What do you think is better?

Thanks for feedback,

Thomas
