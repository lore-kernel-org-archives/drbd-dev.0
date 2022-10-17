Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 21F414203B4
	for <drbd-dev@lists.linbit.com>; Mon, 17 Oct 2022 08:16:10 +0200 (CEST)
Date: Mon, 17 Oct 2022 08:09:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <20221017060951.GA28409@lst.de>
References: <20221013135352.933875-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013135352.933875-1-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: only clone bio if we have a backing
	device
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

On Thu, Oct 13, 2022 at 03:53:52PM +0200, Christoph Böhmwalder wrote:
> +	if (get_ldev(device)) {
> +		req->private_bio = bio_alloc_clone(device->ldev->backing_bdev,
> +						   bio, GFP_NOIO, &drbd_io_bio_set);

This adds an overly long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
