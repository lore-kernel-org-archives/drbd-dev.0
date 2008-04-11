Return-Path: <lars@linbit.com>
Date: Fri, 11 Apr 2008 08:45:52 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems with DRBD merge-bvec function
Message-ID: <20080411064552.GA22939@mail.linbit.com>
References: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767108F02F3F@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108F02F3F@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 10, 2008 at 06:13:46PM -0400, Graham, Simon wrote:
> Lars,
> 
> Thanks for the swift and comprehensive response - gonna have to digest
> this for a bit but I do have some questions:
> 
> > to make it impossible for two "simultaneous" io requests to the same
> > region
> > to reach the disks in different order, we need to check for conflicts.
> > these conflicts are easy to provoke by just doing multiple "dd
> > oflag=direct"
> > to the same block on an smp box, so the risk is real.
> > even when not using two primaries.
> > 
> 
> Hmm.. the result of such badness is undefined, but I guess we should try
> and make DRBD have the same result on both sides in this case...

that is exactly the point, yes.

> cant say I'm entirely convinced though -- if you do bad things, you
> get bad results!

which is also true.

> > conflict detection works by just checking the collision chain for
> > overlapping requests.  if we allow a request to cross collision
> > chain boundaries, we'd have to check three colision chains for the
> > single request, which would be not that bad...  but this degenerates
> > when looking at the problem more thoroughly.  I
> 
> Hmm.. this one escapes me - I can see how you have to potentially search
> three chains for collisions (the one before and the two that the request
> spans) but if the max rq size is 32KB and the bucket size is 32KB, how
> can it expand beyond the three?
> 
> I'm sure you are right, just trying to understand...

I'm sure I'm right, too, just cannot quite remember ;)
thinking about it once more, for the local-only conflict detection,
it would be just ok. for the various classifications of the
two-thousand-and-odd possiblilities in two-primary conflict detection,
there has been cases where it would not be correct anymore, needing
cascading colision chain traversal in the "wake-up" path (telling queued
conflicts that the pending conflicting request is done now).

> > or ignore the risk (any application triggering these sanity checks
> > is seriously broken and would probably not work anyways, so as long
> > as you have an established file system/data base, arguably you can
> > assume that this check is just too paranoid, at least in the
> > one-primary case).  if you chose this option, just revert it to the
> > 4MB boundary check we used to have.  this one has to stay, though,
> > the activity log depends on it, one al-extent coverse 4MB.
> 
> That's what I'm testing at the moment -- I reverted the checks in both
> drbd_merge_bvec and drbd_make_request_26.

let us know what the impact on performance is.

but maybe this had not been your problem at all?
if any of the lower level devices has a merge_bvec function itself,
drbd falls back to "PAGE_SIZE" max-segments, unless you have "use-bmbv"
enabled, because we currently cannot cope with bios that need not be
split on the Primary, but would suddenly be split on the Secondary due
to different lower level constraints.
if you are sure your lower level devices have the very same constraints,
retry with the 32kB boundary settings, but turn on "use-bmbv".

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
