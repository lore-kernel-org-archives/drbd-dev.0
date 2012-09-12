Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C9878103B4C8
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C33E21B4487
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:48 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P+X9plkaWkYK for <drbd-dev@lists.linbit.com>;
	Thu, 13 Sep 2012 10:26:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id AA6581B4458
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:48 +0200 (CEST)
Resent-Message-ID: <20120913082648.GF13815@soda.linbit>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B4B921013803
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 01:53:10 +0200 (CEST)
Received: by obbun3 with SMTP id un3so6149523obb.27
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2012 16:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120912232019.GW7677@google.com>
References: <20120905100724.GA27527@soda.linbit>
	<20120906212952.GP29092@google.com>
	<20120907084221.GD7028@soda.linbit>
	<20120910225442.GE7677@google.com>
	<20120910230654.GF7677@google.com>
	<20120910233159.GE19739@google.com>
	<20120911155820.74f1f918@notabene.brown>
	<20120911082501.GH7028@soda.linbit>
	<20120912185824.GS7677@google.com>
	<CAOzFzEjCf7ZPbheq-tfhts-E=Ep1kvn0muksaaTFqJ=cMm772w@mail.gmail.com>
	<20120912232019.GW7677@google.com>
Date: Thu, 13 Sep 2012 09:53:08 +1000
Message-ID: <CAOzFzEhfoCpGCy0n5cu60xz+tSbB26g1f2ztcD1DwZOY-6aTwQ@mail.gmail.com>
From: Joseph Glanville <joseph.glanville@orionvm.com.au>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <koverstreet@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Vivek Goyal <vgoyal@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 13 September 2012 09:20, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Sep 13, 2012 at 09:12:25AM +1000, Joseph Glanville wrote:
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 4b4dbdf..68b5671 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1809,6 +1809,9 @@ EXPORT_SYMBOL(generic_make_request);
>>   * uses that function to do most of the work. Both are fairly rough
>>   * interfaces; @bio must be presetup and ready for I/O.
>>   *
>> + * Ordering of requests is not guaranteed, callers should drain the queue
>> + * and issue a flush before submission of any dependent bios.
>
> I think using "requests" here is confusing given that struct request
> means something else in the block layer.  Also, the caller doesn't

Agreed, my bad.

> have to drain the whole queue but just the ones involved in the
> dependency and flush doesn't really matter here although mentioning
> that flush too doesn't have any ordering guarantee would be nice.

Will do.
Would you prefer it being added to the top of the file describing the
semantics or the blkdev_issue_flush function itself?

> Also, updating submit_bio() comment too would be nice - something
> simple about lack of ordering and then reference to
> generic_make_request().

Will do.

>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
