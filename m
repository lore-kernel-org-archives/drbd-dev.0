Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 293ED1056312
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 21:49:18 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Date: Mon, 25 Apr 2016 14:49:11 -0500
Message-ID: <4163185.CbU2BaktXH@phil-dell-xps.local>
In-Reply-To: <571E667E.4080200@sandisk.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<2101862.7IMGIqiMZK@phil-dell-xps.local>
	<571E667E.4080200@sandisk.com>
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

Am Montag, 25. April 2016, 11:48:30 schrieb Bart Van Assche:
> On 04/25/2016 09:42 AM, Philipp Reisner wrote:
> > Am Montag, 25. April 2016, 08:35:26 schrieb Bart Van Assche:
> >> On 04/25/2016 05:10 AM, Philipp Reisner wrote:
> >>> As long as the value is 0 the feature is disabled. With setting
> >>> it to a positive value, DRBD limits and aligns its resync requests
> >>> to the rs-discard-granularity setting. If the sync source detects
> >>> all zeros in such a block, the resync target discards the range
> >>> on disk.
> >> 
> >> Can you explain why rs-discard-granularity is configurable instead of
> >> e.g. setting it to the least common multiple of the discard
> >> granularities of the underlying block devices at both sides?
> > 
> > we had this idea as well. It seems that real world devices like larger
> > discards better than smaller discards. The other motivation was that
> > a device mapper logical volume might change it on the fly...
> > So we think it is best to delegate the decision on the discard chunk
> > size to user space.
> 
> Hello Phil,
> 
> Are you aware that for aligned discard requests the discard granularity
> does not affect the size of discard requests at all?
> 
> Regarding LVM volumes: if the discard granularity for such volumes can
> change on the fly, shouldn't I/O be quiesced by the LVM kernel driver
> before it changes the discard granularity? I think that increasing
> discard granularity while I/O is in progress should be considered as a bug.
> 
> Bart.

Hi Bart,

I worked on this about 6 month ago, sorry for not having all the details
at the top of my head immediately. I think it came back now:
We need to announce the discard granularity when we create the device/minor.
At might it might be that there is no connection to the peer node. So we
are left with information about the discard granularity of the local
backing device only.
Therefore we decided to delegate it to the user/admin to provide the
discard granularity for the resync process.

best regards,
 phil 
