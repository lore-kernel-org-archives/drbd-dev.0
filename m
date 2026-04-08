Return-Path: <BATV+4d4f7abe5776451c4d8a+8263+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2756316312D
	for <drbd-dev@lists.linbit.com>; Wed,  8 Apr 2026 07:46:27 +0200 (CEST)
Date: Tue, 7 Apr 2026 22:46:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 08/20] drbd: add DAX/PMEM support for metadata access
Message-ID: <adXrslkhromDtu37@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<20260327223820.2244227-9-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-9-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, nvdimm@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	an Williams <dan.j.williams@intel.com>, drbd-dev@lists.linbit.com
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

Adding the dax maintainers and they really need to review this.

> +	long want = (drbd_md_last_sector(bdev) + 1 - first_sector) >> (PAGE_SHIFT - SECTOR_SHIFT);
> +	pgoff_t pgoff = first_sector >> (PAGE_SHIFT - SECTOR_SHIFT);
> +	long md_offset_byte = (bdev->md.md_offset - first_sector) << SECTOR_SHIFT;
> +	long al_offset_byte = (al_sector - first_sector) << SECTOR_SHIFT;

You really want helpers to make all these unit conversions maintainable.

