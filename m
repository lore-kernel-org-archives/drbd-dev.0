Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AEBC81018D73
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 10:11:18 +0100 (CET)
Date: Thu, 15 Nov 2018 10:04:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20181115090435.GA14370@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<20181114160219.28328-5-hch@lst.de>
	<ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 04/16] block: use atomic bitops for
	->queue_flags
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

On Thu, Nov 15, 2018 at 07:55:02AM +0100, Hannes Reinecke wrote:
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-core.c       | 54 ++++++----------------------------------
>>   block/blk-mq.c         |  2 +-
>>   block/blk-settings.c   | 10 +++-----
>>   block/blk-sysfs.c      | 28 +++++++++------------
>>   block/blk.h            | 56 ------------------------------------------
>>   include/linux/blkdev.h |  1 -
>>   6 files changed, 24 insertions(+), 127 deletions(-)
>>
> I wonder if we can't remove the 'blk_queue_flag_XXX' helpers and replace 
> them with inlines ...

I'd prefer to just open code the *bit helpers as that is a lot more
reasonable.  But that is quite a lot of churn, so I'll only do that if
I get previous buy-in to that idea, and preferably in a separate series.
