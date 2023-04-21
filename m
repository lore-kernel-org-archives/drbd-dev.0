Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CB4EC4252C1
	for <drbd-dev@lists.linbit.com>; Sat, 22 Apr 2023 00:36:19 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
	98e67ed59e1d1-2497d8066c9so497171a91.0
	for <drbd-dev@lists.linbit.com>; Fri, 21 Apr 2023 15:36:19 -0700 (PDT)
Message-ID: <e032f210-f8cc-6441-2481-3c5341f8e72f@kernel.dk>
Date: Fri, 21 Apr 2023 16:36:13 -0600
MIME-Version: 1.0
To: Luis Chamberlain <mcgrof@kernel.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
	<20230421195807.2804512-4-mcgrof@kernel.org>
	<ZELuiBNNHTk4EdxH@casper.infradead.org>
	<ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
	<47688c1d-9cf1-3e08-1f1d-a051b25d010e@kernel.dk>
	<ZEMOeb9Bt60jxV+d@bombadil.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZEMOeb9Bt60jxV+d@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: djwong@kernel.org, philipp.reisner@linbit.com, linux-mm@kvack.org,
	dm-devel@redhat.com, agk@redhat.com, drbd-dev@lists.linbit.com,
	Matthew Wilcox <willy@infradead.org>, hch@infradead.org,
	p.raghav@samsung.com, senozhatsky@chromium.org,
	snitzer@kernel.org, linux-block@vger.kernel.org, hare@suse.de,
	kbusch@kernel.org, da.gomez@samsung.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	minchan@kernel.org, patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/5] iomap: simplify iomap_init() with
	PAGE_SECTORS
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 4/21/23 4:30?PM, Luis Chamberlain wrote:
> On Fri, Apr 21, 2023 at 04:24:57PM -0600, Jens Axboe wrote:
>> On 4/21/23 4:02?PM, Luis Chamberlain wrote:
>>> On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
>>>> On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
>>>>> Just use the PAGE_SECTORS generic define. This produces no functional
>>>>> changes. While at it use left shift to simplify this even further.
>>>>
>>>> How is FOO << 2 simpler than FOO * 4?
>>>>
>>>>> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>>>> +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,
>>>
>>> We could just do:
>>>
>>>
>>> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>> +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
>>>
>>> The shift just seemed optimal if we're just going to change it.
>>
>> It's going to generate the same code, but the multiplication is arguably
>> easier to read (or harder to misread).
> 
> Then let's stick with the 4 * PAGE_SECTORS. Let me know if you need another
> patch.

Just send out a v2 at some point, you've also got a number of cases
where there are superfluous parenthesis, at least in patch 4, and Willy
pointed one out in an earlier patch too. Didn't check the last one.

This will be 6.5 anyway I think, I already sent out the changes for the
6.4 merge window.

-- 
Jens Axboe

