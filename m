Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150526143626.GA4315@redhat.com>
References: <1432318723-18829-1-git-send-email-mlin@kernel.org>
	<1432318723-18829-2-git-send-email-mlin@kernel.org>
	<20150526143626.GA4315@redhat.com>
Date: Tue, 26 May 2015 08:02:08 -0700
Message-ID: <CAF1ivSb3ptYObS3_8bJwWhq98EcNgAgRhN_L-c3uyFfCzdn=9A@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Neil Brown <neilb@suse.de>, Ming Lei <ming.lei@canonical.com>,
	dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>,
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
Subject: Re: [Drbd-dev] [PATCH v4 01/11] block: make generic_make_request
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

On Tue, May 26, 2015 at 7:36 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Fri, May 22 2015 at  2:18pm -0400,
> Ming Lin <mlin@kernel.org> wrote:
>
>> From: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> The way the block layer is currently written, it goes to great lengths
>> to avoid having to split bios; upper layer code (such as bio_add_page())
>> checks what the underlying device can handle and tries to always create
>> bios that don't need to be split.
>>
>> But this approach becomes unwieldy and eventually breaks down with
>> stacked devices and devices with dynamic limits, and it adds a lot of
>> complexity. If the block layer could split bios as needed, we could
>> eliminate a lot of complexity elsewhere - particularly in stacked
>> drivers. Code that creates bios can then create whatever size bios are
>> convenient, and more importantly stacked drivers don't have to deal with
>> both their own bio size limitations and the limitations of the
>> (potentially multiple) devices underneath them.  In the future this will
>> let us delete merge_bvec_fn and a bunch of other code.
>
> This series doesn't take any steps to train upper layers
> (e.g. filesystems) to size their bios larger (which is defined as
> "whatever size bios are convenient" above).
>
> bio_add_page(), and merge_bvec_fn, served as the means for upper layers
> (and direct IO) to build up optimally sized bios.  Without a replacement
> (that I can see anyway) how is this patchset making forward progress
> (getting Acks, etc)!?
>
> I like the idea of reduced complexity associated with these late bio
> splitting changes I'm just not seeing how this is ready given there are
> no upper layer changes that speak to building larger bios..
>
> What am I missing?

See: [PATCH v4 02/11] block: simplify bio_add_page()
https://lkml.org/lkml/2015/5/22/754

Now bio_add_page() can build lager bios.
And blk_queue_split() can split the bios in ->make_request() if needed.

Thanks.

>
> Please advise, thanks!
> Mike
