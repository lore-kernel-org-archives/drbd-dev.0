Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 39AAB1011BEC
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 16:03:58 +0200 (CEST)
Date: Mon, 21 May 2018 10:03:56 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Message-ID: <20180521140348.GA19069@redhat.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-raid@vger.kernel.org,
	darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
	colyli@suse.de, linux-block@vger.kernel.org, clm@fb.com,
	neilb@suse.com, bacik@fb.com, linux-xfs@vger.kernel.org,
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

On Sun, May 20 2018 at  6:25pm -0400,
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> Jens - this series does the rest of the conversions that Christoph wanted, and
> drops bioset_create().
> 
> Only lightly tested, but the changes are pretty mechanical. Based on your
> for-next tree.

By switching 'mempool_t *' to 'mempool_t' and 'bio_set *' to 'bio_set'
you've altered the alignment of members in data structures.  So I'll
need to audit all the data structures you've modified in DM.

Could we get the backstory on _why_ you're making this change?
Would go a long way to helping me appreciate why this is a good use of
anyone's time.

Thanks,
Mike
