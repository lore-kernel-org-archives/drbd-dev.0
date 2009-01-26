Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 26 Jan 2009 12:03:38 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20090126110338.GA9911@barkeeper1-xen.linbit>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<200810011328.02278.thomas.schoebel-theuer@1und1.de>
	<20081001114619.GF19381@soda.linbit>
	<200810011449.23052.thomas.schoebel-theuer@1und1.de>
	<20081001145910.GG19381@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20081001145910.GG19381@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

hi there...
any news on this?

also, please consider testing with linux 2.6.28.2,
there are a few data integrity relevant fixes for the
generic dirty page write out path in there...

On Wed, Oct 01, 2008 at 04:59:10PM +0200, Lars Ellenberg wrote:
> On Wed, Oct 01, 2008 at 02:49:22PM +0200, Thomas Schoebel-Theuer wrote:
> > > > Well, one problem is that the length of bvec could be nearly arbitrary
> > > > (in theory),
> > >
> > > BIO_MAX_PAGES
> > > DRBD_MAX_SEGMENT_SIZE
> > 
> > Ok.
> > 
> > > > But what about simply generating a completely new bio and copying over
> > > > all the stuff by hand? This would mean to implement some sort of
> > > > bio_copy() in the local code which could then later be lifted upstreams
> > > > if other people liked it too. What do you think is better?
> > >
> > > no, I think it would be enough to just set (pseudo code)
> > > copy_page->private = orig_page;
> > 
> > Hmm. what if the caller used orig_page->private already and is now accessing 
> > the page _in parallel_ to us? IMHO in combination with the next step it 
> > _could_ lead to an observable difference:
> > 
> > > bvec->bv_page = copy_page;
> > 
> > IMHO this could cause a side effect for any observer accessing "his" page 
> > via "his" orig_bio and finally arriving at our copy_page->private. I am not 
> > sure whether this really happens in the kernel anywhere, but even if 
> > currently not it probably could happen sometime in future. The idea behind 
> > bio_copy() was to _never_ touch the original and all its transitively 
> > reachable descendants in any way, just to be sure nothing can ever go wrong 
> > with it (similar to a COW style). Well, the performance might be slightly 
> > worse, but we are reasoning on correctness at a rather tricky high level.
> >
> > I am not sure whether it really does any harm, I'm just curious and cautious.
> 
> I think that is a reasonable attitude ;)
> 
> so we just don't bio_clone in drbd_req_new then,
> but bio_alloc a fresh bio with our own bvec and own pages attached,
> which will be submitted, _and_ be used to sendpage it over.
> it has to do properly initialized, obviously.
> 
> we have to make sure to get an extra reference (bio_get) on that private
> bio then, so it cannot vanish while being handed over to tcp, it has to
> stay around until master bio completion (where an extra bio_put will
> free it).
> 
> _maybe_ we could add full struct bio private_bio + reasonably sized bvec
> array member to struct drbd_request, so we can skip the extra bio_alloc,
> _get and _put (unless there is some paranoia code in the generic block
> layer, which may be unhappy with that).
> 
> > Well, before implementing it I will reason on it for some time just to be sure 
> > and convinced. Maybe I should implement both alternatives
> 
> implement the "most correct" alternative.
> 
> > and do some stress-testing on a debug kernel?
> 
> absolutely.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
