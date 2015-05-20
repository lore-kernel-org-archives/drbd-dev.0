Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
	<x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
Date: Wed, 20 May 2015 11:30:10 -0700
Message-ID: <CAF1ivSbdbvnCi04oR9h4sqnMcLFNXfOo-8=_2qFVkzNYmnmELQ@mail.gmail.com>
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

On Mon, May 18, 2015 at 9:52 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Ming Lin <mlin@kernel.org> writes:
>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fd154b9..909f317 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -617,6 +617,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>>       if (q->id < 0)
>>               goto fail_q;
>>
>> +     q->bio_split = bioset_create(4, 0);
>> +     if (!q->bio_split)
>> +             goto fail_id;
>> +
>
> Arbitrary numbers should be documented.

Kent,

Is there specific reason to choose number 4?
If no, I may change it to BIO_POOL_SIZE which is 2.

Thanks.
