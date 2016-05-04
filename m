Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1DBD1056457
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B9E2E3EFDEF
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7S5DzRG6bDgo for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 97D173EFD4A
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bpqgz67JLv0P for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:24 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6CBEE3EFD03
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:24 +0200 (CEST)
Resent-Message-ID: <20160506084124.GU16459@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3F793105644E
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 19:52:05 +0200 (CEST)
To: Jeff Moyer <jmoyer@redhat.com>
References: <1460747777-8479-1-git-send-email-mchristi@redhat.com>
	<x49d1p2c1nx.fsf@segfault.boston.devel.redhat.com>
From: Mike Christie <mchristi@redhat.com>
Message-ID: <572A36BF.3070208@redhat.com>
Date: Wed, 4 May 2016 12:51:59 -0500
MIME-Version: 1.0
In-Reply-To: <x49d1p2c1nx.fsf@segfault.boston.devel.redhat.com>
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

On 05/03/2016 03:44 PM, Jeff Moyer wrote:
> mchristi@redhat.com writes:
> 
>> The following patches begin to cleanup the request->cmd_flags and
>> bio->bi_rw mess. We currently use cmd_flags to specify the operation,
>> attributes and state of the request. For bi_rw we use it for similar
>> info and also the priority but then also have another bi_flags field
>> for state. At some point, we abused them so much we just made cmd_flags
>> 64 bits, so we could add more.
>>
>> The following patches seperate the operation (read, write discard,
>> flush, etc) from cmd_flags/bi_rw.
>>
>> This patchset was made against linux-next from today April 15
>> (git tag next-20160415).
>>
>> I put a git tree here:
>> https://github.com/mikechristie/linux-kernel.git
>> The patches are in the op branch.
> 
> Hi, Mike,
> 
> That git tree doesn't seem to exist.  I did manage to apply your patch
> set on top of next-20160415, though.
> 
> So... what testing did you do? ;-) I ran into the following problems

I normally run xfstests and run it on my daily workstation and laptop. I
did not do this for every FS this time and hit a regression.

What FS were you using?

> - git clone fails
> - yum segfaults


In v7/v6, I missed a new submit_bio call, so I hit issues like the two
above. I have this fixed in the next version.

> - many blktrace/blkparse issues, including incorrect cpu recorded in
>   traces, null task names, and blkparse outputting nothing for a trace
>   file several gigabytes in size.

I will double check for these issues.
