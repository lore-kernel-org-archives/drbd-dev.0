Return-Path: <BATV+6e156d946156a2f7d1de+5924+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2FC7B420381
	for <drbd-dev@lists.linbit.com>; Tue, 12 Nov 2019 16:10:14 +0100 (CET)
Date: Tue, 12 Nov 2019 06:50:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: jgq516@gmail.com
Message-ID: <20191112145043.GA31295@infradead.org>
References: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
Cc: axboe@kernel.dk, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH] block: move rb interval tree from drbd
	to block
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

On Tue, Nov 12, 2019 at 10:01:39AM +0100, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Currently, drbd has the implementation of rb interval tree.
> And we would like to reuse it for raid1 io serialization [1],
> so move it to a common place, rename to block_interval, export
> those symbols and make necessary changes to drbd.

This should not be built unconditonally, but be selected by the two
users.  And lib/ seems like a better place than block.

Also please fix up any > 80 char lines that your naming changes
introduce.
