Return-Path: <dongsu.park@profitbricks.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4C5541045C37
	for <drbd-dev@lists.linbit.com>; Tue, 23 Dec 2014 12:41:43 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id em10so10493089wid.11
	for <drbd-dev@lists.linbit.com>; Tue, 23 Dec 2014 03:41:43 -0800 (PST)
Date: Tue, 23 Dec 2014 12:41:40 +0100
From: Dongsu Park <dongsu.park@profitbricks.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20141223114140.GB15080@gmail.com>
References: <cover.1419241597.git.dongsu.park@profitbricks.com>
	<d26a9a0fc9a7d1529c115785ee5935d5750782bd.1419241597.git.dongsu.park@profitbricks.com>
	<20141223101614.GA13138@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141223101614.GA13138@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nitin Gupta <ngupta@vflare.org>,
	Mike Snitzer <snitzer@redhat.com>, Ming Lin <mlin@minggr.net>,
	Minchan Kim <minchan@kernel.org>, Neil Brown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>, Ming Lei <ming.lei@canonical.com>,
	linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Oleg Drokin <oleg.drokin@intel.com>, Geoff Levand <geoff@infradead.org>,
	Kent Overstreet <kmo@daterainc.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <andreas.dilger@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 01/17] block: make generic_make_request
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

Hi Christoph,

On 23.12.2014 02:16, Christoph Hellwig wrote:
> > +void blk_queue_split(struct request_queue *q, struct bio **bio,
> > +		     struct bio_set *bs)
> > +{
> > +	struct bio *split;
> > +
> > +	if ((*bio)->bi_rw & REQ_DISCARD)
> > +		split = blk_bio_discard_split(q, *bio, bs);
> > +	else if ((*bio)->bi_rw & REQ_WRITE_SAME)
> > +		split = blk_bio_write_same_split(q, *bio, bs);
> > +	else
> > +		split = blk_bio_segment_split(q, *bio, q->bio_split);
> > +
> > +	if (split) {
> > +		bio_chain(split, *bio);
> > +		generic_make_request(*bio);
> > +		*bio = split;
> > +	}
> > +}
> > +EXPORT_SYMBOL(blk_queue_split);
> 
> I think blk_queue_split needs to explicitly skip BLOCK_PC bios.  Those
> are SCSI pass through ioctls that we can't split due to their opaque
> nature.

You mean, checking rq->cmd_type == REQ_TYPE_BLOCK_PC, right?

I'm wondering about how to check that in blk_queue_split().
At the moment when blk_queue_split() is called, it's even before a request
is mapped e.g. in blk_sq_make_request().
Unlike scsi drivers where it's easy to get cmd->rq, blk_queue_split()
doesn't seem to be able to get a request by blk_get_request().

Or am I missing something?

Thanks,
Dongsu
