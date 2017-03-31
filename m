Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 507CE105645E
	for <drbd-dev@lists.linbit.com>; Fri, 31 Mar 2017 04:34:25 +0200 (CEST)
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
	<20170330134957.GA508@redhat.com> <yq1pogy3i6u.fsf@oracle.com>
	<20170330231550.GA3102@redhat.com>
Date: Thu, 30 Mar 2017 22:34:05 -0400
In-Reply-To: <20170330231550.GA3102@redhat.com> (Mike Snitzer's message of
	"Thu, 30 Mar 2017 19:15:50 -0400")
Message-ID: <yq137duyy1u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
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

Mike,

> But while discussing this effort with Jeff Moyer he asked: shouldn't the
> zeroed blocks be provisioned?  This is a fairly embarassing question not
> to be able to answer in the moment.  So I clearly need to learn what the
> overall intent of WRITE_ZEROES actually is.

The intent is to guarantee all future reads to these blocks will return
zeroes. Whether to allocate or deallocate or do a combination to achieve
that goal is up to the device.

> If it is meant as a replacement for WRITE_SAME (as hch switched dm-io
> over from WRITE_SAME with a payload of 0 to WRITE_ZEROES) and for the
> backing mechanism for blkdev_issue_zeroout() then I guess I have my
> answer.

Yes. I was hoping MD would use WRITE SAME to initialize data and parity
drives. That's why I went with SAME nomenclature rather than ZEROES
(which had just appeared in NVMe at that time).

Christoph's renaming is mostly to emphasize the purpose and the
semantics. People keep getting confused because both REQ_DISCARD and
REQ_WRITE_SAME use the WRITE SAME SCSI command. But the two uses are
completely orthogonal and governed by different heuristics in sd.c.

> Unless DM thinp can guarantee that the discarded blocks will
> always return zeroes (by zeroing before all partial block writes) my
> discard based dm-thinp implementation of WRITE_ZEROES is a complete
> throw-away (unless block zeroing is enabled.. which it never is because
> performance sucks with it).  So if an upper-level of the IO stack
> (e.g. ext4) were to assume that a block will _definitely_ have zeroes
> then DM thinp would fall short.

You don't have a way to mark those blocks as being full of zeroes
without actually writing them?

Note that the fallback to a zeroout command is to do a regular write. So
if DM doesn't zero the blocks, the block layer is going to it.

-- 
Martin K. Petersen	Oracle Linux Engineering
