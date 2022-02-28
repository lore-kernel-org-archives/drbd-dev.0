Return-Path: <martin.petersen@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B28B4201F2
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 04:43:35 +0100 (CET)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: mrochs@linux.ibm.com, ukrishn@linux.ibm.com, target-devel@vger.kernel.org,
	manoj@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com
Date: Sun, 27 Feb 2022 22:43:19 -0500
Message-Id: <164601967778.4503.10049578815707749914.b4-ty@oracle.com>
In-Reply-To: <20220209082828.2629273-1-hch@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	drbd-dev@lists.linbit.com
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

On Wed, 9 Feb 2022 09:28:21 +0100, Christoph Hellwig wrote:

> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> have two callers left, and both just export optional protocol features
> to remote systems: DRBD and the target code.
> 
> For the target code the only real use case was zeroing offload, which
> is kept with this series, and for DRBD I suspect the same based on the
> usage.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/7] cxlflash: query write_zeroes limit for zeroing
      https://git.kernel.org/mkp/scsi/c/898cd34607eb
[2/7] drbd: drop REQ_OP_WRITE_SAME support
      https://git.kernel.org/mkp/scsi/c/a34592ff6b78
[3/7] rnbd: drop WRITE_SAME support
      https://git.kernel.org/mkp/scsi/c/ebd04737637b
[4/7] sd: remove write same support
      https://git.kernel.org/mkp/scsi/c/e383e16e84e9
[5/7] md: drop WRITE_SAME support
      https://git.kernel.org/mkp/scsi/c/10fa225c33a9
[6/7] dm: remove write same support
      https://git.kernel.org/mkp/scsi/c/a773187e37fa
[7/7] block: remove REQ_OP_WRITE_SAME support
      https://git.kernel.org/mkp/scsi/c/73bd66d9c834

-- 
Martin K. Petersen	Oracle Linux Engineering
