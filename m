Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A5856105644A
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9F9172B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7PR3clDJMcRL for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7EBEC40C046
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a37tGoxSQMiX for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 590732B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:10 +0200 (CEST)
Resent-Message-ID: <20160331085609.GJ18788@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E16C4105632B
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 03:03:01 +0200 (CEST)
Received: from mail-yw0-f180.google.com ([209.85.161.180])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1alR0m-0002T6-Eq
	for drbd-dev@lists.linbit.com; Thu, 31 Mar 2016 01:03:00 +0000
Received: by mail-yw0-f180.google.com with SMTP id h65so79856683ywe.0
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 18:03:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160330171927.GA13320@infradead.org>
References: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
	<1459354637-17415-3-git-send-email-ming.lei@canonical.com>
	<20160330171927.GA13320@infradead.org>
Date: Thu, 31 Mar 2016 09:02:59 +0800
Message-ID: <CACVXFVNtphY8bWrdMKcR7jYn5hD=H5H6jXrY111K0kZ8jJQHWw@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-block@vger.kernel.org, Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com, Jens Axboe <axboe@fb.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v1 2/8] block: make 'struct bvec_iter' not
	depend on CONFIG_BLOCK
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

On Thu, Mar 31, 2016 at 1:19 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Mar 31, 2016 at 12:17:11AM +0800, Ming Lei wrote:
>> We will use bvec iterator to implement iterate_bvec(): lib/iov_iter.c.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>>  include/linux/blk_types.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 86a38ea..fd8527b 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -26,8 +26,6 @@ struct bio_vec {
>>       unsigned int    bv_offset;
>>  };
>>
>> -#ifdef CONFIG_BLOCK
>> -
>>  struct bvec_iter {
>>       sector_t                bi_sector;      /* device address in 512 byte
>>                                                  sectors */
>> @@ -39,6 +37,8 @@ struct bvec_iter {
>>                                                  current bvec */
>>  };
>
> I didn't catch this earlier, but shouldn't this also move to
> bvec_iter.h? Or maybe just create a linux/bvec.h for the bvec, bvec_iter
> and bvec iter macros given that those are the types used outside the
> block layer as well.

That way may cause trouble to blk_type.h because it needs bvec_iter,
then looks not good to always include bvec_iter.h into blk_type.h.

Thanks,
Ming
