Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
	[209.85.166.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F21D5101AC7B
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 20:20:49 +0100 (CET)
Received: by mail-io1-f47.google.com with SMTP id w7so7595492iom.12
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 11:20:49 -0800 (PST)
To: Christoph Hellwig <hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Date: Thu, 15 Nov 2018 12:14:27 -0700
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove more legacy request leftover
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

On 11/14/18 9:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes another bunch of legacy request leftovers,
> including the pointer indirection for the queue_lock.

Applied, with the subname part removed as mentioned in #13.

> Note that we have very few queue_lock users left, I wonder if
> we should get rid of it entirely and have separate locks for
> the cgroup and I/O scheduler code, which are the only heavy
> users?

Probably not worth it...

-- 
Jens Axboe

