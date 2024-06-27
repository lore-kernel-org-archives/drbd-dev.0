Return-Path: <BATV+b68173646e9cfe1398de+7613+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AEC314200BE
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jun 2024 06:54:13 +0200 (CEST)
Date: Wed, 26 Jun 2024 21:54:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Sang <oliver.sang@intel.com>
Subject: Re: [axboe-block:for-next] [block]  1122c0c1cc:  aim7.jobs-per-min
	22.6% improvement
Message-ID: <ZnzwbYSaIlT0SIEy@infradead.org>
References: <202406250948.e0044f1d-oliver.sang@intel.com>
	<ZnqGf49cvy6W-xWf@infradead.org>
	<Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
	<ZnuNhkH26nZi8fz6@infradead.org>
	<ZnzP+nUrk8+9bANK@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnzP+nUrk8+9bANK@xsang-OptiPlex-9020>
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	feng.tang@intel.com, linux-nvme@lists.infradead.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	lkp@intel.com, linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, ying.huang@intel.com,
	xen-devel@lists.xenproject.org, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	nbd@other.debian.org, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	fengwei.yin@intel.com, oe-lkp@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
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

On Thu, Jun 27, 2024 at 10:35:38AM +0800, Oliver Sang wrote:
> 
> I failed to apply patch in your previous reply to 1122c0c1cc or current tip
> of axboe-block/for-next:
> c1440ed442a58 (axboe-block/for-next) Merge branch 'for-6.11/block' into for-next

That already includes it.

> 
> but it's ok to apply upon next:
> * 0fc4bfab2cd45 (tag: next-20240625) Add linux-next specific files for 20240625
> 
> I've already started the test based on this applyment.
> is the expectation that patch should not introduce performance change comparing
> to 0fc4bfab2cd45?
> 
> or if this applyment is not ok, please just give me guidance. Thanks!

The expectation is that the latest block branch (and thus linux-next)
doesn't see this performance change.

