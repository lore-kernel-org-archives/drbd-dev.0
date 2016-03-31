Return-Path: <BATV+34c1510e3b25446cd58d+4603+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9E8771056312
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 09:52:40 +0200 (CEST)
Date: Thu, 31 Mar 2016 00:52:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160331075228.GA2491@infradead.org>
References: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
	<1459354637-17415-3-git-send-email-ming.lei@canonical.com>
	<20160330171927.GA13320@infradead.org>
	<CACVXFVNtphY8bWrdMKcR7jYn5hD=H5H6jXrY111K0kZ8jJQHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVNtphY8bWrdMKcR7jYn5hD=H5H6jXrY111K0kZ8jJQHWw@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Boaz Harrosh <boaz@plexistor.com>,
	Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v1 2/8] block: make 'struct bvec_iter' not
 depend on CONFIG_BLOCK
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

On Thu, Mar 31, 2016 at 09:02:59AM +0800, Ming Lei wrote:
> That way may cause trouble to blk_type.h because it needs bvec_iter,
> then looks not good to always include bvec_iter.h into blk_type.h.

I'd expect bvec.h to be always included in blk_types.h, and replace
the inclusion of blk_types.h in fs.h eventually.
