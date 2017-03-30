Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 63E71105647D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 04:25:51 +0200 (CEST)
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-4-hch@lst.de>
	<1490726988.2573.16.camel@sandisk.com>
Date: Wed, 29 Mar 2017 22:25:33 -0400
In-Reply-To: <1490726988.2573.16.camel@sandisk.com> (Bart Van Assche's message
	of "Tue, 28 Mar 2017 18:50:01 +0000")
Message-ID: <yq1o9wj4i1u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 03/23] sd: implement REQ_OP_WRITE_ZEROES
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

Bart Van Assche <Bart.VanAssche@sandisk.com> writes:

Hi Bart,

> A quote from SBC: "An OPTIMAL UNMAP GRANULARITY field set to a
> non-zero value indicates the optimal granularity in logical blocks for
> unmap requests (e.g., an UNMAP command or a WRITE SAME (16) command
> with the UNMAP bit set to one).  An unmap request with a number of
> logical blocks that is not a multiple of this value may result in
> unmap operations on fewer LBAs than requested."

Indeed. Fewer LBAs than requested may be *unmapped*. That does not imply
that they are not *written*.

> This means that just like the start and end of a discard must be
> aligned on a discard_granularity boundary, WRITE SAME commands with
> the UNMAP bit set must also respect that granularity. I think this
> means that either __blkdev_issue_zeroout() has to be modified such
> that it rejects unaligned REQ_OP_WRITE_ZEROES operations or that
> blk_bio_write_same_split() has to be modified such that it generates
> REQ_OP_WRITEs for the unaligned start and tail.

No, that's not correct. SBC states:

"a) if the Data-Out Buffer of the WRITE SAME command is the same as the
   logical block data returned by a read operation from that LBA while
   in the unmapped state, then:

   1) the device server performs the actions described in table 6
      [unmap]; and

   2) if an unmap operation is not performed in step 1), then the device
      server shall perform the specified write operation to that LBA;"

I.e. With WRITE SAME it is the responsibility of the device server to
write any LBAs described by the command that were not successfully
unmapped.

-- 
Martin K. Petersen	Oracle Linux Engineering
