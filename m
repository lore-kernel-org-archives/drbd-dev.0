Return-Path: <BATV+5644fb066b1a2f5da0f7+6801+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 404CD421014
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 08:15:18 +0200 (CEST)
Date: Wed, 6 Apr 2022 23:15:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <Yk6Bc7lvjCsmlkoq@infradead.org>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
	<20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/3] drbd: set QUEUE_FLAG_STABLE_WRITES
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

On Wed, Apr 06, 2022 at 09:04:45PM +0200, Christoph Böhmwalder wrote:
> From: Christoph Böhmwalder <christoph@boehmwalder.at>
> 
> We want our pages not to change while they are being written.

Please document the _why_.  A commit like that will leave everyone
looking at this code in the future rather puzzled.
