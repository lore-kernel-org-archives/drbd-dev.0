Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B2DA81057FFA
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:03:20 +0100 (CET)
Date: Thu, 23 Mar 2017 15:56:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20170323145651.GA31771@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-7-hch@lst.de>
	<20170323145522.GB17127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323145522.GB17127@redhat.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/23] dm-kcopyd: switch to use
	REQ_OP_WRITE_ZEROES
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

On Thu, Mar 23, 2017 at 10:55:22AM -0400, Mike Snitzer wrote:
> See commit 70d6c400a ("dm kcopyd: add WRITE SAME support to dm_kcopyd_zero")
> drivers/md/dm-io.c:do_region() adjusts the WRITE SAME payload to be a
> single page.
> 
> So you'd want to tweak dm-io.c accordingly for WRITE ZEROES (presummably
> no payload?)

Yeah, I'll look into it.  Any good test case for verifying this code
while I've got your attention?
