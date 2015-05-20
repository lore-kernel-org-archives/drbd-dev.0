Return-Path: <mlin@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F2951050592
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 22:18:29 +0200 (CEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0704E203F7
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 20:18:27 +0000 (UTC)
Received: from mail-vn0-f51.google.com (mail-vn0-f51.google.com
	[209.85.216.51])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 33895203ED
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 20:18:23 +0000 (UTC)
Received: by vnbf190 with SMTP id f190so4494775vnb.0
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 13:18:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <x49k2w3oz32.fsf@segfault.boston.devel.redhat.com>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
	<x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
	<CAF1ivSbdbvnCi04oR9h4sqnMcLFNXfOo-8=_2qFVkzNYmnmELQ@mail.gmail.com>
	<x49k2w3oz32.fsf@segfault.boston.devel.redhat.com>
Date: Wed, 20 May 2015 13:18:22 -0700
Message-ID: <CAF1ivSaMGtwg11p9K9D4H4W2=1OhP8vRfi9Bj6cpU1F9Miow5Q@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>
Subject: Re: [Drbd-dev] [PATCH v3 01/11] block: make generic_make_request
 handle arbitrarily sized bios
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

On Wed, May 20, 2015 at 11:58 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Ming Lin <mlin@kernel.org> writes:
>
>> On Mon, May 18, 2015 at 9:52 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>>> Ming Lin <mlin@kernel.org> writes:
>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index fd154b9..909f317 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -617,6 +617,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>>>>       if (q->id < 0)
>>>>               goto fail_q;
>>>>
>>>> +     q->bio_split = bioset_create(4, 0);
>>>> +     if (!q->bio_split)
>>>> +             goto fail_id;
>>>> +
>>>
>>> Arbitrary numbers should be documented.
>>
>> Kent,
>>
>> Is there specific reason to choose number 4?
>> If no, I may change it to BIO_POOL_SIZE which is 2.
>
> Here's what he had to say last time around:
>
>   On Mon, Nov 25, 2013 at 10:09:21PM -0800, Christoph Hellwig wrote:
>   > > +   q->bio_split = bioset_create(4, 0);
>   > > +   if (!q->bio_split)
>   > > +      goto fail_id;
>   >
>   > How did we arrive at a mempool size of 4 to make sure we can always make
>   > progress with arbitrarily sized bios?  Shouldn't we document the design
>   > decision somewhere?
>
>   It just has to be nonzero to guarantee forward progress - the

Then I'll update it to BIO_POOL_SIZE.

>   bio_alloc_bioset() rescuer thing I did awhile back guarantees that.
>
> link:  https://lkml.org/lkml/2013/11/26/47
>
> Cheers,
> Jeff
