Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 34F49105647D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 11:33:22 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id k6so46132033wre.2
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 02:33:22 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	m14sm2043107wrb.22.2017.03.30.02.33.21
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 Mar 2017 02:33:21 -0700 (PDT)
Resent-Message-ID: <20170330093321.GF5939@soda.linbit>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
	[209.85.128.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 511271057FBA
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2017 16:58:30 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id k6so2475714wre.3
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2017 07:58:30 -0700 (PDT)
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e19ca1bf-0908-1eb0-cb04-cd306692f216@redhat.com>
Date: Wed, 29 Mar 2017 16:51:50 +0200
MIME-Version: 1.0
In-Reply-To: <1490726988.2573.16.camel@sandisk.com>
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



On 28/03/2017 20:50, Bart Van Assche wrote:
> 
> This means that just like the start and end of a discard must be aligned on a
> discard_granularity boundary, WRITE SAME commands with the UNMAP bit set must
> also respect that granularity. I think this means that either
> __blkdev_issue_zeroout() has to be modified such that it rejects unaligned
> REQ_OP_WRITE_ZEROES operations or that blk_bio_write_same_split() has to be
> modified such that it generates REQ_OP_WRITEs for the unaligned start and tail.

I don't think this is the case.

Rather, Linux should try to align the WRITE SAME commands to the optimal
unmap granularity if the zeroed area requires performing more than one
WRITE SAME command (i.e. > maximum write same length or too large to fit
in the CDB).  However, even in that case it can use WRITE SAME with
UNMAP for the unaligned start and tail.  Unlike the UNMAP command, the
SCSI standard does guarantee that zeroes are written in the unaligned parts.

Paolo
