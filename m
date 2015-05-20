Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150520124418.GA15594@lst.de>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
	<20150520124418.GA15594@lst.de>
Date: Wed, 20 May 2015 11:16:20 -0700
Message-ID: <CAF1ivSbu4e2MzUB2CPJi92PpkOvLrLA=TO55-=7m07GpYz98Xw@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 01/11] block: make generic_make_request
 handle arbitrarily sized bios
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

On Wed, May 20, 2015 at 5:44 AM, Christoph Hellwig <hch@lst.de> wrote:
> This needs the patch below for the blk-mq case with multiple queues.

Will add it.

>
> Also I wonder why we really want to push this below ->make_request.
> Moving it just outside ->make_request would make the callchain more
> obvious and avoid the recursion into the driver.

Are you saying move the split to generic_make_request()?
Below is an off-list discussion.

Ming Lei asked:
> > I am wondering why the bio isn't splitted just before q->make_request_fn
> > is called in generic_make_request()?  By this way, drivers won't need
> > to call blk_queue_split() at all.  Is it because performance reason? or
> > others?

Kent replied:
> > The reasoning was because blk_queue_split() was only an interim solution -
> > there's actually no inherent need to split the bios at all, but not splitting
> > them takes (a small amount of) driver modification. You just have the driver
> > consume the bios incrementally, advancing the iterator and using bi_remaining
> > when they have multiple tags pointing to the same bio.

>
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bbc04..e7fae76 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1256,6 +1256,8 @@ static void blk_mq_make_request(struct request_queue *q, struct bio *bio)
>                 return;
>         }
>
> +       blk_queue_split(q, &bio, q->bio_split);
> +
>         rq = blk_mq_map_request(q, bio, &data);
>         if (unlikely(!rq))
>                 return;
