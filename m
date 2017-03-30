Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 86D46105633D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 17:20:19 +0200 (CEST)
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
	<20170330134957.GA508@redhat.com>
Date: Thu, 30 Mar 2017 11:20:09 -0400
In-Reply-To: <20170330134957.GA508@redhat.com> (Mike Snitzer's message of
	"Thu, 30 Mar 2017 09:49:57 -0400")
Message-ID: <yq1pogy3i6u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	shli@kernel.org, Christoph Hellwig <hch@lst.de>, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
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

> I can work on this now.  Only question I have is: should DM thinp take
> care to zero any misaligned head and tail?  (I assume so but with all
> the back and forth between Bart, Paolo and Martin I figured I'd ask
> explicitly).

Yep, let's make sure our semantics match the hardware ditto.

 - So write zeroes should behave deterministically and explicitly handle
   any blocks that can't be cleared via deprovisioning.

 - And discard can work at the discard granularity in a
   non-deterministic fashion.

-- 
Martin K. Petersen	Oracle Linux Engineering
