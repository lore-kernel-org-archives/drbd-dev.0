Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 35F5B2E0929B
	for <drbd-dev@lists.linbit.com>; Thu, 10 Apr 2008 23:21:28 +0200 (CEST)
Date: Thu, 10 Apr 2008 23:21:55 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems with DRBD merge-bvec function
Message-ID: <20080410212131.GA12178@racke.local>
References: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 10, 2008 at 02:39:11PM -0400, Graham, Simon wrote:
> I've been doing some performance comparisons using the iometer benchmark
> between a system without DRBD and one with and with a specific setup
> that simulates a database workload I am seeing a significant performance
> drop with DRBD (I see around 60% of the 'native' perf level when running
> with DRBD). 
> 
> After several days staring at the perf counter data, I've come to the
> conclusion that the only difference between the two cases is the size of
> requests passed down to the logical volume below DRBD. The iometer
> workload is doing a mixture of synchronous reads and writes but all are
> exactly 16KB in size and I see that:
> 
> 1. When running without DRBD, the logical volume is seeing a constant
> request size of 32 sectors (16KB)
> 2. When running with DRBD, the request size is variable but is <= 16
> sectors with the vast majority of requests at the 16 sector size.
> 
> Enabling the DRBD trace, I can see that we are indeed getting a lot of
> 8K and smaller requests AND that we never see requests that cross a 32KB
> boundary in disk offsets. I think this is causing my problem because
> requests are being split above DRBD and then re-merged (sometimes)
> between LVM and the physical disk.
> 
> Looking at the drbd_merge_bvec function I see that this is indeed
> deliberate with the current code being as follows:
> 
> #if 1
> 	limit = DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
> (DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
> #else
> 	limit = AL_EXTENT_SIZE - ((bio_offset & (AL_EXTENT_SIZE-1)) +
> bio_size);
> #endif
> 
> Since DRBD_MAX_SEGMENT_SIZE is 32KB that means DRBD will never allow a
> single BIO to cross the 32KB boundary. The original purpose of this
> routine according to the comments was to ensure requests did not cross
> the 4MB AL segment size boundary but it seems this was changed.
> 
> This seems to be a big problem to me -- even though DRBD advertizes a
> max rq size of 32KB, it rarely is able to actually achieve this when
> synchronous I/O is done. It's certainly causing me grief at the moment!
> 
> I see that I cant simply change this code back to the 4MB boundary check
> as we then run into code in drbd_make_request26 that will decide to try
> and bio_split the request if it crosses s 32KB boundary... although I
> see that the previous code before Lars checkin cbc66a14 actually did the
> check based on the AL segment size.
> 
> I didn't quite understand the comments re this being necessary to
> support two primaries either.
> 
> Any suggestions for relaxing this limitation?

if your load wants to submit constant 16KB requrets,
get your file system/database simulation to use aligned "pages",
and it will be a non-issue.

ok, so that does not work.
hm.

I'll quote the comment from above _req_conflicts here:
/*
 * checks whether there was an overlapping request
 * or ee already registered.
 *
 * if so, return 1, in which case this request is completed on the spot,
 * without ever being submitted or send.
 *
 * return 0 if it is ok to submit this request.
 *
 * NOTE:
 * paranoia: assume something above us is broken, and issues different write
 * requests for the same block simultaneously...
 *
 * To ensure these won't be reordered differently on both nodes, resulting in
 * diverging data sets, we discard the later one(s). Not that this is supposed
 * to happen, but this is the rationale why we also have to check for
 * conflicting requests with local origin, and why we have to do so regardless
 * of whether we allowed multiple primaries.
 *
 * BTW, in case we only have one primary, the ee_hash is empty anyways, and the
 * second hlist_for_each_entry becomes a noop. This is even simpler than to
 * grab a reference on the net_conf, and check for the two_primaries flag...
 */
STATIC int _req_conflicts(drbd_request_t *req)


to make it impossible for two "simultaneous" io requests to the same region
to reach the disks in different order, we need to check for conflicts.
these conflicts are easy to provoke by just doing multiple "dd oflag=direct"
to the same block on an smp box, so the risk is real.
even when not using two primaries.

the conflict detection is based on hash table lookups,
key is (target start sector>>HT_SHIFT), HT_SHIFT is defined to 6.
that is where the 32kB max segment size comes from.

conflict detection works by just checking the collision chain for overlapping
requests.  if we allow a request to cross collision chain boundaries, we'd have
to check three colision chains for the single request, which would be not that
bad...  but this degenerates when looking at the problem more thoroughly.  I
don't have it written down anywhere, but it cascades.  you have to check the
slot and its neighbors, and then the neighbouring slots of those neighbors, and
... soon you have to walk most if not all pending requests to be correct, or
limit the number of pending requests, which also hurts performance. (maybe the
cascading effect was only for the two-primary case, though, I don't remember
exactly anymore)

I do remember, however, that I considered one way out of there,
which is basically to have
struct drbd_request {
	...
	/* corresponding to (start sector >> HT_SHIFT) */
	struct hlist_node colision_s;
	/* corresponding to (end sector >> HT_SHIFT) */
	struct hlist_node colision_e;
	...
}
register non-crossing requests only on _s,
boundary-crossing requests on both.
one has to be careful and write a special-cased
hlist_for_each(n,slot) {
   req_i = hlist_entry(n, (struct drbd_request *), colision_s);
   if (&req_i->colision_s != n) {
   	req_i = hlist_entry(n, (struct drbd_request *), colision_e);
	BUG_ON(&req_i->colision_e != n)
   }
or something like that, and be more careful when unlinking.  that should do the
trick, get a reliable detection, and get rid of the cascading effect.

much simpler:
you could try to increase HT_SHIFT to 7 or 8,
and see if and where the code breaks.

or ignore the risk (any application triggering these sanity checks is seriously
broken and would probably not work anyways, so as long as you have an
established file system/data base, arguably you can assume that this check is
just too paranoid, at least in the one-primary case).
if you chose this option, just revert it to the 4MB boundary check we
used to have.  this one has to stay, though, the activity log depends on
it, one al-extent coverse 4MB.

	Lars
