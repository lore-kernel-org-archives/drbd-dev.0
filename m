Return-Path: <oliver.sang@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 47CE24200BE
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jun 2024 04:36:01 +0200 (CEST)
Date: Thu, 27 Jun 2024 10:35:38 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [axboe-block:for-next] [block]  1122c0c1cc:  aim7.jobs-per-min
	22.6% improvement
Message-ID: <ZnzP+nUrk8+9bANK@xsang-OptiPlex-9020>
References: <202406250948.e0044f1d-oliver.sang@intel.com>
	<ZnqGf49cvy6W-xWf@infradead.org>
	<Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
	<ZnuNhkH26nZi8fz6@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnuNhkH26nZi8fz6@infradead.org>
MIME-Version: 1.0
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	feng.tang@intel.com, linux-nvme@lists.infradead.org,
	linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com, lkp@intel.com,
	linux-scsi@vger.kernel.org, ying.huang@intel.com,
	xen-devel@lists.xenproject.org, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	nbd@other.debian.org, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, Damien
	Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, fengwei.yin@intel.com,
	oliver.sang@intel.com, oe-lkp@lists.linux.dev,
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

hi, Christoph Hellwig,

On Tue, Jun 25, 2024 at 08:39:50PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 26, 2024 at 10:10:49AM +0800, Oliver Sang wrote:
> > I'm not sure I understand this test request. as in title, we see a good
> > improvement of aim7 for 1122c0c1cc, and we didn't observe other issues for
> > this commit.
> 
> The improvement suggests we are not sending cache flushes when we should
> send them, or at least just handle them in md.

thanks for explanation!

> 
> > do you mean this improvement is not expected or exposes some problems instead?
> > then by below patch, should the performance back to the level of parent of
> > 1122c0c1cc?
> > 
> > sure! it's our great pleasure to test your patches. I noticed there are
> > [1]
> > https://lore.kernel.org/all/20240625110603.50885-2-hch@lst.de/
> > which includes "[PATCH 1/7] md: set md-specific flags for all queue limits"
> > [2]
> > https://lore.kernel.org/all/20240625145955.115252-2-hch@lst.de/
> > which includes "[PATCH 1/8] md: set md-specific flags for all queue limits"
> > 
> > which one you suggest us to test?
> > do we only need to apply the first patch "md: set md-specific flags for all queue limits"
> > upon 1122c0c1cc?
> > then is the expectation the performance back to parent of 1122c0c1cc?
> 
> Either just the patch in reply or the entire [2] series would be fine.

I failed to apply patch in your previous reply to 1122c0c1cc or current tip
of axboe-block/for-next:
c1440ed442a58 (axboe-block/for-next) Merge branch 'for-6.11/block' into for-next

but it's ok to apply upon next:
* 0fc4bfab2cd45 (tag: next-20240625) Add linux-next specific files for 20240625

I've already started the test based on this applyment.
is the expectation that patch should not introduce performance change comparing
to 0fc4bfab2cd45?

or if this applyment is not ok, please just give me guidance. Thanks!


> 
> Thanks!
> 
