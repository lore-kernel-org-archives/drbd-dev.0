Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 792881055734
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 408722A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:05 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OHI6J05RE1W8 for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 219383D84CB
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:05 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LYvuupzLohrE for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EA7882A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:04 +0200 (CEST)
Resent-Message-ID: <20150527085804.GC18767@soda.linbit>
From: Jeff Moyer <jmoyer@redhat.com>
To: Ming Lin <mlin@kernel.org>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
	<x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
	<CAF1ivSbdbvnCi04oR9h4sqnMcLFNXfOo-8=_2qFVkzNYmnmELQ@mail.gmail.com>
Date: Wed, 20 May 2015 14:58:41 -0400
In-Reply-To: <CAF1ivSbdbvnCi04oR9h4sqnMcLFNXfOo-8=_2qFVkzNYmnmELQ@mail.gmail.com>
	(Ming Lin's message of "Wed, 20 May 2015 11:30:10 -0700")
Message-ID: <x49k2w3oz32.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
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

Ming Lin <mlin@kernel.org> writes:

> On Mon, May 18, 2015 at 9:52 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Ming Lin <mlin@kernel.org> writes:
>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index fd154b9..909f317 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -617,6 +617,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>>>       if (q->id < 0)
>>>               goto fail_q;
>>>
>>> +     q->bio_split = bioset_create(4, 0);
>>> +     if (!q->bio_split)
>>> +             goto fail_id;
>>> +
>>
>> Arbitrary numbers should be documented.
>
> Kent,
>
> Is there specific reason to choose number 4?
> If no, I may change it to BIO_POOL_SIZE which is 2.

Here's what he had to say last time around:

  On Mon, Nov 25, 2013 at 10:09:21PM -0800, Christoph Hellwig wrote:
  > > +   q->bio_split = bioset_create(4, 0);
  > > +   if (!q->bio_split)
  > > +      goto fail_id;
  > 
  > How did we arrive at a mempool size of 4 to make sure we can always make
  > progress with arbitrarily sized bios?  Shouldn't we document the design
  > decision somewhere?

  It just has to be nonzero to guarantee forward progress - the
  bio_alloc_bioset() rescuer thing I did awhile back guarantees that.

link:  https://lkml.org/lkml/2013/11/26/47

Cheers,
Jeff
