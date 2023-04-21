Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3FE054252B9
	for <drbd-dev@lists.linbit.com>; Sat, 22 Apr 2023 00:25:01 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
	d9443c01a7336-1a7111e0696so5461755ad.1
	for <drbd-dev@lists.linbit.com>; Fri, 21 Apr 2023 15:25:01 -0700 (PDT)
Message-ID: <47688c1d-9cf1-3e08-1f1d-a051b25d010e@kernel.dk>
Date: Fri, 21 Apr 2023 16:24:57 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
	<20230421195807.2804512-4-mcgrof@kernel.org>
	<ZELuiBNNHTk4EdxH@casper.infradead.org>
	<ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	da.gomez@samsung.com, djwong@kernel.org, snitzer@kernel.org,
	philipp.reisner@linbit.com, kbusch@kernel.org,
	patches@lists.linux.dev, hch@infradead.org, dm-devel@redhat.com,
	hare@suse.de, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-xfs@vger.kernel.org,
	senozhatsky@chromium.org, linux-mm@kvack.org, agk@redhat.com,
	drbd-dev@lists.linbit.com
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

On 4/21/23 4:02 PM, Luis Chamberlain wrote:
> On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
>> On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
>>> Just use the PAGE_SECTORS generic define. This produces no functional
>>> changes. While at it use left shift to simplify this even further.
>>
>> How is FOO << 2 simpler than FOO * 4?
>>
>>> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>> +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,
> 
> We could just do:
> 
> 
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
> 
> The shift just seemed optimal if we're just going to change it.

It's going to generate the same code, but the multiplication is arguably
easier to read (or harder to misread).

-- 
Jens Axboe


