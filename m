Return-Path: <axboe@kernel.dk>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 754EB101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 16:26:29 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id 144-v6so21206163iti.5
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 07:26:29 -0700 (PDT)
To: Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<20180521140348.GA19069@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <686d7df6-c7d1-48a6-b7ff-48dc8aff6a62@kernel.dk>
Date: Mon, 21 May 2018 08:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180521140348.GA19069@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: hch@infradead.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com,
	linux-kernel@vger.kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, clm@fb.com, neilb@suse.com,
	bacik@fb.com, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
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

On 5/21/18 8:03 AM, Mike Snitzer wrote:
> On Sun, May 20 2018 at  6:25pm -0400,
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>> Jens - this series does the rest of the conversions that Christoph wanted, and
>> drops bioset_create().
>>
>> Only lightly tested, but the changes are pretty mechanical. Based on your
>> for-next tree.
> 
> By switching 'mempool_t *' to 'mempool_t' and 'bio_set *' to 'bio_set'
> you've altered the alignment of members in data structures.  So I'll
> need to audit all the data structures you've modified in DM.
> 
> Could we get the backstory on _why_ you're making this change?
> Would go a long way to helping me appreciate why this is a good use of
> anyone's time.

Yeah, it's in the first series, it gets rid of a pointer indirection.

-- 
Jens Axboe

