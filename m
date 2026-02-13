Return-Path: <BATV+9b0b50a7e52011b5873e+8209+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C84C216094D
	for <drbd-dev@lists.linbit.com>; Fri, 13 Feb 2026 07:05:55 +0100 (CET)
Date: Thu, 12 Feb 2026 22:05:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-ID: <aY6_Qg3gPKBPdttw@infradead.org>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
	<aYWNhtixUGuj3hat@infradead.org>
	<eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
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

On Thu, Feb 12, 2026 at 04:01:43PM +0100, Christoph Böhmwalder wrote:
> The current block layer logic actually seems correct to me. The
> underlying device may or may not require stable writes, but regardless
> of that, DRBD itself definitely does need it. In blk_stack_limits, DRBD
> is the top device, and DRBD's backing disk is the bottom device. If the
> backing disk happens to require stable writes, this would indeed be
> correctly inherited.
> 
> So the only missing logic is that DRBD still wants to enable stable
> writes for itself even if the backing disk does *not* request it.
> So it seems to me that this patch is the correct fix for DRBD's special
> case.
> 
> Is it not supposed to work like that?

No, I guess I just misunderstood your report.

