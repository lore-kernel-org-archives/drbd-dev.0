Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F3EF3162EE8
	for <drbd-dev@lists.linbit.com>; Thu, 12 Feb 2026 16:01:45 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
	ffacd0b85a97d-43284ed32a0so5562424f8f.3
	for <drbd-dev@lists.linbit.com>; Thu, 12 Feb 2026 07:01:45 -0800 (PST)
Message-ID: <eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
Date: Thu, 12 Feb 2026 16:01:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
To: Christoph Hellwig <hch@infradead.org>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
	<aYWNhtixUGuj3hat@infradead.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <aYWNhtixUGuj3hat@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

Am 06.02.26 um 07:43 schrieb Christoph Hellwig:
> On Thu, Feb 05, 2026 at 06:39:29PM +0100, Christoph Böhmwalder wrote:
>> DRBD requires stable pages because it may read the same bio data
>> multiple times for local disk I/O and network transmission, and in
>> some cases for calculating checksums.
>>
>> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
>> created, but blk_set_stacking_limits() clears it whenever a
>> backing device is attached. In some cases the flag may be
>> inherited from the backing device, but we want it to be enabled
>> at all times.
> 
> This looks like a bug.  If an underlying device requires
> BLK_FEAT_STABLE_WRITES, the upper device needs to inherit it.

The current block layer logic actually seems correct to me. The
underlying device may or may not require stable writes, but regardless
of that, DRBD itself definitely does need it. In blk_stack_limits, DRBD
is the top device, and DRBD's backing disk is the bottom device. If the
backing disk happens to require stable writes, this would indeed be
correctly inherited.

So the only missing logic is that DRBD still wants to enable stable
writes for itself even if the backing disk does *not* request it.
So it seems to me that this patch is the correct fix for DRBD's special
case.

Is it not supposed to work like that?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

