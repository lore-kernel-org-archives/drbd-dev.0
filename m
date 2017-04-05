Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 35ADD105633D
	for <drbd-dev@lists.linbit.com>; Wed,  5 Apr 2017 13:42:55 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-2-hch@lst.de>
Date: Wed, 05 Apr 2017 07:42:46 -0400
In-Reply-To: <20170331163313.31821-2-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:49 +0200")
Message-ID: <yq1r317t70p.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, lars.ellenberg@linbit.com,
	shli@kernel.org, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev]
 =?utf-8?b?W1BBVENIIDAxLzI1XSDRlWQ6IHNwbGl0IHNkX3NldHVw?=
 =?utf-8?q?=5Fdiscard=5Fcmnd?=
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

> Split sd_setup_discard_cmnd into one function per provisioning type.  While
> this creates some very slight duplication of boilerplate code it keeps the
> code modular for additions of new provisioning types, and for reusing the
> write same functions for the upcoming scsi implementation of the Write Zeroes
> operation.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Minor nit: Patch header should be "sd: ..." instead of " d: ...".

-- 
Martin K. Petersen	Oracle Linux Engineering
