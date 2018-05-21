Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C9A05101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 16:47:04 +0200 (CEST)
Date: Mon, 21 May 2018 10:47:03 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20180521144703.GA19303@redhat.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<20180521140348.GA19069@redhat.com>
	<686d7df6-c7d1-48a6-b7ff-48dc8aff6a62@kernel.dk>
	<20180521143132.GB19194@redhat.com>
	<2bbeeb1a-8b99-b06a-eb9b-eb8523c16460@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbeeb1a-8b99-b06a-eb9b-eb8523c16460@kernel.dk>
Cc: hch@infradead.org, linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
	darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
	colyli@suse.de, linux-block@vger.kernel.org, clm@fb.com,
	neilb@suse.com, bacik@fb.com, Kent Overstreet <kent.overstreet@gmail.com>,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 21 2018 at 10:36am -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 5/21/18 8:31 AM, Mike Snitzer wrote:
> > On Mon, May 21 2018 at 10:19am -0400,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> On 5/21/18 8:03 AM, Mike Snitzer wrote:
> >>> On Sun, May 20 2018 at  6:25pm -0400,
> >>> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> >>>
> >>>> Jens - this series does the rest of the conversions that Christoph wanted, and
> >>>> drops bioset_create().
> >>>>
> >>>> Only lightly tested, but the changes are pretty mechanical. Based on your
> >>>> for-next tree.
> >>>
> >>> By switching 'mempool_t *' to 'mempool_t' and 'bio_set *' to 'bio_set'
> >>> you've altered the alignment of members in data structures.  So I'll
> >>> need to audit all the data structures you've modified in DM.
> >>>
> >>> Could we get the backstory on _why_ you're making this change?
> >>> Would go a long way to helping me appreciate why this is a good use of
> >>> anyone's time.
> >>
> >> Yeah, it's in the first series, it gets rid of a pointer indirection.
> > 
> > "Allows mempools to be embedded in other structs, getting rid of a
> > pointer indirection from allocation fastpaths."
> > 
> > So this is about using contiguous memory or avoiding partial allocation
> > failure?  Or both?
> > 
> > Or more to it?  Just trying to fully appreciate the theory behind the
> > perceived associated benefit.
> 
> It's about avoiding a pointer indirection. Instead of having to
> follow a pointer to get to that struct, it's simple offset math off
> your main structure.
> 
> > I do think the increased risk of these embedded bio_set and mempool_t
> > themselves crossing cachelines, or struct members that follow them doing
> > so, really detracts from these types of changes.
> 
> Definitely something to look out for, though most of them should be
> per-dev structures and not in-flight structures. That makes it a bit
> less sensitive. But can't hurt to audit the layouts and adjust if
> necessary. This is why it's posted for review :-)

This isn't something that is easily caught upfront.  Yes we can all be
busy little beavers with pahole to audit alignment.  But chances are
most people won't do it.

Reality is there is potential for a regression due to false sharing to
creep in if a hot struct member suddenly starts straddling a cacheline.
That type of NUMA performance killer is pretty insidious and somewhat
tedious to hunt down even when looking for it with specialized tools:
https://joemario.github.io/blog/2016/09/01/c2c-blog/
