Return-Path: <dlemoal@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E2CA4205A9
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 10:06:36 +0200 (CEST)
Message-ID: <0f01ed9c-6f85-427c-9690-1551e67e46a9@kernel.org>
Date: Tue, 11 Jun 2024 17:06:29 +0900
MIME-Version: 1.0
Subject: Re: [PATCH 15/26] block: move the add_random flag to queue_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20240611051929.513387-1-hch@lst.de>
	<20240611051929.513387-16-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240611051929.513387-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> Move the add_random flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.

Same remark as the previous patches for the end of this sentence.c

> 
> Note that this also removes code from dm to clear the flag based on
> the underlying devices, which can't be reached as dm devices will
> always start out without the flag set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

