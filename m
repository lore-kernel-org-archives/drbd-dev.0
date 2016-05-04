Return-Path: <jmoyer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1B016105644E
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 19:59:02 +0200 (CEST)
From: Jeff Moyer <jmoyer@redhat.com>
To: Mike Christie <mchristi@redhat.com>
References: <1460747777-8479-1-git-send-email-mchristi@redhat.com>
	<x49d1p2c1nx.fsf@segfault.boston.devel.redhat.com>
	<572A36BF.3070208@redhat.com>
Date: Wed, 04 May 2016 13:58:57 -0400
In-Reply-To: <572A36BF.3070208@redhat.com> (Mike Christie's message of "Wed, 4
	May 2016 12:51:59 -0500")
Message-ID: <x49a8k5aen2.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/42] v7: separate operations from flags in
	the bio/request structs
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

Mike Christie <mchristi@redhat.com> writes:

> On 05/03/2016 03:44 PM, Jeff Moyer wrote:
>> Hi, Mike,
>> 
>> That git tree doesn't seem to exist.  I did manage to apply your patch
>> set on top of next-20160415, though.
>> 
>> So... what testing did you do? ;-) I ran into the following problems
>
> I normally run xfstests and run it on my daily workstation and laptop. I
> did not do this for every FS this time and hit a regression.
>
> What FS were you using?

I'm using xfs, scsi disk, no blk-mq, no dm.

>> - git clone fails
>> - yum segfaults
>
> In v7/v6, I missed a new submit_bio call, so I hit issues like the two
> above. I have this fixed in the next version.

OK, does this mean you're posting another version, or you already did
and I somehow missed it?

>> - many blktrace/blkparse issues, including incorrect cpu recorded in
>>   traces, null task names, and blkparse outputting nothing for a trace
>>   file several gigabytes in size.
>
> I will double check for these issues.

Thanks.  I'll stop digging for now, then.

Cheers,
Jeff
