Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CB69942021F
	for <drbd-dev@lists.linbit.com>; Tue, 27 Feb 2024 15:43:59 +0100 (CET)
Date: Tue, 27 Feb 2024 15:36:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH 04/16] md: add queue limit helpers
Message-ID: <20240227143618.GA13570@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
	<20240226103004.281412-5-hch@lst.de>
	<6eb1741e-f336-bfb1-6549-21374ee667fc@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb1741e-f336-bfb1-6549-21374ee667fc@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, "yukuai \(C\)" <yukuai3@huawei.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
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

On Mon, Feb 26, 2024 at 07:38:17PM +0800, Yu Kuai wrote:
> Any reason to use blk_mq_freeze/unfreeze_queue ? I don't think this is
> meaningful for raid, this only wait for IO submission, not IO done.
>
> raid should already handle concurrent IO with reshape, so I think this
> can just be removed.

We can't just change limits under the driver if I/Os are being sumitted.
That is one of the points of the whole queue limits exercises.

