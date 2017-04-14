Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A5981105645E
	for <drbd-dev@lists.linbit.com>; Fri, 14 Apr 2017 04:23:24 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170412084809.8245-1-hch@lst.de>
Date: Thu, 13 Apr 2017 22:23:10 -0400
In-Reply-To: <20170412084809.8245-1-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 12 Apr 2017 10:48:01 +0200")
Message-ID: <yq1mvbjwwvl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove REQ_OP_WRITE_SAME
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


Christoph,

> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> have two callers left, and both just export optional protocol features
> to remote systems: DRBD and the target code.

While I'm not particularly married to WRITE SAME, I do think it's a
shame that the RAID5/6 code never started using it. It does make a
difference when initializing RAID sets.

The other thing that keeps me a bit on the fence is that a bunch of the
plumbing to handle a bio with a payload different from bi_size is needed
for the copy offload token. I'm hoping to have those patches ready for
4.13. Right now there are a bunch of places where handling of
REQ_OP_COPY_IN and REQ_OP_COPY_OUT share conditionals with WRITE SAME.

So I suggest postponing the decision about whether to rip out WRITE SAME
until I finish the token stuff.

-- 
Martin K. Petersen	Oracle Linux Engineering
