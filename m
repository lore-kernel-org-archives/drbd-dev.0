Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3A1F04202E9
	for <drbd-dev@lists.linbit.com>; Wed,  3 May 2023 13:06:59 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
	5b1f17b1804b1-3f4000ec71dso1972555e9.2
	for <drbd-dev@lists.linbit.com>; Wed, 03 May 2023 04:06:59 -0700 (PDT)
Message-ID: <b1568ca5-4daf-f6b5-7861-4881aa46e578@linbit.com>
Date: Wed, 3 May 2023 13:05:57 +0200
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
References: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
	<ZFHgefWofVt24tRl@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <ZFHgefWofVt24tRl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Thomas Voegtle <tv@lio96.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: do not set REQ_PREFLUSH when
	submitting barrier
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

Am 03.05.23 um 06:18 schrieb Christoph Hellwig:
> On Tue, May 02, 2023 at 11:29:22AM +0200, Christoph Böhmwalder wrote:
>>  	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
>> -				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
>> +				    REQ_OP_FLUSH, GFP_NOIO);
> 
> This isn't going to work.  flush bios are (somewhat confusingly)

Indeed...

> implemented as writes with no data and the preflush flag.  So this
> should be:
> 
> 	REQ_OP_WRITE | REQ_PREFLUSH.
> 
> and it looks like whatever flushing this does hasn't wroked for a long
> time.

Thanks for the hint. I'll prepare a v2 today.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
