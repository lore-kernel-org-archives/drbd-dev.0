Return-Path: <martin.petersen@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC64642177B
	for <drbd-dev@lists.linbit.com>; Fri, 18 Feb 2022 06:41:20 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1r180iyu8.fsf@ca-mkp.ca.oracle.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com> <20220210055151.GA3491@lst.de>
	<2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
	<20220217064349.GA374@lst.de>
Date: Thu, 17 Feb 2022 23:27:56 -0500
In-Reply-To: <20220217064349.GA374@lst.de> (Christoph Hellwig's message of
	"Thu, 17 Feb 2022 07:43:49 +0100")
Content-Type: text/plain
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, manoj@linux.ibm.com,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, ukrishn@linux.ibm.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	jinpu.wang@ionos.com, mrochs@linux.ibm.com
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


Christoph,

> There is a minor conflict because the __blkdev_issue_write_same
> function removed by this series is affected by the blk_next_bio calling
> convention change in the block tree, but the fixup is trivial.
>
> Martin: do you want to fix that up when applying, or do you want me
> to resend?  If you have your discard rework ready you can also send
> that now and I'll rebase on top of that.

I'll fix it up when applying. Will get this queued up tomorrow.

-- 
Martin K. Petersen	Oracle Linux Engineering
