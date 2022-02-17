Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BD31D4202E4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Feb 2022 07:43:52 +0100 (CET)
Date: Thu, 17 Feb 2022 07:43:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20220217064349.GA374@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
	<yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com>
	<20220210055151.GA3491@lst.de>
	<2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
Cc: manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, ukrishn@linux.ibm.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	jinpu.wang@ionos.com, Christoph Hellwig <hch@lst.de>, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] remove REQ_OP_WRITE_SAME v2
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

On Wed, Feb 16, 2022 at 08:07:56PM -0700, Jens Axboe wrote:
> Let's just use the SCSI tree - I didn't check if it throws any conflicts
> right now, so probably something to check upfront...

There is a minor conflict because the __blkdev_issue_write_same
function removed by this series is affected by the blk_next_bio calling
convention change in the block tree, but the fixup is trivial.

Martin: do you want to fix that up when applying, or do you want me
to resend?  If you have your discard rework ready you can also send
that now and I'll rebase on top of that.
