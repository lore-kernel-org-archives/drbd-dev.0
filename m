Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 881CB1057FE2
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 11:39:15 +0200 (CEST)
Received: by mail-wr0-f179.google.com with SMTP id w43so52221185wrb.0
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 02:39:15 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id q4sm2499034wme.17.2017.03.30.02.33.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 Mar 2017 02:33:51 -0700 (PDT)
Resent-Message-ID: <20170330093350.GH5939@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 32D66105633D
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2017 18:53:24 +0200 (CEST)
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@kernel.org" <shli@kernel.org>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-4-hch@lst.de>
	<1490726988.2573.16.camel@sandisk.com>
	<e19ca1bf-0908-1eb0-cb04-cd306692f216@redhat.com>
	<1490804856.3551.3.camel@sandisk.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcb3c0d2-f043-ac84-30b7-d1d7afb3d63e@redhat.com>
Date: Wed, 29 Mar 2017 18:53:17 +0200
MIME-Version: 1.0
In-Reply-To: <1490804856.3551.3.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
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



On 29/03/2017 18:28, Bart Van Assche wrote:
> On Wed, 2017-03-29 at 16:51 +0200, Paolo Bonzini wrote:
>> On 28/03/2017 20:50, Bart Van Assche wrote:
>>> This means that just like the start and end of a discard must be aligned on a
>>> discard_granularity boundary, WRITE SAME commands with the UNMAP bit set must
>>> also respect that granularity. I think this means that either
>>> __blkdev_issue_zeroout() has to be modified such that it rejects unaligned
>>> REQ_OP_WRITE_ZEROES operations or that blk_bio_write_same_split() has to be
>>> modified such that it generates REQ_OP_WRITEs for the unaligned start and tail.
>>
>> I don't think this is the case.
> 
> Hello Paolo,
> 
> Can you cite the section(s) from the SCSI specs that support your view? I
> reread the "5.49 WRITE SAME (10) command" and "4.7.3.4.4 WRITE SAME command
> and unmap operations" sections but I have not found any explicit statement
> that specifies the behavior for unaligned WRITE SAME commands with the UNMAP
> bit set. It seems to me like the OPTIMAL UNMAP GRANULARITY parameter was
> overlooked when both sections were written. Should we ask the T10 committee
> for a clarification?

From 4.7.3.4.4:

------
If unmap operations are requested in a WRITE SAME command,
then for each specified LBA:

if the Data-Out Buffer of the WRITE SAME command is the same as the
logical block data returned by a read operation from that LBA while in
the unmapped state (see 4.7.4.5), then:

1) the device server performs the actions described in table 6; and

2) if an unmap operation is not performed in step 1), then the device
server shall perform the specified write operation to that LBA;
------

and from the description of WRITE SAME (10): "subsequent read operations
behave as if the device server wrote the single block of user data
received from the Data-Out Buffer to each logical block without
modification" (I have a slightly older copy though, it's 5.45 here).

It's pretty unambiguous that if the device cannot unmap (including the
case where the request is misaligned with respect to the granularity) it
does a write.

> Another question is, if the specification of WRITE SAME + UNMAP would be
> made unambiguous in the SBC document, whether or not we should take the risk
> to trigger behavior that is not what we expect by sending unaligned WRITE
> SAME + UNMAP commands to SCSI devices?

Yes, I think we should.

Paolo
