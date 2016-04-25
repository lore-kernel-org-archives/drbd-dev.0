Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0068.outbound.protection.outlook.com [65.55.169.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B54891056442
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 18:37:35 +0200 (CEST)
To: Philipp Reisner <philipp.reisner@linbit.com>, Jens Axboe <axboe@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<1461586077-11581-12-git-send-email-philipp.reisner@linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <571E47C8.5010805@sandisk.com>
Date: Mon, 25 Apr 2016 09:37:28 -0700
MIME-Version: 1.0
In-Reply-To: <1461586077-11581-12-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 11/30] drbd: when receiving P_TRIM,
 zero-out partial unaligned chunks
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

On 04/25/2016 05:13 AM, Philipp Reisner wrote:
> +	while (nr_sectors >= granularity) {
> +		nr = min_t(sector_t, nr_sectors, max_discard_sectors);
> +		err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
> +		nr_sectors -= nr;
> +		start += nr;
> +	}

Hello Phil,

In blk_bio_discard_split() the following statement protects against 
block drivers for which max_discard_sectors is not a multiple of the 
discard granularity:

	max_discard_sectors -= max_discard_sectors % granularity;

Do we need something similar in the above loop?

To Jens: should the drbd_issue_discard_or_zero_out() function go 
upstream or should rather what this function does be integrated in 
blkdev_issue_zeroout() as is done by the patch series "[PATCH v2 0/6] 
Make blkdev_issue_discard() submit aligned discard requests" 
(http://thread.gmane.org/gmane.linux.kernel.device-mapper.devel/23801)?

Thanks,

Bart.

