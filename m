Return-Path: <BATV+2e11e6930e970eb8572e+8229+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E17BB16095C
	for <drbd-dev@lists.linbit.com>; Thu,  5 Mar 2026 15:14:51 +0100 (CET)
Date: Thu, 5 Mar 2026 06:14:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 4/4] bio: use bio_io_error more often
Message-ID: <aamP2qNKEmiyXQQH@infradead.org>
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304190424.291743-5-agruenba@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

On Wed, Mar 04, 2026 at 08:04:09PM +0100, Andreas Gruenbacher wrote:
> Instead of setting bio->bi_status to BLK_STS_IOERR and calling
> bio_endio(bio), use the shorthand bio_io_error(bio).

I'm a little torn how good these helpers actually are, as
hard coding one specific type of error seems to create weird
code and lead to bugs like the xfs one you fixed yesterday.

Maybe we just need a bio_endio_status() that allows passing the
satatus?

Also you really need to send one patch per subsystem.

