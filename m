Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
	<x49twv9kevg.fsf@segfault.boston.devel.redhat.com>
Date: Fri, 22 May 2015 10:49:06 -0700
Message-ID: <CAF1ivSZt1q0QiezakjYT9xPbj-fAuEv-1ZSVrX5Qu9Tg0T2x+A@mail.gmail.com>
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
>
>> +static struct bio *blk_bio_segment_split(struct request_queue *q,
>> +                                      struct bio *bio,
>> +                                      struct bio_set *bs)
>> +{
>
> Funny name for a function that also merges segments.  ;-)  I admit I am

I'm trying to understand ... but I didn't see it also merges segments.

> at a loss for coming up with a better name that won't overflow 80
> columns.
>
> Other than that, this looks sane.
>
> Cheers,
> Jeff
