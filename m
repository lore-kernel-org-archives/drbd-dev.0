Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CEAB8105633D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 17:22:29 +0200 (CEST)
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170330151257.GA910@redhat.com>
Date: Thu, 30 Mar 2017 11:22:21 -0400
In-Reply-To: <20170330151257.GA910@redhat.com> (Mike Snitzer's message of
	"Thu, 30 Mar 2017 11:12:58 -0400")
Message-ID: <yq1lgrm3i36.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
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

Mike Snitzer <snitzer@redhat.com> writes:

> Would be very useful, particularly for testing, if
> drivers/scsi/scsi_debug.c were updated to support WRITE ZEROES.

There is no WRITE ZEROES in SCSI. You should be able to get the right
behavior with lbpws=1 lbprz=1.

-- 
Martin K. Petersen	Oracle Linux Engineering
