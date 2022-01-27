Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5C45D42A583
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 20:58:37 +0100 (CET)
Date: Thu, 27 Jan 2022 20:58:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20220127195834.GA25235@lst.de>
References: <20220127063546.1314111-1-hch@lst.de> <YfLN4/2bYe4hebCy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfLN4/2bYe4hebCy@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] improve the bio cloning interface
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 27, 2022 at 11:52:51AM -0500, Mike Snitzer wrote:
> I'd like to take a closer look, do you happen to have this series
> available in a git branch?

git://git.infradead.org/users/hch/block.git bio_alloc-cleanup-part2

> 
> The changes generally look fine.  Any chance you could forecast what
> you're planning for follow-on changes?

Mostly cleaning up a bunch of submitter code that needs more work to
get at the bdev and op, and trying to figure out what to do about
bio_kmalloc.

> Or is it best to just wait for you to produce those follow-on changes?

There should be no follow ons required to make sense of this series.
