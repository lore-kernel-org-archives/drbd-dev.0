Return-Path: <martin.petersen@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EDBB44205EC
	for <drbd-dev@lists.linbit.com>; Sun, 20 Feb 2022 00:35:00 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1k0dqfn3t.fsf@ca-mkp.ca.oracle.com>
References: <20220209082828.2629273-1-hch@lst.de>
Date: Sat, 19 Feb 2022 18:33:36 -0500
In-Reply-To: <20220209082828.2629273-1-hch@lst.de> (Christoph Hellwig's
	message of "Wed, 9 Feb 2022 09:28:21 +0100")
Content-Type: text/plain
MIME-Version: 1.0
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, haris.iqbal@ionos.com,
	ukrishn@linux.ibm.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, jinpu.wang@ionos.com, mrochs@linux.ibm.com
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

> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> have two callers left, and both just export optional protocol features
> to remote systems: DRBD and the target code.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
