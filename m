Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 64780101AC7B
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 20:20:24 +0100 (CET)
Received: by mail-io1-f54.google.com with SMTP id j18-v6so3198785iog.6
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 11:20:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Message-ID: <3999c98e-e477-c7d0-0a7f-a65d69f3e4e1@kernel.dk>
Date: Thu, 15 Nov 2018 12:20:19 -0700
MIME-Version: 1.0
In-Reply-To: <6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
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

On 11/15/18 12:14 PM, Jens Axboe wrote:
> On 11/14/18 9:02 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series removes another bunch of legacy request leftovers,
>> including the pointer indirection for the queue_lock.
> 
> Applied, with the subname part removed as mentioned in #13.

Your patch #16 missed a few spots, I fixed it up. JFYI.

-- 
Jens Axboe

