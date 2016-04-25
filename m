Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 713F31056442
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 18:42:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Date: Mon, 25 Apr 2016 11:21:17 -0500
Message-ID: <2101862.7IMGIqiMZK@phil-dell-xps.local>
In-Reply-To: <571E393E.1010003@sandisk.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<1461586077-11581-6-git-send-email-philipp.reisner@linbit.com>
	<571E393E.1010003@sandisk.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Axboe <axboe@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 05/30] drbd: Introduce new disk config option
	rs-discard-granularity
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

Am Montag, 25. April 2016, 08:35:26 schrieb Bart Van Assche:
> On 04/25/2016 05:10 AM, Philipp Reisner wrote:
> > As long as the value is 0 the feature is disabled. With setting
> > it to a positive value, DRBD limits and aligns its resync requests
> > to the rs-discard-granularity setting. If the sync source detects
> > all zeros in such a block, the resync target discards the range
> > on disk.
> 
> Hello Phil,
> 
> Can you explain why rs-discard-granularity is configurable instead of
> e.g. setting it to the least common multiple of the discard
> granularities of the underlying block devices at both sides?
> 
> Thanks,
> 

Hi Bart,

we had this idea as well. It seems that real world devices like larger
discards better than smaller discards. The other motivation was that
a device mapper logical volume might change it on the fly...
So we think it is best to delegate the decision on the discard chunk
size to user space.

best regards,
 Phil
	
