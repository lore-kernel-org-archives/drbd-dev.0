Return-Path: <BATV+711829e0f1fcce1ea722+8202+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F8191608F3
	for <drbd-dev@lists.linbit.com>; Fri,  6 Feb 2026 08:18:25 +0100 (CET)
Date: Thu, 5 Feb 2026 22:43:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-ID: <aYWNhtixUGuj3hat@infradead.org>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

On Thu, Feb 05, 2026 at 06:39:29PM +0100, Christoph Böhmwalder wrote:
> DRBD requires stable pages because it may read the same bio data
> multiple times for local disk I/O and network transmission, and in
> some cases for calculating checksums.
> 
> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
> created, but blk_set_stacking_limits() clears it whenever a
> backing device is attached. In some cases the flag may be
> inherited from the backing device, but we want it to be enabled
> at all times.

This looks like a bug.  If an underlying device requires
BLK_FEAT_STABLE_WRITES, the upper device needs to inherit it.

> Note: this commit is based on the for-6.19/block tree in case it is
> still possible to take it into the 6.19 release as this *could* lead
> to silent data corruption. However, due to other protection
> mechanisms in DRBD, this is relatively unlikely to happen in the
> real world and we have not seen any corresponding reports from users.
> So if this only lands in 6.20/7.0, it is also fine.

I'm fine with this as a hot fix for 6.19 and -stable:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can you please also do the proper block layer fix and then
revert the drbd one?

