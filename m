Return-Path: <BATV+2e11e6930e970eb8572e+8229+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 487B016095C
	for <drbd-dev@lists.linbit.com>; Thu,  5 Mar 2026 15:13:34 +0100 (CET)
Date: Thu, 5 Mar 2026 06:13:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 2/4] block: get rid of blk_status_to_{errno,str}
	inconsistency
Message-ID: <aamPjXeF0qHlhJZu@infradead.org>
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304190424.291743-3-agruenba@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On Wed, Mar 04, 2026 at 08:04:07PM +0100, Andreas Gruenbacher wrote:
> Change blk_status_to_str() to be consistent with blk_status_to_errno()
> and return "I/O" for undefined status codes.
> 
> With that, the fallback case in the blk_errors array can be removed with
> no change in behavior.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

While you're at it: blk_status_to_str is exported, but as no modular
users, can you also drop the export?

