Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 047AD105647D
	for <drbd-dev@lists.linbit.com>; Wed,  5 Apr 2017 13:49:00 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-15-hch@lst.de>
Date: Wed, 05 Apr 2017 07:48:51 -0400
In-Reply-To: <20170331163313.31821-15-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:02 +0200")
Message-ID: <yq1o9wbrs64.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, lars.ellenberg@linbit.com,
	shli@kernel.org, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 14/25] sd: implement unmapping Write Zeroes
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Christoph Hellwig <hch@lst.de> writes:

> Try to use a write same with unmap bit variant if the device supports it
> and the caller allows for it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
