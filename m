Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 27F8F1056314
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 14FA3360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:25 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ub5rbIoUeVCj for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E99FF364770
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:24 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QZ9SBMgWTIPI for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:24 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BFC97360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:24 +0100 (CET)
Resent-Message-ID: <20160112100924.GA3313@soda.linbit>
Received: from sabe.cs.wisc.edu (sabe.cs.wisc.edu [128.105.6.20])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4DD311056308
	for <drbd-dev@lists.linbit.com>; Sun, 10 Jan 2016 01:44:42 +0100 (CET)
Message-ID: <5691A934.8020000@cs.wisc.edu>
Date: Sat, 09 Jan 2016 18:43:32 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, mchristi@redhat.com
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-2-git-send-email-mchristi@redhat.com>
	<20160109133409.GA26660@infradead.org>
In-Reply-To: <20160109133409.GA26660@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/35] block/fs/drivers: remove rw argument
	from submit_bio
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

On 01/09/2016 07:34 AM, Christoph Hellwig wrote:
>>  				count);
>> > diff --git a/block/blk-flush.c b/block/blk-flush.c
>> > index 9c423e5..e092e13 100644
>> > --- a/block/blk-flush.c
>> > +++ b/block/blk-flush.c
>> > @@ -484,8 +484,9 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
>> >  
>> >  	bio = bio_alloc(gfp_mask, 0);
>> >  	bio->bi_bdev = bdev;
>> > +	bio->bi_rw |= WRITE_FLUSH;
> Shouldn't the |= be a = here and in many other places?

Yeah, I was trying to merge bi_rw and bio_flags. I am not going to send
that. I will fix up the patchset.
