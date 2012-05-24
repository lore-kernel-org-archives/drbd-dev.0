Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C0C991019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B03C01B4268
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:45 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRimoVynTHdV for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:03:45 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 92DE51B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:45 +0200 (CEST)
Resent-Message-ID: <20120525070345.GD12726@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C1E81017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 20:07:03 +0200 (CEST)
Message-ID: <4FBE78A2.8000803@panasas.com>
Date: Thu, 24 May 2012 21:06:26 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-2-git-send-email-koverstreet@google.com>
	<20120524174649.GC27550@redhat.com>
In-Reply-To: <20120524174649.GC27550@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	yehuda@hq.newdream.net, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 01/14] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 05/24/2012 08:46 PM, Vivek Goyal wrote:

> On Wed, May 23, 2012 at 05:02:38PM -0700, Kent Overstreet wrote:
>> With the old code, when you allocate a bio from a bio pool you have to
>> implement your own destructor that knows how to find the bio pool the
>> bio was originally allocated from.
>>
>> This adds a new field to struct bio (bi_pool) and changes
>> bio_alloc_bioset() to use it. This makes various bio destructors
>> unnecessary, so they're then deleted.
>>
> 
> [..]
>> @@ -419,7 +406,11 @@ void bio_put(struct bio *bio)
>>  	 */
>>  	if (atomic_dec_and_test(&bio->bi_cnt)) {
>>  		bio->bi_next = NULL;
>> -		bio->bi_destructor(bio);
>> +
>> +		if (bio->bi_pool)
>> +			bio_free(bio, bio->bi_pool);
>> +		else
>> +			bio->bi_destructor(bio);
> 
> If you have removed all the users of bi_destructor, then I am wondering that
> why are we retaining this field and trying to call into it when bio_pool
> is not set?
> 


At this point there are still some users they are all removed and this field
later in the patchset

Boaz

> Thanks
> Vivek
> 


